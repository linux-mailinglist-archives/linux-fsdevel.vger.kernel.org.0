Return-Path: <linux-fsdevel+bounces-62238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D0CB8A4FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 17:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D491CB62910
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 15:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66163168E6;
	Fri, 19 Sep 2025 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tjIkRXC8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D6923182D;
	Fri, 19 Sep 2025 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296004; cv=none; b=ZbCKxOWoYPoCrvWcg0Qc1VaGIgLT61EimQupHFQb/1uhr8YnKJVhaZawnqwLb7IAleZ0I3OFvE8PP+26dBOZCBu6wvZk4BTl4DRgsFYM4oofvNgWNT6G7ieaZx91abH3PxJVwmoXIXNNuw7MED/AvVuQSUdxyPidgQNNBCp5gaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296004; c=relaxed/simple;
	bh=3YOqr0NqzcPM5rsFhH62DWliv+25NoJZpZfkGG0K74c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAERwQ0sbwAf9JJ8Ks5BdsC1dBd3SI+sdkaY1soTGfi6POtwU4dWzz3uMm/AvEQ98iVzhdSuYx1b8OM97+V5vtsUx2+uKhOaVoiQwng/kPJbrZNXAv74VMH98Pbp4242PFB3UtxqJkBNlxt4Ojd41lABEU5SxrbSnmIJ1RtP5eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tjIkRXC8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dfEqPhPWfSuWBxNWznQLuVMyeCw8t0fvnlAfwy12R1k=; b=tjIkRXC8OwsbpttAAD3qdIqxt1
	X4RjVhjS9dkOnpKFUwnmhsJ5jl4+60DHZjipiVrMOMwH1uzbqmFaqTxfTXorPixRGPZLkUlPFciwV
	hhFcySlfxGHDBThEo8e+GiiqzDBWFWK1Cq20SRlLp3U1vPjE2jluQ9FQHmB147y+RThQgAGaJ5JgH
	qeQ5JYloRlARGCOQdGYNZGEaTs7LgYcvKrhY7cL8EKUpQHLtKxrCQer/CRpMmNbCt1CJ8v/yLYPNJ
	aqn6wZehj/HPDawAHeKl5+pHvAZ3TEiBb8mnd6qvCeNkPayfN2JJVTiPJwzWpsp7SXGaLdX4KN54h
	Zj2Hu+HQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzd6w-00000003Lhh-0F3a;
	Fri, 19 Sep 2025 15:33:22 +0000
Date: Fri, 19 Sep 2025 08:33:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org,
	miklos@szeredi.hu, hch@infradead.org, hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 11/15] iomap: move buffered io bio logic into new file
Message-ID: <aM13wn6784wqJ7rK@infradead.org>
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
 <20250916234425.1274735-12-joannelkoong@gmail.com>
 <20250918223131.GZ1587915@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918223131.GZ1587915@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Sep 18, 2025 at 03:31:31PM -0700, Darrick J. Wong wrote:
> On Tue, Sep 16, 2025 at 04:44:21PM -0700, Joanne Koong wrote:
> > Move bio logic in the buffered io code into its own file and remove
> > CONFIG_BLOCK gating for iomap read/readahead.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> 
> /me wonders how long until we end up doing the same thing with the
> directio code but in the meantime it beats #ifdef everywhere

So far the direct I/O code depends on CONFIG_BLOCK.  It feels a bit
more tied to the block code to me, but if someone finds other uses
for it we'll get to it eventually.


