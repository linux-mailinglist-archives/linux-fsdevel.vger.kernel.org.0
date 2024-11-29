Return-Path: <linux-fsdevel+bounces-36152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EAA9DE855
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 15:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D0D281D04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 14:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6362837A;
	Fri, 29 Nov 2024 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kRnGrl+V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD4A4C9D
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2024 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732889880; cv=none; b=Vzu3a3DW/9ZWSIHihCVohUA5dUtIYDDPb3+PpjzPPexVURJw8Q0qUODvlgxdNVNhbH/qpZHwacBt87oowYIjP24pPe+8sJk3fN9WGorvirCLNiFMAsiu3lBK2LCLG0y2TkEW22IFLLl6pXui/SujTR3HQagGiEC0r4TyftWvltI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732889880; c=relaxed/simple;
	bh=W0DmtYs/ivDPnZwWHT8UHad7UvF/caiQ/9exehD/LVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJl/8LaJ3NVBtQ+UH/HraLknNTnrmN0CPsKpRUeX41KR5e3YIB2FQjU4ZW7vI/SsaRcz8jBD0UrxPBk+dRzYXLQyjwVb/KMFWuDVk8lfqQBMrDMYcXB8w769qZqd/nsqi8jI04pjCeOj/t/0L5K/vsSJhL56Inm475mW/QCt2bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kRnGrl+V; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7fc2dbee20fso1452135a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2024 06:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732889877; x=1733494677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qTjLakjVQ8CuPE9b+KJbasKB+qT5ruuRyMKmxE0mpHE=;
        b=kRnGrl+Vc3ICIM0amrhgMkRRqHxAZ+u63GopygY+q2sAJ5JCZ2o5tKakg/wSUL3EzH
         Nl1mu00t47i23HzE8cgE8T4q1WZ4dV3bpQdKYD3wp+9JTPC/pZtUtUbxfO6qkHwdWnEW
         e9EHENf6Wf6PIivyTax2KdDh5/pjMpj5KaOmYAl03Yfo0+muRwIG4DezARl6Kr1JVXwL
         Vo2Gj1RtRvqv68B0OsLn7fDxz8pitq6nDlcdIc9JLM0qXByPLsNDFbnnS6OPaHRhp5we
         kJCJGrarUPtWdGBPXrMGHYgV7nsn7Bq56hCH8a402B+Yyh7ZUv/w0aNWS8wrJ/gofHx1
         bmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732889877; x=1733494677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qTjLakjVQ8CuPE9b+KJbasKB+qT5ruuRyMKmxE0mpHE=;
        b=MTCugzL9N9RL5kATCKyAveG+wAyT1rn71v4asa3s0jbhwAve0pIcCT4paQbTG7YT93
         8O8at4zbjY6B9XrDjk3gFsBmdF7jwIF/7vLQb4vGPROuQWFXIfxG2NtiWydtRPPYm2Kn
         8kEWD6+gN2fVTmOmrhNSEdu+XUprWS5Kss4SEkKXsdfEsh7VTQfFtU0J6MElcSi+/6aK
         5tHlL872kwnevO3VJq9CUDBxPH4RQCr4ackJTQR8elRzEqX1xmTAKbEPqCRIDOWy3hpT
         Ibbx8WzatGDyN1iaCOgm2RY+3kpMGbAk+Xb8jvg8r4MzfKSLypdoGwdeYdzGyB5XjGva
         /xtg==
X-Forwarded-Encrypted: i=1; AJvYcCW/eZw1kmafErpWvfKkqabR/CsKKYe8qdo181R1EJJhO/RBAguhimZ7W7waCVz6ljsl938XfPJlpR2Z45L6@vger.kernel.org
X-Gm-Message-State: AOJu0YzqRA3AfByVzKHxaERjU+4ole14lTcV8kS5A6h0qg+iWqu0jihw
	rePaszXnidhIkLikkYu0JsYUFdgATyky41exH9y47F+GZbNxBbeN1x7OljY0rBM=
X-Gm-Gg: ASbGnctaX/tA/RNYk/0rtQg9mItHOyHGWH5v4vC/zyGb9Plnlzwoatg2193iMjmXnVB
	CVgsH44YywY7cUz/eNhvIXxIGiLrIyujgk95AHEQ4DtPyS1nPD1ZX+Yv2NfWvdhDR/PtuFYAoW+
	XTouSkFgynJml/sGI3fT3EqnCkfYKBe+UhP7YOx72VXaNsR/7AlJ2DR3I0hSwqUAMfCBMLd+gs+
	rwseHd2YdqDyFxEC8FZ4PwE5kFk9fjv7AaujbkpuaeBllU=
X-Google-Smtp-Source: AGHT+IGex/wnF/hyoCx+DzF6xIc9C3Ts1sMz2ZwLBUPzctWWBqn39zKEoU35OVLZuarjSrOdSTzJsA==
X-Received: by 2002:a05:6a20:430d:b0:1d9:3957:8a14 with SMTP id adf61e73a8af0-1e0e0afa6d6mr16379131637.1.1732889877136;
        Fri, 29 Nov 2024 06:17:57 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c30e2d8sm2749399a12.38.2024.11.29.06.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 06:17:56 -0800 (PST)
Message-ID: <bc40bd75-7eac-4635-8c91-ccd42c2f1aa6@kernel.dk>
Date: Fri, 29 Nov 2024 07:17:55 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] WARNING in __io_uring_free
To: Matthew Wilcox <willy@infradead.org>, Jann Horn <jannh@google.com>
Cc: syzbot <syzbot+cc36d44ec9f368e443d3@syzkaller.appspotmail.com>,
 asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <673c1643.050a0220.87769.0066.GAE@google.com>
 <CAG48ez0uhdGNCopX2nspLzWZKfuZp0XLyUk90kYku=sP7wsWfg@mail.gmail.com>
 <Z0kDWtjmlI_LwP5S@casper.infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z0kDWtjmlI_LwP5S@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/24 4:57 PM, Matthew Wilcox wrote:
> On Fri, Nov 29, 2024 at 12:30:35AM +0100, Jann Horn wrote:
>>> ------------[ cut here ]------------
>>> WARNING: CPU: 0 PID: 16 at io_uring/tctx.c:51 __io_uring_free+0xfa/0x140 io_uring/tctx.c:51
>>
>> This warning is a check for WARN_ON_ONCE(!xa_empty(&tctx->xa)); and as
>> Jens pointed out, this was triggered after error injection caused a
>> memory allocation inside xa_store() to fail.
>>
>> Is there maybe an issue where xa_store() can fail midway through while
>> allocating memory for the xarray, so that xa_empty() is no longer true
>> even though there is nothing in the xarray? (And if yes, is that
>> working as intended?)

Heh, I had the exact same thought when I originally looked at this
issue. I did code inspection on the io_uring side and tried with error
injection, but could not trigger it. Hence the io_uring side looks fine,
so must be lower down.

> Yes, that's a known possibility.  We have similar problems when people
> use error injection with mapping->i_pages.  The effort to fix it seems
> disproportionate to the severity of the problem.

Doesn't seem like a big deal, particularly when you essentially need
fault injection to trigger it. As long as the xa_empty() is the only
false positive. I wonder if I should just change the io_uring side to do
something ala:

xa_for_each(&tctx->xa, index, node) {
	WARN_ON_ONCE(1);
	break;
}

rather than the xa_empty() warn on. That should get rid of it on my side
at least.

-- 
Jens Axboe

