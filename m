Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6897952275A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 01:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237711AbiEJXEz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 19:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiEJXEy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 19:04:54 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 072442734DA;
        Tue, 10 May 2022 16:04:53 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 44A9110E68F9;
        Wed, 11 May 2022 09:04:49 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1noYuN-00AT9W-Ck; Wed, 11 May 2022 09:04:47 +1000
Date:   Wed, 11 May 2022 09:04:47 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Karel Zak <kzak@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [RFC PATCH] getting misc stats/attributes via xattr API
Message-ID: <20220510230447.GC2306852@dread.disaster.area>
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com>
 <20220509124815.vb7d2xj5idhb2wq6@wittgenstein>
 <20220510005533.GA2306852@dread.disaster.area>
 <87bkw5d098.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkw5d098.fsf@oldenburg.str.redhat.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=627aef94
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=7-415B0cAAAA:8
        a=DeMPlFUAyss6Xeq_UakA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 10, 2022 at 02:45:39PM +0200, Florian Weimer wrote:
> * Dave Chinner:
> 
> > IOWs, what Linux really needs is a listxattr2() syscall that works
> > the same way that getdents/XFS_IOC_ATTRLIST_BY_HANDLE work. With the
> > list function returning value sizes and being able to iterate
> > effectively, every problem that listxattr() causes goes away.
> 
> getdents has issues of its own because it's unspecified what happens if
> the list of entries is modified during iteration.  Few file systems add
> another tree just to guarantee stable iteration.

The filesystem I care about (XFS) guarantees stable iteration and
stable seekdir/telldir cookies. It's not that hard to do, but it
requires the filesystem designer to understand that this is a
necessary feature before they start designing the on-disk directory
format and lookup algorithms....

> Maybe that's different for xattrs because they are supposed to be small
> and can just be snapshotted with a full copy?

It's different for xattrs because we directly control the API
specification for XFS_IOC_ATTRLIST_BY_HANDLE, not POSIX. We can
define the behaviour however we want. Stable iteration is what
listing keys needs.

The cursor is defined as 16 bytes of opaque data, enabling us to
encoded exactly where in the hashed name btree index we have
traversed to:

/*
 * Kernel-internal version of the attrlist cursor.
 */
struct xfs_attrlist_cursor_kern {
        __u32   hashval;        /* hash value of next entry to add */
        __u32   blkno;          /* block containing entry (suggestion) */
        __u32   offset;         /* offset in list of equal-hashvals */
        __u16   pad1;           /* padding to match user-level */
        __u8    pad2;           /* padding to match user-level */
        __u8    initted;        /* T/F: cursor has been initialized */
};

Hence we have all the information in the cursor we need to reset the
btree traversal index to the exact entry we finished at (even in the
presence of hash collisions in the index). Hence removal of the
entry the cursor points to isn't a problem for us, we just move to
the next highest sequential hash index in the btree and start again
from there.

Of course, if this is how we define listxattr2() behaviour (or maybe
we should call it "list_keys()" to make it clear we are treating
this as a key/value store instead of xattrs) then each filesystem
can put what it needs in that cursor to guarantee it can restart key
iteration correctly if the entry the cursor points to has been
removed.  We can also make the cursor larger if necessary for other
filesystems to store the information they need.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
