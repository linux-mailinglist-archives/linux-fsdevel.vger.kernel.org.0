Return-Path: <linux-fsdevel+bounces-43768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 206E1A5D765
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 08:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD12C189E057
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 07:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88381EFFB0;
	Wed, 12 Mar 2025 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gvk5qrkh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA711EFFB2;
	Wed, 12 Mar 2025 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741765023; cv=none; b=V9pgm3TyNYtP1zkcclejMmNNey6CbaskNJ8gL3L63gc1xX8lSNXWiKEcde9TCNWYi16n9HDOb+fSY9IQtZS1UXphExOTxVI3jjby5KeRRM17dHtG2Z3fQpKKKiL73Av9TbuUDAiExXLQ1pqWJ8HPRkHMnrAVFYkLktf187pwxPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741765023; c=relaxed/simple;
	bh=9WDvMlax5GMtGMX2KE7aCiiVjM7oukTeaIvua618FUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iz9tROrQqtIQhH8L24vgUaVEYewhBxE46gv+Rhfxg9zmIIXG3myZ3ztdhBpL1OaLLHKERAOXR/A3P9oTgXY3UiDncnIwnkoyi/itT+xCyNH+YBZHW3A8YBUbkMo6pG9Xcn+vNhTMqe71v4NE0yncccupRT65aFMdxEFHR/3/soE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Gvk5qrkh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CXfgeNXdrWiHE5y6lsnibLhPb3YMKY8O67MCv6tPCFE=; b=Gvk5qrkh4UjeJ/5aXdTbgH6l4k
	LlZh17xU8MlBz9wGR0q6wk/Uk7Yqhup1Vij6Y/GOyhIEPFShMa2Km0oVDPOc/TxyzVsZB6Pgoq+ag
	WWTnlNfxV57lpTzVOvKLkDVhP9twPoQx4nKIflEsb2Is13CykTQMVLN2zh+2aJu1gMaZIBAQneKAS
	0RV9ij7+Jkxrs0YR2i+BubuITpsiiBZXxvOPHkAvjsFcEsmDYng0/G5+pcSOe+eHFKbBHVq96zagk
	dlxJq+459ZQuDN7kwE5D6GsXs7WWTRiIA8z55GRWqaN8Lkcz/9s97Pzbf/fEn6hS2umu2qkeSbaLm
	f/4ddRow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsGeC-00000007iT3-3xwf;
	Wed, 12 Mar 2025 07:37:00 +0000
Date: Wed, 12 Mar 2025 00:37:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com
Subject: Re: [PATCH v5 05/10] xfs: Iomap SW-based atomic write support
Message-ID: <Z9E5nDg3_cred1bH@infradead.org>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-6-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310183946.932054-6-john.g.garry@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 10, 2025 at 06:39:41PM +0000, John Garry wrote:
> In cases of an atomic write occurs for misaligned or discontiguous disk
> blocks, we will use a CoW-based method to issue the atomic write.
> 
> So, for that case, return -EAGAIN to request that the write be issued in
> CoW atomic write mode. The dio write path should detect this, similar to
> how misaligned regular DIO writes are handled.

How is -EAGAIN going to work here given that it is also used to defer
non-blocking requests to the caller blocking context?

What is the probem with only setting the flag that causes REQ_ATOMIC
to be set from the file system instead of forcing it when calling
iomap_dio_rw?

Also how you ensure this -EAGAIN only happens on the first extent
mapped and you doesn't cause double writes?

> +	bool			atomic_hw = flags & IOMAP_ATOMIC_HW;

Again, atomic_hw is not a very useful variable name.  But the
whole idea of using a non-descriptive bool variable for a flags
field feels like an antipattern to me.

> -		if (shared)
> +		if (shared) {
> +			if (atomic_hw &&
> +			    !xfs_bmap_valid_for_atomic_write(&cmap,
> +					offset_fsb, end_fsb)) {
> +				error = -EAGAIN;
> +				goto out_unlock;
> +			}
>  			goto out_found_cow;

This needs a big fat comment explaining why bailing out here is
fine and how it works.

> +		/*
> +		 * Use CoW method for when we need to alloc > 1 block,
> +		 * otherwise we might allocate less than what we need here and
> +		 * have multiple mappings.
> +		*/

Describe why this is done, not just what is done.


