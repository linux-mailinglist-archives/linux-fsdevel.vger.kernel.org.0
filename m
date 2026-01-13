Return-Path: <linux-fsdevel+bounces-73454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE5AD1A053
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 16:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 578743028DAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 15:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAFD3043CE;
	Tue, 13 Jan 2026 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fAmOIHrq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FE325A2DE
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768319446; cv=none; b=RAWDsZCkDMn4c+ls6TDF+JqSQnD1IAS+l9mg7cDc46e6vpBjwH6w4CC6ofdD8qvQkx62q7GasFnPoV9XlDKs8p60JoR5FTn9gaF4SfDOuAOKgVz79dwLUmrp8yLJ+ltUI5eSwMZCqOvtooboWLZpselddTwfn2jvuQ+vkfUQN90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768319446; c=relaxed/simple;
	bh=vHQ0rA1StG1Zgy0F9ndqwnzle817CayfuFLY5oSanMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbl8ejsnU7/UtH7e2+pXsuv76YL1VkZiV7YceKv7pl7vkCdrODcsA5haakQSePK/c8gV/lNcE2EjQlieN/dR2iAZDm2Tdu03BUHKvOk6s91pR1WMrPR81TqqkRa1myuH5q2xF5ItPvhmmVgMzDLnlIqqsxCfxXa7cKmh+0p7Pik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fAmOIHrq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768319443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9/IkhXXqC9yhLNjAsgGulI/lesQyYUk6T6XwvSKOyC4=;
	b=fAmOIHrqkkSXA1zLyFMB/Rs6cB9vw5FUcGzFMLwOjo/j6unQWtmFN+eXQfvijuxQY1DTEm
	fALli/HFfp0ieZFfDe5zEksjpZ22Xe9PA8YQIFpJSWwKRIRH/93lIUyj8TnKOSQA5ag90o
	1d+PRi8X+Tyr/8ZSgA0SRZzufotoR9o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-hBZV14KXMWi7exVOkR9Pgg-1; Tue,
 13 Jan 2026 10:50:38 -0500
X-MC-Unique: hBZV14KXMWi7exVOkR9Pgg-1
X-Mimecast-MFC-AGG-ID: hBZV14KXMWi7exVOkR9Pgg_1768319437
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9591F18003FC;
	Tue, 13 Jan 2026 15:50:37 +0000 (UTC)
Received: from bfoster (unknown [10.22.90.9])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD2CE19560AB;
	Tue, 13 Jan 2026 15:50:36 +0000 (UTC)
Date: Tue, 13 Jan 2026 10:50:34 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: wait for batched folios to be stable in
 __iomap_get_folio
Message-ID: <aWZpyuaG86LdtmVm@bfoster>
References: <20260113153943.3323869-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113153943.3323869-1-hch@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Jan 13, 2026 at 04:39:17PM +0100, Christoph Hellwig wrote:
> __iomap_get_folio needs to wait for writeback to finish if the file
> requires folios to be stable for writes.  For the regular path this is
> taken care of by __filemap_get_folio, but for the newly added batch
> lookup it has to be done manually.
> 
> This fixes xfs/131 failures when running on PI-capable hardware.
> 
> Fixes: 395ed1ef0012 ("iomap: optional zero range dirty folio processing")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/iomap/buffered-io.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index fd9a2cf95620..6beb876658c0 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -851,6 +851,7 @@ static struct folio *__iomap_get_folio(struct iomap_iter *iter,
>  		}
>  
>  		folio_get(folio);
> +		folio_wait_stable(folio);
>  		return folio;
>  	}
>  
> -- 
> 2.47.3
> 
> 


