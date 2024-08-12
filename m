Return-Path: <linux-fsdevel+bounces-25664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A94494EBE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 13:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A24F1C2141B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 11:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3D8175D52;
	Mon, 12 Aug 2024 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="14m6YEOJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8971B16FF4E
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 11:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723462681; cv=none; b=TF9zBf7vn3kzgr51QG77XeM4LX9nCqYwnqgxAQyzG1Z1AfwXHc2HZy/6Yv16opC3oyWyT4YvUjcxnO6poGs1ocf2B8QeYIJUrC7ERM4FE48H8TVNLtR6ZBXRkHIehkpbfVIDoudsRhw4orWo+hLF90rrZmlgBSeUZysdo0+HXRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723462681; c=relaxed/simple;
	bh=wksLjc1w9lLlhRmtEsxLy3ck/7gyi/wdT5KlFUNKhMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqmgZ9ILJrXcEfCTdsACOZEFkuL6QvY5xhu+tMTTanpe5QpIPg2lJ8u6HtSmBAtg+PFoGlmD/OBSR6L4xH1sS6JpNxxlJbRf4rdSbyfyMkZXsYprrhYVLoDyaqu29+j1NEPAh6xwAAh6pAdCYdi3CWAkNYejztD9+XvXwwYd/N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=14m6YEOJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wksLjc1w9lLlhRmtEsxLy3ck/7gyi/wdT5KlFUNKhMY=; b=14m6YEOJjEeU1KfSdarmpUSwrJ
	MB7K90gYapCa14q5bBMbLa2rdGAPdYYb0cZlIVtNvG24T7Zaa7PPkgGz2YuPrYQmmxg0MOBIimVxE
	OCZd3OIE2QfqJMsoxYmY6pAHGXqomcXWHL4o9VwJ0SkMtbIPFONvIVRj8pzCwzM6dGRogCibUkybN
	+ruLeLYFYzWqGHXbUE8huweFHEDQOLr2Wic4rkHpwpgSeVBuhqgYP1hrVJe47a3CSYCdtoc1bkIOn
	2WTPYNieDsbPBYT7dNX6aL4fNlRaaV4FIxYY/+lShuxzPuZOWZeCM3QiikaSD3YuyL4BV8WFICgoK
	7S6gxNqQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdTN8-000000009PY-1yI7;
	Mon, 12 Aug 2024 11:37:58 +0000
Date: Mon, 12 Aug 2024 04:37:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, david@fromorbit.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH 1/2] mm: Add memalloc_nowait_{save,restore}
Message-ID: <Zrn0FlBY-kYMftK4@infradead.org>
References: <20240812090525.80299-1-laoar.shao@gmail.com>
 <20240812090525.80299-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812090525.80299-2-laoar.shao@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 12, 2024 at 05:05:24PM +0800, Yafang Shao wrote:
> The PF_MEMALLOC_NORECLAIM flag was introduced in commit eab0af905bfc
> ("mm: introduce PF_MEMALLOC_NORECLAIM, PF_MEMALLOC_NOWARN"). To complement
> this, let's add two helper functions, memalloc_nowait_{save,restore}, which
> will be useful in scenarios where we want to avoid waiting for memory
> reclamation.

No, forcing nowait on callee contets is just asking for trouble.
Unlike NOIO or NOFS this is incompatible with NOFAIL allocations
and thus will lead to kernel crashes.


