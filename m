Return-Path: <linux-fsdevel+bounces-53653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C80E8AF5A36
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 15:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A845446CD4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 13:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313DB28312B;
	Wed,  2 Jul 2025 13:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="m5bgYAUQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A9027CCCD
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751464257; cv=none; b=XSA/oGeYmAFpJe5FBmtJttQ/SeQ1HLgvN9W4/hMfRiGf2kBYCmx8noEqlsbKb8lY3I7NUAwsGWJQ6ImhBCCGDH1xywz4ZF5Nhy3eXod/fbTG1yJO1zYYVlKAqlMlnF7hfn73uy5y3xpshfekOOYVUqzoZZSeXQj+iLfL6ClTuE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751464257; c=relaxed/simple;
	bh=LDP9lqebG32wAFEhL2w8nw57/9Ji2DO8m3R5qWReTSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZGuQ/F4WmUfAAkfEEc5/xkgl2iLeq3qK4w39eV4Kcp624kX3Nf3gL/gSKWeDH75q+PGV21j7PK12uKaFWFV56R5jlhHFpTBOx7yy5nrCBERp7lTv5YBC1voLUW4Re+kVzTYMVp8EUAVnpY9/hijBe6VoLQgQwoHqFsuD8yCPUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=m5bgYAUQ; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3df3ce3ec91so17082245ab.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 06:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751464255; x=1752069055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mLW/0N0XpNzMpPt8g9m2q67+nQhviZAqExsESNfUAQI=;
        b=m5bgYAUQLT+PjVW8wPfjV61Jt7v0OLfTLV1EiNmwaZd89b8RElrTO2/Hk8MNzpUw+J
         hzcMB5+f9mUP2pASWX/i/03+Ou+PlqEMtqhOCJqMaZtA/zgiKSZf2bystbninRZJW7dW
         Y5n/Ib3KFCbNN8vK7CZoMcgoRukfXauOiniWvMwyRs0OT/dUZyiGtUUfMYcu38v8xP1t
         Zn0xowdZxGai+bqHO5Kg/uvLK7KHukJ7x08XOt3cmUAoMRlNo8Lp36/vOdFEkFV7wOxN
         p83hTqJwT/kudoQieOAj81YMytiQesmfqkc1UEEdJILG86ADMGi7QKYUYjBSwP9Q30qc
         hZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751464255; x=1752069055;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mLW/0N0XpNzMpPt8g9m2q67+nQhviZAqExsESNfUAQI=;
        b=UpqE0eil/PyTlPh03r24OUj6fE/KiLPjBI9+qEgOBmoMYCIi+mOPS/bXKu4An2cF3a
         pi0JYFIYFi2UHbdXGHsaeROf4TqsOPEtLz/B8Df2Qp8D/bxbcpD8JaJpemgdyzQSyJxB
         bAoI4M9kn0YD9wHL9jtqVDdMSQgBcEwH7rdvqAuAIzxwrZkVpy8QN2MetJS+0xacdX9w
         unGm5zo64N3wq828EaunsbKEPwHWxtLLEcHsUF3q1FGmC1bPYLWJcss+t1OcXDHLOCBu
         wDbIZByDcbcIL8fVZvcnx65fmMseu1vRVvMuqLGX8BktQSDJ9NWqRfxKvImnsw0ST6lO
         JQEg==
X-Gm-Message-State: AOJu0Yy6KKE01A21xiDvNVgcqXqVFGhnKOipUTw16mk+7P9MMjYjFhO1
	9eFhFCFrL2ub+B8/OertDo4nsl8zRUIzrOowiBF5DKUVYSRy5WmKAfSpzSb9wFgcXaVL6usYziz
	kaREF
X-Gm-Gg: ASbGncvY7lJL81/36pVmaLP+lrFL/clMRFYR13RP+5qX+Wwi5Ulh/QKQzVLRkzaSq5O
	QNwXY5I3Pj6Vl8/OxIDX9eVKHY2A2y3DCnIy/3LP1nPPh4S3IirJJUnojne8V/F8lq1MmPJEGl+
	Ku36+Lca89tgbFnJYqsXPGNcCyQE9Y3dsjJ+aCCmJAZOkbjrzk8erGYnOQy7a46a8hAez4owyx5
	b7blSkHnfAeARPjTMHzdYQyaqNm7bxF0KCPi91lfOdZ5/CVgG+ASO453Kmd8D9xSjn6bbDRFFKP
	gQPfFfq5uV4YfhP0pJxKL+2F0Ru9nlrSEs1nRPL/LaKE6vGeQg0zY0J5NgrQsxX4l6e0rA==
X-Google-Smtp-Source: AGHT+IHAsltQpbQrRTRHfn1V7UB4MacxzVGxuDT5b3XXV6LL/xGqcw1VGkZtnTQZ+XrujaVF8jD/yQ==
X-Received: by 2002:a05:6e02:17c7:b0:3dd:f4d5:1c1a with SMTP id e9e14a558f8ab-3e0549f29d8mr32106745ab.17.1751464255008;
        Wed, 02 Jul 2025 06:50:55 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3df49fed018sm35911325ab.23.2025.07.02.06.50.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 06:50:54 -0700 (PDT)
Message-ID: <5838f57d-b3bd-4db1-b762-847f970ab60d@kernel.dk>
Date: Wed, 2 Jul 2025 07:50:53 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] anon_inode: rework assertions
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, stable@kernel.org
References: <20250702-work-fixes-v1-1-ff76ea589e33@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250702-work-fixes-v1-1-ff76ea589e33@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/25 3:23 AM, Christian Brauner wrote:
> Making anonymous inodes regular files comes with a lot of risk and
> regression potential as evidenced by a recent hickup in io_uring. We're
> better of continuing to not have them be regular files. Since we have
> S_ANON_INODE we can port all of our assertions easily.

Looks good to me and eases my worries on the S_IFREG addition.

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


