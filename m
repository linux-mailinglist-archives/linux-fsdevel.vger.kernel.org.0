Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88ED5251CBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 17:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgHYPzC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 11:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgHYPzB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:55:01 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7525C061574;
        Tue, 25 Aug 2020 08:55:01 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id n128so12043577oif.0;
        Tue, 25 Aug 2020 08:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fH2KCQXfYf6S+KayEEUTdKvOgSQhpXD7JS/V1Xp3s54=;
        b=ZdU/VgfxpV55TPtW62URSbt5197eA3YwdfQJB8RSHqb0rhKtYFKFqiqPe3YWWmKjkq
         /T8cxAsZCJAfrofSLPYUw1BIrLdnjUJNoPR0Izm6FGAZBnByZRo2l4hesrlXY60cb9xN
         P6ZbIEAgIzW8j98yaXYdJHxPYy3CiU6s/rIUA7Y0nmOXBYEvW/2d/3xZeXz9+54NLTcm
         +t78gGKkI4nZDFyE0W4Ynwp2Exgygx48fq4XxcfUnwOAHTk88+kywhPv0Yr0KCadjVt3
         FDlrJpwyInXbsSbBluTo0loW+1HUNXwtL44C1yUMbkqAk+Ej8UD7crKf1iGr/rNXSJBB
         Fsgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fH2KCQXfYf6S+KayEEUTdKvOgSQhpXD7JS/V1Xp3s54=;
        b=DJnlcM4gWdxdoTS81BiE5SG4ctlcUvpNyeQpBuTYP4yzH2Issln+A7XVVNEZMqcmB2
         pARE8nkCPYZkNuKTJ2PGQDA1HQqlXxxfOu2K6uykyzr/6JKZ/bdJhUNwXKO3C5lYmYFY
         3ZbehVNQZRVJXEkTNl/wWRUsoAS6hDt1ePs60Ecebqo0+bGns9O1y2AmfdwQIj7FjtWj
         fV7Au7Msz4N6tK5rCAcw+BbvqQdo9abuyUFo8i2QHN2WA/FD3FHF4mcQXbRc5bj9PPqL
         6TObVm/yPZVTEjEP+c79gtYssJvljKtgMn16RvTLTyqLxXqEdif+pZ7muKUs5EMPcl4V
         JOgw==
X-Gm-Message-State: AOAM53246POYrIVEqafZCOboKyEjSbMlarbLqTY5Wpegadg3XnhKNBfA
        p7Fw6AsjiDUhd4tmDkC+o5li9tK4ovgBXc6AMc8=
X-Google-Smtp-Source: ABdhPJyCbHBHSERV4iULFx/eGLLYmQBYt2zIBFFUx3oCPn3P63KWCdDNSHhCZnHxFc2HHbZotoX8CtujxtzXth2NKn0=
X-Received: by 2002:aca:c508:: with SMTP id v8mr1334142oif.149.1598370901072;
 Tue, 25 Aug 2020 08:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200505183608.10280-1-yshuiv7@gmail.com> <20200505193049.GC5694@magnolia>
 <20200825123650.3AA34AE045@d06av26.portsmouth.uk.ibm.com>
In-Reply-To: <20200825123650.3AA34AE045@d06av26.portsmouth.uk.ibm.com>
From:   Yuxuan Shui <yshuiv7@gmail.com>
Date:   Tue, 25 Aug 2020 16:54:50 +0100
Message-ID: <CAGqt0zw92aOxA2edGcugqzzQJFbjuAOoDeFirKkx1EiRR9rUdQ@mail.gmail.com>
Subject: Re: [PATCH] iomap: iomap_bmap should accept unwritten maps
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch appears to be working on my machine as well.

On Tue, Aug 25, 2020 at 1:37 PM Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>
>
>
> On 5/6/20 1:00 AM, Darrick J. Wong wrote:
> > On Tue, May 05, 2020 at 07:36:08PM +0100, Yuxuan Shui wrote:
> >> commit ac58e4fb03f9d111d733a4ad379d06eef3a24705 moved ext4_bmap from
> >> generic_block_bmap to iomap_bmap, this introduced a regression which
> >> prevents some user from using previously working swapfiles. The kernel
> >> will complain about holes while there is none.
> >>
> >> What is happening here is that the swapfile has unwritten mappings,
> >> which is rejected by iomap_bmap, but was accepted by ext4_get_block.
> >
> > ...which is why ext4 ought to use iomap_swapfile_activate.
>
> I tested this patch (diff below), which seems to be working fine for me
> for straight forward use case of swapon/swapoff on ext4.
> Could you give it a try?
>
> <log showing ext4_iomap_swap_activate path kicking in>
> swapon  1283 [000]   438.651028:     250000 cpu-clock:pppH:
>         ffffffff817f7f56 percpu_counter_add_batch+0x26 (/boot/vmlinux)
>         ffffffff813a61d0 ext4_es_lookup_extent+0x1d0 (/boot/vmlinux)
>         ffffffff813b8095 ext4_map_blocks+0x65 (/boot/vmlinux)
>         ffffffff813b8d4b ext4_iomap_begin_report+0x10b (/boot/vmlinux)
>         ffffffff81367f58 iomap_apply+0xa8 (/boot/vmlinux)
>         ffffffff8136d1c3 iomap_swapfile_activate+0xb3 (/boot/vmlinux)
>         ffffffff813b51a5 ext4_iomap_swap_activate+0x15 (/boot/vmlinux)
>         ffffffff812a3a27 __do_sys_swapon+0xb37 (/boot/vmlinux)
>         ffffffff812a40f6 __x64_sys_swapon+0x16 (/boot/vmlinux)
>         ffffffff820b760a do_syscall_64+0x5a (/boot/vmlinux)
>         ffffffff8220007c entry_SYSCALL_64+0x7c (/boot/vmlinux)
>             7ffff7de68bb swapon+0xb (/usr/lib/x86_64-linux-gnu/libc-2.30.so)
>         66706177732f756d [unknown] ([unknown])
>
> <shows that swapfile(which I setup using fallocate) has some used bytes>
> $ swapon -s
> Filename                                Type            Size    Used
> Priority
> /home/qemu/swapfile-test                file            2097148 42312   -2
>
>
> @Jan/Ted/Darrick,
>
> I am not that familiar with how swap subsystem works.
> So, is there anything else you feel is required apart from below changes
> for supporting swap_activate via iomap? I did test both swapon/swapoff
> and see that swap is getting used up on ext4 with delalloc mount opt.
>
> As I see from code, iomap_swapfile_activate is mainly looking for
> extent mapping information of that file to pass to swap subsystem.
> And IIUC, "ext4_iomap_report_ops" is meant exactly for that.
> Same as how we use it in ext4_fiemap().
>
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 6eae17758ece..1e390157541d 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3614,6 +3614,13 @@ static int ext4_set_page_dirty(struct page *page)
>         return __set_page_dirty_buffers(page);
>   }
>
> +static int ext4_iomap_swap_activate(struct swap_info_struct *sis,
> +                                   struct file *file, sector_t *span)
> +{
> +       return iomap_swapfile_activate(sis, file, span,
> +                                      &ext4_iomap_report_ops);
> +}
> +
>   static const struct address_space_operations ext4_aops = {
>         .readpage               = ext4_readpage,
>         .readahead              = ext4_readahead,
> @@ -3629,6 +3636,7 @@ static const struct address_space_operations
> ext4_aops = {
>         .migratepage            = buffer_migrate_page,
>         .is_partially_uptodate  = block_is_partially_uptodate,
>         .error_remove_page      = generic_error_remove_page,
> +       .swap_activate          = ext4_iomap_swap_activate,
>   };
>
>   static const struct address_space_operations ext4_journalled_aops = {
> @@ -3645,6 +3653,7 @@ static const struct address_space_operations
> ext4_journalled_aops = {
>         .direct_IO              = noop_direct_IO,
>         .is_partially_uptodate  = block_is_partially_uptodate,
>         .error_remove_page      = generic_error_remove_page,
> +       .swap_activate          = ext4_iomap_swap_activate,
>   };
>
>   static const struct address_space_operations ext4_da_aops = {
> @@ -3662,6 +3671,7 @@ static const struct address_space_operations
> ext4_da_aops = {
>         .migratepage            = buffer_migrate_page,
>         .is_partially_uptodate  = block_is_partially_uptodate,
>         .error_remove_page      = generic_error_remove_page,
> +       .swap_activate          = ext4_iomap_swap_activate,
>   };
>
>   static const struct address_space_operations ext4_dax_aops = {
> @@ -3670,6 +3680,7 @@ static const struct address_space_operations
> ext4_dax_aops = {
>         .set_page_dirty         = noop_set_page_dirty,
>         .bmap                   = ext4_bmap,
>         .invalidatepage         = noop_invalidatepage,
> +       .swap_activate          = ext4_iomap_swap_activate,
>   };
>
>   void ext4_set_aops(struct inode *inode)



-- 

Regards
Yuxuan Shui
