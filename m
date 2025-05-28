Return-Path: <linux-fsdevel+bounces-49953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 157DFAC6416
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 10:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E263AB7BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 08:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4543024677C;
	Wed, 28 May 2025 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J3+f8KPl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AA73398A;
	Wed, 28 May 2025 08:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748419977; cv=none; b=G1V5tKYIfKR7kF1av35GLxIIno6b/m9ipixL7+5QTANKYEQ3+8Z32NfVkLFBluJduv2zDobu7zK8BuJLTmF8ar7FPczwlPzTpTiR7RMGT+lbbV1LlR1/TNOICK4EZlcpSNNwTRy1Sjobd9CfaSgY5LU7M2uDItWLGkgwMD0a+DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748419977; c=relaxed/simple;
	bh=k9MOPZoc9uZcsfEqcrm4H520EINP7BvV1el9VtjaTi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VueLa2OLNC7cGgRnBQcRG/pg9wnzi1puO803tOg5wDA80KXRplTW++szxfIg+OCWHef+V9NfobMYzxafg/qALV5hEd5HAB09sDMReSthPkfybyDf3Icy09DhRVLiON6rI91N0hWdrW58jc9tvd0eF2FlKCebB2gHo8rAUFWWHrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J3+f8KPl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k9MOPZoc9uZcsfEqcrm4H520EINP7BvV1el9VtjaTi8=; b=J3+f8KPlDjC3pzb+vHk+g2G7N/
	kNmq0LMmjGwFs8W9zH2rWqS4TLXJ5bVLdXINuxTG+7FD8nBuPQrLpAUvvHulEY543+iLSMum038Yf
	H3SOCSzMWZv6VMEPsEk05iXHddqWEhsVaMGAB4jY4qY6+p3oM4OCTzXEU0wDSodfpBkI/0cXSGGXz
	0JKqvVaz6l8V8mIYjv8oaG0iFgBBBFCzELq6xN4b9uCsPUUzBCuTwrjP2Xg+DwfHx/lALm2CmowE0
	HA1pAFSZPYmEDDGqu9gRfauz0GrXT5FAxbSnktJ6riIjR80g+4+/qUyfdKLSyKZXI2bi6sntclZfX
	eOC3fZxA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKBuA-0000000CWlU-1yeg;
	Wed, 28 May 2025 08:12:54 +0000
Date: Wed, 28 May 2025 01:12:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	djwong@kernel.org, brauner@kernel.org,
	torvalds@linux-foundation.org, trondmy@hammerspace.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/5] mm/filemap: gate dropbehind invalidate on folio
 !dirty && !writeback
Message-ID: <aDbFhjfbszpAtK-9@infradead.org>
References: <20250527133255.452431-1-axboe@kernel.dk>
 <20250527133255.452431-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527133255.452431-2-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 27, 2025 at 07:28:52AM -0600, Jens Axboe wrote:
> It's possible for the folio to either get marked for writeback or
> redirtied. Add a helper, filemap_end_dropbehind(), which guards the
> folio_unmap_invalidate() call behind check for the folio being both
> non-dirty and not under writeback AFTER the folio lock has been
> acquired. Use this helper folio_end_dropbehind_write().

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

