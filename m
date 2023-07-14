Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E4A75456E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jul 2023 01:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjGNXgK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 19:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGNXgJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 19:36:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7753A92;
        Fri, 14 Jul 2023 16:36:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C4F061E15;
        Fri, 14 Jul 2023 23:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925F2C433C9;
        Fri, 14 Jul 2023 23:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689377767;
        bh=QeueiOpDQZwo6rtEiZoJ8qhJKkd5jWANfodFVO3UgnI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=XZqdXW3oB1OA9npd73eLtv/UBG5Scu7Gm/HetbtRBr1UGMYwh65+KUMe01Kn4GgU4
         q2Jz1V+G92sDeoO2CF5EyqhvK70W+MGZ8Z2NFCeTu+96ikE+QHnKU9GelJZJwRQMTU
         niqyUujd0BW+4UYKz3YPXgknNQgGSoO/u2x3ctS2qt9lO9U/xsWMDjr151ZYOO7MR5
         nuJHn+QT3CGYqdKbcAXhbF44rNZI9bnMIllNVQhZieAU4QUHqKRkelJFkDsWxHFHNd
         erynCy1bOqvj9GHi/Y0qWMaPqGL+ro5IyFAxmVFh454+4vvM131WG/AK9dRlm6OgS8
         AAzAjvKAleHJg==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-56597d949b1so1689905eaf.1;
        Fri, 14 Jul 2023 16:36:07 -0700 (PDT)
X-Gm-Message-State: ABy/qLYXvUZteR0AZK79E2TF+/9r69cqJhWPRvf/LXNl2rGlwyPEJNRj
        aBHB7NoFWSgwk98YQ8IikvHn0fwkJwRlnGat28k=
X-Google-Smtp-Source: APBJJlEFqDCFObfCfrVlv0+B4OnBTopnGMsqKu25XX1NhpPE9jqO/7EtxY8CDN72Va1Re9Ujl3gcn9mGcMs+qhDJkEI=
X-Received: by 2002:a05:6870:c588:b0:1b7:613c:2eb2 with SMTP id
 ba8-20020a056870c58800b001b7613c2eb2mr8323917oab.6.1689377766742; Fri, 14 Jul
 2023 16:36:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:4c7:0:b0:4e8:f6ff:2aab with HTTP; Fri, 14 Jul 2023
 16:36:06 -0700 (PDT)
In-Reply-To: <20230714084354.1959951-1-sj1557.seo@samsung.com>
References: <CGME20230714084427epcas1p2ce3efb1524c8efae6038d1940149ae54@epcas1p2.samsung.com>
 <20230714084354.1959951-1-sj1557.seo@samsung.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sat, 15 Jul 2023 08:36:06 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-+_M=7b-E7RyJj+S3w=_WF8VDRyunYdXPdpD1dTtRA=Q@mail.gmail.com>
Message-ID: <CAKYAXd-+_M=7b-E7RyJj+S3w=_WF8VDRyunYdXPdpD1dTtRA=Q@mail.gmail.com>
Subject: Re: [PATCH] exfat: release s_lock before calling dir_emit()
To:     Sungjong Seo <sj1557.seo@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        syzbot+1741a5d9b79989c10bdc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2023-07-14 17:43 GMT+09:00, Sungjong Seo <sj1557.seo@samsung.com>:
> There is a potential deadlock reported by syzbot as below:
>
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.4.0-next-20230707-syzkaller #0 Not tainted
> ------------------------------------------------------
> syz-executor330/5073 is trying to acquire lock:
> ffff8880218527a0 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock_killable
> include/linux/mmap_lock.h:151 [inline]
> ffff8880218527a0 (&mm->mmap_lock){++++}-{3:3}, at: get_mmap_lock_carefully
> mm/memory.c:5293 [inline]
> ffff8880218527a0 (&mm->mmap_lock){++++}-{3:3}, at:
> lock_mm_and_find_vma+0x369/0x510 mm/memory.c:5344
> but task is already holding lock:
> ffff888019f760e0 (&sbi->s_lock){+.+.}-{3:3}, at: exfat_iterate+0x117/0xb50
> fs/exfat/dir.c:232
>
> which lock already depends on the new lock.
>
> Chain exists of:
>   &mm->mmap_lock --> mapping.invalidate_lock#3 --> &sbi->s_lock
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&sbi->s_lock);
>                                lock(mapping.invalidate_lock#3);
>                                lock(&sbi->s_lock);
>   rlock(&mm->mmap_lock);
>
> Let's try to avoid above potential deadlock condition by moving dir_emit*()
> out of sbi->s_lock coverage.
>
> Fixes: ca06197382bd ("exfat: add directory operations")
> Cc: stable@vger.kernel.org #v5.7+
> Reported-by: syzbot+1741a5d9b79989c10bdc@syzkaller.appspotmail.com
> Link:
> https://lore.kernel.org/lkml/00000000000078ee7e060066270b@google.com/T/#u
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Applied it to #dev, Thanks for your patch!
