Return-Path: <linux-fsdevel+bounces-13766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B70BC873A78
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 16:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD0E1F2C51B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 15:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB441350D6;
	Wed,  6 Mar 2024 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZBRJ4Nw5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B30132472
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709738074; cv=none; b=UpIm2ZRjzhaKZMWQv95yTyqcoyL1OmbKfWqoxZ41Bq4dctlrLpBDKez5jqYVxtwj1263MMeXerx/wKTeNtOoVlKzOecRQcnUO/+zWGvnTtUWIesaSb8fAIGnsPtFcjH4rSG5iNVvRy7fGF3lwzWOIxK/A4s11CmkcgQA0B4OHcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709738074; c=relaxed/simple;
	bh=V3aJ+mDpXol1LnRkVd8frXu/5mxpgid0TGJDT/7qC6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGQ/ewRScIGiu15/2UhhPMTckEqK/5IEbqUIftXehi/sYkLEn3JJ6L756d5ibpdeo8MDKzPFC9/VdnKhKCIcS9dh96jjfpvrZ+hZI0fxjzdTxIWAcC5lrw+sJWwcEj6z1tJN0WDX/wv+PkAV9ajUM1k6DFfBlOvjhLdcDKEbwsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZBRJ4Nw5; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-365c0dfc769so2115725ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Mar 2024 07:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709738070; x=1710342870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WI8wnl72Fr4kYF1pJwPsFlO/0vFnIYu1hp3He8klX70=;
        b=ZBRJ4Nw5kAKzT6hI1cTWI2uZxh8XH7Y2i+mBi+20T9bQa3MBPM2CcHYk3d2DXSLf1O
         9MF9o2yE+qudRaFV75QWnAs2/jRaD2UyCjOX9VCsseIIqKjp6k04aB6YBD+irWxNbfE3
         gjkPIY3iqf/uVuGV6D69c3UJYqfovaIqcMEjIyi7Gy1mTNzesJ9e1qmLFAAORaFY17wb
         dyBm1u3+T9dNG5XezU+Pv544xkY/OgUNfBnrgTdvz+eOxy/BAQBZjdteghJJq6KmlJTt
         yERTrgXkDQ9CtPo1qvmdJuSMWOIrzFbjjXYaXG0ZRDo3j+bTySPRtz/gDCvcX1cr28Qs
         46Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709738070; x=1710342870;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WI8wnl72Fr4kYF1pJwPsFlO/0vFnIYu1hp3He8klX70=;
        b=FEqVqpA3RZbhb798uVlnpHwdsjqI4T/5DFIgGH8bC7QmGuKi7RpRsT/99sC7xwHk0b
         /3yh5/Ejmmo6cUcQKJ1wrWLupiE+R0o1zPPijFhWDOLbdpUm2rx+OeIDjPf2PuHJdo3l
         OHAnP5vY+YBKW4nloyyqF89XkoN9iR9r0AkEZVS9GG42gx9SqimqH1Rs/ZRRl8vb50Ak
         QMd8vyR6vC0RCWxU4fMldRFEI5zczEDTNWWZTqSdh3Q32fK3loVcyumwaA1beXBVLaL6
         UuAKq0npYRgmb4Pxz4jKkNq/HPJP3uGO/lvRnBCQDaglt7ekkVeypGUi+S+dcCJ10/PO
         PKpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVD5MrXMwG4i96ppyzABTk7u1WqmwXKomIW8AYfSgPD4gOO7SJvv9jQ3KPdCvCsZ9L1wkSC09MoMWhurUKJ/nw5lwzDWAb1TuTcOStZA==
X-Gm-Message-State: AOJu0Yxt2EAsbHUmOHc+Dj+j9wz19l7OPZ+ApZ2Wtv/LHAataU+WY99V
	9IANkA6Baap13MxOF5pfpZMR6YaTiUJLiYMehTH20iSfqoh4sxyWZFqadcmSeoA=
X-Google-Smtp-Source: AGHT+IGUiMQGgwvlQMGKRXe7wCmRXYY4W7sYiKxMn4Ny9azh3Xt+7w7LX57Y2OOgwcaF/GvjESF0Sg==
X-Received: by 2002:a6b:6611:0:b0:7c8:7471:2f59 with SMTP id a17-20020a6b6611000000b007c874712f59mr2532950ioc.0.1709738069617;
        Wed, 06 Mar 2024 07:14:29 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y16-20020a027310000000b004767d9bc182sm380434jab.139.2024.03.06.07.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 07:14:28 -0800 (PST)
Message-ID: <74fd60ca-6284-4817-8ec1-7f1a6c203473@kernel.dk>
Date: Wed, 6 Mar 2024 08:14:27 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix page refcounts for unaligned buffers in
 __bio_release_pages()
To: Tony Battersby <tonyb@cybernetics.com>, Greg Edwards <gedwards@ddn.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Hugh Dickins <hughd@google.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, linux-mm <linux-mm@kvack.org>,
 linux-block@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <86e592a9-98d4-4cff-a646-0c0084328356@cybernetics.com>
 <20240229225630.GA460680@bobdog.home.arpa>
 <dd86cf53-d884-4a5c-b5b5-eefe1d7641d7@cybernetics.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <dd86cf53-d884-4a5c-b5b5-eefe1d7641d7@cybernetics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/24 8:03 AM, Tony Battersby wrote:
> On 2/29/24 17:56, Greg Edwards wrote:
>> On Thu, Feb 29, 2024 at 01:08:09PM -0500, Tony Battersby wrote:
>>> Fix an incorrect number of pages being released for buffers that do not
>>> start at the beginning of a page.
>>>
>>> Fixes: 1b151e2435fc ("block: Remove special-casing of compound pages")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
>>> ---
>> This resolves the QEMU hugetlb issue I noted earlier today here [1].
>> I tested it on 6.1.79, 6.8-rc6 and linux-next-20240229.  Thank you!
>>
>> Feel free to add a:
>>
>> Tested-by: Greg Edwards <gedwards@ddn.com>
>>
>> [1] https://lore.kernel.org/linux-block/20240229182513.GA17355@bobdog.home.arpa/
> 
> Jens, can I get this added to 6.8 (or 6.9 if it is too late)?

Let's just go for 6.9 at this pount, we're almost there. I'll queue it
up.

-- 
Jens Axboe


