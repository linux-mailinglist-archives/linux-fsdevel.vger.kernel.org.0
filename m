Return-Path: <linux-fsdevel+bounces-40508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B20C7A2418C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 18:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61C84163D7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 17:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B28A1E883E;
	Fri, 31 Jan 2025 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbFnsLBm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D521EE00B
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738343192; cv=none; b=ONlmmYJuaNkNEWIuzpPujea4t7Hhp+FtskGB1p4YU/R2e1o5u5Vlh3VxjE09RbgrnePrsf02mY3JzX040/vvfOFwJR7KrVlCT9Z3b7fhEfFQU4xChGc07cXb8S+weNDeUMtWvZ/ftdsuLYI+SjY8OAD6sDB00hocGB2Sr/Q5jkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738343192; c=relaxed/simple;
	bh=39axAhy0T2z8BXdixq7iLVH4wVXl+kEXDkWjvRAqRQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsUZjOT/Ymfh/PXWrthiR+7Laiqz+4A40Sf88umBSJ4vqxxQsF+Z0kJxA8cbglst0xqsnnORDHKKpAFEu59/V2DcMhqeSYql516YbGnQHLJ40lR+wXulqY5s2phq+ZjLoYQNWK9k1OOXBiCI5c+eC0EUUMEi8kmk7tqf6kyPSbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbFnsLBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110DEC4CED1;
	Fri, 31 Jan 2025 17:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738343192;
	bh=39axAhy0T2z8BXdixq7iLVH4wVXl+kEXDkWjvRAqRQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YbFnsLBmPu7JgsHRLvde9cS8wx7EYpb892hAi+Znb04og01r+9pRmV8L5IMdGX7o5
	 DI+mRMYsdiGbcYMZgEjclVBWQT3mm35jg0fL7XJ0pYlKiZOyu3EndCRF171b3DpZH4
	 q1r2I9OR4veOIHsW+65X2tAhWMx0HWtjtKpiuMyk50dmUdivAdCX30u4ZjoqQtOzIJ
	 P+Zx/fTNvyGT5UrNQuhofj3LBw7/urGFRrBpr3WdltpLcAmUdq1vCaLqTBK5JQVGAW
	 OOW+Z4Wey5AOL8MDHylFMheZrR6lC+GgevoCSyg8kjmNbyTBLpcsdkm1vx/Mz4p+iQ
	 6+uwy2sfSAGFw==
Date: Fri, 31 Jan 2025 09:06:30 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: Dave Chinner <david@fromorbit.com>, lsf-pc@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org, anuj20.g@samsung.com,
	joshi.k@samsung.com, axboe@kernel.dk, clm@meta.com, hch@lst.de,
	willy@infradead.org, gost.dev@samsung.com,
	Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Subject: Re: [LSF/MM/BPF TOPIC] Parallelizing filesystem writeback
Message-ID: <Z50DFhRseVlI8E4E@bombadil.infradead.org>
References: <CGME20250129103448epcas5p1f7d71506e4443429a0b0002eb842e749@epcas5p1.samsung.com>
 <20250129102627.161448-1-kundan.kumar@samsung.com>
 <Z5qw_1BOqiFum5Dn@dread.disaster.area>
 <20250131093209.6luwm4ny5kj34jqc@green245>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131093209.6luwm4ny5kj34jqc@green245>

On Fri, Jan 31, 2025 at 03:02:09PM +0530, Kundan Kumar wrote:
> > IOWs, having too much parallelism in writeback for the underlying
> > storage and/or filesystem can be far more harmful to system
> > performance under load than having too little parallelism to drive
> > the filesystem/hardware to it's maximum performance.
> 
> With increasing speed of devices we would like to improve the performance of
> buffered IO as well. This will help the applications(DB, AI/ML) using buffered
> I/O. If more parallelism is causing side effect, we can reduce it using some
> factor like:
> 1) writeback context per NUMA node.
> 2) Fixed number of writeback contexts, say min(10, numcpu).
> 3) NUMCPU/N number of writeback contexts.

Based on Dave's feedback, it would seem not using 4) can in the worst
case make things worse in certain heavy workloads. So an opt-in rather
than default would probably be best for 1-3.

> 4) Writeback context based on FS geometry like per AG for XFS, as per your
>   suggestion.

To this later point 4):

This is not the first time having the ability to gather filesystem topology
somehow comes up for more interesting enhancements, FDP being the other one.
I don't think we have a generic way to gather this information today, and so
do we want a way to at least allow internal users to query for something like
this?

  Luis

