Return-Path: <linux-fsdevel+bounces-33565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B81E9BA0D8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 15:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2373E1F21A68
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 14:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A045019E982;
	Sat,  2 Nov 2024 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="i/CK/uPX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EEB175D47
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Nov 2024 14:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730558653; cv=none; b=VXYZAexhaCdFoo6BKKPHjutOj4EVeCY8/3VgOg2N2e8yYSd+NbrKu/gmKTU9PGO35d2NId+dGa11Iy4HKbZUUJ/Jhza9t8pBZW0ua505ZlOnbrPuzUEj2rcqBmJVnWHbo3kPvJaFFOwYaq4z+d+GRLMpAJ+R2tDQgSeM5O0uLow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730558653; c=relaxed/simple;
	bh=NAtK0BpfLQweZNEDiMddK8CzHueYVP5sSNFYzYeYoP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4im97jOg8zr8SCIQg6aSintyAgaGnwRNb+H8jghXg6irDESXtskqMQSpnrNUfR2JNMEuYnCit2TwZ+tg/NjVlLqapF8TH0EF+kP8FsMVCfnK53+L/kS1BabpmCN0T2cehiDRfpboG5976JHH5HG9VQqYjNbZUNmRtXC9XM/PDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=i/CK/uPX; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so2442598b3a.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Nov 2024 07:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730558650; x=1731163450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pXIG4VWB6B4B6GT6n5+B3SAd2bpC2cvEV7gDXJ3W7y8=;
        b=i/CK/uPXEd4vA2X6vg3pYxdzE408WOZjH6rfQ4YzHI7Fb+6nX2iNFg4ZK824d7YF5e
         8QW8uB2BdYY9+4h+zhjcd9cmGXMjwn65XH7WKBiIeCJhTc1ZlV/nfZhOz+UQhJyLDxO1
         Slcpg4TW8fkGzCi0Kr/LDjbBAb1GKVPhqcjAOeDNq3ramPVlaIH/8ULSNOCzF3a9/Qu6
         4GYeXTxH/VlIVGdvUAYJiCwXQAI5189N7evi3w7fd/7SI/v6mXGtbsOqQevRyIEibXsj
         KZdG3TgUERrJHon8Iu41LhkN3tlDKCUeQTGDVW5BV+W6Cf8Yf/IhUezFDTrKRcH999Kp
         a3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730558650; x=1731163450;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pXIG4VWB6B4B6GT6n5+B3SAd2bpC2cvEV7gDXJ3W7y8=;
        b=OnV85F3LOiSNcdpi+XcumvUwO4tjiaV7jg+4pZNkx4lf0LJEHnU24b/bTJU/GZTuZL
         PMBNZUwlN4Mh83dHx6QoE9vG0ojzppKkfhQahIhtG03REz3XE2B3rYa7y5fhr8XWIwFk
         KOqh7DOZIH6ORCMzSLlTiFS/tEVjKacdOL3p+8lPOQ2jYqt0r57oMQ/H9jZ9YeTWxPt9
         hYKAMyvK0Zl+86++7WZRboDOhKwFc7pF6FQPXSdbETttitqYS3Fikbq/VCDKuFduS7gu
         1pMZhDfW1mGld1Z3dwaxSKFDVtg3u6SyQZX9K8BQXgGeR07F0rfuJaLdv/Mno3WBvZw8
         reTg==
X-Forwarded-Encrypted: i=1; AJvYcCVfSLNGhaDfi+U7ycLgfhniFNYRUlG22v5uUNp+INZvFrwfMQnDeSN0SC3NryZ2wUx8+UFXPtVbOANFZLkv@vger.kernel.org
X-Gm-Message-State: AOJu0YzK4WeITc59cih2GFg88ceZM+p4LIdZ067eKIRMcse0CI/q4NiL
	Roq7U+AvTNV8+pO34001spn7n9hSl8m/BEUqhIQWysOLJLG5aCSq444ORVf3ACQ=
X-Google-Smtp-Source: AGHT+IFibsSIRdCwmEeU6S8d2/XwR8LxZJfykax4TcgNvqtUkbWwJBcYMlM0hMxEMl0gCP2ibwfRCw==
X-Received: by 2002:a05:6a00:845:b0:71e:6e4a:507a with SMTP id d2e1a72fcca58-72062f4f6c2mr35374210b3a.3.1730558650398;
        Sat, 02 Nov 2024 07:44:10 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c58f7sm4302022b3a.140.2024.11.02.07.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 07:44:09 -0700 (PDT)
Message-ID: <bf55cc60-09d3-41bc-ab36-e4e460d8d664@kernel.dk>
Date: Sat, 2 Nov 2024 08:44:08 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] io_[gs]etxattr_prep(): just use getname()
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, io-uring@vger.kernel.org,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
References: <20241102072834.GQ1350452@ZenIV>
 <20241102073149.2457240-1-viro@zeniv.linux.org.uk>
 <20241102073149.2457240-4-viro@zeniv.linux.org.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241102073149.2457240-4-viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/24 1:31 AM, Al Viro wrote:
> getname_flags(pathname, LOOKUP_FOLLOW) is obviously bogus - following
> trailing symlinks has no impact on how to copy the pathname from userland...

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


