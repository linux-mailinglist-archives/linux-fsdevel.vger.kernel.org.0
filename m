Return-Path: <linux-fsdevel+bounces-53782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B012BAF6DD3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 10:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2063B102E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 08:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22282D3A9C;
	Thu,  3 Jul 2025 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JeFKvOBo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028AB2D3740;
	Thu,  3 Jul 2025 08:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751532988; cv=none; b=H/jNM3VZ0R1dEW8jDGf5uX633hbYNPKQkIm6db7PxlDgMIpBGAfd5QmxMTEOIl1BWZWppHEFZb05LwozBKFc1S8ScFD+txxh1G5l5kHgxj6Y40CIj6sf0FCp/2T1n/uqVQGGU+Gmq6T8/hX92kBFN8igzZq9RosoSrM6WRsdXP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751532988; c=relaxed/simple;
	bh=lc/IUxYD0lTLUGOdIS4soK3xYpsyIRDCFITxvCyMpFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbKltA8QSsgCavHKYW1Ai8Ak+8dOcslLaMU7NeYPH6SFWXJRuS/H9qyiPQ9cKwPp7a5AAGVT2n1LzWz6CbII3FVYbhLJWbl+68PK6c3yrbMR2jma6hICW15YCezwqOWhKk0erpjedw7ZTqJ9+rG90NkPQsJN4RIALd/Uq/qS7jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JeFKvOBo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m3wMoA/+lGXECQWR911SnI8xaBje/etmwtQiMaO7+lY=; b=JeFKvOBoYI/TCgiqEEvNeN41tC
	M5oPFdSbtPMgCg6n39e5uZA5UhXhwIsPSI93tGcgTh0/4ELNPi3xnHCZx0F7q4Q7cCS+OgFZy4TKy
	XcSf7CK7E0+hF7RVMB5xvnm/ywlCLXqvZ7exdvrgE3Ua5vpmg8rzaIpARIE4N9kYbnRSypvBXC+S5
	kAwaz9WzV4Uv5ppJ2pSMlyku4TEbPdgfqjwaNe5+boo8p4u1UxIWa4qmMZ/oxq4hY6loFPqwlP2dW
	4FX3ftfkk4Z91Qwk05cjAZjBUXIvwC/ImemB6wQ3fWvj3iYEFLVpnJaCNmvw/Fq93IiMc6wNIdSMQ
	xGLFulbg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXFjy-0000000AkOv-10oo;
	Thu, 03 Jul 2025 08:56:22 +0000
Date: Thu, 3 Jul 2025 01:56:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
	chao@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] f2fs: improve the performance of f2fs_lookup
Message-ID: <aGZFtmIxHDLKL6mc@infradead.org>
References: <tencent_0D8BB6ABAB0880DB7BFCCE35EDBC3DCFF505@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_0D8BB6ABAB0880DB7BFCCE35EDBC3DCFF505@qq.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jul 03, 2025 at 04:21:30PM +0800, Yuwen Chen wrote:
> On the Android system, the file creation operation will call
> the f2fs_lookup function. When there are too many files in a
> directory, the generic_ci_match operation will be called
> repeatedly in large quantities. In extreme cases, the file
> creation speed will drop to three times per second.

This files to explain what you are changing in detail, and why
(except for the very highlevel problem statement here).

> 
> Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
> ---
>  fs/ext4/namei.c    |  2 +-
>  fs/f2fs/dir.c      | 24 +++++++++++++++++-------
>  fs/f2fs/f2fs.h     |  3 ++-
>  fs/f2fs/inline.c   |  3 ++-
>  fs/libfs.c         | 32 +++++++++++++++++++++++++++++---
>  include/linux/fs.h |  8 +++++++-

Also please split generic infrastructure changes from f2fs ones.


