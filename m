Return-Path: <linux-fsdevel+bounces-20654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0378D66BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 18:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23136B2664C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 16:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C7B158DA1;
	Fri, 31 May 2024 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vhacHjyj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519B1156242
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717172646; cv=none; b=XHBbcV7BGV0iNLPxybblLvF7ZYoavgYPQ4QJTHlU+5acQQCCHmFBXcbVQDVpRyUnTc1PjsbUysQB/8kXDIFJmZ7C9vxzF6wunVSzcrBw8j8xgaaWjyFckV8lw0IDXNcy/qQq/HIyRBDH1wOq8RJ+mOD3y9cBMakUpE8gNvluXW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717172646; c=relaxed/simple;
	bh=lbfmCc0C6vxw1XUTxL5z++ZJIOBzsLoT9JsXDkl9BJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ku0DPJt/GJFjKoS8qc0b355KRJE3wKAhj88GhUeLj9DlVRU8U0zLX4XsaLSknrL2tflosY7z+O/XbzufCtYZRYkWcbHH453JSmDWVyewrVwJ7w1EieXZRQJtIB16tXS0vMKa3VIsstYzkaYMkewFCHw5Zs4mNtpuIvfgfy6YTk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vhacHjyj; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b3356fd4f3so310030eaf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 09:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1717172643; x=1717777443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rd2v09dpPVB0uQaTFOM+mu5cCEjyqc20z6fVnQytKmg=;
        b=vhacHjyjwhUG+mVVxwjx5ghyvf4UhE+3ygqgAvVOjBSBk4dutnqjQUuNHuHfXGbTX0
         hR+EZ2FVexrqqNcf31ufTlswPNQJTPUn++G+OsWeksDU3i4viEioGYtIMX6EARxmftWi
         M93YPrIq6oBWNLzQs2ZRYowUZpodL7prgIBS7+a2wewVJmvrX/TSwvcr7kwfidnzJE/I
         BEgPjFei8kBJErcJqWr9hbVF64MozNWS2CCB/2zKYHVp0HGAY5MGqNzPJHwVdgyHnd4d
         SzxFfL0Gmef2eA80X5xx5n/jvNoglcPtW3/IHjSD43crBCdPcFGOteiseJaQ3MG23NgM
         naQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717172643; x=1717777443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rd2v09dpPVB0uQaTFOM+mu5cCEjyqc20z6fVnQytKmg=;
        b=J9gUN87l7qt76kdHKA0GseuagXhx+X1OYAGz5r8rAETuoFx1bX8+vWI4G98JEmcq+e
         Lcs8w8eWiGvRR+kbJzxCmth9of3Kq5Isoy8WcD9YT6ZwFWyQK6ZLT83BGnksbtqvyAZa
         fkBpfsARViptTNgGIbDXlL/VD3W1xEkruwkZ3EHdnVvz8GvTloJxqxfT1ChZbZTbiZ63
         jCwdg/rP2mErnlKxrUnAWgY5Cnc8KT9ZBQcxUY+oYR9QLUS4UcAScUtc665mzo+hOruv
         wJWWAiW3ajPPyBdNY0eGc1wyl8AEF64OnSNd1cu8Ps1510R/2LZJcAOq90ZdJ8loSnw7
         oodg==
X-Forwarded-Encrypted: i=1; AJvYcCVOhegDLUWPB9g3hADMOQGL0UrFVXdOsvnDYWNGokFtdbYXGjqhWZhDVmc/ZvhmBsT3/NdVZX84z8YJfUsJtFwFH1mJNfkTop0jNA+qQA==
X-Gm-Message-State: AOJu0Ywt0jnVZKPvjT9WjZWluP+FwTDQWOKcb6UMZWjrlYe+7HwTa77+
	B9UsVfZcSAhjqQAZ3CvQ0MmrOBGUP0gdRG9/7oMeFOdNEhSvCBBNRIKsNFSoLUU=
X-Google-Smtp-Source: AGHT+IFivnw1QES2JYvk0mbF8rmqda47iKxw5iyCB/Z8gLPHMrhzIOsSbr0pKOdfyVdLpn1NDoFexA==
X-Received: by 2002:a05:6870:f71f:b0:250:826d:5202 with SMTP id 586e51a60fabf-2508bd9611amr2762121fac.3.1717172642916;
        Fri, 31 May 2024 09:24:02 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25084ee76adsm594421fac.11.2024.05.31.09.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 09:24:01 -0700 (PDT)
Message-ID: <ee075116-5ed0-4ad7-9db2-048b14655d42@kernel.dk>
Date: Fri, 31 May 2024 10:24:00 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 19/19] fuse: {uring} Optimize async sends
To: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
 bernd.schubert@fastmail.fm
Cc: io-uring@vger.kernel.org
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-19-d149476b1d65@ddn.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-19-d149476b1d65@ddn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/29/24 12:00 PM, Bernd Schubert wrote:
> This is to avoid using async completion tasks
> (i.e. context switches) when not needed.
> 
> Cc: io-uring@vger.kernel.org
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

This patch is very confusing, even after having pulled the other
changes. In general, would be great if the io_uring list was CC'ed on
the whole series, it's very hard to review just a single patch, when you
don't have the full picture.

Outside of that, would be super useful to include a blurb on how you set
things up for testing, and how you run the testing. That would really
help in terms of being able to run and test it, and also to propose
changes that might make a big difference.

-- 
Jens Axboe


