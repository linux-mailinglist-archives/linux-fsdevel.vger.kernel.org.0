Return-Path: <linux-fsdevel+bounces-63304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF09BB46BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 17:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D7557A2A2B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 15:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CA623D7DB;
	Thu,  2 Oct 2025 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rCUGi3+6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA779236A70
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420713; cv=none; b=fl8jt4NWwEsiKBG/5YDB16Gc5hj+q1EzCDf55C8vnlt65t7MOxXGXgqIs2F+dOFGe3gi8420ZNKErAWVwDOd5O4Ry5VRJ64+WDAq8apen4ALtAnCtWmlLPNuJOt9eCoAln5AmkZaTa1zm1xh1TTkgnZ21x5exz0jPoAx4QCuG/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420713; c=relaxed/simple;
	bh=0AOCr6BPvIm1M5pnw2VjYpyLZxGSVwWCediy8evOiuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C6CrbWoqjTmpYx+H99OXZcXNZdw4sLdnlZd0h1vP/QjyG93ZvdvHQw4MByr4uA0eOEaK1KuOnrvLTQgHnhUuGCyI3sj4KYTggQtpQKKW/gUPQXFc5WrT7AQh+duanOo1dZ4YhLhhBPEvUDGQoerB3YyVoI6DtRtTD+pYh/U5TMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rCUGi3+6; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-4256f0fac67so13256585ab.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 08:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759420709; x=1760025509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YNilpGtwunxhkKhtHuanByyeVgHiZ0tzBGIYdEYkGmA=;
        b=rCUGi3+6k/j40dTyvQH3OV2lP/wGRecIhNLRpRqpAjP3rTSbC6ZlZTqX/23Rv8OTxE
         lAXg3oAFeBwvEsOIiQAZ5bGrwIl5b9PKt1+HAnLnIkZOyUO0NAtf0qd7QcgRDnIAG9Q4
         4oYrC8qa5cqYfpGHXj9Xh0ABqZJ2K7sb6EWTmhBuzy9oUVH1FGlodlRuFTQ/Z9yjItBN
         azg05OJJK2OIj4gVRznFwJkjz0DxaOaRC/p7gjo3XOQpVWuSetBZxB8kIRN6LDviq03d
         TwjauBeTs3hITnB614ZKj1h3Kp/cftbcqKKRqWVRYMletv7t/QZz+mYSDU8+8F7fxr3v
         C0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759420709; x=1760025509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YNilpGtwunxhkKhtHuanByyeVgHiZ0tzBGIYdEYkGmA=;
        b=YTaCqDpN4hiKzlbDHrcoIz1Jj0Y6Bj5/gdScBmXzWCXwSzBPz2ldY7WJptc0uvO5bx
         3roc8GMti8HsFIoU5Bq18PwCM01mzQa0SMsxs4fR8QcR/QtN4oR8VNhVubViunPZss2D
         sIhdo6UAV54ECIosGaFtrPTeVhBZjf82pOjRrH2dKjnvyADyf5VF/Dw1ezAkw47gFcBR
         J4P1eCMV7lsHsvYfip/FCD99q4FlBz05Ls2jC+Pt/AwC4oo0bRWhGUUDiKkxktx+Cae6
         6Z1K3/deUQGdSurkwbYOlpqpj19kQQldzHka6y0NZfuFXBBFd6j4iaaiLfNr+VIqAuV+
         BMYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlGhE7ZjiTMvsm+2G1MNkvIBCM2JlFB68C7SKzJNl9+f9h2bcZZPZM3wwCcz5iH2ywhopeGr72NhVwPRyG@vger.kernel.org
X-Gm-Message-State: AOJu0Yy82sM5Ic0qydwJwajMjAzeCvOLSFdaI4WR8pKocEYAmS+qQwnz
	NhDT/G2+eTadbZzcTGK9wP52atWykfBWeCHFcwOn/sXO185foiZXB9/22wSerV04UE4=
X-Gm-Gg: ASbGncthEzg0L5Xi3uooPY1z5EOy0pJTn0GotPvPjPEyArNtyvCibD0qC+ZM4/zv8T9
	xtctnML6rC1KtCXpXeZGEA+EjFJxMEolPvle47OawlKBcKbUvvvfQ0OpU3ALszzUWGqVgkZfnIC
	mCiMWRTC1cxZsoZ6Etv/PkF7VbeFgu6zjZOoHo3YTK/46RayI5g2nZNelgfisGmixfktIRXlodY
	tNFv1p5xHY0rMNkq3TDBuMKj2L1bMS6gYpQsmtQTGocRpDCDWmj1rosfcGgBhSgfOCwa8yF3/aT
	tAlkwM4d67zrgmmRjt+JX3+Y+6vui60B29LC1FWl53XnI2k8pFEPeJRxSYoVQW/WGxW9ule3CHx
	p08e21ZiezeGu0aKInFfteHxGXt2kJ/xZ8ydY7U678pBk
X-Google-Smtp-Source: AGHT+IGEiHZSumtbEx41vubwodqOoT5aOYw9eNQC8MCndLsgVDLYkboIsl41CSo6vL17oHiISA8Lew==
X-Received: by 2002:a05:6e02:16ca:b0:42e:741f:b626 with SMTP id e9e14a558f8ab-42e7ad021eemr1269845ab.13.1759420708846;
        Thu, 02 Oct 2025 08:58:28 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42d8b1f4f0asm10924825ab.2.2025.10.02.08.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 08:58:28 -0700 (PDT)
Message-ID: <1b952f48-2808-4da8-ada2-84a62ae1b124@kernel.dk>
Date: Thu, 2 Oct 2025 09:58:27 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.16.9 / 6.17.0 PANIC REGRESSION] block: fix lockdep warning
 caused by lock dependency in elv_iosched_store
To: Nilay Shroff <nilay@linux.ibm.com>, Kyle Sanderson <kyle.leet@gmail.com>,
 linux-block@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: hch@lst.de, ming.lei@redhat.com, hare@suse.de, sth@linux.ibm.com,
 gjoyce@ibm.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250730074614.2537382-1-nilay@linux.ibm.com>
 <20250730074614.2537382-3-nilay@linux.ibm.com>
 <25a87311-70fd-4248-86e4-dd5fecf6cc99@gmail.com>
 <bfba2ef9-ecb7-4917-a7db-01b252d7be04@gmail.com>
 <05b105b8-1382-4ef3-aaaa-51b7b1927036@linux.ibm.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <05b105b8-1382-4ef3-aaaa-51b7b1927036@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/25 9:30 AM, Nilay Shroff wrote:
>> Slept for a couple hours. This appears to be well known in block (the fix is in the 6.18 pull) that it is causing panics on stable, and didn't make it back to 6.17 past the initial merge window (as well as 6.16).
>>
>> Presumably adjusting the request depth isn't common (if this is indeed the problem)?
>>
>> I also have ACTION=="add|change", KERNEL=="sd*[!0-9]|sr*|nvme*", ATTR{queue/nr_requests}="1024" as a udev rule.
>>
> So the above udev rule suggests that you're updating
> nr_requests which do update the queue depth. 
> 
>> Jens, is this the only patch from August that is needed to fix this panic?
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-6.18/block&id=ba28afbd9eff2a6370f23ef4e6a036ab0cfda409
>>
> Greg, I think we should have the above commit ba28afbd9eff ("blk-mq: fix 
> blk_mq_tags double free while nr_requests grown") backported to the 6.16.x
> stable kernel, if it hasn't yet queued up. 

Sorry missed thit - yes that should be enough, and agree we should get
it into stable. Still waiting on Linus to actually pull my trees though,
so we'll have to wait for that to happen first.

-- 
Jens Axboe

