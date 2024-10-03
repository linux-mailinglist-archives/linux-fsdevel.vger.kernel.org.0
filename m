Return-Path: <linux-fsdevel+bounces-30838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FAD98EA60
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 09:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8794C28690B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 07:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B8D126BF2;
	Thu,  3 Oct 2024 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qy5TRFJS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B7A8F5C;
	Thu,  3 Oct 2024 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727940649; cv=none; b=u+i5KJqPKckJybB0VQ5FNJd6+Pa/t+XG2S39CrNs5hlqtmrGs4eQPSVJpaID7q5oIViQntC0fbTcRQkehOVFIFb0aLb4tKm8q/l3HTpGVC2gD80z2GLK+rzt8r0T/FwTtc7RQB+OCa4oceD+6HV2MX4Blmbv9tuGYEp92/mftK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727940649; c=relaxed/simple;
	bh=NL093BV7BiOBCgirj7UGsqM1cb1tn/4hKFHuvrYHvBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1DIhxPVDOqRqerskBzdg6hfdkgdDRykIWrLMTfXTdrFdnwXxisu1LVpdzb0j0PtfKZtRy2acCHwhzyrwQgImov1TqVErekzB7wlxaamjo/r6VahuWq3WJiyse8K1PA3SsE+PZ62cw1qnCrjK6ABP5iuF9ji4zBaGQEjkaWnp8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qy5TRFJS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NL093BV7BiOBCgirj7UGsqM1cb1tn/4hKFHuvrYHvBw=; b=qy5TRFJSol1cjzhkFFuOxVxt4x
	GL3TKYvSMN4rpgYX5yHhCKZElg10cNpSCYXEhCXkRDBbzbPrWyLb4ubJJANlISC8UW+P5dxfy0DTA
	uCEzfgAA/5mMNHLtSr1MQusHf9S2lLdOwM9tA292tZl1wqM7wfjxbm+7yAdxmigvJ9urk/3WzFIhe
	hovxBlwtJcoChT6R1H/QNAzheoKoz8pmvPxyvY4DIW16DO+QElBXHnlErfK5zcoX+BUorSA149Ml8
	q103Yn3dDy2vjBLfXp9a9FrVIb9IAlXdG1wnNX1Zt/URNaU+cyu4l8XfgnvXPqsvBlJ9rg/YFTkJy
	DIsPJskA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swGIR-00000008OUl-38aX;
	Thu, 03 Oct 2024 07:30:47 +0000
Date: Thu, 3 Oct 2024 00:30:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 6/7] xfs: implement sb->iter_vfs_inodes
Message-ID: <Zv5IJ-zPys05iWLM@infradead.org>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002014017.3801899-7-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002014017.3801899-7-david@fromorbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 02, 2024 at 11:33:23AM +1000, Dave Chinner wrote:
> Note: this is an initial, unoptimised implementation that could be
> significantly improved and reduced in size by using a radix tree tag
> filter for VFS inodes and so use the generic tag-filtered
> xfs_icwalk() implementation instead of special casing it like this
> patch does.

Looking at how much this duplicates from xfs_icwalk that would be very
nice to have.


