Return-Path: <linux-fsdevel+bounces-71546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EDECC6E44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 10:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51584300AC75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 09:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45913346FB5;
	Wed, 17 Dec 2025 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mePx01jH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C2F346AC7;
	Wed, 17 Dec 2025 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765965194; cv=none; b=hXJGQRP8ubqrC5Dy2g8pQ6iSQX+nsxW/+ckLI2j+Z6ynqytZRC9sUn/huljbaPbuAwiLuTm5YPZv9hbuKaom+ZoEklelVysfx99zm26tUCQ26mUuVAx45LWlfDsYPWCUNoURlfQmvGdDLETsfQZTykk6+Y6OEVw8Uv3JWRB2bQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765965194; c=relaxed/simple;
	bh=t0dt5W7LqrxVgiMOA0wHVeB3WrzIJmfYJueL0ZOkYkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSA/WrYgbsPJLUuXH61OKLlbWXXeve9CbLqh4f2CB5WLbO2i8wMvxHCOefV07W3LJOG2EacTvRRLcDhtAUlJ16GL340Iv+2TS1GMuYsNiNNw73JCRGt07jGrVa73UimA4Mj1uTwFKIwtvO+z4fARj3LgHbNBgx/BcUrH8UBnuns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mePx01jH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PO1jsG4jXKSEd/L3L2y2/CD52Pekw8rFFMDDN18aPKo=; b=mePx01jHapQQt6AS2cZZ8c0CCt
	RYp1EBnErtuDtsgIgfP8N1/kOQV9j6gXZq8KTMVALZ5nauifczdffHYxegciU/hXraL4IOYHXP+uf
	03wwRGw11TgZfemYerIZLLic3u8lY/YVTQRVJRAFy/Q87WbmBIXTKvwoN02ZzzduppR7V7r+MFwuh
	yrIDGgcMPrxVzQmwhsWyfSsxrxfsD0FlI3N+CpZUL9xjkqPweRZEM1N+r6lelxAI56lQGt++xIXMl
	aR1lfxlA2S8d9X2YJSllstoTiIbppnBij5ZS1ROZWtxjQ8YK+CXGJ4eCXmmeIvW8QN4xlYOe28kTA
	vgm6FBKw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVoDW-00000006Tdd-40Yg;
	Wed, 17 Dec 2025 09:53:10 +0000
Date: Wed, 17 Dec 2025 01:53:10 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Anna Schumaker <anna.schumaker@oracle.com>
Subject: Re: NFS dentry caching regression? was Re: [GIT PULL] Please pull
 NFS client updates for Linux 6.19
Message-ID: <aUJ9hliJJarv23Uj@infradead.org>
References: <36d449e22bf28df97c7717ab4dfb30f100f159a4.camel@kernel.org>
 <aUJ4rjyAOW3EWC-k@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUJ4rjyAOW3EWC-k@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Dec 17, 2025 at 01:32:30AM -0800, Christoph Hellwig wrote:
> Hi all,
> 
> the merge of this branch causes NFS lookup operation to shoot up a lot
> for me.  And with merge I mean merge - both parent of the merge on their
> own are fine.
> 
> With the script below that simulates running python scripts with lots
> of imports that was created to benchmark delegation performance, the
> number of lookups in the measurement period shoots up from 4 to about
> 410000, which is a bit suboptimal.  I have no idea how this could
> happen, but it must be related to some sort of pathname lookup changes
> I guess.  Other operations looks roughly the same.

To further pin this down, I rebased the patches from the NFS pull request
on top of the baseline (d358e5254674b70f34c847715ca509e46eb81e6f) and
bisected that.  This ends up in:

NFS: Shortcut lookup revalidations if we have a directory delegation


