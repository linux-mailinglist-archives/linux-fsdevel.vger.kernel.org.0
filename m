Return-Path: <linux-fsdevel+bounces-42131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924A6A3CC64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 23:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663B23A8F6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 22:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC7B25A2B0;
	Wed, 19 Feb 2025 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+4h0u0N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382691CAA65;
	Wed, 19 Feb 2025 22:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740004428; cv=none; b=XYF/CY3lDr9SR5JTa+/myaiSjwEv1RibJqZ81G5HZamwr6hctaTziHHXcZaNsTY8jDEDEOQZXNXuYxUC9h5g44QYPDLcVzp7nkYSidiuo584PDgUi0KDSb6oVd+aSvRXcYKpHuQV/t4Nej/F8zuaUH0mwnTt1UjP1nD34iKo1Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740004428; c=relaxed/simple;
	bh=Rijix8UFyDzbnqvA8KL1X8WMN5/5wF0ZMflr9DwyiM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ngw0T6BL+ImBr17Bar5/9gww62ORmYBcsmZN2yPsldyn7wV6H01asFPm+ky6xFQfnbghsfuzznH1qnpHcvm9soCROo7QMX/1FmRXXpoUNGysD+v6oWFfygNSJo+b7xr3zmTotTsJAe9fDhvrRz00OwQW9x5vCrvTIg7OZxaGrl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+4h0u0N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3E6C4CEE0;
	Wed, 19 Feb 2025 22:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740004427;
	bh=Rijix8UFyDzbnqvA8KL1X8WMN5/5wF0ZMflr9DwyiM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t+4h0u0NHYRGRt+m4PCBrcIxFOQ0K2xQnIqwgprrnk0FGYYrwko7hF90Sml50mV45
	 af7kvBcbdXMLIsrkihIsI0hiVKK34PzOzpVxu3TWFRssyMnzBZHuXEJxlsz5S93L2h
	 uFunCWu94fk0vGjNi0LmUa8oAt1Fdq6bN8YLtyAR1QLFyCpmDihz/EtQP+KffckeOp
	 t5lJcRtd8txNxyR0LhiTnDYKUZ7hQF8JUSTnAjOn3dzyUKyu71On9CHZX0NujWA/A3
	 pMEL1LWO6H/Lirh9lj7Gb2R3iuZGnHk4E1P+MHfyytGxb2pNVK8oWN8OBFr6yHi/Lz
	 bkc4mSq81Bjvg==
Date: Wed, 19 Feb 2025 14:33:44 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 04/12] dax: advance the iomap_iter in the read/write
 path
Message-ID: <20250219223344.GJ21808@frogsfrogsfrogs>
References: <20250219175050.83986-1-bfoster@redhat.com>
 <20250219175050.83986-5-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219175050.83986-5-bfoster@redhat.com>

On Wed, Feb 19, 2025 at 12:50:42PM -0500, Brian Foster wrote:
> DAX reads and writes flow through dax_iomap_iter(), which has one or
> more subtleties in terms of how it processes a range vs. what is
> specified in the iomap_iter. To keep things simple and remove the
> dependency on iomap_iter() advances, convert a positive return from
> dax_iomap_iter() to the new advance and status return semantics. The
> advance can be pushed further down in future patches.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Not sure why this and the next patch are split up but it's fsdax so meh.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/dax.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 21b47402b3dc..296f5aa18640 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1585,8 +1585,12 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	if (iocb->ki_flags & IOCB_NOWAIT)
>  		iomi.flags |= IOMAP_NOWAIT;
>  
> -	while ((ret = iomap_iter(&iomi, ops)) > 0)
> +	while ((ret = iomap_iter(&iomi, ops)) > 0) {
>  		iomi.processed = dax_iomap_iter(&iomi, iter);
> +		if (iomi.processed > 0)
> +			iomi.processed = iomap_iter_advance(&iomi,
> +							    &iomi.processed);
> +	}
>  
>  	done = iomi.pos - iocb->ki_pos;
>  	iocb->ki_pos = iomi.pos;
> -- 
> 2.48.1
> 
> 

