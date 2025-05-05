Return-Path: <linux-fsdevel+bounces-48025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F093AA8C48
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 08:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D812A168F26
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 06:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27581B87C0;
	Mon,  5 May 2025 06:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UyZZTM9t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C78EEBE;
	Mon,  5 May 2025 06:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746426316; cv=none; b=Ft+jAVQA1Fc84hohYGqU65qfo3r8ZzzGJQcjgrXXNZS2gTVKWYBMonLCnSXYDKQsPnZf7E3WgMOPV1ly1RglPsxGVtNBbwgj9RRirTXa7ZzM1aeAdi5n2cU1RvormKF/a9F5wkJtmJwErcWD4u4LTCrsi12B4cvJX8A/ibXjCMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746426316; c=relaxed/simple;
	bh=s/xMaDNLYNBf+TVFwKfhS1jR/jduc9puXHYlUILlFOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8xdNmUZTjW2bNG7tCI0GhVHWF7PxPh41FN6jybGEsurgCU/V50hRZw19jeGlcYpbuMB8fd9UP7ODDozvHyDlbwFuFN+FPVMI066SfbYRcxPGuKT8EInHBsaZgkzN9vYrt35MNfsNB8TJ8xAeQ/0XP82yAMazSsXeSf7ipfrDzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UyZZTM9t; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s/xMaDNLYNBf+TVFwKfhS1jR/jduc9puXHYlUILlFOs=; b=UyZZTM9t1sVwbNQwo9o0qPHIbp
	xX5VGpqeiifJf8K3OfYglK5GvWTFFVar7iIYS5A7dxwAiz4mUgPsh7iUPcSfx2WYG8oBee6wm7+8N
	h/kbizK0tlr0RfMhsFrfA+aBVM0jtSMmvaje8tspSqmHU/mWIvX7FA2n6T8SJnChXlOWXaxMdP0cS
	5WOSouRgoRqf99PFwdlxGcSSmipCtf+EmkqwaUIfzKadga1RvumUFIqOOHccWs+v9MzAk3rWgjjW8
	et593zzrug3y0WUZl8yu5G7P9RZHQhOeY97dnBxZG9QeCcx1VE/ltsrc3190qp1tclg48TDCTn+Sz
	SZ4qZW4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBpGJ-00000006WA3-45g6;
	Mon, 05 May 2025 06:25:12 +0000
Date: Sun, 4 May 2025 23:25:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: brauner@kernel.org, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, gost.dev@samsung.com, p.raghav@samsung.com,
	da.gomez@samsung.com
Subject: Re: [PATCH] swapfile: disable swapon for bs > ps devices
Message-ID: <aBhZx_-qZCGoR7Ez@infradead.org>
References: <20250502231309.766016-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502231309.766016-1-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, May 02, 2025 at 04:13:09PM -0700, Luis Chamberlain wrote:
> Devices which have a requirement for bs > ps cannot be supported for
> swap as swap still needs work.

This should work just fine for swap through intelligent enough file
systems not using the generic ->bmap based swap path, although
performance would still be horrible.

So no argument against the check, but please add a detailed comment
for it instead of just placing an undocumented check there.


