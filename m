Return-Path: <linux-fsdevel+bounces-47515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFA9A9F270
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 15:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8C1189EB39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 13:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C417826B948;
	Mon, 28 Apr 2025 13:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YKE4D/n9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69528267B91
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745847147; cv=none; b=HzOEjt0hIoPCavUDQqLTu3TGzmoyQPamfVXZExJ+Jmq3bjUgMU1f53lw5GaSQtRIEa/du7gTXUR8vv+Vp7sq/C8yBMXAbEmEFqLlf5B2xHL6/1IIOue1eLj2whZn97nrudbnz4oC7NB9QibeGkDp81zqejRz0eO+RaBH0NsDCfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745847147; c=relaxed/simple;
	bh=5MvNb/9mCMrhQgQHkqWPTGjqBmv+a8XigpUBb2+aOuY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Idg2wAUFK9eHaSEgN7DdpSVVGjx+oO7AFXvnZXuE5+XwbVzhUV9Nlk/vO4NZR5xUYPTp+Hlfr41ww0SxuVT7nTLvHIYItyCRvTw+ac4b0babOBzOI5S7iGKenxrExPktSTjvQGEh93j4aBy8BupZ/ufacXSR0adPT7BHgOJ6lMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YKE4D/n9; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5f63ac6ef0fso5157696a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 06:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745847144; x=1746451944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5MvNb/9mCMrhQgQHkqWPTGjqBmv+a8XigpUBb2+aOuY=;
        b=YKE4D/n9kPzq6nn8H2VjQiFWdqeo7N2fwVuk9rm2xZU51paqrat2ECCQ+pGmxyjmVE
         WtYJsAJBvOhvNkcXr1DPZa2OW6mp1FDdEhqZsLpydAQU7a5s+zbyPhmcNrCGu7c8a1IP
         pzP/ImAbmg70vHDWV/lYL9UJTN/4UQdMqe1muOVqQv05onQyvXhqJYkj1PXAmC29Hm4O
         +aDIAxy5xPzSLZCe914eWo2xiPLmmk7fWGLpqCha2Xqq7Wgb3nOTwbqiU1Pul7DX2eR8
         nsOP0iEk2uspa8dweLapZ48GAv2tJ4BGGk3eUnnu7oOx5ci40fIYk2ry/eAKTCus9+i/
         1IfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745847144; x=1746451944;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5MvNb/9mCMrhQgQHkqWPTGjqBmv+a8XigpUBb2+aOuY=;
        b=lVzUX/BGzLd+g6JIv/cYTT5iDde5qsThvwDYBgVxsQqxYQwpno4VCGCU9eigfxKJP8
         kjroiWWiCZzCwIzesjOCRfz60jIBej0L35MKwbmsvw9VSL8kXbyfAIO99xmpuU+ihQp3
         Vv4iIP2/gkmLWyIX6rO2DINXKAmFboglEG4dI2RD+yByEfA7KtUjxNxT3HZUQigPge9x
         kM7wN8Auc4DRkzyVjjbLNkapd/0ZuDITBmJ6yOrgrJ617M4knwu0oDD+adcIeh9z5gPz
         8MLmLof/Qc+IkBEtQq4mPrInRgKQTiLM0sgVQYj0Dalkcz1rjq6dEI7rIAZZhEhUUvBV
         HD0A==
X-Forwarded-Encrypted: i=1; AJvYcCVEVYaDx+jR4zxPt77f8F5c1xVp3qXWih2CT7Jh1PRTQhfOCw62lltT5o3s9t+KJygnCFtmA7muMqgggvCw@vger.kernel.org
X-Gm-Message-State: AOJu0YyENLanoyHt+DmZHn0zcxIu0QzO2e9Rc+lfaKYkEJa0ovkhC+xn
	r4+Uc1a3rA6szNBXv0Hrq3btiWNzqbAGUHIvxa2762wGBigqNDee/q/8chFd1+Q=
X-Gm-Gg: ASbGncvJG0hiPGAgj5A9sIRX+tc51SuIJpGtmlS0LVYIW6kiecxL19qaJLMZNKjQYBC
	uFvaRFmwbXZjiwEvcZKrqXAGXAwfUwUbyKc3HBYPUdGUQqLThUUe0xhOqupISpxf4LbauNzy6mO
	fb0+FeKA4ReUMhx1I2zLVoEtMQ1MK6D2vdWmCAKInXxWuZjX3XdCvI5YBXfwMnPu0LnNaVidmRm
	cjvjq0g1YMhMC+fq1FBS/JuYEXeEfcATrG6RhcIKOvFDblBPae9/YHxOvb38sOKBBoJnYLMpmr4
	MXoqaIB4rWAg5r/OgPdTxDYEw6Im88ufR43vFTmKLk/8me1TfQ==
X-Google-Smtp-Source: AGHT+IHrxlEz75uA2xoO8NiazZPDyBHo8KIErfu3S0qRJ+KrGilQraL9G/JLdgOOp+3H5oDKT3nshQ==
X-Received: by 2002:a05:6402:3506:b0:5f6:22ca:8aae with SMTP id 4fb4d7f45d1cf-5f6ef1a35b3mr13928007a12.2.1745847143543;
        Mon, 28 Apr 2025 06:32:23 -0700 (PDT)
Received: from [192.168.0.14] ([82.76.212.167])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7286bb2e1sm5599115a12.36.2025.04.28.06.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 06:32:23 -0700 (PDT)
Message-ID: <7122fe72-ebc2-4798-8a1d-d905debab092@linaro.org>
Date: Mon, 28 Apr 2025 14:32:21 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vfs/vfs.fixes v2] eventpoll: Set epoll timeout if it's in
 the future
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
Cc: Joe Damato <jdamato@fastly.com>, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Alexander Duyck <alexander.h.duyck@intel.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20250416185826.26375-1-jdamato@fastly.com>
 <20250426-haben-redeverbot-0b58878ac722@brauner>
 <ernjemvwu6ro2ca3xlra5t752opxif6pkxpjuegt24komexsr6@47sjqcygzako>
 <d8b619d7-6480-411d-95cb-496411b47ff8@linaro.org>
Content-Language: en-US
In-Reply-To: <d8b619d7-6480-411d-95cb-496411b47ff8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/28/25 2:18 PM, Tudor Ambarus wrote:
> isn't ep_schedule_timeout buggy too? It compares a
> timeout value with the current time, that has to be reworked as well.

Ah, I see the timeout is relative to ktime_get_ts64() in
SYSCALL_DEFINE6(epoll_pwait2, ...), please ignore.

