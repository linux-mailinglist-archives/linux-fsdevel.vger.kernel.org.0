Return-Path: <linux-fsdevel+bounces-66307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F6FC1B2FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 15:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67D3F56448C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 14:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7338D1F4169;
	Wed, 29 Oct 2025 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjfqrzVj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B462F85B
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761746514; cv=none; b=rd3ZtrK1L02B4uJ0hV9bsUA7sqxpwUtbsv7dwQSkHOtP+2CCWOekfwe65C30g0eOm/R17vBqx5g16rPlIea5VdQ9W+rVn1tUaOhM0FcMvPKjHT/rsPX23pTgb9jnlh5gp4LLCLyD1vK2f812s1kw+fFk7NTFBly4LyBiOlMi3Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761746514; c=relaxed/simple;
	bh=+rTwBXkrk8jd67gFcjP3VAxT3XoRYyLkGViTbqEXWs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CiPL275768eixEfckgzGvNiQvYCpmieVdma+0uqZKMsRPkmVYqwb0JuneOLLUxKtK2v31ddMn+Cx2NC5XKlNBlXeNCEuUfvDW3XlaGcLdpyZfeL5iixcgfJf0B8SGfYpzHhCz24UnBoFxBnrhxlN2xBInNwPeuPVh/yhpiFbX1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjfqrzVj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47721293fd3so4524355e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 07:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761746511; x=1762351311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2rMYPcT0vUjf262H+Q8TuoH4jAzWuzkQrPmzc5xLpsU=;
        b=YjfqrzVjhhhucthl9z1qe16KLN3fXmAbc90ghSJWldWPaPDBJDg8NTVrjmZnCn/SMW
         3JykydyotCYl9nyN4yDMQcGd+rUXRdi9E/28vHYzAZPGfisQ0qTNkbv1sptZR9ks3qIW
         65GOc2z1gFPnP0ZxxL5BuuKk971jcRH+n295cwlvc2Y+DIAPyzWRbePWABdTtZh8T9MT
         EgfgilYjZMuKvYgJ9Dmge+byslyU6+omUrbvYx7PJKwv6+y9WTSWAgQyp3PH/YhOXfsM
         oDmRv5xSz8xexf5YQm/ogLIn5UIcm8X6bRn7M3S+Rmendve1iSj8LTEiIqZMDzEYmcgL
         bdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761746511; x=1762351311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2rMYPcT0vUjf262H+Q8TuoH4jAzWuzkQrPmzc5xLpsU=;
        b=or8lgb1d8MvPvJzSBDhlkqmceBp5CSS89zPqTvNeBaOJhkZcmulg5e5mAdD8Z/BDZp
         GqBN8Tci6yvnIn50toA9+vgCPrD4AO7e/WdB/KmJk9ncglcn2ssCxgMGMgz+2ji5ad0G
         o6ER9hICejkoF+bvNSvWV45CFMnnh5R9S8SLkR3n0UsiXv2ZYk6vAuEMuPla9Uvi9woO
         pLR/JoHmdwYlhi/zvO0sTorHHOct4yzWEa8cANveRuHKJ3ixf/B3OTo/XBU3pe1C+5ud
         91bgsPc4uU7H3zAg6WrU7xp834nPLn3pI/ENZRM0hgI9PO1NHJSAkkEWpXdL67YX99XW
         050w==
X-Gm-Message-State: AOJu0YyzqTbpqVkF/K6tEL/Umv9yqK3sdCjTalezs3pfBS+/BrsPXC2+
	wn4A2ZTkm01Bptx4c9wiTs1Mr5kmzMsk2MRqafPQcvcwarKQn2NxmfEY
X-Gm-Gg: ASbGncv3ouIKDvDU+b6BSt9mVm6hASxbEJXX4upkHplBWJrG8b8r0I0ndZj2BAXk7XN
	pzrZOpQOrMSJpx/wTYgJDadxIP8QDO0Nce6srYQgw4VoUEkNsoQHP3lr4fIBcrjkoXJq6EWiBF4
	otcAATF8jPD+3dt9kvjwg8T9mmFte5DfNGYiRdPJRHLZEB9MBtVIBt/DVCxF7XaxRtAzwYNBAVZ
	5e9Ix3vhL4797MDAI0WaBLeJmBOCdBSnWi82uEyHMsNR9QD4qaswiYAnFwxBYTZs6miVZUMhUhh
	1RSa2AQi6eo/QP8bFfYg8osUijmXTn9kXL/nXtoxio6gH1BaaygnQoMNzkVmcVthpd9deak33zl
	7DM2cpQ9lUirQESBUwCmoxozFvp18TN2iRmwT2+g5rY+bUbm5dLPbgJh8HEC7UcV8IYbaSSqJM8
	0FypahrgStTe6Xbjpu55Mr0cvryDEiPqUcxFnYgzfTcbH+VTMbwqwCJLuRwCBzJiyIXg==
X-Google-Smtp-Source: AGHT+IGtuSHh0+Byv59OFxIgZzhRPw4PiAXZpC1qk/p0PcjfnUKrIOrNIC2+YkX1CVaDZipa6oiEYQ==
X-Received: by 2002:a05:600d:830f:b0:475:d91d:28fb with SMTP id 5b1f17b1804b1-477180f3b54mr46255965e9.4.1761746510979;
        Wed, 29 Oct 2025 07:01:50 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47725bd740dsm303775e9.0.2025.10.29.07.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 07:01:50 -0700 (PDT)
Message-ID: <455fe1cb-bff1-4716-add7-cc4edecc98d2@gmail.com>
Date: Wed, 29 Oct 2025 14:01:46 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] io_uring/uring_cmd: add
 io_uring_cmd_import_fixed_full()
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu, axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, bschubert@ddn.com,
 io-uring@vger.kernel.org, xiaobing.li@samsung.com, csander@purestorage.com,
 kernel-team@meta.com
References: <20251027222808.2332692-1-joannelkoong@gmail.com>
 <20251027222808.2332692-2-joannelkoong@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20251027222808.2332692-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 22:28, Joanne Koong wrote:
> Add an API for fetching the registered buffer associated with a
> io_uring cmd. This is useful for callers who need access to the buffer
> but do not have prior knowledge of the buffer's user address or length.

Joanne, is it needed because you don't want to pass {offset,size}
via fuse uapi? It's often more convenient to allocate and register
one large buffer and let requests to use subchunks. Shouldn't be
different for performance, but e.g. if you try to overlay it onto
huge pages it'll be severely overaccounted.

-- 
Pavel Begunkov


