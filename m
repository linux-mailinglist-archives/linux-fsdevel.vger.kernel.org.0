Return-Path: <linux-fsdevel+bounces-25646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3FD94E70C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 08:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D161C21D18
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 06:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC60C1509B0;
	Mon, 12 Aug 2024 06:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k4njBcV3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08292B2DA;
	Mon, 12 Aug 2024 06:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723445121; cv=none; b=HTW4xim4EFLD+xWTVGULSKlTCTcA+u/IlZYUzqJ6fpoI2VMts1bW+WQTHP2zAQM02qHjxmQB5oMaiQHN/z3YeOm1QwbRfsUwPlWWjV3vsHJcIzz2DnV4VSRwZwu+DbQt7tDW3LSUoS69IiRupBBTX4sXYitS0Rmaa49GZOKf2kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723445121; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMb+aB8p4Xg8XLHc1o02uF03iGvwMuHKn4W4+yXyweXpjYJirjpCj/SWra4stku6hKYnLbbS4cGtcsasXNs4s3MQb0d/rth/RJXr5ZsaJT+8xQLPdQBsLx/gIVFDNbWPWCg46P1vqkB3rtVFouQ+GpUe47EqlM4dxRQReVfkDzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k4njBcV3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=k4njBcV3nujtAGkRx9y+bw0zDv
	UIKNDRp+P6N3zUK3WCe/iczCdc1mwjXt57NAaphC9VtFPV1h8XIbxqq6t+KHiTMp20s5C9v577IhE
	W4v0wR4ZFDNvJOI5+9YNEqT8bSuXtYnZo0fWz2IO+blUIV5crLdGaT3bT4LC0iv1O+J7VuGu1xpaJ
	4WmfqwjqJzBYsH97rlBfny0MFuP8vC6yaQcOO+NDw1oHx9PVifhMOaIaa6Wq9L+yLS7K8FFVgQNne
	M5FLfdPPW6giKt7GkaLG3stuh/2N/WIgc7fIo6T9vWjNQIIvXY9Lzy904uNLxHwiIBZSQrIGr4Rco
	GxaP7Emg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdOnu-0000000H4PC-2unm;
	Mon, 12 Aug 2024 06:45:18 +0000
Date: Sun, 11 Aug 2024 23:45:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Gabriel Krisman Bertazi <krisman@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] unicode: constify utf8 data table
Message-ID: <Zrmvfke-kHJmQkKa@infradead.org>
References: <20240809-unicode-const-v1-1-69968a258092@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809-unicode-const-v1-1-69968a258092@weissschuh.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


