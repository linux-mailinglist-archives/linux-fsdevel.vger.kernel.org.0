Return-Path: <linux-fsdevel+bounces-45732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D7BA7B8EC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 10:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14318189BE6B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 08:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D4819995D;
	Fri,  4 Apr 2025 08:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IGfw/URl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0A02E62B4;
	Fri,  4 Apr 2025 08:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743755520; cv=none; b=p14+MR3rVRfdOQ1ethr3DNSf/5YC3CIl1qcffOG3tWBGwnopgfvGuH3G6Bqlk+UcX9Wanhb1YFXlA6+E9iuCRZtnr7hKpV30156CpSsnRu5dN20YBGrL5KIsOAzjRQYxNpu94NPLA1c6PbfdEbBWhrmFFQddJiSM7zw37crtzu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743755520; c=relaxed/simple;
	bh=BDOliCQiV/tizcPRKD2MYSXZd6ImS8F9LCQwfDKrCjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfSRKZWcVOkxbePFe0x739eIQMf5ZeIp10Bax9OV90foMJ8WAZhG6RLAov+S6Y/WMzNDsZmAnGy1Kc6yxR3kmJNrIlwbHcZqoI71NTjx2dwU4ZzLuiHtdVXzQWdFlLPg1Manek45xeoGsyyHV1U87F3uvos+aFTnLrLbcONr+kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IGfw/URl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NiY69VWvTuqwV+rTlc928d5gMTS1h3UvN1TloZGuqbg=; b=IGfw/URly62aWHNlDpNckXWMmx
	PSFDsKlSDSkrcnCQ718kGjWvXn3Lwafm0Ezelfet62CDjY+U+MwBTykVszRDtBTJseLQ/oR4moBk6
	cJJxILA7BIeemeFtDyV00p/nKdjc9D4wfSnHwXBzorPpPvww2LIaVjolLVoi0WzOnDGSD3o3TMvi1
	hV0fOg+PaHnBxgHfTmFz9BWVhufC8TJhqr6794DZtkY0Su10oOvNiVtcd+MLTEV9mKIEaxtisGax+
	QLGlqF1cbxYEUlRvlvTvFIW+Qke72yv2Fn211T3wX2YymPiG17Af8oOIwiIirrk0iqPl0RgLqA4WH
	aPfXfJCA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0cT0-0000000B9p9-0vzk;
	Fri, 04 Apr 2025 08:31:58 +0000
Date: Fri, 4 Apr 2025 01:31:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Penglei Jiang <superman.xpt@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/2] vfs: Fix anon_inode triggering VFS_BUG_ON_INODE in
 may_open()
Message-ID: <Z--Y_pEL9NAXWloL@infradead.org>
References: <20250403015946.5283-1-superman.xpt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403015946.5283-1-superman.xpt@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Please make sure anon inodes have a valid mode set.  Leaving this
landmine around where we have inodes without a valid mode is just going
to create more problems in the future.


