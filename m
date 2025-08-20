Return-Path: <linux-fsdevel+bounces-58383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 938F1B2DC3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 14:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69C167AADBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 12:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57C12E337E;
	Wed, 20 Aug 2025 12:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXPzLRdH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03497262A;
	Wed, 20 Aug 2025 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755692223; cv=none; b=CG/e6/VWU5iphEuNLbFLCeHSQXe018pMHBCdcJ0ALhA50CryJKHTrAZZEVi+RropzbbFXYNumJHKD+pN/aiS/Q2bADULLMqf1fw+9XtqMTI5hzrvl4PbEG4eSK5t1n+e9MXvNA+E2LmAw9coT8Ka3YXjPmTht+tERQPH+Px3M6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755692223; c=relaxed/simple;
	bh=JLWRcDRoHtReAtj03ta+zZeRHOPlCQfZ79cMMGoUmJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QK3jtRDYFRqLf5gChFVimSmmnHUuvg/b9r0HMi7Z0oLN+f5/+jIrj+D0HmcsekO2Jr/IhcmPsin/Q/bQ1FGIdhFYpEOBbDEUgCL4o44v3G/k0rWEzBJQ1jYEpTsuT1ALD6bV05k17cNdm/YKllmCOfe2DXcDULQcDPgOlrCQHpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXPzLRdH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b0b4d13so8072215e9.2;
        Wed, 20 Aug 2025 05:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755692220; x=1756297020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gAyuXmmTiExKl6ZtNupk//S3JQWiRitMbriQKBEbaFc=;
        b=KXPzLRdHNN4Zg7nGZfo8drP6Nvr9bfNPv1nO4xafovZ6hEtLQtaASm4ayhSqnbMpHG
         YNkdLbf/k5Rgv986BRMZTWzDc8iuzuO9opsgyF6QjVvex4Ej7flBMwztBI/nTSfrBXYV
         T52s4ULxLd61pgcke8Wl26EFL7MO3sTCC5d4kzKbUUCTSnsB6/FGg9q+iscQS5EK2qcH
         jhqugXs4FOBsHcenGW2Es/JOUf4pzskGWk735lwb4hXpBlaxSeyPLtQGhiBmhK1qRte4
         vtNSfmE28US5A+E49cyxKC4MjN3667BMtz8WgtG2LIVreOwd9295lMLyvOaPec6vpXRz
         trsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755692220; x=1756297020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gAyuXmmTiExKl6ZtNupk//S3JQWiRitMbriQKBEbaFc=;
        b=wvCKAEFc1bRUQ5fhVFuiQm49ZX8T9fb05n8mTMMaTM6VrM31AwjQtCJNtfCbslZOUE
         dL6MjbQ3y6tCTGKChFE+W2+mNr45Xu54+z2xZk3Kue3LgXl/QYh+mJ2EM8hPVHQJ4y70
         UhcKsLDyDuJa1xNYMmGc4SvPAO6Hr77o5stKxyA4VT9ewc9AlbjAZKsNm2e3qp9Ca0N/
         epVOt3P3VgBR/liBOiWckfP3eZaeaz4pt77ak+mTd5w/GJ3Rh9RJsjG/vaHQU9WnzZDX
         edyy0VFioxwXbgP2BvTH91nUijzIntFdYSTSTItz4ku/Wf7DJQiL4lHXvrQIIDwQUbCZ
         xgVw==
X-Forwarded-Encrypted: i=1; AJvYcCUg+rhHWYJ0AF6LYHXwZJ5FndT9oN0SFbCz5El+cZki9KVEhfygetVmat32Lg5x84YAv4VyLFMgavwXhR1Jzw==@vger.kernel.org, AJvYcCWfqSt3qBf78u69PNWpPT0ujf6JM6Djo0ETutfRdHJI6DUKxwngD9rtC7YsoJWe88ZbqjdMC8vL@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4XrCrQ6lw6Gp+fnJN0ffGlhJpX/e4lo1QxysDFVW6FLLYNfCr
	JFHsW5wd1TDs+tFHm/D81P5f7wvOQuI3Sk+3igg1DXGYZE6X2K0haEG5
X-Gm-Gg: ASbGnctHSYzZ/DGcxcZMZoYQOa0GaioNLSuxUhykHXz3WcN7qvJFIypCrV77IMlQUzz
	B+YmqGDjx0D2rEB3DUXOrYbC787yOaPPn9ydhkDNM6E1TIGHaNbyZrc24v9y5Oz/C6GDPuL9QaO
	v2fCVSYO3k1bKMHGACUtRSZURypQnXDXXIPVg4ZbCjc46B9RWUqC3izOFQDubZGI4Rlf3Zk8UWf
	TwpUsKb5/GXGrzOZ436io7ACSVdWMbsLfKT8P5j5sHPMErpuOs+pTCf479RCeA/DvyeZlc3A9TC
	wYF2Hfn6KjeUKFaruOqkaBUyfTXsgZpqlce2Ndxgy1SZ4S/QXrUSQqyzxyurgzUiUMzon56Q4Me
	tCDqB0plvsLefgJnuL7YZzAlZ+gc4ANC8bRX92g7z6nRuGlsZfIjr
X-Google-Smtp-Source: AGHT+IEmicsSzxkK7EC0Py2jIPsFAnlzPswIDNRsBjO5fusLnw8AUn6MeAd7fI3HWXtD3hpJxw4JkA==
X-Received: by 2002:a05:6000:2282:b0:3b7:8f9a:2e2c with SMTP id ffacd0b85a97d-3c32df48f48mr941403f8f.6.1755692219725;
        Wed, 20 Aug 2025 05:16:59 -0700 (PDT)
Received: from [192.168.100.5] ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077c57aa0sm7531506f8f.66.2025.08.20.05.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 05:16:59 -0700 (PDT)
Message-ID: <24119aa3-f6ef-4467-80a0-475989e19625@gmail.com>
Date: Wed, 20 Aug 2025 16:16:56 +0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] memcg, writeback: Don't wait writeback completion
To: Julian Sun <sunjunchao@bytedance.com>, linux-fsdevel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, axboe@kernel.dk, tj@kernel.org
References: <20250820111940.4105766-1-sunjunchao@bytedance.com>
Content-Language: en-US
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
In-Reply-To: <20250820111940.4105766-1-sunjunchao@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Could we add wb_pending_pages to memory.events?
Very cheap and useful.
A single atomic counter is already kept internally; exposing it is one 
line in memcontrol.c plus one line in the ABI doc.


On 8/20/2025 3:19 PM, Julian Sun wrote:
> This patch series aims to eliminate task hangs in mem_cgroup_css_free()
> caused by calling wb_wait_for_completion().
> This is because there may be a large number of writeback tasks in the
> foreign memcg, involving millions of pages, and the situation is
> exacerbated by WBT rate limiting—potentially leading to task hangs
> lasting several hours.
> 
> Patch 1 is preparatory work and involves no functional changes.
> Patch 2 implements the automatic release of wb_completion.
> Patch 3 removes wb_wait_for_completion() from mem_cgroup_css_free().
> 
> 
> Julian Sun (3):
>    writeback: Rename wb_writeback_work->auto_free to free_work.
>    writeback: Add wb_writeback_work->free_done
>    memcg: Don't wait writeback completion when release memcg.
> 
>   fs/fs-writeback.c                | 22 ++++++++++++++--------
>   include/linux/backing-dev-defs.h |  6 ++++++
>   include/linux/memcontrol.h       |  2 +-
>   mm/memcontrol.c                  | 29 ++++++++++++++++++++---------
>   4 files changed, 41 insertions(+), 18 deletions(-)
> 


