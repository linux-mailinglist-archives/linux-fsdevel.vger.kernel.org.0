Return-Path: <linux-fsdevel+bounces-4257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5055D7FE364
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 23:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A8128188A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27B047A54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b="VkHLvbJB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85D28F
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 13:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spawn.link;
	s=protonmail3; t=1701293967; x=1701553167;
	bh=IB85iVeEAyIjhyVHOqPfYbx4F1D0n+/7RhRhLBW634I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VkHLvbJB2GSsNkeJElsfdQGHQdIykYbNERVxWEHP7fGshDJq2z7CAtjvuZuKdd8my
	 ogzKYHgKiKKM3gpQ8dsY3pEUV+uIn5ZFdmq4jR85uDuY9xDEgXruuQXJyTtFiDkI6K
	 4RlNInTylu1EjxvyvWuY8ye7TX3Zhur3Vl8jr5S47tFxPWmUlohPg/glq5oIixshxA
	 XpA170Y5UF0gMhv1PncyCsNBkQk7nRjogTdvJy/u82DPJ93bqGqszJ9ah/IllPL3I8
	 GI8AiiUD81KNDEBWVZB40nGgVQtl7vYO6+hY4133G5FpN8CCWGtzevMJVW0Pj49B10
	 9mfdBme1Mf8OQ==
Date: Wed, 29 Nov 2023 21:39:21 +0000
To: Bernd Schubert <bernd.schubert@fastmail.fm>, Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
From: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: Daniel Rosenberg <drosen@google.com>, Paul Lawrence <paullawrence@google.com>, Alessio Balsini <balsini@android.com>, Christian Brauner <brauner@kernel.org>, fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
Message-ID: <44ff6b37-7c4b-485d-8ebf-de5fadd3c527@spawn.link>
In-Reply-To: <2f6513fa-68d8-43c8-87a4-62416c3e1bfd@fastmail.fm>
References: <20231016160902.2316986-1-amir73il@gmail.com> <CAOQ4uxh6sd0Eeu8z-CpCD1KEiydvQO6AagU93RQv67pAzWXFvQ@mail.gmail.com> <CAJfpegsoz12HRBeXzjX+x37fSdzedshOMYbcWS1QtG4add6Nfg@mail.gmail.com> <CAOQ4uxjEHEsBr5OgvrKNAsEeH_VUTZ-Cho2bYVPYzj_uBLLp2A@mail.gmail.com> <CAJfpegtH1DP19cAuKgYAssZ8nkKhnyX42AYWtAT3h=nmi2j31A@mail.gmail.com> <CAOQ4uxgW6xpWW=jLQJuPKOCxN=i_oNeRwNnMEpxOhVD7RVwHHw@mail.gmail.com> <CAJfpegtOt6MDFM3vsK+syJhpLMSm7wBazkXuxjRTXtAsn9gCuA@mail.gmail.com> <CAOQ4uxiCjX2uQqdikWsjnPtpNeHfFk_DnWO3Zz2QS3ULoZkGiA@mail.gmail.com> <2f6513fa-68d8-43c8-87a4-62416c3e1bfd@fastmail.fm>
Feedback-ID: 55718373:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/29/23 14:46, Bernd Schubert wrote:
>=20
>=20
> On 11/29/23 18:39, Amir Goldstein wrote:
>> On Wed, Nov 29, 2023 at 6:55=E2=80=AFPM Miklos Szeredi <miklos@szeredi.h=
u> wrote:
>>>
>>> On Wed, 29 Nov 2023 at 16:52, Amir Goldstein <amir73il@gmail.com> wrote=
:
>>>
>>>> direct I/O read()/write() is never a problem.
>>>>
>>>> The question is whether mmap() on a file opened with FOPEN_DIRECT_IO
>>>> when the inode is in passthrough mode, also uses fuse_passthrough_mmap=
()?
>>>
>>> I think it should.
>>>
>>>> or denied, similar to how mmap with ff->open_flags & FOPEN_DIRECT_IO &=
&
>>>> vma->vm_flags & VM_MAYSHARE) && !fc->direct_io_relax
>>>> is denied?
>>>
>>> What would be the use case for FOPEN_DIRECT_IO with passthrough mmap?
>>>
>>
>> I don't have a use case. That's why I was wondering if we should
>> support it at all, but will try to make it work.
>=20
> What is actually the use case for FOPEN_DIRECT_IO and passthrough?
> Avoiding double page cache?
>=20
>>
>>>> A bit more challenging, because we will need to track unmounts, or at
>>>> least track
>>>> "was_cached_mmaped" state per file, but doable.
>>>
>>> Tracking unmaps via fuse_vma_close() should not be difficult.
>>>
>>
>> OK. so any existing mmap, whether on FOPEN_DIRECT_IO or not
>> always prevents an inode from being "neutral".
>>
>=20
>=20
> Thanks,
> Bernd
>=20

 > Avoiding double page cache?

Currently my users enable direct_io because 1) it is typically=20
materially faster than not 2) avoiding double page caching (it is a=20
union filesystem).

The only real reason people disable direct_io is because many apps need=20
shared mmap. I've implemented a mode to lookup details about the=20
requesting app and optionally disable direct_io for apps which are known=20
to need shared mmap but that isn't ideal. The relaxed mode being=20
discussed would likely be more performant and more transparent to the=20
user. That transparency is nice if that can continue as it is already=20
pretty difficult to explain all these options to the layman.

Offtopic: What happens in passthrough mode when an error occurs?=20
Currently I have a number of behaviors relying on the fact that I can=20
intercept and respond to errors. I think my users will gladly give them=20
up for near native io perf but if they can get both it would be nice.



