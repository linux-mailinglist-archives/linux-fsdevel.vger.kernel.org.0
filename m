Return-Path: <linux-fsdevel+bounces-42502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E5FA42E1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99760178959
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 20:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9927F25485E;
	Mon, 24 Feb 2025 20:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdeImkI/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAECA1FDE0B;
	Mon, 24 Feb 2025 20:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740429595; cv=none; b=bpJdpBGA9nFWaYGKzffeTa/ZyX4PbfpYahbRByK3WoQ9rPe6g/XmSQ31Ayg11AUJ09pstZ3ypQ6WoaYWADuGNpgbe8qrUA8VEfzmgt0vbsvHU/jT0kC4sHWFmGXRVq5ssP4Fy7MVLqSQJWcqoHZa+VtRlj4+UW+5OyJoDTSNt7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740429595; c=relaxed/simple;
	bh=r14l7scvAhR53iNGLe8Y/830dFl/Lo8B1pGMjsBlzGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+xRmmBOjc94lRQbEEf1t8O6Jbix6/Y6daSWzWRLtJo1nSc24VQY24pnp9MSs+WQmcOyw3+k1gcCVVFve0LI/Lrppzxt9SqLQpNNczhVuLJoidoxcfYw8Ee8l1s+kjZgFw/BRzC+nY4VSrFe//ml9Add6CGjjv14qcGEDwpq6Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdeImkI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60995C4CED6;
	Mon, 24 Feb 2025 20:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740429594;
	bh=r14l7scvAhR53iNGLe8Y/830dFl/Lo8B1pGMjsBlzGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kdeImkI/cxEMjdxQdGSTfE7AawdknJHuiu4yoEwDy7HfGiffXWPy5Ra2OpPG88f77
	 vQSnN/4g6HNldsv8WtQ6BYbfVlzhv/HD3sKI3HMvdcr4a9v7hrmLqa72qobxY8buwy
	 eTnvwo83J1IATnMNKP+965zuCHIutQHdYbAS66iSRhVtnPr3J1n87ShX8GI0770IZI
	 NOiMzY1Ssz2lBnxFih1geIiweqWE+EB3oCKt4gM2PAVJ5+ikIO854HB4ZM0N5Xi1tx
	 9iI3tFZ+rFPZV8cn3HOeLQgx4OUpob/jq5lNIOWtR5KnA/30Jxt3pjYYo3Rc5jZiSS
	 5jcFhDSmTMU7w==
Date: Mon, 24 Feb 2025 12:39:53 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomap: Minor code simplification in iomap_dio_bio_iter()
Message-ID: <20250224203953.GM21808@frogsfrogsfrogs>
References: <20250224154538.548028-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224154538.548028-1-john.g.garry@oracle.com>

On Mon, Feb 24, 2025 at 03:45:38PM +0000, John Garry wrote:
> Combine 'else' and 'if' conditional statements onto a single line and drop
> unrequired braces, as is standard coding style.
> 
> The code had been like this since commit c3b0e880bbfa ("iomap: support
> REQ_OP_ZONE_APPEND").
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks fine to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 138d246ec29d..cdcd5ff399c1 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -473,12 +473,10 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  			bio_put(bio);
>  			goto zero_tail;
>  		}
> -		if (dio->flags & IOMAP_DIO_WRITE) {
> +		if (dio->flags & IOMAP_DIO_WRITE)
>  			task_io_account_write(n);
> -		} else {
> -			if (dio->flags & IOMAP_DIO_DIRTY)
> -				bio_set_pages_dirty(bio);
> -		}
> +		else if (dio->flags & IOMAP_DIO_DIRTY)
> +			bio_set_pages_dirty(bio);
>  
>  		dio->size += n;
>  		copied += n;
> -- 
> 2.31.1
> 
> 

