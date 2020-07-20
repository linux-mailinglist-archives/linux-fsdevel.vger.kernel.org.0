Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9EB226D9A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 19:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbgGTRxL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 13:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbgGTRxK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 13:53:10 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A2FC0619D4
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2020 10:53:09 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b25so21187828ljp.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2020 10:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kya9ou2H4xCIeg2jTugLQPDLPsUiSPAXkhjVJRHMDG8=;
        b=SX8NYsOLgCeGmFxjb3Z0RzsYrlrHY6Njtfv46WXbScI3rw3tkdMvNy7qsqcNAy91ok
         EmnOsjkBbRSUSYO4/Q+Cx/xTEf85/D7y3ubLVL9GrTTaC883stkN/jVXYzE2FCCqF7eB
         9s7gGZej8MgWwlJIFwC85V0qxylpm5PoPDao/u8vX7pBu4QWu3w4EYzNHhOsY3D9UTQv
         wZ7VKxvMYrxM6QJlB3KwFInEXd5SELo26Gs2/yM5C+3lGgUkJm4gOG1yFNX6CZ+WQun4
         2A746f0YswL5r2QB7a0ry1PuFLvHVFwRkJvX+AeFb1QZo7ouw1eWDpQA/DMeKnb180Pl
         r/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kya9ou2H4xCIeg2jTugLQPDLPsUiSPAXkhjVJRHMDG8=;
        b=NiRilmmM3ByC3hKbKpfeD35L6FTvJFU0j7pzgLdXWPdeaLb6Px9wnCFNOwJHQP+t59
         DRc54RDrZhoEVWpqGwAN/u14zoVAE+yXKZG5iRSYQPvd80BKtsO1a28lwLhV9TVYKuWt
         9yJyxSkYKCuAC4kZ8oytHShfitsUmDhUFa+plfKDVwgw1m1VWSJNz6Wpi2Tf9h4r40I/
         roNmtLnYwhFu2jbOrUZjy6jsutRawd/bFfUwJyN3z2KADfsedb2iPAY7wkuENm+lFFd4
         bpxIEWKKxaR4ng+xux9foHUiH0Gg4S7/RmZXbfvVjKPgSBDzOAHDH8C/T6cnqxi2nBQ7
         xeWQ==
X-Gm-Message-State: AOAM531IZhVA0MYWaFtiaSKo5z+bnj/GOzmrTys75SLxidpU46PJqVoy
        Qcg4skiPSh9EjNMjjc6kwKGqxj1QjTmFDpREZIzjFQ==
X-Google-Smtp-Source: ABdhPJxVEb/gDZEkvQ7LMo203fIZqznHvbPDVwx5Y0R9jHwZ6CsaSCd83ZH/mrB+5f45z4TkFHBNvGDSXrXZqTZC034=
X-Received: by 2002:a2e:8e36:: with SMTP id r22mr10983662ljk.77.1595267587620;
 Mon, 20 Jul 2020 10:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200720075148.172156-1-hch@lst.de> <20200720075148.172156-12-hch@lst.de>
In-Reply-To: <20200720075148.172156-12-hch@lst.de>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 20 Jul 2020 10:52:55 -0700
Message-ID: <CALvZod7ACBnNX5W-gtTzheh8R-rxv1nB-5q7UcDUZ7BvtpakpA@mail.gmail.com>
Subject: Re: [PATCH 11/14] mm: use SWP_SYNCHRONOUS_IO more intelligently
To:     Christoph Hellwig <hch@lst.de>, Minchan Kim <minchan@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, drbd-dev@lists.linbit.com,
        linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+Minchan Kim

On Mon, Jul 20, 2020 at 12:52 AM Christoph Hellwig <hch@lst.de> wrote:
>
> There is no point in trying to call bdev_read_page if SWP_SYNCHRONOUS_IO
> is not set, as the device won't support it.  Also there is no point in
> trying a bio submission if bdev_read_page failed.

This will at least break the failure path of zram_rw_page().

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/page_io.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/mm/page_io.c b/mm/page_io.c
> index ccda7679008851..63b44b8221af0f 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -403,8 +403,11 @@ int swap_readpage(struct page *page, bool synchronous)
>                 goto out;
>         }
>
> -       ret = bdev_read_page(sis->bdev, swap_page_sector(page), page);
> -       if (!ret) {
> +       if (sis->flags & SWP_SYNCHRONOUS_IO) {
> +               ret = bdev_read_page(sis->bdev, swap_page_sector(page), page);
> +               if (ret)
> +                       goto out;
> +
>                 if (trylock_page(page)) {
>                         swap_slot_free_notify(page);
>                         unlock_page(page);
> --
> 2.27.0
>
