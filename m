Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A047B54B2DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 16:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236609AbiFNOQK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 10:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbiFNOQJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:16:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB7C2DD7B
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 07:16:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 39BA721B98;
        Tue, 14 Jun 2022 14:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655216167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y+8NdkE5liNSvjWWz7n8OkBSTjeN3t8A0SpuJXku9Hs=;
        b=BypUEAzO4xR5Xjx4btQQu9EKZvKtXp30ZRBmzkyJlJD+IXx4huEX6RMlTirEZ86K+LZWk3
        fozwAlx1yFYm6XZ5U0ziBTHTE97VZVRdf3aWNF3pcyWr1JyZiAJiZ/lnqpBlSZMcu/b9VR
        plK3qnFq4B8L8DtczGtzfV8DJU1rYZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655216167;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y+8NdkE5liNSvjWWz7n8OkBSTjeN3t8A0SpuJXku9Hs=;
        b=hiMsJXu0GbC6bc/+UqJKm0VO9SeFA0SFAS4VOjXRnBdcI4wVfE6t0LFfM7RxP3qIXm8ymd
        vxIB5b68JgeAP3Dw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1DDC22C141;
        Tue, 14 Jun 2022 14:16:07 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AC686A062E; Tue, 14 Jun 2022 16:16:06 +0200 (CEST)
Date:   Tue, 14 Jun 2022 16:16:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Lecopzer Chen <lecopzer@gmail.com>
Cc:     jack@suse.cz, linux-fsdevel@vger.kernel.org,
        sunjunchao2870@gmail.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5] writeback: Fix inode->i_io_list not be protected by
 inode->i_lock error
Message-ID: <20220614141606.2qlbdlehssuytcaz@quack3.lan>
References: <20220525121351.ixs2yjcnk7ockvuv@quack3.lan>
 <20220613162023.29681-1-lecopzer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613162023.29681-1-lecopzer@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 14-06-22 00:20:23, Lecopzer Chen wrote:
> Sorry to jump in,
> 
> This patch merged in 5.19-rc2,
> and I find that this commit breaks my QEMU bootup(can't boot to shell) on arm64.
> 
> After revert this commit, everything goes back to normal.
> 
> Please kindly help with it if you have any idea about it.
> 
> for the log snippet:
> 
> [    3.755996][   T32] Unable to handle kernel paging request at virtual address ffffffc0f621e000
> [    3.756657][   T32] Mem abort info:
> [    3.756854][   T32]   ESR = 0x0000000096000005
> [    3.757224][   T32]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    3.757501][   T32]   SET = 0, FnV = 0
> [    3.757685][   T32]   EA = 0, S1PTW = 0
> [    3.757837][   T32]   FSC = 0x05: level 1 translation fault
> [    3.758008][   T32] Data abort info:
> [    3.758162][   T32]   ISV = 0, ISS = 0x00000005
> [    3.758393][   T32]   CM = 0, WnR = 0
> [    3.758643][   T32] swapper pgtable: 4k pages, 39-bit VAs, pgdp=0000000041619000
> [    3.758813][   T32] [ffffffc0f621e000] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
> [    3.765434][   T32] Internal error: Oops: 96000005 [#1] PREEMPT SMP
> [    3.766394][   T32] Modules linked in:
> [    3.766831][   T32] CPU: 1 PID: 32 Comm: kdevtmpfs Not tainted 5.19.0-rc2 #55
> [    3.767292][   T32] Hardware name: linux,dummy-virt (DT)
> [    3.767645][   T32] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    3.767827][   T32] pc : percpu_ref_get_many+0xf4/0x248
> [    3.768344][   T32] lr : percpu_ref_get_many+0x70/0x248
> [    3.768457][   T32] sp : ffffffc00a5cbb70
> [    3.768534][   T32] pmr_save: 000000e0
> [    3.768605][   T32] x29: ffffffc00a5cbb70 x28: 0000000000000000 x27: ffffffc00a3ca928
> [    3.776825][   T32] x26: ffffffc00980c5d8 x25: ffffffc00980b688 x24: 0000000000000002
> [    3.777005][   T32] x23: ffffffc00980b8a0 x22: ffffffc00980b698 x21: 0000000000000000
> [    3.813382][   T32] x20: 0000000000000000 x19: ffffffc00a3cada0 x18: ffffffc00995ca70
> [    3.814159][   T32] x17: ffffffc009bbeab0 x16: ffffffc0099fca70 x15: ffffffc0099fca70
> [    3.814699][   T32] x14: ffffff80c03b4a40 x13: 00000000ffffffff x12: ffffff80c03b4a40
> [    3.815745][   T32] x11: 0000000000000001 x10: 0000000000000001 x9 : ffffffc0f621e000
> [    3.816383][   T32] x8 : ffffff80c03b4a40 x7 : ffffffc0084d192c x6 : 0000000000000000
> [    3.817208][   T32] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> [    3.817618][   T32] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffffc0096eb800
> [    3.818814][   T32] Call trace:
> [    3.819360][   T32]  percpu_ref_get_many+0xf4/0x248
> [    3.820357][   T32]  locked_inode_to_wb_and_lock_list+0x118/0x39c
> [    3.821007][   T32]  __mark_inode_dirty+0x2f0/0x4cc
> [    3.821418][   T32]  simple_setattr+0xbc/0xd4
> [    3.821808][   T32]  notify_change+0x590/0x800
> [    3.822230][   T32]  devtmpfs_work_loop+0x464/0x8c8
> [    3.823063][   T32]  sock_inuse_exit_net+0x0/0x2c
> [    3.823520][   T32]  kthread+0x22c/0x250
> [    3.824159][   T32]  ret_from_fork+0x10/0x20
> [    3.824985][   T32] Code: 11000529 b9000909 d538d089 8b140129 (c85f7d2c)
> [    3.826820][   T32] ---[ end trace 0000000000000000 ]---
> [    3.829725][   T32] note: kdevtmpfs[32] exited with preempt_count 2
> [    3.840608][   T32] ------------[ cut here ]------------
> 
> for the assembly:
> ;   asm(ALTERNATIVE("mrs %0, tpidr_el1",
> ffffffc008095048: 89 d0 38 d5   mrs x9, TPIDR_EL1
> ;     this_cpu_add(*percpu_count, nr);
> ffffffc00809504c: 29 01 14 8b   add x9, x9, x20
> ; PERCPU_OP(add, add, stadd)
> ***-->ffffffc008095050: 2c 7d 5f c8   ldxr  x12, [x9]
> 
> locked_inode_to_wb_and_lock_list
> -> wb_get(wb)
>   -> percpu_ref_get(&wb->refcnt);
>   -> percpu_ref_get_many
>     ->
>   if (__ref_is_percpu(ref, &percpu_count))
> ***--> this_cpu_add(*percpu_count, nr);

Thanks for report! I've checked now and the problem is that
locked_inode_to_wb_and_lock_list() now gets called for inodes in the
kdevtmpfs and it gets called very early (during driver_init()) which is
before noop_backing_dev_info gets initialized. I'll fix this...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
