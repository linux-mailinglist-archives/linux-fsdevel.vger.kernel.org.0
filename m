Return-Path: <linux-fsdevel+bounces-1135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9AA7D64BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 10:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F6F1C20BA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 08:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8143A1CA8C;
	Wed, 25 Oct 2023 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="cHMoCLoy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628D51C6BB
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 08:18:06 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0EDB0
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 01:18:05 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99357737980so840030566b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 01:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1698221883; x=1698826683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xF6RmXe0iwrBVlFJKvkrtWsUWK5y+quiCOALv0ygLjY=;
        b=cHMoCLoyWqLWgCXUUkkDnO5cbAijynfJ0KVXEABg7InAxq1gAlCLqegw8NqEZZn41h
         G5foSadkFXVwf9Q2pbcuYF3lRalC/3mL2rW65LTbdP0Mv3R14Z5KXsPX48Ts4Cgj4f9Z
         C/KABSVzXS54FGaiYBTszdh5oIQ7ZEzT8qIFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698221883; x=1698826683;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xF6RmXe0iwrBVlFJKvkrtWsUWK5y+quiCOALv0ygLjY=;
        b=hUZRZ1rSaL0PrTA/zCirTrDFcpKTH9op9GogjWN9FdOF57DD8fN6HkHddv+TkCrw9+
         fvlR7EH8yg9J0xz5fyyBRSMs/NTaNN4bTI8eZgj2aJ+kWxP/UrimXDvq+LGGghf5PsbZ
         ym+1NKpw9KjEmJOWaMXHVn9anOKc2AxgfnFTlPCDahkqj7r9kdllr0ojxpXF/h1T8ebn
         DdRAGbXslvpKyp4hWH0Ku5LCcTUq25HBFHlIAhH6bx0BSSVVVLl21cyPi3x8IZfScToo
         4rpCusQJCJXKBhBpcVq06F4aGypnkDZwyrmrottZVWz4VTDniUHSnxToUEmaT7u7mtdy
         xHJQ==
X-Gm-Message-State: AOJu0YwBKpDbY9+nmz+9UOkQwinCR8wIDU30y1z9QChhDDhtQI9ch10k
	+rWoMBtMm4Eq+xhZamGZMeEoeQ==
X-Google-Smtp-Source: AGHT+IFIy8aB1unRqCPL9qYewTHPkrA5JVy0EuoyQaAtd8SKKnjyQjwdjhFVPf1/NxxldDs9u8D+LQ==
X-Received: by 2002:a17:907:1c0b:b0:9be:45b3:1c3c with SMTP id nc11-20020a1709071c0b00b009be45b31c3cmr12738251ejc.64.1698221882709;
        Wed, 25 Oct 2023 01:18:02 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id ov5-20020a170906fc0500b009a1fef32ce6sm9561110ejb.177.2023.10.25.01.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 01:18:02 -0700 (PDT)
Message-ID: <374465d3-dceb-43b1-930e-dd4e9b7322d2@rasmusvillemoes.dk>
Date: Wed, 25 Oct 2023 10:18:00 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] lib/find: Make functions safe on changing bitmaps
Content-Language: en-US, da
To: kernel test robot <oliver.sang@intel.com>, Jan Kara <jack@suse.cz>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Yury Norov <yury.norov@gmail.com>,
 linux-kernel@vger.kernel.org, ying.huang@intel.com, feng.tang@intel.com,
 fengwei.yin@intel.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
 Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org
References: <202310251458.48b4452d-oliver.sang@intel.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <202310251458.48b4452d-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/10/2023 09.18, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a 3.7% improvement of will-it-scale.per_thread_ops on:

So with that, can we please just finally say "yeah, let's make the
generic bitmap library functions correct and usable in more cases"
instead of worrying about random micro-benchmarks that just show
you-win-some-you-lose-some.

Yes, users will have to treat results from the find routines carefully
if their bitmap may be concurrently modified. They do. Nobody wins if
those users are forced to implement their own bitmap routines for their
lockless algorithms.

Rasmus


