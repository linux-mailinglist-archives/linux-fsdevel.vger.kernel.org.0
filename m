Return-Path: <linux-fsdevel+bounces-27460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CAC961984
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 23:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52FAE1F24944
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 21:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2681D31A2;
	Tue, 27 Aug 2024 21:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Us6fiF/t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A7C1F943
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 21:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724795645; cv=none; b=VJvwaRuRf0Q2ywdkQNZhbquWf+WQVp/USnEDTrpgMQ81Ya7S0xXIRjjZSfXKfSxbFZqjnzB8PF/IzJidyRhRHkTtthHNBn0ZYpK7YWhK/7KmUFMPPwN9KInXNQc4fG+u0KmefmLhJj9xP/3GnumINfpCbEbHWoxx1vt/nYIkIYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724795645; c=relaxed/simple;
	bh=PdSQGJAKKtu9z6TmS+yCsL1ohEmXk1Uc6MwDJXUy3jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbK/89V2BelVVSIVT5MBdJWC9DL1zVrj8MHHxu40YoD/bWFFCec6zvNs/po6DiZmnny45PS9Yat15lVNJBf8kR/O+OPRz39gDHa7MD0OxVCz4aOPWzXQk6d9UAvSd4abYgh2KZhoKy8V00XSQ2liFVAx3X+li9lJcidV+0yt6Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Us6fiF/t; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rcIskjmSfUTjOgrRLsMFS8i4RX4QtDEHKWoMHWylsKE=; b=Us6fiF/tNlISHZaoyT4bT/RbVY
	11zap+InhBkpD1JCalbv0oF6KBBMlum843Zl0w4H/lMB1xBkcKpz+yH8nQSB6jkcYSGktus9cDnsT
	54pB9MJlFMcItNoKW9B8z9zfA8TbHIzJkM5ir/j1MvIYLOsN5t2CLDyb25b4ZTbXD5I1W1/yG0Ik0
	MaA7PFyDjSPRnZ3u63/V7RCFu0VrmshpUw3aZaymYeh/A5Aoq52k8oAi5vxj/SG66Rc1f4oclatQ0
	zu4gcepR8cKoneVkNNe93Pes35J2SKcsx3OXotwlneERODFWCIf8n4Y9bSTZYTMObWzPhu8TQXLRd
	TQxyoicg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sj48U-0000000HKQJ-2WxJ;
	Tue, 27 Aug 2024 21:53:58 +0000
Date: Tue, 27 Aug 2024 22:53:58 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, miklos@szeredi.hu,
	joannelkoong@gmail.com, bschubert@ddn.com
Subject: Re: [PATCH 02/11] fuse: convert fuse_send_write_pages to use folios
Message-ID: <Zs5K9qOgAQVKYD2U@casper.infradead.org>
References: <cover.1724791233.git.josef@toxicpanda.com>
 <ce4dd66436ee3a19cbe4fba10daa47c1f2a0421c.1724791233.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce4dd66436ee3a19cbe4fba10daa47c1f2a0421c.1724791233.git.josef@toxicpanda.com>

On Tue, Aug 27, 2024 at 04:45:15PM -0400, Josef Bacik wrote:
>  	for (i = 0; i < ap->num_pages; i++) {
> -		struct page *page = ap->pages[i];
> +		struct folio *folio = page_folio(ap->pages[i]);
>  
>  		if (err) {
> -			ClearPageUptodate(page);
> +			folio_clear_uptodate(folio);
>  		} else {
>  			if (count >= PAGE_SIZE - offset)
>  				count -= PAGE_SIZE - offset;

I'd tend to adjust these to folio_size() while doing this function,
just so that I don't have to come back to it later.

Either way,

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

