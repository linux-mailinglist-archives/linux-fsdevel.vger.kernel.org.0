Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E17E6E1722
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 00:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjDMWEN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 18:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjDMWEM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 18:04:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2CB4C32;
        Thu, 13 Apr 2023 15:04:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F40F960C27;
        Thu, 13 Apr 2023 22:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E77C433D2;
        Thu, 13 Apr 2023 22:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681423450;
        bh=xEedh3p0Px8gEBli0z8eDmwS7fhVxANmtPS4fzYQhPU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UKN7N7/KsVqmKkswEDpO8M13fsDOtK58qXVAAE6Sf8ZYVOTBl7+9YT7L8TLuAVZna
         irwH6F5aBTuwTd2JL3taMnBffZlrzm4HtmdBdV/i0oxovJEwQYMYR42Ypiiu8ZI6ea
         dXH5AuRG8HLOwZARZR5Bd4XKpEpQvS6XnzujJYJo=
Date:   Thu, 13 Apr 2023 15:04:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        <linux-kernel@vger.kernel.org>, <tongtiangen@huawei.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] mm: hwpoison: coredump: support recovery from
 dump_user_range()
Message-Id: <20230413150409.f772cbafca5e7e3a658c58ee@linux-foundation.org>
In-Reply-To: <20230413041336.26874-1-wangkefeng.wang@huawei.com>
References: <20230413041336.26874-1-wangkefeng.wang@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 13 Apr 2023 12:13:36 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> The dump_user_range() is used to copy the user page to a coredump
> file, but if a hardware memory error occurred during copy, which
> called from __kernel_write_iter() in dump_user_range(), it crashs,
> 
>  CPU: 112 PID: 7014 Comm: mca-recover Not tainted 6.3.0-rc2 #425
> 
>  pc : __memcpy+0x110/0x260
>  lr : _copy_from_iter+0x3bc/0x4c8
>  ...
>  Call trace:
>   __memcpy+0x110/0x260
>   copy_page_from_iter+0xcc/0x130
>   pipe_write+0x164/0x6d8
>   __kernel_write_iter+0x9c/0x210
>   dump_user_range+0xc8/0x1d8
>   elf_core_dump+0x308/0x368
>   do_coredump+0x2e8/0xa40
>   get_signal+0x59c/0x788
>   do_signal+0x118/0x1f8
>   do_notify_resume+0xf0/0x280
>   el0_da+0x130/0x138
>   el0t_64_sync_handler+0x68/0xc0
>   el0t_64_sync+0x188/0x190
> 
> Generally, the '->write_iter' of file ops will use copy_page_from_iter()
> and copy_page_from_iter_atomic(), change memcpy() to copy_mc_to_kernel()
> in both of them to handle #MC during source read, which stop coredump
> processing and kill the task instead of kernel panic, but the source
> address may not always an user address, so introduce a new copy_mc flag
> in struct iov_iter{} to indicate that the iter could do a safe memory
> copy, also introduce the helpers to set/clear/check the flag, for now,
> it's only used in coredump's dump_user_range(), but it could expand to
> any other scenarios to fix the similar issue.
> 
> ...
>
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -291,6 +291,7 @@ void iov_iter_init(struct iov_iter *i, unsigned int direction,
>  		.nofault = false,
>  		.user_backed = true,
>  		.data_source = direction,
> +		.copy_mc = false,
>  		.__iov = iov,
>  		.nr_segs = nr_segs,
>  		.iov_offset = 0,

hm, linux-next.  mm.git doesn't have the other iov_iter changes, so I
repositioned the iov_iter.copy_mc field so the patch should fuzzily
apply to kernels with or without de4f5fed3f231a8 ("iov_iter: add
iter_iovec() helper"),


