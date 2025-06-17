Return-Path: <linux-fsdevel+bounces-51836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E16BADC103
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 06:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC945188CEBF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 04:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFC11F9F7A;
	Tue, 17 Jun 2025 04:44:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800AA23B610;
	Tue, 17 Jun 2025 04:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750135466; cv=none; b=bbjZUJs8/nxofNPUKjE7TJHSYAAAO8uM+Xrkcw2+BK4n2pRzNZCfNYlMdrMqypuLrA6XnmNhaxPJmUDwQuNJQm3wEv1fD9x0wVhgMIVNAXBEaMDGF0Qgv9eC2gwtXlHGpr3Vnpol1RdBlgwvYtO3zQ8rTlkduWopLzQpTRp3esg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750135466; c=relaxed/simple;
	bh=02x0PonG91SK8GAWF4iW1FlUyDmjry+9/MqM5hDLHK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKwl/KScIH4igyOyc0KVTg0kuAZFh8Oltdloqx08klsBV0LSO66mhSuv8Wr2hT5wbsGcWzfAF5wz8D6fIbGlb35unB4xaKCFvAGmlZT429vTvtKYNKPyG/GjXlywkQLIuSqaG9wPVMJ3yaGV44bAE4WMK3qX+uGqPhrVCJOYzOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 23FF768D0E; Tue, 17 Jun 2025 06:44:21 +0200 (CEST)
Date: Tue, 17 Jun 2025 06:44:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 6/6] iomap: move all ioend handling to ioend.c
Message-ID: <20250617044420.GC1824@lst.de>
References: <20250616125957.3139793-1-hch@lst.de> <20250616125957.3139793-7-hch@lst.de> <CAJnrk1YtD2eYbtjxY4JWR3r75h1QyjwHPy+1NQBRUNrDmTUnQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1YtD2eYbtjxY4JWR3r75h1QyjwHPy+1NQBRUNrDmTUnQQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 16, 2025 at 01:52:10PM -0700, Joanne Koong wrote:
> >  #define IOEND_BATCH_SIZE       4096
> >
> > -u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend);
> >  u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend);
> >
> 
> Should iomap_finish_ioend_direct() get moved to ioend.c as well?

It is pretty deeply tied into the direct I/O code, so I don't think
it is easily possible.   But I'll take another look.

