Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD35347E095
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 09:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242821AbhLWInb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 03:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbhLWIna (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:43:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E69C061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 00:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Fp5M5CEKx8pvvCV8c/3yZIVNBpElDuSofO8HVx8sbLs=; b=knsQMCrQ6E7dqbuANuv/2+akq5
        X8nYh3bnI2L/sVNAMSQ4pjiwmxlS4ZRC9qK/kPA2JQws1qfRD/WyQt6rlCdjLEyUX3vaLCtrIQcpp
        3+HA28W1NSckX4tbb3ouZCihgURrpg9sP+Ips3F6trGTqDB0XX8En8drEQTjMfiK/TktQXh7zie5Z
        TinVpyq8fj0r7NgE/KghSZzuSlfT+lWBOjpM5Se95MlT75HkB9AmWkP6+n2dyGpsEeGM9T+GCnetI
        bDW8sbwT/De2kNHEyo7DhRPtdwyGJJl1mP7ups5BKa92BNpOoAOPWlnE7ZiUzPdG1yKvj6gJsaCqU
        rG3Ws4tA==;
Received: from [46.183.103.8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0JhB-00CKCJ-4l; Thu, 23 Dec 2021 08:43:29 +0000
Date:   Thu, 23 Dec 2021 09:43:27 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH 46/48] truncate,shmem: Handle truncates that split large
 folios
Message-ID: <YcQ2rzfaecRChgKm@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-47-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-47-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	partial_end = ((lend + 1) % PAGE_SIZE) > 0;

The > 0 reads a little odd as we can never get a negative value here.

> +	shmem_get_folio(inode, lstart >> PAGE_SHIFT, &folio, SGP_READ);
> +	if (folio) {
> +		bool same_page;
> +
> +		same_page = lend < folio_pos(folio) + folio_size(folio);
> +		if (same_page)
> +			partial_end = false;
> +		folio_mark_dirty(folio);
> +		if (!truncate_inode_partial_folio(folio, lstart, lend)) {
> +			start = folio->index + folio_nr_pages(folio);
> +			if (same_page)
> +				end = folio->index;
>  		}
> +		folio_unlock(folio);
> +		folio_put(folio);
> +		folio = NULL;

The entire logic after the shmem_get_folio call is duplicated in
truncate_inode_pages_range.  Shouldn't we ty to combine that by moving it
into a helper?

If we can't merge it I think same_page shoud be renamed to same_folio as in
truncate_inode_pages_range.

>  	pgoff_t		start;		/* inclusive */
>  	pgoff_t		end;		/* exclusive */
> -	unsigned int	partial_start;	/* inclusive */
> -	unsigned int	partial_end;	/* exclusive */
>  	struct folio_batch fbatch;
>  	pgoff_t		indices[PAGEVEC_SIZE];
>  	pgoff_t		index;
>  	int		i;
> +	struct folio *	folio;

Weird indentation after the star.

> +	bool partial_end;

And the style here in general does not seem to match the existing code.
