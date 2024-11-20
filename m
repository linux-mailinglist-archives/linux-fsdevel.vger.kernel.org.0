Return-Path: <linux-fsdevel+bounces-35309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC52B9D3933
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 12:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1BE72876BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 11:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A836619C554;
	Wed, 20 Nov 2024 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rezgFK9G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B01146D53;
	Wed, 20 Nov 2024 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732101073; cv=none; b=JUB4VYm+HcyJeEu1JMke8muOGNrdvDk20ZLzASld6znfA6riL4hn6rP5EyWiQMfGFBqGuydCYUZvW8PCKFy6P89mxe8+h3VzB49RLqmVcYoAdUTFK4yHgvzlgISY3bgbGl/nfDq8jqe27kyxmoDm2fYYu2JUraH3EjEB7Ej2uEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732101073; c=relaxed/simple;
	bh=C/pCaXi8Tl2CYDP6P/hKG3s7s1R/DgUiLQ64LQ5p+vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6LtKaIeGtTMnOTWkQZiIj61f7W6qVvuKlMOqquXwALyzomxYwijcrX9mVWCLKTRnWAwjHjuYrxFzTqXRDESRJpAGYOLsRMfSCsNZGijPH9Ujm4JyNbuW6u4K2WUciD3ysU0An3BinI3dpL3ZOsgmXQ6B5EYK0O07+GykzCSkLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=rezgFK9G; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Fimso/y6Z29t20Np1FUvgnHFVBfSLUNQ/d84Zd3sby4=; b=rezgFK9GQyCYRlsF5F89WYAyyY
	tnrKmhga1hIUhz73nuNepGslrSJAijiikprnRu+bbqrSs+zMcoTDzH7jL+6q/zTnmufi2QPgczClR
	UWv7ziMHY9+4d7oisBk9gxK8j+OmfJPA1rx6Wp9U5wNtcigoNe7I8o/zxpqy/bViKtypeQokMmtqy
	6NagOmPC8iCHbrpf09RocffuE7r7P7V01/1t5PQnNUMZE+ZUUo4j0uE763xi6PjulKB8WcNmCh2CO
	HzJZXWe3wSLfJgb8syCIrVxFZhVYj0C0ThZwtv/RJ8p46NYjXImn/HSQWWjP49pJkbP6PR/1din2t
	SbWKnzgw==;
Received: from [179.118.189.160] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tDibt-009m9F-6w; Wed, 20 Nov 2024 12:11:01 +0100
Message-ID: <72e793e3-e31e-4caa-b2a8-96886036964b@igalia.com>
Date: Wed, 20 Nov 2024 08:10:54 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tmpfs: Unsigned expression compared with zero
To: guanjing <guanjing@cmss.chinamobile.com>
Cc: linux-fsdevel@vger.kernel.org, krisman@kernel.org, tytso@mit.edu,
 brauner@kernel.org, akpm@linux-foundation.org, hughd@google.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20241120105150.24008-1-guanjing@cmss.chinamobile.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20241120105150.24008-1-guanjing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi guanjing,

Em 20/11/2024 07:51, guanjing escreveu:
> The return value from the call to utf8_parse_version() is not
> of the unsigned type.
> 
> However, the return value is being assigned to an unsigned int
> variable 'version'. This will result in the inability to handle
> errors that occur when parsing a UTF-8 version number from
> a string.
> 
> Additionally, this patch can help eliminate the following
> Coccicheck warning:
> 
> mm/shmem.c:4378:6-13: WARNING: Unsigned expression compared with zero: version < 0
> 
> Fixes: 58e55efd6c72 ("tmpfs: Add casefold lookup support")
> Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>

Another fix was already sent: 
https://lore.kernel.org/lkml/20241111-unsignedcompare1601569-v1-1-c4a9c3c75a52@gmail.com/

