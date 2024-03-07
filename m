Return-Path: <linux-fsdevel+bounces-13865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E80F5874D14
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 12:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1975283D7F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 11:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1881292F9;
	Thu,  7 Mar 2024 11:10:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CD612838A;
	Thu,  7 Mar 2024 11:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809850; cv=none; b=UdOJxNodctoULMKrtZPZwGynz1W8J5WayrCmVTnR+48O8A8iyCPzXZPF/CLwRDzeKhaAOGG39yyYQMS3tu5AdYzN1ZOL6M9yxjkDm7Z9T14at4oN3IE1cKcbNHFnqrrAlj5AVkVbHrOS7I49ou8MGKl4SsuQ4inukmlBN5z7d80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809850; c=relaxed/simple;
	bh=m8Oa2/VYa0ptS2XoYMqcLZ2FrU8+142wWfYUZUWN320=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=qJxsqUFBCxZa2rpMSAcqATJmnrpaLywNZnKpWw7WfmkSb1UNThOcHcd/oWje4sIavQ4OOWRAn1mE7UHGCNV/7Qgp0xeZ/o/HhuJpcOBXaNp06DusOJd3V+FVzOiG6z+CBqDF51T6tC9bnq0vs2T+YDkzTQ/XDT7br6ZpsXcrKOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id A40EC644CE7E;
	Thu,  7 Mar 2024 12:10:44 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id bXZLWalnL1O8; Thu,  7 Mar 2024 12:10:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 09263644CE8A;
	Thu,  7 Mar 2024 12:10:44 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NBLkt6calHPY; Thu,  7 Mar 2024 12:10:43 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id BDCAF644CE7E;
	Thu,  7 Mar 2024 12:10:43 +0100 (CET)
Date: Thu, 7 Mar 2024 12:10:43 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Linux Doc Mailing List <linux-doc@vger.kernel.org>, 
	upstream+pagemap@sigma-star.at, adobriyan@gmail.com, 
	wangkefeng wang <wangkefeng.wang@huawei.com>, 
	ryan roberts <ryan.roberts@arm.com>, hughd@google.com, 
	peterx@redhat.com, avagin@google.com, lstoakes@gmail.com, 
	vbabka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	usama anjum <usama.anjum@collabora.com>, 
	Jonathan Corbet <corbet@lwn.net>
Message-ID: <1058679077.23275.1709809843605.JavaMail.zimbra@nod.at>
In-Reply-To: <d673247b-a67b-43e1-a947-18fdae5f0ea1@redhat.com>
References: <20240306232339.29659-1-richard@nod.at> <d673247b-a67b-43e1-a947-18fdae5f0ea1@redhat.com>
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
Thread-Index: XSyjIW0X6vSwMkWWDv+zJYc006jxkw==

----- Urspr=C3=BCngliche Mail -----
> Von: "David Hildenbrand" <david@redhat.com>
> But why is that required? What is the target use case? (I did not get
> the cover letter in my inbox)
>=20
> We're running slowly but steadily out of bits, so we better make wise
> decisions.
>=20
> Also, consider: Architectures where the dirty/access bit is not HW
> managed could indicate "writable" here although we *will* get a page
> fault to set the page dirty/accessed.

I'm currently investigating why a real-time application faces unexpected
page faults. Page faults are usually fatal for real-time work loads because
the latency constraints are no longer met.

So, I wrote a small tool to inspect the memory mappings of a process to fin=
d
areas which are not correctly pre-faulted. While doing so I noticed that
there is currently no way to detect CoW mappings.
Exposing the writable property of a PTE seemed like a good start to me.

> So best this can universally do is say "this PTE currently has write
> permissions".

Ok.

Thanks,
//richard

