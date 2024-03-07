Return-Path: <linux-fsdevel+bounces-13870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EA2874E48
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 12:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC2F28472F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 11:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F43D12C819;
	Thu,  7 Mar 2024 11:51:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691AE12AAF3;
	Thu,  7 Mar 2024 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709812273; cv=none; b=RkHPpsCHQyDahZjsGzTUPRaaamQ5v8ZPIq8PRWZyl0iVCg7x+Yb5tPhJ9iyAmEhQEc3Lz2Z+6NYX0XYEIHRZfDr/0vtmkCnSe6nH7xeCDCuY/GtaLmOitN93dKZEdTcYq9vfvF0gbEyAO1t2ymcfZmiGfxIUob3fHkcr4LUNeuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709812273; c=relaxed/simple;
	bh=Zmu5uMIZDi7UNA1wCNOlWfc1y0uv4VP1QuGxQKiV3nw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=YEDSYFMdPfddg84lxETVyegVO7h4XZkRZVHMmFrH82aWHozXpdigenmZBwG27xnTyHh+Eo2lNx4x7QADwNz5Bd15dJAVjiEN3HUt5/SxTc2z2JIcsDllJmOal8d+5FG9cuNk2YVHsyD/NrnXTLRBtlu+4Js0tOlkNveKlOZxG9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 84821644CE90;
	Thu,  7 Mar 2024 12:51:08 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Tmxdw1VxKfDn; Thu,  7 Mar 2024 12:51:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id EB46A644CE95;
	Thu,  7 Mar 2024 12:51:07 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lkpkYE8omJqX; Thu,  7 Mar 2024 12:51:07 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id B2713644CE90;
	Thu,  7 Mar 2024 12:51:07 +0100 (CET)
Date: Thu, 7 Mar 2024 12:51:07 +0100 (CET)
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
Message-ID: <1525238492.23321.1709812267495.JavaMail.zimbra@nod.at>
In-Reply-To: <7d9321db-a3c1-4593-91fa-c7f97bd9eecd@redhat.com>
References: <20240306232339.29659-1-richard@nod.at> <d673247b-a67b-43e1-a947-18fdae5f0ea1@redhat.com> <1058679077.23275.1709809843605.JavaMail.zimbra@nod.at> <7d9321db-a3c1-4593-91fa-c7f97bd9eecd@redhat.com>
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
Thread-Index: Q0zWB5x1mF33ot5wjbCf6WpNKPSWOg==

----- Urspr=C3=BCngliche Mail -----
> Von: "David Hildenbrand" <david@redhat.com>
>> I'm currently investigating why a real-time application faces unexpected
>> page faults. Page faults are usually fatal for real-time work loads beca=
use
>> the latency constraints are no longer met.
>=20
> Are you concerned about any type of page fault, or are things like a
> simple remapping of the same page from "read-only to writable"
> acceptable? ("very minor fault")

Any page fault has to be avoided.
To give you more background, the real time application runs on Xenomai,
a real time extension for Linux.
Xenomai applies already many tweaks to the kernel to trigger pre-faulting o=
f
memory areas. But sometimes the application does not use the Xenomai API
correctly or there is an bug in Xenomai it self.
Currently I'm suspecting the latter.
=20
>>=20
>> So, I wrote a small tool to inspect the memory mappings of a process to =
find
>> areas which are not correctly pre-faulted. While doing so I noticed that
>> there is currently no way to detect CoW mappings.
>> Exposing the writable property of a PTE seemed like a good start to me.
>=20
> Is it just about "detection" for debugging purposes or about "fixup" in
> running applications?

It's only about debugging. If an application fails a test I want to have
a tool which tells me what memory mappings are wonky or could cause a fault
at runtime.

I fully understand that my use case is a corner case and anything but mainl=
ine.
While developing my debug tool I thought that improving the pagemap interfa=
ce
might help others too.

Thanks,
//richard

