Return-Path: <linux-fsdevel+bounces-34965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E3B9CF32F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 18:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E09283F01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 17:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DD51D63F7;
	Fri, 15 Nov 2024 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vBAo++Yz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BFC1D618E
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 17:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731692703; cv=none; b=etEQY1MCVLcPZBpteb4gKNsemS1O2v0kC+pMx4NA5hsm4AUtgmP/eIvkTNjn8dcSRxraHuKmGUsmnOP04JcYX5YrACJH58J/IpA6iA3X9N8qqeYGgz9HVJpFOzaqzo5UQARd2DknIsERvB6mJ22KqlKpH30zbaOijYZG50u44IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731692703; c=relaxed/simple;
	bh=xqENlfIbZ6oxYGPT3ENwgUPz7q+WvgG+QMg5G0GrWJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hv+ERfXFYjiLL1VSIoZ+FtkM+xkBsirWuL9KbbLCX7B+QQjs0Z0ZJUS00skXMDjKh98xN04750XSzOztyPebRi6o3P2GaoldD/6WXpgL4ItyLQDu7JEzWSiX1LPNmad3AMgfWQThb+x1HISM0O1EnIEFZgrMotxtk9kZppSUkpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vBAo++Yz; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3e5f835c024so1243686b6e.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 09:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731692700; x=1732297500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GX5wJ6oLxec3STDa1FVtfsmqMbzKtWScheytSQkT1U8=;
        b=vBAo++Yzi2hDov/7+u0KWx6DifVjZDKRweV1NSDXXlfOAglgIZwxXj8Rttz1OgbpNH
         Qwy58xHUTEXJurOnc4tY67CioMNZwfjT5HmY8Hw9ZZVumaUGZBeQuFS+ZP9sA6kGemql
         OJ15Mn4WEJORwJVSLTSr3vsoxRDw0p1g4tCxTya+pmQ3mqNOD9G25XXad6gcOVyTKNav
         T0sSk7AvxB3OQb9wjU0ybdXXfTKkwsdY7AD9uFx2Y8wZNwgoH1FJdr74/lBpCDOl2NLu
         Y9Q5h9pIIq6hzvGgHk992fqL4SeA+QdUUEqxwCQk/IlG2wP0TWAmwSwtdOX8hs/81Jtw
         qIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731692700; x=1732297500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GX5wJ6oLxec3STDa1FVtfsmqMbzKtWScheytSQkT1U8=;
        b=ClRnj99WgwwOi+U/P5yfVtscztSsTl89PeLneShJyOyR4qoKGDpN3Db9WQ9C4AMxaY
         45h12h4NFEl1s3KXsueg4YKk2MWSgRzuC2/BL3mr7v/4x6AGOLGq754x/K9k1s9gDUKz
         l6J7Bqe51/rup0a/tfqdfj5GfVWlgJJOGdeJZKKRaCvdeLuEKNtzQpMMRZ2sM7wk+6RU
         GAuz2f6C0g8mAM7AiQZGrpiw3w/0LE8+s4KemE+knEr92Ig1YIQuuYj/4XWbnwlrwVfr
         0orbXNSUdLYE2DDHJZ8DVKkwafincEhOOlKJ2TSnYvhhhsor+wCkifw9huIPd1+V1RZq
         KajA==
X-Forwarded-Encrypted: i=1; AJvYcCUUfXeP2Y/FwqXOlNre6dNWIqer83/swPvln4uKtWHWTlZvWyh0xyS6Py4iOcsT2CSp8ItTm8HbUpmv5CAJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyyKJo4KLQUjWuYahRKDX2udA4hmOYJeh6y/Pz+tThVg+x5Akln
	Nwo2nWS/hhCDGVmc2qf62VujkXBH+Epar0behGbqtT+rMC/hhD+zafvxTswFBK8=
X-Google-Smtp-Source: AGHT+IE7u0RxmsRL3LQWgWu6xddXzAE9XDdBJ1jPG6HxqNvh9lsaMK0XyjGjnH4cynjuaCDt1FSOiA==
X-Received: by 2002:a05:6808:4401:b0:3e7:c366:d17f with SMTP id 5614622812f47-3e7c366d358mr1389370b6e.38.1731692700454;
        Fri, 15 Nov 2024 09:45:00 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e7bcd12fbasm661744b6e.21.2024.11.15.09.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 09:44:59 -0800 (PST)
Message-ID: <97b3061c-430d-4fc0-9b62-ab830010568e@kernel.dk>
Date: Fri, 15 Nov 2024 10:44:58 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/11] io_uring: introduce attributes for read/write
 and PI support
To: Christoph Hellwig <hch@lst.de>, Pavel Begunkov <asml.silence@gmail.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>, kbusch@kernel.org,
 martin.petersen@oracle.com, anuj1072538@gmail.com, brauner@kernel.org,
 jack@suse.cz, viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 gost.dev@samsung.com, linux-scsi@vger.kernel.org, vishak.g@samsung.com,
 linux-fsdevel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
References: <20241114104517.51726-1-anuj20.g@samsung.com>
 <CGME20241114105405epcas5p24ca2fb9017276ff8a50ef447638fd739@epcas5p2.samsung.com>
 <20241114104517.51726-7-anuj20.g@samsung.com> <20241114121632.GA3382@lst.de>
 <3fa101c9-1b38-426d-9d7c-8ed488035d4a@gmail.com>
 <20241114151921.GA28206@lst.de>
 <f945c1fc-2206-45fe-8e83-ebe332a84cb5@gmail.com>
 <20241115171205.GA23990@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241115171205.GA23990@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/15/24 10:12 AM, Christoph Hellwig wrote:
> On Fri, Nov 15, 2024 at 04:40:58PM +0000, Pavel Begunkov wrote:
>>> So?  If we have a strong enough requirement for something else we
>>> can triviall add another opcode.  Maybe we should just add different
>>> opcodes for read/write with metadata so that folks don't freak out
>>> about this?
>>
>> IMHO, PI is not so special to have a special opcode for it unlike
>> some more generic read/write with meta / attributes, but that one
>> would have same questions.
> 
> Well, apparently is one the hand hand not general enough that you
> don't want to give it SQE128 space, but you also don't want to give
> it an opcode.
> 
> Maybe we just need make it uring_cmd to get out of these conflicting
> requirements.

Let's please lay off the hyperbole here, uring_cmd would be a terrible
way to do this. We're working through the flags requirements. Obviously
this is now missing 6.13, but there's no reason why it's not on track to
make 6.14 in a saner way.

-- 
Jens Axboe

