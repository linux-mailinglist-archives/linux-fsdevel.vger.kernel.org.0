Return-Path: <linux-fsdevel+bounces-13389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E9A86F4B8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 13:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822671F21C25
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 12:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83D3BE5D;
	Sun,  3 Mar 2024 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vFfsujZi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A96B664
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Mar 2024 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709467872; cv=none; b=isd/KfPGmVcIaPuvCrWXZk89dnn4ECcg5ao3MqiUZ1Y+rkFHO3CRe79pAk4AXV4dmw1oJAZinyaDfNz9e8fk7Wuyrf1NWHfgRLBsnIYw4TnIvM1jpMWsG/0w9y4WOTA9kAAm+K2k51pEtSMfIae6mapSthxfyCf42RMGoaHi0wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709467872; c=relaxed/simple;
	bh=y4R0ma/4jgneJjaSi47/qC5JEaLvNahh3mUVztDZPSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/7bFKxP4tEKNcJy2iTKxwy3AIwOKlisC6l2AJmPpSsqhLSRoqGXBO9CpWm1JyfoGPApL02AqfAejHZtRL4k8Z1x6F4st9DtfWT5LzvAKVVAzcn5yIELfZDCTjPq71CX7Mq561+p75+i1IhLgXNfEOXPXVgii9foXNxgf1tHpeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vFfsujZi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rRMzJ2qW9tbebcVqWb7w64Bb3KLmYdAsPFUAA9R/RGw=; b=vFfsujZixI0Jym0abK7Zh4/FH6
	gUEFU+dAUhq0W+aHCZ/G0LSR7g3pkxS556vkgQ43mI/abPQRFxv8dNML98ia2OPeM8WU7KHieKdaz
	9UMGhX5+nD6lJFtbYYayjpgsUGB4cl0yMD9tF1BtaC1HH0jbHgxCcDUPfkCxRsU+fpxitBevc6iVt
	PBbl5hSlY8pqM6WjG53pqrUgy2xHy57pShWkzKB0Lx4RP2pS459StqAI31P0lThbx75cMC9vfPDuT
	zg2lJn0KdYGJ7IWMwMdNTqIvrNMfs5xX3mz7RjSPd7isLVgEopYBmVdteM2v2mjpsdryaiR9Z8BYc
	/GYzfsfA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rgkgM-0000000GHAM-0Li9;
	Sun, 03 Mar 2024 12:11:06 +0000
Date: Sun, 3 Mar 2024 12:11:05 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Han Xing Yi <hxingyi104@gmail.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Xarray: Fix race in xa_get_order()
Message-ID: <ZeRo2Y_RKEZ2op4i@casper.infradead.org>
References: <ZeM0CBHF3mfz847s@desktop-cluster-2.tailce565.ts.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeM0CBHF3mfz847s@desktop-cluster-2.tailce565.ts.net>

On Sat, Mar 02, 2024 at 10:13:28PM +0800, Han Xing Yi wrote:
> Hello! This is my first patch ever, so please bear with me if I make some rookie
> mistakes. I've tried my best to follow the documentation :) 

Thanks!  This is indeed a mistake.  Probably a harmless one, but worth
fixing to silence the warning.

Annoyingly, building with C=1 (sparse) finds the problem:

  CHECK   ../lib/xarray.c
../lib/xarray.c:1779:54: warning: incorrect type in argument 1 (different address spaces)
../lib/xarray.c:1779:54:    expected void const *entry
../lib/xarray.c:1779:54:    got void [noderef] __rcu *

so that means I got out of the habit of running sparse, and for some
reason none of the build bots notified me of the new warning (or I
missed that email).

> +++ b/lib/xarray.c
> @@ -1776,7 +1776,7 @@ int xa_get_order(struct xarray *xa, unsigned long index)
>  
>  		if (slot >= XA_CHUNK_SIZE)
>  			break;
> -		if (!xa_is_sibling(xas.xa_node->slots[slot]))
> +		if (!xa_is_sibling(rcu_dereference(xas.xa_node->slots[slot])))

This is such a common thing to do that I have a helper for it.
So what I'll actually commit is:

-               if (!xa_is_sibling(xas.xa_node->slots[slot]))
+               if (!xa_is_sibling(xa_entry(xas.xa, xas.xa_node, slot)))

but I'll leave your name on it since you did the actual work.

