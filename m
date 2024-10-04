Return-Path: <linux-fsdevel+bounces-30967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8069902A5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 14:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 312B2B20F59
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 12:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AB115C13C;
	Fri,  4 Oct 2024 12:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eea6kWcd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945E71FAA;
	Fri,  4 Oct 2024 12:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728043644; cv=none; b=qHjLLj2nusBCypv/fV3m4TX2QfPSrHHVbMJTbZivmRSNziY7IKlVJzHvJMHXtTbdfNP+HfaMBCFCGjDgUdLKQPZm5/lAvw7ewIHXNL8UCVXrd8eQP2OoVxpl6vzL98Yhagu7QduKAZUaVGD7xdGA2o0m8uB0lwoYXS66oO27RGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728043644; c=relaxed/simple;
	bh=VR8FzVGzGfnb4KaMGg3Jnm4JbWFQm+fBU3FHMey2U84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dj4SpPuEeMHvrpu2L3gfnynWLqTcsSKwNjZEO5mCIjzwvUvY7cIUf4Q9J6SflZ9zJFmcZ2pH5/AKvyMhj9fJXPH6pJkkCN8uhsLwmuEMPqfEqa8W2541P10KXMsaHPiF1lutkICL73LHRDGKX5cDn+x7hcFTCboPMwECkoeMU1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eea6kWcd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ERT8foYooX8pdrVgrItLKj04LRorxaL+eplhzZTEXe4=; b=eea6kWcdtj0JG7WclrxFPpKAUk
	jstdhS9Z6Hdkc4DrwZvREkffLbzSAuwbAQEI1HrJn9lxssdB8qhAzELM+8IMJzDA3g7/kZ87SHJVz
	Cbg10S0GwL60Mxx30D4ut4bx05quawAk2X/OTMyc7H4F7Uxu44KlfsWhiHbpytYeRf5/p22g+KbnZ
	HhCzKHSQUdU5OD3wXEy0+Fna62ypyPE8YKotQC7iftCrrvxkTLpxElH7HNOn+6PgwOilpGCNmq03K
	lsXk5IUYxQKSQsB7l0DrJqxGZC5glxRdg+k8adnE64zcOglmE4R9EdB06xhzvHU0avSA60Wza8wS2
	hyKis9UQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swh5c-0000000CErF-02rH;
	Fri, 04 Oct 2024 12:07:20 +0000
Date: Fri, 4 Oct 2024 05:07:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: willy@infradead.org, brauner@kernel.org, cem@kernel.org,
	ruansy.fnst@fujitsu.com, linux-fsdevel@vger.kernel.org, hch@lst.de,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/4] xfs: don't allocate COW extents when unsharing a hole
Message-ID: <Zv_ad7FI-_LwWp1d@infradead.org>
References: <172796813251.1131942.12184885574609980777.stgit@frogsfrogsfrogs>
 <172796813277.1131942.5486112889531210260.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172796813277.1131942.5486112889531210260.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 03, 2024 at 08:09:01AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> It doesn't make sense to allocate a COW extent when unsharing a hole
> because holes cannot be shared.
> 
> Fixes: 1f1397b7218d7 ("xfs: don't allocate into the data fork for an unshare request")

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


