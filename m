Return-Path: <linux-fsdevel+bounces-13888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD53A875219
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 15:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDEA11C2287D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 14:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2274082C60;
	Thu,  7 Mar 2024 14:42:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E5A1B94D;
	Thu,  7 Mar 2024 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822576; cv=none; b=aRDVNX3o4agt4JmMBYLYAzj+MDpZqHQ8QoW++ZVF8wi9xBmDwAHmjSxQ4YBY8DpXFbs/ZynAswfbXA9N0XpeaUer6gLUJYPlZnkcL+uNK1LDZVM7tKF7KRlixeNaq8ZKpKxXC9+J8E+oE6wZ+1xCWfCI907c0l7xMXmlCGuEqDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822576; c=relaxed/simple;
	bh=Hriwqv1VafwSnAEQgWhG3BftPtOdGMoUT9XyeEe3nbQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=JPtZKRfQuQlJQbNPs930+AteCp/FadmERLyZHcNx4sHzxLiVPQ9BW8HyE8+VnkztBqh07Xv9j2zsLTG5XzZ9tjSIqm+oPCPCWtVs/m33UNDMbLiAHkarR5nnLCFPt04esQL4BWL7vfU50zIZAcdA8nFApxPojmUpsoAptRh2rb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id DAC1B644CE97;
	Thu,  7 Mar 2024 15:42:50 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id CIhG1qGm-RNL; Thu,  7 Mar 2024 15:42:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 58EF0644CE96;
	Thu,  7 Mar 2024 15:42:50 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7EDauf2v-cth; Thu,  7 Mar 2024 15:42:50 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 1DE0A644CE90;
	Thu,  7 Mar 2024 15:42:50 +0100 (CET)
Date: Thu, 7 Mar 2024 15:42:49 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Linux Doc Mailing List <linux-doc@vger.kernel.org>, 
	upstream+pagemap <upstream+pagemap@sigma-star.at>, 
	adobriyan <adobriyan@gmail.com>, 
	wangkefeng wang <wangkefeng.wang@huawei.com>, 
	ryan roberts <ryan.roberts@arm.com>, hughd <hughd@google.com>, 
	peterx <peterx@redhat.com>, avagin <avagin@google.com>, 
	lstoakes <lstoakes@gmail.com>, vbabka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	usama anjum <usama.anjum@collabora.com>, 
	Jonathan Corbet <corbet@lwn.net>
Message-ID: <2055158015.23529.1709822569814.JavaMail.zimbra@nod.at>
In-Reply-To: <a73c78be-8cdc-4f0e-b72f-e5255c906a5f@redhat.com>
References: <20240306232339.29659-1-richard@nod.at> <d673247b-a67b-43e1-a947-18fdae5f0ea1@redhat.com> <1058679077.23275.1709809843605.JavaMail.zimbra@nod.at> <7d9321db-a3c1-4593-91fa-c7f97bd9eecd@redhat.com> <1525238492.23321.1709812267495.JavaMail.zimbra@nod.at> <0644814b-869b-4694-bdb1-bab4e6186136@redhat.com> <a73c78be-8cdc-4f0e-b72f-e5255c906a5f@redhat.com>
Subject: Re: [PATCH 1/2] [RFC] proc: pagemap: Expose whether a PTE is
 writable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: proc: pagemap: Expose whether a PTE is writable
Thread-Index: ALtl01Wd8Zr0Arr/iwJcm8Sl/cTDKQ==

----- Urspr=C3=BCngliche Mail -----
> Von: "David Hildenbrand" <david@redhat.com>
>> One destructive way to find out in a writable mapping if the page would
>> actually get remapped:
>>=20
>> a) Read the PFN of a virtual address using pagemap
>> b) Write to the virtual address using /proc/pid/mem
>> c) Read the PFN of a virtual address using pagemap to see if it changed
>>=20
>> If the application can be paused, you could read+write a single byte,
>> turning it non-destructive.

I'm not so sure whether this works well if a mapping is device memory or su=
ch.
=20
>> But that would still "hide" the remap-writable-type faults.

Xenomai will tell me anyway when there was a page fault while a real time t=
hread
had the CPU.
My idea was having a tool to check before the applications enters the criti=
cal phase.

>>> I fully understand that my use case is a corner case and anything but m=
ainline.
>>> While developing my debug tool I thought that improving the pagemap int=
erface
>>> might help others too.
>>=20
>> I'm fine with this (can be a helpful debugging tool for some other cases
>> as well, and IIRC we don't have another interface to introspect this),
>> as long as we properly document the corner case that there could still
>> be writefaults on some architectures when the page would not be
>> accessed/dirty yet.

Cool. :)
=20
>=20
> [and I just recall, there are some other corner cases. For example,
> pages in a shadow stack can be pte_write(), but they can only be written
> by HW indirectly when modifying the stack, and ordinary write access
> would still fault]

Yeah, I noticed this while browsing through various pte_write() implementat=
ions.
That's a tradeoff I can live with.

Thanks,
//richard

