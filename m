Return-Path: <linux-fsdevel+bounces-30120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6AF986608
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 19:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1919D1C237AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 17:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AF9129E93;
	Wed, 25 Sep 2024 17:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WycpcMoG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2B74A00
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727287121; cv=none; b=iU+HeLqeIBpR6wGQdzy4p744P8Z9MOj+N87wHVXO+ne3FAAU32QvPWKa96KdZJchmKCOMQoRlfedoWvLdWGKrs2Is5CdLQg5sLz5gY4AZjbxHPr2R6Vz/z5R3qCKwnc0raoB5rmm/nQKIHFyANmzhswntgIoDZ35Juztu3gxjIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727287121; c=relaxed/simple;
	bh=3H31ZtNWj1+V6dcrHg4zd2k6+F9OPn1WBJ+Fem504Cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qqHRF/GcjoJDRGSuJeftO+OD3NZnl5JHJdc2zbUG1IqALaa0zu3u3cuwPOfyUP7mkZ1xjJtHD47dq4C/20RkWfzUG+3wZy4LZ1Ko9J22QTD6YZuDq4Dpy1x3SIDTONlgeyotfbwMkPxmKp69lHn1wZbiEvqlJfo62DAL3Yvfmbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WycpcMoG; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-374cacf18b1so39378f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 10:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727287116; x=1727891916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qLBQStQH4mOT4tHop8xO2S+SOlNf+B3pIjXfX91wsjM=;
        b=WycpcMoGD4jnTKU4uLNH+bNuQAcVqwMLMVeclJIYFRPHer6SIkuPgthf9K0fXmsXBU
         v2OiFsdxlFLQEjJL7kWDaIFkJ5sQMcEMXkbP/FO2r17t9wEHr8MmHx9cCfEG4UiGHZdb
         icLgx/zsTTTfJNNFdJ9Q3SSon+6Gyak7/OtSW/7I3J7zf3+P8YS8v47UxEQDbeftRfSY
         w87lCjYMY2oZCEx+KmirMCwUlVGwsZePkQYIzMVz1MKuy+GeTAYEXi6Z3QiUt7PTV4/U
         vPyiH+yZkuex0MZH6KBmaHoaqltQtaaXAu1HY6YdKfzFhxrUS3uarQ/9XMHuk3pHZRuj
         IzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727287116; x=1727891916;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLBQStQH4mOT4tHop8xO2S+SOlNf+B3pIjXfX91wsjM=;
        b=IlQmBapc4HEkwRPwObP3eUhNZum4AleeC6eeyYe51/GxZf+yBUC8KEgPbtFv221PHM
         AvgCkHfWGbIkLNNLHq26jZKSkIPUShliqwip5yKwvFOgx7S4MHTbWLaM1hLV7tUPhgq6
         xn34WmHr7jnot0Dwd9d7OyKgX63+ll9t5+jkqJmPCTQSJifC6wzXJmOwSGG7qFI4fTTi
         nq1chq2J5hU0QCzsfPBsw0VCOA4ypnUzEl/JIgioLYRgIaFzN93HtDqXMFkngZur391I
         C5n3530Pcoy+TA0nb5dF+oR7R9ZqgOs3LYv4n2FkFmXAMnkU3ygXRwdi1BJRdebc8ybV
         f0Yw==
X-Gm-Message-State: AOJu0Yy6C8e6apBYwmA23cAKuwaQGnPTn0Zsq0BGUpsmvfOma1DDps1I
	RbyYlzOshGEl81PHFladOQHTL+g9QcNiLTo5dUgWN6NhTl0kO4cvJOSjjIHl1Fw=
X-Google-Smtp-Source: AGHT+IH/25ALbTPGMDmRIL9doQ0GOXZ2YfWUetUYVAYukFUp044hzXXpK33AoBCBNQw74pZd9I7HIg==
X-Received: by 2002:a5d:4803:0:b0:374:c0c5:3c05 with SMTP id ffacd0b85a97d-37cc24c2b38mr2365336f8f.42.1727287115892;
        Wed, 25 Sep 2024 10:58:35 -0700 (PDT)
Received: from [172.20.13.161] ([45.147.210.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc31f77esm4611323f8f.108.2024.09.25.10.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 10:58:34 -0700 (PDT)
Message-ID: <8217c5bc-41e7-4346-b3ca-1fb6caa10209@kernel.dk>
Date: Wed, 25 Sep 2024 11:58:34 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] struct filename, io_uring and audit troubles
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
References: <20240922004901.GA3413968@ZenIV> <20240923015044.GE3413968@ZenIV>
 <62104de8-6e9a-4566-bf85-f4c8d55bdb36@kernel.dk>
 <CAHC9VhQMGsL1tZrAbpwTHCriwZE2bzxAd+-7MSO+bPZe=N6+aA@mail.gmail.com>
 <20240923144841.GA3550746@ZenIV>
 <CAHC9VhSuDVW2Dmb6bA3CK6k77cPEv2vMqv3w4FfGvtcRDmgL3A@mail.gmail.com>
 <20240923203659.GD3550746@ZenIV> <20240924214046.GG3550746@ZenIV>
 <d3d2c19d-d6a3-4876-87f0-d5709ee1e4b2@kernel.dk>
 <20240925173956.GI3550746@ZenIV>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240925173956.GI3550746@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/25/24 11:39 AM, Al Viro wrote:
> On Wed, Sep 25, 2024 at 12:01:01AM -0600, Jens Axboe wrote:
> 
>> The normal policy is that anything that is read-only should remain
>> stable after ->prep() has been called, so that ->issue() can use it.
>> That means the application can keep it on-stack as long as it's valid
>> until io_uring_submit() returns. For structs/buffers that are copied to
>> after IO, those the application obviously need to keep around until they
>> see a completion for that request.  So yes, for the xattr cases where the
>> struct is copied to at completion time, those do not need to be stable
>> after ->prep(), could be handled purely on the ->issue() side.
> 
> Hmm...  Nothing in xattr is copied in both directions, actually.

Even if it's just copied out at the end, it does not need to remain
stable after ->prep(). But most things will still do prep appropriate
things at prep time, just to keep it consistent across different op
types. Regardless, other things read from the sqe need to be stable
after prep anyway, so it's just the best place to do copy-in of structs
too, even if they are written at completion time and could defer reading
it in until issue. The ->issue() side is mostly just about that, issuing
a request and posting a completion - or deferring a retry if it's not
ready for issue just yet.

> AFAICS, the only copy-in you leave to ->issue() is the data for write
> and sendmsg and ->msg_control for sendmsg.  Wait, there's that ioctl-like
> mess you've got, so anything that feels like doing (seems to include
> at least setsockopt)...  Oh, well...

Right, things that obviously write to buffers will do that there, as
that's the context where the completion happens anyway. The setsockopt
parts should just copy out at issue time.

-- 
Jens Axboe

