Return-Path: <linux-fsdevel+bounces-62913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CC8BA5009
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 21:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12983253FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 19:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E430E2848AE;
	Fri, 26 Sep 2025 19:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRHhKXJT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C9D283CA7
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 19:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758916369; cv=none; b=F1vymPQMFU3fOBijU4q/jqqIxxWHMwKxHWPpYeOdE+4QRZlO37US/Ra7sJv9poI6fi8TrDY4Q54c4rDmezn4msATkIzMCM3JUY7w7v1Q7Mxs9/wjq6J7bhidKuVYxemJHCpBtZqAyodFEXXhqBxC6/vdQJrgmPmqW4xyK4sFPCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758916369; c=relaxed/simple;
	bh=oO+7zCRCpcn8afztGwY+HzbQXwPySfZfX7HQqZPBq4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPPR3EPHw68QJDD6WTWdblyURbO3MLUqZOevQ43PfJIKdT8udSMno4VpTddWsRWnbksxSfkQIkpxt61oVhhhQPNH0c8RRF25v06kmRuA8y5W/uSbaWmfvgWBYKuOqIOacg9qvEtAAOLXyfRg6hkfPxqcj2XEB0/zCSiHB53078A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eRHhKXJT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758916366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XHvwAIHkoSzj/0sM3EQyAOJu3zkKVKdDZuOCGzwODmg=;
	b=eRHhKXJTjouWf/y91w+UTVWCgXOMJrFz9jv7vQYWD8JbcWbZCS/7PT9iQ6P3jS4suZUuc7
	PXPNiIwyF09alRL+wqMiutZ8SkhPnGdfOY6djzTWmlxEzXm/R8spXL/QDpv0Fri4hUAAlP
	16HiBbatRZFAaMouzl6J4jKGkh1VbUg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-t223hT9KN56yp_SnsKdUYg-1; Fri,
 26 Sep 2025 15:52:43 -0400
X-MC-Unique: t223hT9KN56yp_SnsKdUYg-1
X-Mimecast-MFC-AGG-ID: t223hT9KN56yp_SnsKdUYg_1758916362
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B7A41800452;
	Fri, 26 Sep 2025 19:52:42 +0000 (UTC)
Received: from cmirabil.redhat.com (unknown [10.22.90.77])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 71B901800446;
	Fri, 26 Sep 2025 19:52:30 +0000 (UTC)
From: Charles Mirabile <cmirabil@redhat.com>
To: cmirabil@redhat.com
Cc: Liam.Howlett@oracle.com,
	a.hindborg@kernel.org,
	akpm@linux-foundation.org,
	alex.gaynor@gmail.com,
	alexghiti@rivosinc.com,
	aliceryhl@google.com,
	alistair.francis@wdc.com,
	andybnac@gmail.com,
	aou@eecs.berkeley.edu,
	arnd@arndb.de,
	atishp@rivosinc.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	bp@alien8.de,
	brauner@kernel.org,
	broonie@kernel.org,
	charlie@rivosinc.com,
	cleger@rivosinc.com,
	conor+dt@kernel.org,
	conor@kernel.org,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	david@redhat.com,
	debug@rivosinc.com,
	devicetree@vger.kernel.org,
	ebiederm@xmission.com,
	evan@rivosinc.com,
	gary@garyguo.net,
	hpa@zytor.com,
	jannh@google.com,
	jim.shu@sifive.com,
	kees@kernel.org,
	kito.cheng@sifive.com,
	krzk+dt@kernel.org,
	linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	lorenzo.stoakes@oracle.com,
	lossin@kernel.org,
	mingo@redhat.com,
	ojeda@kernel.org,
	oleg@redhat.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	peterz@infradead.org,
	pjw@kernel.org,
	richard.henderson@linaro.org,
	rick.p.edgecombe@intel.com,
	robh@kernel.org,
	rust-for-linux@vger.kernel.org,
	samitolvanen@google.com,
	shuah@kernel.org,
	tglx@linutronix.de,
	tmgross@umich.edu,
	vbabka@suse.cz,
	x86@kernel.org,
	zong.li@sifive.com
Subject: Re: [PATCH v19 00/27] riscv control-flow integrity for usermode
Date: Fri, 26 Sep 2025 15:52:24 -0400
Message-ID: <20250926195224.351862-1-cmirabil@redhat.com>
In-Reply-To: <20250926192919.349578-1-cmirabil@redhat.com>
References: <20250926192919.349578-1-cmirabil@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi -

Sorry for my previous email, I realized I was mistaken...

On Fri, Sep 26, 2025 at 03:29:19PM -0400, Charles Mirabile wrote:
> Hi - 
> 
> Hoping that I got everything right with git-send-email so that this is
> delivered alright...
> 
> Wanted to jump in to head off a potential talking past one another / 
> miscommunication situation I see here.
> 
> On Wed, Sep 24, 2025 at 08:36:11AM -0600, Paul Walmsley wrote:
> > Hi,
> > 
> > On Thu, 31 Jul 2025, Deepak Gupta wrote:
> > 
> > [ ... ]
> > 
> > > vDSO related Opens (in the flux)
> > > =================================
> > > 
> > > I am listing these opens for laying out plan and what to expect in future
> > > patch sets. And of course for the sake of discussion.
> > > 
> > 
> > [ ... ]
> > 
> > > How many vDSOs
> > > ---------------
> > > Shadow stack instructions are carved out of zimop (may be operations) and if CPU
> > > doesn't implement zimop, they're illegal instructions. Kernel could be running on
> > > a CPU which may or may not implement zimop. And thus kernel will have to carry 2
> > > different vDSOs and expose the appropriate one depending on whether CPU implements
> > > zimop or not.
> > 
> > If we merge this series without this, then when CFI is enabled in the 
> > Kconfig, we'll wind up with a non-portable kernel that won't run on older 
> > hardware.  We go to great lengths to enable kernel binary portability 
> > across the presence or absence of other RISC-V extensions, and I think 
> > these CFI extensions should be no different.
> 
> That is not true, this series does not contain the VDSO changes so it can
> be merged as is.

Oops... no sorry, it looks like it does. See 19/27. I was misled by the
cover letter which said to pick that patch separately. I completely agree
that that needs to not be included if this is to be merged.

> 
> > 
> > So before considering this for merging, I'd like to see at least an 
> > attempt to implement the dual-vDSO approach (or something equivalent) 
> > where the same kernel binary with CFI enabled can run on both pre-Zimop 
> > and post-Zimop hardware, with the existing userspaces that are common 
> > today.
> 
> I agree that when the VDSO patches are submitted for inclusion they should
> be written in a way that avoids limiting the entire kernel to either
> pre-Zimop or post-Zimop hardware based on the config, but I think it
> should be quite possible to perform e.g. runtime patching of the VDSO
> to replace the Zimop instructions with nops if the config is enabled but
> the hardware does not support Zimop.
> 
> However, that concern should not hold up this patch series. Raise it again
> when the VDSO patches are posted.

@Deepak, would it be possible to just resend this without the VDSO patch?

Or to rework as I had alluded to to check for the presense of the extension
and remove the instructions from the VDSO at boot if it is not found?

> 
> > 
> > thanks Deepak,
> > 
> > - Paul
> 
> Best - Charlie
> 

Best - Charlie


