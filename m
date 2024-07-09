Return-Path: <linux-fsdevel+bounces-23364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BE992B29D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 10:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5579280CF0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 08:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4841534E7;
	Tue,  9 Jul 2024 08:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DpExboip"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CED113DB9B
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720515156; cv=none; b=iWETWT0cWx72A8JXePte9lCKiW3zKXaDjeWm/VmIq6tmP3pyLaJ8d3E7jyfKe3BnfKYkjbMez1oU6rpQZvwmY5Ckmv1fJyLL4XsM6HInqg8plq1fQNKoEHafIHmI0Vs5yDL177+btBGoAhyywd0LwGVdJGGFmRoUxmNRfT9T/3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720515156; c=relaxed/simple;
	bh=aKrbvYatQQa9iqD/RLLmut5wz3BIvGbGeZI4a400mkw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OAr9zmu/ghAVofZ21QC9TgQAN6ONKa2WmfvJE/utH25lmkRxmQhCDbcluDXwY8RZCaQrVCQmhau7sLkNfDDpU3rmrcVhgAIPX0lt5plWEfxKX/ifpv6lPcTjYphf7Oh68ljPqZ/ssBT60XasYpRZEj8qO5kLV8EUez65Qnlf8UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DpExboip; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720515154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aKrbvYatQQa9iqD/RLLmut5wz3BIvGbGeZI4a400mkw=;
	b=DpExboipbpZsb5hA8MZS+pnWqFRlcoGaoyQYP0EmXqb92Oqh1bthLAT1i4B+GL46lOt2dc
	18RfoepX6gPzhPmTzkClnv8kcxz+ZIDA6ErWrqjlg1Syawdx9VkHXgJIE7M3Umns2pJ2pG
	teS5C8LlwjlEiJI/c/WB2A4GMdS9LHs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-95z-6JRaPpWfMZk9MN0rrw-1; Tue,
 09 Jul 2024 04:52:30 -0400
X-MC-Unique: 95z-6JRaPpWfMZk9MN0rrw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A13F31958B3D;
	Tue,  9 Jul 2024 08:52:25 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.45.224.64])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDBC43000181;
	Tue,  9 Jul 2024 08:52:15 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,  Joey Gouly
 <joey.gouly@arm.com>,  dave.hansen@linux.intel.com,
  linux-arm-kernel@lists.infradead.org,  akpm@linux-foundation.org,
  aneesh.kumar@kernel.org,  aneesh.kumar@linux.ibm.com,  bp@alien8.de,
  broonie@kernel.org,  christophe.leroy@csgroup.eu,  hpa@zytor.com,
  linux-fsdevel@vger.kernel.org,  linux-mm@kvack.org,
  linuxppc-dev@lists.ozlabs.org,  maz@kernel.org,  mingo@redhat.com,
  mpe@ellerman.id.au,  naveen.n.rao@linux.ibm.com,  npiggin@gmail.com,
  oliver.upton@linux.dev,  shuah@kernel.org,  tglx@linutronix.de,
  will@kernel.org,  x86@kernel.org,  kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 17/29] arm64: implement PKEYS support
In-Reply-To: <Zoz1lbjrp+y3HXff@arm.com> (Szabolcs Nagy's message of "Tue, 9
	Jul 2024 09:32:21 +0100")
References: <20240503130147.1154804-1-joey.gouly@arm.com>
	<20240503130147.1154804-18-joey.gouly@arm.com>
	<ZlnlQ/avUAuSum5R@arm.com>
	<20240531152138.GA1805682@e124191.cambridge.arm.com>
	<Zln6ckvyktar8r0n@arm.com> <87a5jj4rhw.fsf@oldenburg.str.redhat.com>
	<ZnBNd51hVlaPTvn8@arm.com> <ZownjvHbPI1anfpM@arm.com>
	<Zoz1lbjrp+y3HXff@arm.com>
Date: Tue, 09 Jul 2024 10:52:12 +0200
Message-ID: <87ikxf0wxv.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

* Szabolcs Nagy:

>> However, does it matter much? That's only for the initial setup, the
>> user can then change the permissions directly via the sysreg. So maybe
>> we don't need all those combinations upfront. A PKEY_DISABLE_EXECUTE
>> together with the full PKEY_DISABLE_ACCESS would probably suffice.
>
> this is ok.
>
> a bit awkward in userspace when the register is directly
> set to e.g write-only and pkey_get has to return something,
> but we can handle settings outside of valid PKEY_* macros
> as unspec, users who want that would use their own register
> set/get code.
>
> i would have designed the permission to use either existing
> PROT_* flags or say that it is architectural and written to
> the register directly and let the libc wrapper deal with
> portable api, i guess it's too late now.

We can still define a portable API if we get a few more PKEY_* bits.
The last attempt stalled because the kernel does not really need them,
it would be for userspace benefit only.

For performance-critical code, pkey_get/pkey_set are already too slow,
so adding a bit more bit twiddling to it wouldn't be a proble, I think.
Applications that want to change protection key bits around a very short
code sequence will have to write the architecture-specific register.

> (the signal handling behaviour should have a control and it
> is possible to fix e.g. via pkey_alloc flags, but that may
> not be the best solution and this can be done later.)

For glibc, the POWER behavior is much more useful.

Thanks,
Florian


