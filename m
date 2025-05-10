Return-Path: <linux-fsdevel+bounces-48676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1262AB2556
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 May 2025 23:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65DD37B039F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 May 2025 21:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084052882A3;
	Sat, 10 May 2025 21:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c5kk5HVK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CF978C9C;
	Sat, 10 May 2025 21:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746911482; cv=none; b=RdfSyRRLG38Z11uFBNRoJrH7DB0jls4p3BgNYO7cZv+5CYdFM4aAPz+0NKmgnEG29x5rY6h4rBcEbKyniOBYEUJNjlWSsPS/SJex3jNI/7mlYVh22eCtKbZMwLS2dhR9f3kxA/vmRuIH5l6ldZ6fw14PpXrIVkSLIEFP6NBXXgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746911482; c=relaxed/simple;
	bh=YaTRPpJu4IXAqgUm93MB+ZnsNUdNBD0yv1Wjlt/WKU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/ZDg+OKpyTyjeh+5G4BhNtNWri2fezsn1w8Gj+gfl9O4IY2LFedp4jZ45c+MZBPZuuJbAAJHjz7+4aqtY+IMPs3irPcIvuGRYSC4EqIAQOz3aHDcQCp76VysoJyfegjz0vB7XRknxsmn/J/3AyvX1CjAhV+XOXJkoyxoEia7dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c5kk5HVK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=o6ORA5gX6E7XXNPH3F2az+0vfTFANLlW+LsGqTkQWXc=; b=c5kk5HVKCDDYj2sENDA8ExaPt+
	Orw20A+GMCdu2UrgLWCc8EeTaXHnGH8sSRWhyvFjheunrbEKZt4e2kLAm5F4Z4NGy2hOlw/6j2348
	Zv7eJrPI+kAJVDNsgVR7U5vvaSUpu77IsLs5JILrzkxjKcw213DX0chHrKBRPZeRnDKbDEXgAmEbv
	gE49rfFUCW/kHjG+lQ4C3WuKJCuXyd9uw3dbuSscaZsi4I5caFoAcAp+iGeY8TFQcBS57kdx2pei2
	Udzm9eU4gsnmSdZb/DFQW6jIzVhRAycSDod+OTmwyVDoSuQpaX8dr7N9ornV2Y0B515lWS8id8PQI
	vFZEoH6g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDrTO-00000008Pgo-13Gs;
	Sat, 10 May 2025 21:11:06 +0000
Date: Sat, 10 May 2025 22:11:06 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: I Hsin Cheng <richard120310@gmail.com>, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] fs: Fix typo in comment of link_path_walk()
Message-ID: <aB_A6jiLNBwpeNsJ@casper.infradead.org>
References: <20250510104632.480749-1-richard120310@gmail.com>
 <20250510120835.GY2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250510120835.GY2023217@ZenIV>

On Sat, May 10, 2025 at 01:08:35PM +0100, Al Viro wrote:
> On Sat, May 10, 2025 at 06:46:32PM +0800, I Hsin Cheng wrote:
> > Fix "NUL" to "NULL".
> > 
> > Fixes: 200e9ef7ab51 ("vfs: split up name hashing in link_path_walk() into helper function")
> 
> Not a typo.  And think for a second about the meaning of
> so "fixed" sentence - NUL and '/' are mutually exclusive
> alternatives; both are characters.  NULL is a pointer and
> makes no sense whatsoever in that context.

fwiw, C refers to strings as being 'null terminated' rather than NUL
terminated.  eg 5.2.1:

"A byte with all bits set to 0, called the null character, shall exist
in the basic execution character set; it is used to terminate a character
string."

so NULL-terminated is incorrect because it uses the wrong case.  All this
to sau. I Hsin Cheng, please do not submit patches "correcting" comments
in the other direction (ie changing NULL to NUL).  They aren't
ambiguous.

