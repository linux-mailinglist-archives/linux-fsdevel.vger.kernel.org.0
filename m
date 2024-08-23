Return-Path: <linux-fsdevel+bounces-26910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 152A295CD46
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 15:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6966BB22B47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 13:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B69186601;
	Fri, 23 Aug 2024 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QEV9dqCm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145531865E6
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 13:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724418593; cv=none; b=K3wZOpUJssbl5sRaBUQQXN+X5s6NmCDoLZJ3hv4BxlwarbT5KRiSlLVbBRkGUb0HRUido/iamBxfdSUiC+020D0VoHvfNmRMw/MUem2YVbXdencSDZHNECxdbzCA+pOtrEXpjaXHkKy980hI7vfIMSDomU8bFok5pdEBrrS6QVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724418593; c=relaxed/simple;
	bh=AMj5NIlUqezap8V4tsjrA8vrQLUZNKX+mQ/wekmUFS4=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=LYceiyEX4efQBtq2EIhio3+dV2YmYTGYCblNPBcLci8D+o/Z+c2kixRggz5O0V1px2scE2onQMHHaL4hJ/qKjltM1A3yilAvMfwyqaJQroJR2MWx3RrCDiT1zhWktI+wHRmI0BD8PXZrO6Mo3F1ilKMH7CWAJk+sL+1/WgmPNDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QEV9dqCm; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240823130942euoutp0178a3685fdd95be9613e5e858a5ce22e2~uXZCBJ9_i1249912499euoutp01u
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 13:09:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240823130942euoutp0178a3685fdd95be9613e5e858a5ce22e2~uXZCBJ9_i1249912499euoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724418582;
	bh=E3NMDe9bEH+iM4pov0tkQBVKEmJvg4rW6rvtLKSDCNY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=QEV9dqCmvmK9SBZqu4W51x97iZpJAIxC/DFR69+75Ya7J5MLecKQXDsfr0Pr8EejR
	 s2L34M3zOmtGzLp2jaiPTDRtLUEfmyEUb3GUXjayPAsNxIiY99iTSGZidQnb2a2jC8
	 Qse3iO5T3QwdmhhfZf7miB/5h/9vQ/pnq+iJseVo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240823130942eucas1p2c9bb8b56fba3717f1382f10a0d955ace~uXZBqC5BF0543105431eucas1p2a;
	Fri, 23 Aug 2024 13:09:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id B2.E6.09624.51A88C66; Fri, 23
	Aug 2024 14:09:41 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240823130941eucas1p211f1eca1ac176fd4f6125b922be75d58~uXZBF-4uR0142101421eucas1p2l;
	Fri, 23 Aug 2024 13:09:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240823130941eusmtrp233cfdc9454a2911f47c20e482e5f2f25~uXZBFOW3i1532015320eusmtrp2d;
	Fri, 23 Aug 2024 13:09:41 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-2b-66c88a151f45
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id C2.0E.08810.51A88C66; Fri, 23
	Aug 2024 14:09:41 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240823130941eusmtip1d3289339abdf907dac3a3090de28c3e0~uXZAzOT901901219012eusmtip1D;
	Fri, 23 Aug 2024 13:09:41 +0000 (GMT)
Received: from localhost (106.110.32.87) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 23 Aug 2024 14:09:41 +0100
Date: Fri, 23 Aug 2024 15:09:40 +0200
From: Daniel Gomez <da.gomez@samsung.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
CC: <brauner@kernel.org>, <akpm@linux-foundation.org>,
	<chandan.babu@oracle.com>, <linux-fsdevel@vger.kernel.org>,
	<djwong@kernel.org>, <hare@suse.de>, <gost.dev@samsung.com>,
	<linux-xfs@vger.kernel.org>, <hch@lst.de>, <david@fromorbit.com>, Zi Yan
	<ziy@nvidia.com>, <yang@os.amperecomputing.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <willy@infradead.org>,
	<john.g.garry@oracle.com>, <cl@os.amperecomputing.com>,
	<p.raghav@samsung.com>, <mcgrof@kernel.org>, <ryan.roberts@arm.com>, "David
 Howells" <dhowells@redhat.com>
Subject: Re: [PATCH v13 01/10] fs: Allow fine-grained control of folio sizes
Message-ID: <20240823130940.kmy3lccaenuxksxt@AALNPWDAGOMEZ1.aal.scsc.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240822135018.1931258-2-kernel@pankajraghav.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7djP87qiXSfSDD5NsbKYs34Nm8Xrw58Y
	LS4dlbNYt/Yhk8WWY/cYLd41/WaxuPyEz2LPoklMFitXH2WyuPBrB6PFmZefWSz27D0JlNw1
	h83i3pr/rBa7/uxgt7gx4SmjRc/uqYwWv38AJXqXnGS3mH30HruDiMeaeWsYPU4tkvDYvELL
	Y9OqTjaPTZ8msXucmPGbxWP3zQY2j97md2weH5/eYvHovnyD3ePsSkeP9/uusnlsPl3t8XmT
	XABfFJdNSmpOZllqkb5dAlfG5O/72QomuVXsenCcvYFxtWUXIyeHhICJxNNvP5i6GLk4hARW
	MEp8v/qBDcL5wiixpOMCM4TzmVFi8objLDAtH6a2Q1UtZ5S4ceYgG1zVjJYWJpAqIYHNjBIv
	ej1AbBYBVYkvZ7uYQWw2AU2JfSc3sYPYIgLmEstmvmAEsZkFVrJInNiZCWILC/hI7F58CKyG
	V8Bb4uCSlVC2oMTJmU9YIOp1JBbs/gS0mAPIlpZY/o8DJMwpYC8xrfs5O8ShihIzJq6EOrpW
	4tSWW2B/Sgj84pR4/PgKI0ivhICLRMNzB4gaYYlXx7dA9cpI/N85nwnCTpdYsm4W1JwCiT23
	Z7FCtFpL9J3JgQg7Sqz5fJ8JIswnceOtIMSRfBKTtk1nhgjzSnS0CUFUq0msvveGZQKj8iwk
	b81C8tYshLcWMDKvYhRPLS3OTU8tNsxLLdcrTswtLs1L10vOz93ECEybp/8d/7SDce6rj3qH
	GJk4GA8xSnAwK4nwJt07mibEm5JYWZValB9fVJqTWnyIUZqDRUmcVzVFPlVIID2xJDU7NbUg
	tQgmy8TBKdXAxB/a7W7l5fdpYWzmznaOyreXUy34a3N85P9OLTrW69lzr+bmkYtSjHanVAyr
	frzgnTJPvNF54j79qrUbdrLF/z476YtVy3QpyYtnnH+8lF8fLjk/evqBm7fi9m+unH/lwEMu
	h/cviuLks8UP7Es4tnF/SY0j06aVctbfDy0/ZbWUaZK0X+Whr33trOmamTznJu0Sv7nne2Cu
	T0zsjpl+rz4euxXtyM3LLfx87ZK1HEttvnWJXPnGWbDk2nev2H2Vel4ix/UOHBX07pHcpRuV
	6rjzR6GS7wbb0+9NT9VVq9dqVyrN/3cgiuG+wu3ZayN0DBe0ZJ15evbR6smb8gUZ7EwzrSYf
	LHP4ID1NP6GeV4mlOCPRUIu5qDgRAA9Tgd8KBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsVy+t/xu7qiXSfSDE5sFrOYs34Nm8Xrw58Y
	LS4dlbNYt/Yhk8WWY/cYLd41/WaxuPyEz2LPoklMFitXH2WyuPBrB6PFmZefWSz27D0JlNw1
	h83i3pr/rBa7/uxgt7gx4SmjRc/uqYwWv38AJXqXnGS3mH30HruDiMeaeWsYPU4tkvDYvELL
	Y9OqTjaPTZ8msXucmPGbxWP3zQY2j97md2weH5/eYvHovnyD3ePsSkeP9/uusnlsPl3t8XmT
	XABflJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G
	5O/72QomuVXsenCcvYFxtWUXIyeHhICJxIep7WxdjFwcQgJLGSVubj7KDJGQkdj45SorhC0s
	8edaF1TRR0aJdzOmM0M4mxklVr2/AFbFIqAq8eVsF1g3m4CmxL6Tm9hBbBEBc4llM18wgtjM
	AitZJE7szASxhQV8JHYvPgRWwyvgLXFwyUp2iKHHGSVWX/jJDJEQlDg58wkLRLOOxILdn4DO
	4ACypSWW/+MACXMK2EtM637ODnGposSMiStZIOxaic9/nzFOYBSehWTSLCSTZiFMWsDIvIpR
	JLW0ODc9t9hQrzgxt7g0L10vOT93EyMwiWw79nPzDsZ5rz7qHWJk4mA8xCjBwawkwpt072ia
	EG9KYmVValF+fFFpTmrxIUZTYFBMZJYSTc4HprG8knhDMwNTQxMzSwNTSzNjJXFez4KORCGB
	9MSS1OzU1ILUIpg+Jg5OqQYmFtNPARZFh2ztHngYCsxskp99annyM8nfSy1PZV0/X+mVfvlg
	sbXqyY0PNrPlhfBZKZeeKch63rqxRu2Rzvs1Xiv/3vrAWPLg/9+JYoWrZvev2+K7VVi7vCb6
	ohF/u5bhUq8HZbzm3iqXgyKyXwWGxK1bZn7DfteDi2vWnE+KtHRWeLBR/qXFm9abXtVhV27Y
	b3z14K3l3r0f3jPI8pjrTf06c7Wflknwn/4NSlbvPKZtPW4blriukuProinJcyezLVd4v1v4
	84ruIBs9m4BM3oOir05V/fzT67zmnFl20b6vXz7uvRiulv0wTHfFtp1Gt2dH53Bzq8jEWCgk
	e184J7QsbN9Ttns/jvY+rfg1W4mlOCPRUIu5qDgRAGer65mrAwAA
X-CMS-MailID: 20240823130941eucas1p211f1eca1ac176fd4f6125b922be75d58
X-Msg-Generator: CA
X-RootMTR: 20240822135043eucas1p29a434e2217a0f0790c67c312e302a9df
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240822135043eucas1p29a434e2217a0f0790c67c312e302a9df
References: <20240822135018.1931258-1-kernel@pankajraghav.com>
	<CGME20240822135043eucas1p29a434e2217a0f0790c67c312e302a9df@eucas1p2.samsung.com>
	<20240822135018.1931258-2-kernel@pankajraghav.com>

On Thu, Aug 22, 2024 at 03:50:09PM +0200, Pankaj Raghav (Samsung) wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> We need filesystems to be able to communicate acceptable folio sizes
> to the pagecache for a variety of uses (e.g. large block sizes).
> Support a range of folio sizes between order-0 and order-31.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Co-developed-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Tested-by: David Howells <dhowells@redhat.com>
> ---
>  include/linux/pagemap.h | 90 ++++++++++++++++++++++++++++++++++-------
>  mm/filemap.c            |  6 +--
>  mm/readahead.c          |  4 +-
>  3 files changed, 80 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index d9c7edb6422bd..c60025bb584c5 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -204,14 +204,21 @@ enum mapping_flags {
>  	AS_EXITING	= 4, 	/* final truncate in progress */
>  	/* writeback related tags are not used */
>  	AS_NO_WRITEBACK_TAGS = 5,
> -	AS_LARGE_FOLIO_SUPPORT = 6,
> -	AS_RELEASE_ALWAYS,	/* Call ->release_folio(), even if no private data */
> -	AS_STABLE_WRITES,	/* must wait for writeback before modifying
> +	AS_RELEASE_ALWAYS = 6,	/* Call ->release_folio(), even if no private data */
> +	AS_STABLE_WRITES = 7,	/* must wait for writeback before modifying
>  				   folio contents */
> -	AS_INACCESSIBLE,	/* Do not attempt direct R/W access to the mapping,
> -				   including to move the mapping */
> +	AS_INACCESSIBLE = 8,	/* Do not attempt direct R/W access to the mapping */
> +	/* Bits 16-25 are used for FOLIO_ORDER */
> +	AS_FOLIO_ORDER_BITS = 5,
> +	AS_FOLIO_ORDER_MIN = 16,
> +	AS_FOLIO_ORDER_MAX = AS_FOLIO_ORDER_MIN + AS_FOLIO_ORDER_BITS,
>  };
>  
> +#define AS_FOLIO_ORDER_BITS_MASK ((1u << AS_FOLIO_ORDER_BITS) - 1)
> +#define AS_FOLIO_ORDER_MIN_MASK (AS_FOLIO_ORDER_BITS_MASK << AS_FOLIO_ORDER_MIN)
> +#define AS_FOLIO_ORDER_MAX_MASK (AS_FOLIO_ORDER_BITS_MASK << AS_FOLIO_ORDER_MAX)
> +#define AS_FOLIO_ORDER_MASK (AS_FOLIO_ORDER_MIN_MASK | AS_FOLIO_ORDER_MAX_MASK)
> +
>  /**
>   * mapping_set_error - record a writeback error in the address_space
>   * @mapping: the mapping in which an error should be set
> @@ -367,9 +374,51 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
>  #define MAX_XAS_ORDER		(XA_CHUNK_SHIFT * 2 - 1)
>  #define MAX_PAGECACHE_ORDER	min(MAX_XAS_ORDER, PREFERRED_MAX_PAGECACHE_ORDER)
>  
> +/*
> + * mapping_set_folio_order_range() - Set the orders supported by a file.
> + * @mapping: The address space of the file.
> + * @min: Minimum folio order (between 0-MAX_PAGECACHE_ORDER inclusive).
> + * @max: Maximum folio order (between @min-MAX_PAGECACHE_ORDER inclusive).
> + *
> + * The filesystem should call this function in its inode constructor to
> + * indicate which base size (min) and maximum size (max) of folio the VFS
> + * can use to cache the contents of the file.  This should only be used
> + * if the filesystem needs special handling of folio sizes (ie there is
> + * something the core cannot know).
> + * Do not tune it based on, eg, i_size.
> + *
> + * Context: This should not be called while the inode is active as it
> + * is non-atomic.
> + */
> +static inline void mapping_set_folio_order_range(struct address_space *mapping,
> +						 unsigned int min,
> +						 unsigned int max)
> +{
> +	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> +		return;
> +
> +	if (min > MAX_PAGECACHE_ORDER)
> +		min = MAX_PAGECACHE_ORDER;
> +
> +	if (max > MAX_PAGECACHE_ORDER)
> +		max = MAX_PAGECACHE_ORDER;
> +
> +	if (max < min)
> +		max = min;
> +
> +	mapping->flags = (mapping->flags & ~AS_FOLIO_ORDER_MASK) |
> +		(min << AS_FOLIO_ORDER_MIN) | (max << AS_FOLIO_ORDER_MAX);

This is my test case to be sure we don't overwrite flags:

Before:
AS_FOLIO_ORDER_MASK=0x1f
AS_FOLIO_ORDER_MIN_MASK=0x1f0000
AS_FOLIO_ORDER_MAX_MASK=0x3e00000

v13:
AS_FOLIO_ORDER_BITS_MASK=0x1f
AS_FOLIO_ORDER_MASK=0x3ff0000
AS_FOLIO_ORDER_MIN_MASK=0x1f0000
AS_FOLIO_ORDER_MAX_MASK=0x3e00000
Test result for min=0, expected: min=0
Test result for min=0, expected: min=0
Test result for min=5, expected: min=5
Test result for min=10, expected: min=10
Test result for min=31, expected: min=31
Test result for min=31, expected: min=31
Test result for min=12, expected: min=12
Test result for min=20, expected: min=20
Test result for min=7, expected: min=7
Test result for min=14, expected: min=14

The test checks for flags in mapping_set_folio_order_range() and iterates over a
list of test cases:
	flags = 0xffffffff
	_flags = flags & ~(AS_FOLIO_ORDER_MASK)
	newflags = _flags | (min_val << AS_FOLIO_ORDER_MIN) | (max_val << AS_FOLIO_ORDER_MAX)


Reviewed-by: Daniel Gomez <da.gomez@samsung.com>

> +}
> +
> +static inline void mapping_set_folio_min_order(struct address_space *mapping,
> +					       unsigned int min)
> +{
> +	mapping_set_folio_order_range(mapping, min, MAX_PAGECACHE_ORDER);
> +}
> +
>  /**
>   * mapping_set_large_folios() - Indicate the file supports large folios.
> - * @mapping: The file.
> + * @mapping: The address space of the file.
>   *
>   * The filesystem should call this function in its inode constructor to
>   * indicate that the VFS can use large folios to cache the contents of
> @@ -380,7 +429,23 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
>   */
>  static inline void mapping_set_large_folios(struct address_space *mapping)
>  {
> -	__set_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
> +	mapping_set_folio_order_range(mapping, 0, MAX_PAGECACHE_ORDER);
> +}
> +
> +static inline unsigned int
> +mapping_max_folio_order(const struct address_space *mapping)
> +{
> +	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> +		return 0;
> +	return (mapping->flags & AS_FOLIO_ORDER_MAX_MASK) >> AS_FOLIO_ORDER_MAX;
> +}
> +
> +static inline unsigned int
> +mapping_min_folio_order(const struct address_space *mapping)
> +{
> +	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> +		return 0;
> +	return (mapping->flags & AS_FOLIO_ORDER_MIN_MASK) >> AS_FOLIO_ORDER_MIN;
>  }
>  
>  /*
> @@ -389,20 +454,17 @@ static inline void mapping_set_large_folios(struct address_space *mapping)
>   */
>  static inline bool mapping_large_folio_support(struct address_space *mapping)
>  {
> -	/* AS_LARGE_FOLIO_SUPPORT is only reasonable for pagecache folios */
> +	/* AS_FOLIO_ORDER is only reasonable for pagecache folios */
>  	VM_WARN_ONCE((unsigned long)mapping & PAGE_MAPPING_ANON,
>  			"Anonymous mapping always supports large folio");
>  
> -	return IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> -		test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
> +	return mapping_max_folio_order(mapping) > 0;
>  }
>  
>  /* Return the maximum folio size for this pagecache mapping, in bytes. */
> -static inline size_t mapping_max_folio_size(struct address_space *mapping)
> +static inline size_t mapping_max_folio_size(const struct address_space *mapping)
>  {
> -	if (mapping_large_folio_support(mapping))
> -		return PAGE_SIZE << MAX_PAGECACHE_ORDER;
> -	return PAGE_SIZE;
> +	return PAGE_SIZE << mapping_max_folio_order(mapping);
>  }
>  
>  static inline int filemap_nr_thps(struct address_space *mapping)
> diff --git a/mm/filemap.c b/mm/filemap.c
> index d87c858465962..5c148144d5548 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1932,10 +1932,8 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  		if (WARN_ON_ONCE(!(fgp_flags & (FGP_LOCK | FGP_FOR_MMAP))))
>  			fgp_flags |= FGP_LOCK;
>  
> -		if (!mapping_large_folio_support(mapping))
> -			order = 0;
> -		if (order > MAX_PAGECACHE_ORDER)
> -			order = MAX_PAGECACHE_ORDER;
> +		if (order > mapping_max_folio_order(mapping))
> +			order = mapping_max_folio_order(mapping);
>  		/* If we're not aligned, allocate a smaller folio */
>  		if (index & ((1UL << order) - 1))
>  			order = __ffs(index);
> diff --git a/mm/readahead.c b/mm/readahead.c
> index e83fe1c6e5acd..e0cf3bfd2b2b3 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -449,10 +449,10 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  
>  	limit = min(limit, index + ra->size - 1);
>  
> -	if (new_order < MAX_PAGECACHE_ORDER)
> +	if (new_order < mapping_max_folio_order(mapping))
>  		new_order += 2;
>  
> -	new_order = min_t(unsigned int, MAX_PAGECACHE_ORDER, new_order);
> +	new_order = min(mapping_max_folio_order(mapping), new_order);
>  	new_order = min_t(unsigned int, new_order, ilog2(ra->size));
>  
>  	/* See comment in page_cache_ra_unbounded() */
> -- 
> 2.44.1
> 

