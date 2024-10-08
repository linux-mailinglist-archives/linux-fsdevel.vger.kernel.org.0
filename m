Return-Path: <linux-fsdevel+bounces-31300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2851F99447B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 11:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6AC2812C5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 09:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E7C18BC19;
	Tue,  8 Oct 2024 09:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mJ7ZlpUa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDB242A9F;
	Tue,  8 Oct 2024 09:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380411; cv=none; b=sujBn6XzYLTQjjTl2VkxWGwXd0vOxyhj1FkSRGsW5s3Luwnaf+lyczfnRYXSwWtPABDA1/uadvrQYpSH8s6AC9aaRa5D+0FR4qvwLX26KPsrTSpPUFPnLLiEuaG2r5FHjgRWWh3o6ogwrY663mxRGQ8ykmnwk3RFZkNg8gM2NBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380411; c=relaxed/simple;
	bh=tGjy/MJ7qSzNqn6SzkQZQ/kjNvL+CwAet1wNoX0MD78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssCTcTZBH+QnTLNDOcnGysuRhxa885kBALVw9CarCUIPxQnvF0hh39WNy1xV1XXroUB+zsRFjbvnFIBPZ0oyRWc+SABXxZKeKah2stiKNAzEon3tsfD3yYtNwOBlZh+V+taixBsfvhveWFc/DltqwBBl1NgQb6MHkZo5eyqvcfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mJ7ZlpUa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2KBWPOvW1tfe/P895onK+lr0m4zZB783O0eW6luWS9w=; b=mJ7ZlpUaHKntHvZ3O0jDBhwtTH
	Kz9+12u78OwbXpXr61izW9ftIwhkWDD2Nrq6cUHu8aNmkwJtb1H0DxUAsRDvYHT32PYvVoY8u0EoV
	ncMebVclbuH/ib1euV/8ydRF+fLW3U6+//YBUDUfW4hImxCmwNzhFmX1/jC7vtCHffRpch4R0t5B9
	Ziduy2X5XEVrHqGAFf1lUOcXNGlT/RVjkfCN0WHYuT6LRCtenI1wwbade6HOS9qYBoQkFSW5Zml8j
	sK8gQ2F6mdPbly+Mh/SCyKioPyW8ro7r4BLChZb4m/x8MseAXCSklzZXY+Dhgi3K6DOwhStfI/CDO
	9D6D23Nw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sy6hN-00000005L79-1hZr;
	Tue, 08 Oct 2024 09:40:09 +0000
Date: Tue, 8 Oct 2024 02:40:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 01/12] iomap: check if folio size is equal to FS block
 size
Message-ID: <ZwT9-eOVV7eGK_w1@infradead.org>
References: <cover.1728071257.git.rgoldwyn@suse.com>
 <b25b678264d02e411cb2c956207e2acd95188e4c.1728071257.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b25b678264d02e411cb2c956207e2acd95188e4c.1728071257.git.rgoldwyn@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 04, 2024 at 04:04:28PM -0400, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Filesystems such as BTRFS use folio->private so that they receive a
> callback while releasing folios. Add check if folio size is same as
> filesystem block size while evaluating iomap_folio_state from
> folio->private.
> 
> I am hoping this will be removed when all of btrfs code has moved to
> iomap and BTRFS uses iomap's subpage.

iomap owns folio->private, so please make sure this isn't
needed before moving out of RFC state.


