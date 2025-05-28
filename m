Return-Path: <linux-fsdevel+bounces-49956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4A5AC6431
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 10:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F3ED4E2C19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 08:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE91268FED;
	Wed, 28 May 2025 08:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ni4KDQL+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D2C247291
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 May 2025 08:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748420069; cv=none; b=OA6/IOn8l+eq8unhVhBy2/iAzaJqelQ1/GONZ/war+hJblbsuaHMCAX6l0cN7WYuSITOdzT/TPUqE9aA26IH9hsUdLOoFsmYOysH5n9gdP23lJJRwsCdG9NCxPIvuBcrnZn5Y931m5ppt2a43DFFHKk97nNaogbyEic0MFKrHCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748420069; c=relaxed/simple;
	bh=Wcvx92hp+Gb3b7PboVHtXp/MenDjmj/0vp/Z27Uc46E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUv4DPahom9kT8o0PKkRWPrCyslUHoUUn2Ytgdcd+zszE9+wzYLP5FaUrXGQ0dlrZOtl7smtJvUqT/J+URLUJmJSHRS5mo1r60V5Tap+xfFaX8NFS+3fw3RB0+VC1gVtMMKT0FBzt8mKQCYbpGnvjlJmfNQoQl5RHLomTaft3ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ni4KDQL+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8zjmapg44AuL/ZGbDOqK5Clqi2LK3TV3AEEABVxU/TU=; b=ni4KDQL+OpVQP3VoT4aMeQhFeT
	DyCmZiB8xE1MK8p0o5EOCixw6BFg7aBYw1klmz5BD25leq0hhrSxFyO9PlBqvxSWwaxdnRKHPLAP3
	1mtCBthyeHEY/zy0DulPXjo/l5EFq0+y2VmnNeM0MSNwMaZ8OujhrL7XjC6oo9kHG6Ao9L83fxRD+
	0nGBxZjJhRQl2uyO1AK/Cec3EoD8YGW95Jnof4cEqtC8iJYlwOLXAdxqwyAKFHUC07gsM1M/lupZR
	hHkfWaGnOQc50OYLh1mpg/k3EucGdLHgS2TEAE9qg2o62hwJ0Rk8P3XwV5+WfklFyQ/d5cms/HBAO
	8LcC1MFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKBvf-0000000CX8R-0dan;
	Wed, 28 May 2025 08:14:27 +0000
Date: Wed, 28 May 2025 01:14:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	djwong@kernel.org, brauner@kernel.org,
	torvalds@linux-foundation.org, trondmy@hammerspace.com
Subject: Re: [PATCH 3/5] Revert "Disable FOP_DONTCACHE for now due to bugs"
Message-ID: <aDbF46IuUB1tt2R-@infradead.org>
References: <20250527133255.452431-1-axboe@kernel.dk>
 <20250527133255.452431-4-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527133255.452431-4-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 27, 2025 at 07:28:54AM -0600, Jens Axboe wrote:
> This reverts commit 478ad02d6844217cc7568619aeb0809d93ade43d.
> 
> Both the read and write side dirty && writeback races should be resolved
> now, revert the commit that disabled FOP_DONTCACHE for filesystems.

Do we really do the revert-like commit style for re-enabling the
feature?  I would have expected a normal commit log here, just
mentioning that is reverts the commit.

The change itself looks obviously fine.


