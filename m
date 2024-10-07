Return-Path: <linux-fsdevel+bounces-31261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85884993A37
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 00:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA2B3B21992
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 22:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224F318CC17;
	Mon,  7 Oct 2024 22:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fcf59brg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072AC18C333
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 22:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728340174; cv=none; b=Uta5183UOyH7DKKb8R2Q406yaVMKMzohaRXA9dxsApKNKMwa6cupSckCWj/sA6/y/y8SUSZFDw25bxx6Vss/KoOj8LPKAUIG7xYjRx9KbA6wICLrtj12OgOT5K2zUnzd54EEcOeh8qm8rNfUHTi8siNDRvWjWza3iHtWXKQtJ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728340174; c=relaxed/simple;
	bh=dFBGJ7Fkq5TiDATvU9vo7164l+g2CBClix4Hq87gImE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayRxwKLRIDLRcQUJWSb7XiuiD/9giSXcRyXfthmdEqMfP9bHSJff1hLHZvItlqY/xG9xy7Pbe7pQcLATlYDn3OX9if8ruWVP76oiWwH8Nxn6iqU2nIiWbWJEf3CH+lJ3UljmmyHl7W80GFZMBqvKDy/bODj9L/3ZPhigymimh5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fcf59brg; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b5fb2e89dso38368005ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 15:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728340171; x=1728944971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u7Yr4WO6vKFC515dnzWPLRRBdfJDGWgI8I6HVaT96bc=;
        b=fcf59brg4H5iQuVla2nfg/+lzvVh9+OkxVEBNmuaqRXaiOv7sIA4wMmOyx3qPJX8bR
         NPN/PV4jIgfSdAeIOcwig8OpQoFu0Iw8bLJignJMk6O2qBFFUYiJn8OC8AQ0AQDlT7/t
         ztJycwjlix6+o1X2BO/FtLjPAHqHAYC+SUwootFBmNDJ4qPrO1MJkz2HAzZ0DXDVvamk
         n29reW/0I2JDO1X5OluGtZ2a0cAdazcAYZZpvvuehE/a9X/42nrGa821/z5RKwR7uUcw
         Irdt+hMipYAIUXm1lJuSRXxjIUMgb2POaesEg19itoi0wNuAs77xiCAfWnJ6k2E5qxiD
         v+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728340171; x=1728944971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u7Yr4WO6vKFC515dnzWPLRRBdfJDGWgI8I6HVaT96bc=;
        b=MWp9YeEfvZfijeCxuf8zp/8g37olH1aK1/A1eYQrSgb2JwgN4vw32gz3E81wVvV1rF
         1C2pv8YWaBU53ADkREvJrEhV8zvyP2ehfyIuuH0kPcKB4opiaGpr/tPshugkr443nou7
         Mw5/wjrJtwTNYUuasObCnppHXQdeH4tKTNygRPKrqL7V3NXcOWHFzSMI29/uhGUTYzA6
         BepLssuf51TqO26F1eGm+nWtndk3sloKdTox9L0aikdy0c16yb+XeSEFl+WLzlgijL/r
         cz710g8ma/VPX8MlqFQNMxvXapi5pgj180WXtse3vT4VvJ/vxLVHuCmhkJKJpOL0YFhu
         NwKA==
X-Gm-Message-State: AOJu0YxUSERMdfJmyx8PS5s24VWWFKyAjyZW28Rcci/U8UuAOIlMJSNh
	nsu3Y063Bwoj6ErTYVcgGVmSzYQG33Vhz3xNDy7Uq8Oc6JA9UKUj9tLah9yS6XY=
X-Google-Smtp-Source: AGHT+IH5NEobdxwS04ehz34YXVr2JyGbv2t0wb0CI25E+GEqKPdOzfpWGeUld/PYfzZktVocnX+3fQ==
X-Received: by 2002:a17:902:f68a:b0:205:4721:19c with SMTP id d9443c01a7336-20bff1944a8mr137708025ad.37.1728340171233;
        Mon, 07 Oct 2024 15:29:31 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13990b52sm44234165ad.281.2024.10.07.15.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 15:29:30 -0700 (PDT)
Message-ID: <2da6c045-3e55-4137-b646-f2da69032fff@kernel.dk>
Date: Mon, 7 Oct 2024 16:29:29 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] replace do_setxattr() with saner helpers.
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
 io-uring@vger.kernel.org, cgzones@googlemail.com
References: <20241002012230.4174585-1-viro@zeniv.linux.org.uk>
 <20241002012230.4174585-5-viro@zeniv.linux.org.uk>
 <12334e67-80a6-4509-9826-90d16483835e@kernel.dk>
 <20241002020857.GC4017910@ZenIV>
 <a2730d25-3998-4d76-8c12-dde7ce1be719@kernel.dk>
 <20241002211939.GE4017910@ZenIV>
 <d69b33f9-31a0-4c70-baf2-a72dc28139e0@kernel.dk>
 <20241006052859.GD4017910@ZenIV>
 <69e696d7-637a-4cb2-912c-6066d23afd72@kernel.dk>
 <965e59b5-615a-4d20-bb04-a462c33ad84b@kernel.dk>
 <20241007212034.GS4017910@ZenIV>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241007212034.GS4017910@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/24 3:20 PM, Al Viro wrote:
> On Mon, Oct 07, 2024 at 12:20:20PM -0600, Jens Axboe wrote:
>> On 10/7/24 12:09 PM, Jens Axboe wrote:
>>>>>> Questions on the io_uring side:
>>>>>> 	* you usually reject REQ_F_FIXED_FILE for ...at() at ->prep() time.
>>>>>> Fine, but... what's the point of doing that in IORING_OP_FGETXATTR case?
>>>>>> Or IORING_OP_GETXATTR, for that matter, since you pass AT_FDCWD anyway...
>>>>>> Am I missing something subtle here?
>>>>>
>>>>> Right, it could be allowed for fgetxattr on the io_uring side. Anything
>>>>> that passes in a struct file would be fair game to enable it on.
>>>>> Anything that passes in a path (eg a non-fd value), it obviously
>>>>> wouldn't make sense anyway.
>>>>
>>>> OK, done and force-pushed into #work.xattr.
>>>
>>> I just checked, and while I think this is fine to do for the 'fd' taking
>>> {s,g}etxattr, I don't think the path taking ones should allow
>>> IOSQE_FIXED_FILE being set. It's nonsensical, as they don't take a file
>>> descriptor. So I'd prefer if we kept it to just the f* variants. I can
>>> just make this tweak in my io_uring 6.12 branch and get it upstream this
>>> week, that'll take it out of your hands.
>>>
>>> What do you think?
>>
>> Like the below. You can update yours if you want, or I can shove this
>> into 6.12, whatever is the easiest for you.
> 
> Can I put your s-o-b on that, with e.g.
> 
> io_uring: IORING_OP_F[GS]ETXATTR is fine with REQ_F_FIXED_FILE
> 
> Rejection of IOSQE_FIXED_FILE combined with IORING_OP_[GS]ETXATTR
> is fine - these do not take a file descriptor, so such combination
> makes no sense.  The checks are misplaced, though - as it is, they
> triggers on IORING_OP_F[GS]ETXATTR as well, and those do take 
> a file reference, no matter the origin. 

Yep that's perfect, officially:

Signed-off-by: Jens Axboe <axboe@kernel.dk>

Thanks Al!

-- 
Jens Axboe

