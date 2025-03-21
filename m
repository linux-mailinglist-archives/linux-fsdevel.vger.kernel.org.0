Return-Path: <linux-fsdevel+bounces-44743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B81A6C493
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 21:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8C41484862
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 20:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497CF231A2D;
	Fri, 21 Mar 2025 20:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYk8PV1U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26FA1E9B32;
	Fri, 21 Mar 2025 20:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742590253; cv=none; b=QrFL3P7tiQy8CQ187FvGR49YHt4iI4UvRd29F0104pBLS8wgSfHYR1iGcEH59bgit+hNzkQYX1J1Kfzxf1q03YQ3ZMLyxogVUyNRPJHNc6LMUoJKh6/hTY18C9ZCElVPwSkPI7AtnDEzu3HzIJShUWsiCp88ZAx69iwnO/TVhMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742590253; c=relaxed/simple;
	bh=fvyqCqDcCaEX4mI7phytQuw5UOBiV1RnJVgwLEE5YY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cne4Pgm5KORLInBRRmiyPHgWS7ltjRTk40yCIxNkLzQUveLZppksRh7MMpCC8uZkDnTiFR4i2qub6sYpP1rOyeiWLgdfqU0h2kcQiRQJPyFnWmqbS8gQLx362fKqGmFLHq8JciKyg1rl6NQdIcWTKjDkmAlXmXdW3tRVkpZIidI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYk8PV1U; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2c663a3daso481684766b.2;
        Fri, 21 Mar 2025 13:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742590250; x=1743195050; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JEdzPwVO0oWNN0wAc8zMe+O8cay5/vcOYcIsMyGQbi4=;
        b=GYk8PV1UK2TdMhedUDB6F0q0vxX4SLyPLCfdY4Z2wL3aqqBmyX48qNfmMbdf/XN0jf
         IJGJUm5TjWugDm/2E9EHMySYSR1Ry4yDUM4hjG99FUrUi/it5XwNmGqr5TZroEzbiQPC
         P7wlkU33o78BnPrhSXJX1CQxpX/3Znf47T7SfOsUc7C19+oM8vDlDaI7LIIPNjZtS1s9
         SKagdYwsUXxFhkEOnotvGT6bvEHBjpWJnJC2wKs5ZxfkJrb5zmXHCx70+B5gigqjDPVp
         Z95BHgqkVm/puSDaGo/0psT76NROHWsjoTNBfOkj71wclwvM3z0D55SgW+yXN8ZiCobw
         WlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742590250; x=1743195050;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JEdzPwVO0oWNN0wAc8zMe+O8cay5/vcOYcIsMyGQbi4=;
        b=KDsx7xFkF+jwrO+LKlMovabfzZED/JO/D7bRI/do+kqFonbmf5ggvzAmgdzSzpTdmP
         yYNc/Qs1XJm9rfkA+pd0QMzI9tCGRkaWb7vSC5nmBhGV5GOyLVmw8HtNXrjZ2CupK9xj
         1b+yJhhRTnd/3nvNbMkWw8UPSI27SiuHuw36SAL3TPn2ZLuBCqrr5bzdelGDjaBA0nqy
         kv0GHC1HIPhGISqO2ZLJTmk+jliFtGPtR3FwrYt23uPS8e7S9afNhzmkNnnYZ3/WNUEB
         sG7Tq/WZM3IPpStVDzLRJZWg9+MtVLQ0jwgCNJ62m7mjj1WV6Lz/0YbmAeQ/zJO4cjJp
         qCWA==
X-Forwarded-Encrypted: i=1; AJvYcCUO2vFSc9qJB3YB3KWwNWy0xwL+ABoEHQFZohEY6M00kIjbUU65wz1KMVIQ5nIGRMrh2Cy0aComS/eHLqOR@vger.kernel.org, AJvYcCUkkfrg5NQ260XxSytz8LJUP7H7vCE91Bh1wHPw0YKLta/EuFPZH3wQKLl0wv/nFhwiylXPJmTc@vger.kernel.org, AJvYcCVG4WmbyQKcrHo+8Rz42xv/+JjoZF5N9hAvXfEwpb/RrwtezWWPDXETAhoCKq9GLbvJbsGseXLPY714CQ==@vger.kernel.org, AJvYcCVP8P8V2drOUAOnnnyXCzGAfQ9jTU3MA6p151JqWwRoMsys+3fmwsICVDGrLtTCT4aDRkJAHWapZ+6DhmLj6Q==@vger.kernel.org, AJvYcCW55ufPwODavjErm0kf4aWFWeb/4NLlOwbdmiYVam4zGlf2gHMobKqD4TqaZSlR2Ow9fTSw05W1lg9UhciUKrXw@vger.kernel.org, AJvYcCWIFc9/3RHrpDKgNN6dNYeh/ar4WHBj7/nJLOn0j+UyjlGvSP1R+vol9pzH2jgm8Q8Y+/lTxqreJ5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKctUmZ7TJnD/805WILrckjv5l3Tspsj94Bw8xVN4iHelThGxZ
	4UwakOQgQSYZK6CBBvbqVITJlsmr3as+ERSCMyO/xfCQjNhEWOPs
X-Gm-Gg: ASbGncuokCnw8Dd7FkPt3FUimGmMRImVi3ED3mgyZuCgjZX577UOybCrPpcGRLHrnwW
	MQopRMaebFpizgZ0pf04Cq6JEG2dL4Tk/oFvJbKo2qFjABoLPxJv4n2kvpw7O9VJDOExcwjm17w
	WnaSxoahNJDeWKwsGUCfPBAtiVHETVFJ49V9YqqPaDwsIv8oofTKkQ8CWigqlEGqapuOt0OVSUj
	REnZATjLiYB9pU1kv+xvk8VRRtDloIKbVxdjwnqPnlscqMr3SXlrdPNqHdu8fasMqLpICnacSTo
	hvPo8p/oFk/c4XpkqzXzb77yls4npRS8uj6D4jzNtn7nEu8HllFYQg==
X-Google-Smtp-Source: AGHT+IFnVEhxSIgWde7XpMHbJeBcjFQtRapjJMQGPcFXYnPNvOU7oIf092XK7zlewafDkwDIpcyxag==
X-Received: by 2002:a17:907:7ea7:b0:ac4:4c9:c044 with SMTP id a640c23a62f3a-ac404c9c637mr147567866b.15.1742590249590;
        Fri, 21 Mar 2025 13:50:49 -0700 (PDT)
Received: from [192.168.8.100] ([85.255.236.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efbd3d3esm211035166b.130.2025.03.21.13.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 13:50:48 -0700 (PDT)
Message-ID: <f7c5a71e-b935-4e87-aa9a-e404b9a0bca0@gmail.com>
Date: Fri, 21 Mar 2025 20:51:41 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
To: Stefan Metzmacher <metze@samba.org>, Jens Axboe <axboe@kernel.dk>,
 Joe Damato <jdamato@fastly.com>, Christoph Hellwig <hch@infradead.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
 viro@zeniv.linux.org.uk, jack@suse.cz, kuba@kernel.org, shuah@kernel.org,
 sdf@fomichev.me, mingo@redhat.com, arnd@arndb.de, brauner@kernel.org,
 akpm@linux-foundation.org, tglx@linutronix.de, jolsa@kernel.org,
 linux-kselftest@vger.kernel.org
Cc: David Wei <dw@davidwei.uk>
References: <20250319001521.53249-1-jdamato@fastly.com>
 <Z9p6oFlHxkYvUA8N@infradead.org> <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
 <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
 <Z9r5JE3AJdnsXy_u@LQ3V64L9R2>
 <19e3056c-2f7b-4f41-9c40-98955c4a9ed3@kernel.dk>
 <Z9sCsooW7OSTgyAk@LQ3V64L9R2>
 <dc3ebb86-f4b2-443a-9b0d-f5470fd773f1@kernel.dk>
 <356ce660-fc2e-4016-a0d9-6896936669c2@samba.org>
 <fbcd759e-2453-4570-a2a0-c9ad67ae9277@gmail.com>
 <0fc1032f-908c-4e59-8f64-f22b380ae639@samba.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <0fc1032f-908c-4e59-8f64-f22b380ae639@samba.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/21/25 07:55, Stefan Metzmacher wrote:
> Am 20.03.25 um 11:46 schrieb Pavel Begunkov:
>> On 3/19/25 19:15, Stefan Metzmacher wrote:
>>> Am 19.03.25 um 19:37 schrieb Jens Axboe:
>>>> On 3/19/25 11:45 AM, Joe Damato wrote:
>>>>> On Wed, Mar 19, 2025 at 11:20:50AM -0600, Jens Axboe wrote:
>> ...
>>>> My argument would be the same as for other features - if you can do it
>>>> simpler this other way, why not consider that? The end result would be
>>>> the same, you can do fast sendfile() with sane buffer reuse. But the
>>>> kernel side would be simpler, which is always a kernel main goal for
>>>> those of us that have to maintain it.
>>>>
>>>> Just adding sendfile2() works in the sense that it's an easier drop in
>>>> replacement for an app, though the error queue side does mean it needs
>>>> to change anyway - it's not just replacing one syscall with another. And
>>>> if we want to be lazy, sure that's fine. I just don't think it's the
>>>> best way to do it when we literally have a mechanism that's designed for
>>>> this and works with reuse already with normal send zc (and receive side
>>>> too, in the next kernel).
>>>
>>> A few month (or even years) back, Pavel came up with an idea
>>> to implement some kind of splice into a fixed buffer, if that
>>> would be implemented I guess it would help me in Samba too.
>>> My first usage was on the receive side (from the network).
>>
>> I did it as a testing ground for infra needed for ublk zerocopy,
>> but if that's of interest I can resurrect the patches and see
>> where it goes, especially since the aforementioned infra just got
>> queued.
> 
> Would be great!
> 
> Have you posted the work in progress somewhere?

Nope apart from a dirty hack I believe I posted back then.

-- 
Pavel Begunkov


