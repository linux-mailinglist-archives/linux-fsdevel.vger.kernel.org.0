Return-Path: <linux-fsdevel+bounces-35241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC86D9D2E81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 20:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952241F239B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 19:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B821D1506;
	Tue, 19 Nov 2024 19:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CSWhK9IO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7204F148FF0;
	Tue, 19 Nov 2024 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732043084; cv=none; b=e/W+4zzAKwKykxOO3DcrMlKwjST8XUw7ORJp4rWaPY0gGJCgdGqB2dagsKnpORQQoakF8teCk9LEMDQWv8jaQp5wCmWo30XZcdo6R5Of6G40WY7fR3tgXQGUoU1l+kQFpdtwUfnBtAJvdza5VdNatffRci7JapP49xYmT4iTr5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732043084; c=relaxed/simple;
	bh=8CaE3KII4e+tc1syb0LbM0WcjCUHc8wR9k2CwKyVB4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XScMNeKmeO1rW2O8QCr0lDZNHpNpjm4PC2WLy0+lUM4ZTIno8klkULX3mVArkbygTgdBVcEmYav5pYEY78f+orgxUNJvPsHQGwRjvuLbmXAk1nSp2E4PWpWkJfDBV7Hv6+g1gf1ntjNfdkUe7iTZO5DJN2jzIWKigkMPNQelWAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CSWhK9IO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=15ehok7qY1cg60bj42u7BEiGtlPmHVRwDxTs3l/wT2A=; b=CSWhK9IOZIdfYjyTdPRWsC3Rs7
	pPLcobrELhFX4J4zDdeHerAOPTvXEAwZLvJfF7HZ5zXT+pauRgtheWr4wCE6FLxC/Zbyw05yZ6b5q
	Rv9LZ9/W0lN1Bn+OsWHsTpMnuVXHMa+0ggYAfLvK/OJWG4BchOIzxJHJB3HJmSHEVsm+yhBdDcbYt
	1DSXjycRTo3tIaPw6K+ZjmEM/wZ4lH/IsPcPN2bKGZ9X5PSHIkVdcLZ8e1I4iYq/2kdEkPs49AJ1J
	5NGSCBvf3V6CGw4w4RfOcYJrDMqjB9hE/LQx3EoRdKfm8XG6FAnibvmq5rYYsOH54aH2NkMChqzQm
	zulHUL3g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tDTWh-00000004QFb-3PdZ;
	Tue, 19 Nov 2024 19:04:39 +0000
Date: Tue, 19 Nov 2024 19:04:39 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] fiemap: use kernel-doc includes in fiemap docbook
Message-ID: <ZzzhR3QXRBtNJwJb@casper.infradead.org>
References: <20241119185507.102454-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119185507.102454-1-rdunlap@infradead.org>

On Tue, Nov 19, 2024 at 10:55:07AM -0800, Randy Dunlap wrote:
> Add some kernel-doc notation to structs in fiemap header files
> then pull that into Documentation/filesystems/fiemap.rst
> instead of duplicating the header file structs in fiemap.rst.
> This helps to future-proof fiemap.rst against struct changes.

Thanks!  This is great.  Feels free to ignore every suggestion I'm about
to make.

> +/**
> + * struct fiemap_extent - description of one fiemap extent
> + * @fe_logical: logical offset in bytes for the start of the extent
> + *	from the beginning of the file

 * @fe_logical: Byte offset of extent in the file.

> + * @fe_physical: physical offset in bytes for the start of the extent
> + *	from the beginning of the disk

 * @fe_physical: Byte offset of extent on disk.

> +/**
> + * struct fiemap - file extent mappings
> + * @fm_start: logical offset (inclusive) at
> + *	which to start mapping (in)

Do we want to say "Byte offset"?

>  
> +/* flags used in fm_flags: */
>  #define FIEMAP_FLAG_SYNC	0x00000001 /* sync file data before map */
>  #define FIEMAP_FLAG_XATTR	0x00000002 /* map extended attribute tree */
>  #define FIEMAP_FLAG_CACHE	0x00000004 /* request caching of the extents */
>  
>  #define FIEMAP_FLAGS_COMPAT	(FIEMAP_FLAG_SYNC | FIEMAP_FLAG_XATTR)

Do we want to turn this into an enum so it can be kernel-doc?

> +/* flags used in fe_flags: */
>  #define FIEMAP_EXTENT_LAST		0x00000001 /* Last extent in file. */
>  #define FIEMAP_EXTENT_UNKNOWN		0x00000002 /* Data location unknown. */
>  #define FIEMAP_EXTENT_DELALLOC		0x00000004 /* Location still pending.

Likewise


