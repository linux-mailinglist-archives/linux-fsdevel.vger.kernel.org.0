Return-Path: <linux-fsdevel+bounces-31739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F8599A974
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 19:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7158F1C22C68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 17:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5C31A08C6;
	Fri, 11 Oct 2024 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Fz2rR03x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26133194C75
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 17:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666505; cv=none; b=brhaqbTfjXcPiXxljgqAf+B4KarjdONVGXNKn1tvssuovb37f5OEoWu1YDkDYG2tvS+x3zm8g/dqliHowBqVNuZczsE00yhK4pO22rfjQSP1MLliTc1SExdkJWM60NOLZ90udOqy2RtuztvjLvtehdG6ioYi1NGZe5C9q4QjutA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666505; c=relaxed/simple;
	bh=ihIlqVW564dbowEngJ04WJAW+Lor2+j3QGLpJB5zMRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxwDPBe+XmYupOLIvVC7cF1XLObAaO2lhYJo5w9pyPexThwhojVJ66mj5giVDji/aAbQmjPgjhC1RqIVPKMMowSEyQesBSGUWh27GJPNPAVI30uO2jWdkHeDQqsjiTZhfDoGrFB8ysOHJRKrJg2y49ys3upS36s3/YV9gsZR3yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Fz2rR03x; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e49ef3bb9so219354b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 10:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728666503; x=1729271303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r+xPK7LKwEh54/ZZC8QG6tkevrImBxSFBvQwNAw+xEw=;
        b=Fz2rR03xa04PkIXSLaBxsWPilAduWLGJaiHicmUlXBOmGpV10FUnaAT95zBJBWXR0m
         WTKfqCthx5zcqjcTG05jnsP9k2vJWtM5IX+8a1eOpqpVI5UntFVAhLL3wBIIK/am4BkA
         88IwLA7AUkSQTISLBsTVU1p4N212sHxdU+Kb/5lknmQX96NQ9mEB7LElqDmatjG9xK0w
         IcucWt89H0Cwc9m/0O9NtAEwgDjfyxtU4bhSW1EuLZ23A8O1sc3Y0IPapKcXAzocX+d9
         QJv3A+IFD3MxZKJj35TRILGJLlfwJuuJkVDUcRtKEqRV0yLX/lW59GYFiJaCkTV58XxJ
         8+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728666503; x=1729271303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+xPK7LKwEh54/ZZC8QG6tkevrImBxSFBvQwNAw+xEw=;
        b=uzM7gRLEjCHr5oaGGhHCcRiIeilN1ep9PqG6lV5dxCxlcyGCGRLOJ9vegPnOdSPbcP
         zRoBq0LXgV2OqX5+oDnbhdONJCPVt9/tmptX6uupQJFdgYlZru/R18MNqzI5vuqCaQSW
         3xRWXrhhGFFu16XABVXciBb28iIUy5300/nZIBRZvViy2TlvhiIY82GbEYBAeafQSGzK
         rCmqC+m3EKTdBcxBh4EVTRKFPolEODcQYgkI9o7/S8VdkULqeQP9gGVz+SNYlth/WbP9
         ugkaJqj1SPf7hqD7TKnTVb4AUvHt+2nSJq+K9BELJwx06ooUHKyuro1ED8kdY6Af9tQX
         xt5g==
X-Forwarded-Encrypted: i=1; AJvYcCUYPmRfJYZTsngH6OsUV9FmkoctnWlMnORuRGSpXBd8qTOx6QvkNjBmAh4DCeAOJuIvz5X6pJFQ2khVKlgN@vger.kernel.org
X-Gm-Message-State: AOJu0YyUrj2APl1KARTIN3zjuji6e3JVc9WKe9I8Wwhm+Bw/+YkmE2Lf
	jrOY7gQjCzJbyGFWTQr5x4twtEunsCSYGOGCyYwohyBn3JbuZFG8norzRH9t6As=
X-Google-Smtp-Source: AGHT+IEHmhZfyYl8DJMsul1UkXEVT9lzG0SPe4pnS2qGoqHY42Il/aljbU9nux3eahAquBNN31tnFA==
X-Received: by 2002:a05:6a00:2d0e:b0:71e:d8e:7676 with SMTP id d2e1a72fcca58-71e37987c15mr5444761b3a.12.1728666503198;
        Fri, 11 Oct 2024 10:08:23 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aaba5acsm2890345b3a.177.2024.10.11.10.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 10:08:22 -0700 (PDT)
Date: Fri, 11 Oct 2024 10:08:20 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Mark Brown <broonie@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH RFC/RFT 2/3] mm: helper `is_shadow_stack_vma` to check
 shadow stack vma
Message-ID: <ZwlbhKL7aZf+L9qa@debug.ba.rivosinc.com>
References: <20241010-shstk_converge-v1-0-631beca676e7@rivosinc.com>
 <20241010-shstk_converge-v1-2-631beca676e7@rivosinc.com>
 <ZwkAO9P3CxGbyq4L@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZwkAO9P3CxGbyq4L@finisterre.sirena.org.uk>

On Fri, Oct 11, 2024 at 11:38:51AM +0100, Mark Brown wrote:
>On Thu, Oct 10, 2024 at 05:32:04PM -0700, Deepak Gupta wrote:
>> VM_SHADOW_STACK (alias to VM_HIGH_ARCH_5) is used to encode shadow stack
>> VMA on three architectures (x86 shadow stack, arm GCS and RISC-V shadow
>> stack). In case architecture doesn't implement shadow stack, it's VM_NONE
>> Introducing a helper `is_shadow_stack_vma` to determine shadow stack vma
>> or not.
>>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> ---
>>  mm/gup.c |  2 +-
>>  mm/vma.h | 10 +++++++---
>>  2 files changed, 8 insertions(+), 4 deletions(-)
>
>As I noted in reply to the version of this patch in the RISC-V series
>there's another test for VM_SHADOW_STACK in mm/mmap.c.

Yeah will make sure to consolidate comments from both patch series in next
version. Thanks.

