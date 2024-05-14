Return-Path: <linux-fsdevel+bounces-19467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C558E8C5B74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 21:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328A92834DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 19:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43C0180A96;
	Tue, 14 May 2024 19:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZ6Sy20+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63741E504
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 19:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715713622; cv=none; b=GQxx35ueYR9V15ROyCBqArTlPYPsmVIbHv/i9kCDBu+QgdklTrOW5tuphoxUfmTlpAUdDAn2uNGLRVylQE6lWKjVW+gBCST0qM0QHrumWw7/BnIb38ZboCK00xEUzv6M0P93+UckOfWhl6EUvNDJt5hIiivo6AgQfYUTQrhm1LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715713622; c=relaxed/simple;
	bh=SRDKfYtiOyAk7J+SMEGjHxRBXf/XPUfl6KFIgr9/0as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8mbxo3VX1obj4XA89n9Nx3x8/2OUwI8LR/orYsy0RXfTqGLlOHH8jSPw3VqxLSCzAnxseXWRIii0z2YOchB0yad6NyFCuHdOSkbQ4MHBrJhUI71zr66bP0CQOQdepAZ6ANA9XZRtoAJNO/b5sGgVyYoIZ1VhZoHUVbFGsdc6s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iZ6Sy20+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715713619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aYUW0UPqFdmZGbNOSxfwtHAWVqif1LCZdrKVkYmtGGI=;
	b=iZ6Sy20+bUSNHESGiSmMe3e9eavjG6oe/F7WFX5QMlrJ1BrNpT8wllPiIZp8m/GDdjLpCs
	v8GHCzAqkmLizg6CcZiIXiTkl/RhFKqUOPkCYqKgnJEH5C4uNA9+aoAaxeDGJueS0OLAFW
	zh7MxX4LUy9kJRZLPK+gPoqNmORJQZU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-f4xz3WD2NxmH2Wsnelm-yg-1; Tue, 14 May 2024 15:06:54 -0400
X-MC-Unique: f4xz3WD2NxmH2Wsnelm-yg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95263185A783;
	Tue, 14 May 2024 19:06:53 +0000 (UTC)
Received: from redhat.com (unknown [10.22.32.71])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F13A2026D68;
	Tue, 14 May 2024 19:06:53 +0000 (UTC)
Date: Tue, 14 May 2024 14:06:51 -0500
From: Bill O'Donnell <bodonnel@redhat.com>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-fsdevel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] zonefs: enable support for large folios
Message-ID: <ZkO2S3XiGDrTVrmi@redhat.com>
References: <20240513223718.29657-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513223718.29657-1-jth@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Tue, May 14, 2024 at 12:37:18AM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Enable large folio support on zonefs.
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks fine.
Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>

> ---
>  fs/zonefs/super.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 37080ec516e8..3c5b4c3a0c3e 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -662,6 +662,7 @@ static struct inode *zonefs_get_file_inode(struct inode *dir,
>  	inode->i_op = &zonefs_file_inode_operations;
>  	inode->i_fop = &zonefs_file_operations;
>  	inode->i_mapping->a_ops = &zonefs_file_aops;
> +	mapping_set_large_folios(inode->i_mapping);
>  
>  	/* Update the inode access rights depending on the zone condition */
>  	zonefs_inode_update_mode(inode);
> -- 
> 2.35.3
> 
> 


