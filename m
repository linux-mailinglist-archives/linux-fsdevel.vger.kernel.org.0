Return-Path: <linux-fsdevel+bounces-71583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 219D5CC9A09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 22:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1005130433DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 21:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C233930F945;
	Wed, 17 Dec 2025 21:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="qTJ1yVHV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1914B22D7B5;
	Wed, 17 Dec 2025 21:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766008174; cv=none; b=raTWjYf0mtclEJi5cNa3C77Re0KbJtyAfhWYrbD8y6JVuDHArZ6RKXLvzahOaLT2EDZwqB7YRf/Yo7+QZ/5N9ZP4Bslq/kI0ixLMzb6Se6eSZasvLIKvBeeyv9o8/nKKgxAa+dqxU1W5GY6U2LDDAnRLX28pdJWWCVR+efjYCzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766008174; c=relaxed/simple;
	bh=pe6MD91KBXNGiAzgccXj8T+pTJoWLRrL5iFCNmLhSjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDkFBjYXCo7mGNwADt//ghRJnLq7bG2hwbNYcFTxBvjDwgfEIpuOho3MISHyX46xt3T1MfO2jkYihv1f1GlQz2cOLQ4l7P/aAkHh00tgd3RvPsP1cbiFaqUj/IShc1Sw+T78lWcIt5gTXXE4jJqv3i7EeVXEF4ZYTgXgM1oJ6N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=qTJ1yVHV; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id DBCD114C2D6;
	Wed, 17 Dec 2025 22:49:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1766008163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rm0JYrpF7d0NcE2CiRu2ipHmE7x2XFoJEcDXDNz0kiM=;
	b=qTJ1yVHV9ta8kgjEQx1M9VNpZi6Ex+WOflXMZWwvIfAqXLy2vP1KGi7WNH5+0wfSYElTPO
	Dh2iULa3x8eVjXAsdYl18pT99qC+iSV7S4D8gL9yuo4zBY0sXMb9LrfHu6Vj6/l8tkSEqU
	9gaJKSi3N0vOAhfY2IMzKi98tZGj1j/b9IJHhn6uoTIjjJ7jVH6CwKi8Wuz4+0iycDcwcd
	UQ94SvazkKdhRkLuhDhqIFBA5hsQcAMb3//x4auyn05s14ElqI5zzo0F+XAE1i3WniGK09
	UuErgazzURIJ6EET0ya6gnYUAmRhalcfXgD3szsmA7j3Yfp7EbRqgIoyX2tQuA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id ce03f421;
	Wed, 17 Dec 2025 21:49:19 +0000 (UTC)
Date: Thu, 18 Dec 2025 06:49:04 +0900
From: asmadeus@codewreck.org
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Chris Arges <carges@cloudflare.com>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] 9p/virtio: restrict page pinning to user_backed_iter()
 iovec
Message-ID: <aUMlUDBnBs8Bdqg0@codewreck.org>
References: <20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org>
 <2332946.iZASKD2KPV@weasel>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2332946.iZASKD2KPV@weasel>

Christian Schoenebeck wrote on Wed, Dec 17, 2025 at 02:41:31PM +0100:
> Something's seriously messed up with 9p cache right now. With today's git 
> master I do get data corruption in any 9p cache mode, including cache=mmap, 
> only cache=none behaves clean.

Ugh...

> With this patch applied though it gets even worse as I can't even boot due to 
> immediate 9p data corruption. Could be coincidence, as I get corruption 
> without this patch in any cache mode as well, but at least I have to try much 
> harder to trigger it.

As said before don't bother with this patch, it's definitely wrong --
we can't just use data->kvec->iov_base for bvec or folioq iters, so
there *will* be corruptions with this patch.

I'll try to see if I can produce anything wrong with master...
-- 
Dominique

