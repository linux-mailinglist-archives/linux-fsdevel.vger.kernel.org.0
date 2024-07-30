Return-Path: <linux-fsdevel+bounces-24620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A579417B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 18:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EDEB1F217A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 16:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDFB1917D8;
	Tue, 30 Jul 2024 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b="ciKouVi4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826A318E02C
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.179.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355880; cv=none; b=p5H4eKyHYMjX+rDv4PgzqvJDuJrKOG8Be42azDQ2ZsHYV8e4cGY1Uh/23mAyGr4Re7oFwu35vZv9r14lylJO4tQq/hVXzCODTA5nOkpz3IhifqmANaY3tUFezlcnR8RGX0ShUQjCs79ehNspyCXWLGZHKBBOnTEgPZZ8YAct334=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355880; c=relaxed/simple;
	bh=oSyIak7MrCRTahFcJ8npYG+FPdiKa6Mr/cx1rCpCE5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZMaeioAWmZV4nUYPjALbZHQrgoDNOdVXpXXQlXNZGZgnYRQdwGE+y/jzI3mEvT49agB3OPZsCQbgc3DQNJ/UmTlfh8U0iuOjBqX1SmM/h1Bfb2OTnH2GYV7ePnt2bqVTbawoSqLn8VDw4iDOouJ6B2O0Busf/zdKwlFhyYPOFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu; spf=pass smtp.mailfrom=cs.ucla.edu; dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b=ciKouVi4; arc=none smtp.client-ip=131.179.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.ucla.edu
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id CA7D73C00F4E3;
	Tue, 30 Jul 2024 09:11:17 -0700 (PDT)
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10032) with ESMTP
 id Pl_YaaNZWRvT; Tue, 30 Jul 2024 09:11:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 7B4F63C01409F;
	Tue, 30 Jul 2024 09:11:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu 7B4F63C01409F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
	s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1722355877;
	bh=95K7GQZ+ry1mpvubcchKwK+jM9LD0UqDXJ4srSr3GMc=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=ciKouVi45ujSQlY96FckO5hI0MgoPIV+MQKT3iEMTpRRgwR0hf2DEF8dzj6518Jt1
	 VO3oT/R9peP7wGJbyjBLFNSbxtnTYb5L2Pe5oj2gWeucDkffI+6kiCpB43Z3Guv9d6
	 wNpH3MlO2VD20+XyKjLGOZrAvxR1BnRxctpz58gZuP5ooLx0c6Lom7Irv1vf+ZEcVZ
	 HpaXtw8yv+2hVv+84QN8jevmF0tstYd7ZIp74KFefkmaXmszoxum3+b8lyROBy7ltZ
	 dTAgG4RAVBlz0x81h5PJmL6jnKXt/Dn6ARbHswp1o/Pki8zzwWxgg47PpWGVmo9J9G
	 YOI6bK1TsfEWw==
X-Virus-Scanned: amavis at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id BtG4NkO3cxMA; Tue, 30 Jul 2024 09:11:17 -0700 (PDT)
Received: from [192.168.254.12] (unknown [47.154.17.165])
	by mail.cs.ucla.edu (Postfix) with ESMTPSA id 533E13C00F4E3;
	Tue, 30 Jul 2024 09:11:17 -0700 (PDT)
Message-ID: <e2fe77d0-ffa6-42d1-a589-b60304fd46e9@cs.ucla.edu>
Date: Tue, 30 Jul 2024 09:11:17 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: posix_fallocate behavior in glibc
To: Christoph Hellwig <hch@lst.de>, Florian Weimer <fweimer@redhat.com>
Cc: libc-alpha@sourceware.org, linux-fsdevel@vger.kernel.org,
 Trond Myklebust <trondmy@hammerspace.com>
References: <20240729160951.GA30183@lst.de>
 <87a5i0krml.fsf@oldenburg.str.redhat.com> <20240729184430.GA1010@lst.de>
 <877cd4jajz.fsf@oldenburg.str.redhat.com> <20240729190100.GA1664@lst.de>
 <8734nsj93p.fsf@oldenburg.str.redhat.com> <20240730154730.GA30157@lst.de>
Content-Language: en-US
From: Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
In-Reply-To: <20240730154730.GA30157@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-07-30 08:47, Christoph Hellwig wrote:
> On Mon, Jul 29, 2024 at 09:23:22PM +0200, Florian Weimer wrote:
>> Anything that's not EOPNOTSUPP will do.  EMEDIUMTYPE or ENOTBLK might do
>> it.  Any of the many STREAMS error codes could also be re-used quite
>> safely because Linux doesn't do STREAMS.
> 
> Huh?  EOPNOTSUP(P) is the standard error code in Posix for operation
> not supported, and clearly documented as such in the Linux man page
> (for musl).  A totally random new error code doesn't really help us.

It would help glibc distinguish the following cases:

A. file systems whose internal structure supports the semantics of 
posix_fallocate, and where user-mode code can approximate those 
semantics by writing zeros, but where that feature has not been 
implemented in the kernel's file system code so the system call 
currently fails with EOPNOTSUPP.

B. file systems whose internal structure cannot support the semantics of 
posix_fallocate and you cannot approximate them, and where the system 
call currently fails with EOPNOTSUPP.

Florian is proposing that different error numbers be returned for (A) vs 
(B) so that glibc posix_fallocate can treat the cases differently.


>> If you remove the fallback code, applications need to be taught about
>> EOPNOTSUPP, so that doesn't really make a difference.
> 
> Portable software can't assume that posix_fallocate actually does
> anything.

Of course, but this issue is about whether glibc posix_fallocate should 
continue to work on type (A) file systems. It's understandable that 
glibc maintainers would be reluctant to mess with that longstanding 
behavior.

