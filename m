Return-Path: <linux-fsdevel+bounces-50960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FB4AD17A1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 06:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749241889E69
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 04:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F9627FB35;
	Mon,  9 Jun 2025 04:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IV1SfdwZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21CA13AC1;
	Mon,  9 Jun 2025 04:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749442265; cv=none; b=nsLJFwud+9AYy+iAO/tiLhtUbQtJ5vM1yaC3qk/mbfXvcmBMYv097Pp8Pch7FX+Fb/FjFG0WidQhFcwkIazsXzQUdRRokmGq+83WGfcEUlQ7jmuoZDMSmULBYCYocXYLGrrLt8fZ5cF+uEEv70EQj1FodPDILaPeZYBEFHwJDX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749442265; c=relaxed/simple;
	bh=kL5dYavrO/aPtlseye7SZuIv+Nf4/NUAkrRzCbC2HW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2CH1Pl+U98syTHH5BAV5IARb6d/XJ0jPdUtT7TkIWcPmzeqG82Fc28sz4uCijPe6RwnFWWocneVGyaFAKbhHlx7NFkD4Ey3lf9BKQeQrlgO0WW6n/MXmtJQehLwpbiXgtJm4nm+tYD+Ahoe0O1t3BvtjR6GrTbOG0a/WjxPeUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IV1SfdwZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kL5dYavrO/aPtlseye7SZuIv+Nf4/NUAkrRzCbC2HW4=; b=IV1SfdwZo2K8ZkBzd2xg+p0TUN
	uWjykp54GkCPF2p6eJv1x/jTgGg4F1Z9idqQOq9WQYeDk9yy/JjT2sdjjLIKJ2B13+YMjrywQMkMI
	MHCnQMa7Vxlf8kH2ZteZCC19+wa0twKmrG5jud2Hjmj5KE18rAoBycx+a/w4/01I0raWj7LoMwWit
	cEINIJpabgmunw65yrlXUmnk9aU8Yrq19VgaPJOduQEvxkHOoK3KiL4gGYDDT3bPo3c2QPTM4t4LB
	88IoXxF23Bs2C3zQEAH0pPUi6r+OcBlR3MlqBA/HUSlimPCuByso3PYJ7aTqNS3Z3wsM6txyj+DAt
	S/wF7Diw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOTqa-00000003NhD-2cHK;
	Mon, 09 Jun 2025 04:10:56 +0000
Date: Sun, 8 Jun 2025 21:10:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com
Subject: Re: [PATCH for-next v2 1/2] block: introduce pi_size field in
 blk_integrity
Message-ID: <aEZe0HdnndhWQRSX@infradead.org>
References: <20250605150729.2730-1-anuj20.g@samsung.com>
 <CGME20250605150743epcas5p11a40e74bba0b8a8f9c24c3ff31051665@epcas5p1.samsung.com>
 <20250605150729.2730-2-anuj20.g@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605150729.2730-2-anuj20.g@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 05, 2025 at 08:37:28PM +0530, Anuj Gupta wrote:
> Introduce a new pi_size field in struct blk_integrity to explicitly
> represent the size (in bytes) of the protection information (PI) tuple.
> This is a prep patch.

These changes looks good, but I think we'll also want some validation
in blk-settings.c that the pi_size matches the chosen checksum.


