Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9671A435C8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 10:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhJUIF1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 04:05:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37380 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhJUIF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:05:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 458501FDA2;
        Thu, 21 Oct 2021 08:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634803388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+pm/NZLEuV5BEzdZJ9xSVzcAyFs8p5nXmzxCLPlAfyI=;
        b=RI+cS14EpigLQbiToyCM9aR23GCi18cOA1ZFxJY5dHoKWY6B+DyNUWv8SKvxx8pZ8vbTGv
        qv25XK5M7wBnnK6T1XPQNT4iUGKdhsRncdYyi1RPyLqxS7QhBpEKjh4dO1dSOoYZpvjaIa
        Or6IRIU3/ue1ljwgHCYEvYOtsV6Tpi4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634803388;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+pm/NZLEuV5BEzdZJ9xSVzcAyFs8p5nXmzxCLPlAfyI=;
        b=xVvf2bQnUPOKG+957FxH6NuPHIoNLrGq+ZnDMfVe7GI4e0/zjcXs5QQNBbXTSOCTdB8mfQ
        In2o3sjIF5b4NMBA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 93F0FA3C73;
        Thu, 21 Oct 2021 08:03:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DB2CD1E0BFB; Thu, 21 Oct 2021 10:03:04 +0200 (CEST)
Date:   Thu, 21 Oct 2021 10:03:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhengyuan Liu <liuzhengyuang521@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org,
        =?utf-8?B?5YiY5LqR?= <liuyun01@kylinos.cn>,
        Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Subject: Re: Problem with direct IO
Message-ID: <20211021080304.GB5784@quack2.suse.cz>
References: <CAOOPZo52azGXN-BzWamA38Gu=EkqZScLufM1VEgDuosPoH6TWA@mail.gmail.com>
 <20211020173729.GF16460@quack2.suse.cz>
 <CAOOPZo43cwh5ujm3n-r9Bih=7gS7Oav0B=J_8AepWDgdeBRkYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOOPZo43cwh5ujm3n-r9Bih=7gS7Oav0B=J_8AepWDgdeBRkYA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 21-10-21 10:21:55, Zhengyuan Liu wrote:
> On Thu, Oct 21, 2021 at 1:37 AM Jan Kara <jack@suse.cz> wrote:
> > On Wed 13-10-21 09:46:46, Zhengyuan Liu wrote:
> > > we are encounting following Mysql crash problem while importing tables :
> > >
> > >     2021-09-26T11:22:17.825250Z 0 [ERROR] [MY-013622] [InnoDB] [FATAL]
> > >     fsync() returned EIO, aborting.
> > >     2021-09-26T11:22:17.825315Z 0 [ERROR] [MY-013183] [InnoDB]
> > >     Assertion failure: ut0ut.cc:555 thread 281472996733168
> > >
> > > At the same time , we found dmesg had following message:
> > >
> > >     [ 4328.838972] Page cache invalidation failure on direct I/O.
> > >     Possible data corruption due to collision with buffered I/O!
> > >     [ 4328.850234] File: /data/mysql/data/sysbench/sbtest53.ibd PID:
> > >     625 Comm: kworker/42:1
> > >
> > > Firstly, we doubled Mysql has operating the file with direct IO and
> > > buffered IO interlaced, but after some checking we found it did only
> > > do direct IO using aio. The problem is exactly from direct-io
> > > interface (__generic_file_write_iter) itself.
> > >
> > > ssize_t __generic_file_write_iter()
> > > {
> > > ...
> > >         if (iocb->ki_flags & IOCB_DIRECT) {
> > >                 loff_t pos, endbyte;
> > >
> > >                 written = generic_file_direct_write(iocb, from);
> > >                 /*
> > >                  * If the write stopped short of completing, fall back to
> > >                  * buffered writes.  Some filesystems do this for writes to
> > >                  * holes, for example.  For DAX files, a buffered write will
> > >                  * not succeed (even if it did, DAX does not handle dirty
> > >                  * page-cache pages correctly).
> > >                  */
> > >                 if (written < 0 || !iov_iter_count(from) || IS_DAX(inode))
> > >                         goto out;
> > >
> > >                 status = generic_perform_write(file, from, pos = iocb->ki_pos);
> > > ...
> > > }
> > >
> > > From above code snippet we can see that direct io could fall back to
> > > buffered IO under certain conditions, so even Mysql only did direct IO
> > > it could interleave with buffered IO when fall back occurred. I have
> > > no idea why FS(ext3) failed the direct IO currently, but it is strange
> > > __generic_file_write_iter make direct IO fall back to buffered IO, it
> > > seems  breaking the semantics of direct IO.
> > >
> > > The reproduced  environment is:
> > > Platform:  Kunpeng 920 (arm64)
> > > Kernel: V5.15-rc
> > > PAGESIZE: 64K
> > > Mysql:  V8.0
> > > Innodb_page_size: default(16K)
> >
> > Thanks for report. I agree this should not happen. How hard is this to
> > reproduce? Any idea whether the fallback to buffered IO happens because
> > iomap_dio_rw() returns -ENOTBLK or because it returns short write?
> 
> It is easy to reproduce in my test environment, as I said in the previous
> email replied to Andrew this problem is related to kernel page size.

Ok, can you share a reproducer?

> > Can you post output of "dumpe2fs -h <device>" for the filesystem where the
> > problem happens? Thanks!
> 
> Sure, the output is:
> 
> # dumpe2fs -h /dev/sda3
> dumpe2fs 1.45.3 (14-Jul-2019)
> Filesystem volume name:   <none>
> Last mounted on:          /data
> Filesystem UUID:          09a51146-b325-48bb-be63-c9df539a90a1
> Filesystem magic number:  0xEF53
> Filesystem revision #:    1 (dynamic)
> Filesystem features:      has_journal ext_attr resize_inode dir_index
> filetype needs_recovery sparse_super large_file

Thanks for the data. OK, a filesystem without extents. Does your test by
any chance try to do direct IO to a hole in a file? Because that is not
(and never was) supported without extents. Also the fact that you don't see
the problem with ext4 (which means extents support) would be pointing in
that direction.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
