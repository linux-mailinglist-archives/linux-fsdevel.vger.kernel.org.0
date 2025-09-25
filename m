Return-Path: <linux-fsdevel+bounces-62798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD507BA117A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 20:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A44E6C1042
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 18:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8562B31B13D;
	Thu, 25 Sep 2025 18:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZjFnR2k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3B531AF31
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 18:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758826555; cv=none; b=ItItABXXxt5mtKoM64vLamdyTANVs+Mjzph80BUYtDXVrnR4JS3ys9HlwNyEZAebVUWPPeurPLA74VZXmePlY1QeaN+Wu76yc2NUFiPrjLtscHX+wkFOQPp0NfeD7H7ceKDJzzn3RX9MrH8nxG8Sj7G/I8+Ngtrg+Z8AXEgn818=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758826555; c=relaxed/simple;
	bh=/7KLcXEUrTaZ8PYKGvMHDGUwv/t9AV/n6HhtLSFxzZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2jdD17vJjLYI36TrDCEcf5Mh2/XkUmtV77OPUoZq4Ni1y/C1PzJMCEa62ydIQzDGP0yiG9a4+z5u24AYo3LOh+XgExeLQ0/ellTRxXIwQVt+pRXHKOEEUv5tYqbvZKrGjeZouoKRdRTphrvo7J8csOAS/C2HsWghGIQ3sQnDM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PZjFnR2k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758826553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8aOn11o2tJkweFjWQJDeVHcaNST5BmW1mwyMr2zk5Ts=;
	b=PZjFnR2kOC0unU9cYgjEqJ6X6YJU65ogTXZ+ByskbFcflTWGZtpxnExtbXGa3PrX5hWOEw
	O3AEfA7vbBIKl/0NCpc4ycLPXcKBH1C3uIaFWHTg6mi1jH3W1bsp00zY1wFI2YCa149HP+
	pfYXEudkxznFfn9OO4owrWXpAibML0k=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-k3BxJZQANFmZjZcM7o3f6g-1; Thu,
 25 Sep 2025 14:55:47 -0400
X-MC-Unique: k3BxJZQANFmZjZcM7o3f6g-1
X-Mimecast-MFC-AGG-ID: k3BxJZQANFmZjZcM7o3f6g_1758826545
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 766D219560B2;
	Thu, 25 Sep 2025 18:55:45 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.134])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5675119560A2;
	Thu, 25 Sep 2025 18:55:43 +0000 (UTC)
Date: Thu, 25 Sep 2025 14:59:53 -0400
From: Brian Foster <bfoster@redhat.com>
To: alexjlzheng@gmail.com
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org,
	kernel@pankajraghav.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH v5 2/4] iomap: move iter revert case out of the unwritten
 branch
Message-ID: <aNWRKZJKePnNl2O3@bfoster>
References: <20250923042158.1196568-1-alexjlzheng@tencent.com>
 <20250923042158.1196568-3-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923042158.1196568-3-alexjlzheng@tencent.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Sep 23, 2025 at 12:21:56PM +0800, alexjlzheng@gmail.com wrote:
> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> The commit e1f453d4336d ("iomap: do some small logical cleanup in
> buffered write") merged iomap_write_failed() and iov_iter_revert()
> into the branch with written == 0. Because, at the time,
> iomap_write_end() could never return a partial write length.
> 
> In the subsequent patch, iomap_write_end() will be modified to allow
> to return block-aligned partial write length (partial write length
> here is relative to the folio-sized write), which violated the above
> patch's assumption.
> 
> This patch moves it back out to prepare for the subsequent patches.
> 
> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/iomap/buffered-io.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index ee1b2cd8a4b4..e130db3b761e 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1019,6 +1019,11 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
>  
>  		if (old_size < pos)
>  			pagecache_isize_extended(iter->inode, old_size, pos);
> +		if (written < bytes)
> +			iomap_write_failed(iter->inode, pos + written,
> +					   bytes - written);
> +		if (unlikely(copied != written))
> +			iov_iter_revert(i, copied - written);
>  
>  		cond_resched();
>  		if (unlikely(written == 0)) {
> @@ -1028,9 +1033,6 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
>  			 * halfway through, might be a race with munmap,
>  			 * might be severe memory pressure.
>  			 */
> -			iomap_write_failed(iter->inode, pos, bytes);
> -			iov_iter_revert(i, copied);
> -
>  			if (chunk > PAGE_SIZE)
>  				chunk /= 2;
>  			if (copied) {
> -- 
> 2.49.0
> 
> 


