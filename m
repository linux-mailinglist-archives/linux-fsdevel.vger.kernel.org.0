Return-Path: <linux-fsdevel+bounces-46884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62743A95CDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 06:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF3A174E24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 04:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A6E1A238F;
	Tue, 22 Apr 2025 04:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vZEUFcWx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0756196;
	Tue, 22 Apr 2025 04:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745295600; cv=none; b=gB1KadOcg64PEURNhBcR3milh8GvszBCa3VPvasE6oPknQE2xiUdiZEXL7dMFd+WAoSu/lptndesstXhlY7HtmLjLs2vRXkvQCzVQXk/jx4h60vBOVRHDwXWNPqrzyB6HqOb+++elTRJDEfuIka9zM2Kldfepmdg6bTsQrYOQv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745295600; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCfa5/3o7an3Z3TfuSvRdD9Nm1h9lgXlm9Rxei+KLC35LHHW8auULWQQN4A1UXW36W5JllBLclXQmILgbH5+zQH1Kfq+j1/UBLkyblOLum/wMdcwCvsX/MP2I/CsszuD6vfULbgCgOZNnsvUEIPVIRzlpxXS6iyWRvMYqRdYLmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vZEUFcWx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=vZEUFcWxXnhc+35qpFFROnZsl1
	vfTqHnVyYvuCMGGWzK/aqmouXxp/l/KxRDk1EoO79DF3rxzT8NKN5cJn8BVHSxRG21PP2X0ql3dBJ
	aZFr6bLv2ECpjrquEOq2yEW6/u4Z1PIISz/Vz6qlmzAVjeuAvwMBbrkhqdcKqq4ypC3p4Y8QMd+DA
	avQ9gNpLSFCUmQKTpgrYX9FOytIffBRRgScE+jHS7vUWPqT7R2hSwiIXHbyYamzBbaBj/nlygjsLN
	tYqFTZwJMBekIlygWaOkuvGzg/PTxzeEyecu2WHpx/IrCnyZwrhzsYhcMUbTXEi9GTm2wCT53E4sj
	r3ofwSrQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7570-00000005mQL-1VUL;
	Tue, 22 Apr 2025 04:19:58 +0000
Date: Mon, 21 Apr 2025 21:19:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, axboe@kernel.dk, mcgrof@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	shinichiro.kawasaki@wdc.com, linux-xfs@vger.kernel.org,
	hch@infradead.org, willy@infradead.org
Subject: Re: [PATCH 3/3] xfs: stop using set_blocksize
Message-ID: <aAcY7sxXHUFWBsC_@infradead.org>
References: <174528466886.2551621.12802195876907852208.stgit@frogsfrogsfrogs>
 <174528466963.2551621.17345314319654390051.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174528466963.2551621.17345314319654390051.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


