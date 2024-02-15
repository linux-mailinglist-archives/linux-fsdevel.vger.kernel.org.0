Return-Path: <linux-fsdevel+bounces-11697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C9C856268
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 13:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3A2CB24D6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 11:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349DE12B14B;
	Thu, 15 Feb 2024 11:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9jYecNL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA77B12A14D
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 11:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997379; cv=none; b=VnZELqrp+6+yX3SlcGFN95WAJZKFu5/MkV3YVXdtffA727lBViXoDReJF4i7eVUocR92AgXRROJfkJZYl5t2NJNmjQ24G7eXOkawfkP1wrWNzAjBPdjrUXEVOgcUR5D10lRSrF1ezgUpeUznVCROhsdSrBxNQnKq1bMzSCQgQO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997379; c=relaxed/simple;
	bh=/FTXlztzle2L/AhigWw1U4jQU2T/XKgKPnl46C3daJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaH7ol2EWV6jMWC8wAN1ABLYbvJ42lN5cUTzMxKHXMTG/UIgT2cnyQY+9z6Fx3R2rZJedk9goWxOq3a/0Spili4w+InPOe/TjLm/wikMDysCGIxz1MMh1T685cEup7CrhHAjPJbSbWzzlJaFdKZQcHyozNQbGdCwx7bOYWr/7LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K9jYecNL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707997376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xii2dGZNUM53ImanG6FtSPY3VdLuDxHQOVnxEu+XqVY=;
	b=K9jYecNL8Qg8Wrai5ySCFV+ZVumjSxRzlACBTD8LowvpKw6S9AQEc+EPwqHZWeaWNPzcbp
	vAOF2FTWPPbxRWamajo7OGuiUysFvnL3wkdbQ6IVjrqMvNh/Ak/j8WoiSe41AX6q6WpGA3
	R9QXt/mhu5oImzgI58ui46UpSk50wes=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-Za6kuhPdP7mORgoJwagK2g-1; Thu, 15 Feb 2024 06:42:52 -0500
X-MC-Unique: Za6kuhPdP7mORgoJwagK2g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9FAAF845DC1;
	Thu, 15 Feb 2024 11:42:51 +0000 (UTC)
Received: from bfoster (unknown [10.22.16.56])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C20F2166B36;
	Thu, 15 Feb 2024 11:42:51 +0000 (UTC)
Date: Thu, 15 Feb 2024 06:44:28 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/14] writeback: don't call mapping_set_error on
 AOP_WRITEPAGE_ACTIVATE
Message-ID: <Zc35HOF8+vVEkdQu@bfoster>
References: <20240215063649.2164017-1-hch@lst.de>
 <20240215063649.2164017-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215063649.2164017-2-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Thu, Feb 15, 2024 at 07:36:36AM +0100, Christoph Hellwig wrote:
> mapping_set_error should only be called on 0 returns (which it ignores)
> or a negative error code.
> 
> writepage_cb ends up being able to call writepage_cb on the magic
> AOP_WRITEPAGE_ACTIVATE return value from ->writepage which means
> success but the caller needs to unlock the page.  Ignore that and
> just call mapping_set_error on negative errors.
> 
> (no fixes tag as this goes back more than 20 years over various renames
>  and refactors so I've given up chasing down the original introduction)
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  mm/page-writeback.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 3f255534986a2f..703e83c69ffe08 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2535,7 +2535,9 @@ static int writepage_cb(struct folio *folio, struct writeback_control *wbc,
>  {
>  	struct address_space *mapping = data;
>  	int ret = mapping->a_ops->writepage(&folio->page, wbc);
> -	mapping_set_error(mapping, ret);
> +
> +	if (ret < 0)
> +		mapping_set_error(mapping, ret);
>  	return ret;
>  }
>  
> -- 
> 2.39.2
> 
> 


