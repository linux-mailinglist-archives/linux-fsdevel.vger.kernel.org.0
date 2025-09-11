Return-Path: <linux-fsdevel+bounces-60923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDB4B52FCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 13:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB4387BF31E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 11:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3D031C578;
	Thu, 11 Sep 2025 11:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QhZWGh/v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F9631AF2C;
	Thu, 11 Sep 2025 11:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589060; cv=none; b=S0J5mdzcSZYNr+dSIBzgirZJfqL6RJ6+Y3Vj+84udLvcCTVvGHFutdVl1VmFvUcl6yfHWV7S4XBqz+F/FGIsyJ7Blv/VjsHQyb5xMZ1XsDERm0gg4MdjHAxxnJHOfmy0QiPmKG/FxjEUoj8o+wxJYbf21USLAlX7gZrjw/liwKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589060; c=relaxed/simple;
	bh=R1UEEkewaEY237gxWGlZQwlXgxtGX1iGrJdcWNwINZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2jJgVY3pfuSw6ZT0k7YI3GPgc/l32dXNfTd7idIDxQGyNpFQYpqJMc0WEpkcj6saDj2mkTUWHqixtM9ngY+CiM+RHRCx0DlyBlzjraJXPyKNPppXm7rLSmKUhFMBxZvOM8WKCnAF7nlXJmjEa5g1LVhSYXTOa2nz3JPmTJ4zEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QhZWGh/v; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xkvXXShxzbk6EJQBaiz6XgAISjiN2pDgv7Qy0MGqvPY=; b=QhZWGh/vYZCpC1rTa+FH1H43Nq
	XRKh5e1SvdMOV/4Cdbu1ORAPPEQya9b4DhuPx4Ezcc2extl3MBLRZx9WYPbGQIxZ/2hQL5LsKJwKs
	P6ik4TlOSTV6XIrZL5pYlQoISd4RAXl9sdxvU5dPvVueAXRknznBAf+JWeloIQ5Xj/CYZ3yzw4gDc
	6NaITsJRUide7tJ3iM66WzgEPV0jBLpnfPnwVY2GoncHX13ILYbm/yLabrs6DwulZEmru6h4RYrvM
	vxgsSHaUL3CWLev8sSkCJzoXKPMDmX4e3lhUr0joVhLvOOsNCx6d0J/s+51kfAoluSlWPWWDnUNvT
	Nm+MpkLQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwfCY-00000002Zm1-3jFS;
	Thu, 11 Sep 2025 11:10:54 +0000
Date: Thu, 11 Sep 2025 04:10:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	djwong@kernel.org, hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 03/16] iomap: rename cur_folio_in_bio to folio_owned
Message-ID: <aMKuPjFjKu5NOfOS@infradead.org>
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-4-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908185122.3199171-4-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 08, 2025 at 11:51:09AM -0700, Joanne Koong wrote:
> The purpose of struct iomap_readpage_ctx's cur_folio_in_bio is to track
> whether the folio is owned by the bio (where thus the bio is responsible
> for unlocking the folio) or if it needs to be unlocked by iomap. Rename
> this to folio_owned to make the purpose more clear and so that when
> iomap read/readahead logic is made generic, the name also makes sense
> for filesystems that don't use bios.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index a3b02ed5328f..598998269107 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -352,7 +352,12 @@ static void iomap_read_end_io(struct bio *bio)
>  
>  struct iomap_readpage_ctx {
>  	struct folio		*cur_folio;
> -	bool			cur_folio_in_bio;
> +	/*
> +	 * Is the folio owned by this readpage context, or by some
> +	 * external IO helper?  Either way, the owner of the folio is
> +	 * responsible for unlocking it when the read completes.
> +	 */

Nit: you can use up to 80 characters for you comments.

Otherwise this looks good.


