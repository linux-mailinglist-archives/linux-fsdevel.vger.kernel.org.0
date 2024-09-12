Return-Path: <linux-fsdevel+bounces-29217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2792D9772CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 22:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B107AB23BDF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 20:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BE51C174F;
	Thu, 12 Sep 2024 20:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="uSvi5fR2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DDD19048C;
	Thu, 12 Sep 2024 20:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726173423; cv=none; b=pdFZFcDvBvof66iJ4VeiZBMc63Rz46h3bL316fhMOJxdGrXWNLaPuZgnOTyyyVfzx8QydPVGN3q+TvKJS7eY2qkOEqC/7KktkTF5owmGStOmckEDDHTIoLSkpchXuK4xxAPo3mAm4pqJlCpvAbeTiJyk4Wd4qK/TasWhJW9jiWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726173423; c=relaxed/simple;
	bh=7+M44koOMskpETV9kPeIdnNGWICx9D3h0F8RX7huMNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbQHKYXuE9tY9L/43ZRE1vZelW3ckpoOtw1mjrwGSeLkh4K1VaVtr8v0fTLVtGApS5JPlGJcxE2mThYEDexZCG0OTyMuizZNsClny/v6Zxrnt2ZHu3OL9XlNcoLZhC3oYcm9qbJzNJEX1icswl+X7S6NjGLAlVg0WLIv7PmroHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=uSvi5fR2; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4X4TkZ655hzlgMVN;
	Thu, 12 Sep 2024 20:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1726173408; x=1728765409; bh=9yS7HA6fKYDCCYVIl+KdIxvA
	ej4qJ3r4GXFGjMqBgvo=; b=uSvi5fR2vmRTU5PsBWAozmgRWg15DQCoTw9QYG0Q
	JILXCI2W17PMdjeB0eCaY4R9b4p5zp9bb+bfYJlcGbHdBTfiFtQtMF3dUYguzo/Z
	TlwUp0S+sLzCJ2ZszrvHZG5CDzMw6iEjadRBSJIy5BAgA0y3vIeIBsfBENIkbnoW
	r11vxY1o7k84TSJpKMgfwayzh+k0/J3gvxSYRGPxCpPyAAVkWDiPCc0uq08D7fpJ
	66OjaML0t1A0/rH2BCmDW3sZR1xKfqOJVpFBi7aKD0+DNxhM9SCJFcr5+emr55CI
	a+9PjgbvNYdOfcQHlw3ysfvDS3LLjk0rwkbAPwa/6Q1aNQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Z4I_UPR0myMw; Thu, 12 Sep 2024 20:36:48 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4X4TkN0rMHzlgT1M;
	Thu, 12 Sep 2024 20:36:43 +0000 (UTC)
Message-ID: <53043e99-be5f-4fc6-be87-4ebcb8ce99b6@acm.org>
Date: Thu, 12 Sep 2024 13:36:43 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] fcntl: add F_{SET/GET}_RW_HINT_EX
To: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com,
 James.Bottomley@HansenPartnership.com, brauner@kernel.org,
 viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
 jlayton@kernel.org, chuck.lever@oracle.com
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
 javier.gonz@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>
References: <20240910150200.6589-1-joshi.k@samsung.com>
 <CGME20240910151052epcas5p48b20962753b1e3171daf98f050d0b5af@epcas5p4.samsung.com>
 <20240910150200.6589-4-joshi.k@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240910150200.6589-4-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 8:01 AM, Kanchan Joshi wrote:
> diff --git a/include/linux/rw_hint.h b/include/linux/rw_hint.h
> index b9942f5f13d3..ff708a75e2f6 100644
> --- a/include/linux/rw_hint.h
> +++ b/include/linux/rw_hint.h
> @@ -21,4 +21,17 @@ enum rw_lifetime_hint {
>   static_assert(sizeof(enum rw_lifetime_hint) == 1);
>   #endif
>   
> +#define WRITE_HINT_TYPE_BIT	BIT(7)
> +#define WRITE_HINT_VAL_MASK	(WRITE_HINT_TYPE_BIT - 1)
> +#define WRITE_HINT_TYPE(h)	(((h) & WRITE_HINT_TYPE_BIT) ? \
> +				TYPE_RW_PLACEMENT_HINT : TYPE_RW_LIFETIME_HINT)
> +#define WRITE_HINT_VAL(h)	((h) & WRITE_HINT_VAL_MASK)
> +
> +#define WRITE_PLACEMENT_HINT(h)	(((h) & WRITE_HINT_TYPE_BIT) ? \
> +				 WRITE_HINT_VAL(h) : 0)
> +#define WRITE_LIFETIME_HINT(h)	(((h) & WRITE_HINT_TYPE_BIT) ? \
> +				 0 : WRITE_HINT_VAL(h))
> +
> +#define PLACEMENT_HINT_TYPE	WRITE_HINT_TYPE_BIT
> +#define MAX_PLACEMENT_HINT_VAL	(WRITE_HINT_VAL_MASK - 1)
>   #endif /* _LINUX_RW_HINT_H */

The above macros implement a union of two 7-bit types in an 8-bit field.
Wouldn't we be better of by using two separate 8-bit values such that we
don't need the above macros?

Thanks,

Bart.

