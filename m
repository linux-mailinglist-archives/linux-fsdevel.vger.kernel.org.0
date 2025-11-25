Return-Path: <linux-fsdevel+bounces-69805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AF05BC8600F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 17:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32BB534EAED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 16:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A1D32937D;
	Tue, 25 Nov 2025 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Qx4eNx1p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D43E1487E9
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764088732; cv=none; b=Za/4jPwTrWjBUl/ETJQyWQl+wp0fndJGA1X5NCChXr+zFE589X2DjeVCPs97Y5iNZnL1mno++xy8PaolE2s2lwRB4DA1v94nhAcYHg6ayoFrp4aGUF2smc9VmlPDkWAvGUGDY+ctJ/Ov21FrGytX8WRU2k9N/+otxW/8yyPZKHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764088732; c=relaxed/simple;
	bh=pl81mTmQrUeFbjogui3HKPvx1lGdbjyjUoY+kiiu66Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CtnPZkkO3/YiAgsrQi+z5ys0HWV1KL0ZrWk/PL/mmXHm4RcUwT6PMbISD1RIwaAxJeqzK6NDW5jQedvztmhh8soWChR67V/basRWRgQoaE+ifWAK5mf/oz6NbyC5yubIZPXHFYk3VBcfwI9gTrr9LlNfDKEiflYPfxSfFP/c7GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Qx4eNx1p; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-948733e7810so232477139f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 08:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764088728; x=1764693528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sQJD1PaCFGI+2PHP+VdPq0g8BVVyn313smxn1nN2/mk=;
        b=Qx4eNx1ppOfskWW1jQ37R8A23pQKxrjj2lrA7iKjZPzQtQkNy4WkYcr79pi81sj8MJ
         oTe7PxnR5KDwbmBWuJaeg469UlZMSzTTNzu258PYCpUR6FpphokKOKqiue5FCJv7Nqm3
         UHdPXJWO7ygYzbrzRaNyuX0wF/zskUO5RN9I+l91xbD6eCDIR/VuHsYia3KgEZMNEIyY
         6UcPmuwmg44gMQtMj17gjxnk0rWRSi2Q8nSdwXFw0Vj4ENv1PDvvmJUCpVoLoufriQhl
         mBG9T0/+x/QfcyVMjK4PlhCTCa5RJpJSs8SP5SLfXlHIFHOhzs+j3PV6gCF8xLD+Sqw0
         P0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764088728; x=1764693528;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQJD1PaCFGI+2PHP+VdPq0g8BVVyn313smxn1nN2/mk=;
        b=fOUiuSuZtzT9mbVxU8yeMVS6klJSdmRjG5/AahVNNFZZ5R/Us7EPVWYWZLEGuHWqRH
         R/hmLkU2hn6kYpFcaUZfe7RzKgOLhjuaNGMwIdaoucGEDkoQrd1R+6YEcaK/cZENELSs
         MIvNUjvd/ynJhjlMp46tkVkeFDV6F669zRdyXb5v1+b47p4R/mCrJWzSU1wdo4bxALdm
         jqeYZ516kWrrNfqCluITkgwA+C7e+5r6/s7rXLcaqdMXk+2s/VEsuCxJvwiWnoqSZfvd
         FWhWoeH8Rm9DQteeHUSiYo8nu3nNOZDrtPIsSMWhwgNfuTl/JFbJjD1mPI6PJ8Xxxh7c
         xkxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMqYWzFJhsE5f+hoXVOy4MFhj83qtYAWif0nr8Xd5XD4vflJxtgUXhYeSN3j/DUr6WR/G50LtWCzjfoEGL@vger.kernel.org
X-Gm-Message-State: AOJu0YxXD8JxGdxZ58v9Kc2O98f7i8rZ57zfH1lftumMRhC9TNqJwoK1
	3KnEXZaXN6dGgouP2lQKscwfGWsmGXsZeveunZmkFMeuimPc754jlJdaEqjFKY3AZTI=
X-Gm-Gg: ASbGncu9UMvBOagSeIn7ooQ1kFbNb51bzdRT/9Agi520t/CE15UQ7/9Rn7/zlB5sHFo
	V3O25QXTNzebcwVdqSGNGFifoYRx4FhGMJ92m+1CnY0qImb7DoRKpjf722pDVug3mgXslZe6HjK
	vc69qZrps1MSDZOP2oi7JhCS8bHZdt1UJuq/C07JQUxlSiJuyuSwIqhyuI3WPqfQKQU1O1kY4BC
	6aRzI6ewb18s+wFPUeAvuCbZAM/mp64dE6aKfkgA6ou/Wx2LcZDkAuAhmvPz3IGs6V4PigJWlVh
	69eXxRlpppJHQ5FcEYiFi0ajH8IfKy4GUlDr9U5uXeE07MQLv1vZZY5r3vCZFUl0K2RLlD88kxb
	g8eWXHSsKxA05/v6ZdB+mL/WZu0fb5hcIDbLRzrrsw9bgPSYoBvX5FKm/ZLGSnGo/3I4=
X-Google-Smtp-Source: AGHT+IHAOkBCQQdrWWOLmVPy3SStJyD3Kg0OmBefj/pt9NVo7Hs3JK+2OGaEsm0hkiqY60ZLZlNBrw==
X-Received: by 2002:a05:6638:af90:b0:5b7:c054:e805 with SMTP id 8926c6da1cb9f-5b9679f78b7mr10919929173.5.1764088728333;
        Tue, 25 Nov 2025 08:38:48 -0800 (PST)
Received: from [192.168.1.99] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954b212basm6987275173.36.2025.11.25.08.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 08:38:47 -0800 (PST)
Message-ID: <0da6ea14-e229-4699-9b63-d21611783c25@kernel.dk>
Date: Tue, 25 Nov 2025 09:38:46 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 45/47] io_uring: convert io_create_mock_file() to
 FD_PREPARE()
To: Christian Brauner <brauner@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
 <20251123-work-fd-prepare-v4-45-b6efa1706cfd@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251123-work-fd-prepare-v4-45-b6efa1706cfd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/23/25 9:34 AM, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  io_uring/mock_file.c | 44 +++++++++++++++-----------------------------
>  1 file changed, 15 insertions(+), 29 deletions(-)

LGTM!

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


