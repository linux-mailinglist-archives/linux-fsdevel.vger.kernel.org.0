Return-Path: <linux-fsdevel+bounces-40200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 455D2A20416
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 06:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DED43A67F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 05:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555721C3BF7;
	Tue, 28 Jan 2025 05:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mhs8qC3r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F1842A92;
	Tue, 28 Jan 2025 05:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738042808; cv=none; b=Oljx3K2MG4bRevasa3jmCMY/da5r/haIYuEkAWo0uiYfX0yYr6nsv4k7in/qTM+h15V5Pei6MjJWe979qCfhl/vPWFPHFQbVWla4I6VgqrZ59QmThS2g02xwYGqMgcS9euXYdWiRCkswP3sgUvpM9W5ed9hw5ryIrg6w12ZLUsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738042808; c=relaxed/simple;
	bh=3ca6dHvS/7XZka4IrF3ajiqPB8T1yty6JKA6JjWj1LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D46re96SiYMQ633x05+KaSrodsOav5leIln3x9dcw7pj1IzAJgv+rdJPgUXf2EX6S3qeyJILxnXUfnzdZCAMSiClgFMc9/+gWjIooks3tZzYZpb+5F8JWsh3597SfrbbyHHtOag4TGjyp8niVBPRwMpLC0LFpo4HbtRf8Y7vtCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mhs8qC3r; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Un7CuJlz0uQRB4nSRv+XIwSkWeZ6jPj2isD7JOINuIE=; b=mhs8qC3ravxdbvUFy827Dve+ph
	K9dgT9jbwBigUiqmWjojkrWFEDkIqnpZQySl2WqI8aIn0vOTLXXYBW9NVsz1F8yUVimSrHD2jrRKO
	ZMnLPeFy16efmJ6mTASabAoc1Q2/bnDX2ZN+Y+yc+ZnOi3W/mQHSx+vZKrH3nHPCd0bw/Dbb/GF9h
	9oo7a4DPN5p2v3JwC7GfLEjFfV4RxP1wcJIEtqk24/tSa4EcLvlvucsatJRTP09XmM5aBJW6h+VbA
	hMoS8RF1cAcMBzMeQ4VvcIH4PYaiU4LSbQlQyvjlOME4ahL49jRTaBvqkGl76++xxF+v72b6/THcT
	jgegKzFw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tceKT-00000004Awc-3rNG;
	Tue, 28 Jan 2025 05:40:05 +0000
Date: Mon, 27 Jan 2025 21:40:05 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 7/7] iomap: advance the iter directly on zero range
Message-ID: <Z5httcEzstjgAoMm@infradead.org>
References: <20250122133434.535192-1-bfoster@redhat.com>
 <20250122133434.535192-8-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122133434.535192-8-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +	size_t bytes = iomap_length(iter);

Same thing about the type of bytes here.

Otherwise looks good;

Reviewed-by: Christoph Hellwig <hch@lst.de>


