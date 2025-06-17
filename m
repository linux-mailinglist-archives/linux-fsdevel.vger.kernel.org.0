Return-Path: <linux-fsdevel+bounces-51839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DD5ADC148
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 07:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1A117A79E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 05:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79BB23B63E;
	Tue, 17 Jun 2025 05:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sOGu0/rh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237BF21B91F;
	Tue, 17 Jun 2025 05:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750136969; cv=none; b=oZqcd+xfC0Pnuse7Ph/SHYbNdkyeFUn/ZbjlZ3IN+O16Zgkf465z5Bw/G75lS4xY3EX77R0G0pgYwCBbUYaK2qukhTBLihBp4ZiBskB3hVJbKgRRHLzpppjCeGj4NAl5rZJQr8bYbUakPMhPOpQDVEF3pIpxs0Ap80Hun29XnBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750136969; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rH7h8R22iIH999M8S58/Vi+Kzdg7wqVDcodlxOtUGzOgddyrzJpP6fgvILgnhysAxnKps/cayYK4vW56Uw+FwTydzEVw/Fzrli4jl44SWkgfmuR4H0xUVUJnXd6SJPL5SjnMl/fd/9QLUXp/Czba0Ef0ippqRDRxFMBNzoGHIHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sOGu0/rh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=sOGu0/rhnWt+Spjk2YH463ozhA
	bAWw6AE8YNTR0P5hbmRldoA4b9TIfu0gzt+sUD+CcgYoHtPYq6h90aYx8En0GcZZCiB+h5yqv7PBk
	r7FZ9pd/jzayRWPPf/8OfBtAGQjmaostjebHgBUqwVMih8VF9DzG4J9xsbwa8wBpZcW3X+GW9Yy4Z
	m1x4ipRsfctneqkSw2ZqE1Xx9dxUnMXqYbqtSVUrG5WJHsdtC9SWT+KP5ram9v+sSZ78+tp+0QO8W
	NoJ2iRgK42OOzyndQH5yHpicaJqopHvZTFYShTl0F78s72/Uj5PDO/+xz6ekCVWP7gpClWs5LyYIO
	KcNiWh4A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uROZb-00000006Dt8-2aoW;
	Tue, 17 Jun 2025 05:09:27 +0000
Date: Mon, 16 Jun 2025 22:09:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@vger.kernel.org
Subject: Re: [PATCH] block: Improve read ahead size for rotational devices
Message-ID: <aFD4h-nLnnAMj9BT@infradead.org>
References: <20250616062856.1629897-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616062856.1629897-1-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


