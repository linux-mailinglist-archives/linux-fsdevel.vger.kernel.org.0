Return-Path: <linux-fsdevel+bounces-45120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5F8A72DE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 11:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8352D1897540
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 10:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7755A20F062;
	Thu, 27 Mar 2025 10:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4A/bz+Gd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D0813C8EA;
	Thu, 27 Mar 2025 10:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743071713; cv=none; b=m57HEJMAaSegDf5cPASGOxh6EZmW+2bLg10zxD5sNk/Wnry0w1pl/OVYPrboMm3mZrte0ceQ9kp43gWkdypuUh2rzoyZQTtF5skmUUjxhZzMQFVSj2/f064pVPjqBxQvFeBtTiv6pVgWBm8c8JAU3u+h2sqOIKFdotRnQ1sL1OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743071713; c=relaxed/simple;
	bh=oh41vHWRsr2+lN+yXmNq1LUAseIV+ETEUuRKtR8YJSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuyXLRjml1LEdIH0q8dEE3umezVWcwkHRPPIanv3S5rreGM9FXZOY4zbmgF0IMKosF7ELK/hCwd7fQjmQeLXM7ydL/e1WEMXhklae8U20CXHyS6RC6zWkizBrRby+bR7gXEL3ctc7Nv2yoV03yQB2l5fRgZzhY0CqCGSgRvh4dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4A/bz+Gd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vz7gwH/RO6tD9kndiyTk4n1VVx7Bqtq1KEXYkmsRw3w=; b=4A/bz+GdyJfgtb3iEz06NJCuXQ
	FnHzoL9c0RYb0Bl7of8u6e7ryetrkThDcSkEWlILEJkCZ2N0eNV+yXX0J58r4w0HWOtveZutOKR3e
	0M17Noio+hIFFSWbg08YBWC95JrQ+b3htaWU9WOJOMl4ZravE//KoBdodOBxClqN4bl7sKKzAwuiM
	JrOMgDY+Fey2b9Gtsk0LtpjdOwulYw6DyllGfnnKR5LaaE/+MCkhhP8HDd/DUenujLsf1h5fcVJT+
	0ee0KPtY0EXca5UlmWxIr9IJH6y158y9yxcC3lb9j9JqHtEK+78f3NWQ+fr4i+UduqF59zaw1F9Qg
	tiL9r+xg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txkZr-0000000Aic9-0zNZ;
	Thu, 27 Mar 2025 10:35:11 +0000
Date: Thu, 27 Mar 2025 03:35:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chi Zhiling <chizhiling@163.com>
Cc: cem@kernel.org, djwong@kernel.org, brauner@kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH] iomap: Rename iomap_last_written_block to
 iomap_first_unchanged_block
Message-ID: <Z-Up3xt1q9swlhv_@infradead.org>
References: <20250327055706.3668207-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327055706.3668207-1-chizhiling@163.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Mar 27, 2025 at 01:57:06PM +0800, Chi Zhiling wrote:
> From: Chi Zhiling <chizhiling@kylinos.cn>
> 
> This renames iomap_last_written_block() to iomap_first_unchanged_block()
> to better reflect its actual behavior of finding the first unmodified
> block after partial writes, improving code readability.

Does it?  I it used in the context of a write operation where uncached
is not exactly well define.  I'm not a native speaker, but I don't see
an improvement here (then again I picked the current name, so I might be
biassed).

> +static inline loff_t iomap_first_unchanged_block(struct inode *inode, loff_t pos,

Either way please avoid the overly long line.


