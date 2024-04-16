Return-Path: <linux-fsdevel+bounces-17080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3488A77B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 00:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0761F23EAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 22:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C6784DF6;
	Tue, 16 Apr 2024 22:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="afuGsyg7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582F97FBC4;
	Tue, 16 Apr 2024 22:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713305942; cv=none; b=RYtxFWDAQwbNYJQGvPjPrmo88S0ee/sPYomuaw+TmMc1twHYhd6EP/6p57KXbxfArcRD8CeO9HvBJT+w0GPW76HPfhOXzTz4cb+ryfwuUy0P3ueW1tyKUfRL97WKfUoZ/OZW0zNf7byuDPmHKZvmCrj3ZkjMDKAPE3UWkyF482o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713305942; c=relaxed/simple;
	bh=bW2XiDJ/DqQxbh79M+R3dEriHWCoVS8f5WkUD5glCqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=madhiBDC/HEYbZGnhnXA/uE+2/Fg2sLtyhlw103JyIHkWkevM2NfXkc+xo0pEU+v21Ofqsp4PjIgUxJrTyEx4Eur3nxFTCcnE+t9JRPPCpgMbePJBFRywj2ywxFBcNtRIu/5kC3Gck2WfvizGRgZ08b+yhxGEH//gQzP1WPzGX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=afuGsyg7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=lpmxt/5MIvA45UosU7v5VkKnZE4VtxUJy2lOAA317go=; b=afuGsyg7g6WxXbTtwUNFVEFqP2
	Cu98aJVx8WT9+r3qY4ASQOnsSrwbXxb2yAhQp7JuTuRZrBbu1foJ57OpV2VmPnGj06XLThWajRTqc
	ojGiDNUBNiMafRZ134Di/AxT00uwzklAmQyIb13qpL0WO8LGtHlOIWMA25pP7dBmwzRNw6G+T84H/
	jgpOQjeQS1BXZajLt9WsU9FcKOOTTDAsQWgHHEJc9RKhmHAPYCCy87+uHB3KQxJMAkhXALwT69Ws2
	tKnBvLnlQO1lWJoXTVchvmrEnu+xsv7M3p7kQ5YA7O0lFX6HtmJFVKaKRF0AO5/dYB2awp9qTdSJM
	33+8it4w==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwr8l-0000000E1xY-2iG7;
	Tue, 16 Apr 2024 22:18:59 +0000
Message-ID: <5b1938bc-e675-4f1c-810b-dd91f6915f1d@infradead.org>
Date: Tue, 16 Apr 2024 15:18:59 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] doc: Split buffer.rst out of api-summary.rst
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20240416031754.4076917-1-willy@infradead.org>
 <20240416031754.4076917-9-willy@infradead.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240416031754.4076917-9-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/15/24 8:17 PM, Matthew Wilcox (Oracle) wrote:
> Buffer heads are no longer a generic filesystem API but an optional
> filesystem support library.  Make the documentation structure reflect
> that, and include the fine documentation kept in buffer_head.h.
> We could give a better overview of what buffer heads are all about,
> but my enthusiasm for documenting it is limited.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  Documentation/filesystems/api-summary.rst | 3 ---
>  Documentation/filesystems/index.rst       | 1 +
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/Documentation/filesystems/api-summary.rst b/Documentation/filesystems/api-summary.rst
> index 98db2ea5fa12..cc5cc7f3fbd8 100644
> --- a/Documentation/filesystems/api-summary.rst
> +++ b/Documentation/filesystems/api-summary.rst
> @@ -56,9 +56,6 @@ Other Functions
>  .. kernel-doc:: fs/namei.c
>     :export:
>  
> -.. kernel-doc:: fs/buffer.c
> -   :export:
> -
>  .. kernel-doc:: block/bio.c
>     :export:
>  
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index 1f9b4c905a6a..8f5c1ee02e2f 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -50,6 +50,7 @@ filesystem implementations.
>  .. toctree::
>     :maxdepth: 2
>  
> +   buffer

This causes:

Documentation/filesystems/index.rst:50: WARNING: toctree contains reference to nonexisting document 'filesystems/buffer'


>     journalling
>     fscrypt
>     fsverity

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

