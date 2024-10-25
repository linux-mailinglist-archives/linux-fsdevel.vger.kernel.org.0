Return-Path: <linux-fsdevel+bounces-32909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D569B0999
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 18:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED0C11F212AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 16:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EBE184549;
	Fri, 25 Oct 2024 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXFAoCdo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8799D7080E;
	Fri, 25 Oct 2024 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872993; cv=none; b=qFKcX3wk+rZFiZAzkTuj+pVvOymjTrvqiJCGxXKRqQqkw9CYJ/EdPkYaVUqlt8KM47UJIbqbHNZnqo+KeFByR6zlcfUdJd8PRyPg4iIBwoSXGw4BK4jI6+hUu/gSEG1P0rpdILuYwTlJgZO4GQSfwg0rcVdJqay1509fIBJz/W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872993; c=relaxed/simple;
	bh=nn618csCV0nfmdVUFNZxtbc9Np+SY9OMrfOoQa9JKs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgYYzJa/R4OkVoQwiY9EqIhE8tiQR7CHpXdbSBJBXNU39xRQ4NJzhfeEJsNlPawDdg1GBi+4tIDVgSuMCxCmI6/0UtAUiuQpYB1i/FHaD7nSrrcwvHNvALWjYkz9+IeI9aW3a6sg7yXK/vlEA8fn9lUzvhaxVkDBh0Afr59vaC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXFAoCdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC848C4CEC3;
	Fri, 25 Oct 2024 16:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729872993;
	bh=nn618csCV0nfmdVUFNZxtbc9Np+SY9OMrfOoQa9JKs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hXFAoCdoFqZMXlOYigk6dnBpVkwU/b6eZlHDuo5rMt/0DTFnrcuuon7H+kF8A46Nk
	 f6wBM0zhF/h/OTz6oBAZVGzbmjmIKVKRN/f4HAdyPvSWfyDLgSvdhE2Qf0GDMLv3FT
	 ATF9Gyb8cM1ZANfYUxBndapkor4pEvK876BQUqmWh0hJ2dDzhIIH5AV+61+6kd0yo8
	 ikozvmiCr2QWzHaxNXe/shjzgt62S1qcVwJuERUaPx1uPrsRIs62k1Ge5W6R83RG8U
	 t2XGq7zmzYKBsacmP7UePlrb+qW74okNou3dIs41+tHIdaS9mk4vqc4Z8dWF6FAz5w
	 RpIsuPWk55Zow==
Date: Fri, 25 Oct 2024 09:16:32 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/6] ext4: Warn if we ever fallback to buffered-io for
 DIO atomic writes
Message-ID: <20241025161632.GL2386201@frogsfrogsfrogs>
References: <cover.1729825985.git.ritesh.list@gmail.com>
 <7c4779f1f0c8ead30f660a2cfbdf4d7cc08e405a.1729825985.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c4779f1f0c8ead30f660a2cfbdf4d7cc08e405a.1729825985.git.ritesh.list@gmail.com>

On Fri, Oct 25, 2024 at 09:15:53AM +0530, Ritesh Harjani (IBM) wrote:
> iomap will not return -ENOTBLK in case of dio atomic writes. But let's
> also add a WARN_ON_ONCE and return -EIO as a safety net.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/ext4/file.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index f9516121a036..af6ebd0ac0d6 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -576,8 +576,16 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		iomap_ops = &ext4_iomap_overwrite_ops;
>  	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
>  			   dio_flags, NULL, 0);
> -	if (ret == -ENOTBLK)
> +	if (ret == -ENOTBLK) {
>  		ret = 0;
> +		/*
> +		 * iomap will never return -ENOTBLK if write fails for atomic
> +		 * write. But let's just add a safety net.

I think it can if the pagecache invalidation fails, so you really do
need the safety net.  I suspect that the xfs version of this series
needs it too, though it may have fallen out?

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +		 */
> +		if (WARN_ON_ONCE(iocb->ki_flags & IOCB_ATOMIC))
> +			ret = -EIO;
> +	}
> +
>  	if (extend) {
>  		/*
>  		 * We always perform extending DIO write synchronously so by
> -- 
> 2.46.0
> 
> 

