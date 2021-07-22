Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B2E3D22F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 13:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhGVLL4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 07:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhGVLL4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 07:11:56 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD10C061575;
        Thu, 22 Jul 2021 04:52:31 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i5so8108576lfe.2;
        Thu, 22 Jul 2021 04:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ypKqM7KTx5GpDb/y7PGXXY/nEaOI08qXqRMcMGLHsKU=;
        b=Co2isklHqoeK+dVakSgNHl1oaYC9tuYysc/z5nwhR3VrEEJOloyqQJolx8feidgI2N
         ElgwJgIBswly6hyU6XFqmMNhxtXQxVGpf1WbmLUeWByCdqiGWCg5e/FUzZsmVQQAxooB
         X/Zw56MlS/+Y9Kbd7goKvDrb1ckkoQnynCg5lcAUSz+HQMbh1lbYMWy4z+fANVX0uyP8
         UfQiHSRYYGGlClGYooUJffvGkMxOxwj91cM0DHyXxrc6/rrEA6FaWUfWXMmNB1CmnQgE
         pWPzKf/cxv9issJjiSM4eE320SYJBlYjwTccZ01uEu159EFWzwb/dRYqDvIaaIA6S4Bm
         ESGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ypKqM7KTx5GpDb/y7PGXXY/nEaOI08qXqRMcMGLHsKU=;
        b=CjFD9LnmPQIMxXr4UWmCH5WV7Iv0UhYkMzxSOJ2GxvOhqxcMpRG6NtkYoHP19twG4z
         QKllX0t+JSiN3rAo1bafyqOiW8IPpYqiohtzrEXs6d/3rEU44XvhZWVV4S3RORuZSWLt
         cFBK2AOjqxWv7+HK/TLx363jHb6nDsqlCKaD1XTUvq/El6e1cJRTOPyxEIDSsReHDmHr
         LWWi/RD2R0aniH6mCG2d9COqYYS+BrkSukfNDsTPBtOavosyUbRn+AIt26yuoIzmuMDS
         rqwA20nfQUMqx9CNjqXQkkk57ddRMhqoP10ZJs/vAuUKDe7cpY3BLmZXcxz9rka/j6xL
         u3Zw==
X-Gm-Message-State: AOAM530edj4kSpFCmD2aJvLTwyZ7rhhHEKhthJ/dEJZxz+fmYaj4xU22
        RYR24xhrkdDISh25afyCo76+fSZwEKE=
X-Google-Smtp-Source: ABdhPJyQqV5j32AB3JiK3JxX8PRQKtaHRVok6krIaVVBKgiYVsFhCKwwo1GtwUnNXDsB5GfcKeqEJA==
X-Received: by 2002:a05:6512:68c:: with SMTP id t12mr12714146lfe.224.1626954749387;
        Thu, 22 Jul 2021 04:52:29 -0700 (PDT)
Received: from [192.168.2.145] (79-139-184-182.dynamic.spd-mgts.ru. [79.139.184.182])
        by smtp.googlemail.com with ESMTPSA id l21sm2623692ljc.94.2021.07.22.04.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 04:52:29 -0700 (PDT)
Subject: Re: [PATCH v14 062/138] mm/migrate: Add folio_migrate_copy()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-63-willy@infradead.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a670e7c1-95fb-324f-055f-74dd4c81c0d0@gmail.com>
Date:   Thu, 22 Jul 2021 14:52:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-63-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

15.07.2021 06:35, Matthew Wilcox (Oracle) пишет:
> This is the folio equivalent of migrate_page_copy(), which is retained
> as a wrapper for filesystems which are not yet converted to folios.
> Also convert copy_huge_page() to folio_copy().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/migrate.h |  1 +
>  include/linux/mm.h      |  2 +-
>  mm/folio-compat.c       |  6 ++++++
>  mm/hugetlb.c            |  2 +-
>  mm/migrate.c            | 14 +++++---------
>  mm/util.c               |  6 +++---
>  6 files changed, 17 insertions(+), 14 deletions(-)

Hi,

I'm getting warnings that might be related to this patch.

[37020.191023] BUG: sleeping function called from invalid context at mm/util.c:761
[37020.191383] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 29, name: kcompactd0
[37020.191550] CPU: 1 PID: 29 Comm: kcompactd0 Tainted: G        W         5.14.0-rc2-next-20210721-00201-g393e9d2093a1 #8880
[37020.191576] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[37020.191599] [<c010ce15>] (unwind_backtrace) from [<c0108fd5>] (show_stack+0x11/0x14)
[37020.191667] [<c0108fd5>] (show_stack) from [<c0a74b1f>] (dump_stack_lvl+0x2b/0x34)
[37020.191724] [<c0a74b1f>] (dump_stack_lvl) from [<c0141a41>] (___might_sleep+0xed/0x11c)
[37020.191779] [<c0141a41>] (___might_sleep) from [<c0241e07>] (folio_copy+0x3f/0x84)
[37020.191817] [<c0241e07>] (folio_copy) from [<c027a7b1>] (folio_migrate_copy+0x11/0x1c)
[37020.191856] [<c027a7b1>] (folio_migrate_copy) from [<c027ab65>] (__buffer_migrate_page.part.0+0x215/0x238)
[37020.191891] [<c027ab65>] (__buffer_migrate_page.part.0) from [<c027b73d>] (buffer_migrate_page_norefs+0x19/0x28)
[37020.191927] [<c027b73d>] (buffer_migrate_page_norefs) from [<c027affd>] (move_to_new_page+0x4d/0x200)
[37020.191960] [<c027affd>] (move_to_new_page) from [<c027bc91>] (migrate_pages+0x521/0x72c)
[37020.191993] [<c027bc91>] (migrate_pages) from [<c024dbc1>] (compact_zone+0x589/0xb60)
[37020.192031] [<c024dbc1>] (compact_zone) from [<c024e1eb>] (proactive_compact_node+0x53/0x6c)
[37020.192064] [<c024e1eb>] (proactive_compact_node) from [<c024e713>] (kcompactd+0x20b/0x238)
[37020.192096] [<c024e713>] (kcompactd) from [<c013b987>] (kthread+0x123/0x140)
[37020.192134] [<c013b987>] (kthread) from [<c0100155>] (ret_from_fork+0x11/0x1c)
[37020.192164] Exception stack(0xc1751fb0 to 0xc1751ff8)

