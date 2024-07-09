Return-Path: <linux-fsdevel+bounces-23367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E9692B4AB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 12:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 281D428619F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 10:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49523156646;
	Tue,  9 Jul 2024 10:04:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41908155725;
	Tue,  9 Jul 2024 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519448; cv=none; b=djcUnJFeTNFp/yo5mVFywwNVTm5OTOJ9G7HkHx9w3L5z9bTmW5aFyZd8BEJCKpVH7A8zg8DhpD6Xh0chLXS7x6h1yt+qBFeAlAtuHOOOePercsb2DXQaWQJE262Hp90eDHQ+5A2sXE8iXM+itApIAyLScN+U3cvnBDvbLRptG5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519448; c=relaxed/simple;
	bh=UG06XE/wrNje1GxMLozW0TRTmIefwRDVuD1S9dkvSOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eL08WRT0taaONlTRUNsxthLBYGCsrq2uSjp2BkCOrMlq9GbSLUMtlQPp/OCTi2yoCEfC0rmL0gXpJEiwI1kCS+OZMhU9KY8tfAKI0JK7wN+URV7p7L6vbuVcdXbwqvl/iUT2VFt4UWy1U9CZDmweaVBfgqDOZYCEQYIFuooZ6LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1B1412FC;
	Tue,  9 Jul 2024 03:04:30 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D76AD3F762;
	Tue,  9 Jul 2024 03:04:03 -0700 (PDT)
Date: Tue, 9 Jul 2024 11:04:00 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FYI: path walking optimizations pending for 6.11
Message-ID: <Zo0LECcBUElkHPGs@J2N7QTR9R3>
References: <CAHk-=whHvMbfL2ov1MRbT9QfebO2d6-xXi1ynznCCi-k_m6Q0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whHvMbfL2ov1MRbT9QfebO2d6-xXi1ynznCCi-k_m6Q0w@mail.gmail.com>

Hi Linus,

On Wed, Jun 19, 2024 at 01:25:02PM -0700, Linus Torvalds wrote:
> I've pushed out four branches based on 6.10-rc4, because I think it's
> pretty ready. But I'll rebase them if people have commentary that
> needs addressing, so don't treat them as some kind of stable base yet.
> My plan is to merge them during the next merge window unless somebody
> screams.
> 
> The branches are:
> 
> arm64-uaccess:
>     arm64: access_ok() optimization
>     arm64: start using 'asm goto' for put_user()
>     arm64: start using 'asm goto' for get_user() when available

> runtime-constants:
>     arm64: add 'runtime constant' support
>     runtime constants: add x86 architecture support
>     runtime constants: add default dummy infrastructure
>     vfs: dcache: move hashlen_hash() from callers into d_hash()

Apologies, the arm64 branches/patches have been on my TODO list for
review/test/benchmark for the last couple of weeks, but I haven't had
both the time and machine availability to do so.

Looking at the arm64 runtime constants patch, I see there's a redundant
store in __runtime_fixup_16(), which I think is just a leftover from
applying the last roudn or feedback:

+/* 16-bit immediate for wide move (movz and movk) in bits 5..20 */
+static inline void __runtime_fixup_16(__le32 *p, unsigned int val)
+{
+	u32 insn = le32_to_cpu(*p);
+	insn &= 0xffe0001f;
+	insn |= (val & 0xffff) << 5;
+	*p = insn;
+	*p = cpu_to_le32(insn);
+}

... i.e. the first assignment to '*p' should go; the compiler should be
smart enough to elide it entirely, but it shouldn't be there.

For the sake of review, would you be happy to post the uaccess and
runtime-constants patches to the list again? I think there might be some
remaining issues with (real) PAN and we might need to do a bit more
preparatory work there.

Mark.

