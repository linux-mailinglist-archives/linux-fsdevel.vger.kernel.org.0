Return-Path: <linux-fsdevel+bounces-14199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2714E879402
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 13:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E44281614
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 12:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3227A133;
	Tue, 12 Mar 2024 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nTcIedDc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7ED79DD3;
	Tue, 12 Mar 2024 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710245821; cv=none; b=C+xzX6TXit60Vjcme4P4oMyVUZRYXdleqpHuY/hoqPkbvXncFFNW1CHF3SilIK2WpniIOWfEk4yUSOtyiBPzbzTOsoTiQF3YO7f1Gxepci/I9y4+lP7jClgU6kOwkWJcgCTETpTqScqQ/72qA6McT30RMtJ294MfFtqdNyStioA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710245821; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2FF5pn6QbCWYTcqGwDrH1X1ZXUEhFSspJXxVLdPHeERCYau77MHALXgi30bmrnx1lc2PJB+aAsSNzLlQmGib7Cznh9kIcBlt7MVs8fpJZY+Br6Lmc17eGC/CFLS1wwQq1OyvqTp6br5daeupUtAhc9HTEJC0ppKGnP9LnzAPsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nTcIedDc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=nTcIedDcpLOry+oMcbIxJjnKg5
	ko68aMsKEdwj4L9hhlrrKo0ESZlqeYnTjZuukyy6FOC0z+FE5f0e0BQRHxD+QU/TCi6+6ohaUBMvX
	3cztJhT1ehVdgquYTvoWeL5xtcpCWpg8kSnJaq4W2wpf4SRBPPyKWcN2isLu3tl3RlRjNDcMmA9Lv
	KMnjHOt0r6v5qZ8m26fdV0DpO3WWxOx1ycb49hEtKMFg1lnbN9cjs+tmD0cG/9ydnUorAj9murhrx
	dyKpONqG6kvUvJySLJSpp2ndZJ86vo7QgihKafOom2vkiBv6wIHSFx75NK/UgPb0NQfi2t4Q/9UrD
	fv4Miv+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk13x-00000005hnF-07n2;
	Tue, 12 Mar 2024 12:16:57 +0000
Date: Tue, 12 Mar 2024 05:16:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, tytso@mit.edu,
	jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH 1/4] xfs: match lock mode in
 xfs_buffered_write_iomap_begin()
Message-ID: <ZfBHuMAefqOld0sa@infradead.org>
References: <20240311122255.2637311-1-yi.zhang@huaweicloud.com>
 <20240311122255.2637311-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311122255.2637311-2-yi.zhang@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

