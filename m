Return-Path: <linux-fsdevel+bounces-31976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 473C599EBC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 15:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D73DDB20D0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 13:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7981C07ED;
	Tue, 15 Oct 2024 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+2ROisv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EBA1C07DF
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728997841; cv=none; b=DTLeI4RN8s4mmApm649zRQrzJSYTtlcPKI7Hh+Q6V0tB7IyQI67+2q1HuIoiFRA3f335RpWOqPZ+hl+7VFBhC9JdOajW6sNMEslR8Xi4yrLz5voOa3vLNjpJBcdWq7CZYy7rHtMS+N1G9raCKvlOi5vFVtqPEATLITsSTy905Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728997841; c=relaxed/simple;
	bh=Icd1CTLa3HUKpZaYkWuGGC7Yj5qwYe37DUCu4UgcvXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJnkqYTvQ9YE4NdYn73aZRehEJVn60nQLVXRVgYd0K7X2yreMBkb2PVcLtZ/E2QBCvQPtmFVJWrz6fWpzix9qKD4Q/e0ZwlzK2p3PcmdoqwxcfoU3o1K3F2iCIkWL0sdFcmMOrLx2ZMAaHEFpxZb2XyGrUv4R5qNtjKN5CSIszQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P+2ROisv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728997838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=so8jeFClFkTvv/ldCrw0QLpFv7/rrriOsiZ+RRZqQGQ=;
	b=P+2ROisvMPAdmQRnu0U+Y0cLzd17yJk8i+yQMuSruWHFUxf2/y4TEBTGjdRENCbZ66UCD8
	YY3SXV8MUFn7KS0R+rv16XgLgUrE4luk0R9NvgyTxcNN5Dex/Cy6Uh/h1VRgZu9QNXXTV9
	wcCpM7fhLqG8d0VlFUU5u2mQsveuGQU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-Zfx-vJtJM1mEyeO8RIoj9A-1; Tue,
 15 Oct 2024 09:10:34 -0400
X-MC-Unique: Zfx-vJtJM1mEyeO8RIoj9A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42D5E19560BD;
	Tue, 15 Oct 2024 13:10:33 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.74])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E5A41956054;
	Tue, 15 Oct 2024 13:10:31 +0000 (UTC)
Date: Tue, 15 Oct 2024 09:11:53 -0400
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iomap: turn iomap_want_unshare_iter into an inline
 function
Message-ID: <Zw5qGY8asl0grLAD@bfoster>
References: <20241015041350.118403-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241015041350.118403-1-hch@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, Oct 15, 2024 at 06:13:50AM +0200, Christoph Hellwig wrote:
> iomap_want_unshare_iter currently sits in fs/iomap/buffered-io.c, which
> depends on CONFIG_BLOCK.  It is also in used in fs/dax.c whіch has no
> such dependency.  Given that it is a trivial check turn it into an inline
> in include/linux/iomap.h to fix the DAX && !BLOCK build.
> 
> Fixes: 6ef6a0e821d3 ("iomap: share iomap_unshare_iter predicate code with fsdax")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/iomap/buffered-io.c | 17 -----------------
>  include/linux/iomap.h  | 19 +++++++++++++++++++
>  2 files changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 604f786be4bc54..ef0b68bccbb612 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1270,23 +1270,6 @@ void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
>  }
>  EXPORT_SYMBOL_GPL(iomap_write_delalloc_release);
>  
> -bool iomap_want_unshare_iter(const struct iomap_iter *iter)
> -{
> -	/*
> -	 * Don't bother with blocks that are not shared to start with; or
> -	 * mappings that cannot be shared, such as inline data, delalloc
> -	 * reservations, holes or unwritten extents.
> -	 *
> -	 * Note that we use srcmap directly instead of iomap_iter_srcmap as
> -	 * unsharing requires providing a separate source map, and the presence
> -	 * of one is a good indicator that unsharing is needed, unlike
> -	 * IOMAP_F_SHARED which can be set for any data that goes into the COW
> -	 * fork for XFS.
> -	 */
> -	return (iter->iomap.flags & IOMAP_F_SHARED) &&
> -		iter->srcmap.type == IOMAP_MAPPED;
> -}
> -
>  static loff_t iomap_unshare_iter(struct iomap_iter *iter)
>  {
>  	struct iomap *iomap = &iter->iomap;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index e04c060e8fe185..664c5f2f0aaa2d 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -270,6 +270,25 @@ static inline loff_t iomap_last_written_block(struct inode *inode, loff_t pos,
>  	return round_up(pos + written, i_blocksize(inode));
>  }
>  
> +/*
> + * Check if the range needs to be unshared for a FALLOC_FL_UNSHARE_RANGE
> + * operation.
> + *
> + * Don't bother with blocks that are not shared to start with; or mappings that
> + * cannot be shared, such as inline data, delalloc reservations, holes or
> + * unwritten extents.
> + *
> + * Note that we use srcmap directly instead of iomap_iter_srcmap as unsharing
> + * requires providing a separate source map, and the presence of one is a good
> + * indicator that unsharing is needed, unlike IOMAP_F_SHARED which can be set
> + * for any data that goes into the COW fork for XFS.
> + */
> +static inline bool iomap_want_unshare_iter(const struct iomap_iter *iter)
> +{
> +	return (iter->iomap.flags & IOMAP_F_SHARED) &&
> +		iter->srcmap.type == IOMAP_MAPPED;
> +}
> +
>  ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
>  		const struct iomap_ops *ops, void *private);
>  int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
> -- 
> 2.45.2
> 
> 


