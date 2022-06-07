Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D967540048
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 15:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244863AbiFGNmH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 09:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242626AbiFGNmF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:42:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11CE9BCE8B
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 06:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654609323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U9GWchY9hZYcIJP7lDw5j1KYfu5h/jhdfCsZWPH40Q8=;
        b=SGwI3oo2udhcgRJgauoltrxTaB33zFqMlPsUaH8WUZz4QPIfAwGwg4PQm17iO6cMEItOsM
        axYMGK9vuHGzqjAgNSzaY2WgqSRWlBsuwmpD94X3OUi80GtTPvkLf0mlT6SB4dZTKdLAHC
        E6M6wjnVELJzqQIovGlU8wuUTz4hh/8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591--nvHW1b-PlOInLByhNsaBQ-1; Tue, 07 Jun 2022 09:42:01 -0400
X-MC-Unique: -nvHW1b-PlOInLByhNsaBQ-1
Received: by mail-qk1-f199.google.com with SMTP id i5-20020a05620a404500b006a6d7a765d9so1515315qko.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jun 2022 06:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U9GWchY9hZYcIJP7lDw5j1KYfu5h/jhdfCsZWPH40Q8=;
        b=BvkPdES/y8G6dAYO7YT5cSWZCHsTGcLpZUC10Z793A9qvr/NEaFBe8GAvLma3CnzHK
         bLAkQo9WySaZUIQwSz3104oda7h3Hc42pylSKNa0olNKR7AiwrMt3W6GONrXQZTAcf+N
         B5UQhyAApPWRmVgSDOUakeJrZ3kyVBXyjzpc7OzOXMAulcfuHW7z7iFm3ydRRVGIcdcV
         YX2t5LjnKMg3MLZpnCQLwxCWwzmiVbgmXV5bXunSgm8g1K0Ptk/3uA6+yBP66NNXb6sW
         NKJ+fQR7uOVnue7wdtKo5/ji8IVLtvauSsknfiIxcaUhR0peldcF4TvaThzdEk/49j8l
         r9Lg==
X-Gm-Message-State: AOAM533ZAKFan3FiQsaC58D+2nCkFBPZW5D+wyiqJxh118dSSuShuTK9
        lddb2lfJeeoWlL+LB6dFV97mtuwC/AoVUS3K2/Id0sYPuST4Ou+2Ix0yyn4uwllxJ4/cDzUmrF1
        MvUJ2+cRFr9i+Fj/e1UHFtmp19Q==
X-Received: by 2002:ac8:5acc:0:b0:304:f75a:4a1d with SMTP id d12-20020ac85acc000000b00304f75a4a1dmr3015558qtd.120.1654609320536;
        Tue, 07 Jun 2022 06:42:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyavNr4YW+NLtrlTYw3DwYvyx9zxVnBrVGsEoQi3F5ODngxQYCXvCvG44n4ArB8DEsaTyYSw==
X-Received: by 2002:ac8:5acc:0:b0:304:f75a:4a1d with SMTP id d12-20020ac85acc000000b00304f75a4a1dmr3015540qtd.120.1654609320271;
        Tue, 07 Jun 2022 06:42:00 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id ay33-20020a05620a17a100b006a6f68c8a87sm148860qkb.126.2022.06.07.06.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 06:41:59 -0700 (PDT)
Date:   Tue, 7 Jun 2022 09:41:57 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ocfs2-devel@oss.oracle.com, linux-mtd@lists.infradead.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 05/20] mm/migrate: Convert expected_page_refs() to
 folio_expected_refs()
Message-ID: <Yp9VpZDsUEAZHEuy@bfoster>
References: <20220606204050.2625949-1-willy@infradead.org>
 <20220606204050.2625949-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606204050.2625949-6-willy@infradead.org>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 06, 2022 at 09:40:35PM +0100, Matthew Wilcox (Oracle) wrote:
> Now that both callers have a folio, convert this function to
> take a folio & rename it.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/migrate.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 77b8c662c9ca..e0a593e5b5f9 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -337,13 +337,18 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
>  }
>  #endif
>  
> -static int expected_page_refs(struct address_space *mapping, struct page *page)
> +static int folio_expected_refs(struct address_space *mapping,
> +		struct folio *folio)
>  {
> -	int expected_count = 1;
> +	int refs = 1;
> +	if (!mapping)
> +		return refs;
>  
> -	if (mapping)
> -		expected_count += compound_nr(page) + page_has_private(page);
> -	return expected_count;
> +	refs += folio_nr_pages(folio);
> +	if (folio_get_private(folio))
> +		refs++;

Why not folio_has_private() (as seems to be used for later
page_has_private() conversions) here?

> +
> +	return refs;;

Nit: extra ;

Brian

>  }
>  
>  /*
> @@ -360,7 +365,7 @@ int folio_migrate_mapping(struct address_space *mapping,
>  	XA_STATE(xas, &mapping->i_pages, folio_index(folio));
>  	struct zone *oldzone, *newzone;
>  	int dirty;
> -	int expected_count = expected_page_refs(mapping, &folio->page) + extra_count;
> +	int expected_count = folio_expected_refs(mapping, folio) + extra_count;
>  	long nr = folio_nr_pages(folio);
>  
>  	if (!mapping) {
> @@ -670,7 +675,7 @@ static int __buffer_migrate_folio(struct address_space *mapping,
>  		return migrate_page(mapping, &dst->page, &src->page, mode);
>  
>  	/* Check whether page does not have extra refs before we do more work */
> -	expected_count = expected_page_refs(mapping, &src->page);
> +	expected_count = folio_expected_refs(mapping, src);
>  	if (folio_ref_count(src) != expected_count)
>  		return -EAGAIN;
>  
> -- 
> 2.35.1
> 
> 

