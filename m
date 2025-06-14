Return-Path: <linux-fsdevel+bounces-51665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A86E8AD9C44
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 12:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6465F17A4A1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 10:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF9B247DF9;
	Sat, 14 Jun 2025 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0f0kZUP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC90B24B26
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Jun 2025 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749898480; cv=none; b=FhF3yitIrZ8lEfY6i5zn7TddmhwWnXbei5mF4TkJmVXKFobgO8Rhddy9/Ou6cq1sqGTlWH7aL04jSC0Fc4TvPqWN5R4C0MvvWaNZ9Lu5RPJvkoKeJdyIuVKeylPkcIoVhGQC6SyIt2AeYE5l2DtMDDPPFvcxcC4uWiw1Uo6v0JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749898480; c=relaxed/simple;
	bh=sLBWFbFq1w3pEIrPOPwjreBL5qAL0dBrcchgQWLKPEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWBmZo4h33allejtro5pnB0jVywYb5Vk0LhMCsKY/Qd1kRKbhfJSOgVAprn8tnRM69orBb/JGlANg7J+UC5hYihkXAYxhIEf/IL2WuJ0pZHtIt+K7YG0dJ7xWwzA8BYYAf2A6Uls1+yesUNfRvgR7Pp74GNynyybtnA78iJA1ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z0f0kZUP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749898477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f0uTQUkgFC9ERIewzQ+H10P2H/AyL2V2W54/aFB3GXU=;
	b=Z0f0kZUPqnoHVn9kvAStX6KCEIisVwaltc2TNBItBxMBdgo6vgsGgc36dzb3qKaVtOcXjW
	BJnmdPYgRYMgRNkafRYpYuRvZRcDRk1vckQFUtIVuuaXG9YL6LeqFstd2p3LchwaH+M+cY
	3fDdosX7fp0JAVjvT02/PeHQFCeKuBc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-K447FfE7M0-EXAc27Z67cQ-1; Sat,
 14 Jun 2025 06:54:33 -0400
X-MC-Unique: K447FfE7M0-EXAc27Z67cQ-1
X-Mimecast-MFC-AGG-ID: K447FfE7M0-EXAc27Z67cQ_1749898472
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC7D51956080;
	Sat, 14 Jun 2025 10:54:32 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.100])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7409B1956094;
	Sat, 14 Jun 2025 10:54:31 +0000 (UTC)
Date: Sat, 14 Jun 2025 06:58:06 -0400
From: Brian Foster <bfoster@redhat.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fuse: fix fuse_fill_write_pages() upper bound calculation
Message-ID: <aE1VvnDfZj0oJMMv@bfoster>
References: <20250614000114.910380-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250614000114.910380-1-joannelkoong@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Fri, Jun 13, 2025 at 05:01:14PM -0700, Joanne Koong wrote:
> This fixes a bug in commit 63c69ad3d18a ("fuse: refactor
> fuse_fill_write_pages()") where max_pages << PAGE_SHIFT is mistakenly
> used as the calculation for the max_pages upper limit but there's the
> possibility that copy_folio_from_iter_atomic() may copy over bytes
> from the iov_iter that are less than the full length of the folio,
> which would lead to exceeding max_pages.
> 
> This commit fixes it by adding a 'ap->num_folios < max_folios' check.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Fixes: 63c69ad3d18a ("fuse: refactor fuse_fill_write_pages()")
> Reported-by: Brian Foster <bfoster@redhat.com>
> Closes: https://lore.kernel.org/linux-fsdevel/aEq4haEQScwHIWK6@bfoster/
> ---

This resolves the problem for me as well. Thanks again..

Tested-by: Brian Foster <bfoster@redhat.com>

>  fs/fuse/file.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 3d0b33be3824..a05a589dc701 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1147,7 +1147,7 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
>  static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>  				     struct address_space *mapping,
>  				     struct iov_iter *ii, loff_t pos,
> -				     unsigned int max_pages)
> +				     unsigned int max_folios)
>  {
>  	struct fuse_args_pages *ap = &ia->ap;
>  	struct fuse_conn *fc = get_fuse_conn(mapping->host);
> @@ -1157,12 +1157,11 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>  	int err = 0;
>  
>  	num = min(iov_iter_count(ii), fc->max_write);
> -	num = min(num, max_pages << PAGE_SHIFT);
>  
>  	ap->args.in_pages = true;
>  	ap->descs[0].offset = offset;
>  
> -	while (num) {
> +	while (num && ap->num_folios < max_folios) {
>  		size_t tmp;
>  		struct folio *folio;
>  		pgoff_t index = pos >> PAGE_SHIFT;
> -- 
> 2.47.1
> 


