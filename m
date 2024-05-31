Return-Path: <linux-fsdevel+bounces-20653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6878D66A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 18:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C475B2B99E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 16:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C56A158DD3;
	Fri, 31 May 2024 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="stGSz/LK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95643D57E;
	Fri, 31 May 2024 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717172274; cv=none; b=UBb2CDEY9x9rL7jvIIIqM/IbkOrVoL0+AEOffwPWiVxSg0RXLobS79YDVhaPNHCk+kZ7a07SEKDzBvMcFYytkh+LKAREoUas7NP1lfBJDZ94+Lwn4y5F2e8FDr0wgILOkvKixcDrnALFrh9K7JEapbNlbyti6Bt6UMftxDzjz20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717172274; c=relaxed/simple;
	bh=vlldDds/fh09JBc7WVUVFuFOn32xy1JcFdVT445R33Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mb4KNV8KcgDcal3RJEJL132t4L9hncTvNflBYoKcgnMkgdC98FEmSe+Yk2cqJDaroAtyL2Cu3QNCf1C8Rwq08265Na72LBp7Gp22UUmBq7vcM5kqcGC1oEZj4A/yuyE+emZbFXmvB2E4GVUOpQWoOI9ZE8RoLkxDttwbkn4SNZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=stGSz/LK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nez/jzPvJv9Aintcu3RZ3COXxw6jF9V/9ALZcl2RF5Y=; b=stGSz/LKwiyNGVDT61NEq7ww4H
	m3UVCPdgFtRPNdP/L/DHJA8zNB1gxZ2trLgTB10psBhR9lKlN/arXp+LhCViU4QyDfYm5BTMll6gN
	4KjfxrMbI0V8gtA3TIpfJ4ql/RnC2y6/W+KNkLRhzeg2rcZ3RnFw/lNsx54EbzLEPCnSEm101AmyN
	25BYt9aT56J5NHBo8nI7lPmLe1d+Xrjak5u7Z6BFsAYTmtv2ggMZvBQGrz5G8RrN0Zg4M75sezwud
	2ktaWrgM7+i8x3CpSPM05HU+rgnV8VK4NPGssegEPYmH6TAzyIJJn79YD6wMRHmdmp3AFPEej2Ajl
	TTH5RBCg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD4wy-0000000AoKY-1dBu;
	Fri, 31 May 2024 16:17:52 +0000
Date: Fri, 31 May 2024 09:17:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
	jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH v4 7/8] xfs: reserve blocks for truncating realtime
 inode
Message-ID: <Zln4MAQmvk8BSKJM@infradead.org>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <20240529095206.2568162-8-yi.zhang@huaweicloud.com>
 <ZlnFvWsvfrR1HBZW@infradead.org>
 <20240531141000.GH52987@frogsfrogsfrogs>
 <Zlna8S76sbj-6ItP@infradead.org>
 <20240531152922.GN52987@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531152922.GN52987@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, May 31, 2024 at 08:29:22AM -0700, Darrick J. Wong wrote:
> > 
> > Sorry, it was meant to say for the data device.  My whole journey
> > to check if this could get called for the attr fork twisted my mind.
> 
> I really hope not -- all writes to the attr fork have known sizes at
> syscall time, and appending doesn't even make sense.

It's obviously not.  I just had to go out and actually read the code
before commenting.


