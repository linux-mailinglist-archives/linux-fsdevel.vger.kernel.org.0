Return-Path: <linux-fsdevel+bounces-40959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E39E6A29969
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 19:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D54169553
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 18:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E051FECB8;
	Wed,  5 Feb 2025 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbN5Su7v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8A31FC7E7;
	Wed,  5 Feb 2025 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738781377; cv=none; b=ARkIb2Ou4TFzBRc59Ut5Jig+kVFomL0ZNptETXpP7Ebr/rmQv+3l2/Y/U4uIX/pF29c2h07gE57qCpagRWvAnBqT4ECniALoB0FIQ9HKmuIerSarOE5QrxPrt6SyD7xz0lyGC4zvmpQoKtlH81ehy2XUFUb4QPEYAqcZnd5jIVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738781377; c=relaxed/simple;
	bh=cdZeGk4+G7SauNEPMezV/u40YR7lktPg457PxB+uXDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcEno3NtoWedS7qwXkXhyh7NbI0DW8XRLNPrJQrpIS3eohVjXgzGo41zRD0F7fHbdOkvwzB2Kuab9rKmXYKBMiPJO2QVsZdZI6Q6i4RungCBwVYvOTBh/sHLlQ7GiG3bvfbIJ5J9YGziGTNqsN5JDaMwdU3nyr0KMYM0njLpOmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbN5Su7v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31F2C4CED1;
	Wed,  5 Feb 2025 18:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738781377;
	bh=cdZeGk4+G7SauNEPMezV/u40YR7lktPg457PxB+uXDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dbN5Su7vE6i4LxvcNxVQpAr+c+9tlbvuzcIRo+ghAnMHGGxNNZ/AC8jFnXmFPi2Ad
	 rGMefHhzJbziqWuJza748++KnYYP2KILRNiy+QnQpT1yUgUUB01D37jV81wBrkcDwY
	 rjzHtSgsuZ91abdXn0rW4VqowuWXrUzWNRH6a2B5uI4apbTD8kQwRQPnrDU1lFiAxa
	 5xwKRZ3VuQAWyjUnSa+2mawyLleszjEgjHu/OguiAG8K20mMiWWfA3Rux/UAqpN2ft
	 Im1mq4wSFOXEbGwWEaKs3F0Hagq/MzMjTvr2+QTHM8uPzuxzUc/Gc2SqYsglhHTP8m
	 Z1HjAbE/lk7mQ==
Date: Wed, 5 Feb 2025 10:49:36 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v5 01/10] iomap: factor out iomap length helper
Message-ID: <20250205184936.GL21808@frogsfrogsfrogs>
References: <20250205135821.178256-1-bfoster@redhat.com>
 <20250205135821.178256-2-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205135821.178256-2-bfoster@redhat.com>

On Wed, Feb 05, 2025 at 08:58:12AM -0500, Brian Foster wrote:
> In preparation to support more granular iomap iter advancing, factor
> the pos/len values as parameters to length calculation.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  include/linux/iomap.h | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 75bf54e76f3b..f5ca71ac2fa2 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -231,18 +231,33 @@ struct iomap_iter {
>  int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops);
>  
>  /**
> - * iomap_length - length of the current iomap iteration
> + * iomap_length_trim - trimmed length of the current iomap iteration
>   * @iter: iteration structure
> + * @pos: File position to trim from.
> + * @len: Length of the mapping to trim to.
>   *
> - * Returns the length that the operation applies to for the current iteration.
> + * Returns a trimmed length that the operation applies to for the current
> + * iteration.
>   */
> -static inline u64 iomap_length(const struct iomap_iter *iter)
> +static inline u64 iomap_length_trim(const struct iomap_iter *iter, loff_t pos,
> +		u64 len)
>  {
>  	u64 end = iter->iomap.offset + iter->iomap.length;
>  
>  	if (iter->srcmap.type != IOMAP_HOLE)
>  		end = min(end, iter->srcmap.offset + iter->srcmap.length);
> -	return min(iter->len, end - iter->pos);
> +	return min(len, end - pos);
> +}
> +
> +/**
> + * iomap_length - length of the current iomap iteration
> + * @iter: iteration structure
> + *
> + * Returns the length that the operation applies to for the current iteration.
> + */
> +static inline u64 iomap_length(const struct iomap_iter *iter)
> +{
> +	return iomap_length_trim(iter, iter->pos, iter->len);
>  }
>  
>  /**
> -- 
> 2.48.1
> 
> 

