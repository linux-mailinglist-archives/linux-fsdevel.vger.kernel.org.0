Return-Path: <linux-fsdevel+bounces-38711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EB1A06EA9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 08:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E167C7A37D3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 07:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71148214A78;
	Thu,  9 Jan 2025 07:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kDZEOM65"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564A021421B;
	Thu,  9 Jan 2025 07:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736406447; cv=none; b=NJ2iynpnhv4CzwSP6RDcNgQLIerXW5gkBNSbPC+zMBbmGw9r25JkGBwNm5IgZm5tk2PW0okAFw/uijYnB3+qYJW1TLHCDXO/ttUmIbhBSr1dJxUlmVsvEFs6yFeSEfBksi3aVW72Qopfk3u78UGmsjbQwq5Guqb4RBTFYY8usdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736406447; c=relaxed/simple;
	bh=pekhkn+nJwGZcO1y5dn7ppitqoq/rv3unPbldZ0Yugc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMi1G/Xl9HmCpkA4QqVKOokMVCfIEg+/GozNf+z/HZZGxIT8X4jXMzFXEoFbiYYOKhEMMj7BKca6+Po8TGUpa7rEk8OxoWf09CbXx4od9CzhbADuU0c+trIVHb4tDD4feDx45OR5iiDVfoKe03RPQWV3t6Z5mATbCFWqJQSjbBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kDZEOM65; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2dTz/6/ttopgX3sM2RfgLNZGtNwCqFJV1qF3/VzVwrI=; b=kDZEOM65vsa07X2T8l2U9agyrU
	KF/F0DKvhFgE4BtdhJ/je/8QYuAM24mXkfqs+0XAVa9lPpgxp0fiEPjKEkcsxoUA1ZL5/hL6R6brv
	IZTJecfudNZwmAEDAauN6KEn4ZrjW7dJ55qwmO3NeYOXKOHGVsSDBgrpBvOw8rn378T3GwHWq27Dp
	JqgC46vN9QxHHtaVJrJlpIkB6qaoyvJYEoqA+ZfhhFCxyofTOf0c8eCUnynFdd54x63ZxamLY72T8
	3nuB/SI7pPxSnaxVGLt6d3Vi/pCI/9rCu5FPmqrWArySCbFPyAvRqpXQFWL5YkDWcRdgopVQ2S7/D
	OLjXakwg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tVmdW-0000000Azhj-2xZP;
	Thu, 09 Jan 2025 07:07:22 +0000
Date: Wed, 8 Jan 2025 23:07:22 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/6] iomap: support incremental iomap_iter advances
Message-ID: <Z391qhtj_c56nfc2@infradead.org>
References: <20241213143610.1002526-1-bfoster@redhat.com>
 <20241213143610.1002526-4-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213143610.1002526-4-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Dec 13, 2024 at 09:36:07AM -0500, Brian Foster wrote:
> Note that the semantics for operations that use incremental advances
> is slightly different than traditional operations. Operations that
> advance the iter directly are expected to return success or failure
> (i.e. 0 or negative error code) in iter.processed rather than the
> number of bytes processed.

While the uses of the incremental advance later look nice, this bit
is pretty ugly.  I wonder if we could just move overy everything to
the incremental advance model, even if it isn't all that incremental,
that is always call iomap_iter_advance from the processing loop and
eventually remove the call in iomap_iter() entirely?

> @@ -36,7 +36,7 @@ static inline int iomap_iter_advance(struct iomap_iter *iter, s64 count)
>  		return -EIO;
>  	iter->pos += count;
>  	iter->len -= count;
> -	if (!iter->len || (!count && !stale))
> +	if (!iter->len || (!count && !stale && iomap_length(iter)))

This probably warrantd a comment even with the existing code, but really
needs one now.

> + * @iter_spos: The original start pos for the current iomap. Used for
> + *	incremental iter advance.

Maybe spell out the usage as iter_start_pos in the field name as spos
reads a little weird?


