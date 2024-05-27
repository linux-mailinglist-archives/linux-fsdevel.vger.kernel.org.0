Return-Path: <linux-fsdevel+bounces-20248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2348D073C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 18:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17985B25E10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 15:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB8B79E1;
	Mon, 27 May 2024 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="F9BvcxNL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCDE17E8E0
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716824190; cv=none; b=qyxws6mjKoQ6okArGcumB6NSs+IDVopKAuDuNLjH4t8lI2lPPKlDLsLCofSGm0Uu15IW90WF3h566FHwwMWeqDrVZxfl/5Ow7mFVs9pkMP0tecfkyERj541IJcIFCGhZ3sHEACqGttyFf5vIYEgILIPw/f0hz7UEBIIGji5kBxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716824190; c=relaxed/simple;
	bh=tL9SRFm+QXGfjo5/k/kK7X/HFQKtJRXpCoX7gFPiXKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kxfttBMJ5IcvSXx6+BkI2uAF1FxXJ4jouFAq8wt38qP2MuiGrnBWPxu4L16pkCVGKlPFehBLAPGaPSLLTgeLGRP7az4cmRCEchFu52FPcfsvkOIxsDlHySM+HNEeqQ0EWHaBHqlPjQBp2qPt15+tGg9YQlgRBYa2cMyGmlpQy/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=F9BvcxNL; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f4850918d0so46975ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 08:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716824187; x=1717428987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FGMRKGoSYUA5y3/8ZCfrZ1xp7rqzMx12hKUQWEXXdwY=;
        b=F9BvcxNLHbFCL5XfHLnGTxQs/kbGpALZnSl2DYjNA/21xx0FBmmySwAJN/5dtkPhZV
         IwwKjcqRB9pV10OOLL6wHdu5znp/6PE86Vas57cBS/wuAbBw2UZndM8t2ducr7YYWm6Y
         qK9hMREyXKjeBhZWSjTI2InCbzAtbz3PLAwXmX2LUbmD27CV84Ld62XttJh+nGQRapAs
         b070pptuUluTj7BrbyTY7tkobVJKFo/9qxvErZHnOMlm8wItNpZuLUNC8RDdtzThAB2N
         KMJsW+YN/2uWpInjYvnpvDqSoW6Kn8DylQoMu4CqVNrueusLUWYFZNSZk1pdxY03zMc1
         k2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716824187; x=1717428987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FGMRKGoSYUA5y3/8ZCfrZ1xp7rqzMx12hKUQWEXXdwY=;
        b=rU51NnvjUMB8Ylwmf4/WPR+FrkZjL+p+QmTH1wTHFepnx4gcMZhZmmohDZuhP+oFy+
         M5U0LJ1sHlFUzaIuczaFgtqWamTvvJ15mINvZwUEYH99Ay2wjUZ9Zb4r54+7ecB6pBXI
         LU5UoY//kTRr/tGR/ob2hz4fiSRRGmw198fntpD4ELZIEznokN+NMUus0W4LOj+krv7w
         Qm8dSZV+TR3cw+pHlB4ZYEko17z9hcx39xYIy9MhwnxOEt3AHrLhF5u0EPUj3rMmWjeh
         IH0rL6t+3/rgpLNRKLd6dpZ9kQZtSSYQsuAzjaQR4Op5/athESsrJrlZ1QvyxNXf/X7K
         uO+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWYO2KBjXCIxr10lCERn+9bCsdkNDZYUZP9EsgP18dvdOPCQGAwuHQkxDybt3lpO4p8yUcRCV+jX079lDbfTMqsAHZgW94hnUIguIlzQ==
X-Gm-Message-State: AOJu0Yzi8FLBWrV9HTHCA+0C46vPGHPjT9PIV7BQ6YQcSlWVWvSoAtpT
	y67znfommHuIPK7L5F4KjW4po4huzqkqV6xsstohYTVTLsmjORW0FCnFAXqvS8Y=
X-Google-Smtp-Source: AGHT+IHTxIPNAK3HsNoC9uItVsCnZCK8MD3ThRKVvVNi4TwdQa2YRFJqyU+MaLPmqStXfF6Dl3dotQ==
X-Received: by 2002:a17:902:e810:b0:1f2:fd9a:dbf8 with SMTP id d9443c01a7336-1f449907a09mr116945035ad.5.1716824186842;
        Mon, 27 May 2024 08:36:26 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c970058sm64280955ad.121.2024.05.27.08.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 08:36:26 -0700 (PDT)
Message-ID: <c66ca795-da93-437c-bb11-718801f8114a@kernel.dk>
Date: Mon, 27 May 2024 09:36:24 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/filemap: invalidating pages is still necessary when io
 with IOCB_NOWAIT
To: Liu Wei <liuwei09@cestc.cn>
Cc: akpm@linux-foundation.org, hch@lst.de, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 rgoldwyn@suse.com, willy@infradead.org
References: <024b9a30-ad3b-4063-b5c8-e6c948ad6b2e@kernel.dk>
 <20240527100908.49913-1-liuwei09@cestc.cn>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240527100908.49913-1-liuwei09@cestc.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/27/24 4:09 AM, Liu Wei wrote:
> I am a newer, thanks for the reminder.
> 
>>
>>>> when we issuing AIO with direct I/O and IOCB_NOWAIT on a block device, the
>>>> process context will not be blocked.
>>>>
>>>> However, if the device already has page cache in memory, EAGAIN will be
>>>> returned. And even when trying to reissue the AIO with direct I/O and
>>>> IOCB_NOWAIT again, we consistently receive EAGAIN.
>>
>> -EAGAIN doesn't mean "just try again and it'll work".
>>
>>>> Maybe a better way to deal with it: filemap_fdatawrite_range dirty pages
>>>> with WB_SYNC_NONE flag, and invalidate_mapping_pages unmapped pages at
>>>> the same time.
>>>>
>>>> Signed-off-by: Liu Wei <liuwei09@cestc.cn>
>>>> ---
>>>>  mm/filemap.c | 9 ++++++++-
>>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/filemap.c b/mm/filemap.c
>>>> index 30de18c4fd28..1852a00caf31 100644
>>>> --- a/mm/filemap.c
>>>> +++ b/mm/filemap.c
>>>> @@ -2697,8 +2697,15 @@ int kiocb_invalidate_pages(struct kiocb *iocb, size_t count)
>>>>  
>>>>  	if (iocb->ki_flags & IOCB_NOWAIT) {
>>>>  		/* we could block if there are any pages in the range */
>>>> -		if (filemap_range_has_page(mapping, pos, end))
>>>> +		if (filemap_range_has_page(mapping, pos, end)) {
>>>> +			if (mapping_needs_writeback(mapping)) {
>>>> +				__filemap_fdatawrite_range(mapping,
>>>> +						pos, end, WB_SYNC_NONE);
>>>> +			}
>>
>> I don't think WB_SYNC_NONE tells it not to block, it just says not to
>> wait for it... So this won't work as-is.
> 
> Yes, but I think an asynchronous writex-back is better than simply
> return EAGAIN. By using __filemap_fdatawrite_range to trigger a
> writeback, subsequent retries may have a higher chance of success. 

And what's the application supposed to do, just hammer on the same
IOCB_NOWAIT submission until it then succeeds? The only way this can
reasonably work for that would be if yo can do:

1) Issue IOCB_NOWAIT IO
2) Get -EAGAIN
3) Sync kick off writeback, wait for it to be done
4) Issue IOCB_NOWAIT IO again
5) Success

If you just kick it off, then you'd repeat steps 1..2 ad nauseam until
it works out, not tenable.

And this doesn't even include the other point I mentioned, which is
__filemap_fdatawrite_range() IO issue blocking in the first place.

So no, NAK on this patch.

-- 
Jens Axboe


