Return-Path: <linux-fsdevel+bounces-71011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB6ACAF69D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 10:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A6873009F2C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 09:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0792D6E62;
	Tue,  9 Dec 2025 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="C/BjZ1xB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8832C2AA2;
	Tue,  9 Dec 2025 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765271617; cv=none; b=JE7oZqAU0o4nWFq2OZOn9l/VnYJlRbHCcKg6iT/a4LSszM1frIGaYe0pVbHZe+jC7hX1Zf4tloIMkyejkIaIVG6QJb9rEPL+s+h6y8vPFNmW2h727SpcTKUgP4qG7KdYEokwBNWBZPVsm/vP3faNd/IXuqBuAq1E/YpTwXwmUJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765271617; c=relaxed/simple;
	bh=WUyRxeHG2tQEC+LD1/5TFV7dFFzwWZ0Xe/eRbtMW1ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWhPXGXvAZ4eBYJ5XdEzWk5W9M7qRkdJcN7d6mPV4yFghJVSMHhKhr2LiI13OXVpuASJuGeT4hmEBVr3rV8wkqnj6Xx9fYJnBUzSLI0Dl36ZQk+CotXx/2LRBQm86KqmLnkGOHbeqShXe7Vjjqu2Oyf1CNn/L955FxGCN8Fx3ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=C/BjZ1xB; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=obStIBMpIt3uo/fyyEYbs0AzFByesLQjTm1626CXOxE=; b=C/BjZ1xBoFEjMyU1bEWNDSakYj
	6hl4h3FOSNvFJQtr/6EI7p6jyXhdS9uwUJ0piVxx7eosZNbT0Oc/cPdaWXiqnwGzYWBcfZHlFntq/
	KKxkxXlgNYRmrc1nU+E4wC6UFqMttmpWXHVe2TR6F1LLeYziJ71FhbfdshnjSE04Nf2QJ6ZVbGyYV
	YATczgrvIWEuEyXuaFNecrGN6VQ/xyaw+glQPL1dsz+kDdy8eCPGfG9H3dS3saU00HzFsBG1hAqmf
	xYeZrN6BysjpH3EwsmFqNlpLqCkQavBhzZnJ9cNVA1G/Bfe6h+y3CscjwGQbR7hN80LORabNHcyk7
	gXaeQFBg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vStnD-00000004XWD-1cmf;
	Tue, 09 Dec 2025 09:13:59 +0000
Date: Tue, 9 Dec 2025 09:13:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] file: Call security_file_alloc() after initializing the
 filp
Message-ID: <20251209091359.GW1712166@ZenIV>
References: <20251209075347.31161-1-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209075347.31161-1-tianjia.zhang@linux.alibaba.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Dec 09, 2025 at 03:53:47PM +0800, Tianjia Zhang wrote:
> When developing a dedicated LSM module, we need to operate on the
> file object within the LSM function, such as retrieving the path.
> However, in `security_file_alloc()`, the passed-in `filp` is
> only a valid pointer; the content of `filp` is completely
> uninitialized and entirely random, which confuses the LSM function.
> 
> Therefore, it is necessary to call `security_file_alloc()` only
> after the main fields of the `filp` object have been initialized.
> This patch only moves the call to `security_file_alloc()` to the
> end of the `init_file()` function.

Which fields would those be and why would ->file_alloc(), which is
not called anywhere else, depend on any values being stored there?
And how would init_file() know which path we are going to use
that struct file for, anyway, considering that file is allocated
and init_file() called *before* we get around to resolving the pathname?

