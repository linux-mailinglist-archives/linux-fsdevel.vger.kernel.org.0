Return-Path: <linux-fsdevel+bounces-74954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFFdBqN0cWm3HAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 01:51:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 832AE6014B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 01:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2031588B90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 00:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1346530F818;
	Thu, 22 Jan 2026 00:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5bA9/OA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0DE2192FA;
	Thu, 22 Jan 2026 00:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769043056; cv=none; b=VO8YzXwgnx1SuGB1/bHThVILqJekIhaLPhgORnRDGb55m2Lkpa8ulr2aq4Wv50apUg+0omhQ+AhIqj1xZ3/0Df8yeVoRfn+E8MUTH2mdqZEk4OXSDkod68TK66dbmVvBrdEhDbJVVpgEnrU39uak5wI6T1uYI5voXyy6fIiAG8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769043056; c=relaxed/simple;
	bh=tXZABtjRhGaaZrG/e+AO6dure1JMWV+agj6Rh68TkDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9SifswKx4vwKU7FLM9ngePhmwpiR8GpQ/Vs0WpeBhignWfIKj5ajOa1LVnmBJq/2wnXBKoC9gdY+Hz6x1OEPqFPoFBBrhLYFiF8vK85FSN2QU/M7HirbYfJPbmepUgljoqWQdKIqxr/gdt1kFZljphXTppEkc9LrfvbUbCWW4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5bA9/OA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E55C4CEF1;
	Thu, 22 Jan 2026 00:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769043056;
	bh=tXZABtjRhGaaZrG/e+AO6dure1JMWV+agj6Rh68TkDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M5bA9/OAiYeUbA4+G7fL8zkmmbXiOmPwiecNbM8khvYRAT34LVWjx9HaLeiA4J8eq
	 zB+e6JDwcv6IB6KMmvvItptlqdfVlnEgrRxsMdNY3oByU4WOOTH6P5XA9Bx0vywaPl
	 Ehq1bkiMiQ9ZVF1rVzG4W5E/K47gVnL0a2WtHO2MsvkOTADvy0p6zJxf4EzGWHYruu
	 1YKLN4TnIiCjZn4WV6fY4UfC4GiGkWV1/WN7pnhTh/8TQMZIyw0+1JQ2+KpAl97Fqk
	 I7w7K62qAZg58CMtV2plEGEnK+KzDz+TGzo6SpgZp2iic0thVIpy3+cxcwQ0nBje+2
	 iF/nb+C7wkiDg==
Date: Wed, 21 Jan 2026 16:50:55 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 13/15] iomap: support ioends for buffered reads
Message-ID: <20260122005055.GQ5945@frogsfrogsfrogs>
References: <20260121064339.206019-1-hch@lst.de>
 <20260121064339.206019-14-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121064339.206019-14-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-74954-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 832AE6014B
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 07:43:21AM +0100, Christoph Hellwig wrote:
> Support using the ioend structure to defer I/O completion for
> buffered reads by calling into the buffered read I/O completion
> handler from iomap_finish_ioend.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Seems simple enough...
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/bio.c      | 19 ++++++++++++++++---
>  fs/iomap/internal.h |  1 +
>  fs/iomap/ioend.c    |  8 +++++---
>  3 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/bio.c b/fs/iomap/bio.c
> index 259a2bf95a43..b4de67bdd513 100644
> --- a/fs/iomap/bio.c
> +++ b/fs/iomap/bio.c
> @@ -8,14 +8,27 @@
>  #include "internal.h"
>  #include "trace.h"
>  
> -static void iomap_read_end_io(struct bio *bio)
> +static u32 __iomap_read_end_io(struct bio *bio, int error)
>  {
> -	int error = blk_status_to_errno(bio->bi_status);
>  	struct folio_iter fi;
> +	u32 folio_count = 0;
>  
> -	bio_for_each_folio_all(fi, bio)
> +	bio_for_each_folio_all(fi, bio) {
>  		iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);
> +		folio_count++;
> +	}
>  	bio_put(bio);
> +	return folio_count;
> +}
> +
> +static void iomap_read_end_io(struct bio *bio)
> +{
> +	__iomap_read_end_io(bio, blk_status_to_errno(bio->bi_status));
> +}
> +
> +u32 iomap_finish_ioend_buffered_read(struct iomap_ioend *ioend)
> +{
> +	return __iomap_read_end_io(&ioend->io_bio, ioend->io_error);
>  }
>  
>  static void iomap_bio_submit_read(const struct iomap_iter *iter,
> diff --git a/fs/iomap/internal.h b/fs/iomap/internal.h
> index 3a4e4aad2bd1..b39dbc17e3f0 100644
> --- a/fs/iomap/internal.h
> +++ b/fs/iomap/internal.h
> @@ -4,6 +4,7 @@
>  
>  #define IOEND_BATCH_SIZE	4096
>  
> +u32 iomap_finish_ioend_buffered_read(struct iomap_ioend *ioend);
>  u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend);
>  
>  #ifdef CONFIG_BLOCK
> diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
> index 800d12f45438..72f20e8c8893 100644
> --- a/fs/iomap/ioend.c
> +++ b/fs/iomap/ioend.c
> @@ -36,7 +36,7 @@ EXPORT_SYMBOL_GPL(iomap_init_ioend);
>   * state, release holds on bios, and finally free up memory.  Do not use the
>   * ioend after this.
>   */
> -static u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend)
> +static u32 iomap_finish_ioend_buffered_write(struct iomap_ioend *ioend)
>  {
>  	struct inode *inode = ioend->io_inode;
>  	struct bio *bio = &ioend->io_bio;
> @@ -68,7 +68,7 @@ static void ioend_writeback_end_bio(struct bio *bio)
>  	struct iomap_ioend *ioend = iomap_ioend_from_bio(bio);
>  
>  	ioend->io_error = blk_status_to_errno(bio->bi_status);
> -	iomap_finish_ioend_buffered(ioend);
> +	iomap_finish_ioend_buffered_write(ioend);
>  }
>  
>  /*
> @@ -260,7 +260,9 @@ static u32 iomap_finish_ioend(struct iomap_ioend *ioend, int error)
>  		return 0;
>  	if (ioend->io_flags & IOMAP_IOEND_DIRECT)
>  		return iomap_finish_ioend_direct(ioend);
> -	return iomap_finish_ioend_buffered(ioend);
> +	if (bio_op(&ioend->io_bio) == REQ_OP_READ)
> +		return iomap_finish_ioend_buffered_read(ioend);
> +	return iomap_finish_ioend_buffered_write(ioend);
>  }
>  
>  /*
> -- 
> 2.47.3
> 
> 

