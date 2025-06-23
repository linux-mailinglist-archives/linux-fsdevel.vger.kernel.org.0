Return-Path: <linux-fsdevel+bounces-52473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628C9AE34C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 07:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 952E03B018C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 05:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86FC1C8601;
	Mon, 23 Jun 2025 05:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e1KZ9QyY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15714210FB;
	Mon, 23 Jun 2025 05:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750656620; cv=none; b=h1tyJvPmp5N+LV9LnEe2kyxpYW7uODfsTMOWlSlRxZ3cSs9+V7EH/tMHJ8DiCaE3ITzN730w40GK1s5xQZFwLni1WGIJ1Em3kzOmW1bVChFDbGKLDHPxW7SAZN3Fc3OkJLJD4nsiTo2z8d1rnNKMbPGR+9d+M5ww+OqLaCMXg9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750656620; c=relaxed/simple;
	bh=OLS9TfzrHaJbr7q8HR4u6+oaiCM98vyR/i7lZ8fnI68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnLTgu1/oGk/eQAecRsipmSHS08Oe/Okbn7enz8Vf9nroxNj/HfECxl5b6uW7mZtqqtJViQFF65SKToQdov0RDLwu+FJSrBjKew4UWXbybnOTPshJK9Ewm8Xa049BsQVJjy/35QR9x57tsXNFJZA42TWDr5D9lruXcZcivjFiis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e1KZ9QyY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OLS9TfzrHaJbr7q8HR4u6+oaiCM98vyR/i7lZ8fnI68=; b=e1KZ9QyYVqszBvA+tNI5GhIgd8
	Y/uPFGe+3zKpytXztk+ckvYQyRV5pHi2oAjJ0RJ58FRXkbKLu1m28XdCitYiqKiSaJcoLjaCo1LSH
	4dQ0yJ1qrBdQ1Hojcf25FlLA/fptIAuK+zZZSIFa/dNeNPobp5B9MjHaGu8CyHyVAZYTe8Th6VRYU
	wnHBsIqu9s/qFhqNKUYQ7O+eduTjklzN8jV/rCl3hXjTXzNy45/7NGmcC4QnUu1HSJ6y6J4I1Kluf
	RTjId58owroV27j/BHi1mATd0dxTLf+gbrf+Vs+78pnSIx4zzSB+70uTveK7xlhz4xsUhfypzX0gM
	LrvSR86A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZl0-00000001cg2-0hIM;
	Mon, 23 Jun 2025 05:30:14 +0000
Date: Sun, 22 Jun 2025 22:30:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [PATCH for-next v4 3/4] set pi_offset only when checksum type is
 not BLK_INTEGRITY_CSUM_NONE
Message-ID: <aFjmZkidi9O_73bW@infradead.org>
References: <20250618055153.48823-1-anuj20.g@samsung.com>
 <CGME20250618055218epcas5p13a69c6cbb36108a34379148a4f8d0a20@epcas5p1.samsung.com>
 <20250618055153.48823-4-anuj20.g@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618055153.48823-4-anuj20.g@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The Subject line is missing an "nvme: " prefix.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


