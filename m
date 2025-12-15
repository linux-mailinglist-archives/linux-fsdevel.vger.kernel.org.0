Return-Path: <linux-fsdevel+bounces-71325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CD3CBDA76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 12:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 864783019DB9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 11:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234C8314D2A;
	Mon, 15 Dec 2025 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcjMJ031"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6BE3FFD;
	Mon, 15 Dec 2025 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765799902; cv=none; b=s1rZcAhibnzMJsE68a4z8lZDbnYDw+ijq6+FWzTHzAwgCB0LZuMtnbSk3ppepBcoOar5gqufsa6UxjSkPwgHTSx9/HJ6tgf4m5cu3gENJWZkzQuYPDlEqlwGj1d1xKOgbKA5tuBtfZIEWe7v/OuxsxAPbHcGlLY9gu1wL09Qamw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765799902; c=relaxed/simple;
	bh=p3ib7IxATEEQKs6tLDHHrhEZu0aHnPihiAgww66H4cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+rSg/BeFLZ0bNSHzuU6YPZbj45vGC8Hr0ybISYY3VV6chrlLDXs8f81V7h9OO2pqLaQg3CDTLc0OGlLclkfXqvAuPEAmKGBgpgOyFCTHSZ6at2JVHzAJcLQZC4Tw9P36lrbt9FYVRpwnMZYobDGc8Vus3sjwfURZLHr2yhRy6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcjMJ031; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C288C4CEF5;
	Mon, 15 Dec 2025 11:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765799902;
	bh=p3ib7IxATEEQKs6tLDHHrhEZu0aHnPihiAgww66H4cQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KcjMJ031jvj8WbTNzax5HHRcg5ddvgbwkfIjEdJiKCj5AO9fB/6pDavbpha3Eh9Re
	 69g2/ys0cw/30gkkLda5wgsOEG0YlOvhlHVi8pbg2F6TQyey50Qj86YAgbPZjEeL0y
	 FiXvIzdA2XRU97NAahkk5YQVyUKU64nPnkKPPQu/2W/XpbtyIfvZ+ULo0SM8G6gtns
	 QQcOf+Amu5/D4vFoimmq/PWFQWsUM7fDRmb5KZvC0T7jgDgmdm8LUBaR/HDLFHnha/
	 tNgqhvaMkdBSy9Z8hw8yRCxIAufG77TMkjr9cGgiL13g4iNVvUqqo4jcxCNaJPdchj
	 vFor6C4D0hRJA==
Date: Mon, 15 Dec 2025 12:58:17 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Hugh Dickins <hughd@google.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Andrew Morton <akpm@linux-foundation.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC][PATCH 2/2] shmem: fix recovery on rename failures
Message-ID: <20251215-mythologisch-losung-f99a7be1c735@brauner>
References: <47e9d03c-7a50-2c7d-247d-36f95a5329ed@google.com>
 <20251212050225.GD1712166@ZenIV>
 <20251212053452.GE1712166@ZenIV>
 <8ab63110-38b2-2188-91c5-909addfc9b23@google.com>
 <20251212063026.GF1712166@ZenIV>
 <2a102c6d-82d9-2751-cd31-c836b5c739b7@google.com>
 <bed18e79-ab2b-2a8f-0c32-77e6d27e2a05@google.com>
 <20251213072241.GH1712166@ZenIV>
 <20251214032734.GL1712166@ZenIV>
 <20251214033049.GB460900@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251214033049.GB460900@ZenIV>

On Sun, Dec 14, 2025 at 03:30:49AM +0000, Al Viro wrote:
> maple_tree insertions can fail if we are seriously short on memory;
> simple_offset_rename() does not recover well if it runs into that.
> The same goes for simple_offset_rename_exchange().
> 
> Moreover, shmem_whiteout() expects that if it succeeds, the caller will
> progress to d_move(), i.e. that shmem_rename2() won't fail past the
> successful call of shmem_whiteout().
> 
> Not hard to fix, fortunately - mtree_store() can't fail if the index we
> are trying to store into is already present in the tree as a singleton.
> 
> For simple_offset_rename_exchange() that's enough - we just need to be
> careful about the order of operations.
> 
> For simple_offset_rename() solution is to preinsert the target into the
> tree for new_dir; the rest can be done without any potentially failing
> operations.
> 
> That preinsertion has to be done in shmem_rename2() rather than in
> simple_offset_rename() itself - otherwise we'd need to deal with the
> possibility of failure after successful shmem_whiteout().
> 
> Fixes: a2e459555c5f ("shmem: stable directory offsets")
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

