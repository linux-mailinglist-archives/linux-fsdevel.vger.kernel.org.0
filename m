Return-Path: <linux-fsdevel+bounces-37966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 365FE9F9617
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 17:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BCDC7A2DCE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 16:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9858219A79;
	Fri, 20 Dec 2024 16:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uuUQzXca"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A238822301;
	Fri, 20 Dec 2024 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734711132; cv=none; b=UwHKT+EAfT3xuRZmCszYUN55JXkVX/hXX3QrOGzz6z3wCu6z4CeWtvYa78x958FuwULo54hJs3BxfvlfReaBxDP+OeoMKGv3pDpKmOOY/J4v84Y/5mhYkYjgRwj0mD4bJjIOiz4lObxveMvdK9ShSruuMtXCmkfu8cW0o1CHXWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734711132; c=relaxed/simple;
	bh=fxpnygGw5gGk+GcC3V6EISftke2hr49Y15CZl0+12Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTLwTGZg9vAz4NifOPRqv2UXcG0XpVbPLkICMnDyo7o9T3/8S0+1IO9vZSIyG5Vr+uHl0oqveUfIeXoSY/naeScWAVH+ODoM+BburrTcvFB800fP+FkGe90dUiMFtBkShz7L9EJuCcATrGZiUDWUbKPtO9JNqwf6OHssL7QeXZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uuUQzXca; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BpS1AUK+VuYt0/lGLoppBsm3daRp+lMug788JoyS+8g=; b=uuUQzXca7l3B9mENB7BMikLdXV
	jaPnjJbH49immn3ihZHiSfT/GaLCo1ZKl4lNpwTEUpByB5I9tDtDLAiDbtuVAnIGoz1PBsbfA/V66
	sQWyhymgq5XtPfk1OpTuGVyYGsGi6SyS1d5I3cizrdxsqv6S6W9Uipdb7mhOMIyLLm2AcH+65yDN2
	FSsvV9Jzfa44f1YuU1OfACgRB/XIO8KDzEoxo94qvER8yJIJrYBpNA/O1VYbZ8Ht1B0zlmjNy3PVx
	gX22ogwI5gbhOuqtl5A2U8Vwyc0Ibg6tFbMmvk8L3Xi0XHxNT1ceVk7WqDjnJK13SmjmfhniONHNB
	HPJhEmWA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tOfbj-00000001YEB-1YvX;
	Fri, 20 Dec 2024 16:12:07 +0000
Date: Fri, 20 Dec 2024 16:12:07 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
	clm@meta.com, linux-kernel@vger.kernel.org, kirill@shutemov.name,
	bfoster@redhat.com,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 02/12] mm/filemap: use page_cache_sync_ra() to kick off
 read-ahead
Message-ID: <Z2WXVz7FTm2pSsY9@casper.infradead.org>
References: <20241220154831.1086649-1-axboe@kernel.dk>
 <20241220154831.1086649-3-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220154831.1086649-3-axboe@kernel.dk>

On Fri, Dec 20, 2024 at 08:47:40AM -0700, Jens Axboe wrote:
> Rather than use the page_cache_sync_readahead() helper, define our own
> ractl and use page_cache_sync_ra() directly. In preparation for needing
> to modify ractl inside filemap_get_pages().
> 
> No functional changes in this patch.
> 
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>


