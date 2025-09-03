Return-Path: <linux-fsdevel+bounces-60123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 578C1B414B6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 08:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25FE1560E09
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A102D77E7;
	Wed,  3 Sep 2025 06:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PgV22Q2B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB6A257851;
	Wed,  3 Sep 2025 06:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756879793; cv=none; b=jGA2d3ULWgqOdSutqeoW42fv/CvmuAF2M/fuho78Pn0+8+hc5IJ1iSX75QnUyixLEgs29xQa6r95FrjgpnL79SWv5F4uUsYs1UxJCXskNs9YYoKEBN7c9FjxeZLll3Io9J629tF/v/k2DH6FrHBbk2FruiB5D9nZjYyos367TmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756879793; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i90Wg+1LS+GkyFZb4i4dG/HSEoFNh9m3Jq6kPUYVeRPyW4ZJBA70aCwRZtLXon7GQGX+zeqmLSNfPqMlR4no1QvYKULP73O3azf+8JaOZcEz2oSiRSnEf4zQmsix1JM4aUvW6ITHdqPml7IW2l8txlRqtxXqxmr8hzOWT3ErzdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PgV22Q2B; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=PgV22Q2BqEmUv1vindbLd4nOxq
	NLfanvGuRBr38AXF8k9N/6GD7N/eRhr+EUYvFaWepzQkU4y8Y+wtU+Wo3WGlUEZGSfozM6fFXBhcG
	0L/+D1Y1lBvuPKp2gHRhG8xg5ggJu3RIqc7Qn0R0oCQylV3P/raqX27TTVLUBEvrvJXqOkgWTDZC6
	khzPh+muKFpRTEFS4DSmYRl59AWIitwrT/+GW5SCx/KrWsXtTZoCkabYmRo2wTjfgrj6T8tq2OqDd
	0K8Y8sdkb3Jn1MuQDuFVT6SZGPl7LsdUViZL/+ykMZxcffQd1IRck+LxnNTCOabPVX5pjVKXbpmSe
	Vh2xD/Wg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utggp-00000004U4c-1JVX;
	Wed, 03 Sep 2025 06:09:51 +0000
Date: Tue, 2 Sep 2025 23:09:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, jack@suse.cz, djwong@kernel.org
Subject: Re: [PATCH RFC 1/2] iomap: prioritize iter.status error over
 ->iomap_end()
Message-ID: <aLfbr-LpArXGuNS5@infradead.org>
References: <20250902150755.289469-1-bfoster@redhat.com>
 <20250902150755.289469-2-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902150755.289469-2-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


