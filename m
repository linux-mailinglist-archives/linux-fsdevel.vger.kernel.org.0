Return-Path: <linux-fsdevel+bounces-15504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B3A88F773
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 06:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099771F234AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 05:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873D34D9F5;
	Thu, 28 Mar 2024 05:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tttGRj5y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B7148CC6;
	Thu, 28 Mar 2024 05:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711605103; cv=none; b=n/qhojtqt9T1tFG2mBCeaorzfYth/UYcI5ya1A5KqtQro6crj1ap/vomDRKKxVCEIXzlhV2PLMK9wZ4CqT7d7/n6HtUqCnFVRKfDbt14n/YMauZD8H6koDzExYbiGqsOkjDVMx0z1Xn3qYwTFl1n/EoeHTCCmUpeX0GxoUKbnlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711605103; c=relaxed/simple;
	bh=6kv4U+OlSY+qlQflghGbIVo8TBSoBTX2u5cN0RYYRzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gs6SOL0529s/ol5mbkqkgdEB5weEkFfmJGoRqKvgZJ6pwKndy7UUl3f9r2HhvqrQAIF04QkWjIR4zOshLzUWtqWY1TmQC02enmEh6GtfFas0z/nzuaGRhitN/knhnHdBkTTWUNdHYF/vd8/KpsHizcx+zLAjpG6nB/y0wcpDmj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tttGRj5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4998EC43390;
	Thu, 28 Mar 2024 05:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711605102;
	bh=6kv4U+OlSY+qlQflghGbIVo8TBSoBTX2u5cN0RYYRzs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tttGRj5ylh9xVO642wPR1F2Asn5IsF3J1IDJ9pqvnIh1qj6XQgGrpl4six+k1HHRf
	 aoU7KuEjvUv5Ii9zuOT+mH6BtpmkaBTz4FcZS6L0LCZTPajk2hXlbfy/k1hVU+NZ28
	 Wg4db9y1MDaDrXtFBBEgTQekHUKH7dUpja3VbrZJgu7ADxfru+YZW5u7cB9IMMs8zC
	 mrubWP/EDVcMLefx6YTk6HA9erGzEt7LjzHG8vGbMoVsnZ2OEqqw0kIfJszeXgBiPy
	 1PPy5iqTnZAlh9yVfb4I75n6QCxgZoMfaqW4bU26A3LhUrFRRN7YufRgRneeNEP5Gc
	 5Xn0oSBC206dA==
Message-ID: <3360dba8-0fac-4126-b72b-abc036957d6a@kernel.org>
Date: Wed, 27 Mar 2024 22:51:39 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] mm/gup: consistently call it GUP-fast
To: Arnd Bergmann <arnd@arndb.de>, David Hildenbrand <david@redhat.com>,
 peterx <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-mm@kvack.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 x86@kernel.org, Ryan Roberts <ryan.roberts@arm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Matt Turner <mattst88@gmail.com>,
 Vineet Gupta <vgupta@kernel.org>, Alexey Brodkin <abrodkin@synopsys.com>
References: <20240327130538.680256-1-david@redhat.com> <ZgQ5hNltQ2DHQXps@x1n>
 <3922460a-4d01-4ecb-b8c5-7c57fd46f3fd@redhat.com>
 <dc1433ea-4e59-4ab7-83fb-23b393020980@app.fastmail.com>
Content-Language: en-US
From: Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <dc1433ea-4e59-4ab7-83fb-23b393020980@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

+CC Alexey

On 3/27/24 09:22, Arnd Bergmann wrote:
> On Wed, Mar 27, 2024, at 16:39, David Hildenbrand wrote:
>> On 27.03.24 16:21, Peter Xu wrote:
>>> On Wed, Mar 27, 2024 at 02:05:35PM +0100, David Hildenbrand wrote:
>>>
>>> I'm not sure what config you tried there; as I am doing some build tests
>>> recently, I found turning off CONFIG_SAMPLES + CONFIG_GCC_PLUGINS could
>>> avoid a lot of issues, I think it's due to libc missing.  But maybe not the
>>> case there.
>> CCin Arnd; I use some of his compiler chains, others from Fedora directly. For
>> example for alpha and arc, the Fedora gcc is "13.2.1".
>> But there is other stuff like (arc):
>>
>> ./arch/arc/include/asm/mmu-arcv2.h: In function 'mmu_setup_asid':
>> ./arch/arc/include/asm/mmu-arcv2.h:82:9: error: implicit declaration of 
>> function 'write_aux_reg' [-Werro
>> r=implicit-function-declaration]
>>     82 |         write_aux_reg(ARC_REG_PID, asid | MMU_ENABLE);
>>        |         ^~~~~~~~~~~~~
> Seems to be missing an #include of soc/arc/aux.h, but I can't
> tell when this first broke without bisecting.

Weird I don't see this one but I only have gcc 12 handy ATM.

    gcc version 12.2.1 20230306 (ARC HS GNU/Linux glibc toolchain -
build 1360)

I even tried W=1 (which according to scripts/Makefile.extrawarn) should
include -Werror=implicit-function-declaration but don't see this still.

Tomorrow I'll try building a gcc 13.2.1 for ARC.


>
>> or (alpha)
>>
>> WARNING: modpost: "saved_config" [vmlinux] is COMMON symbol
>> ERROR: modpost: "memcpy" [fs/reiserfs/reiserfs.ko] undefined!
>> ERROR: modpost: "memcpy" [fs/nfs/nfs.ko] undefined!
>> ERROR: modpost: "memcpy" [fs/nfs/nfsv3.ko] undefined!
>> ERROR: modpost: "memcpy" [fs/nfsd/nfsd.ko] undefined!
>> ERROR: modpost: "memcpy" [fs/lockd/lockd.ko] undefined!
>> ERROR: modpost: "memcpy" [crypto/crypto.ko] undefined!
>> ERROR: modpost: "memcpy" [crypto/crypto_algapi.ko] undefined!
>> ERROR: modpost: "memcpy" [crypto/aead.ko] undefined!
>> ERROR: modpost: "memcpy" [crypto/crypto_skcipher.ko] undefined!
>> ERROR: modpost: "memcpy" [crypto/seqiv.ko] undefined!

Are these from ARC build or otherwise ?

Thx,
-Vineet

