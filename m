Return-Path: <linux-fsdevel+bounces-41634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9EEA33865
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 07:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505393A917D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 06:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC38A207DF0;
	Thu, 13 Feb 2025 06:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rHehbT0v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20094207DFB;
	Thu, 13 Feb 2025 06:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739429986; cv=none; b=D9HZm6mBr7FDUtiB2JE4w3TtWUQHs0tXySiH/tTw/cS9bwNoYvKOCgoioHItAGMUhRkohFOP9YZSG3HXIZB0Q9t5V2l5iU4O4h8dIH56fHluvvomDIdXLQx3kMot4g3521aMQqlFTZonEC6Oq9WJKKsNGhc38XbBGFCWRLY/2UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739429986; c=relaxed/simple;
	bh=sgnBANpLS4PVSv90/NeS/8xpIYjB1vRMQhWOMnFGE5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwaoMIJzrDuh7zrrT2RxPoignMegX2W722o2tNGnsyjvmzoJvMc12GY4wp3LX5299sGHt4J6t4DV4zmBNsLeZe6JhV4jvGAwYW309YBjeD4k7QnYVLoZ9dEKbpgv2gDDeN8rA6EA3iYxUUdLW2DJ8s3X4jxVnD5or6MJ9ABl89A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rHehbT0v; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=H/fwp2CzdPSdVolxuwB+Q82ZwGKMq6kS8ilkl69DJ78=; b=rHehbT0vW+JP7zXmKCjZs583dP
	R6xEzHFqeZKXBRKewgsW5f9PyX5RN2h0CgSfZXUFsz61vNt6hhdWc49Z9r+EZQ/w43tN+1ZENI78j
	RUqE7f4T5Xi2gBxO1MbGMgXtpFWlgkX5JYsnfNwD3foOnR80qFeplf4im6z2+IN2Vx9osZszZ/CV+
	S0NEMrLb+USmQMa5y5rPKreRV1zUjYQs9VV+ujnio0ZavcSmQdQ5VpfRQswqFvAe8Gp0mZ6VlwgWD
	D+n4H2A2n7EAXu9VzdQjMY4APgCDMsX9T4KGmOTtYwNDJY6ceMUqNFfBi7aU9+mLZzon/SvkYA9Jk
	9tG/rwwA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tiTCK-0000000A1mz-2quv;
	Thu, 13 Feb 2025 06:59:44 +0000
Date: Wed, 12 Feb 2025 22:59:44 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH 09/10] iomap: remove unnecessary advance from iomap_iter()
Message-ID: <Z62YYEKE8n8qIsMc@infradead.org>
References: <20250212135712.506987-1-bfoster@redhat.com>
 <20250212135712.506987-10-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212135712.506987-10-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Feb 12, 2025 at 08:57:11AM -0500, Brian Foster wrote:
> +	ret = (iter->len > 0) ? 1 : 0;
> +	if (iter->processed < 0)
> +		ret = iter->processed;
> +	else if (!advanced && !stale)
>  		ret = 0;

Maybe reshuffle this a bit as:

	if (iter->processed < 0)
		ret = iter->processed;
	else if (iter->len == 0 || (!advanced && !stale))
		ret = 0;
	else
		ret = 1;

Otherwise this looks great!

