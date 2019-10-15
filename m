Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7D3ED6D30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 04:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfJOCUk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Oct 2019 22:20:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35523 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfJOCUj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Oct 2019 22:20:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id 205so11454747pfw.2;
        Mon, 14 Oct 2019 19:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8H4x/0PzSc+cFgDx1YZ5+BsoHRjAf/XAcn/2vvNKiII=;
        b=dltxS1i19yhHH709eXXysC7QrJFjh2Ra7frwS53c0XKyRv95OMf9qIQd+7bqlNHGoJ
         x+DF9gvatAOdsY6Vz414vk54AyAU2eQ0TD5eNQ4hWJYvBwo9Mal8FUWnXkoie8e2JxVb
         MIkOVxxE9jhdAGZsbUXCIqnloynfoEuSOeWr43Rr2qE4TeaxWVrkYYCcySX5x058AC/C
         BIdgJnOJ/plwzzw4OBia4mLfcA6oZt+B5FtinPCw5tkXEBb3P8xBVQwmkrEfuvioc5P4
         paqo9h8erqF+ZMX5z2IUJpVCEVkmlQFC2VXoZHAP71gIvejmGAE1+SGFpX0i9Hlfd24d
         RvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8H4x/0PzSc+cFgDx1YZ5+BsoHRjAf/XAcn/2vvNKiII=;
        b=MW1r49OXPwZivgC3ozns9xAW1rsUhjkKVgPp1wPrOfPQ3wZ3kyAkhobQes/mounXjf
         pdFp6uF6OEAw4P1SZNNul3O7paRKySlAY2JkAO880LMRjfYsw5p8i9c7c/CufPR7PcLi
         3eYrJhHve23TkrKOGD0OlY8qJx1f7pU6X1KdskowToRz+st0xfpnAVtInG+OqhnMeZDr
         QHi7NlfyztBENpD328hyozDfUBnOuYgH2/E4/w9XthI4uLXZeLiDPBAEwjjXQL15A6lI
         88iYrkJ8V5YhihwJXhTqjrksZEKk+zsItooH7j3k1IwEg6L0+1UQ3wMw6oLGuEE8wee6
         2JlQ==
X-Gm-Message-State: APjAAAWd5vfxRrRLSrsRxhq48J0FC4cVPH3Txh1p9bunPfEyDyCmTHl2
        yLwvsMmpgeje0cQfH+ekxsbwuUw=
X-Google-Smtp-Source: APXvYqzOXpShh56uDCVPgANcyM3B+A2AAhIkbDujovTmxMJALaZxxy0iXsrKcX4LEPjKigJevZPUYw==
X-Received: by 2002:a17:90a:c094:: with SMTP id o20mr39731453pjs.37.1571106037499;
        Mon, 14 Oct 2019 19:20:37 -0700 (PDT)
Received: from mypc ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m5sm18914736pgt.15.2019.10.14.19.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 19:20:36 -0700 (PDT)
Date:   Tue, 15 Oct 2019 10:20:26 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Eric Sandeen <sandeen@sandeen.net>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>, Jan Kara <jack@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] xfs: introduce "metasync" api to sync metadata to fsblock
Message-ID: <20191015022026.GC14327@mypc>
References: <1570977420-3944-1-git-send-email-kernelfans@gmail.com>
 <20191013163417.GQ13108@magnolia>
 <20191014083315.GA10091@mypc>
 <20191014094311.GD5939@quack2.suse.cz>
 <d3ffa114-8b73-90dc-8ba6-3f44f47135d7@sandeen.net>
 <20191014200303.GF5939@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014200303.GF5939@quack2.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 14, 2019 at 10:03:03PM +0200, Jan Kara wrote:
> On Mon 14-10-19 08:23:39, Eric Sandeen wrote:
> > On 10/14/19 4:43 AM, Jan Kara wrote:
> > > On Mon 14-10-19 16:33:15, Pingfan Liu wrote:
> > > > On Sun, Oct 13, 2019 at 09:34:17AM -0700, Darrick J. Wong wrote:
> > > > > On Sun, Oct 13, 2019 at 10:37:00PM +0800, Pingfan Liu wrote:
> > > > > > When using fadump (fireware assist dump) mode on powerpc, a mismatch
> > > > > > between grub xfs driver and kernel xfs driver has been obsevered.  Note:
> > > > > > fadump boots up in the following sequence: fireware -> grub reads kernel
> > > > > > and initramfs -> kernel boots.
> > > > > > 
> > > > > > The process to reproduce this mismatch:
> > > > > >    - On powerpc, boot kernel with fadump=on and edit /etc/kdump.conf.
> > > > > >    - Replacing "path /var/crash" with "path /var/crashnew", then, "kdumpctl
> > > > > >      restart" to rebuild the initramfs. Detail about the rebuilding looks
> > > > > >      like: mkdumprd /boot/initramfs-`uname -r`.img.tmp;
> > > > > >            mv /boot/initramfs-`uname -r`.img.tmp /boot/initramfs-`uname -r`.img
> > > > > >            sync
> > > > > >    - "echo c >/proc/sysrq-trigger".
> > > > > > 
> > > > > > The result:
> > > > > > The dump image will not be saved under /var/crashnew/* as expected, but
> > > > > > still saved under /var/crash.
> > > > > > 
> > > > > > The root cause:
> > > > > > As Eric pointed out that on xfs, 'sync' ensures the consistency by writing
> > > > > > back metadata to xlog, but not necessary to fsblock. This raises issue if
> > > > > > grub can not replay the xlog before accessing the xfs files. Since the
> > > > > > above dir entry of initramfs should be saved as inline data with xfs_inode,
> > > > > > so xfs_fs_sync_fs() does not guarantee it written to fsblock.
> > > > > > 
> > > > > > umount can be used to write metadata fsblock, but the filesystem can not be
> > > > > > umounted if still in use.
> > > > > > 
> > > > > > There are two ways to fix this mismatch, either grub or xfs. It may be
> > > > > > easier to do this in xfs side by introducing an interface to flush metadata
> > > > > > to fsblock explicitly.
> > > > > > 
> > > > > > With this patch, metadata can be written to fsblock by:
> > > > > >    # update AIL
> > > > > >    sync
> > > > > >    # new introduced interface to flush metadata to fsblock
> > > > > >    mount -o remount,metasync mountpoint
> > > > > 
> > > > > I think this ought to be an ioctl or some sort of generic call since the
> > > > > jbd2 filesystems (ext3, ext4, ocfs2) suffer from the same "$BOOTLOADER
> > > > > is too dumb to recover logs but still wants to write to the fs"
> > > > > checkpointing problem.
> > > > Yes, a syscall sounds more reasonable.
> > > > > 
> > > > > (Or maybe we should just put all that stuff in a vfat filesystem, I
> > > > > don't know...)
> > > > I think it is unavoidable to involve in each fs' implementation. What
> > > > about introducing an interface sync_to_fsblock(struct super_block *sb) in
> > > > the struct super_operations, then let each fs manage its own case?
> > > 
> > > Well, we already have a way to achieve what you need: fsfreeze.
> > > Traditionally, that is guaranteed to put fs into a "clean" state very much
> > > equivalent to the fs being unmounted and that seems to be what the
> > > bootloader wants so that it can access the filesystem without worrying
> > > about some recovery details. So do you see any problem with replacing
> > > 'sync' in your example above with 'fsfreeze /boot && fsfreeze -u /boot'?
> > > 
> > > 								Honza
> > 
> > The problem with fsfreeze is that if the device you want to quiesce is, say,
> > the root fs, freeze isn't really a good option.
> 
> I agree you need to be really careful not to deadlock against yourself in
> that case. But this particular use actually has a chance to work.
> 
Yeah, normally there is a /boot partition in system, and if so, fsfreeze
can work.
> > But the other thing I want to highlight about this approach is that it does not
> > solve the root problem: something is trying to read the block device without
> > first replaying the log.
> > 
> > A call such as the proposal here is only going to leave consistent metadata at
> > the time the call returns; at any time after that, all guarantees are off again,
> > so the problem hasn't been solved.
> 
> Oh, absolutely agreed. I was also thinking about this before sending my
> reply. Once you unfreeze, the log can start filling with changes and
> there's no guarantee that e.g. inode does not move as part of these
But just as fsync, we only guarantee the consistency before a sync. If
the involved files change again, we need another sync.
> changes. But to be fair, replaying the log isn't easy either, even more so
> from a bootloader. You cannot write the changes from the log back into the
> filesystem as e.g. in case of suspend-to-disk the resumed kernel gets
> surprised and corrupts the fs under its hands (been there, tried that). So
> you must keep changes only in memory and that's not really easy in the
> constrained bootloader environment.
Sigh, this is more complicated than I had thought. I guess it will be a
long time to go with this bug, and use fsfreeze as a work around.

Thanks and regards,
	Pingfan
> 
> So I guess we are left with hacks that kind of mostly work and fsfreeze is
> one of those. If you don't mess with the files after fsfreeze, you're
> likely to find what you need even without replaying the log.
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
