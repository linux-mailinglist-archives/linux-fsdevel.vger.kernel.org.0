Return-Path: <linux-fsdevel+bounces-36805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6311B9E97C4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 14:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908391888994
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 13:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D481A238F;
	Mon,  9 Dec 2024 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J4B4Ke2p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A523594D
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752184; cv=none; b=JYglIG59xuARuMBPB3O/g1IoW70V/MDLcsjlqHnT7VzHfkKsqnNcowUUVhTIteSG20sm4KNrBO3psZvWFRDACswisJ/cx15Y8Jo0mGoYYSBE0JFumxX42zIkLP0lpHEEz/gqY2jjAlcagyDSyeSJuSDyneZDZiKEo+7QAkvNIP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752184; c=relaxed/simple;
	bh=A98ULM84P9CyzA0dwohG2IK9MCfAb0RcXLoy5InuOZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mE0QQUXEhzeBCuNPuth/k8B4WhQ9zq7O1kErTVwUJdmLOzX4Q4efiDcE1gb/4yIRTUwACff66dIkrcGC4s1MvNXE/36uAtfezy3P4AdWjGQ3A67+Cb258+2ibLsAL6TZHnppSuaXVXLu3OkGesFHFxI8bYIQUJupbKb8lTx6fRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J4B4Ke2p; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d2Slkh6l9J3aLXrk12pvXa6OtGlOGWt/xLhzAOq59Og=; b=J4B4Ke2pUDHhk4Jd1y6Yr2+vJv
	W0SxpDHV2KSlOJNY1CQusYEDlMhhM2JUzZwGE1699KBfUUzira0d+QaSIPZI1Co/w+C1FyPGmLwOd
	/aMNKoTRs66ZLtuXyFRGDoPjvP15hx37MFLGGxjMQL6Gl7rVzCOglgtYI6tacBLGv2bUvfrOfRKIU
	jo9Ff5VdMs4eqT8O8QUtPydstkHcuAnvyl+LzODNVDELm2pj6WhQ0okioxp7iz/GlUX3xlLxreFu4
	VC6WNwlLD9tb7agDBvp94PTgZVzZkwYmXryowJlrV4G3c5Bq2dKA9zRNGV/ZAzJRPzwQUC4WFGLFo
	ReOoOYSQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKe8t-000000084i5-0fgk;
	Mon, 09 Dec 2024 13:49:43 +0000
Date: Mon, 9 Dec 2024 05:49:43 -0800
From: Christoph Hellwig <hch@infradead.org>
To: cel@kernel.org
Cc: Zorro Lang <zlang@redhat.com>, linux-fsdevel@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH] fstests: disable generic duperemove tests for NFS and
 others
Message-ID: <Z1b1d3AXTxNhunYj@infradead.org>
References: <20241208180718.930987-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208180718.930987-1-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +_supported_fs btrfs xfs

This is not how generic tests works.   They need a helper in common
to check if a feature is present or not, which then probes for the
feature.  We should figure out what the issue is here first before
doing hacks like that as well.


