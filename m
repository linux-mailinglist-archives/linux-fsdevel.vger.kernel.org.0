Return-Path: <linux-fsdevel+bounces-63115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0ACBACA96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 13:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581854828C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 11:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DE224467E;
	Tue, 30 Sep 2025 11:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FenXSiBb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B13F2F4A1D
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 11:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759230965; cv=none; b=RkBXlSnn6Zm4GLDr1ZIwDj8bAX2wNO+mZ44RXZbo2JGjzNPlsGjoZ4yUKyXOrno/bp76OAzClaq2B1pOjkTC+2vIF1LcoofKHtkvIf+Wui2SnXk9OePqBOqUkBK6PrJZt3MzVWwala3DilxgRAqshuERQkImUAClZxUPMxIkOFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759230965; c=relaxed/simple;
	bh=8V4GgwEO++Ce8hUatVMIQ/GshH7wdH34txBzsQRlSoA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lveu5oLwRE7Zu8wFRbHwXEJXjgq403viMn4dWaNkdeywxJV+q9W2NyQZPwOuw3DaRiq5IJlh49MuHzBLkrMR/wfKqkI9eR4LtMe881aF8z4PRXzTn9/k8MrTSJ+KGiV9BSdU1dc5pFPCV4IQpR+zSkXcWHky4o03w5KMipPxUcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FenXSiBb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759230963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEOnnvfg2VP9jFylWLMcLAcGpm2F4oh7aBv+d9st9Ec=;
	b=FenXSiBbgJqyd4RBytIyHX33Rm3X0YLVpH3Je0HZFXybPfGA0Nvcjl6Nn78vicz9fdBc4z
	4qvqjlFn1olQdR9uKct1ZkTZSgOn3sFfPnA02DG2UXCRZNsT4g5VTCDPe+0i7wk6jvBWEX
	IuXvsidA3DyDAFBW4JC3RKNxm6298lE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-2CvSDyiXOYen3hR5ZWAO6g-1; Tue,
 30 Sep 2025 07:15:57 -0400
X-MC-Unique: 2CvSDyiXOYen3hR5ZWAO6g-1
X-Mimecast-MFC-AGG-ID: 2CvSDyiXOYen3hR5ZWAO6g_1759230955
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AD1C1800365;
	Tue, 30 Sep 2025 11:15:55 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.33.56])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 018161800447;
	Tue, 30 Sep 2025 11:15:34 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Deepak Gupta <debug@rivosinc.com>
Cc: Paul Walmsley <pjw@kernel.org>,  Thomas Gleixner <tglx@linutronix.de>,
  Ingo Molnar <mingo@redhat.com>,  Borislav Petkov <bp@alien8.de>,  Dave
 Hansen <dave.hansen@linux.intel.com>,  x86@kernel.org,  "H. Peter Anvin"
 <hpa@zytor.com>,  Andrew Morton <akpm@linux-foundation.org>,  "Liam R.
 Howlett" <Liam.Howlett@oracle.com>,  Vlastimil Babka <vbabka@suse.cz>,
  Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,  Paul Walmsley
 <paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>,  Albert
 Ou <aou@eecs.berkeley.edu>,  Conor Dooley <conor@kernel.org>,  Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Arnd
 Bergmann <arnd@arndb.de>,  Christian Brauner <brauner@kernel.org>,  Peter
 Zijlstra <peterz@infradead.org>,  Oleg Nesterov <oleg@redhat.com>,  Eric
 Biederman <ebiederm@xmission.com>,  Kees Cook <kees@kernel.org>,  Jonathan
 Corbet <corbet@lwn.net>,  Shuah Khan <shuah@kernel.org>,  Jann Horn
 <jannh@google.com>,  Conor Dooley <conor+dt@kernel.org>,  Miguel Ojeda
 <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,  Boqun Feng
 <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6?=
 =?utf-8?Q?rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  Andreas Hindborg <a.hindborg@kernel.org>,
  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross <tmgross@umich.edu>,
  Benno Lossin <lossin@kernel.org>,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-mm@kvack.org,
  linux-riscv@lists.infradead.org,  devicetree@vger.kernel.org,
  linux-arch@vger.kernel.org,  linux-doc@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  alistair.francis@wdc.com,
  richard.henderson@linaro.org,  jim.shu@sifive.com,  Andy Chiu
 <andybnac@gmail.com>,  kito.cheng@sifive.com,  charlie@rivosinc.com,
  atishp@rivosinc.com,  evan@rivosinc.com,  cleger@rivosinc.com,
  alexghiti@rivosinc.com,  samitolvanen@google.com,  broonie@kernel.org,
  rick.p.edgecombe@intel.com,  rust-for-linux@vger.kernel.org,  Zong Li
 <zong.li@sifive.com>,  David Hildenbrand <david@redhat.com>,  Heinrich
 Schuchardt <heinrich.schuchardt@canonical.com>,  bharrington@redhat.com,
  Aurelien Jarno <aurel32@debian.org>, bergner@tenstorrent.com,
 jeffreyalaw@gmail.com
Subject: Re: [PATCH v19 00/27] riscv control-flow integrity for usermode
In-Reply-To: <aNQ7D6_ZYMhCdkmL@debug.ba.rivosinc.com> (Deepak Gupta's message
	of "Wed, 24 Sep 2025 11:40:15 -0700")
References: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
	<f953ee7b-91b3-f6f5-6955-b4a138f16dbc@kernel.org>
	<aNQ7D6_ZYMhCdkmL@debug.ba.rivosinc.com>
Date: Tue, 30 Sep 2025 13:15:32 +0200
Message-ID: <lhuldlwgpij.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

* Deepak Gupta:

> Any distro who is shipping userspace (which all of them are) along
> with kernel will not be shipping two different userspaces (one with
> shadow stack and one without them). If distro are shipping two
> different userspaces, then they might as well ship two different
> kernels. Tagging some distro folks here to get their take on shipping
> different userspace depending on whether hardware is RVA23 or
> not. @Heinrich, @Florian, @redbeard and @Aurelien.
>
> Major distro's have already drawn a distinction here that they will drop
> support for hardware which isn't RVA23 for the sake of keeping binary
> distribution simple.

The following are just my personal thoughts.

For commercial distributions, I just don't see how things work out if
you have hardware that costs less than (say) $30 over its lifetime, and
you want LTS support for 10+ years.  The existing distribution business
models aren't really compatible with such low per-node costs.  So it
makes absolute sense for distributions to target more powerful cores,
and therefore require RVA23.  Nobody is suggesting that mainstream
distributions should target soft-float, either.

For community distributions, it is a much tougher call.  Obsoleting
virtually all existing hardware sends a terrible signal to early
supporters of the architecture.  But given how limited the RISC-V
baseline ISA is, I'm not sure if there is much of a choice here.  Maybe
it's possible to soften the blow by committing to (say) two more years
of baseline ISA support, and then making the switch, assuming that RVA23
hardware for local installation is widely available by then.

However, my real worry is that in the not-too-distant future, another
ISA transition will be required after RVA23.  This is not entirely
hypothetical because RVA23 is still an ISA designed mostly for C (at
least in the scalar space, I don't know much about the vector side).
Other architectures carry forward support for efficient overflow
checking (as required by Ada and some other now less-popular languages,
and as needed for efficiently implementing fixnums with arbitrary
precision fallback).  Considering current industry trends, it is not
inconceivable that these ISA features become important again in the near
term.

You can see the effect of native overflow checking support if you look
at Ada code examples with integer arithmetic.  For example, this:

function Fib (N: Integer) return Integer is
begin
   if N <= 1 then
      return N;
   else
      return Fib (N - 1) + Fib (N - 2);
   end if;
end;

produces about 370 RISC-V instructions with -gnato, compared to 218
instructions with -gnato0 and overflow checking disabled (using GCC
trunk).  For GCC 15, the respective instruction counts are 301 and 258
for x86-64, and 288 and 244 for AArch64.  RVA23 reduces the instruction
count with overflow checking to 353.  A further reduction should be
possible once GCC starts using xnor in its overflow checks, but I expect
that the overhead from overflow checking will remain high.

Thanks,
Florian


