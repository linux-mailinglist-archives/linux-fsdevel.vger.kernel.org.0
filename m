Return-Path: <linux-fsdevel+bounces-53784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C335EAF70DB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 12:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F01A17A896D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 10:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6C62E2F09;
	Thu,  3 Jul 2025 10:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0x232XR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0BA2D9EFB;
	Thu,  3 Jul 2025 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751539634; cv=none; b=GS5+GkIuRUtDhEGxa9b5A63zrbM+okj7TJe2mfnl78WkoNUGi4HPhUXzfUn2dnd3OMjDu14YHtP3j7u7Mx8l24Q7DGrvCSwsk7wIRiUozXUKZ+VIqOqc82vxRmUUQJ6sX5jSM0WOrPKeqE5HMHXwf94lxKQNb1InbuBm9oWgzK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751539634; c=relaxed/simple;
	bh=NkBVSvIRK6m5xJpAYwjcb6boeOKxulWEgOMtKfEgvGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aGFSF83/Yzg7g8ne0QreuBGmuTrGh8FhH8ORY5NlmrMS2AKEAjuAiFa4P9tvFqubP/bWyhEMpG47WFuYavdvi6RENLCH3NSjoXuBaF4LA9hYtcglkMojSGE6ExjKDcgYqq4W8isMzpwxidu0WQKJvkvTiVByNhsIYXA3lcaLtrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0x232XR; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23602481460so80836355ad.0;
        Thu, 03 Jul 2025 03:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751539632; x=1752144432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yT116BmQVYQp7TgXBQY166ymvqYjgN3gIl7mlb2d3wM=;
        b=R0x232XRd3uS4UHUgKiGB5nheq8G2pOpy245WXg1l5hkAMGcNbwQT7KZUILV703xdP
         ZDTtQGdkI6OdmQvdOxVgBCOdvnZCjpDnixnJ28CrxKf+YZ+FIXJK5wHtsgvCdJHif0jE
         wpq0yG1Rnms0ULntbXSbEw/qqs6LdYvaP7rLSqvqmIeq5nwqiRVI/7je5WM47LfKngNx
         BwA9Q2sJLfxg5480HbDk2pLwdooYwtbgytp34iPV1ib6OymHzsMogAzWxsM2BRlXN0Rf
         rLl8tQl4rf1dBZYAfPa56WQrh/UIw4UTY1JkaLfdGt0YPURZ4dnZv1cdKLqMmEh9LZBd
         kgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751539632; x=1752144432;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yT116BmQVYQp7TgXBQY166ymvqYjgN3gIl7mlb2d3wM=;
        b=UYJausX8eSq0pAUPEDKwhXcUsJSPZaSOqYyjSaJloh/tVEuSBerAaFBB36BB8WkVlv
         VohjShdz7+27T+UHdaWqZqSAu9DKINl0odD318bJ/3Ztns3BHB5RdEo/dirHEhSY0ma/
         6S5FgBWGzSsVWP5OdAF30Fi0ZYBnD0fOemZIznProKXRqtdnxfGurhb2CYRlGFpCa7hR
         4kliYk2SeuO5d/coS4A4Hc49AwFJvr+ya0QTECaD0ybiGOh6ZIMfE7Tan6I/nIVz+70b
         A6VCsZxuAGuAAl3UI1eI7ayRRRWFlIh/1UkUN+5nwjv/5C8KMaWerUnYCue3Ql8EHvpe
         Cqag==
X-Forwarded-Encrypted: i=1; AJvYcCVEbrkv7b2GETlohwdySaalXVdlrZQegDUMt8Cz5AqSlTYR+xjWJSj3rR90fOh7NZOl7aoHxcg6x5liReFW@vger.kernel.org, AJvYcCVRoTlSFWIyLy/1bTxSf2i4AVFZxIMHFsAFgQr0Af3hFGc0q/XoCeT+hWho28RKifufxwXcJdgE4enBtkej@vger.kernel.org
X-Gm-Message-State: AOJu0YwEmUYILDNWNhDuatBWefZcD5Dxullk94aNakAkiOrHC6ysKjk0
	MybisMmUbp02MV8qMadoXkCOKNHswJZUgMfpD/RAGQ37zYnXyLKHOgJFlAqVKSFj
X-Gm-Gg: ASbGncskUcZIjhxUaMZojWspxYkLB5HWq4dVdaEZx9rxVnxUIC+1slMzIh0OGdsM+IE
	p9UAWE3Drzm74ZBw8v7jaKB23C89PR+hq6l5l0PzDaIQPHu55KKzBA27aDhc//jMe5HR0QwyMVk
	sZcv1r6/WdEDmBXbArNRO4viCXAYNeic+CMTmdmqfQk/cICp6hkYPuD3b5z1UqHfnMXzFZBF2VY
	vSyQLLC1e9Dx7EvQUKEv/WL57Fnz1zh9nGqbzkLvdXOSB5itdbIN8gqDtfQUhvcXDTFHKULv0iw
	yfiLP6uGHglxRovsfE++WtT/XDFhpb55blk4pkaeiiXrMx2FXPnx3QeO8Cw++DMh5AUnTvxt3w6
	+efA=
X-Google-Smtp-Source: AGHT+IE+BSY2N3Ksp1Ngu882oItJhHDV437LBfkyE/yfOf+Y7Tt3xVRjNgqMrrvyEVdLEqjOCjXpZg==
X-Received: by 2002:a17:903:1aab:b0:234:f825:b2c3 with SMTP id d9443c01a7336-23c7a1f0e25mr31795975ad.17.1751539632373;
        Thu, 03 Jul 2025 03:47:12 -0700 (PDT)
Received: from [30.221.128.104] ([47.246.101.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39b9f2sm162265655ad.99.2025.07.03.03.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 03:47:12 -0700 (PDT)
Message-ID: <2ee5547a-fa11-49fb-98b7-898d20457d7e@gmail.com>
Date: Thu, 3 Jul 2025 18:47:08 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: next-20250626: WARNING fs jbd2 transaction.c start_this_handle
 with ARM64_64K_PAGES
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4 <linux-ext4@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>,
 LTP List <ltp@lists.linux.it>, Theodore Ts'o <tytso@mit.edu>,
 Jan Kara <jack@suse.cz>, Anders Roxell <anders.roxell@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>
References: <CA+G9fYsyYQ3ZL4xaSg1-Tt5Evto7Zd+hgNWZEa9cQLbahA1+xg@mail.gmail.com>
 <2dbc199b-ef22-4c22-9dbd-5e5876e9f9b4@huaweicloud.com>
 <CA+G9fYv5zpLxeVLqYbDLLUOxmAzuXDbaZobvpCBBBuZJKLMpPQ@mail.gmail.com>
From: Joseph Qi <jiangqi903@gmail.com>
In-Reply-To: <CA+G9fYv5zpLxeVLqYbDLLUOxmAzuXDbaZobvpCBBBuZJKLMpPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/7/3 15:26, Naresh Kamboju wrote:
> On Thu, 26 Jun 2025 at 19:23, Zhang Yi <yi.zhang@huaweicloud.com> wrote:
>>
>> Hi, Naresh!
>>
>> On 2025/6/26 20:31, Naresh Kamboju wrote:
>>> Regressions noticed on arm64 devices while running LTP syscalls mmap16
>>> test case on the Linux next-20250616..next-20250626 with the extra build
>>> config fragment CONFIG_ARM64_64K_PAGES=y the kernel warning noticed.
>>>
>>> Not reproducible with 4K page size.
>>>
>>> Test environments:
>>> - Dragonboard-410c
>>> - Juno-r2
>>> - rk3399-rock-pi-4b
>>> - qemu-arm64
>>>
>>> Regression Analysis:
>>> - New regression? Yes
>>> - Reproducibility? Yes
>>>
>>> Test regression: next-20250626 LTP mmap16 WARNING fs jbd2
>>> transaction.c start_this_handle
>>>
>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>
>> Thank you for the report. The block size for this test is 1 KB, so I
>> suspect this is the issue with insufficient journal credits that we
>> are going to resolve.
> 
> I have applied your patch set [1] and tested and the reported
> regressions did not fix.
> Am I missing anything ?
> 
> [1] https://lore.kernel.org/linux-ext4/20250611111625.1668035-1-yi.zhang@huaweicloud.com/
> 

I can also reproduce the similar warning with xfstests generic/730 under
64k page size + 4k block size.

Thanks,
Joseph



