Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321AC4E5B9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 23:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345352AbiCWXAY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 19:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbiCWXAW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 19:00:22 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED1FC90256;
        Wed, 23 Mar 2022 15:58:49 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-150-27.pa.vic.optusnet.com.au [49.186.150.27])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 72EA3533E65;
        Thu, 24 Mar 2022 09:58:45 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nX9wB-0095L5-JH; Thu, 24 Mar 2022 09:58:43 +1100
Date:   Thu, 24 Mar 2022 09:58:43 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [RFC PATCH] getvalues(2) prototype
Message-ID: <20220323225843.GI1609613@dread.disaster.area>
References: <20220322192712.709170-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322192712.709170-1-mszeredi@redhat.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=623ba628
        a=sPqof0Mm7fxWrhYUF33ZaQ==:117 a=sPqof0Mm7fxWrhYUF33ZaQ==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=GumQ9EM2AAAA:8 a=7-415B0cAAAA:8
        a=63ntfpr2ZaCgDPseocQA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 22, 2022 at 08:27:12PM +0100, Miklos Szeredi wrote:
> Add a new userspace API that allows getting multiple short values in a
> single syscall.
> 
> This would be useful for the following reasons:
> 
> - Calling open/read/close for many small files is inefficient.  E.g. on my
>   desktop invoking lsof(1) results in ~60k open + read + close calls under
>   /proc and 90% of those are 128 bytes or less.

How does doing the open/read/close in a single syscall make this any
more efficient? All it saves is the overhead of a couple of
syscalls, it doesn't reduce any of the setup or teardown overhead
needed to read the data itself....

> - Interfaces for getting various attributes and statistics are fragmented.
>   For files we have basic stat, statx, extended attributes, file attributes
>   (for which there are two overlapping ioctl interfaces).  For mounts and
>   superblocks we have stat*fs as well as /proc/$PID/{mountinfo,mountstats}.
>   The latter also has the problem on not allowing queries on a specific
>   mount.

https://xkcd.com/927/

> - Some attributes are cheap to generate, some are expensive.  Allowing
>   userspace to select which ones it needs should allow optimizing queries.
> 
> - Adding an ascii namespace should allow easy extension and self
>   description.
> 
> - The values can be text or binary, whichever is fits best.
> 
> The interface definition is:
> 
> struct name_val {
> 	const char *name;	/* in */
> 	struct iovec value_in;	/* in */
> 	struct iovec value_out;	/* out */
> 	uint32_t error;		/* out */
> 	uint32_t reserved;
> };

Ahhh, XFS_IOC_ATTRMULTI_BY_HANDLE reborn. This is how xfsdump gets
and sets attributes efficiently when dumping and restoring files -
it's an interface that allows batches of xattr operations to be run
on a file in a single syscall.

I've said in the past when discussing things like statx() that maybe
everything should be addressable via the xattr namespace and
set/queried via xattr names regardless of how the filesystem stores
the data. The VFS/filesystem simply translates the name to the
storage location of the information. It might be held in xattrs, but
it could just be a flag bit in an inode field.

Then we just get named xattrs in batches from an open fd.

> int getvalues(int dfd, const char *path, struct name_val *vec, size_t num,
> 	      unsigned int flags);
> 
> @dfd and @path are used to lookup object $ORIGIN.  @vec contains @num
> name/value descriptors.  @flags contains lookup flags for @path.
> 
> The syscall returns the number of values filled or an error.
> 
> A single name/value descriptor has the following fields:
> 
> @name describes the object whose value is to be returned.  E.g.
> 
> mnt                    - list of mount parameters
> mnt:mountpoint         - the mountpoint of the mount of $ORIGIN
> mntns                  - list of mount ID's reachable from the current root
> mntns:21:parentid      - parent ID of the mount with ID of 21
> xattr:security.selinux - the security.selinux extended attribute
> data:foo/bar           - the data contained in file $ORIGIN/foo/bar

How are these different from just declaring new xattr namespaces for
these things. e.g. open any file and list the xattrs in the
xattr:mount.mnt namespace to get the list of mount parameters for
that mount.

Why do we need a new "xattr in everything but name" interface when
we could just extend the one we've already got and formalise a new,
cleaner version of xattr batch APIs that have been around for 20-odd
years already?

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
