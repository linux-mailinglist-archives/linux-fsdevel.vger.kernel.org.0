Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AEE4E69D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Mar 2022 21:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353412AbiCXUdH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Mar 2022 16:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353411AbiCXUc5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Mar 2022 16:32:57 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DD2FB6E70;
        Thu, 24 Mar 2022 13:31:23 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-150-27.pa.vic.optusnet.com.au [49.186.150.27])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 2ABDA533EAB;
        Fri, 25 Mar 2022 07:31:18 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nXU72-009RUP-Ov; Fri, 25 Mar 2022 07:31:16 +1100
Date:   Fri, 25 Mar 2022 07:31:16 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [RFC PATCH] getvalues(2) prototype
Message-ID: <20220324203116.GJ1609613@dread.disaster.area>
References: <20220322192712.709170-1-mszeredi@redhat.com>
 <20220323225843.GI1609613@dread.disaster.area>
 <CAJfpegv6PmZ_RXipBs9UEjv_WfEUtTDE1uNZq+9fBkCzWPvXkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegv6PmZ_RXipBs9UEjv_WfEUtTDE1uNZq+9fBkCzWPvXkw@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=623cd519
        a=sPqof0Mm7fxWrhYUF33ZaQ==:117 a=sPqof0Mm7fxWrhYUF33ZaQ==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=7-415B0cAAAA:8 a=GumQ9EM2AAAA:8
        a=PLAR8crxhtdwIOoicKgA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 24, 2022 at 09:57:26AM +0100, Miklos Szeredi wrote:
> On Wed, 23 Mar 2022 at 23:58, Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Tue, Mar 22, 2022 at 08:27:12PM +0100, Miklos Szeredi wrote:
> 
> > > - Interfaces for getting various attributes and statistics are fragmented.
> > >   For files we have basic stat, statx, extended attributes, file attributes
> > >   (for which there are two overlapping ioctl interfaces).  For mounts and
> > >   superblocks we have stat*fs as well as /proc/$PID/{mountinfo,mountstats}.
> > >   The latter also has the problem on not allowing queries on a specific
> > >   mount.
> >
> > https://xkcd.com/927/
> 
> Haha!
> 
> > I've said in the past when discussing things like statx() that maybe
> > everything should be addressable via the xattr namespace and
> > set/queried via xattr names regardless of how the filesystem stores
> > the data. The VFS/filesystem simply translates the name to the
> > storage location of the information. It might be held in xattrs, but
> > it could just be a flag bit in an inode field.
> 
> Right, that would definitely make sense for inode attributes.
> 
> What about other objects' attributes, statistics?   Remember this
> started out as a way to replace /proc/self/mountinfo with something
> that can query individual mount.

For individual mount info, why do we even need to query something in
/proc? I mean, every open file in the mount has access to the mount
and the underlying superblock, so why not just make the query
namespace accessable from any open fd on that mount?

e.g. /proc/self/mountinfo tells you where the mounts are, then you
can just open(O_PATH) the mount point you want the info from and
retrieve the relevant xattrs from that fd. The information itself
does not need to be in /proc, nor only accessible from /proc, nor be
limited to proc infrastructure, nor be constrained by proc's
arbitrary "one value per file" presentation....

Indeed, we don't have to centralise all the information in one place
- all we need is to have a well defined, consistent method for
indexing that information and all the shenanigans for accessing
common stuff can be wrapped up in a common userspace library
(similar to how iterating the mount table is generic C library
functionality).

> > > mnt                    - list of mount parameters
> > > mnt:mountpoint         - the mountpoint of the mount of $ORIGIN
> > > mntns                  - list of mount ID's reachable from the current root
> > > mntns:21:parentid      - parent ID of the mount with ID of 21
> > > xattr:security.selinux - the security.selinux extended attribute
> > > data:foo/bar           - the data contained in file $ORIGIN/foo/bar
> >
> > How are these different from just declaring new xattr namespaces for
> > these things. e.g. open any file and list the xattrs in the
> > xattr:mount.mnt namespace to get the list of mount parameters for
> > that mount.
> 
> Okay.
> 
> > Why do we need a new "xattr in everything but name" interface when
> > we could just extend the one we've already got and formalise a new,
> > cleaner version of xattr batch APIs that have been around for 20-odd
> > years already?
> 
> Seems to make sense. But...will listxattr list everyting recursively?
> I guess that won't work, better just list traditional xattrs,
> otherwise we'll likely get regressions,

*nod*

> and anyway the point of a
> hierarchical namespace is to be able to list nodes on each level.  We
> can use getxattr() for this purpose, just like getvalues() does in the
> above example.

Yup, and like Casey suggests, you could implement a generic
getvalues()-like user library on top of it so users don't even need
to know where and how the values are located or retrieved.

The other advantage of an xattr interface is that is also provides a
symmetrical API for -changing- values. No need for some special
configfs or configfd thingy for setting parameters - just change the
value of the parameter or mount option with a simple setxattr call.
That retains the simplicity of proc and sysfs attributes in that you
can change them just by writing a new value to the file....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
