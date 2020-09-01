Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001C7259DDA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 20:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbgIASGr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 14:06:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbgIASGq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 14:06:46 -0400
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0CB020866;
        Tue,  1 Sep 2020 18:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598983605;
        bh=2Lfvmfq4ZZ/+WMJSiH8u8cZm0zraIa4vbzwb4dTfe0g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uFvkOFoR7ee4CiEr9FYKckMkQuvtj01lK9phDiqWKg63igqVY2m+VnySzKWdLQdRj
         KIj5gxNLWlU2NoVo21kbPij9slwCdGbc2Ql33UmGdp8SC6gEdYXZ44zsW7MabKWHAw
         sJzWV6FSKaAfftthbnIYUgx7rpgxUa8s0NYC6KtI=
Received: by mail-lj1-f174.google.com with SMTP id k25so2652722ljg.9;
        Tue, 01 Sep 2020 11:06:44 -0700 (PDT)
X-Gm-Message-State: AOAM532t0xGUhqUeZtXOZ9x3s6/UxyS/Pw3WXV0fuRUp+6La3AFJaDTm
        xtQcuY0f7nrKo6Egsj8Y8uKJdwTNtOPwUnaZWNs=
X-Google-Smtp-Source: ABdhPJyY9bc1IKqI/4PFWILW0olpWrITWYBVlcmWHnFJfpVQkBPzscfRB0xW1XKLj6lsc9Uqrpy1b+BNTMFEe14K2wM=
X-Received: by 2002:a2e:81c2:: with SMTP id s2mr1257862ljg.10.1598983603083;
 Tue, 01 Sep 2020 11:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <159897769535.405783.17587409235571100774.stgit@warthog.procyon.org.uk>
 <159897770245.405783.16506873187032379873.stgit@warthog.procyon.org.uk>
In-Reply-To: <159897770245.405783.16506873187032379873.stgit@warthog.procyon.org.uk>
From:   Song Liu <song@kernel.org>
Date:   Tue, 1 Sep 2020 11:06:31 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6vSE8j7yvz8Q377=ZGOq5xGh1bEujpDYkLLSO6ALmvTA@mail.gmail.com>
Message-ID: <CAPhsuW6vSE8j7yvz8Q377=ZGOq5xGh1bEujpDYkLLSO6ALmvTA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] Fix khugepaged's request size in collapse_file()
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 1, 2020 at 9:28 AM David Howells <dhowells@redhat.com> wrote:
>
> collapse_file() in khugepaged passes PAGE_SIZE as the number of pages to be
> read ahead to page_cache_sync_readahead().  It seems this was expressed as a
> number of bytes rather than a number of pages.
>
> Fix it to use the number of pages to the end of the window instead.
>
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Song Liu <songliubraving@fb.com>

Thanks for the fix!

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>
>  mm/khugepaged.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 6d199c353281..f2d243077b74 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1706,7 +1706,7 @@ static void collapse_file(struct mm_struct *mm,
>                                 xas_unlock_irq(&xas);
>                                 page_cache_sync_readahead(mapping, &file->f_ra,
>                                                           file, index,
> -                                                         PAGE_SIZE);
> +                                                         end - index);
>                                 /* drain pagevecs to help isolate_lru_page() */
>                                 lru_add_drain();
>                                 page = find_lock_page(mapping, index);
>
>
>
