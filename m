Return-Path: <linux-fsdevel+bounces-40204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F36A20449
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 07:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31BA01887D52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 06:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3047319E7F8;
	Tue, 28 Jan 2025 06:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qADOY4WJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7761C768FC
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 06:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738044868; cv=none; b=B62O+LECevOw+952VUpSTLPgVr+rEYKa4zwJFkJVLX6CC/mtUwGJ07DuhjemMllTKELOntLP2ig3yG86gRN/Q7vz/c0vRh9ZnlV14Z3RawRNUuALpeoaPB0ZFLy+uKC2l44FES0fxB+4fFzLtnunrrjVTg+5R7It31Y4KgCturo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738044868; c=relaxed/simple;
	bh=4Q5FZkMACHS+z4hdZ7oy79B4SfjWex4CdBb3uKoCbGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4tmbho6Nt0OdsZnCGfIkyRDDaz4lnP6HOCE5Aw41Uijj29YR4SQkcvMhR+BmKV6QncWOkmLekv8bq++CqqstFRs5Hrktf0LDhCy4gi2XuGBhc7tV+5arVE8xNjKvF5Mlan/l8jnhSPRH/Lw7j60sp1yS0O2CG7RcrKvqpU5j4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qADOY4WJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lFNANzg9RxKj40UpcYPQwfMj7tEwUdt/Pz3og0nscW8=; b=qADOY4WJFOA1M3HtSi9x3coDCi
	iNhrrzofJZKW4WSrZkhXYe2SpHzX6YmEfrNphayPzdj7VOGvxB4CYx4r/xL366iQc6H5HqCdu4ipp
	3GE2RxU7M+YsBAOJZFbXXXbxc8JCORXoHxQW+MpofYjNBq7JC38WxeFo4Qy3wHYaN072vBMSyGd4m
	mOoOCYWWlJVqEeGOzLfa0R1tmzoNQuLHc4Wrthq8H5A41V4hB741+m4iPlfNMRAvWZwRf0OHr0SHv
	sHUTm8xT2SsOR+MldYxAV0ICRCGeemiqREs88AwE5VDy8RMcuD1Ziu8cVewEcERmI5zUQkd85bLFu
	SxFSSkVg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tceri-00000004CIj-3VTA;
	Tue, 28 Jan 2025 06:14:26 +0000
Date: Mon, 27 Jan 2025 22:14:26 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Day, Timothy" <timday@amazon.com>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"jsimmons@infradead.org" <jsimmons@infradead.org>,
	Andreas Dilger <adilger@ddn.com>, "neilb@suse.de" <neilb@suse.de>
Subject: Re: [LSF/MM/BPF TOPIC] Lustre filesystem upstreaming
Message-ID: <Z5h1wmTawx6P8lfK@infradead.org>
References: <5A3D5719-1705-466D-9A86-96DAFD7EAABD@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A3D5719-1705-466D-9A86-96DAFD7EAABD@amazon.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jan 24, 2025 at 08:50:02PM +0000, Day, Timothy wrote:
> While much of that has been addressed since - the kernel is a
> moving target. Several filesystems have been merged (or removed)
> since Lustre left staging. We're aiming to avoid the mistakes of
> the past and hope to address as many concerns as possible before
> submitting for inclusion.

That's because they have a (mor eor less normal) development model
and a stable on-disk / on-the-wire protocol.

I think you guys needs to sort your internal mess out first.
Consolidate the half a dozend incompatible versions, make sure you
have a documented and stable on-disk version and don't require
all participants to run exactly the same version.  After that just
send patches just like everyone else.


