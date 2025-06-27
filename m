Return-Path: <linux-fsdevel+bounces-53212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C113FAEBF93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 21:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EE091C463E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 19:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39EF20FA94;
	Fri, 27 Jun 2025 19:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R9eBJV3M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A8F202C3A
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jun 2025 19:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751051711; cv=none; b=C5qfO9j5sMl2EkVXtvZOBSXz1Pi17jEyfAYmm2fhURO0Urpq5JRoolSMeibBTgLoYpMMm15Dmrg7xvDSMp9oXI8XheCx4ZgTLo+sOoLG9PBV957RYYWZWpdTtsLkDPyW18hPErAWyF7tWUdeW+xGmCu6TfwyEiSEyTcNc3S7fjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751051711; c=relaxed/simple;
	bh=SY70xkPa6mJlmsfKBvrjeQYhdfFQN5MBR1J/QFlBzTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWYlaipBdrjwHT89e8SKRT3NGL8KXmpOfhrAbGcWXDwA8BKTAff9WtWW4ywWWxoTpFxX8WpuzibWifNLlO473oYA5vS8+IhLdYojqcXxtq9m9CTTvFyl4uPY1BMwa0ZgNmNmv6WBiOllxoQe0zpJ+sYydMO+mUlHvVA2wkTSqy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R9eBJV3M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751051708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CYSrLAo09ExIjtjKGHrLSh/0TiMV2cB4z2DIrI0u/xE=;
	b=R9eBJV3MX0dOWGicNj74/pteVoXUxM9iOj1mkcsILxHlEDestzu2UYaJLTenjXWrbMEWsa
	y4GXtKGB1QP7hJFb/ZGqGxeGzFxngd4ZnAyr4diCa8jLDJbJpP0kcQi6/hyk3AFn/5Yi9P
	8w0WmUdDhL874nPnQk1eXsdvn6hDTYI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-CMyhJzmuMdSDIRomBQcwvA-1; Fri,
 27 Jun 2025 15:15:03 -0400
X-MC-Unique: CMyhJzmuMdSDIRomBQcwvA-1
X-Mimecast-MFC-AGG-ID: CMyhJzmuMdSDIRomBQcwvA_1751051701
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9D851809C8A;
	Fri, 27 Jun 2025 19:15:00 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.142])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DBA1180045C;
	Fri, 27 Jun 2025 19:14:58 +0000 (UTC)
Date: Fri, 27 Jun 2025 15:18:36 -0400
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 11/12] iomap: add read_folio_range() handler for buffered
 writes
Message-ID: <aF7ujFij4GmYuYPu@bfoster>
References: <20250627070328.975394-1-hch@lst.de>
 <20250627070328.975394-12-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627070328.975394-12-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Jun 27, 2025 at 09:02:44AM +0200, Christoph Hellwig wrote:
> From: Joanne Koong <joannelkoong@gmail.com>
> 
> Add a read_folio_range() handler for buffered writes that filesystems
> may pass in if they wish to provide a custom handler for synchronously
> reading in the contents of a folio.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> [hch: renamed to read_folio_range, pass less arguments]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  .../filesystems/iomap/operations.rst          |  6 +++++
>  fs/iomap/buffered-io.c                        | 25 +++++++++++--------
>  include/linux/iomap.h                         | 10 ++++++++
>  3 files changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
> index 167d3ca7819c..04432f40e7a2 100644
> --- a/Documentation/filesystems/iomap/operations.rst
> +++ b/Documentation/filesystems/iomap/operations.rst
> @@ -68,6 +68,8 @@ The following address space operations can be wrapped easily:
>       void (*put_folio)(struct inode *inode, loff_t pos, unsigned copied,
>                         struct folio *folio);
>       bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
> +     int (*read_folio_range)(const struct iomap_iter *iter,
> +     			struct folio *folio, loff_t pos, size_t len);

Whitespace ^

>   };
>  
>  iomap calls these functions:
...
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index a77686977a2e..1a9ade77aeeb 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -667,22 +667,23 @@ iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
>  					 pos + len - 1);
>  }
>  
> -static int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
> -		size_t poff, size_t plen, const struct iomap *iomap)
> +static int iomap_read_folio_range(const struct iomap_iter *iter,
> +		struct folio *folio, loff_t pos, size_t len)
>  {
> +	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	struct bio_vec bvec;
>  	struct bio bio;
>  
> -	bio_init(&bio, iomap->bdev, &bvec, 1, REQ_OP_READ);
> -	bio.bi_iter.bi_sector = iomap_sector(iomap, block_start);
> -	bio_add_folio_nofail(&bio, folio, plen, poff);
> +	bio_init(&bio, srcmap->bdev, &bvec, 1, REQ_OP_READ);
> +	bio.bi_iter.bi_sector = iomap_sector(srcmap, pos);
> +	bio_add_folio_nofail(&bio, folio, len, offset_in_folio(folio, pos));
>  	return submit_bio_wait(&bio);
>  }

Hmm, so this kind of makes my brain hurt... pos here is now the old
block_start and len is the old plen. We used to pass poff to the
add_folio_nofail() call, and now that is dropped and instead we use
offset_in_folio(..., pos). The old poff is an output of the previous
iomap_adjust_read_range() call, which is initially set to
offset_in_folio(folio, *pos), of which *pos is block_start and is bumped
in that function in the same places that poff is. Therefore old poff and
new offset_in_folio(folio, pos) are logically equivalent. Am I following
that correctly?

Brian

>  
> -static int __iomap_write_begin(const struct iomap_iter *iter, size_t len,
> +static int __iomap_write_begin(const struct iomap_iter *iter,
> +		const struct iomap_write_ops *write_ops, size_t len,
>  		struct folio *folio)
>  {
> -	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	struct iomap_folio_state *ifs;
>  	loff_t pos = iter->pos;
>  	loff_t block_size = i_blocksize(iter->inode);
> @@ -731,8 +732,12 @@ static int __iomap_write_begin(const struct iomap_iter *iter, size_t len,
>  			if (iter->flags & IOMAP_NOWAIT)
>  				return -EAGAIN;
>  
> -			status = iomap_read_folio_sync(block_start, folio,
> -					poff, plen, srcmap);
> +			if (write_ops && write_ops->read_folio_range)
> +				status = write_ops->read_folio_range(iter,
> +						folio, block_start, plen);
> +			else
> +				status = iomap_read_folio_range(iter,
> +						folio, block_start, plen);
>  			if (status)
>  				return status;
>  		}
> @@ -848,7 +853,7 @@ static int iomap_write_begin(struct iomap_iter *iter,
>  	else if (srcmap->flags & IOMAP_F_BUFFER_HEAD)
>  		status = __block_write_begin_int(folio, pos, len, NULL, srcmap);
>  	else
> -		status = __iomap_write_begin(iter, len, folio);
> +		status = __iomap_write_begin(iter, write_ops, len, folio);
>  
>  	if (unlikely(status))
>  		goto out_unlock;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 482787013ff7..b3588dd43105 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -166,6 +166,16 @@ struct iomap_write_ops {
>  	 * locked by the iomap code.
>  	 */
>  	bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
> +
> +	/*
> +	 * Optional if the filesystem wishes to provide a custom handler for
> +	 * reading in the contents of a folio, otherwise iomap will default to
> +	 * submitting a bio read request.
> +	 *
> +	 * The read must be done synchronously.
> +	 */
> +	int (*read_folio_range)(const struct iomap_iter *iter,
> +			struct folio *folio, loff_t pos, size_t len);
>  };
>  
>  /*
> -- 
> 2.47.2
> 
> 


