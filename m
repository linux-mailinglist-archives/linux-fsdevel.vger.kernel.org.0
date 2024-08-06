Return-Path: <linux-fsdevel+bounces-25147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F9B9496BB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 19:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7EE1F268D5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 17:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4EC6FE16;
	Tue,  6 Aug 2024 17:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAXvUE0K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E98F5339D;
	Tue,  6 Aug 2024 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965320; cv=none; b=gHLTCYKB0RwoHLVQqOv2vooqfwrqbZF2n1E64HmNJh8AgHEKSRnw+4Za25TxYR5gGk7Qrv9oDgdbN7ZqjwJhUWGLrDtqJxCKSW7hxxeyP4s0dGgDiHAznRRTCflV9ughUc1QiizD3HJMHvvfe9k179eY+qTuXnHqlK6ElP4xLeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965320; c=relaxed/simple;
	bh=Qi5WxmMVqmR0matvwiMljokUy+VSTuQ68dFhDYopPqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=T01016j0dgpAEoRn+WCPGEvcPtTnuAFP4m0fZ8oNhJMMIV8I+NYT9AKfoU2RTaku6YGfcH/aVRDiVgz3DQL6VXlO12CWqqAGl0zsk3BtReSAZd6CAhhtDTgTWmVT8boJhScLjQ+NPos4OcehdzegcSSqbkRl9u/YfWqKGre9RcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAXvUE0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25ADC32786;
	Tue,  6 Aug 2024 17:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722965320;
	bh=Qi5WxmMVqmR0matvwiMljokUy+VSTuQ68dFhDYopPqQ=;
	h=Date:From:To:Cc:Subject:From;
	b=FAXvUE0KIKhlW+bPfH7nEjVfB9pnfTRAVLFxq3YBnRaBNeyQInhLUDkVNQ1Yne4fy
	 1rji3IM/XkY/aW1PHguSfjzwzQu98iEfNi5pJJ3IUWyIkZ2yNjX/LoJRXFU5dO5thy
	 QDjrU5CIX1ZsXeIt25qlgPx4T8POowARlFSSu32UltQi9hmb751L6+Dnoz1HzEqmAm
	 dUZ7DRZuCUXA7cCWOngjT52mIrgqZxCQWprWnfRYF5/GqtCVIGmtwAcYK/b3UKXLSz
	 pQp9ukAAaey9TMGScKUWq38FHIr/ODo+01aCy7rH6Q8pEXYnzbVNa3tBkdjai/iDOo
	 Hd3b4NCiL9SPA==
Date: Tue, 6 Aug 2024 19:28:34 +0200
From: Alejandro Colomar <alx@kernel.org>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, alexei.starovoitov@gmail.com, 
	audit@vger.kernel.org, bpf@vger.kernel.org, catalin.marinas@arm.com, 
	dri-devel@lists.freedesktop.org, ebiederm@xmission.com, laoar.shao@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	rostedt@goodmis.org, selinux@vger.kernel.org, serge@hallyn.com
Subject: Re: [PATCH v5 0/9] Improve the copy of task comm
Message-ID: <2jxak5v6dfxlpbxhpm3ey7oup4g2lnr3ueurfbosf5wdo65dk4@srb3hsk72zwq>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d4izvc7wnp2wjet3"
Content-Disposition: inline


--d4izvc7wnp2wjet3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, alexei.starovoitov@gmail.com, 
	audit@vger.kernel.org, bpf@vger.kernel.org, catalin.marinas@arm.com, 
	dri-devel@lists.freedesktop.org, ebiederm@xmission.com, laoar.shao@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	rostedt@goodmis.org, selinux@vger.kernel.org, serge@hallyn.com
Subject: Re: [PATCH v5 0/9] Improve the copy of task comm
MIME-Version: 1.0

Hi Linus,

Serge let me know about this thread earlier today.

On 2024-08-05, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Mon, 5 Aug 2024 at 20:01, Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > One concern about removing the BUILD_BUG_ON() is that if we extend
> > TASK_COMM_LEN to a larger size, such as 24, the caller with a
> > hardcoded 16-byte buffer may overflow.
>=20
> No, not at all. Because get_task_comm() - and the replacements - would
> never use TASK_COMM_LEN.
>=20
> They'd use the size of the *destination*. That's what the code already do=
es:
>=20
>   #define get_task_comm(buf, tsk) ({                      \
>   ...
>         __get_task_comm(buf, sizeof(buf), tsk);         \
>=20
> note how it uses "sizeof(buf)".

In shadow.git, we also implemented macros that are named after functions
and calculate the appropriate number of elements internally.

	$ grepc -h STRNCAT .
	#define STRNCAT(dst, src)  strncat(dst, src, NITEMS(src))
	$ grepc -h STRNCPY .
	#define STRNCPY(dst, src)  strncpy(dst, src, NITEMS(dst))
	$ grepc -h STRTCPY .
	#define STRTCPY(dst, src)  strtcpy(dst, src, NITEMS(dst))
	$ grepc -h STRFTIME .
	#define STRFTIME(dst, fmt, tm)  strftime(dst, NITEMS(dst), fmt, tm)
	$ grepc -h DAY_TO_STR .
	#define DAY_TO_STR(str, day, iso)   day_to_str(NITEMS(str), str, day, iso)

They're quite useful, and when implementing them we found and fixed
several bugs thanks to them.

> Now, it might be a good idea to also verify that 'buf' is an actual
> array, and that this code doesn't do some silly "sizeof(ptr)" thing.

I decided to use NITEMS() instead of sizeof() for that reason.
(NITEMS() is just our name for ARRAY_SIZE().)

	$ grepc -h NITEMS .
	#define NITEMS(a)            (SIZEOF_ARRAY((a)) / sizeof((a)[0]))

> We do have a helper for that, so we could do something like
>=20
>    #define get_task_comm(buf, tsk) \
>         strscpy_pad(buf, __must_be_array(buf)+sizeof(buf), (tsk)->comm)

We have SIZEOF_ARRAY() for when you want the size of an array:

	$ grepc -h SIZEOF_ARRAY .
	#define SIZEOF_ARRAY(a)      (sizeof(a) + must_be_array(a))

However, I don't think you want sizeof().  Let me explain why:

-  Let's say you want to call wcsncpy(3) (I know nobody should be using
   that function, not strncpy(3), but I'm using it as a standard example
   of a wide-character string function).

   You should call wcsncpy(dst, src, NITEMS(dst)).
   A call wcsncpy(dst, src, sizeof(dst)) is bogus, since the argument is
   the number of wide characters, not the number of bytes.

   When translating that to normal characters, you want conceptually the
   same operation, but on (normal) characters.  That is, you want
   strncpy(dst, src, NITEMS(dst)).  While strncpy(3) with sizeof() works
   just fine because sizeof(char)=3D=3D1 by definition, it is conceptually
   wrong to use it.

   By using NITEMS() (i.e., ARRAY_SIZE()), you get the __must_be_array()
   check for free.

In the end, SIZEOF_ARRAY() is something we very rarely use.  It's there
only used in the following two cases at the moment:

	#define NITEMS(a)            (SIZEOF_ARRAY((a)) / sizeof((a)[0]))
	#define MEMZERO(arr)  memzero(arr, SIZEOF_ARRAY(arr))

Does that sound convincing?

For memcpy(3) for example, you do want sizeof(), because you're copying
raw bytes, but with strings, in which characters are conceptually
meaningful elements, NITEMS() makes more sense.

BTW, I'm working on a __lengthof__ operator that will soon allow using
it on function parameters declared with array notation.  That is,

	size_t
	f(size_t n, int a[n])
	{
		return __lengthof__(a);  // This will return n.
	}

If you're interested in it, I'm developing and discussing it here:
<https://inbox.sourceware.org/gcc-patches/20240806122218.3827577-1-alx@kern=
el.org/>

>=20
> as a helper macro for this all.
>=20
> (Although I'm not convinced we generally want the "_pad()" version,
> but whatever).

We had problems with it in shadow recently.  In user-space, it's similar
to strncpy(3) (at least if you wrap it in a macro that makes sure that
it terminates the string with a null byte).

We had a lot of uses of strncpy(3), from old times where that was used
to copy strings with truncation.  I audited all of that code (and
haven't really finished yet), and translated to calls similar to
strscpy(9) (we call it strtcpy(), as it _t_runcates).  The problem was
that in some cases the padding was necessary, and in others it was not,
and it was very hard to distinguish those.

I recommend not zeroing strings unnecessarily, since that will make it
hard to review the code later.  E.g., twenty years from now, someone
takes a piece of code with a _pad() call, and has no clue if the zeroing
was for a reason, or for no reason.

On the other hand, not zeroing may make it easier to explot bugs, so
whatever you think best.  In the kernel you may need to be more worried
than in user space.  Whatever.  :)

>=20
>                     Linus

Have a lovely day!
Alex


--=20
<https://www.alejandro-colomar.es/>

--d4izvc7wnp2wjet3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmayXTwACgkQnowa+77/
2zKkGg//QGKZL+2Xhpb6wdoKoQMt5Ixm8AxcrhEng31CT2FlaXxnveqkjC9CXsUS
hvuVRQFMFyhrARydHNtx/Ps5q5f/TSv4qX+5PI6hBFPAIJOuHCh2UfXqPEMrCXb5
iAhq73HPqXL20Igr1+n9W9buunf2ow4fBxTsK+7eMZCPnTAuS3lMkRpmne8d7ks1
iOHorYSEbJYJqWUyOCq7i/KNufR7nALJzBHzqPcAE47Gsp0/N0DA/NEzO6zbCRS4
HLODuEC8T6iWnEh+qoBTS0Gn1ksmVNCQPVyLj4OurtSYeX0pGL6NQWxKjMgxCaQ9
r0rN2v+o8ULJIOBI1ZVKAqlXZdPxtPpwPxyim82IB5Mok0bkqGSZQYMqEL27YkK0
k/Ec5R/AkO8Zhc/i3YFzTwa8peXA9s4D2xFCB/hYTdTNL138ugVV1fevoPo6qt9t
eqA/fKesf5pK9OXftXBdqHNqsDGe6Ps76ahK9FsQNj0ZEi1JLTmWoEGRQMHQ6iZ+
yXlgOkn3625L2Q0Qofv3x943QicRe8eahFyW/YV7a+8B+n7PP9RQEo95DTv1QjGU
wCP6XYatwx1uKgauYWE2if5RiXyhsUBbCjEAUrXTmLBAxk/5zJ+vSpDl3j3fr4D0
hm5Pe6kB02HnX7NQKrnlgmPJi7PhBVGSRSDc+Lj4r4q7e3BYDuY=
=TwdF
-----END PGP SIGNATURE-----

--d4izvc7wnp2wjet3--

