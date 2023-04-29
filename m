Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EDF6F2300
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Apr 2023 06:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjD2E5A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Apr 2023 00:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjD2E46 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Apr 2023 00:56:58 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E35268A
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 21:56:57 -0700 (PDT)
Received: from letrec.thunk.org ([76.150.80.181])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33T4u4S9019981
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Apr 2023 00:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682744169; bh=MxVIng8Evj++Z1u5M0nsXwrWqthOdSqW0ypNnEpPCFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=HKk5nO+qnFlDZChkGokPzHeb6mvY0qy3p1ZzgVpxcrxibP21L3LwhzN0L4jDw90kI
         rI2LnVSA2rc3SkGUKXHZ6OzPX6WV1VJS0OZg3JnOFp5IeCr0s025WZVc3r5bjKXis6
         fbaz12JodlwTmZUq4iSXHcD57Z2JCIE9BsY7PENAuTwFrBUIHtO9NwOHAyhCrhpntL
         nMZ8yuB5zX0TXXgUNOObAmZkfmIOxsb4sZGE0z6ceafd4F3pgog1qX0LFSKzHmxHYz
         SEg5X9BmJM4q+abjxF8q/WSE6mfkZRqwheEM41Q2by7xwJRV10PKJDXCxcNgu0psiz
         zz2t9GLTgjh1Q==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id EF0678C01B4; Sat, 29 Apr 2023 00:56:03 -0400 (EDT)
Date:   Sat, 29 Apr 2023 00:56:03 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Baokun Li <libaokun1@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Zhang Yi <yi.zhang@redhat.com>,
        yangerkun <yangerkun@huawei.com>
Subject: Re: [ext4 io hang] buffered write io hang in balance_dirty_pages
Message-ID: <ZEyjY0W+8zafPAoh@mit.edu>
References: <ZEny7Izr8iOc/23B@casper.infradead.org>
 <ZEn/KB0fZj8S1NTK@ovpn-8-24.pek2.redhat.com>
 <dbb8d8a7-3a80-34cc-5033-18d25e545ed1@huawei.com>
 <ZEpH+GEj33aUGoAD@ovpn-8-26.pek2.redhat.com>
 <663b10eb-4b61-c445-c07c-90c99f629c74@huawei.com>
 <ZEpcCOCNDhdMHQyY@ovpn-8-26.pek2.redhat.com>
 <ZEskO8md8FjFqQhv@ovpn-8-24.pek2.redhat.com>
 <fb127775-bbe4-eb50-4b9d-45a8e0e26ae7@huawei.com>
 <ZEtd6qZOgRxYnNq9@mit.edu>
 <ZEyL/sjVeW88XpIn@ovpn-8-24.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEyL/sjVeW88XpIn@ovpn-8-24.pek2.redhat.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 29, 2023 at 11:16:14AM +0800, Ming Lei wrote:
> 
> bdi_unregister() is called in del_gendisk(), since bdi_register() has
> to be called in add_disk() where major/minor is figured out.
> 
> > problem is that the block device shouldn't just *vanish*, with the
> 
> That looks not realistic, removable disk can be gone any time, and device
> driver error handler often deletes disk as the last straw, and it shouldn't
> be hard to observe such error.

It's not realistic to think that the file system can write back any
dirty pages, sure.  At this point, the user has already yanked out the
thumb drive, and the physical device is gone.  However, various fields
like bdi->dev shouldn't get deinitialized until after the
s_ops->shutdown() function has returned.

We need to give the file system a chance to shutdown any pending
writebacks; otherwise, we could be racing with writeback happening in
some other kernel thread, and while the I/O is certainly not going to
suceed, it would be nice if attempts to write to the block device
return an error, intead potentially causing the kernel to crash.

The shutdown function might need to sleep while it waits for
workqueues or kernel threads to exit, or while it iterates over all
inodes and clears all of the dirty bits and/or drop all of the pages
associated with the file system on the disconnected block device.  So
while this happens, I/O should just fail, and not result in a kernel
BUG or oops.

Once the s_ops->shutdown() has returned, then del_gendisk can shutdown
and/or deallocate anything it wants, and if the file system tries to
use the bdi after s_ops->shutdown() has returned, well, it deserves
anything it gets.

(Well, it would be nice if things didn't bug/oops in fs/buffer.c if
there is no s_ops->shutdown() function, since there are a lot of
legacy file systems that use the buffer cache and until we can add
some kind of generic shutdown function to fs/libfs.c and make sure
that all of the legacy file systems that are likely to be used on a
USB thumb drive are fixed, it would be nice if they were protected.
At the very least, we should make that things are no worse than they
currently are.)

       	    	 	       	     	  - Ted

P.S.  Note that the semantics I've described here for
s_ops->shutdown() are slightly different than what the FS_IOC_SHUTDOWN
ioctl currently does.  For example, after FS_IOC_SHUTDOWN, writes to
files will fail, but read to already open files will succeed.  I know
this because the original ext4 shutdown implementation did actually
prevent reads from going through, but we got objections from those
that wanted ext4's FS_IOC_SHUTDOWN to work the same way as xfs's.

So we have an out of tree patch for ext4's FS_IOC_SHUTDOWN
implementation in our kernels at $WORK, because we were using it when
we knew that the back-end server providing the iSCSI or remote block
had died, and we wanted to make sure our borg (think Kubernetes) jobs
would fast fail when they tried reading from the dead file system, as
opposed to failing only after some timeout had elapsed.

To avoid confusion, we should probably either use a different name
than s_ops->shutdown(), or add a new mode to FS_IOC_SHUTDOWN which
corresponds to "the block device is gone, shut *everything* down:
reads, writes, everything."  My preference would be the latter, since
it would mean we could stop carrying that out-of-tree patch in our
data center kernels...
