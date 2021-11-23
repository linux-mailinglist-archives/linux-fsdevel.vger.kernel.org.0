Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B770F45AE64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 22:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240495AbhKWVZe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 16:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240508AbhKWVZd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 16:25:33 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB22C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 13:22:24 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id m15so215498pgu.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 13:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bLSToY/Rn4QaplrUteOdrUS7Uug3uZWr/TlOz9Y1nF0=;
        b=b/hUI3hQLxDR2Xk9r7lQxFzBrg/2/5tGZW+JSVwNYrq8dmNWS3P9ynBIU8RZmfFHUI
         Xgm0552sZFP2+qPF3soghwDd7XxX6FGNBFe395T6bvF+N1dr29Lop15wmWK8lt8m87yV
         9vAVuWAMC6kkIO1VclhYl3oilFONamQuNci0i1jGGdKo0v4NlKYSPdpcWln2MSBf1py8
         eotcm4rw3pNPGNJSmy6HW2en9pvx0GUA8KH3ho166JTJ5FG5ph7IQpvk6v1nkInbqZW5
         YGsf77VgzBkZO6x5IA8KcT5QTl5SnWc54c+GTeaTywwpW3otwTRaZbbIpfY5ylF9vOkP
         iFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bLSToY/Rn4QaplrUteOdrUS7Uug3uZWr/TlOz9Y1nF0=;
        b=J1Ks1zmQAH3w8qnjOGxn+M6oMjrjoSbEQ2B0UvmjfpFaKhIs8tVUUHxqYGJEFLBwCm
         CI7IL7BFWEbb1JSJm2CCOk+ShLna7K6/XW/zdeLiIZPVTQVZII66onGzYKVrZtML4wd/
         jiHgMaymaewHtdpH19ZCxtkYL8Si7kY7jXBLJ/h8Aii7SXq3uq2rViE5ZM3xuIMbP7oB
         zqfwRzV+NAobvRY12O6ONWflGd4pNDWjPzTSc3sxMK/FRs/r7IQttvTfFL0+NReiOpqD
         JR+GyR85LcQGP22DDOZVMVJKUQ6BSic87XsJ8GqGNoKAayXYHVAM6OrE8J9/+l3clj8w
         fVlw==
X-Gm-Message-State: AOAM531dhfqPyH5ceFmxMpeXNE/4f1zz+gR1iu391ts/HEKNUrmWuW6c
        V2dLMWQDza52HuUzDWj12qMFsN+3Rn6lE8nszSPTKw==
X-Google-Smtp-Source: ABdhPJynvi8g71RwjaWWgFjo9LaoTAJgYi1+7huNhjnlJVCNZL4JsPbOJLOogDISiszVaR5xm5B316tq/pqSlm2ohsA=
X-Received: by 2002:a05:6a00:140e:b0:444:b077:51ef with SMTP id
 l14-20020a056a00140e00b00444b07751efmr476612pfu.61.1637702544283; Tue, 23 Nov
 2021 13:22:24 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-18-hch@lst.de>
In-Reply-To: <20211109083309.584081-18-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 13:22:13 -0800
Message-ID: <CAPcyv4imPgBEbhDCQpDwCQUTxOQy=RT9ZkAueBQdPKXOLNmrAQ@mail.gmail.com>
Subject: Re: [PATCH 17/29] fsdax: factor out a dax_memzero helper
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Factor out a helper for the "manual" zeroing of a DAX range to clean
> up dax_iomap_zero a lot.
>

Small / optional fixup below:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/dax.c | 36 +++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index d7a923d152240..dc9ebeff850ab 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1121,34 +1121,36 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
>  }
>  #endif /* CONFIG_FS_DAX_PMD */
>
> +static int dax_memzero(struct dax_device *dax_dev, pgoff_t pgoff,
> +               unsigned int offset, size_t size)
> +{
> +       void *kaddr;
> +       long rc;
> +
> +       rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
> +       if (rc >= 0) {

Technically this should be "> 0" because dax_direct_access() returns
nr_available_pages @pgoff, but this isn't broken because
dax_direct_access() converts the "zero pages available" case into
-ERANGE.

> +               memset(kaddr + offset, 0, size);
> +               dax_flush(dax_dev, kaddr + offset, size);
> +       }
> +       return rc;
> +}
> +
>  s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
>  {
>         pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
>         long rc, id;
> -       void *kaddr;
> -       bool page_aligned = false;
>         unsigned offset = offset_in_page(pos);
>         unsigned size = min_t(u64, PAGE_SIZE - offset, length);
>
> -       if (IS_ALIGNED(pos, PAGE_SIZE) && size == PAGE_SIZE)
> -               page_aligned = true;
> -
>         id = dax_read_lock();
> -
> -       if (page_aligned)
> +       if (IS_ALIGNED(pos, PAGE_SIZE) && size == PAGE_SIZE)
>                 rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
>         else
> -               rc = dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL);
> -       if (rc < 0) {
> -               dax_read_unlock(id);
> -               return rc;
> -       }
> -
> -       if (!page_aligned) {
> -               memset(kaddr + offset, 0, size);
> -               dax_flush(iomap->dax_dev, kaddr + offset, size);
> -       }
> +               rc = dax_memzero(iomap->dax_dev, pgoff, offset, size);
>         dax_read_unlock(id);
> +
> +       if (rc < 0)
> +               return rc;
>         return size;
>  }
>
> --
> 2.30.2
>
