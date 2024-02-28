Return-Path: <linux-fsdevel+bounces-13082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A733E86B0AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 14:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6270228BFA1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 13:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A674E151CC5;
	Wed, 28 Feb 2024 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="orS4RlOj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A8314C58C;
	Wed, 28 Feb 2024 13:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127749; cv=none; b=jOcSERdCV0/dwX3rhTV4Xs3xZmF7k+KmSVnxAQR17Pv4DtHIwtdDLL0NuSYNHsIhw0Ba/qaCoN0su0S1Z7r/1WxtwJyu16gzPVrL1w/oCOz1XeEfnhfCdISDMxtI8dB4ccX191Fg9Nz6QR5iKexHhs2udwUtEvjdGWmm/refpjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127749; c=relaxed/simple;
	bh=hGYyIywMUr3A9dPW66NkB50nXjuJ1NC2vf/YZGxs/LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIdkKcfyMl/dCSXm1NYMVRYlAQhteymnQqrR9fjCJEV+Pfdm+EUN3s51uTLH+yUBUVZigtX8xRcfu9Q0yVFqkLnfVmcYzmG+3Gym+GgFaN4m3eIMpdWYwTJQgVGBpbJYVueymauh+TsJGvXKUgXwk+jAcZU+jGATTrk75fe5oy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=orS4RlOj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hGYyIywMUr3A9dPW66NkB50nXjuJ1NC2vf/YZGxs/LA=; b=orS4RlOj0B9z/YClVS6C2POa39
	9DpZ0rvYDlmP61wdT+xVLwOHf4SIzXEqgUtDGVmKHO/oekImROQBqeUIvx41o8RosJLgWxYdy+obb
	07VNSJhLKvhmpR2SEusbfUlUZwdZ2EIofynuI2+wg6YcG/Abr+lgXzgNGcLYjakE54ocTrUp2+PNA
	eBTRDeRrWr0km2yUnZjwavcRwWJyumTOG/+wknldjYQkma9PXzzKkT6m+p+1rshA0F1SYdji/P71g
	lA2TFcj7Sh3urdjlNXxUylT2L6gweviLSKtccTuQ90yGrflazYhurG//I2FsFYAqXPINz2KhKboCQ
	BPk2ElDw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfKCX-00000009WVB-3ooA;
	Wed, 28 Feb 2024 13:42:25 +0000
Date: Wed, 28 Feb 2024 05:42:25 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 00/19] fs & block: remove bdev->bd_inode
Message-ID: <Zd84QSWfmuuXwK5j@infradead.org>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The series looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

