Return-Path: <linux-fsdevel+bounces-72201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C362FCE79B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 17:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33EDC30028A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 16:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D6F28488D;
	Mon, 29 Dec 2025 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PT3M8txn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AA43A1E6E;
	Mon, 29 Dec 2025 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767026343; cv=none; b=rppXUtiVc6vAWWRIUuT516qUgzIdTKyuXChsiheKM0BGRmwMVFgV8hlh+SGFWPOokRutgCkGsCcw92J1jkr2ABX8UFPRpBnCuWeXO61AoiO8vSYNfjvB2IaKZpNuZk6iRsUMWTxvGlI8T/l8/2m7H4nZRNXSu7x5tEIQyaGqxXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767026343; c=relaxed/simple;
	bh=mDH5OFlr0PQR1nKY+Vt8Er76TR3RXUilxLoCxZATF3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uf5ooaYyAPaPxgrlNvruoFKiTp8AQCQPGZmuuC9FZex7DcZtfdqiEC9xLNo93RwJ+tPrRGULUZNLboBsHFw6LlIVstrYX0cVg8XpE8mphGIEbauGS6RS77K1gPb1B2Cypr/p9k+RW8ug5G5PKGXA98aUQoSmh55whPuzGB1EYQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PT3M8txn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Bi139usmA7/F56mDRTwGJt8eoXLId1WUvtud5poscp8=; b=PT3M8txnxp6d2KoTOGoA8e9lZ0
	bEtbmzoGG9q42o6C1mHdVD9HfGoKSEiTbEvnhx9BgsQ05z2kdJtLxuGbuUMgRIJpiWyRiCMaul7C0
	9a8UvLGizSWD74gAQ4nL0O0yAgcO6IqW2xrZwjrHFKLCu7fyzSf2TrmhA/rA1tY52KOLqUOFRsPj9
	61VmEREFIbNVBeuvn1Ah6CTXi7wSJufAE24VxhZ6utQGVcez7XvcIzuSxLdzfBEhIIVIeB3N7Ou/Z
	yNGOU9tkiGfPXYHx88mCJmdWRJpMP5TqZQNScFHIDymFtk5M8uewUlQLfT77RPiVTWoPqEMBR1JSq
	VL7evhvA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaGGX-000000025jr-0M7U;
	Mon, 29 Dec 2025 16:38:41 +0000
Date: Mon, 29 Dec 2025 16:38:40 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org,
	hch@lst.de, tytso@mit.edu, jack@suse.cz, djwong@kernel.org,
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com,
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org,
	ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
	gunho.lee@lge.com
Subject: Re: [PATCH v3 13/14] ntfs: add Kconfig and Makefile
Message-ID: <aVKukOG-Oa0-3pA3@casper.infradead.org>
References: <20251229105932.11360-1-linkinjeon@kernel.org>
 <20251229105932.11360-14-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229105932.11360-14-linkinjeon@kernel.org>

On Mon, Dec 29, 2025 at 07:59:31PM +0900, Namjae Jeon wrote:
> +++ b/fs/ntfs/Makefile
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for the ntfs filesystem support.
> +#
> +
> +# to check robot warnings

What does this comment mean?  I see ntfs3 also has this, so was this a
case of blindly copying?

> +ccflags-y += -Wint-to-pointer-cast \
> +        $(call cc-option,-Wunused-but-set-variable,-Wunused-const-variable) \
> +        $(call cc-option,-Wold-style-declaration,-Wout-of-line-declaration)

-Wint-to-pointer-cast is already enabled by default,
-Wunused-but-set-variable is enabled by -Wall, so both of these can be
dropped I think.


