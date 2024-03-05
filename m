Return-Path: <linux-fsdevel+bounces-13659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C65D8728E2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 21:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9F51C2982C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 20:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F0012AAC2;
	Tue,  5 Mar 2024 20:43:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7647E13FFC;
	Tue,  5 Mar 2024 20:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709671409; cv=none; b=FK52Hha9N23YBefjDx3HotWUJnPo8tF1Txy9xGz4KkWyuK3z/laLBg0XlIGsMEgNkPsgQZccMYsAOmEOcrO7gfPIyXMNV5IIQl3CNt5AFA0zxr9qpyTQT0pEXQmBAy3Q8oCWTDrwt0ZrTzd5d3aLxqjIag+PAB2NKmCOGgfZGsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709671409; c=relaxed/simple;
	bh=5LhkyOL5DBfFrm/Q4kn3P/JyK8ZmVreOttEn5YGWp6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGhNL1kxO8MSOFiwbCLKSyOrLeFbPD4v3wZh9oG8jVsWyxrVYIoxbi4XKVDwDEf4nfT1aqg/QVPuJsGONahP7ace0nmJ/JpDCPj7sPCV/rpMvBBdmiaJp4YRmyfm59rkFb4qmMx7HLpSPwl+obb/vyUsyHpMadOG6nNqyEM4oo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e4d48a5823so4885606b3a.1;
        Tue, 05 Mar 2024 12:43:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709671408; x=1710276208;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s4cUwSCUfrhnX7rFZCq2HWzc9MGRRD5c8S8wSmLmcuY=;
        b=wkBAglwTO6eYB/kt331ahf5OlJkxxicDfFOHRk9g+Nc7ECi/5HdBuU5bkMAZ0LCFlf
         8EVgzRvqCdf77YD7xwlK+CW17vPeKEGVet5gkB8PM8REGRiwnwP3wRaP4Ws0hLuiX4N8
         F4rtjEODoD8ct+HDFrSV+ChpHyNcuUHXmcURucTRrfy+Pl7zvJz+C0bkZD5ELYa8FVR6
         3ktnBUDWpSqoAMKVrK9Urue8rSe4tx9LqVWYXYLmcXAPsf0URQZD8usYRkXi/r4KRb99
         c5za4PtOpej83pFO1/aS0j+qyBUIyRb4iSso+3Vk0csW7NyV2B8+85KUJG8W/iFYsLl3
         eoSw==
X-Forwarded-Encrypted: i=1; AJvYcCWKZhlXoDGu1yYigtS7c1SBxTMZbS9Zelv3IWVqyy52CAEH9QQkiDqeDmkILB6IY4Fa6zzBVBtoOr8Hzc1ytdb7DR2/FFf71AaXODm8cHY8Xj4CE5Q/eX1ZprO0D1+x08KKRb6e9Q==
X-Gm-Message-State: AOJu0YzZHofxAOsmrEQYxwkbLflpwzj/hNqaTL1rhEMCCxmD5GUxybeD
	A2ss2/16Rzu+vUGzKyc+aG92WjdJRGfRsIdK3u+niYaexFbWAWL8
X-Google-Smtp-Source: AGHT+IEBYm9zdJraXaE2N6WQpGT8/+FhFknywcpDBj8R9qAJ6nWOP3rRf9cbjLQovMjvEfndTm6t4g==
X-Received: by 2002:a05:6a21:6da4:b0:1a1:4d8b:6f2c with SMTP id wl36-20020a056a216da400b001a14d8b6f2cmr3007251pzb.2.1709671407713;
        Tue, 05 Mar 2024 12:43:27 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:3e11:2c1a:c1ee:7fe1? ([2620:0:1000:8411:3e11:2c1a:c1ee:7fe1])
        by smtp.gmail.com with ESMTPSA id lo12-20020a056a003d0c00b006e627d0e97bsm3429769pfb.181.2024.03.05.12.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 12:43:27 -0800 (PST)
Message-ID: <94dd9db1-6025-4cd0-93b7-40d55a60efc4@acm.org>
Date: Tue, 5 Mar 2024 12:43:26 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] fs/aio: Restrict kiocb_set_cancel_fn() to I/O
 submitted via libaio
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>,
 Sandeep Dhavale <dhavale@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, stable@vger.kernel.org
References: <20240215204739.2677806-1-bvanassche@acm.org>
 <20240215204739.2677806-2-bvanassche@acm.org>
 <20240304191047.GB1195@sol.localdomain>
 <90c96981-cd7a-4a4c-aade-7a5cfc3fd617@acm.org>
 <b36536cd-c62b-4b86-aef7-fddd3eb282a1@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <b36536cd-c62b-4b86-aef7-fddd3eb282a1@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 12:21, Jens Axboe wrote:
> On 3/4/24 12:43 PM, Bart Van Assche wrote:
>> As far as I know no Linux user space interface for submitting I/O
>> supports cancellation of read or write requests other than the AIO
>> io_cancel() system call.
> 
> Not true, see previous reply (on both points in this email). The kernel
> in general does not support cancelation of regular file/storage IO that
> has submitted. That includes aio. There are many reasons for this.
> 
> For anything but that, you can most certainly cancel inflight IO with
> io_uring, be it to a socket, pipe, whatever.
> 
> The problem here isn't that only aio supports cancelations, it's that
> the code to do so is a bad hack.

What I meant is that the AIO code is the only code I know of that
supports cancelling I/O from user space after the I/O has been submitted
to the driver that will process the I/O request (e.g. a USB driver). Is
my understanding correct that io_uring cancellation involves setting the
IO_WQ_WORK_CANCEL flag and also that that flag is ignored by
io_wq_submit_work() after io_assign_file() has been called? The AIO code
supports cancelling I/O after call_read_iter() or call_write_iter() has
been called.

Thanks,

Bart.



