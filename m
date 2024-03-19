Return-Path: <linux-fsdevel+bounces-14835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BCA88067B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 22:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42F3283D2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 21:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3323FE31;
	Tue, 19 Mar 2024 21:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cs6qXtNu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685293FB90;
	Tue, 19 Mar 2024 21:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710882223; cv=none; b=aSXr4cJK4CqbQvXiGyPfsk9+NGf+N9UKz9HVWcAgmyofqsWdnn1rn1VC0lqdrDKlZV0gIOUsUienZMblsxDi7rG7WaAZPmjWZuYtFvjS2v06AKBzhTdM/gAHEcmx+gyZZ4j20WR/zSzGDEWItRw/m49VvJiK3yZ2d3LtkwW5IPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710882223; c=relaxed/simple;
	bh=3qLLWhXjox+tz8+eEQotqrS0D9GARV2ZYvI2br+jXso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H//IxOaL9KH61uS8MMjMWY1QYr4AyrmVUUd+myDlme83y52+AAKEj3KEWvUFF/Dt2ny/Th1j+P9gBuQVlkVNIvkMSslz5OA6zCAFhClXN8CqDjlkpebp2gvevhfImrfZRszoJoAvwzXEukHUWv3yBTJaMklRNVobIJsrYRaPGU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cs6qXtNu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC6AC43390;
	Tue, 19 Mar 2024 21:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710882223;
	bh=3qLLWhXjox+tz8+eEQotqrS0D9GARV2ZYvI2br+jXso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cs6qXtNu50nRmJY2dJ5dU9YBVeBY50YYQkKf/Cja6Arlt8jwQTEMcwm3YCUW/Qt/v
	 wr1+eKYsFBFpZd3B9B8O4zrF7yCMQ47unnDucNKamsd7lcDMPNehVYflenucJSiXpw
	 JMbHo/KHn8uTpAi7uIzJmxUns1uXFDb2z2UsExAD7gFEuC2MgAnpIBxd4Ss/CD86kM
	 BKMncVV4kApy8kh3HuJFfiBGs2rPCgjrOjgRR+HjOWQkh2IMgtSaB0BPzhCWfGd33o
	 XlqqxTycxmwXhSA4lTsA/ame1TLWB43d9EiSBIGK5J9CEI5hhOQoZSFpCfHRfXRhxZ
	 a6NiYWa6jnNRw==
Date: Tue, 19 Mar 2024 14:03:42 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
	david@fromorbit.com, tytso@mit.edu, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 5/9] iomap: drop the write failure handles when
 unsharing and zeroing
Message-ID: <20240319210342.GJ1927156@frogsfrogsfrogs>
References: <20240319011102.2929635-1-yi.zhang@huaweicloud.com>
 <20240319011102.2929635-6-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319011102.2929635-6-yi.zhang@huaweicloud.com>

On Tue, Mar 19, 2024 at 09:10:58AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Unsharing and zeroing can only happen within EOF, so there is never a
> need to perform posteof pagecache truncation if write begin fails, also
> partial write could never theoretically happened from iomap_write_end(),
> so remove both of them.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Makes sense,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 093c4515b22a..7e32a204650b 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -786,7 +786,6 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
>  
>  out_unlock:
>  	__iomap_put_folio(iter, pos, 0, folio);
> -	iomap_write_failed(iter->inode, pos, len);
>  
>  	return status;
>  }
> @@ -863,8 +862,6 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
>  
>  	if (old_size < pos)
>  		pagecache_isize_extended(iter->inode, old_size, pos);
> -	if (ret < len)
> -		iomap_write_failed(iter->inode, pos + ret, len - ret);
>  	return ret;
>  }
>  
> @@ -912,8 +909,10 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  		}
>  
>  		status = iomap_write_begin(iter, pos, bytes, &folio);
> -		if (unlikely(status))
> +		if (unlikely(status)) {
> +			iomap_write_failed(iter->inode, pos, bytes);
>  			break;
> +		}
>  		if (iter->iomap.flags & IOMAP_F_STALE)
>  			break;
>  
> @@ -927,6 +926,9 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
>  		status = iomap_write_end(iter, pos, bytes, copied, folio);
>  
> +		if (status < bytes)
> +			iomap_write_failed(iter->inode, pos + status,
> +					   bytes - status);
>  		if (unlikely(copied != status))
>  			iov_iter_revert(i, copied - status);
>  
> -- 
> 2.39.2
> 
> 

