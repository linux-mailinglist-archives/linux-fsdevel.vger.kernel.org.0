Return-Path: <linux-fsdevel+bounces-30833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAD198EA1A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 09:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7256C1F27BFB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 07:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250E884A5C;
	Thu,  3 Oct 2024 07:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zvcr0dFj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE47131E38;
	Thu,  3 Oct 2024 07:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939262; cv=none; b=K7Y8YUx9UNfUUEoGc/LXTkzCFQJw19bb0rhFRQfZwyyqPGeEnEDaKF7YbUzTP8jyaHQXKmiMQmMOcgS3Ixb5KujdgZzvCDO0mONyiTg0mJP+coslrJaVvqs5LVUp9CAf9QtdLH0umN6LnADPw9N2asWNzg9V4X/b1ig1QYKIF9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939262; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2CXlYvBFNmogDd+ByyalpdFEmeS3iHgfDZpnuKQdq2YWS66sWQEg2KDAWDaawdyZDhGsXX2O9TYQI+Z84nNLyCrjaBEVQ4jRVL8jW6ENXJHnPUrf7psB5Vm+0L3CMrfs8VcXIIAvJ/5a5zW3IyU1u9KPsBPC5jeHdrRJVNJySQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Zvcr0dFj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Zvcr0dFjxYVMPBGsznKBlGftm0
	uIeNjyjb85AopL2TmQLpONQ0lqCQ34gxvOJO9N84C+bYYD1i9zvBdITbINmqZVqekJ3HVr52AarXZ
	B0nr5tCbm9H1Qsp61s4B5ht7aPYMipY/eo3hNCu09qrV8e54MwKNRhzM3u0VhhKcjiHvSjkzgnFnB
	GLIUiwIejJrnDF0oh4/ymIV5IGTK7kces7tpZd0TbqLdQD1KnveIdlkFTteJUN4Qd9KkKNYxyBl0y
	wB8uLL/pgiwRMMmQ37lo4AaSQTR3od/f5lA9YNxxvZzuYNbeqaoTV2h3aCrMYsWOP+0EGnGZh6Ikb
	UhtFmMDA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swFvv-00000008LWo-3NZ3;
	Thu, 03 Oct 2024 07:07:31 +0000
Date: Thu, 3 Oct 2024 00:07:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 1/7] vfs: replace invalidate_inodes() with evict_inodes()
Message-ID: <Zv5Cs--ykHDQyWbp@infradead.org>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002014017.3801899-2-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002014017.3801899-2-david@fromorbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


