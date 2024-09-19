Return-Path: <linux-fsdevel+bounces-29709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA37897CA57
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 15:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBAC41C22F92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 13:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D443719E83D;
	Thu, 19 Sep 2024 13:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="W/c+d0T9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2031EB5B;
	Thu, 19 Sep 2024 13:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726753566; cv=none; b=DS+jKXVSccDLN/eYpSqnzYECT6K2QLteBv/ytRzUQa/TUakQH1C2vjveq8/0+CLDni2Tzt+LqDC1vk0vZMK19BT6R9ISlKTuf3hA9+w5DweEO+HfUq27yXK4XtPaGsHbRxL+jYAxx5MXhbWLHm0wNdiNq4UzQLuC0fIVhPKqWqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726753566; c=relaxed/simple;
	bh=08Hrq/1zy42WL1U0lqBIB2EDF7K+U052L8fQ6GMV8/k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AYscFlPUeZXjyGOSELO7Rc31F6jn70nhKkRDkvdC5LYMHkHJy1WOPFXFRWAlSAYW2yvU0L/k1CVlkcNsRVqO3FohKhGV3FlIzw5gjnSE5ptDP7NtrBnUMqZ8Upt+zXmEvuIne9TllAlilgU3NTztyFnTcGg2EAIPd5rPiPiMmQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=W/c+d0T9; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1726753559; x=1727012759;
	bh=NT33HsfNCSAYhZK5GJl2I4nckfuU7LN1MNbY5TeJz/U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=W/c+d0T9UMJnzXhcPX0tffEyYNAXdVQ+ZIaXB0VTMs1MRV7bUq5IwH9btO4HfM1pJ
	 yGSUotJheJm/LCtYz6S53Q6FMYIfvb8Tv7FEwJor03A+vLxB/NOJwouepTn+dPx83z
	 cM5+ywIXqOdJrklOAEOTBTmVcm0li0VJYCOZNGV0YOgDFSk2fBea4iSpnBx+E1NBx4
	 i9YtFWce7sywTDWT7nYWo2fvilMHPrcOdMs4fdQNw7k+3+Ua0Pjr4BIw8jKepNT8ph
	 hM6CNgXzRMkHrf2kE1k8nXbQpOml2SzPCIkoZ+3yyqakRpDn+mhr45jPiecfE5R9eY
	 Mhntehp3wQNUg==
Date: Thu, 19 Sep 2024 13:45:56 +0000
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Gary Guo <gary@garyguo.net>, Yiyang Wu <toolmanp@tlmp.cc>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-erofs@lists.ozlabs.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
Message-ID: <ac871d1e-9e4e-4d1b-82be-7ae87b78d33e@proton.me>
In-Reply-To: <2b04937c-1359-4771-86c6-bf5820550c92@linux.alibaba.com>
References: <20240916135634.98554-1-toolmanp@tlmp.cc> <20240916135634.98554-4-toolmanp@tlmp.cc> <20240916210111.502e7d6d.gary@garyguo.net> <2b04937c-1359-4771-86c6-bf5820550c92@linux.alibaba.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: b8d97f78ee362a1aa80e09e4076bc52d0a830dd6
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the patch series. I think it's great that you want to use
Rust for this filesystem.

On 17.09.24 01:58, Gao Xiang wrote:
> On 2024/9/17 04:01, Gary Guo wrote:
>> Also, it seems that you're building abstractions into EROFS directly
>> without building a generic abstraction. We have been avoiding that. If
>> there's an abstraction that you need and missing, please add that
>> abstraction. In fact, there're a bunch of people trying to add FS
>=20
> No, I'd like to try to replace some EROFS C logic first to Rust (by
> using EROFS C API interfaces) and try if Rust is really useful for
> a real in-tree filesystem.  If Rust can improve EROFS security or
> performance (although I'm sceptical on performance), As an EROFS
> maintainer, I'm totally fine to accept EROFS Rust logic landed to
> help the whole filesystem better.

As Gary already said, we have been using a different approach and it has
served us well. Your approach of calling directly into C from the driver
can be used to create a proof of concept, but in our opinion it is not
something that should be put into mainline. That is because calling C
from Rust is rather complicated due to the many nuanced features that
Rust provides (for example the safety requirements of references).
Therefore moving the dangerous parts into a central location is crucial
for making use of all of Rust's advantages inside of your code.

> For Rust VFS abstraction, that is a different and indepenent story,
> Yiyang don't have any bandwidth on this due to his limited time.

This seems a bit weird, you have the bandwidth to write your own
abstractions, but not use the stuff that has already been developed?

I have quickly glanced over the patchset and the abstractions seem
rather immature, not general enough for other filesystems to also take
advantage of them. They also miss safety documentation and are in
general poorly documented.

Additionally, all of the code that I saw is put into the `fs/erofs` and
`rust/erofs_sys` directories. That way people can't directly benefit
from your code, put your general abstractions into the kernel crate.
Soon we will be split the kernel crate, I could imagine that we end up
with an `fs` crate, when that happens, we would put those abstractions
there.

As I don't have the bandwidth to review two different sets of filesystem
abstractions, I can only provide you with feedback if you use the
existing abstractions.

> And I _also_ don't think an incomplete ROFS VFS Rust abstraction
> is useful to Linux community

IIRC Wedson created ROFS VFS abstractions before going for the full
filesystem. So it would definitely be useful for other read-only
filesystems (as well as filesystems that also allow writing, since last
time I checked, they often also support reading).

> (because IMO for generic interface
> design, we need a global vision for all filesystems instead of
> just ROFSes.  No existing user is not an excuse for an incomplete
> abstraction.)

Yes we need a global vision, but if you would use the existing
abstractions, then you would participate in this global vision.

Sorry for repeating this point so many times, but it is *really*
important that we don't have multiple abstractions for the same thing.

> If a reasonble Rust VFS abstraction landed, I think we will switch
> to use that, but as I said, they are completely two stories.

For them to land, there has to be some kind of user. For example, a rust
reference driver, or a new filesystem. For example this one.

---
Cheers,
Benno


