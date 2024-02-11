Return-Path: <linux-fsdevel+bounces-11058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 301798507A8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Feb 2024 04:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4C7EB229B5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Feb 2024 03:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B17CFBF6;
	Sun, 11 Feb 2024 03:21:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAF2179
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Feb 2024 03:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707621667; cv=none; b=ZO8hJTBht+z07Z51mVSOmOvzAh+ZBNUyhGysQS+SfxlgWSeZmVSornsrq9Z9Sg2gHJB8TLWDXZq31huYfxxpDBzpDnamvxViDAqC9hUfgUqC5RAagh7Fn6ITuUU3FBfzZjqDDfWEQh2a2e9mkLG5eXT1wcrAVWxhzKkAYQihr7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707621667; c=relaxed/simple;
	bh=aM4f0hEYKhLGGqvjlpkk1GiJR6uP5ZHJZJARC+dYHb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o6ITBQsxCo4R4FCbIi0e4bGpsTGPYJJFQr0spHZjxLj+z7XP5mUk8m+WCPfSTqQfaVfmsvbetBVjm9oSYK4ryeGJ/DYQEoQ0F3tlz2pr3NYHz4FBsJ8xzePRpRHh9ds+iyLPEUzJBPAujtzoE83w9Wy9n4IcZOxZ+uBHxAgvlgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c031776e0cso383356b6e.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Feb 2024 19:21:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707621665; x=1708226465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3J/FdYcLKdjKVfrV2PLl2c+icxFPWRSI71KMX8B9d0=;
        b=wb4dOgT+jyuxUaPYAHFSRg0+z2VWmtp1mh3GsVOXMIt+Smo/CUO3kqoUtqzsR3zDQo
         TqoKrcm7ItL0WuIv0i/bKVJInO1FitIc9JxO4XS64ceyLB7CnsvyjKvTdR9comd7BkmB
         0vzdBKIopNr3MMP6lwXtl8aNOZu/I/pAOmyAQ7lW4mn12LcpHDXHDb76TS50udzFJYuL
         Pfz2fOSiTusj9e3XJxBzgy+Njulg9IW6jVZhXWKD0kh2Jf12jp3X8zVbqC4dQi6LOgTu
         0mIkfKljajrJoVLQa1N+w8+Epnmlm7dgmiZBfyiXSypAV2GmBpEFtAF8G0wY0bDgoBL+
         SiVw==
X-Forwarded-Encrypted: i=1; AJvYcCX8nI4p++7gPV0mXo3uEb1cW0shtKscWcZdBfhjQpVi9GpTr2RXRFr9e4Jx/PPbEgeuUPAcrCzMg/TIBZ5awWATgm/+VvjJcsXmeNGxFA==
X-Gm-Message-State: AOJu0YzymQyA1Z8+CIWOcEJvok+uNnlvEcaHkxOSUHUAkJ4OWeMrQE4n
	JEeZZ/ya3W74FYSG8Pa3eyLmu2k2u843BQYWu7q41v1PYBVq5U1rx0sKkYQG
X-Google-Smtp-Source: AGHT+IGUWlCemFlV4CA5JyC3k2wkfSgB3bmovaaRx/6u4OTV18bs8PEuSoDJnDejD2YgHhLsD0rFOA==
X-Received: by 2002:a05:6808:bcc:b0:3c0:18e7:41c2 with SMTP id o12-20020a0568080bcc00b003c018e741c2mr5072312oik.6.1707621665311;
        Sat, 10 Feb 2024 19:21:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXNpQG7UJrY0mbEQX1Hq0Si+1IkKp+1o/3FHxuhAB5KQESkpu/9xvn8WtxetNduCgr154wMx9AappVQnUDqsG8lnFInodr59Lby30Qy35LLiP7eHRg87+2ni293NcdC0AVeKi8VYi883tJdendJsOjPrcg=
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id li12-20020a170903294c00b001d9ef7f4bfdsm3697902plb.164.2024.02.10.19.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Feb 2024 19:21:04 -0800 (PST)
Message-ID: <3b605f29-07fc-42fb-b9f1-e526e9794d63@acm.org>
Date: Sat, 10 Feb 2024 19:21:03 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/hfsplus: use better @opf description
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>
References: <20240210050606.9182-1-rdunlap@infradead.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240210050606.9182-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/9/24 21:06, Randy Dunlap wrote:
> diff -- a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
> --- a/fs/hfsplus/wrapper.c
> +++ b/fs/hfsplus/wrapper.c
> @@ -30,7 +30,7 @@ struct hfsplus_wd {
>    * @sector: block to read or write, for blocks of HFSPLUS_SECTOR_SIZE bytes
>    * @buf: buffer for I/O
>    * @data: output pointer for location of requested data
> - * @opf: request op flags
> + * @opf: I/O operation type and flags
>    *
>    * The unit of I/O is hfsplus_min_io_size(sb), which may be bigger than
>    * HFSPLUS_SECTOR_SIZE, and @buf must be sized accordingly. On reads

Thanks!

Reviewed-by: Bart Van Assche <bvanassche@acm.org>



