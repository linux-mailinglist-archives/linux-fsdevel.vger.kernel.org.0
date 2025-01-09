Return-Path: <linux-fsdevel+bounces-38715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E00A06F05
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 08:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F9C164643
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 07:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAEB2144B4;
	Thu,  9 Jan 2025 07:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NxUiFHkS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187AA19F421;
	Thu,  9 Jan 2025 07:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736407570; cv=none; b=p6QufKITimnxOEqNTQmyAGNTRz67gk97YnXkFCVI2yrw8RYyer6g3fOSmiJwyOCl0pTj2++aZjIzj5n/1JZT2gq4eYg2OzDqENG07EE8zSOl3Bovce5SA/RJO03k190KKgLsSSqJ3IZUyb6xNtG7OgroVqBK59YqbszghGPNQRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736407570; c=relaxed/simple;
	bh=i/PfRnwVvb91invkTP3ANFcGajpe13PmT0iGstEz+Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkHTP6Fn9DbCIxLcMsw/YHiNbVwpCnTqaTAWV5eyX3hTjFAs+BcTklxAqUpC97nU/xB5fpta/Vz3sI614dUovOyEivuYesDDRH8O6pfRKjWQiyMiigY+aWld0uSIOYy9T1Rg5m1lXaz1VPVTLceK0p27yz1WZ1bhxxUqSnSjIfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NxUiFHkS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ezlV/4EJBMAJ676pi3aA8w5PWpPJ4HEyIsOrgmnK2AQ=; b=NxUiFHkSukEy00L25thneda7ot
	jlLJSwAdQntiGTnwYmj+vU5VVw6Lv2/LNvFqTA9BfNnXaw8X12f16OWaKtelEtMAu+x/fuZS8RpeZ
	dBkfB6HQfTScE0/Gyt6uOWwWSBICyjLGCnJIAfI+YUE0/dflS+9XRxO+Vk2fjbzNXYBuyw6BUX4FY
	KBcGD7xWG9RM6kG9AmdVIMPxU/KKY0dUWLjMlrhYXHx0wBXe2/U7RLpgKRcIhL1uPFeDLHZ5e7AJ9
	qtCuIc0k8gDy961wni9GRrpz8UUfcCzXCtbhpAG6vPEcfQz4Ypd/i0XRqqFJmBiE5k/lNA+3YG6QA
	UPjV790A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tVmvg-0000000B2mF-1dF6;
	Thu, 09 Jan 2025 07:26:08 +0000
Date: Wed, 8 Jan 2025 23:26:08 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH RFCv2 4/4] xfs: fill dirty folios on zero range of
 unwritten mappings
Message-ID: <Z396EO-6XNK9SAdW@infradead.org>
References: <20241213150528.1003662-1-bfoster@redhat.com>
 <20241213150528.1003662-5-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213150528.1003662-5-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +	struct iomap_iter	*iter = container_of(iomap, struct iomap_iter, iomap);

Overly long line.

>  	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
>  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
> @@ -1065,12 +1066,21 @@ xfs_buffered_write_iomap_begin(
>  	 */
>  	if (flags & IOMAP_ZERO) {
>  		xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
> +		u64 end;
>  
>  		if (isnullstartblock(imap.br_startblock) &&
>  		    offset_fsb >= eof_fsb)
>  			goto convert_delay;
>  		if (offset_fsb < eof_fsb && end_fsb > eof_fsb)
>  			end_fsb = eof_fsb;
> +		if (imap.br_state == XFS_EXT_UNWRITTEN &&
> +		    offset_fsb < eof_fsb) {
> +			xfs_trim_extent(&imap, offset_fsb, end_fsb - offset_fsb);
> +			end = iomap_fill_dirty_folios(iter,
> +					XFS_FSB_TO_B(mp, imap.br_startoff),
> +					XFS_FSB_TO_B(mp, imap.br_blockcount));
> +			end_fsb = min_t(xfs_fileoff_t, end_fsb, XFS_B_TO_FSB(mp, end));

A few more here.

But most importantly please add a comment desribing the logic behind
this in the function.  It's hairy logic and not obvious from reading
the code, so explaining it will be helpful.

Splitting it into a separate helper might be useful for that, but due
to the amount of state shared with the caller that might not look all
that pretty in the end, so I'm not entirely sure about it.


