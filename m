Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E2847DFA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 08:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346867AbhLWHkF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 02:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhLWHkD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:40:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53954C061401
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 23:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sq6V6vYu5swJCU5ETFM1PG2L8GKOGu+R/KRXeQOTkLk=; b=u3Y/gtLS8RoNxyrxhgE3MioB/K
        20hS7ujE5C9IVYYfK+DSjEmBei1DEbxNahFnMGdUrV7yW0h5/NhNiCjD43zjOVehkSvlp1/oyFAk1
        HmCKorYobC7gwQDvhKdnbM3G/HqLbV84KpJmBYAzgSEMP2CKmfNUtel3TqewUFKnUIy+eWPuty5Qh
        MRalUpqsapF1qOf63IfwMmkUc+41VqT7hutw4H07S8jJ/8qvDXiuKLawwhVoq/Yek/P6M1SFO2ZTA
        6e3gZQTnW2J1XgpBgxKt7A3uVxW74VWUW6nOmfkH8ffE2zwLjaQPxeQUUvF5Un+Kho6J6/0yJ3pPl
        zYSblYvw==;
Received: from 089144214178.atnat0023.highway.a1.net ([89.144.214.178] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0Ihm-00Bz2T-4F; Thu, 23 Dec 2021 07:40:02 +0000
Date:   Thu, 23 Dec 2021 08:39:59 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 25/48] filemap: Add read_cache_folio and
 read_mapping_folio
Message-ID: <YcQlbjBKzMlGOLI7@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-26-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-26-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> thn makes up for the extra 100 bytes of text added to the various

s/thn/

>  	return read_cache_page(mapping, index, NULL, data);
>  }
>  
> +static inline struct folio *read_mapping_folio(struct address_space *mapping,
> +				pgoff_t index, void *data)
> +{
> +	return read_cache_folio(mapping, index, NULL, data);
> +}

Is there much of a point in this wrapper?

> +static struct page *do_read_cache_page(struct address_space *mapping,
> +		pgoff_t index, filler_t *filler, void *data, gfp_t gfp)
> +{
> +	struct folio *folio = read_cache_folio(mapping, index, filler, data);
> +	if (IS_ERR(folio))
> +		return &folio->page;
> +	return folio_file_page(folio, index);
> +}

This drops the gfp on the floor.
