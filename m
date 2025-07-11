Return-Path: <linux-fsdevel+bounces-54594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC69CB015C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 10:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C934484546
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 08:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331F02222B7;
	Fri, 11 Jul 2025 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mTrRmnl6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E87F1B3925;
	Fri, 11 Jul 2025 08:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752221624; cv=none; b=Inj0v7xOxdnvZ/MYB7PyC3kucnd4xlXCiO4KJkj/a934gLg9alAw1bq3XJVTaSufUzqyY88nf6TrZpZ9XvMZl/Q6GGLBTEWdDH+0ewWW7+D2edGNw6t9shXy7JMWzyPI+z25hgQKv7FZOTp3Rl65Uz07TkVgGn5a62RlJlrKekM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752221624; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daWEsO9gyWKUjntR9O3DvUfHxJZtKlMBc8o/pmAHVky646lMPBifIowHJm47wG39kZsTpsz+YslibkTFx4OvDnasqa6mFJsOG/4NsSPpe8Gccx1NsYfLuDmm2gxyb9/7iJZt/mfgfzjJalK52BKVenfFtrB0OvbAnHvTJCyVAWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mTrRmnl6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=mTrRmnl6NMuR80pklFbDImf3/r
	grhpCHRZg65NIzOfi8Sx4mJ6wk3QlVmaWdIkqdIj9cbRlefWsoCxIB3fo0pyQy1oOjZeuuM/NhK2s
	CTrG1KjE7UobAv/eH5M+5TWz5UNrC/4sJRiIUCoRf6sGVEd6KcQd3J1e+g9qLTyWRu86/TU4lYPu8
	PFpPmIPPlF+ND0GJEVdTGuWWWEcEm7VP3vaBVHmWk3bn3xX9yHXiDHQYa8jbPosQ9Dm4vgufV//w1
	0VZowxgQ7tfcvcCGMtV/nHWzXMyQIoi0vsfFIRDusE/WAvsWcLUBGvaWECpKk04zZoEb3/Bvjd4Px
	QGMnn6Hg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua8su-0000000E643-33NJ;
	Fri, 11 Jul 2025 08:13:32 +0000
Date: Fri, 11 Jul 2025 01:13:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: alexjlzheng@gmail.com
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org,
	willy@infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH v2] iomap: avoid unnecessary ifs_set_range_uptodate()
 with locks
Message-ID: <aHDHrN7TdqV2bmtg@infradead.org>
References: <20250711081207.1782667-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711081207.1782667-1-alexjlzheng@tencent.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


