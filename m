Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B88F199F3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 21:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgCaTia (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 15:38:30 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34878 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgCaTia (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:38:30 -0400
Received: by mail-ed1-f65.google.com with SMTP id a20so26705191edj.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2020 12:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=coOdi1Ly5bJ5CvWdmQt/Q+ZCp+crvRqi7slIvYScR14=;
        b=oCBiHixRsRqxNnKByFIvZClFEVtIFF4B8Nx41p6iiYhNwitsHjQ8cg5SAq5qI1ghy3
         kSuUcWke/Ml2C4WTgdNA5jhbVfBm4qucb5EDY7/8+kRqlLnRsYYzQEUuLEQmY1ijaP5y
         +qWEQRzJkut5qkaLKy7ZyanwwQ4yAkijmn+4+w8YhXlei7Xx8eAtZMJQrhKEJd7LvtOm
         vGcv56fIlzt2bB7GpSJO1GkIHRRfZ7L9UZZ64pAgKHFleZ4HqrXJqUh9tu+iQZXOiL5j
         pikzHkCrq26EooTmp26MpUo+KwZPLUEEJ0xx2P9qAmSBV0SlCSQ4VccUscW5L2dAV26b
         iWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=coOdi1Ly5bJ5CvWdmQt/Q+ZCp+crvRqi7slIvYScR14=;
        b=ry8MK64BirWmn4hJYE+x6aq54yyKKKYUYbcQ6fHoIe55ekCqht4164vv+4dK/ZiYDU
         WmPnCdbfjWGiypWUR+e8WQ05jUsgLGcPbg3JE7Gx3sG0RCr4EjqIQK8jXlDUPCsyIyyQ
         Gq7ptvk8mbesqvCDXb3jO/tiw8b8tEMC/gMDNtlCZgrjrrqX9APcNi2yoPMefMrRmozq
         a34xH1h/RyWhoTTsy1LmrIc8cepcq9XR4GVYusnQbcB+G+PX3JZlCCNtfzZvtY6x9h3S
         SOyXqblBfVOdIeoeGZVG/SxMGg2kMsnant6KWqFNaAaDFhfyXEu7nCiITrvTzLK6jD9L
         Fddg==
X-Gm-Message-State: ANhLgQ0a37BkesSOUg8F3ugPncRPbEtFsXoDQoA3wBlLq6PGaNpbLHkw
        XyUhFF9rS2QFAmnaj3HtGzpaUdtLnV9M4RfBCMEtBg==
X-Google-Smtp-Source: ADFU+vucdPRa5GwsLNOLq17qDztrUIi3xXzSpp62uKGM5//eINqDk4GDVcCHXXgstr7+YAE0SAGtA+/4ZqZsNN24uMY=
X-Received: by 2002:aa7:d7c7:: with SMTP id e7mr17322078eds.296.1585683508013;
 Tue, 31 Mar 2020 12:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200218214841.10076-1-vgoyal@redhat.com> <20200218214841.10076-5-vgoyal@redhat.com>
In-Reply-To: <20200218214841.10076-5-vgoyal@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 31 Mar 2020 12:38:16 -0700
Message-ID: <CAPcyv4jKHxy5c8BZodePeCu5+Z=cwhtEfw3RnOD1ZDNob382bQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] dax, pmem: Add a dax operation zero_page_range
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Christoph Hellwig <hch@infradead.org>,
        device-mapper development <dm-devel@redhat.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 1:49 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> Add a dax operation zero_page_range, to zero a range of memory. This will
> also clear any poison in the range being zeroed.
>
> As of now, zeroing of up to one page is allowed in a single call. There
> are no callers which are trying to zero more than a page in a single call.
> Once we grow the callers which zero more than a page in single call, we
> can add that support. Primary reason for not doing that yet is that this
> will add little complexity in dm implementation where a range might be
> spanning multiple underlying targets and one will have to split the range
> into multiple sub ranges and call zero_page_range() on individual targets.
>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  drivers/dax/super.c   | 19 +++++++++++++++++++
>  drivers/nvdimm/pmem.c | 10 ++++++++++
>  include/linux/dax.h   |  3 +++
>  3 files changed, 32 insertions(+)
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 0aa4b6bc5101..c912808bc886 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -344,6 +344,25 @@ size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
>  }
>  EXPORT_SYMBOL_GPL(dax_copy_to_iter);
>
> +int dax_zero_page_range(struct dax_device *dax_dev, u64 offset, size_t len)
> +{
> +       if (!dax_alive(dax_dev))
> +               return -ENXIO;
> +
> +       if (!dax_dev->ops->zero_page_range)
> +               return -EOPNOTSUPP;

This seems too late to be doing the validation. It would be odd for
random filesystem operations to see this error. I would move the check
to alloc_dax() and fail that if the caller fails to implement the
operation.

An incremental patch on top to fix this up would be ok. Something like
"Now that all dax_operations providers implement zero_page_range()
mandate it at alloc_dax time".
