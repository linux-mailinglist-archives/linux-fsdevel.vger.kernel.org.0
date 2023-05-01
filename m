Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02A96F2BEE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 04:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjEACG0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Apr 2023 22:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjEACGY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Apr 2023 22:06:24 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223FFE52
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Apr 2023 19:06:23 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63b70ca0a84so2446647b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Apr 2023 19:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1682906782; x=1685498782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=znM2E4gIVmPbqaHKPAok5KWXVI4I8gH5qEPvg831RO0=;
        b=OGCvREmjyIoVoTOo+kZudb2tWoe+QIpJ28NIXPFfOaeI4x2OA3P5MK9cDDxS+5SNhg
         P3snzcZ8fFuqvvvyfVlgQAZ4o6IhZ+su+4VV+DlD8PZ3hzVuxnlV13bEUerZ0HmZOGJr
         GI19Jgmgwa4DDPGE1ckHgyxfBGoQdz2eqnYDjWsrfG70cYypoFEbmCRqWhpF0TsoH23Z
         hfwGAYBmbLP/zvjwhp4oVkK9vIpytsjQgbTGH0YeC1xmJcGA1HZfFO4kDTzxW41LEQ7C
         ohgKXQyh1LcSrGPYt7yy387wEdlod/DVUqKxTToZ0Ht+NV0dDQOOSJa0jqyYN+NfZw5a
         VVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682906782; x=1685498782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znM2E4gIVmPbqaHKPAok5KWXVI4I8gH5qEPvg831RO0=;
        b=a66jlRZd3c5bHakQxrawMfy0Zg/rcT72DM4Wqi+oySlvMeJVA1/D3nuQAGv0Q1m4rm
         Ea4Sc/PvEEjXtTYQnkTZtOjmaEC4ePkL5N6FvHwjHtZTULvjRiHM0/LUsx72JSOikGTV
         lwZiqNRkQxrHe1tHiaifqWsn06ZtxhEVBzkfijX+2f1TDeikOHFOCVVDqwVmKHMmTdHo
         /lUkoYxNcIbPRCvx2PWn1yUbfz2ZwSNhsq/H2EFh3oR3wAFYswn56H9iTkscl1GcMNHJ
         HNLg0uqZzzTL9OD3pN6Ioof4wIlu/CIgvy0T0lJVyA/NVLH/mmv6LJFLaQntF5GtARPY
         4zPQ==
X-Gm-Message-State: AC+VfDwaMAk6slNQUr+pGJnqxNgPssFNVventwHdMg4V9pZ2Q+a0mnwv
        A/Fy6LeGyPoobiJN7muSeyyh+w==
X-Google-Smtp-Source: ACHHUZ769BNFg/pkbOm+IJp8cuzfUYEw5n0Bk4fMRkxMz6MabsohUyKRBjisP2jC95bYKmM2HDcPSQ==
X-Received: by 2002:a05:6a00:b84:b0:63d:3a18:4a03 with SMTP id g4-20020a056a000b8400b0063d3a184a03mr18408589pfj.5.1682906782544;
        Sun, 30 Apr 2023 19:06:22 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id 2-20020a621802000000b0063d24d5f9b6sm18938752pfy.210.2023.04.30.19.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 19:06:22 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ptIvh-009t8e-GL; Mon, 01 May 2023 12:06:17 +1000
Date:   Mon, 1 May 2023 12:06:17 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ming Lei <ming.lei@redhat.com>, Baokun Li <libaokun1@huawei.com>,
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
Message-ID: <20230501020617.GD2155823@dread.disaster.area>
References: <ZEn/KB0fZj8S1NTK@ovpn-8-24.pek2.redhat.com>
 <dbb8d8a7-3a80-34cc-5033-18d25e545ed1@huawei.com>
 <ZEpH+GEj33aUGoAD@ovpn-8-26.pek2.redhat.com>
 <663b10eb-4b61-c445-c07c-90c99f629c74@huawei.com>
 <ZEpcCOCNDhdMHQyY@ovpn-8-26.pek2.redhat.com>
 <ZEskO8md8FjFqQhv@ovpn-8-24.pek2.redhat.com>
 <fb127775-bbe4-eb50-4b9d-45a8e0e26ae7@huawei.com>
 <ZEtd6qZOgRxYnNq9@mit.edu>
 <ZEyL/sjVeW88XpIn@ovpn-8-24.pek2.redhat.com>
 <ZEyjY0W+8zafPAoh@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEyjY0W+8zafPAoh@mit.edu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 29, 2023 at 12:56:03AM -0400, Theodore Ts'o wrote:
> On Sat, Apr 29, 2023 at 11:16:14AM +0800, Ming Lei wrote:
> > 
> > bdi_unregister() is called in del_gendisk(), since bdi_register() has
> > to be called in add_disk() where major/minor is figured out.
> > 
> > > problem is that the block device shouldn't just *vanish*, with the
> > 
> > That looks not realistic, removable disk can be gone any time, and device
> > driver error handler often deletes disk as the last straw, and it shouldn't
> > be hard to observe such error.
> 
> It's not realistic to think that the file system can write back any
> dirty pages, sure.  At this point, the user has already yanked out the
> thumb drive, and the physical device is gone.  However, various fields
> like bdi->dev shouldn't get deinitialized until after the
> s_ops->shutdown() function has returned.
> 
> We need to give the file system a chance to shutdown any pending
> writebacks; otherwise, we could be racing with writeback happening in
> some other kernel thread, and while the I/O is certainly not going to
> suceed, it would be nice if attempts to write to the block device
> return an error, intead potentially causing the kernel to crash.
> 
> The shutdown function might need to sleep while it waits for
> workqueues or kernel threads to exit, or while it iterates over all
> inodes and clears all of the dirty bits and/or drop all of the pages
> associated with the file system on the disconnected block device.  So
> while this happens, I/O should just fail, and not result in a kernel
> BUG or oops.
> 
> Once the s_ops->shutdown() has returned, then del_gendisk can shutdown
> and/or deallocate anything it wants, and if the file system tries to
> use the bdi after s_ops->shutdown() has returned, well, it deserves
> anything it gets.
> 
> (Well, it would be nice if things didn't bug/oops in fs/buffer.c if
> there is no s_ops->shutdown() function, since there are a lot of
> legacy file systems that use the buffer cache and until we can add
> some kind of generic shutdown function to fs/libfs.c and make sure
> that all of the legacy file systems that are likely to be used on a
> USB thumb drive are fixed, it would be nice if they were protected.
> At the very least, we should make that things are no worse than they
> currently are.)
> 
>        	    	 	       	     	  - Ted
> 
> P.S.  Note that the semantics I've described here for
> s_ops->shutdown() are slightly different than what the FS_IOC_SHUTDOWN
> ioctl currently does.  For example, after FS_IOC_SHUTDOWN, writes to
> files will fail, but read to already open files will succeed.  I know
> this because the original ext4 shutdown implementation did actually
> prevent reads from going through, but we got objections from those
> that wanted ext4's FS_IOC_SHUTDOWN to work the same way as xfs's.

<blink>

Wot?

The current XFS read IO path does this as it's first check:

STATIC ssize_t
xfs_file_read_iter(
        struct kiocb            *iocb,
        struct iov_iter         *to)
{
        struct inode            *inode = file_inode(iocb->ki_filp);
        struct xfs_mount        *mp = XFS_I(inode)->i_mount;
        ssize_t                 ret = 0;

        XFS_STATS_INC(mp, xs_read_calls);

        if (xfs_is_shutdown(mp))
                return -EIO;
....

It's been this way since .... 1997 on Irix when forced shutdowns
were introduced with this commit:

commit a96958f0891133f2731094b455465e88c03a13fb
Author: Supriya Wickrematillake <sup@sgi.com>
Date:   Sat Jan 25 02:55:04 1997 +0000

    First cut of XFS I/O error handling changes.

So, yeah, XFS *always* errors out user read IO after a shutdown.

/me wonders what ext4 does


static ssize_t ext4_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
{
        struct inode *inode = file_inode(iocb->ki_filp);

        if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
                return -EIO;

Huh. It does the same thing as XFS. I now have no idea what
you are talking about now, Ted.

Ah:

https://lore.kernel.org/linux-ext4/20170203022224.idwexzwnqmbyskbj@thunk.org/

You explicitly mention readpage/readpages, which was the page
fault IO path (address space ops, not file ops). These days we have
xfs_vm_read_folio(), which goes through iomap, which then asks the
filesystem to map the folio to the underlying storage for IO, which
then calls xfs_read_iomap_begin(), and that does:

static int
xfs_read_iomap_begin(
        struct inode            *inode,
        loff_t                  offset,
        loff_t                  length,
        unsigned                flags,
        struct iomap            *iomap,
        struct iomap            *srcmap)
{
        struct xfs_inode        *ip = XFS_I(inode);
        struct xfs_mount        *mp = ip->i_mount;
        struct xfs_bmbt_irec    imap;
        xfs_fileoff_t           offset_fsb = XFS_B_TO_FSBT(mp, offset);
        xfs_fileoff_t           end_fsb = xfs_iomap_end_fsb(mp, offset, length);
        int                     nimaps = 1, error = 0;
        bool                    shared = false;
        unsigned int            lockmode = XFS_ILOCK_SHARED;
        u64                     seq;

        ASSERT(!(flags & (IOMAP_WRITE | IOMAP_ZERO)));

        if (xfs_is_shutdown(mp))
                return -EIO;

.... a shutdown check as it's first operation.

I'm pretty sure that this has always been the case - for reading
pages/folios through page faults, we've always errored those out in
the block mapping callback function, not in the high level VFS
interfacing functions. Yeah, looking at the old page based path
from 2008:


STATIC int
xfs_vm_readpage(
        struct file             *unused,
        struct page             *page)
{
        return mpage_readpage(page, xfs_get_blocks);
}

Call chain:

mpage_readpage
  xfs_get_blocks
    __xfs_get_blocks
      xfs_iomap

int
xfs_iomap(
....
{
        xfs_mount_t     *mp = ip->i_mount;
....
        int             iomap_flags = 0;

        ASSERT((ip->i_d.di_mode & S_IFMT) == S_IFREG);

        if (XFS_FORCED_SHUTDOWN(mp))
                return XFS_ERROR(EIO);

Yup, there's the shutdown check way back in the 2008 code base for
the pagefault IO path. IOWs, we've always errored out any attempt to
do IO via page faults after a shutdown, too.

The XFS ->page_mkwrite() path also does a shutdown check as it's
first operation, which leaves just read faults through filemap_fault
as skipping the shutdown check.

Yeah, so if the page is uptodate in the page cache, the fault still
succeeds. This was left in place so that root filesystems might
still be able to execute a system shutdown after the root filesystem
was shut down. Sometimes it works, sometimes it doesn't, but it
doesn't hurt anything to let read page faults for cached data to
succeed after a shutdown...

That's trivial to change - just add a shutdown check before calling
filemap_fault(). I just don't see a need to change that for XFS, and
I don't care one way or another if other filesystems do something
different here, either, as long as they don't issue read IO to the
underlying device....

> So we have an out of tree patch for ext4's FS_IOC_SHUTDOWN
> implementation in our kernels at $WORK, because we were using it when
> we knew that the back-end server providing the iSCSI or remote block
> had died, and we wanted to make sure our borg (think Kubernetes) jobs
> would fast fail when they tried reading from the dead file system, as
> opposed to failing only after some timeout had elapsed.

Well, yeah. That's pretty much why XFS has failed all physical I/O
attempts (read or write) after a shutdown for the past 25 years.
Shutdowns on root filesystems are a bit nasty, though, because if
you don't allow cached executables to run, the whole system dies
instantly with no warning or ability to safely shutdown applications
at all.

> To avoid confusion, we should probably either use a different name
> than s_ops->shutdown(), or add a new mode to FS_IOC_SHUTDOWN which
> corresponds to "the block device is gone, shut *everything* down:
> reads, writes, everything.

Yup, that's pretty much what we already do for a shutdown, so I'm
not sure what you are advocating for, Ted. If you add the shutdown
check to the filemap_fault() path then even that last little "allow
cached executables to still run on a shutdown root fs" helper goes
away and then you have what you want...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
