Return-Path: <linux-fsdevel+bounces-71811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D95ACD422A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Dec 2025 16:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 696F13004784
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Dec 2025 15:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E631F151C;
	Sun, 21 Dec 2025 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="d4LBr66A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A34D282EB
	for <linux-fsdevel@vger.kernel.org>; Sun, 21 Dec 2025 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766331032; cv=none; b=M07EOmuwZ7KzDa1bWYoAM3TC8QWFvG0Uu/S9q1lEnQQG7dB+JogmX2beHjOY+ZbAMa/2b4Nu2zrZ23Neo4aqe1btQr7pwss6ofxleBR6ofhqPX7WEnRL1hqTlCMVonqzNwtPLIsZinI93bKJIv1JbkoXLIGnB4eVKXCGCDbPT5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766331032; c=relaxed/simple;
	bh=9jRXzqdm+O8sCU9dSss5nSLGK1fQA5oef6IwJ8MUb7Y=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=sFq0Uy2aEx+Bj+mqYx2HHAQa2dG6BK+69Tw7SM80PkuuT7VYSaVLNnuqCH3XiDmEvNCP2y+OXLfyBiXxeJ5P5fZJ1mKEvwMlxdRICw/ayNaECTcikMxrTTUy1DxgIvxsl5yWTd6Zln9GS7KKa7rY+zLDPwZ4PZ/xiteSMlO1mV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=d4LBr66A; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5BLFQAQb2906325
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 21 Dec 2025 07:26:11 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5BLFQAQb2906325
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025112201; t=1766330779;
	bh=jlKsAFeaIV2hMkoHG30hkHGQj8Sy9Pccwd7CmoKW274=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=d4LBr66A/lMYsQQUrfpraHzgjeSyK6794g+KDFvXyLiRZzLUKCZVKw68GdUqnufZZ
	 +NAvFJ1Tc1JY5HEDmF0egLxtTnk8IAec4qisamrjj52wF9Zyd4QozYprO+iiGUZQJU
	 c2fm+Em7HTcQi1P/wvEzvyQwP9GZuEEsuyscS4GLVm8IDRc8zdqM36lHHl3R5uLzaZ
	 l6bZyDuDsP+7ONg1mrdK0BrGIdBfrsgOE07sYDDOHVvHchBTA+qa7DJxFrF2DMYbxm
	 Nho6yO0DvkfLBbFDJfdtimxRjHn09lg7IcBD3DPpHB3/L17Ujb74vSiGQta0IdSzu5
	 LQhxq3/8OdW4Q==
Date: Sun, 21 Dec 2025 07:26:10 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Arnd Bergmann <arnd@kernel.org>, linux-mm@kvack.org
CC: Andrew Morton <akpm@linux-foundation.org>,
        Andreas Larsson <andreas@gaisler.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthew Wilcox <willy@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Michal Simek <monstr@monstr.eu>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Nishanth Menon <nm@ti.com>, Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 1/4] arch/*: increase lowmem size to avoid highmem use
User-Agent: K-9 Mail for Android
In-Reply-To: <4aecb94f-e283-4720-96e5-1837352c3329@kernel.org>
References: <20251219161559.556737-1-arnd@kernel.org> <20251219161559.556737-2-arnd@kernel.org> <a3f22579-13ee-4479-a5fd-81c29145c3f3@intel.com> <bad18ad8-93e8-4150-a85e-a2852e243363@app.fastmail.com> <a2ce2849-e572-404c-9713-9283a43c09fe@intel.com> <4aecb94f-e283-4720-96e5-1837352c3329@kernel.org>
Message-ID: <D1726374-3075-47CF-B2FF-FBAC11BC962C@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On December 21, 2025 1:30:15 AM PST, "David Hildenbrand (Red Hat)" <david@k=
ernel=2Eorg> wrote:
>On 12/19/25 21:52, Dave Hansen wrote:
>> On 12/19/25 12:20, Arnd Bergmann wrote:
>>>> For simplicity, I think this can just be:
>>>>=20
>>>> -	default VMSPLIT_3G
>>>> +	default VMSPLIT_2G
>>>>=20
>>>> I doubt the 2G vs=2E 2G_OPT matters in very many cases=2E If it does,=
 folks
>>>> can just set it in their config manually=2E
>>>>=20
>>>> But, in the end, I don't this this matters all that much=2E If you th=
ink
>>>> having x86 be consistent with ARM, for example, is more important and
>>>> ARM really wants this complexity, I can live with it=2E
>>> Yes, I think we do want the default of VMSPLIT_3G_OPT for
>>> configs that have neither highmem nor lpae, otherwise the most
>>> common embedded configs go from 3072 MiB to 1792 MiB of virtual
>>> addressing, and that is much more likely to cause regressions
>>> than the 2816 MiB default=2E
>>>=20
>>> It would be nice to not need the VMSPLIT_2G default for PAE/LPAE,
>>> but that seems like a larger change=2E
>>=20
>> The only thing we'd "regress" would be someone who is repeatedly
>> starting from scratch with a defconfig and expecting defconfig to be th=
e
>> same all the time=2E I honestly think that's highly unlikely=2E
>>=20
>> If folks are upgrading and _actually_ exposed to regressions, they've
>> got an existing config and won't be hit by these defaults at *all*=2E T=
hey
>> won't actually regress=2E
>>=20
>> In other words, I think we can be a lot more aggressive about defaults
>> than with the feature set we support=2E I'd much rather add complexity =
in
>> here for solving a real problem, like if we have armies of 32-bit x86
>> users constantly starting new projects from scratch and using defconfig=
s=2E
>>=20
>> I'd _really_ like to keep the defaults as simple as possible=2E
>
>I agree with that=2E In particular in areas where there is the chance tha=
t we could count the number of people that actually care about that with on=
e hand (in binary ;) )=2E
>

So, maximum 31? ;)

