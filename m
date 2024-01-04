Return-Path: <linux-fsdevel+bounces-7423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DF58249FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 22:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101E1285027
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 21:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84852C844;
	Thu,  4 Jan 2024 21:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sbn5zyJt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A972C6B6;
	Thu,  4 Jan 2024 21:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=cXLyhOtvZ+uqW+xAdmcmkb7H6C8kaMn0EgnUnAAVSQ0=; b=sbn5zyJtWXapZ7vzZ1mGvsqrxJ
	Pnkz3PbYnpnNYYpOKUlhcNPoDxiH3vhc258zgOXMe8FTItEt/piPdH3tN9JuzyzRnyNSY3Tw6+1L5
	CrfuLuCbh2mjgOFOVWIR9bmGBB8im4wdW7ZD4KcrKiP7ZABHaxOqhfMt/f8GgEyQqXYZv167gh696
	G0PXdO64BtbjkFiniwrZkD2PUwXAth8242vnPlzEcqhnlnmn2ecWqRhOKoAolZIiJIPzRevHTXUYc
	+8Iyq9Gfl8ruVFRQNVwOyFf/umKCTugBPWLN5Ch5fE/rTh9/Tah0Tq8P9opPWew941j7J1UARCIWU
	yvMGCNYg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rLUup-00FETU-19;
	Thu, 04 Jan 2024 21:06:11 +0000
Message-ID: <133cd73f-3080-4362-bc3e-ef4cc8880a20@infradead.org>
Date: Thu, 4 Jan 2024 13:06:10 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] buffer: Add kernel-doc for block_dirty_folio()
Content-Language: en-US
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240104163652.3705753-1-willy@infradead.org>
 <20240104163652.3705753-3-willy@infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240104163652.3705753-3-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/4/24 08:36, Matthew Wilcox (Oracle) wrote:
> Turn the excellent documentation for this function into kernel-doc.
> Replace 'page' with 'folio' and make a few other minor updates.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/buffer.c | 54 +++++++++++++++++++++++++++++------------------------
>  1 file changed, 30 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 5c29850e4781..31e171382e00 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -687,30 +687,36 @@ void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode)
>  }
>  EXPORT_SYMBOL(mark_buffer_dirty_inode);
>  
> -/*
> - * Add a page to the dirty page list.
> - *
> - * It is a sad fact of life that this function is called from several places
> - * deeply under spinlocking.  It may not sleep.
> - *
> - * If the page has buffers, the uptodate buffers are set dirty, to preserve
> - * dirty-state coherency between the page and the buffers.  It the page does
> - * not have buffers then when they are later attached they will all be set
> - * dirty.
> - *
> - * The buffers are dirtied before the page is dirtied.  There's a small race
> - * window in which a writepage caller may see the page cleanness but not the
> - * buffer dirtiness.  That's fine.  If this code were to set the page dirty
> - * before the buffers, a concurrent writepage caller could clear the page dirty
> - * bit, see a bunch of clean buffers and we'd end up with dirty buffers/clean
> - * page on the dirty page list.
> - *
> - * We use private_lock to lock against try_to_free_buffers while using the
> - * page's buffer list.  Also use this to protect against clean buffers being
> - * added to the page after it was set dirty.
> - *
> - * FIXME: may need to call ->reservepage here as well.  That's rather up to the
> - * address_space though.
> +/**
> + * block_dirty_folio - Mark a folio as dirty.
> + * @mapping: The address space containing this folio.
> + * @folio: The folio to mark dirty.
> + *
> + * Filesystems which use buffer_heads can use this function as their
> + * ->dirty_folio implementation.  Some filesystems need to do a little
> + * work before calling this function.  Filesystems which do not use
> + * buffer_heads should call filemap_dirty_folio() instead.
> + *
> + * If the folio has buffers, the uptodate buffers are set dirty, to
> + * preserve dirty-state coherency between the folio and the buffers.
> + * It the folio does not have buffers then when they are later attached
> + * they will all be set dirty.
> + *
> + * The buffers are dirtied before the folio is dirtied.  There's a small
> + * race window in which writeback may see the folio cleanness but not the
> + * buffer dirtiness.  That's fine.  If this code were to set the folio
> + * dirty before the buffers, writeback could clear the folio dirty flag,
> + * see a bunch of clean buffers and we'd end up with dirty buffers/clean
> + * folio on the dirty folio list.
> + *
> + * We use private_lock to lock against try_to_free_buffers() while
> + * using the folio's buffer list.  This also prevents clean buffers
> + * being added to the folio after it was set dirty.
> + *
> + * Context: May only be called from process context.  Does not sleep.
> + * Caller must ensure that @folio cannot be truncated during this call,
> + * typically by holding the folio lock or having a page in the folio
> + * mapped and holding the page table lock.

 * Return: tbd

?

>   */
>  bool block_dirty_folio(struct address_space *mapping, struct folio *folio)
>  {

-- 
#Randy

