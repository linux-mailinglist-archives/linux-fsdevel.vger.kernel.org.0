Return-Path: <linux-fsdevel+bounces-44129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD451A6336D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 04:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA05171744
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 03:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F2513D503;
	Sun, 16 Mar 2025 03:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YC7Yw5dg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5BB7DA8C;
	Sun, 16 Mar 2025 03:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742095806; cv=none; b=CxoIATMB5k/6xPifGCfcaw5M6oCM5ck+u8TtREk5hWsfYhcwyJVk5QVhbUlyme7xO7jR6SnzneiyOOX7QsSXtjorh6jeR9cptpuUPod5P0iRUQpWmKs86OO6QfW8k2JMrQaQIwEWNqK8Ayx07jQinjZkZGqsItVnp5saXflCmQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742095806; c=relaxed/simple;
	bh=HPlN6EQ4TqhduOGC6gbXQx2ti+IJ2nJLaoZfd3YbLSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzGFgHKKdQHnvvtj+P9QTdHbIQN2RNeRckp+yMi6qai8JDqFU0aUQ3kbErhtUkIaoq+HOimD22NCrUzy5G5oTqS6603GX1CSePwHrvhX7tgKrYeP5drVlG8ERnwvZyCKV6ZgDHKFTdITHqTXa9Z5vrcTQKjPDaHuUEgBy2ij4Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YC7Yw5dg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FSu43IEnd9G6UVWlhy9qpwM+6c8I+Yb5z7euF1j53zk=; b=YC7Yw5dg3Mmiti9+u/w5zC4Srm
	5dm75T8uBuzXeTRAPjy+DUOjznvY761c2sQHlRGN8+rrLT04U8r4Om8ova9UHSY1CbxRGul6DqMSs
	8AApvWDNdOfl9OA6yK1IvHFcyCO0v7TBQlPOXxgFG3g/w2HzWFtKqrGdE5gK5kFKOXXVP7R7mkOUJ
	kLlJy8+F9Sg488czTSEjIePzDNgCUIFhFlDDjsWMG1ZzuO4fES1G36APrb5jlsmDZ7zKgf4OUZOxW
	LEy/w6LgnIRhZT/HlBLKNUo6EfVbPedHyP0T1HaWarX59GUVwcAUvlcd/AyadKGpqSmrHi8s9WQMQ
	wCvpJTWA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tteg5-0000000Gefo-2SuV;
	Sun, 16 Mar 2025 03:29:35 +0000
Date: Sun, 16 Mar 2025 03:28:41 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ext4: hash: change kzalloc(n * sizeof, ...) to
 kcalloc(n, sizeof, ...)
Message-ID: <Z9ZFabmQuSLiwfE5@casper.infradead.org>
References: <20250315-ext4-hash-kcalloc-v1-1-a9132cb49276@ethancedwards.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315-ext4-hash-kcalloc-v1-1-a9132cb49276@ethancedwards.com>

On Sat, Mar 15, 2025 at 12:29:34PM -0400, Ethan Carter Edwards wrote:
> Open coded arithmetic in allocator arguments is discouraged. Helper
> functions like kcalloc are preferred.

Well, yes, but ...

> +++ b/fs/ext4/hash.c
> @@ -302,7 +302,7 @@ int ext4fs_dirhash(const struct inode *dir, const char *name, int len,
>  
>  	if (len && IS_CASEFOLDED(dir) &&
>  	   (!IS_ENCRYPTED(dir) || fscrypt_has_encryption_key(dir))) {
> -		buff = kzalloc(sizeof(char) * PATH_MAX, GFP_KERNEL);
> +		buff = kcalloc(PATH_MAX, sizeof(char), GFP_KERNEL);

sizeof(char) is defined to be 1.  So this should just be
kzalloc(PATH_MAX, GFP_KERNEL).


