Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BCE2ED711
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 20:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbhAGTAi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 14:00:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27885 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728674AbhAGTAh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 14:00:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610045951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Xi2LsUJTfR3F6Kw+mgZKWaNP6g+KrERh5YVstyYnNc=;
        b=J9VzF6R+YaSFFTPioXNcCAlMOTRNXUZDbZ0ZhuadJu2okrsth5D+QeNOWtvH0mQ4MGlIFN
        SQ2PGsyAti0tL39ahyiCGj6ytf9kCmcr8AzUifiGYRa6RQIUt62wazl+D1K+30oj1q1Rgz
        /xYwkRcOB1cAFEvDCewC5WHeyY/ZNcM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-1dVGJka0OZeA2-GkdfYnAA-1; Thu, 07 Jan 2021 13:59:06 -0500
X-MC-Unique: 1dVGJka0OZeA2-GkdfYnAA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7143D107ACF5;
        Thu,  7 Jan 2021 18:59:04 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0613C19630;
        Thu,  7 Jan 2021 18:59:03 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 107Ix3eV025400;
        Thu, 7 Jan 2021 13:59:03 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 107Ix18i025339;
        Thu, 7 Jan 2021 13:59:02 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 7 Jan 2021 13:59:01 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Matthew Wilcox <willy@infradead.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Wang Jianchao <jianchao.wan9@gmail.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "Norton, Scott J" <scott.norton@hpe.com>,
        "Tadakamadla, Rajesh" <rajesh.tadakamadla@hpe.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Subject: Re: Expense of read_iter
In-Reply-To: <20210107151125.GB5270@casper.infradead.org>
Message-ID: <alpine.LRH.2.02.2101071110080.30654@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com> <20210107151125.GB5270@casper.infradead.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Thu, 7 Jan 2021, Matthew Wilcox wrote:

> On Thu, Jan 07, 2021 at 08:15:41AM -0500, Mikulas Patocka wrote:
> > I'd like to ask about this piece of code in __kernel_read:
> > 	if (unlikely(!file->f_op->read_iter || file->f_op->read))
> > 		return warn_unsupported...
> > and __kernel_write:
> > 	if (unlikely(!file->f_op->write_iter || file->f_op->write))
> > 		return warn_unsupported...
> > 
> > - It exits with an error if both read_iter and read or write_iter and 
> > write are present.
> > 
> > I found out that on NVFS, reading a file with the read method has 10% 
> > better performance than the read_iter method. The benchmark just reads the 
> > same 4k page over and over again - and the cost of creating and parsing 
> > the kiocb and iov_iter structures is just that high.
> 
> Which part of it is so expensive?

The read_iter path is much bigger:
vfs_read		- 0x160 bytes
new_sync_read		- 0x160 bytes
nvfs_rw_iter		- 0x100 bytes
nvfs_rw_iter_locked	- 0x4a0 bytes
iov_iter_advance	- 0x300 bytes

If we go with the "read" method, there's just:
vfs_read		- 0x160 bytes
nvfs_read		- 0x200 bytes

> Is it worth, eg adding an iov_iter
> type that points to a single buffer instead of a single-member iov?
> 
> +++ b/include/linux/uio.h
> @@ -19,6 +19,7 @@ struct kvec {
>  
>  enum iter_type {
>         /* iter types */
> +       ITER_UBUF = 2,
>         ITER_IOVEC = 4,
>         ITER_KVEC = 8,
>         ITER_BVEC = 16,
> @@ -36,6 +36,7 @@ struct iov_iter {
>         size_t iov_offset;
>         size_t count;
>         union {
> +               void __user *buf;
>                 const struct iovec *iov;
>                 const struct kvec *kvec;
>                 const struct bio_vec *bvec;
> 
> and then doing all the appropriate changes to make that work.


I tried this benchmark on nvfs:

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(void)
{
	unsigned long i;
	unsigned long l = 1UL << 38;
	unsigned s = 4096;
	void *a = valloc(s);
	if (!a) perror("malloc"), exit(1);
	for (i = 0; i < l; i += s) {
		if (pread(0, a, s, 0) != s) perror("read"), exit(1);
	}
	return 0;
}


Result, using the read_iter method:

# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 3K of event 'cycles'
# Event count (approx.): 1049885560
#
# Overhead  Command  Shared Object     Symbol                               
# ........  .......  ................  .....................................
#
    47.32%  pread    [kernel.vmlinux]  [k] copy_user_generic_string
     7.83%  pread    [kernel.vmlinux]  [k] current_time
     6.57%  pread    [nvfs]            [k] nvfs_rw_iter_locked
     5.59%  pread    [kernel.vmlinux]  [k] entry_SYSCALL_64
     4.23%  pread    libc-2.31.so      [.] __libc_pread
     3.51%  pread    [kernel.vmlinux]  [k] syscall_return_via_sysret
     2.34%  pread    [kernel.vmlinux]  [k] entry_SYSCALL_64_after_hwframe
     2.34%  pread    [kernel.vmlinux]  [k] vfs_read
     2.34%  pread    [kernel.vmlinux]  [k] __fsnotify_parent
     2.31%  pread    [kernel.vmlinux]  [k] new_sync_read
     2.21%  pread    [nvfs]            [k] nvfs_bmap
     1.89%  pread    [kernel.vmlinux]  [k] iov_iter_advance
     1.71%  pread    [kernel.vmlinux]  [k] __x64_sys_pread64
     1.59%  pread    [kernel.vmlinux]  [k] atime_needs_update
     1.24%  pread    [nvfs]            [k] nvfs_rw_iter
     0.94%  pread    [kernel.vmlinux]  [k] touch_atime
     0.75%  pread    [kernel.vmlinux]  [k] syscall_enter_from_user_mode
     0.72%  pread    [kernel.vmlinux]  [k] ktime_get_coarse_real_ts64
     0.68%  pread    [kernel.vmlinux]  [k] down_read
     0.62%  pread    [kernel.vmlinux]  [k] exit_to_user_mode_prepare
     0.52%  pread    [kernel.vmlinux]  [k] syscall_exit_to_user_mode
     0.49%  pread    [kernel.vmlinux]  [k] syscall_exit_to_user_mode_prepare
     0.47%  pread    [kernel.vmlinux]  [k] __fget_light
     0.46%  pread    [kernel.vmlinux]  [k] do_syscall_64
     0.42%  pread    pread             [.] main
     0.33%  pread    [kernel.vmlinux]  [k] up_read
     0.29%  pread    [kernel.vmlinux]  [k] iov_iter_init
     0.16%  pread    [kernel.vmlinux]  [k] __fdget
     0.10%  pread    [kernel.vmlinux]  [k] entry_SYSCALL_64_safe_stack
     0.03%  pread    pread             [.] pread@plt
     0.00%  perf     [kernel.vmlinux]  [k] x86_pmu_enable_all


#
# (Tip: Use --symfs <dir> if your symbol files are in non-standard locations)
#



Result, using the read method:

# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 3K of event 'cycles'
# Event count (approx.): 1312158116
#
# Overhead  Command  Shared Object     Symbol                               
# ........  .......  ................  .....................................
#
    60.77%  pread    [kernel.vmlinux]  [k] copy_user_generic_string
     6.14%  pread    [kernel.vmlinux]  [k] current_time
     3.88%  pread    [kernel.vmlinux]  [k] entry_SYSCALL_64
     3.55%  pread    libc-2.31.so      [.] __libc_pread
     3.04%  pread    [nvfs]            [k] nvfs_bmap
     2.84%  pread    [kernel.vmlinux]  [k] syscall_return_via_sysret
     2.71%  pread    [nvfs]            [k] nvfs_read
     2.56%  pread    [kernel.vmlinux]  [k] entry_SYSCALL_64_after_hwframe
     2.00%  pread    [kernel.vmlinux]  [k] __x64_sys_pread64
     1.98%  pread    [kernel.vmlinux]  [k] __fsnotify_parent
     1.77%  pread    [kernel.vmlinux]  [k] vfs_read
     1.35%  pread    [kernel.vmlinux]  [k] atime_needs_update
     0.94%  pread    [kernel.vmlinux]  [k] exit_to_user_mode_prepare
     0.91%  pread    [kernel.vmlinux]  [k] __fget_light
     0.83%  pread    [kernel.vmlinux]  [k] syscall_enter_from_user_mode
     0.70%  pread    [kernel.vmlinux]  [k] down_read
     0.70%  pread    [kernel.vmlinux]  [k] touch_atime
     0.65%  pread    [kernel.vmlinux]  [k] ktime_get_coarse_real_ts64
     0.55%  pread    [kernel.vmlinux]  [k] syscall_exit_to_user_mode
     0.49%  pread    [kernel.vmlinux]  [k] up_read
     0.44%  pread    [kernel.vmlinux]  [k] do_syscall_64
     0.39%  pread    [kernel.vmlinux]  [k] syscall_exit_to_user_mode_prepare
     0.34%  pread    pread             [.] main
     0.26%  pread    [kernel.vmlinux]  [k] __fdget
     0.10%  pread    pread             [.] pread@plt
     0.10%  pread    [kernel.vmlinux]  [k] entry_SYSCALL_64_safe_stack
     0.00%  perf     [kernel.vmlinux]  [k] x86_pmu_enable_all


#
# (Tip: To set sample time separation other than 100ms with --sort time use --time-quantum)
#


Note that if we sum the percentage of nvfs_iter_locked, new_sync_read, 
iov_iter_advance, nvfs_rw_iter, we get 12.01%. On the other hand, in the 
second trace, nvfs_read consumes just 2.71% - and it replaces 
functionality of all these functions.

That is the reason for that 10% degradation with read_iter.

Mikulas

