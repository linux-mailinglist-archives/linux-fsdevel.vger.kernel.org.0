Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9918E3553DA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 14:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343927AbhDFM3o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 08:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344013AbhDFM3d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 08:29:33 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C73AC061756
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Apr 2021 05:29:18 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 12so22292122lfq.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Apr 2021 05:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=57Sd0MjVPJwj9C8CqpwruZwhDWQJmwCtp4DcDbeYrF8=;
        b=NEO1be9H9hw5hBSR23y/A5JCAtyboH9xWrlmgMhhWVhufIwYwiOazGbF2dO0NdwO9a
         J9S3ZAMimrz0dT4/afoTSNsL7yhFFLAM/5RAfwzar2YtiFBrCX0IJQ4eYdF83RQPXqCJ
         Y53J2sO3U9UPgBFY0gMoQy+CHfUdcIsf2Jto3OK3LXjGF4Yhjc14nC1ZTjpBA1Tr1wZG
         DAoX9coVVL/3vi/e50Z3kAcixfdS3Wkh8OcAGfiy9c0ZlsrqxEyfEg/GWfkNjLpWvvVE
         YqfewjWc0nwhmCKNStGOfPLlDg8uax4MQC9GhdDy5R2VEZf1LsoFYjw0GaK+YJBxl1sP
         E9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=57Sd0MjVPJwj9C8CqpwruZwhDWQJmwCtp4DcDbeYrF8=;
        b=EYdpNlnK5SfC4gU6UdyAtSSCZHvv7E13b2VPQ95XGe0NjHSdVPGo4iBpwqzBpd1PoZ
         UtuwuMlVS5XwwbJBA7LsrnIivKud/woe/guSVa/+JrVNZPHUJk65VFUyQlXKGfqzJAeT
         GV1Wlo8gqyUOvNwsFxea7wb8gT4DdnEkGW9Adj5e+/WP4v7i1S333bbQznPF1CwCQIM8
         TfwU/MAioewVPJgB8zxtywccj/XxoMMs/uW1KcSEvwHHTqJq6ReiMmdjbL9idijkzxZ1
         JqBQJo49LM4nyT1BIha19FtHL15RSmIo34gP17PJE8bcqOmnNiO8Vw7g2p+mEMELQpHL
         /BZA==
X-Gm-Message-State: AOAM533xBytt8I4PEmvE8YOoaRxW7tCgDRtTmh8hoHymrQavnQFUxZcw
        HlvgEaB8kiUVHNCzR7pNiHHZUQ==
X-Google-Smtp-Source: ABdhPJwN+7HNNe6vl5shpanay18CZEn+2wHwc1TZiipOq36OoeeDMJquiT51ffeyPvbSUxAjHkldig==
X-Received: by 2002:a19:ee0d:: with SMTP id g13mr21536160lfb.38.1617712156785;
        Tue, 06 Apr 2021 05:29:16 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q7sm2197962lfc.260.2021.04.06.05.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 05:29:16 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 9E879101FF7; Tue,  6 Apr 2021 15:29:18 +0300 (+03)
Date:   Tue, 6 Apr 2021 15:29:18 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 01/27] mm: Introduce struct folio
Message-ID: <20210406122918.h5dsnbjhmwpfasf4@box.shutemov.name>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331184728.1188084-2-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 07:47:02PM +0100, Matthew Wilcox (Oracle) wrote:
> +/**
> + * folio_next - Move to the next physical folio.
> + * @folio: The folio we're currently operating on.
> + *
> + * If you have physically contiguous memory which may span more than
> + * one folio (eg a &struct bio_vec), use this function to move from one
> + * folio to the next.  Do not use it if the memory is only virtually
> + * contiguous as the folios are almost certainly not adjacent to each
> + * other.  This is the folio equivalent to writing ``page++``.
> + *
> + * Context: We assume that the folios are refcounted and/or locked at a
> + * higher level and do not adjust the reference counts.
> + * Return: The next struct folio.
> + */
> +static inline struct folio *folio_next(struct folio *folio)
> +{
> +#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
> +	return (struct folio *)nth_page(&folio->page, folio_nr_pages(folio));
> +#else
> +	return folio + folio_nr_pages(folio);
> +#endif

Do we really need the #if here?

From quick look at nth_page() and memory_model.h, compiler should be able
to simplify calculation for FLATMEM or SPARSEMEM_VMEMMAP to what you do in
the #else. No?

> @@ -224,6 +224,71 @@ struct page {
>  #endif
>  } _struct_page_alignment;
>  
> +/**
> + * struct folio - Represents a contiguous set of bytes.
> + * @flags: Identical to the page flags.
> + * @lru: Least Recently Used list; tracks how recently this folio was used.
> + * @mapping: The file this page belongs to, or refers to the anon_vma for
> + *    anonymous pages.
> + * @index: Offset within the file, in units of pages.  For anonymous pages,
> + *    this is the index from the beginning of the mmap.
> + * @private: Filesystem per-folio data (see attach_folio_private()).
> + *    Used for swp_entry_t if FolioSwapCache().
> + * @_mapcount: How many times this folio is mapped to userspace.  Use
> + *    folio_mapcount() to access it.
> + * @_refcount: Number of references to this folio.  Use folio_ref_count()
> + *    to read it.
> + * @memcg_data: Memory Control Group data.
> + *
> + * A folio is a physically, virtually and logically contiguous set
> + * of bytes.  It is a power-of-two in size, and it is aligned to that
> + * same power-of-two.  It is at least as large as %PAGE_SIZE.  If it is
> + * in the page cache, it is at a file offset which is a multiple of that
> + * power-of-two.
> + */
> +struct folio {
> +	/* private: don't document the anon union */
> +	union {
> +		struct {
> +	/* public: */
> +			unsigned long flags;
> +			struct list_head lru;
> +			struct address_space *mapping;
> +			pgoff_t index;
> +			unsigned long private;
> +			atomic_t _mapcount;
> +			atomic_t _refcount;
> +#ifdef CONFIG_MEMCG
> +			unsigned long memcg_data;
> +#endif

As Christoph, I'm not a fan of this :/

> +	/* private: the union with struct page is transitional */
> +		};
> +		struct page page;
> +	};
> +};

-- 
 Kirill A. Shutemov
