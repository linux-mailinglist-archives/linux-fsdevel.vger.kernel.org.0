Return-Path: <linux-fsdevel+bounces-9940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2961B84645D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 00:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C75928A76C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 23:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FDD47A7E;
	Thu,  1 Feb 2024 23:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JWgB85MW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E51B47A7A
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 23:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706829610; cv=none; b=eEuaFmDV4SWZOiP6CbvgW2/Ra0/PpSciOBEnxgfFX+h6e7SyD4wUvUCfti8aNWS6rJD36N6lgcE+mWZ3gka80RgwnC3zLYmYlplPBupy+Ccrc61p6pe9QWihRzgCy+H4MKHxWxMHyRSBSPygxICE9FlShbaPAVp3B3u7omQyAps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706829610; c=relaxed/simple;
	bh=qnU0fOVipO3NgJmAvMxKgS+yMPu1e+FJDZztZaigPzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mlu/N1iK4f8hGKx5XdMVLy5y4EKJ5eTzeLaeihrKfZ5KWyevkvg47nLmYe5snP4TrAwUgohAhhbNzwp56sdzIliTPjL60MQxAgb7Ixln8r3s5FYCODl8r0lpm6sPlxr3TkmIS5M+Z3doHgk5E6fRiFQdcWNB2mhvfWnusPpgTfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JWgB85MW; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6de207c85fcso151992b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 15:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706829608; x=1707434408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WidUy5MgpvXo3RRgp9vhm9IXWrxrxkiLxfmg6p6r1p0=;
        b=JWgB85MWByCmrWKj8rEdsJ4chhKp0lRzPmVOfLzGjJBm4EVXqFAO83UavlGbTQkJkN
         Ulo4h7B0frOhNyhK1llKq8IOxbKQj/o9W8rMCt7alUEu0LaONDoQeIPPej1VEHxuOUUZ
         spMaIUSynK6qXtpEWoTvRBHr0bQIJwXDngdXCUuXqgKQK4IScXPw9lnjuvOiBEUOeIHs
         LUSxbLR/g6NZvCXYPo1JH5G2nB/AKJqnfs1LiEMwktfLIYKeSOCHOdbdnM352dC0INol
         FYCGGfoawKeIaApEtDN9HzhqoTGJveXzUyuKaGZvdHHYYEEm3F6CJSvGqfRuRGIv3feG
         ElzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706829608; x=1707434408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WidUy5MgpvXo3RRgp9vhm9IXWrxrxkiLxfmg6p6r1p0=;
        b=SjOTRi78QP+K75skXGTwO5AMfcCnY56Z5DdrlyICu6FdgWg5oG1ZMWpjvU94D/0SYM
         9HXiQtG+UzV7k3l8vgMqEK01Tvwp2nDo+mJmKDjHzpFfbfAKRWTo+y0rMyshCrDmOHdw
         wmsY2VxdSMC8HSEqHfDJwqKQtD58ocZGvkmJb8LXn0f3QN9Hc3ENXNd/jDOIHlIRN6s0
         WTkxFjrPCYYDakVffn3ZqSMHMwroa4yFOJN/pi4JXOeLcL2KxXSOhlbnEdVpMvNmmFdZ
         8FP9eip/StpUeYSK1mgrGrmWX13JvDUPzZGjpdjkW8J0B9N752/gQynId49t60tWU8Ti
         RxFw==
X-Gm-Message-State: AOJu0Yz4GExfaYzZUjfgDW+K7e/zX7Wao0Zwqczm0K0I6OdmfV6HOsqF
	M2sQrV7GunFR2FWI01CGkMYyG4RhtNFnB4UQYU9T67MZdkQspr7Vf2VIWRPsl2k=
X-Google-Smtp-Source: AGHT+IGycX91EOTANdI0cn/Hpis899oLRURfAfOza5DBXAFOFdrCFwZpolReH4cbp+bkB6HyyknXKw==
X-Received: by 2002:a05:6a20:3d06:b0:19e:3369:5eea with SMTP id y6-20020a056a203d0600b0019e33695eeamr4340454pzi.5.1706829607804;
        Thu, 01 Feb 2024 15:20:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVDmxMguMgaAl58Eo2JP1AhWJB8I11FY/J4jRtNBCi4WbouxM3hiwyAo/FgqhfGCHtoRKtCjcXIbheyxw9s9HmeJ2jeLTPaF+mSWkUAD6fQIevPab22qLenjJDjNlC44PQB
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id u26-20020aa7839a000000b006dde0724247sm289057pfm.149.2024.02.01.15.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 15:20:07 -0800 (PST)
Message-ID: <17b4f4f0-0c33-4c6d-819e-c2e170d4b4b7@kernel.dk>
Date: Thu, 1 Feb 2024 16:20:06 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] Add do_ftruncate that truncates a struct file
Content-Language: en-US
To: Tony Solomonik <tony.solomonik@gmail.com>,
 Christian Brauner <brauner@kernel.org>
Cc: willy@infradead.org, linux-fsdevel@vger.kernel.org
References: <20240124083301.8661-1-tony.solomonik@gmail.com>
 <20240129151507.14885-1-tony.solomonik@gmail.com>
 <20240129151507.14885-2-tony.solomonik@gmail.com>
 <20240129-freischaffend-gefeuert-18ccf4cd5f01@brauner>
 <CAD62OrETm04q5F7ef8fpB5xF_vTKEHfas5W86QEssZ2ozyg0DQ@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAD62OrETm04q5F7ef8fpB5xF_vTKEHfas5W86QEssZ2ozyg0DQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/31/24 2:14 AM, Tony Solomonik wrote:
> Actually, I'm not quite sure anymore, @Jens Axboe
> <mailto:axboe@kernel.dk> is there any guarantee in io_uring that the
> file is always opened as LARGE / 64 bit? From looking at the code, it
> simply accepts a user made fd, so the user might have not opened it as
> LARGE on a 32bit system, which might be bad news.

Yeah, we probably want to retain that. Though it'd be a very odd case
where an application using io_uring isn't opening "large" files by
default, but we'd still have to ensure that it is.

-- 
Jens Axboe


