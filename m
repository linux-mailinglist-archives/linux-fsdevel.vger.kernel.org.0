Return-Path: <linux-fsdevel+bounces-30736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6026B98E003
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 18:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D3DA1F26C95
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 16:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5FA1D0DD0;
	Wed,  2 Oct 2024 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HRfJLvAi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1C01D0B97
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884839; cv=none; b=GHIcWBp7keKEK4bDM5EmOHLwk4xqhehtqyaI5moR9NzN1uxf3ZqJH0uq33YshY6J16dF7MVY6+B/7AqtBObSOgyHdTGeQFrBrIqDTT+8Ns80Ke+gZcMviALEUNz/66QZVlONY4OkqfEf74BIbreQyQDxcjWUXah2w7XvApVVdO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884839; c=relaxed/simple;
	bh=Sf3YcwHZ5bkZK2LJt9rV+Ayz14bpGLw6myXonMiTZp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjtKM5XFJtNJ36Qfs8I8m63Q+3eYSgnzZGxoZXMVFuarvjowadQR6VDzytgy/oIVhBpSDfARn/i1fEExgKJX3tlo10V42pgFUtf7rHxV28ZhMN7YHqmDnsZioFhbc0APsCfojNpicFfo8UcreOc5e8F26V+inKVfpStcZCuzL7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HRfJLvAi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727884836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eyA1ypbvzB+LBo6FKEjPys+6nNl05QYiIsVBJtMHFRE=;
	b=HRfJLvAium7EOcOdz2mOdJhjaVQnKJtt9w1dEmclaqj4lyoSzTQR6qm0eCLnBEfOxsoFMX
	UMKD1pqbh81VWOLekgv/Q8GiIy2A1Ovocf2SZAlxRg7KP5mpIKnjEIjMEa0RuJwCbLJDfJ
	3PI3MkUsIgMkbfR6ht+RsUhrmwPCLzU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-AoqjOKAaODiUVjb40HOCyw-1; Wed,
 02 Oct 2024 12:00:34 -0400
X-MC-Unique: AoqjOKAaODiUVjb40HOCyw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 722E919560A2;
	Wed,  2 Oct 2024 16:00:32 +0000 (UTC)
Received: from bfoster (unknown [10.22.32.70])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA3F73000198;
	Wed,  2 Oct 2024 16:00:30 +0000 (UTC)
Date: Wed, 2 Oct 2024 12:01:39 -0400
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>, sunjunchao2870@gmail.com,
	jack@suse.cz
Subject: Re: [PATCH 2/2] iomap: constrain the file range passed to
 iomap_file_unshare
Message-ID: <Zv1uY_fH_L-MWU25@bfoster>
References: <20241002150040.GB21853@frogsfrogsfrogs>
 <20241002150213.GC21853@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002150213.GC21853@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Oct 02, 2024 at 08:02:13AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> File contents can only be shared (i.e. reflinked) below EOF, so it makes
> no sense to try to unshare ranges beyond EOF.  Constrain the file range
> parameters here so that we don't have to do that in the callers.
> 
> Fixes: 5f4e5752a8a3 ("fs: add iomap_file_dirty")
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/dax.c               |    6 +++++-
>  fs/iomap/buffered-io.c |    6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index becb4a6920c6a..c62acd2812f8d 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1305,11 +1305,15 @@ int dax_file_unshare(struct inode *inode, loff_t pos, loff_t len,
>  	struct iomap_iter iter = {
>  		.inode		= inode,
>  		.pos		= pos,
> -		.len		= len,
>  		.flags		= IOMAP_WRITE | IOMAP_UNSHARE | IOMAP_DAX,
>  	};
> +	loff_t size = i_size_read(inode);
>  	int ret;
>  
> +	if (pos < 0 || pos >= size)
> +		return 0;
> +
> +	iter.len = min(len, size - pos);
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
>  		iter.processed = dax_unshare_iter(&iter);
>  	return ret;
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index c1c559e0cc07c..78ebd265f4259 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1375,11 +1375,15 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
>  	struct iomap_iter iter = {
>  		.inode		= inode,
>  		.pos		= pos,
> -		.len		= len,
>  		.flags		= IOMAP_WRITE | IOMAP_UNSHARE,
>  	};
> +	loff_t size = i_size_read(inode);
>  	int ret;
>  
> +	if (pos < 0 || pos >= size)
> +		return 0;
> +
> +	iter.len = min(len, size - pos);
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
>  		iter.processed = iomap_unshare_iter(&iter);
>  	return ret;
> 

Heh. This was pretty much my local fix when I was testing fsx unshare
range, so LGTM. Apologies, I probably should have just sent it out. It
just seemed like Julian was 90% there, but then review went off the
rails and I guess I lost interest. Anyways, thanks for the fix:

Reviewed-by: Brian Foster <bfoster@redhat.com>


