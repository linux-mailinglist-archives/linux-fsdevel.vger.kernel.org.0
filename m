Return-Path: <linux-fsdevel+bounces-73620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15966D1CDEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 08:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02B7F3069FF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 07:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C1537A496;
	Wed, 14 Jan 2026 07:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AjgfZ5si"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC9D342C8E;
	Wed, 14 Jan 2026 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376243; cv=none; b=J7t5cgdLLNfBcArqQ+wyF2acEJqWqy78RdEu4BIxfW8+IYR563keKlCm6KDwtX6IYNnwuVK6GDT85hQhF6/ERzan5yLN/ohnQDmrlRWhWbqIh1TPdiy5INvA7JksrbK2wyvIZzJHUV7AuTDTfBhE3rYqBJ/eVYyCtvPIzs72ztA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376243; c=relaxed/simple;
	bh=jkvnpA9gfE4+ANZ5IOCna/ns0ya1unHDkNohNK8VQZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDQRwrTE8d0vUEHcakXInhG5LB675vWYegY5lG98unpk/xgE4RAd6A+lYckxhm4caiQcNSPMFSoX28W7+ujzr7Y5ViA2aZNhGy7VGNM+oBpCJHqaq/TYSYuUlC0JBBjRV3QjmM+v5HQu4AQN0tSsIClKlEsou6YCRshl9cheDr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=AjgfZ5si; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JHQsKyub3KFmr4h6byT9LriJEMAGg3GjzDyedELWlcc=; b=AjgfZ5siTzRzpyCDaHqGE3WpW4
	j+s7tQRTeqdNRkkpX27DMCVG1sb55Ac1nK8b+PUcot1E8QT0/VOhOCMldJYja5NrmzdkSSshcd8fX
	Mhj4gWQN5meymeDNRxB256BFcmLMetym+XPViujCEaZloYAP0/s38nRi/FSREV6W1naQ017yCZvOP
	MKk7NmvpKPjzRRu2gKeFhXrH4P2KwCtUbGC5o+lzSsFFXu0X7J4fvt/Lcb+0xmGqkUVYl+fKISxL/
	U70mfQEKThY1q8xh+h0ZFSDbBVaaSBufBcmq9foeN6OBCgDgiaE0h21qie5Z4IWKzQu7zbTsn9vrr
	PLvkHLRQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vfvSi-0000000Gh72-07Qu;
	Wed, 14 Jan 2026 07:38:40 +0000
Date: Wed, 14 Jan 2026 07:38:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mguzik@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 01/15] static kmem_cache instances for core caches
Message-ID: <20260114073840.GT3634291@ZenIV>
References: <20260110040217.1927971-1-viro@zeniv.linux.org.uk>
 <20260110040217.1927971-2-viro@zeniv.linux.org.uk>
 <aWdGEI6iQBl3Xibi@hyeyoo>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWdGEI6iQBl3Xibi@hyeyoo>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jan 14, 2026 at 04:30:24PM +0900, Harry Yoo wrote:

> SLAB_NO_MERGE prevents both side of merging - when 1) creating the cache,
> and when 2) another cache tries to create an alias from it.
> 
> Avoiding 1) makes sense, but is there a reason to prevent 2)?
> 
> If it's fine for other caches to merge into a cache with static
> duration, then it's sufficient to update find_mergeable() to not attempt
> creating an alias during cache creation if args->preallocated is
> specified (instead of using SLAB_NO_MERGE).

Umm...  For static-in-module - definitely (what if it goes away before
the dynamic alias?), for globally static... might be fine, I guess...

