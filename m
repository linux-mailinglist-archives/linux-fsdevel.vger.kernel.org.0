Return-Path: <linux-fsdevel+bounces-53363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F77AEDF20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 15:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C21D176CB3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 13:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E5428B7C8;
	Mon, 30 Jun 2025 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rDfeXfa6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D1C285CBA;
	Mon, 30 Jun 2025 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751290229; cv=none; b=lnOrOxc5Pt6GKGKomcAkap0n84jHvQgk0nE1pBvO+CZ7G+kEw7S7tT26hKWv8gTLX9YhnagTW8dvRgOijWe1mqWpKEUonspqi8Bs9ZTRXr4vyGyZ3LMq3S3PMnAlsTy58c5lA90P0mvnddFquNE69UZRc1Ze+ohLh1GgGMGkgFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751290229; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfhPkT9ksNKQU6n/O5QuORHNfHT3rrX5wSmL4zvrCY502OSwOmHcGBu++91ti21+FvSQ2KWRoAHbgfctYfmxcRpHmdl6bWmIKCQ2PeFaRj4uDq0bcjdCrqBTaxQtO/D78p+VUYx8GWwwktWE7Zra2F+v9FQTvny21ZyOMz1RAK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rDfeXfa6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=rDfeXfa6PsMSTgYU/J/uk+swep
	uJRA7/CLW6oUUynWA+xK8mBGAwq7ZEnfbZyVe68kiWG/ClwyLoPncgV6C5r5XXTvdtR7GIK2JIlEG
	W29u+f1SMJ4NUpEcoW6p2qzOFWRSJKOD9JtFVAkMjiYqN7yqGAyGZE80NqGjI1EOf2tWv1YugdWba
	fDgYLjIf+e+zt0gJcQcfAODc9507phEbPYDgLijdlHXxMsUOtFfJH99OV2RPBopTBGLjtvl5PJcca
	Yvv61M7fzreDsN51x4k18gs16i8gFcU4FiMkNl4v88sRz38KSOcbMKhuF5Is/1wSCHTvaFHnjzAS0
	WApSRqkw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWEaU-00000002Nik-1YOv;
	Mon, 30 Jun 2025 13:30:22 +0000
Date: Mon, 30 Jun 2025 06:30:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [PATCH for-next v5 4/4] fs: add ioctl to query metadata and
 protection info capabilities
Message-ID: <aGKRbqS7eD43DEqu@infradead.org>
References: <20250630090548.3317-1-anuj20.g@samsung.com>
 <CGME20250630090616epcas5p2a9ca118ca83586172d69213e22b635a1@epcas5p2.samsung.com>
 <20250630090548.3317-5-anuj20.g@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630090548.3317-5-anuj20.g@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

