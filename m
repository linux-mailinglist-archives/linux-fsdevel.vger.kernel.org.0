Return-Path: <linux-fsdevel+bounces-44176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51576A6438A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 08:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC3A188EA86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 07:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA66F21ABC1;
	Mon, 17 Mar 2025 07:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fgmNswqL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEBD18C337;
	Mon, 17 Mar 2025 07:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742196401; cv=none; b=hrpPL0qS57dDjp/x0DtKgZW4gIcMs4PF/xYo2ZqIQKA33HZoUHQv+j6RMn4LWX9EH2nNb1dL3r3TEym04CwLHuywlnRlDsuUwSiXitHw/taen3XEys+L9JjMHLyK9Euw0IPP+69RNc1bkvy1XbUY8rFQCLFcXpwiIqpE69tBi6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742196401; c=relaxed/simple;
	bh=/EBRr78bTB7IPtkQ2GQhjr3zyZBWGf4fgSULQAsILI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLmG9th312JNKiDVA+NEGthW6qAijgRNghk8hAEeihT2pKVVh2mkVZc3NKURBpOBy+xGeNbQwaB7ddBOinIcS2kg80BuJoMA3fAOrM+Lk7vPEA8zsdHoi7wvyDoUjzK7JeEO2J0XAJU1Vkogo5cKO5QLmgklVnqFnxT002GIZVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fgmNswqL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=97Zv7Mg/W+abiVwjRppBEMgRyPJcNS2X06DHf2ypa3M=; b=fgmNswqLxJa3sk4NgrMJ9DWkqJ
	X6Vu3CK2L09BSigewCJ/VxWxVem/WsrEjnIPcSpeIQlrldKYlkTOEZJQITlXR3aO4qaerh3cpHoT3
	vh/0CaBWgMWJtetdepMX8Qy9dNwbGn0N17Nu13Nj6hRdB1w4ayODQEbqT7GVh9JGwHtKMiMiCPO/9
	gU96B8IPHnfoVOE5UuIfCXEkHruQLxkaRwv5nL46KWTunrZSG4W6dUnyr+oRS+EI0TWQjhw4042zp
	2yC6KbGCfDQv2h4vbRome++dMgaVLOt1DZSDLBRO0QhVhYK49tXxXr9mBp0XOzXM4h1OVhIau973b
	guCKRbHA==;
Received: from [2001:4bb8:2dd:73af:768b:3020:1cfb:1718] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tu4rq-00000001Ywb-28Cw;
	Mon, 17 Mar 2025 07:26:36 +0000
Date: Mon, 17 Mar 2025 08:26:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	dchinner@redhat.com, hch@lst.de, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 10/13] xfs: iomap COW-based atomic write support
Message-ID: <Z9fOoE3LxcLNcddh@infradead.org>
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
 <20250313171310.1886394-11-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313171310.1886394-11-john.g.garry@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +static bool
> +xfs_bmap_valid_for_atomic_write(

This is misnamed.  It checks if the hardware offload an be used.

> +	/* Misaligned start block wrt size */
> +	if (!IS_ALIGNED(imap->br_startblock, imap->br_blockcount))
> +		return false;

It is very obvious that this checks for a natural alignment of the
block number.  But it fails to explain why it checks for that.

> +
> +	/* Discontiguous extents */
> +	if (!imap_spans_range(imap, offset_fsb, end_fsb))

Same here.

> +		if (shared) {
> +			/*
> +			 * Since we got a CoW fork extent mapping, ensure that
> +			 * the mapping is actually suitable for an
> +			 * REQ_ATOMIC-based atomic write, i.e. properly aligned
> +			 * and covers the full range of the write. Otherwise,
> +			 * we need to use the COW-based atomic write mode.
> +			 */
> +			if ((flags & IOMAP_ATOMIC) &&
> +			    !xfs_bmap_valid_for_atomic_write(&cmap,

The "Since.." implies there is something special about COW fork mappings.
But I don't think there is, or am I missing something?
If xfs_bmap_valid_for_atomic_write was properly named and documented
this comment should probably just go away.

> +static int
> +xfs_atomic_write_cow_iomap_begin(

Should the atomic and cow be together for coherent naming?
But even if the naming is coherent it isn't really
self-explanatory, so please add a little top of the function
comment introducing it.

> +	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb, &imap,
> +			&nimaps, 0);
> +	if (error)
> +		goto out_unlock;

Why does this need to read the existing data for mapping?  You'll
overwrite everything through the COW fork anyway.


