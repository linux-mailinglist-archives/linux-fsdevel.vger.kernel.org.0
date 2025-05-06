Return-Path: <linux-fsdevel+bounces-48303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD78AAD121
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 00:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30068983F11
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 22:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8757C21ADC5;
	Tue,  6 May 2025 22:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQ02sBbS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CF14B1E7D
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 22:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746571966; cv=none; b=e90KK36/dzbSeo/Ut1dLSdtcm8Eq37+JfW6DwK4CJE0tjm0BifKBTmaKP73C91uNlcr8+5LmN1OZBeyWmykCEW9hyUecDrNqbtwu3TuZk1jXq+9n4qZ3oXUK1UU+gAsnsFh/osCT3Z+tFP/efhIzqkC9gOJF9WjJ2FvUutFbR7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746571966; c=relaxed/simple;
	bh=I2Lc6FjdTEfc7KcKNMcYel/MLvKbi6lyMI7kWWS9qdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GOBn66AzVIRUd2rjjU1nJbwprPaRmlFByS1NQzqFsi0nOpKjY3aztHDymRrw78obG1tftIxW2Fypy12WIehLEnusaoBaqD6PySkiHIafjZj96E6MwVsBm4pgsq5QoWvuzopBL8JCII6m4mEtcZzjaaZLufCDrITGAjrDZOxfrX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IQ02sBbS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746571962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSbhMzwrXgtq6axW2oDnDnrz312/alFjqdIi9xnRxw8=;
	b=IQ02sBbSypRatYieEPWXysnGpKIaCpTmgw0tPOk0teQcxJh2y2esfkjYWIX3pA9et5asi9
	opZaRQZu0gXUck17drX6vAX241nqXNeOLte6HSTVoNe7UHcPGCuKL1y9DTcUnqQ6b1jsIs
	qqycJVNgGDsSiRVqvSSRxVKEOUTBXro=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-yQzBDSeiP9yBk-cWWxh3mQ-1; Tue, 06 May 2025 18:52:40 -0400
X-MC-Unique: yQzBDSeiP9yBk-cWWxh3mQ-1
X-Mimecast-MFC-AGG-ID: yQzBDSeiP9yBk-cWWxh3mQ_1746571960
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3da720e0c93so12894685ab.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 May 2025 15:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746571960; x=1747176760;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSbhMzwrXgtq6axW2oDnDnrz312/alFjqdIi9xnRxw8=;
        b=MEyZQKUOs24QKpWaxmEjXFh6jB8n0oelhz0YKuOEkUZt7HqGBkJD05svBsvOHWTcT6
         446kibNvEzzbzkrLCt95a1B7Sv5UYkeblxuJwUGkYMHz9ZwGkA7qsEhXriLjHfQTcjPd
         hgD1HBIhkes+dY5HbUZ4tTDphSYdlShPvxvhRTRvABF0bLYmjmU/t/hBHRA49QiP6V9V
         yHEuRk+8HTwX/z8t9jf2kIISwMLtZcq8QRLBdrtCUveTtn8cRPjjZ6T9imz6vMZN7oig
         QqHOdS/xJv7aFKb3HrKf8OMmXX3InWyscY21G9Fhk+cjrhSjizoyGQoFUfPaGk6EhRaC
         In2g==
X-Forwarded-Encrypted: i=1; AJvYcCXnAbYDP8gmyQ/6bBikNqp8ryd55Ct0EdVCQmENlz3a7kJEvCQF/NOgh7SSdcrD1DYT9cJfBGRRsvV9hL1k@vger.kernel.org
X-Gm-Message-State: AOJu0YxGsRA8R3gum210Vzlh0/UmFCNd1pJr/ZnHaS2hpI5yQG+YR9pz
	1Nf6BauzjrzS3YRtsoX4TpQEYfMXitbyRb84PU/bnSC3n+qwSEoaLbcXe/VejffXGyGP5gTMjtX
	kuH7DPN6SW2X/nrqYdkzl92ptRCp9owLxOgBLWoEv7vAUY79xPrg0psYx8BR3Ols=
X-Gm-Gg: ASbGncu1tVE5H2ye+AKJ9UnF/WdpiObvDLpXRucdV9byyAQTmiLbmjcKqJgb4jWm5is
	JTtKUxQxj4rFnC7KReI0KhqFQPXPsPnWgsnmeQJqlNtQS/ppD6XPzu7cM+ki4OHd+rRK5SQuX6l
	j1K2xWLPdCISpPop1DgV55693m/VOpWi1ego3rIFVFAbmnKA2ExFWG2wgAPqRaf/FnQjqJKLLnZ
	YG//Hn9MlFrEDixRzK6QXzGeBOTPqyRGVuhPYqQWoS2BAYLhXcQl/0Dk3u5gzvl8wCtZB4AMJQN
	icoBbOu6f6fR9FvBZO7C+NUAUO2nwQqQNCfxv/ncj4V+5SwrmA/H
X-Received: by 2002:a05:6e02:338f:b0:3d3:f4fc:a291 with SMTP id e9e14a558f8ab-3da73935e95mr12731305ab.19.1746571960043;
        Tue, 06 May 2025 15:52:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0fxqWLT2ZfgPKpCW1lmti5qzFFiAZoLiS+3Hezb26fGkl98iJVYJZU8f5uhw6Yg6E3x+ftQ==
X-Received: by 2002:a05:6e02:338f:b0:3d3:f4fc:a291 with SMTP id e9e14a558f8ab-3da73935e95mr12731165ab.19.1746571959829;
        Tue, 06 May 2025 15:52:39 -0700 (PDT)
Received: from [10.0.0.82] (75-168-235-180.mpls.qwest.net. [75.168.235.180])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d975f58be3sm28293765ab.58.2025.05.06.15.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 15:52:39 -0700 (PDT)
Message-ID: <5eda52cb-995f-4bb7-a896-927bacdd17a2@redhat.com>
Date: Tue, 6 May 2025 17:52:38 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 5/7] f2fs: separate the options parsing and options
 checking
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 chao@kernel.org, lihongbo22@huawei.com
References: <20250423170926.76007-1-sandeen@redhat.com>
 <20250423170926.76007-6-sandeen@redhat.com> <aBqGw8lUbNtvdziC@google.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <aBqGw8lUbNtvdziC@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/25 5:01 PM, Jaegeuk Kim wrote:

<snip>

>> +static int f2fs_check_opt_consistency(struct fs_context *fc,
>> +				      struct super_block *sb)
>> +{
>> +	struct f2fs_fs_context *ctx = fc->fs_private;
>> +	struct f2fs_sb_info *sbi = F2FS_SB(sb);
>> +	int err;
>> +
>> +	if (ctx_test_opt(ctx, F2FS_MOUNT_NORECOVERY) && !f2fs_readonly(sb))
>> +		return -EINVAL;
>> +
>> +	if (f2fs_hw_should_discard(sbi) && (ctx->opt_mask & F2FS_MOUNT_DISCARD)
>> +				&& !ctx_test_opt(ctx, F2FS_MOUNT_DISCARD)) {
> Applied.
> 
>        if (f2fs_hw_should_discard(sbi) &&
>                        (ctx->opt_mask & F2FS_MOUNT_DISCARD) &&
>                        !ctx_test_opt(ctx, F2FS_MOUNT_DISCARD)) {
> 

yes that's nicer

>> +		f2fs_warn(sbi, "discard is required for zoned block devices");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (f2fs_sb_has_device_alias(sbi)) {
> Shouldn't this be?
> 
> 	if (f2fs_sb_has_device_alias(sbi) &&
> 			!ctx_test_opt(ctx, F2FS_MOUNT_READ_EXTENT_CACHE)) {
> 

Whoops, I don't know how I missed that, or how my testing missed it, sorry.
And maybe it should be later in the function so it doesn't interrupt the=
discard cases.
 
>> +		f2fs_err(sbi, "device aliasing requires extent cache");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!f2fs_hw_support_discard(sbi) && (ctx->opt_mask & F2FS_MOUNT_DISCARD)
>> +				&& ctx_test_opt(ctx, F2FS_MOUNT_DISCARD)) {
>        if (!f2fs_hw_support_discard(sbi) &&
>                        (ctx->opt_mask & F2FS_MOUNT_DISCARD) &&
>                        ctx_test_opt(ctx, F2FS_MOUNT_DISCARD)) {
> 


