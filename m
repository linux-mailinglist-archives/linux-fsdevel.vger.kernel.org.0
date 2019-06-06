Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 939D537A65
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 19:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfFFRAP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 13:00:15 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42799 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFRAP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 13:00:15 -0400
Received: by mail-ot1-f68.google.com with SMTP id l15so2620407otn.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jun 2019 10:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fOF2v+nii6PCUScBH269ysq3FqQJUmeziCAupnZ/plI=;
        b=zgBUrZQERHJ0MwQl+9FEdnHVVraNTSvb2k3lMY3iiqKucZlLjPHCM+OenSOkFF6kkp
         +Fynlc0xZFRq73pL+3H0h/6jhWSwK7czgWoshBCvVHwBeUP+IyLezPCip4VFFUEkoshx
         gGnARnf9HYWaR0ClnvSV2bMFgQqTYbplAcjUdD0XmsffXdyvMFdqpXAqbFntO2CO7Ffh
         8kSk2jVsx5dmUtYboJmE/WXMUZ3AMpp/RZJgcWzJ1UBuWadIPMyBblU8rqvcbKn507qT
         8xubU38/uqOIKN2p1NZglv7xwG7hS0Ak/fTxhdCArMXR+Sp4OZroxY+xjmhPrJkBsEpn
         y7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fOF2v+nii6PCUScBH269ysq3FqQJUmeziCAupnZ/plI=;
        b=c1LSY9y9fxUaQsu50uot2wSR4z9Z4Au0bIv1leb+FR0+OM9yQ1/v+DYrl8z173KcK0
         A+Gn50HnebXISg9DeKZgteQbgWZNapa1650jn/a/s/z69j77mua9904MWYurfsW3tr79
         ZKPm9C8ZZLB2Q+RSUK35nE9+uv3LqxRoDEEjUNeVJdU1tvuD6bh/SNZ9WJ2gH2yekjtw
         wj7vFdLhPTcDPSLKZBKvA1UMBSDZDuVQS+7CwNKRzyUEhSPjFafJpzLLKaS16P5ZZwk7
         ryDtLYgI2jM7AExf8lJo5JAG0knrErqwZjqjepmC+JtX/B8e9qFpUyDKH8Cd1mfquhQp
         cydg==
X-Gm-Message-State: APjAAAV43gtl/hxiWm+E1BU8UHADGOIgrdtO1Q2p4hJAMGt2uI8j/xu2
        EjwlmiWGo7ZXYRl3SKWOXHp0mkVs0m/MykcbGVlkNg==
X-Google-Smtp-Source: APXvYqw9oulwXBGmnjNFJzOiIPlf4TLGSj5wNxUI+ZF1trLskZ3MD0rzqMuYZS1eaSFxY4PMZFWyS6MR986IxHSbL5w=
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr10998391otn.71.1559840413685;
 Thu, 06 Jun 2019 10:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190606091028.31715-1-jack@suse.cz>
In-Reply-To: <20190606091028.31715-1-jack@suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 6 Jun 2019 10:00:01 -0700
Message-ID: <CAPcyv4jxBoDUyuEFjY=1TcN_8ufjM8tqF1Yj0AN=xHfQ0NpdDQ@mail.gmail.com>
Subject: Re: [PATCH] dax: Fix xarray entry association for mixed mappings
To:     Jan Kara <jack@suse.cz>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 6, 2019 at 2:10 AM Jan Kara <jack@suse.cz> wrote:
>
> When inserting entry into xarray, we store mapping and index in
> corresponding struct pages for memory error handling. When it happened
> that one process was mapping file at PMD granularity while another
> process at PTE granularity, we could wrongly deassociate PMD range and
> then reassociate PTE range leaving the rest of struct pages in PMD range
> without mapping information which could later cause missed notifications
> about memory errors. Fix the problem by calling the association /
> deassociation code if and only if we are really going to update the
> xarray (deassociating and associating zero or empty entries is just
> no-op so there's no reason to complicate the code with trying to avoid
> the calls for these cases).

Looks good to me, I assume this also needs:

Cc: <stable@vger.kernel.org>
Fixes: d2c997c0f145 ("fs, dax: use page->mapping to warn if truncate
collides with a busy page")

>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/dax.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index f74386293632..9fd908f3df32 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -728,12 +728,11 @@ static void *dax_insert_entry(struct xa_state *xas,
>
>         xas_reset(xas);
>         xas_lock_irq(xas);
> -       if (dax_entry_size(entry) != dax_entry_size(new_entry)) {
> +       if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
> +               void *old;
> +
>                 dax_disassociate_entry(entry, mapping, false);
>                 dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address);
> -       }
> -
> -       if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
>                 /*
>                  * Only swap our new entry into the page cache if the current
>                  * entry is a zero page or an empty entry.  If a normal PTE or
> @@ -742,7 +741,7 @@ static void *dax_insert_entry(struct xa_state *xas,
>                  * existing entry is a PMD, we will just leave the PMD in the
>                  * tree and dirty it if necessary.
>                  */
> -               void *old = dax_lock_entry(xas, new_entry);
> +               old = dax_lock_entry(xas, new_entry);
>                 WARN_ON_ONCE(old != xa_mk_value(xa_to_value(entry) |
>                                         DAX_LOCKED));
>                 entry = new_entry;
> --
> 2.16.4
>
