Return-Path: <linux-fsdevel+bounces-15391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E85088DC11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 12:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED68EB25D18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 11:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337BC535BB;
	Wed, 27 Mar 2024 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DEYaU8PR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F80947F54;
	Wed, 27 Mar 2024 11:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711537656; cv=none; b=iVHFvxPaj7No8wd4ShcnVopKUBG3ZvwB7btf94cKYjDgR+RRTR2r+yXEYxP8EPqKAbwS0EG0kaYizFMpPKh7ZJgusxWKrqHyOkqkrPgWHoFloQK4Eer0xopIOe0CQXcKzF0s32dxyEa4MaAPSRxCCWGLsntjy3nK1hsn5awd5yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711537656; c=relaxed/simple;
	bh=dyPQX42V3VOeEjUzW7IqsbL9qdCa1m+6MiMJVO+YMQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiuatJf0aLbe+fme715CJYAVE8WRq2JW6nocR3Km0GOP+XDKsi9skxgCmsk0O2zlF5ubdjFF0eqqodlCjkED8E4SzDR7EzofdvCI3y9ZzyiR2Y3PXa7rlOalolu4g95ThY9KH8PxqRnvRbfgadUR+VmAxKnpMgv+5gURwh357k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DEYaU8PR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=11edJ+2RVGRqxYKfltRuwqwoO0szupMDY1aM7vPPoDg=; b=DEYaU8PR5ZMFgNAewPGj6jJa5L
	i1UMZ8SfTrjm6FOwd8KHXznYnhhu8x2rora3KWjMkmJetONZgDQrvbuShAJJ1rCJzExQHf5W7y3VV
	8d/izTEl/ADzKxOJc0dCEany64xjT9P4KisK79LEnRRbjLpX1U9H7Hokjb3m8qslGHoZJXluTFUGW
	eIX0hW0pBuypTxf0Rvgs9cA2BzWkv7grb4kpjZdV87NMRpLEmyeOghlMW5EzuDANJoRkuk7bf/PU+
	ZeCouHTbPUWtwD+LWdLngOTqv4GadVPbmZtyGG1zVvx7ScIO+C06jCeyKo0tQakdY3fP99cEovyxT
	1tA4ivxg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpR80-00000008XvO-3YwE;
	Wed, 27 Mar 2024 11:07:32 +0000
Date: Wed, 27 Mar 2024 04:07:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 01/15] vfs: export remap and write check helpers
Message-ID: <ZgP99DN7v9NVJhPs@infradead.org>
References: <171150380628.3216674.10385855831925961243.stgit@frogsfrogsfrogs>
 <171150380682.3216674.8890477329517035702.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171150380682.3216674.8890477329517035702.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html


Seems like this is the only patch Cc'ed to the fsdevel list.  Which
makes it really hard for anyone not on the XFS list to actually
review this properly as they won't see the caller.


