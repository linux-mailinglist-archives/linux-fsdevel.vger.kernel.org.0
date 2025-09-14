Return-Path: <linux-fsdevel+bounces-61253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54945B568A1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 14:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BBF31654FB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 12:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4248D262FD8;
	Sun, 14 Sep 2025 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="ZHnFQ9WV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CAFE55A;
	Sun, 14 Sep 2025 12:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757853280; cv=none; b=JqiSRYEnLWggJaH94kHFw4ZRzUGx5gzP1GjE1Ttnxj79STLsNhigfySAchESYSbbvNIUrt1m5xsOMfRbwc82DVEJM4HnnK7oqYA5BevITRBLCu5WGtzzPkkTYnlv1TLGZdVULjjB01iPFKi9KJCKb3OVR5bdaysqVphRp+2QyPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757853280; c=relaxed/simple;
	bh=8iABwI2C5d5wA5EN6xiW+XM3Ij/JuAeh7KwDh27HM2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ldgq0SlqUUjbj9GBmxEY1YaNVjEVo40xWEdiRBY4I6nkVAXgRCssjdTss/NXz7KR652eikdAAZBXqrqaowLc5cMA4vWEGeQh6jwCfBS4fljAD/GsEzzD+2rCxPfR0Q5kaZdWC6TeE/f6M1A/60mqk2ebSr4Rr1Gjuu5ntWi/M9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=ZHnFQ9WV; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 3336F14C2D3;
	Sun, 14 Sep 2025 14:34:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1757853270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jsU2AE2o9h39I/bC+6REsgHkBZzgTz+eEtU5Pz4oB3M=;
	b=ZHnFQ9WVH7uQ7JXSaJgSdCwGPWEZeOAULgp+YfZaQOyBWL0r//EvgB0uLCrDe5ZqeNAyQq
	BBuSWtP91z9MYE6EqQmIOVndtjXW581sYCxDbiPTpXp5A00gbrISdjrOXIULuuHW3nPPP5
	9h9GtQPdeo+c+wZBJ+e6nE8BEAzevKKxo20Hcses+KxzeSB8JI+c/lrfyIzh+fjQwYJ8LW
	uQq1S8Snlg8jRSdO12JaCVms+ic5oReXoMKjcCaVMc7JSuYkyMg6dWx11YNf2mhGZZim4L
	Pvo479pRFWyDJLelnVGs2IdgLsbxVGXppkJ+pkQgjDpry7jify9yXyQ+Qcdy2g==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id a8ee2d0a;
	Sun, 14 Sep 2025 12:34:26 +0000 (UTC)
Date: Sun, 14 Sep 2025 21:34:11 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Remi Pommarel <repk@triplefau.lt>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [RFC PATCH 0/5] 9p: Performance improvements for build workloads
Message-ID: <aMa2Q_BUNonUSOjA@codewreck.org>
References: <cover.1756635044.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1756635044.git.repk@triplefau.lt>

Remi Pommarel wrote on Sun, Aug 31, 2025 at 09:03:38PM +0200:
> This patchset introduces several performance optimizations for the 9p
> filesystem when used with cache=loose option (exclusive or read only
> mounts). These improvements particularly target workloads with frequent
> lookups of non-existent paths and repeated symlink resolutions.

Sorry for slow reply, I think a negative cache and symlink cache make
sense.
I haven't tested these yet, and there's a conversion to the "new" mount
API that's brewing and will conflict with 2nd patch, but I'll be happy
to take these patches as time allows.
What was the reason this was sent as RFC, does something require more work?

I can't comment on io_wait_event_killable, it makes sense to me as well
but it's probably more appropriate to send through the scheduler tree.


> The third patch extends page cache usage to symlinks by allowing
> p9_client_readlink() results to be cached. Resolving symlink is
> apparently something done quite frequently during the build process and
> avoiding the cost of a 9P RPC call round trip for already known symlinks
> helps reduce the build time to 1m26.602s, outperforming the virtiofs
> setup.

That's rather impressive!
(I assume virtiofs does not have such negative lookup or symlink cache so
they'll catch up soon enough if someone cares? But that's no reason to
refuse this with cache=loose)

> Further investigation may be needed to address the remaining gap with
> native build performance. Using the last two patches it appears there is
> still a fair amount of time spent waiting for I/O, though. This could be
> related to the two systematic RPC calls made when opening a file (one to
> clone the fid and another one to open the file). Maybe reusing fids or
> openned files could potentially reduce client/server transactions and
> bring performance even closer to native levels ? But that are just
> random thoughs I haven't dig enough yet.

Another thing I tried ages ago was making clunk asynchronous,
but that didn't go well;
protocol-wise clunk errors are ignored so I figured it was safe enough
to just fire it in the background, but it caused some regressions I
never had time to look into...

As for reusing fids, I'm not sure it's obvious because of things like
locking that basically consider one open file = one fid;
I think we're already re-using fids when we can, but I guess it's
technically possible to mark a fid as shared and only clone it if an
operation that requires an exclusive fid is done...?
I'm not sure I want to go down that hole though, sounds like an easy way
to mess up and give someone access to data they shouldn't be able to
access by sharing a fid opened by another user or something more
subtle..

-- 
Dominique Martinet | Asmadeus

