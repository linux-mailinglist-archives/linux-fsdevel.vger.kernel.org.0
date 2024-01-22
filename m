Return-Path: <linux-fsdevel+bounces-8419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F268362DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 13:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5594E1F239C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 12:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CBB3BB32;
	Mon, 22 Jan 2024 12:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exia.io header.i=@exia.io header.b="GqA3/afu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from h7.fbrelay.privateemail.com (h7.fbrelay.privateemail.com [162.0.218.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B893BB21;
	Mon, 22 Jan 2024 12:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.0.218.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705925615; cv=none; b=hv79HNtHl4+hPSqVWK9WIbjdIGqyhPVRMyoOYsrTZaiKda+5KmYpzjh+KsJ9xjIySNvjAfAwruLuFWPJRAQSoPA1mhf3HdaGezY11Qlu/JbFLbJctQAibPEsPX+pQSv5p06uNjsJaeGhjDCaJ/+29CfhPQepPkx7oO3XG8BjYjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705925615; c=relaxed/simple;
	bh=E+GS8Dp2FPfxmyApAnU8fN/JeF+OsSo7QILwUiphDME=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=JFxFS1EPpfU14yMJhBz/EsuffFp+lUwy+Gqngl18Qij3mXGsk45FFgaAARHxrlcKNOQ0J4wO752EX8r6TV475DAje6yiyrlxlFx3lkJgtZ7YnQmukxu/WEKCQ2H/z5qG+mNGfVvY5qgP+7frng85vCPfavPZMywJSRyl0fBGf8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exia.io; spf=pass smtp.mailfrom=exia.io; dkim=pass (2048-bit key) header.d=exia.io header.i=@exia.io header.b=GqA3/afu; arc=none smtp.client-ip=162.0.218.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exia.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exia.io
Received: from MTA-05-3.privateemail.com (mta-05.privateemail.com [198.54.127.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by h7.fbrelay.privateemail.com (Postfix) with ESMTPSA id 08F64608CB;
	Mon, 22 Jan 2024 07:01:29 -0500 (EST)
Received: from mta-05.privateemail.com (localhost [127.0.0.1])
	by mta-05.privateemail.com (Postfix) with ESMTP id 964DE18000BB;
	Mon, 22 Jan 2024 07:01:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=exia.io; s=default;
	t=1705924881; bh=E+GS8Dp2FPfxmyApAnU8fN/JeF+OsSo7QILwUiphDME=;
	h=Date:To:From:Cc:Subject:From;
	b=GqA3/afuwdRouPoodV9R1wlpLX5b/02R1XA+chUFOm3GDzzJBCr7S5XqlmFwayahv
	 3CuADmEIdJb0qv0daT3OTWWye6iPGPzL1a0ecXMCj23Joi9MfUffzkdCiVBVPfdGw/
	 V2jq/ph8+Ubg1kQrVEk0GKr17L6NnCx3SyHYiycAMOlqzBbaEKKbSn3v1vt5W8Ue/y
	 3JYxcckn+2z8YYeC1/aMxTz/WYytsIWMi7BepkGL4sDdhhZkPLDLPHkiS0tSF4kwgI
	 J4/EWYGrNJDTZk6KUrZ/JKAlC0A9u7GO82wP+r9gQNBVprtDmVm1GXgDD5UnnowU/q
	 Gq8WLRJywFmLQ==
Received: from [192.168.1.17] (M106073142161.v4.enabler.ne.jp [106.73.142.161])
	by mta-05.privateemail.com (Postfix) with ESMTPA;
	Mon, 22 Jan 2024 07:01:13 -0500 (EST)
Message-ID: <c7209e19-89c4-446a-b364-83100e30cc00@exia.io>
Date: Mon, 22 Jan 2024 21:01:06 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ebiederm@xmission.com, keescook@chromium.org
From: Jan Bujak <j@exia.io>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Recent-ish changes in binfmt_elf made my program segfault
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

Hi.

I recently updated my kernel and one of my programs started segfaulting.

The issue seems to be related to how the kernel interprets PT_LOAD headers;
consider the following program headers (from 'readelf' of my reproduction):

Program Headers:
   Type  Offset   VirtAddr  PhysAddr  FileSiz  MemSiz   Flg Align
   LOAD  0x001000 0x10000   0x10000   0x000010 0x000010 R   0x1000
   LOAD  0x002000 0x11000   0x11000   0x000010 0x000010 RW  0x1000
   LOAD  0x002010 0x11010   0x11010   0x000000 0x000004 RW  0x1000
   LOAD  0x003000 0x12000   0x12000   0x0000d2 0x0000d2 R E 0x1000
   LOAD  0x004000 0x20000   0x20000   0x000004 0x000004 RW  0x1000

Old kernels load this ELF file in the following way ('/proc/self/maps'):

00010000-00011000 r--p 00001000 00:02 131  ./bug-reproduction
00011000-00012000 rw-p 00002000 00:02 131  ./bug-reproduction
00012000-00013000 r-xp 00003000 00:02 131  ./bug-reproduction
00020000-00021000 rw-p 00004000 00:02 131  ./bug-reproduction

And new kernels do it like this:

00010000-00011000 r--p 00001000 00:02 131  ./bug-reproduction
00011000-00012000 rw-p 00000000 00:00 0
00012000-00013000 r-xp 00003000 00:02 131  ./bug-reproduction
00020000-00021000 rw-p 00004000 00:02 131  ./bug-reproduction

That map between 0x11000 and 0x12000 is the program's '.data' and '.bss'
sections to which it tries to write to, and since the kernel doesn't map
them anymore it crashes.

I bisected the issue to the following commit:

commit 585a018627b4d7ed37387211f667916840b5c5ea
Author: Eric W. Biederman <ebiederm@xmission.com>
Date:   Thu Sep 28 20:24:29 2023 -0700

     binfmt_elf: Support segments with 0 filesz and misaligned starts

I can confirm that with this commit the issue reproduces, and with it
reverted it doesn't.

I have prepared a minimal reproduction of the problem available here,
along with all of the scripts I used for bisecting:

https://github.com/koute/linux-elf-loading-bug

You can either compile it from source (requires Rust and LLD), or there's
a prebuilt binary in 'bin/bug-reproduction` which you can run. (It's tiny,
so you can easily check with 'objdump -d' that it isn't malicious).

On old kernels this will run fine, and on new kernels it will segfault.

Thanks!


