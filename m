Return-Path: <linux-fsdevel+bounces-40622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12E1A25EA9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 16:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1228E3A23AC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 15:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D807205E1C;
	Mon,  3 Feb 2025 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJTlejNh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14C6201270
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738596227; cv=none; b=goacIpWwLOJ7y5PObwwtBrR7YYghfiU3p+GX4qMhunhNW1Ui/k8I+Rmv5WXHhRv3aXk/ymWo0tcY54kMYt+qfpxTFqlzc/SvDYwW53pRzwj7dLdarHn9vq6XZrNHu0uAXBJqcKvAv1TVmoCommyEe+15kGcZiBgBYgT0WTsYoXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738596227; c=relaxed/simple;
	bh=5v9+ClyC3GPkP/8ybDSEdTxX6vJZvWdUAtDY5DUeo3E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Qzozw8L3dNeOrWZJCzx6oSFNAz5BVis4ZwJDIPMlliKHSpIXcGFvHLmzmgY25rf83EG7fOnfSbHUuIYXUyuxQROr4SihqMEGoSaQl/IV2C9CT7AG/q9IfHeigydCPXI3R/DzrNZOriyk8Wlqeysxz26CV6umnnFyAt1P9i2gDvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJTlejNh; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3cf094768so8378484a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2025 07:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738596224; x=1739201024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UFG8TExcpVbvaTjy9CO9XEfVDyRvQvnWDqpblTf2WNo=;
        b=jJTlejNh38qoSgQLIsloVu3nIZ1+I4/Pd5dXYCh4Udnn23z32VtGLCvhE4SGWUxQ8f
         zAMfTZ8/DkbbLUmqGHudEGPyTXg200e/wC9QSigjCmJjt79Hd2zuqUGGw/hHlqKVIBaW
         wOaUO0S9ux8AvOjz0yeQzMwzaxgrKqoRq/TP8lu5gmFS2yQFgywOPgUfLYukxIOyx+Cv
         RWOxJVoXKgVTJx8184GcJhYsmjuL9ClH2+q+FY5sP4Rjd+H7HqiytIdQo/1lDV/KjaRH
         YxNHSIMUkfQxvIfmm7WnT53cL6lBjc6HfUf+sU4fFeq/EvGdKvd5jWHWfDrqviungM0H
         1cCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738596224; x=1739201024;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UFG8TExcpVbvaTjy9CO9XEfVDyRvQvnWDqpblTf2WNo=;
        b=lG/uXX694YAmztQJ4axKBUjJ4gtJCX+rKqsYimV6z0ZBi/9uygBGniSRX91QY9NiD/
         hu3G5FRGPgdscfZgF2xNCyIZ513c7lQGOLH79f70urJDEiU7ohT0K2weTX5GJ5CvJuG/
         kAXv+cWGT8lrnz+ijir4+jURRRg17n3BfLqotZX2D2l5//xzq4ImqRV3z0+JNmy9JeOz
         lnwLQavkOd46hBbRBEkdq6bSESR8xtswUyao51h9T4/rpB7W11TV2788XTsBe2rjWXQY
         2Nz1pX0iY9JT6w+G0XnHFqR5r8zlpPJfITO5Iz9jMlbbhUx8MOZ0CQ5PPKg0OgrAOa03
         ONQg==
X-Forwarded-Encrypted: i=1; AJvYcCUWeZfmQcx9AQYjDcV0CCeSYmGyGGndA5bj/s6UwS0Ymm6Rfo3qbblqZUdkcz8tNjPA9OHTrz8q9UqKui3c@vger.kernel.org
X-Gm-Message-State: AOJu0YydvEuXXsDq6iChFDedebEi+k8jLQ4IO6Pp1RriKg9Nry7ntp53
	30t5KnseMNJT54jR7O89o/49heQbaw4iD44JshQoErTLFD36m31VD7yGySmh1Ik=
X-Gm-Gg: ASbGncsfWXw/t4Zl7gFku7jLksHPdMfN0QpbAP/izkXCbA3uc04rymRkf9Oz2TD1ZlE
	3OYbyaR4IbsmeiIKRbpfjJQMr3Rb2YNagWINRWR/hIbKgzngnhdO6ZVtEvZ2H9nnLihaq79yOOV
	eYEW3bOFv3ElK0DyIXOs9A0G9s19B0ASM55gRNRghyCp0MiXa/KfFBCLUo67d5LS9GUVh2XcpFz
	5yQkashQUpqW8Vhrx5AcsCTZmfanARyKWqWvxerLnNQivl/zZ6un3rJjqUuYSv2ga3BxN/osRue
	JNR3y/pHIddb+2I2i2o=
X-Google-Smtp-Source: AGHT+IFiXdFr8dXjSrNeuaeUpC6oqIN2FGm3JDnLEeGYmit0sxj285Ud7mctF12dFFzclyWSD9gCLw==
X-Received: by 2002:a17:907:7255:b0:ab7:e71:adb5 with SMTP id a640c23a62f3a-ab70e71b1bcmr1011960766b.35.1738596223093;
        Mon, 03 Feb 2025 07:23:43 -0800 (PST)
Received: from [10.22.100.77] ([62.212.134.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e49ff719sm770696066b.114.2025.02.03.07.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 07:23:42 -0800 (PST)
Message-ID: <bf6e5729-8e68-4135-8946-66bf3acafc69@gmail.com>
Date: Mon, 3 Feb 2025 16:23:42 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Design challenges for a new file system that
 needs to support multiple billions of file
From: Ric Wheeler <ricwheeler@gmail.com>
To: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org
Cc: Zach Brown <zab@zabbo.net>
References: <048dc2db-3d1f-4ada-ac4b-b54bf7080275@gmail.com>
Content-Language: en-US
In-Reply-To: <048dc2db-3d1f-4ada-ac4b-b54bf7080275@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/2/25 10:39 PM, RIc Wheeler wrote:
>
> I have always been super interested in how much we can push the 
> scalability limits of file systems and for the workloads we need to 
> support, we need to scale up to supporting absolutely ridiculously 
> large numbers of files (a few billion files doesn't meet the need of 
> the largest customers we support).
>
> Zach Brown is leading a new project on ngnfs (FOSDEM talk this year 
> gave a good background on this - 
> https://www.fosdem.org/2025/schedule/speaker/zach_brown/).  We are 
> looking at taking advantage of modern low latency NVME devices and 
> today's networks to implement a distributed file system that provides  
> better concurrency that high object counts need and still have the 
> bandwidth needed to support the backend archival systems we feed.
>
> ngnfs as a topic would go into the coherence design (and code) that 
> underpins the increased concurrency it aims to deliver.
>
> Clear that the project is in early days compared to most of the 
> proposed content, but it can be useful to spend some of the time on 
> new ideas.
>
Just adding that all of this work is GPL'ed and we aspire to getting it 
upstream.

This is planned to be a core part of future shipping products, so we 
intend to fully maintain it going forward.



