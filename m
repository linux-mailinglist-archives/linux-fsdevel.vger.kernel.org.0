Return-Path: <linux-fsdevel+bounces-28020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CD1966166
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 14:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFF30B27631
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 12:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17D4199FB3;
	Fri, 30 Aug 2024 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="HDLC/X2j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B981D1312;
	Fri, 30 Aug 2024 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725020253; cv=none; b=E8REgfQEAgj/YCDEc8R8XTTUI2FW/Ew2+pFvWCh3Aq1aS9Hoikw9ZpF0LB2p8PzCLMBtHPJKfhNeVFPR2FyAEtGP1Wh4r8Opjqe7WeHCXxEKA6x54FjW2mpupWnQM2oCJWkN3LMwhFLzQK1OlER2UCkDMv6vptz28ergn154GfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725020253; c=relaxed/simple;
	bh=/+fKhI8KAimtiPsf1eCWbsSMjNQGP2zcD3k8ZB1ra30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Im2MJAkxOnoVsWwKv5euFocHe4cJcHGg8HWTc0j5nqJAGisHS4aRAW4PZLqn/VKKbhxnhMqlLj+ssQpuloRkw74faXaKHmUaMsVPieopMgyIXJo29sEc88tCXr9TEHPo+BZ9Ag3J8ERx5j032lPJlXwF5Aflp98ZjZhzZzjwb4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=HDLC/X2j; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WwHGL1TxYzlgMVf;
	Fri, 30 Aug 2024 12:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1725020245; x=1727612246; bh=6GlW9yIoadQq46MmyoepJYJ8
	q9LfdZqy08l1271Zu+4=; b=HDLC/X2jGKS6GEr8dCi4sdxXG4856TtMCXnGwrLk
	hPO1wOwiL6OJ5gZBVzRO5iAqQ8W4nld9tlezsQD3axIrvx2xAuAlifeCxIYW04lY
	XJNOmPI/qZS6iG5xzXM5UkRSAOla/trI5M9M5DbVuebf06mqh1FL8K07ZJa9Qw5T
	25j8wENOw8vzEmOhvCWIjuUYTIRNi/H/oSN2GNzUKuHhDihlqmBEh5SR5LjdlqFj
	HulYBaWrWGYBKs21TSU7+5oPrTh/qcnkDchEoNA+3/RuPO3N9ZZqHetbg0nhVbSr
	zJTXX/O48XQSFBtvs76WvzyIGyvQL1f6moM7RRiKzuyaAw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id CK5wHqhS3E6t; Fri, 30 Aug 2024 12:17:25 +0000 (UTC)
Received: from [10.254.113.103] (unknown [207.164.135.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WwHG807ZyzlgMVb;
	Fri, 30 Aug 2024 12:17:19 +0000 (UTC)
Message-ID: <0cfd7841-ea11-48c6-93fb-7817236c81c8@acm.org>
Date: Fri, 30 Aug 2024 08:17:18 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] fs, block: refactor enum rw_hint
To: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com,
 James.Bottomley@HansenPartnership.com, brauner@kernel.org, jack@suse.cz,
 jaegeuk@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
 javier.gonz@samsung.com
References: <20240826170606.255718-1-joshi.k@samsung.com>
 <CGME20240826171413epcas5p3f62c2cc57b50d6df8fa66af5fe5996c5@epcas5p3.samsung.com>
 <20240826170606.255718-2-joshi.k@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240826170606.255718-2-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/24 1:06 PM, Kanchan Joshi wrote:
>   /* Block storage write lifetime hint values. */
> -enum rw_hint {
> +enum rw_life_hint {

The name "rw_life_hint" seems confusing to me. I think that the
name "rw_lifetime_hint" would be a better name.

Thanks,

Bart.


