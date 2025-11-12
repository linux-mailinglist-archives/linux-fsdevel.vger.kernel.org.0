Return-Path: <linux-fsdevel+bounces-68022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD32C51257
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 09:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D263AC28A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 08:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC702F83B0;
	Wed, 12 Nov 2025 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dUbe8s/F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C421D2874F1;
	Wed, 12 Nov 2025 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762936784; cv=none; b=YETwOhZ6B8KOrJUEdFSHZILy12TaHsLyYO50v6wc7xuuJxQTZ836z74UhUvIhx4+A8+KsTcB3UH/c8+x09jDxJfZKj6pFabDlBOzdjWULKz7mNRDIO1y2QPRqaPGb6FV5AKXKojNXESIxgN9r8v6AnOHt+Z9ORIs/JBmwg71umU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762936784; c=relaxed/simple;
	bh=NXvrTFkzI7pTICNzEfX6K/0yHVDrAAHG4k+1ZhAX2Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZlxeGtvR0s5N5PIsNtS43Jl7gTJiKkEk9MRaHkLnddz1YXVW4YeL644YXMQeoT7xdDz0YDeRwKOPr2UYupC441ufvQCfiANxcApMsNCTxx6EK9q0ayWF5tpJyQxuaKGJY3V9o8MW1ITvkUcKcq4+4O7RyQUoE1rSX8+Mxbs11E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dUbe8s/F; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zS+IWVh2k9UAJmmsb+JOEYcR9dVNS+mQJ3f2MKM+IWc=; b=dUbe8s/FPoF6BNcOQBXDIb8PD/
	J3MR9eWMmMHBPp4bCUPDLQXfBGOqpex15nQBuv7QJVdS9kZ+R+0SudxXkX7Qu22xlwoCxZa3zklCx
	rvrZvUNnMObjvykQQwUp88iV2JJK3GQpCENaE+g+xvTkh9Zsa/10fZJhTt8f66YP4uPDW3uR/QFqX
	xmI9uK2EUg/pDCQE0zApi6tNvtqqGrzHkNR1IyH8AnT9+htNEc+HT8h58IipK4N2EPaiE659+yvJY
	44MagKD5kze+xUuf83LB5KqVO8EyzyxU3/eRvAERIE/bgZOhyzeNuJjeHx9ziOM4QKY8JjuSrdO8z
	ec+hGM9Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ6OC-00000008N11-1Hom;
	Wed, 12 Nov 2025 08:39:40 +0000
Date: Wed, 12 Nov 2025 00:39:40 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] iomap: replace folio_batch allocation with stack
 allocation
Message-ID: <aRRHzBlw6pc3cQjr@infradead.org>
References: <20251111175047.321869-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111175047.321869-1-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 11, 2025 at 12:50:47PM -0500, Brian Foster wrote:
>  		if (imap.br_state == XFS_EXT_UNWRITTEN &&
>  		    offset_fsb < eof_fsb) {
> -			loff_t len = min(count,
> -					 XFS_FSB_TO_B(mp, imap.br_blockcount));
> +			loff_t foffset = offset, fend;
>  
> -			end = iomap_fill_dirty_folios(iter, offset, len);
> +			fend = offset +
> +			       min(count, XFS_FSB_TO_B(mp, imap.br_blockcount));
> +			iomap_flags |= iomap_fill_dirty_folios(iter, &foffset,
> +							       fend);
>  			end_fsb = min_t(xfs_fileoff_t, end_fsb,
> -					XFS_B_TO_FSB(mp, end));
> +					XFS_B_TO_FSB(mp, foffset));

Maybe it's just me, but I found the old calling convention a lot more
logic.  Why not keep it and extend it for passing the flags as an
in/out argument?  That would also keep the churn down a bit.

Otherwise the change looks good.

