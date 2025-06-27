Return-Path: <linux-fsdevel+bounces-53211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96832AEBF8A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 21:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5A6556554E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 19:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB65207A0C;
	Fri, 27 Jun 2025 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXDLSSv6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5649205E3E
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jun 2025 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751051696; cv=none; b=SPhPgCs2g2X2qYXItBDoI9Pa/II+lXUEaqDdVyrQ1ZKr5UAQT+uDO1y10Xrw1SxJPP3oJK6616A/zvsQfgKU62b4f0ByZ2z59RPv+BNkPj9fHbveNc7l8vfz5Mngxr6elJxuLV33Tez9iV5HW2IgldDx3Wu3DiGXLhTA3K5gPEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751051696; c=relaxed/simple;
	bh=rJBy5eogMaWK1Inha+r6cqvoOuomE1H2/3avaV6ZghA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwYh5y3NRVjfSsQSrbCe6Pp7yHe4b+8vN67fdwBASabHFrqnf+p6Yn9PsIqGUIh/mmF/TpAhkzOy4fBSP+i6O76ZZxdFAuO1AhpTPgwJEiy+gXvy32vc1XDk4CuuXgNLfUZ9ZOIFPLlzUnCpzVIJy/P7qVh4JhvxoktS36MnZsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YXDLSSv6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751051693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xUYZjKekMRgOsttarHYMXC+RSYbEKSH+B8I++22Ehro=;
	b=YXDLSSv6/YB1cNDq2VHofEC/c5ltRV2XtnYRbeNAXTkEP+9J40dyKXnwKedUsIDSQAHfZ1
	mkCt381bdCT42Qlni2khltWsD2DBVV5QIvp0O/5aqkOPg425dLoTdtn+E1yGNg9eVY4yLm
	D/w2Us/EnLNRuqYlnFeR3qtMK4F+vUU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-bpnFFZK1OeSol0EdJXJIRQ-1; Fri,
 27 Jun 2025 15:14:51 -0400
X-MC-Unique: bpnFFZK1OeSol0EdJXJIRQ-1
X-Mimecast-MFC-AGG-ID: bpnFFZK1OeSol0EdJXJIRQ_1751051690
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E648319560A1;
	Fri, 27 Jun 2025 19:14:49 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.142])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D77130001B1;
	Fri, 27 Jun 2025 19:14:47 +0000 (UTC)
Date: Fri, 27 Jun 2025 15:18:25 -0400
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 10/12] iomap: replace iomap_folio_ops with iomap_write_ops
Message-ID: <aF7ugUxtYQrjRl1D@bfoster>
References: <20250627070328.975394-1-hch@lst.de>
 <20250627070328.975394-11-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627070328.975394-11-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Jun 27, 2025 at 09:02:43AM +0200, Christoph Hellwig wrote:
> The iomap_folio_ops are only used for buffered writes, including
> the zero and unshare variants.  Rename them to iomap_write_ops
> to better describe the usage, and pass them through the callchain
> like the other operation specific methods instead of through the
> iomap.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/filesystems/iomap/design.rst    |  3 -
>  .../filesystems/iomap/operations.rst          |  8 +-
>  block/fops.c                                  |  3 +-
>  fs/gfs2/bmap.c                                | 21 ++---
>  fs/gfs2/bmap.h                                |  1 +
>  fs/gfs2/file.c                                |  3 +-
>  fs/iomap/buffered-io.c                        | 79 +++++++++++--------
>  fs/xfs/xfs_file.c                             |  6 +-
>  fs/xfs/xfs_iomap.c                            | 12 ++-
>  fs/xfs/xfs_iomap.h                            |  1 +
>  fs/xfs/xfs_reflink.c                          |  3 +-
>  fs/zonefs/file.c                              |  3 +-
>  include/linux/iomap.h                         | 22 +++---
>  13 files changed, 89 insertions(+), 76 deletions(-)
> 
...
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index ff05e6b1b0bb..2e94a9435002 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -79,6 +79,9 @@ xfs_iomap_valid(
>  {
>  	struct xfs_inode	*ip = XFS_I(inode);
>  
> +	if (iomap->type == IOMAP_HOLE)
> +		return true;
> +

Is this to handle the xfs_hole_to_iomap() case? I.e., no validity cookie
and no folio_ops set..? If so, I think a small comment would be helpful.
Otherwise LGTM:

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  	if (iomap->validity_cookie !=
>  			xfs_iomap_inode_sequence(ip, iomap->flags)) {
>  		trace_xfs_iomap_invalid(ip, iomap);
> @@ -89,7 +92,7 @@ xfs_iomap_valid(
>  	return true;
>  }
>  
> -static const struct iomap_folio_ops xfs_iomap_folio_ops = {
> +const struct iomap_write_ops xfs_iomap_write_ops = {
>  	.iomap_valid		= xfs_iomap_valid,
>  };
>  
> @@ -151,7 +154,6 @@ xfs_bmbt_to_iomap(
>  		iomap->flags |= IOMAP_F_DIRTY;
>  
>  	iomap->validity_cookie = sequence_cookie;
> -	iomap->folio_ops = &xfs_iomap_folio_ops;
>  	return 0;
>  }
>  
> @@ -2198,7 +2200,8 @@ xfs_zero_range(
>  		return dax_zero_range(inode, pos, len, did_zero,
>  				      &xfs_dax_write_iomap_ops);
>  	return iomap_zero_range(inode, pos, len, did_zero,
> -				&xfs_buffered_write_iomap_ops, ac);
> +			&xfs_buffered_write_iomap_ops, &xfs_iomap_write_ops,
> +			ac);
>  }
>  
>  int
> @@ -2214,5 +2217,6 @@ xfs_truncate_page(
>  		return dax_truncate_page(inode, pos, did_zero,
>  					&xfs_dax_write_iomap_ops);
>  	return iomap_truncate_page(inode, pos, did_zero,
> -				   &xfs_buffered_write_iomap_ops, ac);
> +			&xfs_buffered_write_iomap_ops, &xfs_iomap_write_ops,
> +			ac);
>  }
> diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
> index 674f8ac1b9bd..ebcce7d49446 100644
> --- a/fs/xfs/xfs_iomap.h
> +++ b/fs/xfs/xfs_iomap.h
> @@ -57,5 +57,6 @@ extern const struct iomap_ops xfs_seek_iomap_ops;
>  extern const struct iomap_ops xfs_xattr_iomap_ops;
>  extern const struct iomap_ops xfs_dax_write_iomap_ops;
>  extern const struct iomap_ops xfs_atomic_write_cow_iomap_ops;
> +extern const struct iomap_write_ops xfs_iomap_write_ops;
>  
>  #endif /* __XFS_IOMAP_H__*/
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index ad3bcb76d805..3f177b4ec131 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -1881,7 +1881,8 @@ xfs_reflink_unshare(
>  				&xfs_dax_write_iomap_ops);
>  	else
>  		error = iomap_file_unshare(inode, offset, len,
> -				&xfs_buffered_write_iomap_ops);
> +				&xfs_buffered_write_iomap_ops,
> +				&xfs_iomap_write_ops);
>  	if (error)
>  		goto out;
>  
> diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
> index a0ce6c97b9e5..88cb7df2709f 100644
> --- a/fs/zonefs/file.c
> +++ b/fs/zonefs/file.c
> @@ -572,7 +572,8 @@ static ssize_t zonefs_file_buffered_write(struct kiocb *iocb,
>  	if (ret <= 0)
>  		goto inode_unlock;
>  
> -	ret = iomap_file_buffered_write(iocb, from, &zonefs_write_iomap_ops, NULL);
> +	ret = iomap_file_buffered_write(iocb, from, &zonefs_write_iomap_ops,
> +			NULL, NULL);
>  	if (ret == -EIO)
>  		zonefs_io_error(inode, true);
>  
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 568a246f949b..482787013ff7 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -101,8 +101,6 @@ struct vm_fault;
>   */
>  #define IOMAP_NULL_ADDR -1ULL	/* addr is not valid */
>  
> -struct iomap_folio_ops;
> -
>  struct iomap {
>  	u64			addr; /* disk offset of mapping, bytes */
>  	loff_t			offset;	/* file offset of mapping, bytes */
> @@ -113,7 +111,6 @@ struct iomap {
>  	struct dax_device	*dax_dev; /* dax_dev for dax operations */
>  	void			*inline_data;
>  	void			*private; /* filesystem private */
> -	const struct iomap_folio_ops *folio_ops;
>  	u64			validity_cookie; /* used with .iomap_valid() */
>  };
>  
> @@ -143,16 +140,11 @@ static inline bool iomap_inline_data_valid(const struct iomap *iomap)
>  }
>  
>  /*
> - * When a filesystem sets folio_ops in an iomap mapping it returns, get_folio
> - * and put_folio will be called for each folio written to.  This only applies
> - * to buffered writes as unbuffered writes will not typically have folios
> - * associated with them.
> - *
>   * When get_folio succeeds, put_folio will always be called to do any
>   * cleanup work necessary.  put_folio is responsible for unlocking and putting
>   * @folio.
>   */
> -struct iomap_folio_ops {
> +struct iomap_write_ops {
>  	struct folio *(*get_folio)(struct iomap_iter *iter, loff_t pos,
>  			unsigned len);
>  	void (*put_folio)(struct inode *inode, loff_t pos, unsigned copied,
> @@ -335,7 +327,8 @@ static inline bool iomap_want_unshare_iter(const struct iomap_iter *iter)
>  }
>  
>  ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
> -		const struct iomap_ops *ops, void *private);
> +		const struct iomap_ops *ops,
> +		const struct iomap_write_ops *write_ops, void *private);
>  int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
>  void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
>  bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
> @@ -344,11 +337,14 @@ bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
>  void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
>  bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio);
>  int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
> -		const struct iomap_ops *ops);
> +		const struct iomap_ops *ops,
> +		const struct iomap_write_ops *write_ops);
>  int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
> -		bool *did_zero, const struct iomap_ops *ops, void *private);
> +		bool *did_zero, const struct iomap_ops *ops,
> +		const struct iomap_write_ops *write_ops, void *private);
>  int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> -		const struct iomap_ops *ops, void *private);
> +		const struct iomap_ops *ops,
> +		const struct iomap_write_ops *write_ops, void *private);
>  vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops,
>  		void *private);
>  typedef void (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length,
> -- 
> 2.47.2
> 
> 


