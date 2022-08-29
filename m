Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9690C5A4B9D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 14:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbiH2MY5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 08:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiH2MYc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:24:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FF3915EC
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 05:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661774876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xvRlmqs214Dpgefm9SAxkwz6k6CnKHpZ0dlz408l89w=;
        b=MnYWh0iTijYG8gktzzxr5ACnR8os9vvoHWNMrgvPIgN0UNT1LJezzaeKIEE9SZ1zs5G+B+
        srY1bt7GnCWZ8ZSf50J0DQ3clQ4TlWYo4VLMMgl4O7N7WN055rQTXIeA/AgZJCJNMdAsBn
        9A8alDvVjTe4CVXi5VdG30BlDY/PEzU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-163-gqetRo9CN2yyo6xnlDHsuw-1; Mon, 29 Aug 2022 08:07:55 -0400
X-MC-Unique: gqetRo9CN2yyo6xnlDHsuw-1
Received: by mail-wm1-f72.google.com with SMTP id h133-20020a1c218b000000b003a5fa79008bso8365830wmh.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 05:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=xvRlmqs214Dpgefm9SAxkwz6k6CnKHpZ0dlz408l89w=;
        b=fsBmOv76yv5Ct/Qgg6/IDrjGZfxN0g2Xm7tGcbk1OH7R2awps7iy5AQC9YH7hupA0R
         RtDmH5olppDOnVMZPwmUrJFukehVvYxPzgITq0p7Lrajg2e+YYSUuS6L0TCbcyTZCrGT
         fWdJIiuPztjr02gJwED0EEjCl2SN2A9R4eV08vRRYa1zg8jA4yPedQ7oKYN6UCazd8ai
         HHuKWVEmngEC5nnw46ZY5zA7GQiV/rCkiPZtg+0S84UXVnUGnQm9KJF7PbycTGGK/gsw
         +8gJcFrY/tXqOa7fpJdjcIDpmM79GB7ahbC2ZRw+oMM5WhI1fkZoXWe7pMdzL3UHw+rp
         KFnA==
X-Gm-Message-State: ACgBeo39z29GeaAh4/GCqbn84jnXuM/GsAAfEpt3QgDWtKh/poVcQg4v
        ih6yiNYujDL/00/tbWHmogJybEoYk2hqiGpsK37z5fBh/0AWr2hNhVpAPgdv2Wi2Lw6YH0/sqbT
        kqg7u5y19lQ13Qafxu504B4uu5g==
X-Received: by 2002:a5d:68c9:0:b0:225:330b:2d0 with SMTP id p9-20020a5d68c9000000b00225330b02d0mr5809295wrw.243.1661774873806;
        Mon, 29 Aug 2022 05:07:53 -0700 (PDT)
X-Google-Smtp-Source: AA6agR40B6aIc3Kd7HqO+pm6F4fpndLD4ybKX0vv6qIxnrSvSPYic+blNQ9JwBkZ3/6303cVEkP7JA==
X-Received: by 2002:a5d:68c9:0:b0:225:330b:2d0 with SMTP id p9-20020a5d68c9000000b00225330b02d0mr5809271wrw.243.1661774873476;
        Mon, 29 Aug 2022 05:07:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3900:658b:bed0:4260:4c25? (p200300cbc7073900658bbed042604c25.dip0.t-ipconnect.de. [2003:cb:c707:3900:658b:bed0:4260:4c25])
        by smtp.gmail.com with ESMTPSA id f17-20020adfdb51000000b002252cb35184sm6771976wrj.25.2022.08.29.05.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 05:07:53 -0700 (PDT)
Message-ID: <10a9d33a-58a3-10b3-690b-53100d4e5440@redhat.com>
Date:   Mon, 29 Aug 2022 14:07:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/6] mm/gup: introduce pin_user_page()
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
References: <20220827083607.2345453-1-jhubbard@nvidia.com>
 <20220827083607.2345453-2-jhubbard@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220827083607.2345453-2-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 27.08.22 10:36, John Hubbard wrote:
> pin_user_page() is an externally-usable version of try_grab_page(), but
> with semantics that match get_page(), so that it can act as a drop-in
> replacement for get_page(). Specifically, pin_user_page() has a void
> return type.
> 
> pin_user_page() elevates a page's refcount using FOLL_PIN rules. This
> means that the caller must release the page via unpin_user_page().
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/linux/mm.h |  1 +
>  mm/gup.c           | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 982f2607180b..85a105157334 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1869,6 +1869,7 @@ long pin_user_pages_remote(struct mm_struct *mm,
>  long get_user_pages(unsigned long start, unsigned long nr_pages,
>  			    unsigned int gup_flags, struct page **pages,
>  			    struct vm_area_struct **vmas);
> +void pin_user_page(struct page *page);
>  long pin_user_pages(unsigned long start, unsigned long nr_pages,
>  		    unsigned int gup_flags, struct page **pages,
>  		    struct vm_area_struct **vmas);
> diff --git a/mm/gup.c b/mm/gup.c
> index 5abdaf487460..245ccb41ed8c 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -3213,6 +3213,39 @@ long pin_user_pages(unsigned long start, unsigned long nr_pages,
>  }
>  EXPORT_SYMBOL(pin_user_pages);
>  
> +/**
> + * pin_user_page() - apply a FOLL_PIN reference to a page
> + *
> + * @page: the page to be pinned.
> + *
> + * This is similar to get_user_pages(), except that the page's refcount is
> + * elevated using FOLL_PIN, instead of FOLL_GET.
> + *
> + * IMPORTANT: The caller must release the page via unpin_user_page().
> + *
> + */
> +void pin_user_page(struct page *page)
> +{
> +	struct folio *folio = page_folio(page);
> +
> +	WARN_ON_ONCE(folio_ref_count(folio) <= 0);
> +

We should warn if the page is anon and !exclusive.

I assume the intend is to use pin_user_page() only to duplicate pins, right?


-- 
Thanks,

David / dhildenb

