Return-Path: <linux-fsdevel+bounces-43492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EBFA5755C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 23:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5584C3B11C4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 22:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219142586CC;
	Fri,  7 Mar 2025 22:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvD/KUIU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7CD258CF3
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 22:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741387943; cv=none; b=l/QjzyffXsB4+uB9H46+1rSWtx77U038P3/3faYOJy7V42OuxdK6UVlsdt4ZR49hI9HZfJFfFy/3+LhZVdaU1efozAay2Jfue4ACWVqZhTFYngvpRUMlebfd4EsSSQa6hKwJUe7ZWaIH+OLSP6jZu5w9+Kl0ixEJipdpso+xO6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741387943; c=relaxed/simple;
	bh=L9a2goqUHG+BX9r0pyJIWYUEQ4SeZ9N6cdY/98f6u5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSyliPtnbr7IqtpUc57hA1LQxIQvku0UutEERgiQJUddfdRj/dfyT02NxEOhTi2Zfj+0b/tzxPIllsFAF1FiB265RoAwYzDCqk6wucbU4fU3U18GmD44pWjndzbYGwERXuqKSA0On3jHmv/YbTNJr4KpaQKdqbmeLNpibYP7W60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fvD/KUIU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741387939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=onyBD1UDJ5U7A9OhtNB30NHsTt6yYiPkgTXOi2KQifk=;
	b=fvD/KUIU5SYUZih8c9qPgeSOTZa3svaCtDBWyQ2fpsFV3nL1DMcVpCNAWK9WKmTxN26u6J
	vrWePIPhP9/KVClzRvwx7VnP2Gy7cFzOLOuSPgnQ4pypj4NzrwhFagpdJTVyX49E9Ng8PX
	7yF+OkrBFH41sZYdioWYTV14KRhbPa4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-brLMSSdxM9WfjZefVwJVEg-1; Fri,
 07 Mar 2025 17:52:12 -0500
X-MC-Unique: brLMSSdxM9WfjZefVwJVEg-1
X-Mimecast-MFC-AGG-ID: brLMSSdxM9WfjZefVwJVEg_1741387931
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 909B11955D4E;
	Fri,  7 Mar 2025 22:52:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 22DEB18009AE;
	Fri,  7 Mar 2025 22:52:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  7 Mar 2025 23:51:39 +0100 (CET)
Date: Fri, 7 Mar 2025 23:51:35 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/pipe.c: simplify tmp_page handling
Message-ID: <20250307225135.GB28762@redhat.com>
References: <20250307221004.1115255-1-linux@rasmusvillemoes.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307221004.1115255-1-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03/07, Rasmus Villemoes wrote:
>
> Assigning the newly allocated page to pipe->tmp_page, only to
> unconditionally clear ->tmp_page a little later, seems somewhat odd.

Oh yes, but could you look at

	[PATCH v2 1/1] pipe: change pipe_write() to never add a zero-sized buffer
	https://lore.kernel.org/all/20250210114039.GA3588@redhat.com/

already in Christian's tree although I will probably need to rebase
this patch on top of the recent changes.

Oleg.

> It made sense prior to commit a194dfe6e6f6 ("pipe: Rearrange sequence
> in pipe_write() to preallocate slot"), when a user copy was done
> between the allocation and the buf->page = page assignment, and a
> failure there would then just leave the pipe's one-element page cache
> populated. Now, the same purpose is served by the page being inserted
> as a size-0 buffer, and the next write attempting to merge with that
> buffer.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  fs/pipe.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 4d0799e4e719..097400cce241 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -508,13 +508,14 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
>  			struct page *page = pipe->tmp_page;
>  			int copied;
>  
> -			if (!page) {
> +			if (page) {
> +				pipe->tmp_page = NULL;
> +			} else {
>  				page = alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
>  				if (unlikely(!page)) {
>  					ret = ret ? : -ENOMEM;
>  					break;
>  				}
> -				pipe->tmp_page = page;
>  			}
>  
>  			/* Allocate a slot in the ring in advance and attach an
> @@ -534,7 +535,6 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
>  				buf->flags = PIPE_BUF_FLAG_PACKET;
>  			else
>  				buf->flags = PIPE_BUF_FLAG_CAN_MERGE;
> -			pipe->tmp_page = NULL;
>  
>  			copied = copy_page_from_iter(page, 0, PAGE_SIZE, from);
>  			if (unlikely(copied < PAGE_SIZE && iov_iter_count(from))) {
> -- 
> 2.48.1
> 


