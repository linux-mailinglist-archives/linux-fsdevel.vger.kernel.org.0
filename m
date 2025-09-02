Return-Path: <linux-fsdevel+bounces-60002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0269B40A49
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 18:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C013ADF88
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 16:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303DB33CEB9;
	Tue,  2 Sep 2025 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="lQARut9W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8802335BC6;
	Tue,  2 Sep 2025 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756829566; cv=none; b=TOdA3dvE7t88f2BIYgTfSa1g9jGpB4ifNmchc1JNnzVfIdKBYeRuRq8zR6Nk2+6fScYh+xD1AOz8dj8IS4uooJuB4ZUQbnz7zIqvGiN9tJuDI7teMZQih/22a9E2NnV3yv3H6a01p/79Qt2TiwhxYNTiMZ1hJgWK+OM5Vxo79d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756829566; c=relaxed/simple;
	bh=5avgvEP3XxLW1FEb1wh9OlMrNkakvRKUU3W73a6ZmMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j4alweKLKwvIVhPUYCxw/72hWLQVFethWwx8hgFNui9p+4B8Whl+T2CGQi67XePk0wcZjlP2jf0+SnGAfkWGAlrmPM3TBRBL6QkSkuEF8U2p2omHyPK5TlhVhX20nzB/DdvSDC4e9vEbkD2Wg0pdHui00qcMBg44EvVzS3F7XZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=lQARut9W; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cGW3p20KkzlfnCV;
	Tue,  2 Sep 2025 16:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1756829553; x=1759421554; bh=zLHsMuSoN87Y/kpFANGBnIy5
	780AiDprbMGpVpen4tY=; b=lQARut9W9c51D4XL1oAzxysF19Y+3QHFc2F9OEsR
	h39y+s3ur/7jYldadPxTguxvg3Ycn4O+XY4uYMd/f+kwVcAUZs1ZzkcqRoGARq9R
	NbtFh6U+SPyJPHERkPA0uPX320V9WBts1iezGyFVV2OhHlXgrDQGIVVQv/Fn8UuA
	CaC3TsjTBNF94zl0UjVE0FsDOO32SUj7DyIhLu01o4HTpY2Wt+EFmShrs+CEsp72
	V2OT8gYsBrPQKf8DcUV73C0Bjmq37uZRwJC7xbHn8Nq8SU1PjQ6wrF5EK41HjzJf
	e46v73JhJWXdm7z+PEdpDYzaBHZtvDeloofoWLyPdqVFfg==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 4d38XxLOeDyA; Tue,  2 Sep 2025 16:12:33 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cGW3Z3Rqyzlh3sc;
	Tue,  2 Sep 2025 16:12:25 +0000 (UTC)
Message-ID: <e844fe01-7cfa-4aff-b21e-d0ad04399829@acm.org>
Date: Tue, 2 Sep 2025 09:12:24 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] fs: add an enum for number of life time hints
To: hch <hch@lst.de>, Hans Holmberg <Hans.Holmberg@wdc.com>
Cc: "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 Carlos Maiolino <cem@kernel.org>, Dave Chinner <david@fromorbit.com>,
 "Darrick J . Wong" <djwong@kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 axboe@kernel.dk
References: <20250901105128.14987-1-hans.holmberg@wdc.com>
 <20250901105128.14987-2-hans.holmberg@wdc.com>
 <20250902054108.GA11431@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250902054108.GA11431@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/1/25 10:41 PM, hch wrote:
> Looks good, but you probably want to add a few more folks that
> created this constant and the header to the Cc list.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> On Mon, Sep 01, 2025 at 10:52:04AM +0000, Hans Holmberg wrote:
>> Add WRITE_LIFE_HINT_NR into the rw_hint enum to define the number of
>> values write life time hints can be set to. This is useful for e.g.
>> file systems which may want to map these values to allocation groups.
>>
>> Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
>> ---
>>   include/linux/rw_hint.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/rw_hint.h b/include/linux/rw_hint.h
>> index 309ca72f2dfb..adcc43042c90 100644
>> --- a/include/linux/rw_hint.h
>> +++ b/include/linux/rw_hint.h
>> @@ -14,6 +14,7 @@ enum rw_hint {
>>   	WRITE_LIFE_MEDIUM	= RWH_WRITE_LIFE_MEDIUM,
>>   	WRITE_LIFE_LONG		= RWH_WRITE_LIFE_LONG,
>>   	WRITE_LIFE_EXTREME	= RWH_WRITE_LIFE_EXTREME,
>> +	WRITE_LIFE_HINT_NR,
>>   } __packed;
>>   
>>   /* Sparse ignores __packed annotations on enums, hence the #ifndef below. */
>> -- 
>> 2.34.1
> ---end quoted text---

Thanks Christoph for having Cc-ed me. I'm not a big fan of this type of
change because it makes it harder to write switch-statements without
'default:' clause. From a quick look I haven't found any such
switch-statements on 'enum rw_hint' so I'm fine with this change.

Bart.

