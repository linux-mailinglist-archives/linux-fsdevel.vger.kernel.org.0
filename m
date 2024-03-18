Return-Path: <linux-fsdevel+bounces-14688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0431987E1D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 02:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3706282A37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 01:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1681CFBC;
	Mon, 18 Mar 2024 01:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lv+jukBo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D721318C36;
	Mon, 18 Mar 2024 01:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710725866; cv=none; b=WKFfI4CGKv6ed35SoX03MO/q4NwpSXmXVzsnurlJFsgZ8MkTYny7y/zp5hSpoUwUIpi2WO+KHJDNSMv3kkKagjSx/iDmLB9rKLF72A9reKW4bC7lO1hKxcRRtpPwKJaK0sJuUmnAgHGNfgxaficpZgh5Gpdd9iWXp/ZfvIFfKf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710725866; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTYwYbp3wHb4tPsJwQJiISfjljv67iE/kJjvg0Zap8JahVzQPAA62WGrG6AoDN44sGaxKI5UzNIDqcHjdn2Omyz0hTr0I/BH9zFrbVyKQGP+clUiHQTRNggNUy3EVYKy1I2mCqMlMo0iaW6pxm1k2WprhuES9Bm5xEI1DogJm6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Lv+jukBo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Lv+jukBolHgJVFHPYOonFCmy0W
	qBYN4yQXifwN/5WxK/nIpuUDWCo9tp3DzaQwYEDw6uxMJg01j5d6FvuHK2juZnX//qL5864SILy8A
	W0G50hrnJv5FtujweNv/DSzgeVVwZIpEwpIhawhHcUQ/TjiY08z/MYte1hxKKkFL/wDC8uBYyWqN5
	6SkDGXaxBJ0Xqkau6ZIDMiZgTcLYZQpDgj92mt7N8BrsmDVt+LrzJhVGM+HXi8z0NsFeYpMbpIvdX
	dy1Z3RIz14b+0c2XHAWp43gKq7qW2RgIU8yY5+5zRko7vrMe6uEjGcdzrCDIswQOgMcXNxJ7Q7CTJ
	h7z4m/CQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm1wd-00000006wrG-1fcA;
	Mon, 18 Mar 2024 01:37:43 +0000
Date: Sun, 17 Mar 2024 18:37:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, tytso@mit.edu,
	jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH v2 10/10] iomap: do some small logical cleanup in
 buffered write
Message-ID: <Zfea5xxdI37UAIhu@infradead.org>
References: <20240315125354.2480344-1-yi.zhang@huaweicloud.com>
 <20240315125354.2480344-11-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315125354.2480344-11-yi.zhang@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

