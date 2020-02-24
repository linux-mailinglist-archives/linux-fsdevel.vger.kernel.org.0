Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA0D16B2B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 22:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgBXVgm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 16:36:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60882 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbgBXVgm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mFwk7Ogzw1DwSroExaLsOAPWW4X5SCgwVYe/ydMONuc=; b=h/ro7KECScPGoDcA++S4qIfmW4
        a06F8eE7BeOWkVDTLANRFPSvwkLapVgJFqt2VXCcOLFMLb/IVkdpgWIewAjZwrmoXoLgiQWSG9Zty
        UOQzMrCaYm6q5rbwkHC0Ctve2q580OSV2Oy4PszFr17DCrDQhwfT/4C+JU/PKFZsFq6SqQp9tCg+g
        acEByWoYRjIwj8O0VsmpyloGmy5L4TaJDe+GO7Y7wN9a8IZc2Z/AgJajdXqjL1+CPTF2F1h+Z6qwh
        d7Lt1pwr7q//pc6zqqg9O/LFXziK/pHi+Sp1b494SmXhpNH92hlDYT7pk0T0Rb9hF8+rxMxWmvnsf
        KMVQIFBQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6LP7-0005et-TQ; Mon, 24 Feb 2020 21:36:41 +0000
Date:   Mon, 24 Feb 2020 13:36:41 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v7 05/24] mm: Use readahead_control to pass arguments
Message-ID: <20200224213641.GD13895@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219210103.32400-6-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 19, 2020 at 01:00:44PM -0800, Matthew Wilcox wrote:
> @@ -160,9 +164,13 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  	unsigned long end_index;	/* The last page we want to read */
>  	LIST_HEAD(page_pool);
>  	int page_idx;
> -	unsigned int nr_pages = 0;
>  	loff_t isize = i_size_read(inode);
>  	gfp_t gfp_mask = readahead_gfp_mask(mapping);
> +	struct readahead_control rac = {
> +		.mapping = mapping,
> +		.file = filp,
> +		._nr_pages = 0,

There is no real need to initialize fields to zero if we initialize
the structure at all.  And while I'd normally not care that much,
having as few references as possible to the _-prefixed internal
variables helps making clear how internal they are.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
