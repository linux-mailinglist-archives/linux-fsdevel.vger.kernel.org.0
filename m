Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E99E5129332
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2019 09:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfLWIlO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 03:41:14 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41523 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfLWIlO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 03:41:14 -0500
Received: by mail-ot1-f66.google.com with SMTP id r27so21194602otc.8;
        Mon, 23 Dec 2019 00:41:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cDv9UaL4HKxCZwOpeNm1xbtf2cmQl4fg1wQxfmqaPlY=;
        b=f2zAyaDXwgl4tc6L5OljcVFXROCwReDChWEOjREH3Ho857KqigiMUBkYVvSd9Tj21t
         T6dDGuVTd4kwkAz9j8VTiyi9MdhvwvMV6WyJgMB8w/jXVz9q0SgmWbn3WaH7m1/x3BDV
         QjUAnUJh+aL56YOlwDH6jE/T+OTqKsGzF5cbWnWN3s1gyBmhWOuoFK+6YNpwqCwj4p9u
         en0NQGwgdDcdJy3WAiW4/UeYffsh96tljoF1cLZINldvnRPnD3fEwlQ0mzWYKHDh37wQ
         bp3Gky2wuhiLt+mUrw1cxYleKMSomU8EstGezn5MiT5fQTNleS7xVoNF83vl/1scPhUa
         4moQ==
X-Gm-Message-State: APjAAAUTg841JTkrunoyV5cnT2VNz6KEm8sHHrGmN7htgWkekBzEtLAs
        JXD/cOcWB1E4rM3nud9ZzJI81cSR6rABozRRZ5Dolbfo
X-Google-Smtp-Source: APXvYqx2KCiv7cxuDdzBfA2c2NhXkW2xa7BGOvhzkGGauQ0VJ6aD6A5SkDirLFnjAg8AJrwmGlawMoHMEhNiYeHVBR4=
X-Received: by 2002:a9d:dc1:: with SMTP id 59mr31479287ots.250.1577090473314;
 Mon, 23 Dec 2019 00:41:13 -0800 (PST)
MIME-Version: 1.0
References: <20191223040020.109570-1-yuchao0@huawei.com>
In-Reply-To: <20191223040020.109570-1-yuchao0@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 Dec 2019 09:41:02 +0100
Message-ID: <CAMuHMdUDMv_mMw_ZU4BtuRKX1OvMhjLWw2owTcAP-0D4j5XROw@mail.gmail.com>
Subject: Re: [PATCH] f2fs: introduce DEFAULT_IO_TIMEOUT_JIFFIES
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chao Yu <chao@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

CC linux-fsdevel

On Mon, Dec 23, 2019 at 5:01 AM Chao Yu <yuchao0@huawei.com> wrote:
> As Geert Uytterhoeven reported:
>
> for parameter HZ/50 in congestion_wait(BLK_RW_ASYNC, HZ/50);
>
> On some platforms, HZ can be less than 50, then unexpected 0 timeout
> jiffies will be set in congestion_wait().
>
> This patch introduces a macro DEFAULT_IO_TIMEOUT_JIFFIES to limit
> mininum value of timeout jiffies.
>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>

Thanks for your patch!

> ---
>  fs/f2fs/compress.c |  3 ++-
>  fs/f2fs/data.c     |  5 +++--
>  fs/f2fs/f2fs.h     |  2 ++
>  fs/f2fs/gc.c       |  3 ++-
>  fs/f2fs/inode.c    |  3 ++-
>  fs/f2fs/node.c     |  3 ++-
>  fs/f2fs/recovery.c |  6 ++++--
>  fs/f2fs/segment.c  | 12 ++++++++----
>  fs/f2fs/super.c    |  6 ++++--
>  9 files changed, 29 insertions(+), 14 deletions(-)
>
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 1bc86a54ad71..ee4fe8e644aa 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -945,7 +945,8 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
>                         } else if (ret == -EAGAIN) {
>                                 ret = 0;
>                                 cond_resched();
> -                               congestion_wait(BLK_RW_ASYNC, HZ/50);
> +                               congestion_wait(BLK_RW_ASYNC,
> +                                       DEFAULT_IO_TIMEOUT_JIFFIES);
>                                 lock_page(cc->rpages[i]);
>                                 clear_page_dirty_for_io(cc->rpages[i]);
>                                 goto retry_write;
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index f1f5c701228d..78b5c0b0287e 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2320,7 +2320,8 @@ int f2fs_encrypt_one_page(struct f2fs_io_info *fio)
>                 /* flush pending IOs and wait for a while in the ENOMEM case */
>                 if (PTR_ERR(fio->encrypted_page) == -ENOMEM) {
>                         f2fs_flush_merged_writes(fio->sbi);
> -                       congestion_wait(BLK_RW_ASYNC, HZ/50);
> +                       congestion_wait(BLK_RW_ASYNC,
> +                                       DEFAULT_IO_TIMEOUT_JIFFIES);
>                         gfp_flags |= __GFP_NOFAIL;
>                         goto retry_encrypt;
>                 }
> @@ -2900,7 +2901,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>                                         if (wbc->sync_mode == WB_SYNC_ALL) {
>                                                 cond_resched();
>                                                 congestion_wait(BLK_RW_ASYNC,
> -                                                               HZ/50);
> +                                                       DEFAULT_IO_TIMEOUT_JIFFIES);
>                                                 goto retry_write;
>                                         }
>                                         goto next;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 16edbf4e05e8..4bdc20a94185 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -559,6 +559,8 @@ enum {
>
>  #define DEFAULT_RETRY_IO_COUNT 8       /* maximum retry read IO count */
>
> +#define        DEFAULT_IO_TIMEOUT_JIFFIES      (max_t(long, HZ/50, 1))
> +
>  /* maximum retry quota flush count */
>  #define DEFAULT_RETRY_QUOTA_FLUSH_COUNT                8
>

Seeing other file systems (ext4, xfs) and even core MM code suffers from
the same issue, perhaps it makes sense to move this into congestion_wait(),
i.e. increase the timeout to 1 if it's zero in the latter function?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
