Return-Path: <linux-fsdevel+bounces-18405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889BA8B85C1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 08:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0342847BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 06:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216084C637;
	Wed,  1 May 2024 06:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gy2p9Ele"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E493A29A;
	Wed,  1 May 2024 06:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714546565; cv=none; b=ePyUWz5x9yXwX+aG6rw775hTahfxQf3HVTM4CaBENbfDIYETrvIr+vF2dzbtQRP21mLAIEQ/Gn6O0INAomCySUAiXvBzL83NeI0g+/xQ61DgY2dSYoPActeX/UMEZHXsadNfkXXSS+kfSLF5Jh3SuAs//bTWZcv8c6hLBQwzx3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714546565; c=relaxed/simple;
	bh=+mJOKxFhs6tfzwy658YNcb1L1LjgMGXkjK5aWRLgp1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQNOen1Q5ubGMddvXy9wuIRDQEW/2r1Yze3N6Y4ix5abOalkwur3XedVabRECgoBTuE/dsyWh9zY0l1VeIjCfOkYuuMsp+tASdKyFebl2jnu4wpRpGQs/3BWbLYFoh5O8/QnIDlxyWP57X9NBoQucPkXSJGDyRa7R7Oe+RDke0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gy2p9Ele; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l2w+OgMCKTsapaIwlAyPd6HVy171jA3lm1RhD1ddgmE=; b=gy2p9EleEwaRkqdyriqq39dGHZ
	fQTi7R0Gw1/KA9tT8xe8xWrsWz3QcFu8OuQV2DCe0ho3Eow0J8+Be/L9QgH45XWvl6EX3yAOaLCX0
	7tOWIpNfg5l1EDujh3wCXk7BhdM3hBuLjJPZHkFrSGoBZws7aEA1djr9VTOaXIIAzh+Olco1L59gn
	90z7GuKVkuLZq4MPcI1x6k05kTDhBCraIpJzLflb1VkD0CdVUcaNAyJVbirEQ7zA85vihZqUPsEFJ
	Ea056lKCLXrvSPNDVg/R48VNoZX1nQgneeZ7r1JKQRcmxbKtVT2H4EjljBi3Z2QfEwAWHQINrW4Ab
	Ir3JTj8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s23sq-00000008iIw-0Tz4;
	Wed, 01 May 2024 06:56:04 +0000
Date: Tue, 30 Apr 2024 23:56:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, ebiggers@kernel.org, linux-xfs@vger.kernel.org,
	alexl@redhat.com, walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/26] xfs: create a helper to compute the blockcount of
 a max sized remote value
Message-ID: <ZjHnhMshwJidH-Zs@infradead.org>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680412.957659.427175724115662103.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171444680412.957659.427175724115662103.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 29, 2024 at 08:24:53PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Create a helper function to compute the number of fsblocks needed to
> store a maximally-sized extended attribute value.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


