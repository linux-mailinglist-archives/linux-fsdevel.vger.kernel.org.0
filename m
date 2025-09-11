Return-Path: <linux-fsdevel+bounces-60922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75522B52FBE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 13:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5321896C32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 11:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C6131B110;
	Thu, 11 Sep 2025 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zGUUI/pf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C98314A6A;
	Thu, 11 Sep 2025 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589002; cv=none; b=haT6VaFgXTZwcc00T5UgyTI81kQMyUbSZpNuxiVhShtBEtmw1qnItYR9KKSdNPIG+V0utDmAqNvZ2jbCnVFNko9WiOydFIo+/sC4LqqI+PNCuFC76bFtjkN7e75gd6tGNeINGRtJ971G0/BpZM29Cqgrv+rM3DR4gWrD/mXMg6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589002; c=relaxed/simple;
	bh=jg+VKW+kg7AOUjS5FbZukYga5Hic1fSVIRq1RrVL220=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UflHGXEpcceoklWawdjE8Rjru/2N96QBKPXqca3O1prRQW/M7DVAXhLK+4AQATUf+XHSSarB1OhdPxMgmuGDyXqfXNsncVjYl2Y3wov5NizHfhsr5YKRWfjmNajLtGi2eoOrDFShHXJR6UCoHNE3jZj+I/Rc9D/l1btfAnwLw8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zGUUI/pf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jg+VKW+kg7AOUjS5FbZukYga5Hic1fSVIRq1RrVL220=; b=zGUUI/pfqWD2SrYFd5ajlcryZi
	b0lST77jrFsgWLpD/aTEudXZ4IE04lygzYO6o6+zyQYSfLbh02R3Yso4wB80xFFa7burYJwBKLkRI
	VAxffGJFBTUa1HtnsjruM6IuW69urcfJOG6uNfeCwa/m4tsiJstWt4rKWqYDIyA3ditNXg01zbVjJ
	nai44eSsyMvk0T8O5x77Ss9y2ukmU+MfK5QisdXYRacZU5xfMvHnkEpMx60aziaQr4w4o4c0tbNxS
	5cCPzeVEhT2CBOqITvkhZ2UMqg7l1P6rBsvDSPnBc41RstvC+8OB3uAAjf/AigevQUNbm0CVHesxr
	/wDk0w1Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwfBc-00000002Yru-1pKn;
	Thu, 11 Sep 2025 11:09:56 +0000
Date: Thu, 11 Sep 2025 04:09:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	djwong@kernel.org, hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 02/16] iomap: move read/readahead bio submission logic
 into helper function
Message-ID: <aMKuBCy8684V4sdV@infradead.org>
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-3-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908185122.3199171-3-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This looks good except for the naming scheme mentioned in the last
patch.


