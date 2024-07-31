Return-Path: <linux-fsdevel+bounces-24700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D60943478
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 18:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17851C21C4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 16:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEFE1BD4E3;
	Wed, 31 Jul 2024 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n/mv1jIc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D84434CDE;
	Wed, 31 Jul 2024 16:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722444737; cv=none; b=Upsfg5kWrD/y7fXDLc08Er3YH2Jcak3h6zP2LJiiOu2CRfkmeic8vKpLyJMwG985oRo0CE05fVryE1FGsm/dfZseLoQGLiXxS3jYXfGoifbjtL3hSvZEQ45hYTvXvNwT5k03AEGAkcp77resPsSXWqwpFmSomzuCZuBuVxQCQjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722444737; c=relaxed/simple;
	bh=Py0+MUMLyP+amcrYsRQm71NOW2FLNIcd6AfpvH7QLjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aS/vdBKAMpbfrgPW04/vxmLSQvNmyfacSq36Mv7vtNHnnIqF3LTsg5l8PCxyjzoBVZkpW6xvN8eANFp9vAjAy023MaLAl5B6VM5qnt6OkFlzSJK1PABv0q5WYaWh/jA4tab7zfcSaOjssUhFjV20QU8Z+fFA6TIRs3Lj0P4jstU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n/mv1jIc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4X8mvoBdcFqyLtDyn+RpakBZQHl2koRfp36O76+J8IE=; b=n/mv1jIcFfqCWKkKbptzGtFXvo
	0/7jkcF/VDqPqrrfl5Wcsi5XvvobtlzeqBOGKwi0MvPpLOxF6MTgKTXVbrFm1Z+EBzlnDs6AFHwJx
	iJQ/yeFzihq9sBMprpamy16IGxIsISw9iZ/2e9PSxaFadX27UV80owE5YBRNNgtgHH7Y5Muks84WW
	RoVcEbPvJJBwy8+M+3rNecMU7FX9D0iz82YBW8zUCzMcdXwEgQD+OJOowOK55KV4Sat0wIKsVDiIv
	D7XGqc3GdW/fMi2lsUDrvxXAT71gtXFtF4AydsiYubLPcPmVpc+V4rMcEDP3fCrYKMGD/X7CsSjAo
	FFQyrA8w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZCYe-0000000GLu2-0Y5p;
	Wed, 31 Jul 2024 16:52:12 +0000
Date: Wed, 31 Jul 2024 17:52:12 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 5/6] iomap: drop unnecessary state_lock when setting ifs
 uptodate bits
Message-ID: <ZqprvNM5itMbanuH@casper.infradead.org>
References: <20240731091305.2896873-1-yi.zhang@huaweicloud.com>
 <20240731091305.2896873-6-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731091305.2896873-6-yi.zhang@huaweicloud.com>

On Wed, Jul 31, 2024 at 05:13:04PM +0800, Zhang Yi wrote:
> Commit '1cea335d1db1 ("iomap: fix sub-page uptodate handling")' fix a
> race issue when submitting multiple read bios for a page spans more than
> one file system block by adding a spinlock(which names state_lock now)
> to make the page uptodate synchronous. However, the race condition only
> happened between the read I/O submitting and completeing threads, it's
> sufficient to use page lock to protect other paths, e.g. buffered write
> path. After large folio is supported, the spinlock could affect more
> about the buffered write performance, so drop it could reduce some
> unnecessary locking overhead.

This patch doesn't work.  If we get two read completions at the same
time for blocks belonging to the same folio, they will both write to
the uptodate array at the same time.

