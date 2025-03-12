Return-Path: <linux-fsdevel+bounces-43751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EB0A5D3AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 01:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87F143B614A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 00:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A351CF96;
	Wed, 12 Mar 2025 00:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ge9Ns2a3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718632F24
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 00:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741738704; cv=none; b=SDsjUIJDgeQYWREtqmNC7MxDX/J42YprH51/g2P8DoM3i+o/hCBppQbw6Jw3B/0nHT2Q3GHaQRoXFv2sdY8l/fb27CWwUrNTevEwAbJBHzBi5oZQGvF7TLghP+oNDJg4DhbJkQgEh+JZFGlBsKQDkkplch1I7P4t8eCw50MxjJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741738704; c=relaxed/simple;
	bh=xVzKP8w5U0bXGUEi6CrFctVJuudSHiuUQjDleCz79PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwEkub6nAZ/MfHx+dd46K/hlzaegUO5dOI7H80pX6+7ZmcUbOtQTsivr8roBpaYgylboyi7MPcYIThZjLTbc3s490/vgj9YQv76l4JIuxRCF3i7xjU/ECuVXfDPZEFPacS1BHMYxNXdSYgA03GjiJK8w6WzpKUcfRPSrooYVquw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ge9Ns2a3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rMmV95KfMYOSOuwrpe9GLg7ghg5pqY7RQiEb0Q/OJas=; b=ge9Ns2a3BwkDtNyZ9UbIyHO8Y2
	0PeIokoXdiA2S2EIANSsDCo+mkEjhziIZ52Z0dJxL2zzmrdwZ3lt/IyXcvYGrxCSgszIWKC4jyxl8
	5GTi43kcQfUZyOU5BBi66mE+GpYU6MJtpKQEM+3xpdV4ksubeFEVkm2EeryFpC7sqCiZyT7IiRSZF
	B6aWkhUYq+9Gzr55fxmAmANSTw5zQfg34Ey4AbN0Thf+Yk+tt6N/PWjxzO98dmmxpUiCCB0Ya7uaS
	3QfBqtGaIWakQMrnlp4JZcv47OhoHw4LbniwCbX3u7lPDr5UyVezjA+GHprS3G0tgDYz/pwHn5DDP
	bHmuS2iQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1ts9nf-0000000B2l8-00VK;
	Wed, 12 Mar 2025 00:18:19 +0000
Date: Wed, 12 Mar 2025 00:18:18 +0000
From: Matthew Wilcox <willy@infradead.org>
To: patchwork-bot+f2fs@kernel.org
Cc: jaegeuk@kernel.org, chao@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 0/4] f2fs: Remove uses of writepage
Message-ID: <Z9DSym8c9h53Xmr8@casper.infradead.org>
References: <20250307182151.3397003-1-willy@infradead.org>
 <174172263873.214029.5458881997469861795.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174172263873.214029.5458881997469861795.git-patchwork-notify@kernel.org>

On Tue, Mar 11, 2025 at 07:50:38PM +0000, patchwork-bot+f2fs@kernel.org wrote:
> Hello:
> 
> This series was applied to jaegeuk/f2fs.git (dev)
> by Jaegeuk Kim <jaegeuk@kernel.org>:

Thanks!

FWIW, I have a tree with 75 patches in it on top of this that do more
folio conversion work.  It's not done yet; maybe another 200 patches to
go?  I don't think it's worth posting at this point in the cycle, so
I'll wait until -rc1 to post, by which point it'll probably be much
larger.

