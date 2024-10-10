Return-Path: <linux-fsdevel+bounces-31528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFAA99829F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 11:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F30BE284F50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 09:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC95F1BC9EC;
	Thu, 10 Oct 2024 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m4PK/UOx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC44818DF65;
	Thu, 10 Oct 2024 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728553371; cv=none; b=c/EcSRGxizKvWOe2dBJw4I6mg5/gUJt/tHzKfmM/DY/5InEB7TqV/xBc+NbqoF4VUbEFw5Q6iOiK2mEx/OmN6i1TsR28H7czgqVnl9GeIdsdHLwINh0K2v+t2IpyGdhibFfwoby0XXZA+hRmkiqAIq+SPIEnlBP+sP01mJrq9eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728553371; c=relaxed/simple;
	bh=346cdhzfMjk0IugSFuF5mu9ZT8QjdmGOPWqppdkR+Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piimYImyqwgZK0wuQms629j/ud5Ww348Sv3UFRnr7hY+LXYXJOrgi+K4kBgX53qsnYx3NB3zSSX9/hpMPwjNry2YueX89OnarrBQAVoeSRg9MBCMB+9V2P3oZm4+G2z/6vCfRco1Ns7zuRDZs8VsN5dahRdp3iexG4F3CBm9J1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m4PK/UOx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cRaxaOIG6VIWm/An1JMpyl8wdnm639NBZ/3o+pQVzBk=; b=m4PK/UOxubqShBQ4Rd0obSAgl9
	eGhdntLwcUAmTGnXVwBpec+u5B/rbWNSQ4DjCiVicB6jaJfHRvkJZgkSs5zPLcbIO0CEpwZU4adty
	YDMgmv3hEWRis7PQ6qc+IsLim5gryqhjz/rU5IS3UmJr1iSpUB9CppG+v80vCan4CLxU7EmJZ3wvA
	eY18GLZPNnppJRdpfg3U5X546Xn8FT28IK1sfWhUgygLd/c/1Df7ib4VVCVjKPpmZUDKqx1+7TVVI
	MyzWdOhKhwvP0ORPqXRpqE7F7spFZuDm4ZOGUwZ94WfrT3YuC7sgYI+MHKCHLhNGIE8o5TC2+JRI2
	X6+H0fUg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1syph3-0000000CGvD-1ino;
	Thu, 10 Oct 2024 09:42:49 +0000
Date: Thu, 10 Oct 2024 02:42:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>,
	Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH 05/12] iomap: Introduce IOMAP_ENCODED
Message-ID: <ZwehmQt52_iSMLeL@infradead.org>
References: <cover.1728071257.git.rgoldwyn@suse.com>
 <d886ab58b1754342797d84b1fa06fea98b6363f8.1728071257.git.rgoldwyn@suse.com>
 <ZwT_-7RGl6ygY6dz@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwT_-7RGl6ygY6dz@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 08, 2024 at 02:48:43AM -0700, Christoph Hellwig wrote:
> In general I'm not a huge fan of the encoded magic here, but I'll
> need to take a closer look at the caller if I can come up with
> something better.

I looked a bit more at the code.  I'm not entirely sure I fully
understand it yet, but:

I think most of the read side special casing would be handled by
always submitting the bio at the end of an iomap.  Ritesh was
looking into that for supporting ext2-like file systems that
read indirect block ondemand, but I think it actually is fundamentally
the right thing to do anyway.

For the write we plan to add a new IOMAP_BOUNDARY flag to prevent
merges as part of the XFS RT group series, and I think this should
also solve your problems with keeping one bio per iomap?  The
current patch is here:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=djwong-wtf&id=91b5d7a52dab63732aee451bba0db315ae9bd09b


