Return-Path: <linux-fsdevel+bounces-43530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1AEA57E94
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 22:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E506188BCE5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 21:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ED71EFF86;
	Sat,  8 Mar 2025 21:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQp7L3ln"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD4F15749F;
	Sat,  8 Mar 2025 21:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741469643; cv=none; b=IdSMeWJHVoZQ/lx53ww67sgSxQj/B6hop9QKC34Y8CPx7icN6vM5adqJMwasMwSh0jqPJ3kY/+rqMlVc9hLVzenQPisuCn59oKvwD8i8vnmJPOFjQ98QuTgiuExCjDLhwYjpohnOf9MYyIb5q0kyviHv1EOcAMKK+3ThpVkBfxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741469643; c=relaxed/simple;
	bh=D3enNDD6IJ9h5WbzvlwGVYrpzdUfItJAPQgFApHCcXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eSs7NeznBROvLVYH8UOGXkvpPX30HlodoK+yItvI6Lr3tH4bcPlo02JWyX7ci5vouWwuXB+swFV7lUKjc6/DxXGD1RobkWdlNQ7CVKS+YKoWTYh7YXCGocUwVjqyaEGOepTmTXbqpUigJPDy3zWGuYLtiwaWgAsTlyk20mC31cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQp7L3ln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C26C4CEE0;
	Sat,  8 Mar 2025 21:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741469643;
	bh=D3enNDD6IJ9h5WbzvlwGVYrpzdUfItJAPQgFApHCcXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lQp7L3lnRvKN3sS1evrXBI53w7bgUXY37xeFolN7N5OzCNV93cQeh+HkdKAllfc5P
	 rUDnCBqOwpjubbd5si4dsVh7eG+r/JO+A85CdDpdl4f58vKwATa+NzfpjEbpGO+B4B
	 Z5G5v6Aq/yRIqsYQ7eep/I2dosIaI+2JsGH/6F2hPZfp/Zmp2S1PCRc5P9kaN0PPe2
	 M5CRw/z0XQ7rrZvlV2w/jsZHxZhRq3MEXhnkKhovQhP9zwdvbAL4e+D2bY3fKQLWKj
	 Ek54OrDIoljN4906DppDy5Mesd+S2F2MHyg56+ywGVI69oZMnohV/WfmQIOesZ2dCr
	 bqKWybEGFsCfA==
From: SeongJae Park <sj@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
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
Date: Sat,  8 Mar 2025 13:34:00 -0800
Message-Id: <20250308213400.10220-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20A1553F-C30A-4D93-8A43-011163A22C60@nvidia.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 08 Mar 2025 13:32:02 -0500 Zi Yan <ziy@nvidia.com> wrote:

> On 8 Mar 2025, at 13:14, SeongJae Park wrote:
> 
> > Hello,
> >
> > On Wed, 26 Feb 2025 16:08:53 -0500 Zi Yan <ziy@nvidia.com> wrote:
[...]
> >> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
> >> index 4010195201c9..78eede109b1a 100644
> >> --- a/include/linux/xarray.h
> >> +++ b/include/linux/xarray.h
> >> @@ -1556,6 +1556,7 @@ int xas_get_order(struct xa_state *xas);
> >>  void xas_split(struct xa_state *, void *entry, unsigned int order);
> >>  void xas_split_alloc(struct xa_state *, void *entry, unsigned int order, gfp_t);
> >>  void xas_try_split(struct xa_state *xas, void *entry, unsigned int order);
> >> +unsigned int xas_try_split_min_order(unsigned int order);
> >>  #else
> >>  static inline int xa_get_order(struct xarray *xa, unsigned long index)
> >>  {
> >> @@ -1582,6 +1583,12 @@ static inline void xas_try_split(struct xa_state *xas, void *entry,
> >>  		unsigned int order)
> >>  {
> >>  }
> >> +
> >> +static inline unsigned int xas_try_split_min_order(unsigned int order)
> >> +{
> >> +	return 0;
> >> +}
> >> +
> >>  #endif
> >>
> >>  /**
> >> diff --git a/lib/xarray.c b/lib/xarray.c
> >> index bc197c96d171..8067182d3e43 100644
> >> --- a/lib/xarray.c
> >> +++ b/lib/xarray.c
> >> @@ -1133,6 +1133,28 @@ void xas_split(struct xa_state *xas, void *entry, unsigned int order)
> >>  }
> >>  EXPORT_SYMBOL_GPL(xas_split);
> >>
> >> +/**
> >> + * xas_try_split_min_order() - Minimal split order xas_try_split() can accept
> >> + * @order: Current entry order.
> >> + *
> >> + * xas_try_split() can split a multi-index entry to smaller than @order - 1 if
> >> + * no new xa_node is needed. This function provides the minimal order
> >> + * xas_try_split() supports.
> >> + *
> >> + * Return: the minimal order xas_try_split() supports
> >> + *
> >> + * Context: Any context.
> >> + *
> >> + */
> >> +unsigned int xas_try_split_min_order(unsigned int order)
> >> +{
> >> +	if (order % XA_CHUNK_SHIFT = 0)
> >> +		return order = 0 ? 0 : order - 1;
> >> +
> >> +	return order - (order % XA_CHUNK_SHIFT);
> >> +}
> >> +EXPORT_SYMBOL_GPL(xas_try_split_min_order);
> >> +
> >
> > I found this makes build fails when CONFIG_XARRAY_MULTI is unset, like below.
> >
> >     /linux/lib/xarray.c:1251:14: error: redefinition of ‘xas_try_split_min_order’
> >      1251 | unsigned int xas_try_split_min_order(unsigned int order)
> >           |              ^~~~~~~~~~~~~~~~~~~~~~~
> >     In file included from /linux/lib/xarray.c:13:
> >     /linux/include/linux/xarray.h:1587:28: note: previous definition of ‘xas_try_split_min_order’ with type ‘unsigned int(unsigned int)’
> >      1587 | static inline unsigned int xas_try_split_min_order(unsigned int order)
> >           |                            ^~~~~~~~~~~~~~~~~~~~~~~
> >
> > I think we should have the definition only when CONFIG_XARRAY_MULTI?
> 
> I think it might be a merge issue, since my original patch[1] places
> xas_try_split_min_order() above xas_try_split(), both of which are
> in #ifdef CONFIG_XARRAY_MULTI #endif. But mm-everything-2025-03-08-00-43
> seems to move xas_try_split_min_order() below xas_try_split() and
> out of CONFIG_XARRAY_MULTI guard.

You're right.  I was testing this on the mm-unstable tree, more specifically,
commit 2f0c87542d97.

I confirmed the build failure goes away after moving the definition to the
original place.

> 
> [1] https://lore.kernel.org/linux-mm/20250226210854.2045816-2-ziy@nvidia.com/
> 
> --
> Best Regards,
> Yan, Zi


Thanks,
SJ

