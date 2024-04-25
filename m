Return-Path: <linux-fsdevel+bounces-17761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E758B2206
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 14:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E774DB286EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 12:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7963F149C68;
	Thu, 25 Apr 2024 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pSBnG9S5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4CE1494D8;
	Thu, 25 Apr 2024 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049606; cv=none; b=kNZ9R2KNPY3019MXaFL3yzxg9RA80YDd/7woaqLOOgkaztwz4yT/grHU72lJqJ/W15QYVzrJ8YsN74sXBBtIUT9sICu/CpuGOUPtugD/gpyiRFGCiPkbCghPx+Fnb0zDsmyKhe0cZUs/GFLgXJ/2jej4oX15KnmSDBhZ6B3nnpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049606; c=relaxed/simple;
	bh=fy8j5zTS5R9p5dLel/NsA3+rvhAU+p9UzfYeBFb2gz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7vqkIuYnBl1wTWUajJ5pWYFVF8GkDy339Hke4F8KY1r6g+6DbPGcKpPBQ2dEcfOKI4irgaW9KUV0E6vD9ThBsl4yhiM/jVGQdNyQ18soZ8ETFlLZfE6JFZK0OsnFDUhwwTiDA0qDqZVQGer1MC4KPirciR61qj+AprpqUQsa2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pSBnG9S5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KAaKjBOmTmKtiwXbnEwj76/jYmsGdqRarPPNKoQCzpQ=; b=pSBnG9S50M2h95Gw323PvYrCgU
	eS3udHqR1Aurzel+p6jTZ6oKATg1OaRBD1LcpDgbeVilplQdGrZbWJY8VQrMpK9MeDRKbqZTLzJYK
	IAkhW223WdCj1azUPJ2lNZu9lsdB/kPXanRPhTAsbsiQ/HMrHuo0mIT5MqyqgLrcStQi8lLtxWdzn
	0/vlJ6WPiUc4BgNOtOpETbKz2+VpO6mStBkqx0OsgBBY7FFBdIV345P+vxJTCIiYOpWsVg6Tki0Sx
	QY0QucCSuYkWnSX/Kb9e/irflumoOnJirnxvx5RCZr8p4m8QnCAPuS4EgY8jdZmsZyvHoR0y5INSW
	f3n+YjHw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzybD-000000033Bg-24jW;
	Thu, 25 Apr 2024 12:53:15 +0000
Date: Thu, 25 Apr 2024 13:53:15 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: brauner@kernel.org, eadavis@qq.com,
	jfs-discussion@lists.sourceforge.net, jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	shaggy@kernel.org,
	syzbot+241c815bda521982cb49@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] jfs: Fix array-index-out-of-bounds in diFree
Message-ID: <ZipSO4ITxuy2faKx@casper.infradead.org>
References: <ZilEXC3qLiqMTs29@casper.infradead.org>
 <20240425124433.28645-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425124433.28645-1-aha310510@gmail.com>

On Thu, Apr 25, 2024 at 09:44:33PM +0900, Jeongjun Park wrote:
> Through direct testing and debugging, I've determined that this 
> vulnerability occurs when mounting an incorrect image, leading to 
> the potential passing of an excessively large value to 
> 'sbi->bmap->db_agl2size'. Importantly, there have been no instances 
> of memory corruption observed within 'sbi->bmap->db_agl2size'. 
> 
> Therefore, I think implementing a patch that terminates the 
> function in cases where an invalid value is detected.

If that's the problem then the correct place to detect & reject this is
during mount, not at inode free time.

