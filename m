Return-Path: <linux-fsdevel+bounces-14201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A43687940E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 13:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E3E284B71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 12:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B1A7A136;
	Tue, 12 Mar 2024 12:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XAJMGdVo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FF3BA28;
	Tue, 12 Mar 2024 12:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710246154; cv=none; b=pwJXHox0SDINFn5sLC84yuxeExTD+xO7A393s1VCUJuJrKDM37uQaRJpOWJDiYwDY4XKUIqka5HaZDcnBmY52o8Mp31ZVywTLYVFMQjUWzyOuLQcmbSwAdjJ8rqtcl2lV5xEb1ZjElnhCXmGqopgzCxw+5P8KVxLW+BpJ93lvr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710246154; c=relaxed/simple;
	bh=zlvLjarZdeEpwMqv3ioOMOVhX7SRgglWVh5Wg6hqAjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9MBguMNNZm+dCE2PzagnLkWm8L33Tv++MzrfFOnQdMt1ulVePLBDHyM4ZyoLLvZWmh51l+s+WCBeo8MXPBMzlra1oLjvp5rp1Zv91yprnh7kU3+f63qZaQf1QGAV6c/TEs8h4TvdZZ1vrhRbuTmGYxDewG3fBu/zbXYTgy2DLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XAJMGdVo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LO2AKRd8Qpr8cRJXSnq0WdmDa4UEpoucMUOCpS9D1/w=; b=XAJMGdVoMdJVsIcluL5gL0GpcA
	R8o1KBJfBl9KSRy76maI+KMgbm1ozrr6+PVm4yhx0+UWBazHVae8neMc342CHo/QQu4YLsgYkBfxN
	9WlZYSBc0g0x6F+80AMgypNg581uxPaQS699A1PTqzBkA3y2SDSYSkeSfpLjt1Qa0K8cx6ovijdHc
	LSB3WON2jU5fWCDccUTTToMDHcHXpi2ZAYV5EigYSijC7ZqbdIlfrcMV0eHEksvzOEIr2YfQwdR8y
	bzfcX6/mff9EWVq3dk/At3xu6KryY+D/OIHffPs+BCW/kgKGMhGdeGpa8FSWkVK2R53iqKZTfOT+Z
	yxj3+ZKA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk19M-00000005itK-0dQn;
	Tue, 12 Mar 2024 12:22:32 +0000
Date: Tue, 12 Mar 2024 05:22:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	hch@infradead.org, brauner@kernel.org, david@fromorbit.com,
	tytso@mit.edu, jack@suse.cz, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 3/4] iomap: don't increase i_size if it's not a write
 operation
Message-ID: <ZfBJCJqf6zOaSYRL@infradead.org>
References: <20240311122255.2637311-1-yi.zhang@huaweicloud.com>
 <20240311122255.2637311-4-yi.zhang@huaweicloud.com>
 <20240311154829.GU1927156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311154829.GU1927156@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 11, 2024 at 08:48:29AM -0700, Darrick J. Wong wrote:
> This change should be a separate patch with its own justification.
> Which is, AFAICT, something along the lines of:
> 
> "Unsharing and zeroing can only happen within EOF, so there is never a
> need to perform posteof pagecache truncation if write begin fails."

Agreed.

> > Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Doesn't this patch fix a bug in ext4?

Only with the not yet merged ext4 conversion to iomap for buffered I/O,
which is not merged yet.


