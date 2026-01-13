Return-Path: <linux-fsdevel+bounces-73448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F17D19D74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 16:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A22D3012769
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 15:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42513392B76;
	Tue, 13 Jan 2026 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xomA14eV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824472EA490;
	Tue, 13 Jan 2026 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768317706; cv=none; b=VMZdR22kG8ITdpdYbU0ohlAiFExM3xFJjwdgIwXQOh8rSg/5ZyuK4gNXsO7NJtF6Erdy/LartRqaq2D7R47Is9Z4n3e/CJGzBWnZZVEMB9L46acsiAj17bxYmHjn1/oeUKAwVN/YrsI7VjV+3LnBEJDwKaiSC9IDmq2azsHnsaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768317706; c=relaxed/simple;
	bh=XnG8cD3+5qeXbAUh8AXkTzn9ig3HRSOVhXL6ED+SMiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7k1mA/1Yw9wj59pOYEX29tLJunrF6TGVzqTKmeyGgaDZpD6eagJCjTSDsNwJ/7QN8pRh3x2XyaWVzyWNauBKjzW3jy/11brVUJa91F9OXfnROImeP0NWQR0ljVpjan2Xlov1D6mj4JSrzo2EYZpOss2wxVEUlXdxQi6kib+40M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xomA14eV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PkHPcgL/r2/sQCYYk7Tbgs3xv2a7+rqN3EI5OmY8q6A=; b=xomA14eVXNDIQFtdd0HHQoTB7E
	zdCyAopaRYT/ZMC1HRDd52yie0ZY9djWOaiJeSSd3JNvbC1NEWAZcsjGHwHmvcGycvYjYLSUAcSze
	tXHmc9c0Fki49NonLagV8PsJ/iPuhUOgcmQb0ASFXPOgGlBUjJ+8kRLLmG301tJmrH/G0bLxaLert
	UC9c6sXNj9n/Ja0qaa3jrPPzv2+Ea5ytTE61XOYk1fawrjxrVkCJb801hU6hRAH+/pVS7dYZkqkLL
	fw96oO4yE2lV/mG64uT0zCNM0k7/uphOCi77birTY2ROcuPQDd7ghnbA71Zf8M5tzKCQHyNI9+r4X
	C8S7fIvw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfgDC-00000007M9V-0lHF;
	Tue, 13 Jan 2026 15:21:38 +0000
Date: Tue, 13 Jan 2026 07:21:38 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: vira@web.codeaurora.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
	linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com,
	almaz.alexandrovich@paragon-software.com, slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu,
	adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org,
	pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com,
	trondmy@kernel.org, anna@kernel.org, jaegeuk@kernel.org,
	chao@kernel.org, hansg@kernel.org, senozhatsky@chromium.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 01/16] fs: Add case sensitivity info to file_kattr
Message-ID: <aWZjAi5rCJk6iVKw@infradead.org>
References: <20260112174629.3729358-1-cel@kernel.org>
 <20260112174629.3729358-2-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112174629.3729358-2-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +	/* case sensitivity behavior: */
> +	bool	case_insensitive:1;
> +	bool	case_preserving:1;

Given that not case preserving is by far the exception, maybe have
a flag for that instead?


