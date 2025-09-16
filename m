Return-Path: <linux-fsdevel+bounces-61732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915B5B59826
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 15:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E48D3BF926
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 13:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6347931B81A;
	Tue, 16 Sep 2025 13:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iJuDYdO5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D6B31328D;
	Tue, 16 Sep 2025 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030565; cv=none; b=C7leljwYWgUGn0uht4VAM2E1KndFWQWkl/3ACmgccQScN03EcZggK0laW51LEssSQ7Kcx1Gg7CgoaR/FdefB+IINK42KlHM6AcPMtU7FPwwHRuolOOKrSdLAmTfqCrpemuh22mog/pZ6jU7elnbYaxCxEoMpeCrAqJd3gj1zaU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030565; c=relaxed/simple;
	bh=F3M5QRuW62Z5l8BaT/3ewidJZFg3Z3fpaf8gtbjTITE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxaKoZjWOt9Rmsis1a3/IMUAmc/ic8CYShoWm2AVxQY3x95dUyPvP3fjgYcGKOwfTV7uVnBsf2pXbbG/bz0aqwk/jsF6w1io8GpdMISj0LtbwJ77rmb5iJtd/SYIWi8kgZnuld30zjk2HymmyR0xwxujo3eML3H3wkkMOGMy8Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iJuDYdO5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=svVk2pmAQIG6Xzug0JCDqAe9MTHDXtaVXBsfzt6yQxk=; b=iJuDYdO5Nh81xRBHUuxC97Zepu
	NVuSQLXmZTHGOEXnMroziZ4Bx3yOhccqeYU9baFiKgMUGcpfvwRQMocGcBfqr64iXZ4euijp/lLpP
	87E8GYSocSUWRxRLDfYyU25rNo7nN2x/LmURD/qalO23QEpu/Ig4vh1z8Zs/YbWLkibUu5iKnMk5p
	ici+v/owrDi5xsC6t/ruMGO7s8M5bHhB/dCMvxwPTjFRVtC5CHTURHs8Miy86Fa7Smls375khRoc4
	xUxe12Y8/IpkkdMIYppOaPpkLaJkwp1961ofuiJqYqFaUsmUbfCwe5gI1RcNAH9qBq5m66Gov53PC
	XHKFDUNw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyW3c-00000007zK7-2IWS;
	Tue, 16 Sep 2025 13:49:20 +0000
Date: Tue, 16 Sep 2025 06:49:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, linux-xfs@vger.kernel.org,
	John@groves.net, linux-fsdevel@vger.kernel.org, neal@gompa.dev,
	joannelkoong@gmail.com
Subject: Re: [PATCH 1/2] iomap: trace iomap_zero_iter zeroing activities
Message-ID: <aMlq4DhX_mzoNz8q@infradead.org>
References: <175798150409.382342.12419127054800541532.stgit@frogsfrogsfrogs>
 <175798150439.382342.16301331727277357575.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175798150439.382342.16301331727277357575.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 15, 2025 at 05:26:24PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Trace which bytes actually get zeroed.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Can you send this out separately so that we can get it queued up ASAP?


