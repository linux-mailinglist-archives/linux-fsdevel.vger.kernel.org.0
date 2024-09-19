Return-Path: <linux-fsdevel+bounces-29724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5737297CE27
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 21:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE9D1C22811
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 19:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A499B2C87C;
	Thu, 19 Sep 2024 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="MT8zbC1s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E28723759;
	Thu, 19 Sep 2024 19:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726774623; cv=none; b=b/4xME+njFdE83wn4itkbNBRjFeJwo3kfDLmKrSeiLoEzIUJZuwE3vSa0owAhvmjE3XrhBCNnuvvyU2CyJ5TRJA5SICFdDDG8lFQrUxHi1n+4siwbP1WRZVh1S9WFxt9LJnD5aAY9jDdUdy7GLKx+zMqtnbhLtv23X0AxT1hW/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726774623; c=relaxed/simple;
	bh=C+ME7fXLk6IvChq/v/YexZ5AQKs5QVOylqDE2bdhMs0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBMzQQTWjSwG/FBcC2cbcOoeJfXE7GaoUjEFBZwu3GMpTPQTRO2Bzl/RDD4hg32wQ/mqiL01pTbxM7TZZ0PKh4gKYYBfmWzDrRLcaZzjWmZc+6DSirMv29sPM5mUnbHjCqCfDs+vEyi3oV9dOTmTb90hECAxKMICNgkAXy86s+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=MT8zbC1s; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1726774618; x=1727033818;
	bh=DFBi15tweOygE7n7l7iIMTCGHcKMHtPF8B/hV9IQyg0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=MT8zbC1snKrDr+WkllpmTH2KgYxbh/bw3psX3m0wWOgtwgoy23nhavtt6uEpZMUAJ
	 B0PQ0HpASeTPtguQoQFIWYEepoh0f/YQCV4hqLDQDmcmIikKHqSUffpAImYWOS8gTC
	 Br1yySm/K2ZmZgGZRjB5vzJyix86Af2eSvbW1njeJv2XDtepHMLUlssssCsWk9/WpM
	 e0rcUhLx/pjRV850DLQZKSmVWMS0W4wiWygW1oH9doBXlcTsb35GADHo8X9ZUVnLMF
	 CF6gGAs6vn/DF8imwATwLpexJapAAnRuGv5wWmzl+rGFeESABa0ocbLAViF1Eew6Ij
	 0jW46sBYhLV7A==
Date: Thu, 19 Sep 2024 19:36:53 +0000
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Gary Guo <gary@garyguo.net>, Yiyang Wu <toolmanp@tlmp.cc>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-erofs@lists.ozlabs.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
Message-ID: <239b5d1d-64a7-4620-9075-dc645d2bab74@proton.me>
In-Reply-To: <9bbbac63-c05f-4f7b-91c2-141a93783cd3@linux.alibaba.com>
References: <20240916135634.98554-1-toolmanp@tlmp.cc> <20240916135634.98554-4-toolmanp@tlmp.cc> <20240916210111.502e7d6d.gary@garyguo.net> <2b04937c-1359-4771-86c6-bf5820550c92@linux.alibaba.com> <ac871d1e-9e4e-4d1b-82be-7ae87b78d33e@proton.me> <9bbbac63-c05f-4f7b-91c2-141a93783cd3@linux.alibaba.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 494c205a1874b0a64d5e13cf14775a4737933e3e
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.09.24 17:13, Gao Xiang wrote:
> Hi Benno,
>=20
> On 2024/9/19 21:45, Benno Lossin wrote:
>> Hi,
>>
>> Thanks for the patch series. I think it's great that you want to use
>> Rust for this filesystem.
>>
>> On 17.09.24 01:58, Gao Xiang wrote:
>>> On 2024/9/17 04:01, Gary Guo wrote:
>>>> Also, it seems that you're building abstractions into EROFS directly
>>>> without building a generic abstraction. We have been avoiding that. If
>>>> there's an abstraction that you need and missing, please add that
>>>> abstraction. In fact, there're a bunch of people trying to add FS
>>>
>>> No, I'd like to try to replace some EROFS C logic first to Rust (by
>>> using EROFS C API interfaces) and try if Rust is really useful for
>>> a real in-tree filesystem.  If Rust can improve EROFS security or
>>> performance (although I'm sceptical on performance), As an EROFS
>>> maintainer, I'm totally fine to accept EROFS Rust logic landed to
>>> help the whole filesystem better.
>>
>> As Gary already said, we have been using a different approach and it has
>> served us well. Your approach of calling directly into C from the driver
>> can be used to create a proof of concept, but in our opinion it is not
>> something that should be put into mainline. That is because calling C
>> from Rust is rather complicated due to the many nuanced features that
>> Rust provides (for example the safety requirements of references).
>> Therefore moving the dangerous parts into a central location is crucial
>> for making use of all of Rust's advantages inside of your code.
>=20
> I'm not quite sure about your point honestly.  In my opinion, there
> is nothing different to use Rust _within a filesystem_ or _within a
> driver_ or _within a Linux subsystem_ as long as all negotiated APIs
> are audited.

To us there is a big difference: If a lot of functions in an API are
`unsafe` without being inherent from the problem that it solves, then
it's a bad API.

> Otherwise, it means Rust will never be used to write Linux core parts
> such as MM, VFS or block layer. Does this point make sense? At least,
> Rust needs to get along with the existing C code (in an audited way)
> rather than refuse C code.

I am neither requiring you to write solely safe code, nor am I banning
interacting with the C side. What we mean when we talk about
abstractions is that we want to minimize the Rust code that directly
interfaces with C. Rust-to-Rust interfaces can be a lot safer and are
easier to implement correctly.

> My personal idea about Rust: I think Rust is just another _language
> tool_ for the Linux kernel which could save us time and make the
> kernel development better.

Yes, but we do have conventions, rules and guidelines for writing such
code. C code also has them. If you want/need to break them, there should
be a good reason to do so. I don't see one in this instance.

> Or I wonder why not writing a complete new Rust stuff instead rather
> than living in the C world?

There are projects that do that yes. But Rust-for-Linux is about
bringing Rust to the kernel and part of that is coming up with good
conventions and rules.

>>> For Rust VFS abstraction, that is a different and indepenent story,
>>> Yiyang don't have any bandwidth on this due to his limited time.
>>
>> This seems a bit weird, you have the bandwidth to write your own
>> abstractions, but not use the stuff that has already been developed?
>=20
> It's not written by me, Yiyang is still an undergraduate tudent.
> It's his research project and I don't think it's his responsibility
> to make an upstreamable VFS abstraction.

That is fair, but he wouldn't have to start from scratch, Wedsons
abstractions were good enough for him to write a Rust version of ext2.
In addition, tarfs and puzzlefs also use those bindings.
To me it sounds as if you have not taken the time to try to make it work
with the existing abstractions. Have you tried reaching out to Ariel? He
is working on puzzlefs and might have some insight to give you. Sadly
Wedson has left the project, so someone will have to pick up his work.

I hope that you understand that we can't have two abstractions for the
same C API. It confuses people which to use, some features might only be
available in one version and others only in the other. It would be a
total mess. It's just like the rule for no duplicated drivers that you
have on the C side.

People (mostly Wedson) also have put in a lot of work into making the
VFS abstractions good. Why ignore all of that?

>> I have quickly glanced over the patchset and the abstractions seem
>> rather immature, not general enough for other filesystems to also take
>=20
> I don't have enough time to take a full look of this patchset too
> due to other ongoing work for now (Rust EROFS is not quite a high
> priority stuff for me).
>=20
> And that's why it's called "RFC PATCH".

Yeah I saw the RFC title. I just wanted to communicate early that I
would not review it if it were a normal patch. In fact, I would advise
against taking the patch, due to the reasons I outlined.

>> advantage of them. They also miss safety documentation and are in
>=20
> I don't think it needs to be general enough, since we'd like to use
> the new Rust language tool within a subsystem.
>=20
> So why it needs to take care of other filesystems? Again, I'm not
> working on a full VFS abstriction.

And that's OK, feel free to just pick the parts of the existing VFS that
you need and extend as you (or your student) see fit. What you said
yourself is that we need a global vision for VFS abstractions. If you
only use a subset of them, then you only care about that subset, other
people can extend it if they need. If everyone would roll their own
abstractions without communicating, then how would we create a global
vision?

> Yes, this patchset is not perfect.  But I've asked Yiyang to isolate
> all VFS structures as much as possible, but it seems that it still
> touches something.

It would already be a big improvement to put the VFS structures into the
kernel crate. Because then everyone can benefit from your work.

>> general poorly documented.
>=20
> Okay, I think it can be improved then if you give more detailed hints.
>=20
>>
>> Additionally, all of the code that I saw is put into the `fs/erofs` and
>> `rust/erofs_sys` directories. That way people can't directly benefit
>> from your code, put your general abstractions into the kernel crate.
>> Soon we will be split the kernel crate, I could imagine that we end up
>> with an `fs` crate, when that happens, we would put those abstractions
>> there.
>>
>> As I don't have the bandwidth to review two different sets of filesystem
>> abstractions, I can only provide you with feedback if you use the
>> existing abstractions.
>=20
> I think Rust is just a tool, if you could have extra time to review
> our work, that would be wonderful!  Many thanks then.
>=20
> However, if you don't have time to review, IMHO, Rust is just a tool,
> I think each subsystem can choose to use Rust in their codebase, or
> I'm not sure what's your real point is?

I don't want to prevent or discourage you from using Rust in the kernel.
In fact, I can't prevent you from putting this in, since after all you
are the maintainer.
What I can do, is advise against not using abstractions. That has been
our philosophy since very early on. They are the reason that you can
write PHY drivers without any `unsafe` code whatsoever *today*. I think
that is an impressive feat and our recipe for success.

We even have this in our documentation:
https://docs.kernel.org/rust/general-information.html#abstractions-vs-bindi=
ngs

My real point is that I want Rust to succeed in the kernel. I strongly
believe that good abstractions (in the sense that you can do as much as
possible using only safe Rust) are a crucial factor.
I and others from the RfL team can help you if you (or your student)
have any Rust related questions for the abstractions. Feel free to reach
out.


Maybe Miguel can say more on this matter, since he was at the
maintainers summit, but our takeaways essentially are that we want
maintainers to experiment with Rust. And if you don't have any real
users, then breaking the Rust code is fine.
Though I think that with breaking we mean that changes to the C side
prevent the Rust side from working, not shipping Rust code without
abstractions.

We might be able to make an exception to the "your driver can only use
abstractions" rule, but only with the promise that the subsystem is
working towards creating suitable abstractions and replacing the direct
C accesses with that.

I personally think that we should not make that the norm, instead try to
create the minimal abstraction and minimal driver (without directly
calling C) that you need to start. Of course this might not work, the
"minimal driver" might need to be rather complex for you to start, but I
don't know your subsystem to make that judgement.

>>> And I _also_ don't think an incomplete ROFS VFS Rust abstraction
>>> is useful to Linux community
>>
>> IIRC Wedson created ROFS VFS abstractions before going for the full
>> filesystem. So it would definitely be useful for other read-only
>> filesystems (as well as filesystems that also allow writing, since last
>> time I checked, they often also support reading).
>=20
> Leaving aside everything else, an incomplete Rust read-only VFS
> abstraction itself is just an unsafe stuff.

I don't understand what you want to say.

>>> (because IMO for generic interface
>>> design, we need a global vision for all filesystems instead of
>>> just ROFSes.  No existing user is not an excuse for an incomplete
>>> abstraction.)
>>
>> Yes we need a global vision, but if you would use the existing
>> abstractions, then you would participate in this global vision.
>>
>> Sorry for repeating this point so many times, but it is *really*
>> important that we don't have multiple abstractions for the same thing.
>=20
> I've expressed my viewpoint.
>=20
>>
>>> If a reasonble Rust VFS abstraction landed, I think we will switch
>>> to use that, but as I said, they are completely two stories.
>>
>> For them to land, there has to be some kind of user. For example, a rust
>> reference driver, or a new filesystem. For example this one.
>=20
> Without a full proper VFS abstraction, it's just broken and
> needs to be refactored.  And that will be painful to all
> users then.

I also don't understand your point here. What is broken, this EROFS
implementation? Why will it be painful to refactor?

> =3D=3D=3D=3D=3D=3D=3D
> In the end,
>=20
> Other thoughts, comments are helpful here since I wonder how "Rust
> -for-Linux" works in the long term, and decide whether I will work
> on Kernel Rust or not at least in the short term.

The longterm goal is to make everything that is possible in C, possible
in Rust. For more info, please take a look at the kernel summit talk by
Miguel Ojeda.
However, we can only reach that longterm goal if maintainers are willing
and ready to put Rust into their subsystems (either by knowing/learning
Rust themselves or by having a co-maintainer that does just the Rust
part). So you wanting to experiment is great. I appreciate that you also
have a student working on this. Still, I think we should follow our
guidelines and create abstractions in order to require as little
`unsafe` code as possible.

---
Cheers,
Benno


