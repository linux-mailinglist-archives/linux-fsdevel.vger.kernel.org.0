Return-Path: <linux-fsdevel+bounces-43520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B9DA57CA3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 19:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB991892F64
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 18:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6321E8325;
	Sat,  8 Mar 2025 18:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaczmgbF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D13C196;
	Sat,  8 Mar 2025 18:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741457645; cv=none; b=QUoszMBY4DqRVALNp1/22qZGbeRCOz08Mw4SQVixQvG9MryxbLSacw32MVQSq4iD0yuG33ZPPXxdpnhinooQNEdI9LFbNeEr2GbpDzaYGNfNf0Adt39X8SsZvMgVYyrCEDCdQrpebPx8spJSXainDqjQlgzhVAhQiKf6f3d1XyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741457645; c=relaxed/simple;
	bh=/DztjNlgTwuVOyV43hgm+/GQtxBZDAlcw654hm2YE5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qnQ+Gz51NsUF2TnbD+AcgJj0kXKtXJnOB7AtIHzrBGVY4d30Q8FzKN9vTrC/Ly8+kzlGUdDD5LprFzkMBRHINhffTNKBnHS5WoQFiydagyphWCPEjvBBWx83cFO+ch+p4Cr9mUp0fKjQ2Oy+nisU5f+cmuO/IZ2tJXAv9uVYkH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaczmgbF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C789C4CEE0;
	Sat,  8 Mar 2025 18:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741457644;
	bh=/DztjNlgTwuVOyV43hgm+/GQtxBZDAlcw654hm2YE5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eaczmgbFwScBH4+O9vOHrmVBUaSICMoLMaXdTFJk2xBze9yDs9GB2xea5i8XLaIMi
	 A29V4tq0rL9BL9kiXdrirtOkDhuFTSsc7k0xK0zwoJZ+6ph6r6tCwhT1LkYl/XN1Sp
	 8Q35ZCFpIl/0O1mC1B0TMo4zA6mRhHEEfm3G26nm+nv0vhgyunR9X79lctzU9++u8Q
	 iKlnygEq5P0y1y26dxLBDb9UDJUrUPmZUJs9vnATJ7FR88yDk6mbYYCvxmFCrP6cBl
	 guHOicAuDTmLH8pR2DXZ9Z828qziEk3K5IrduFp6DGtO3oiDNcBNVbJ9XfsvVGF+FD
	 2eboWApInBghg==
From: SeongJae Park <sj@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: SeongJae Park <sj@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Kairui Song <kasong@tencent.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	linux-kernel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	"Kirill A. Shuemov" <kirill.shutemov@linux.intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v3 1/2] mm/filemap: use xas_try_split() in __filemap_add_folio()
Date: Sat,  8 Mar 2025 10:14:02 -0800
Message-Id: <20250308181402.95667-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226210854.2045816-2-ziy@nvidia.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On Wed, 26 Feb 2025 16:08:53 -0500 Zi Yan <ziy@nvidia.com> wrote:

> During __filemap_add_folio(), a shadow entry is covering n slots and a
> folio covers m slots with m < n is to be added.  Instead of splitting all
> n slots, only the m slots covered by the folio need to be split and the
> remaining n-m shadow entries can be retained with orders ranging from m to
> n-1.  This method only requires
> 
> 	(n/XA_CHUNK_SHIFT) - (m/XA_CHUNK_SHIFT)
> 
> new xa_nodes instead of
> 	(n % XA_CHUNK_SHIFT) * ((n/XA_CHUNK_SHIFT) - (m/XA_CHUNK_SHIFT))
> 
> new xa_nodes, compared to the original xas_split_alloc() + xas_split()
> one.  For example, to insert an order-0 folio when an order-9 shadow entry
> is present (assuming XA_CHUNK_SHIFT is 6), 1 xa_node is needed instead of
> 8.
> 
> xas_try_split_min_order() is introduced to reduce the number of calls to
> xas_try_split() during split.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Mattew Wilcox <willy@infradead.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Kirill A. Shuemov <kirill.shutemov@linux.intel.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Yang Shi <yang@os.amperecomputing.com>
> Cc: Yu Zhao <yuzhao@google.com>
> ---
>  include/linux/xarray.h |  7 +++++++
>  lib/xarray.c           | 25 +++++++++++++++++++++++
>  mm/filemap.c           | 45 +++++++++++++++++-------------------------
>  3 files changed, 50 insertions(+), 27 deletions(-)
> 
> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
> index 4010195201c9..78eede109b1a 100644
> --- a/include/linux/xarray.h
> +++ b/include/linux/xarray.h
> @@ -1556,6 +1556,7 @@ int xas_get_order(struct xa_state *xas);
>  void xas_split(struct xa_state *, void *entry, unsigned int order);
>  void xas_split_alloc(struct xa_state *, void *entry, unsigned int order, gfp_t);
>  void xas_try_split(struct xa_state *xas, void *entry, unsigned int order);
> +unsigned int xas_try_split_min_order(unsigned int order);
>  #else
>  static inline int xa_get_order(struct xarray *xa, unsigned long index)
>  {
> @@ -1582,6 +1583,12 @@ static inline void xas_try_split(struct xa_state *xas, void *entry,
>  		unsigned int order)
>  {
>  }
> +
> +static inline unsigned int xas_try_split_min_order(unsigned int order)
> +{
> +	return 0;
> +}
> +
>  #endif
>  
>  /**
> diff --git a/lib/xarray.c b/lib/xarray.c
> index bc197c96d171..8067182d3e43 100644
> --- a/lib/xarray.c
> +++ b/lib/xarray.c
> @@ -1133,6 +1133,28 @@ void xas_split(struct xa_state *xas, void *entry, unsigned int order)
>  }
>  EXPORT_SYMBOL_GPL(xas_split);
>  
> +/**
> + * xas_try_split_min_order() - Minimal split order xas_try_split() can accept
> + * @order: Current entry order.
> + *
> + * xas_try_split() can split a multi-index entry to smaller than @order - 1 if
> + * no new xa_node is needed. This function provides the minimal order
> + * xas_try_split() supports.
> + *
> + * Return: the minimal order xas_try_split() supports
> + *
> + * Context: Any context.
> + *
> + */
> +unsigned int xas_try_split_min_order(unsigned int order)
> +{
> +	if (order % XA_CHUNK_SHIFT == 0)
> +		return order == 0 ? 0 : order - 1;
> +
> +	return order - (order % XA_CHUNK_SHIFT);
> +}
> +EXPORT_SYMBOL_GPL(xas_try_split_min_order);
> +

I found this makes build fails when CONFIG_XARRAY_MULTI is unset, like below.

    /linux/lib/xarray.c:1251:14: error: redefinition of ‘xas_try_split_min_order’
     1251 | unsigned int xas_try_split_min_order(unsigned int order)
          |              ^~~~~~~~~~~~~~~~~~~~~~~
    In file included from /linux/lib/xarray.c:13:
    /linux/include/linux/xarray.h:1587:28: note: previous definition of ‘xas_try_split_min_order’ with type ‘unsigned int(unsigned int)’
     1587 | static inline unsigned int xas_try_split_min_order(unsigned int order)
          |                            ^~~~~~~~~~~~~~~~~~~~~~~

I think we should have the definition only when CONFIG_XARRAY_MULTI?


Thanks,
SJ

[...]

