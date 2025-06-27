Return-Path: <linux-fsdevel+bounces-53204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F567AEBDA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 18:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5888A188D834
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 16:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A13A2EA17A;
	Fri, 27 Jun 2025 16:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IxRsa4K/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA522EEDE
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jun 2025 16:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751042096; cv=none; b=UJlQv4h8J0nN3Mp+Fc2exAKf5pyeW+2vB1Yn094gattDxJRZzXGU71ZuIh36KxSeFbH+Pq5NgWTwI3BR65b38dZzeT9JwJqmEo8da2zLWXMTR7OplWB+a+IYKNSeqbGARJfXTNZb7eijWyQV5tm8QiGjO13CCYFWdMX2DL7mwrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751042096; c=relaxed/simple;
	bh=rHkOemDdCFfylqTQV5hBs6gNxOJZzjk85RHJW/FVCoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/AVXGa1GimZPqAR3o1/ir95xAok292xghmdUNzxBnfCjZLDbttc66s4b1O+2W3LhVmFIYEx+kZs8b9cP1SQX7TGcW62PGKK723JU6dWSTnxiCBD/dqGQogvj+PAWR/g2YFY+uw7mTp9ImgeCIwJ23pHGUmWOIqrKA3ja73tYmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IxRsa4K/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751042093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=spbMVZZxbYkDM6CEf0Wf+Dn5JHCUiY4z7C7IPr5gz2s=;
	b=IxRsa4K/Qro7s1Vfl+FStVbrEv+vUCiccaLHw50Fj3xjjROgRaNF+wfGTB/+QoPZKKJDFA
	qj+psnih2EgPYmqpjCoDhsgZuFoYPDTQYOmIyWojKTJXHW9x1tg09Kasa6R0CDsNH1od4z
	Hg0mlchAjnkmA8/7+EeZhKcX6nrbFOo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-e1K8rw1jNh2htVdesIEhCA-1; Fri,
 27 Jun 2025 12:34:49 -0400
X-MC-Unique: e1K8rw1jNh2htVdesIEhCA-1
X-Mimecast-MFC-AGG-ID: e1K8rw1jNh2htVdesIEhCA_1751042087
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8740C19560AD;
	Fri, 27 Jun 2025 16:34:47 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.142])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE817180045C;
	Fri, 27 Jun 2025 16:34:45 +0000 (UTC)
Date: Fri, 27 Jun 2025 12:38:22 -0400
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 07/12] iomap: rename iomap_writepage_map to
 iomap_writeback_folio
Message-ID: <aF7I_hTYx8yr0lRa@bfoster>
References: <20250627070328.975394-1-hch@lst.de>
 <20250627070328.975394-8-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627070328.975394-8-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Jun 27, 2025 at 09:02:40AM +0200, Christoph Hellwig wrote:
> ->writepage is gone, and our naming wasn't always that great to start
> with.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/iomap/buffered-io.c | 10 +++++-----
>  fs/iomap/trace.h       |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 3e0ce6f42df5..c28eb6a6eee4 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1586,7 +1586,7 @@ static int iomap_writeback_range(struct iomap_writeback_ctx *wpc,
>   * If the folio is entirely beyond i_size, return false.  If it straddles
>   * i_size, adjust end_pos and zero all data beyond i_size.
>   */
> -static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
> +static bool iomap_writeback_handle_eof(struct folio *folio, struct inode *inode,
>  		u64 *end_pos)
>  {
>  	u64 isize = i_size_read(inode);
> @@ -1638,7 +1638,7 @@ static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
>  	return true;
>  }
>  
> -static int iomap_writepage_map(struct iomap_writeback_ctx *wpc,
> +static int iomap_writeback_folio(struct iomap_writeback_ctx *wpc,
>  		struct folio *folio)
>  {
>  	struct iomap_folio_state *ifs = folio->private;
> @@ -1654,9 +1654,9 @@ static int iomap_writepage_map(struct iomap_writeback_ctx *wpc,
>  	WARN_ON_ONCE(folio_test_dirty(folio));
>  	WARN_ON_ONCE(folio_test_writeback(folio));
>  
> -	trace_iomap_writepage(inode, pos, folio_size(folio));
> +	trace_iomap_writeback_folio(inode, pos, folio_size(folio));
>  
> -	if (!iomap_writepage_handle_eof(folio, inode, &end_pos)) {
> +	if (!iomap_writeback_handle_eof(folio, inode, &end_pos)) {
>  		folio_unlock(folio);
>  		return 0;
>  	}
> @@ -1741,7 +1741,7 @@ iomap_writepages(struct iomap_writeback_ctx *wpc)
>  		return -EIO;
>  
>  	while ((folio = writeback_iter(mapping, wpc->wbc, folio, &error)))
> -		error = iomap_writepage_map(wpc, folio);
> +		error = iomap_writeback_folio(wpc, folio);
>  
>  	/*
>  	 * If @error is non-zero, it means that we have a situation where some
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index aaea02c9560a..6ad66e6ba653 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -79,7 +79,7 @@ DECLARE_EVENT_CLASS(iomap_range_class,
>  DEFINE_EVENT(iomap_range_class, name,	\
>  	TP_PROTO(struct inode *inode, loff_t off, u64 len),\
>  	TP_ARGS(inode, off, len))
> -DEFINE_RANGE_EVENT(iomap_writepage);
> +DEFINE_RANGE_EVENT(iomap_writeback_folio);
>  DEFINE_RANGE_EVENT(iomap_release_folio);
>  DEFINE_RANGE_EVENT(iomap_invalidate_folio);
>  DEFINE_RANGE_EVENT(iomap_dio_invalidate_fail);
> -- 
> 2.47.2
> 
> 


