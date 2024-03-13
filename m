Return-Path: <linux-fsdevel+bounces-14299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D8787AA3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 16:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A891F261BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 15:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D0645BF3;
	Wed, 13 Mar 2024 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m6b/4oU9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F02045978;
	Wed, 13 Mar 2024 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710342982; cv=none; b=R3Qpf2asUOEQmjPdO5vt50u3KGS4myL2+0KHr300Oczxc84n39DydsBwpKAKnTzZWOqiI3uVBJadqI3+b7fH3fMPa2LkjlkVcuVxcGXf1VmkAGrtMwgd70UvT0lTak1pebGbyuCxWmH5PsMraKjTSw1jLxW3hO2PwZbWkvI6/0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710342982; c=relaxed/simple;
	bh=RHS+XuMEn8kL1ufzPN0FvcSTJWpvFWqnB4jbHIZirIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BkS765UUAYTcMnuP+YiXq6ZfZvihlzcxzlV3gML1VYWoPjtfh92FKMdFDCBBjkUfODMA7S3xxfM0bKOv+XO7gpcQrGqQ2WkHHIFqo2fk1unEEafj+r22uoqCWx04YmYHz9SgyU48Eph3+bw9pb1x7HeZxv4OOXhnJwpEGKoErKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m6b/4oU9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=InxoltL9Z3LnNnWLek5uQ3+ekEQtIQzIj0k2w89gXSA=; b=m6b/4oU9b3E8nRGPfFAJTwbL7J
	bzx2OXiXiT9ReRp2PT5fKFiCmb7d6tOKEzPMhAgJtq3Wghd1DSWPRh4rHqkfXkK5oZbgditGpddNh
	X07m4SalA4M/fEChjCHVswhGiXzXsfEWlKSPpSKHxcD+yW/yyz2FFYaUxoifweocsyGAiNCTP7XU0
	WmcfKU2xKsRD9lobRLOsO13hgIi3xTsjKuvSPgoyPr9WnVxV3QDC877eAxNqfPT0D7Iz7dbwcc9sT
	hN4BAVp9V24q5Dwjhy8oVN/MlAoIEWtiOcHEyfT9QZ31cn2NfWTDzgL4wTH8qcpWJbF4k1NNeKexD
	d6lBwFXQ==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkQL3-0000000AZWr-3Xv4;
	Wed, 13 Mar 2024 15:16:17 +0000
Message-ID: <544d7b9d-ef15-463f-a11c-9a3cca3a49ea@infradead.org>
Date: Wed, 13 Mar 2024 08:16:16 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] afs: Revert "afs: Hide silly-rename files from userspace"
To: David Howells <dhowells@redhat.com>,
 Marc Dionne <marc.dionne@auristor.com>,
 Markus Suvanto <markus.suvanto@gmail.com>
Cc: Jeffrey Altman <jaltman@auristor.com>,
 Christian Brauner <brauner@kernel.org>, linux-afs@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3085695.1710328121@warthog.procyon.org.uk>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <3085695.1710328121@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/13/24 04:08, David Howells wrote:
>     
> This reverts commit 57e9d49c54528c49b8bffe6d99d782ea051ea534.
> 
> This undoes the hiding of .__afsXXXX silly-rename files.  The problem with
> hiding them is that rm can't then manually delete them.
> 
> This also reverts commit 5f7a07646655fb4108da527565dcdc80124b14c4 ("afs: Fix
> endless loop in directory parsing") as that's a bugfix for the above.
> 
> Fixes: 57e9d49c5452 ("afs: Hide silly-rename files from userspace")
> Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
> Link: https://lists.infradead.org/pipermail/linux-afs/2024-February/008102html

Not Found

The requested URL was not found on this server.

> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> ---
>  fs/afs/dir.c |   10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> index 8a67fc427e74..67afe68972d5 100644
> --- a/fs/afs/dir.c
> +++ b/fs/afs/dir.c
> @@ -474,16 +474,6 @@ static int afs_dir_iterate_block(struct afs_vnode *dvnode,
>  			continue;
>  		}
>  
> -		/* Don't expose silly rename entries to userspace. */
> -		if (nlen > 6 &&
> -		    dire->u.name[0] == '.' &&
> -		    ctx->actor != afs_lookup_filldir &&
> -		    ctx->actor != afs_lookup_one_filldir &&
> -		    memcmp(dire->u.name, ".__afs", 6) == 0) {
> -			ctx->pos = blkoff + next * sizeof(union afs_xdr_dirent);
> -			continue;
> -		}
> -
>  		/* found the next entry */
>  		if (!dir_emit(ctx, dire->u.name, nlen,
>  			      ntohl(dire->u.vnode),
> 
> 

-- 
#Randy

