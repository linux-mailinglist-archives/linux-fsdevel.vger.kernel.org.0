Return-Path: <linux-fsdevel+bounces-43764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5B4A5D724
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 08:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55AE01792D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 07:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538FD1EB1B8;
	Wed, 12 Mar 2025 07:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lf0gzvzp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4536B79CD;
	Wed, 12 Mar 2025 07:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741763746; cv=none; b=WauzgY/duC92PHaa6QwiE02RNb6NT9h7gu/sp0xcjvKon7XRdpEFw5xt6IE78DSIWmCjVuzBP/KS2Qv50WG24c2CUIH8gYjnMOIRlGJLt5zzn5g9mrdYDEp5icT6/JltNwZE5DIg9xBGrOTWGTjbKTnZi4IfBLuxgl0Pf83/Gw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741763746; c=relaxed/simple;
	bh=tyu/VoV5E2lh23gXY3onXvEd0Lu1naDahKD0alV9Q1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMCXmqoJfUkJKPgpKTv4IwAPVM9d/FJh3O+2825NC/1Y4hzYUUi1bT7oucaVPK0twzicP9BHvMcxqqiX8PhqSUn23aOviT4u8V1XcQQErnv7axeuEATuvNDumxVqCeQhGBhdfmmySbNoxRlO5mKi1ohEtS4st0CZcDL3MjR09fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Lf0gzvzp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mKXNynFfzsPXuIrBpQX5UyMexUljsPaGCJJZEjTneC8=; b=Lf0gzvzpjVR5kSOzVQzQGAGxbC
	Gx5k3cFdVF/rMQr1EFMi1GruTOVsUuL+k5xJ5IYxy1KfhMw8G6i148/teXWwQ5/CSZNupuxXKkA4J
	qYJg6ouOJQ0zBVcDuiAbkogbze8JpaGDr5GKsgqsa4qvMJYMh3C+yQ8wP3k2v8309OkXLqrI6XGja
	xQHlmkMBqrzYycum5Y2vBIgk1uDHz9vhdacaOlIGTRY/GVBpOcaMXaazWowjrZ6p49WWdZh2PpSyQ
	rxKyGkqHNyCBp0lQvJH6k+RUTYAd79dxsj2EaJ/QxTOioVw2spDqVCzEJiE7sdU9lee7I6Qqces51
	/JpIeavw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsGJc-00000007gL0-2BTb;
	Wed, 12 Mar 2025 07:15:44 +0000
Date: Wed, 12 Mar 2025 00:15:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com
Subject: Re: [PATCH v5 01/10] xfs: Pass flags to xfs_reflink_allocate_cow()
Message-ID: <Z9E0oEq67RJkDn1h@infradead.org>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-2-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310183946.932054-2-john.g.garry@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

All the patches (but not the cover letter) capitalize the first
word after the prefix.  While some subsystems do that, xfs does not.
Please be consistent with the other commit messages.

> +/*
> + * Flags for xfs_reflink_allocate_cow()
> + */
> +#define XFS_REFLINK_CONVERT	(1u << 0) /* convert unwritten extents now */

Please add a _UNWRITTEN prefix to avoid any confusion with delalloc
conversions.


