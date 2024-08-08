Return-Path: <linux-fsdevel+bounces-25400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B8894B860
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 09:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166431F2357B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 07:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476171891B7;
	Thu,  8 Aug 2024 07:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xr2QwR/4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846C81CD25;
	Thu,  8 Aug 2024 07:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723103935; cv=none; b=RDdGNxjxnTX+WgGUoI/mV/6H5JMyRP/iY/PiGo54NjwHwmS/UOBgyiXev4F/fSQJsQPbRjhUA8j+ToEuY3KG6rLLYHmODfXio00fa4JblPiQORzictFtLtXSYUShJ478sGydH9Xq5ur99dGG8lBf5QWBTC4Odb0MNoYQ8idYATQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723103935; c=relaxed/simple;
	bh=lBgKsSZMNn5ItIypje4300VtOpFDmA6vuT10xWV/5tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9T7osUHUKt4V5emWdGMUtglxHW4Y0BJ0HKkOQWUaoe+2gTH4uqfJM53KJ6bcGyxZj2PpJxq3nM43xrRgYRl/0LVVPnZtjNtw52G/cyZyTH8c0SEga0/ZYw3MxwK5udfmL27uJz+/emvs/3yvobPwRQDauC8f3VkeJjGJJIqY9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xr2QwR/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E30C32782;
	Thu,  8 Aug 2024 07:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723103935;
	bh=lBgKsSZMNn5ItIypje4300VtOpFDmA6vuT10xWV/5tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xr2QwR/4R0+Yb+9pUu6BgnmvD4j3cPKIXj9murfquFun6YQ/CtU3vzU8MbgPfxoVB
	 xkYuiK/L381eurFZAGr+8yLDvjaR3DzrA+JEA1NP4Vt+8DfpQV63+glF1dNVLIQsq9
	 6RBkYf4cl5QgGfcCJ1oif1ZReVXjPbf9VLx/sL5k79gAC60zyJMW6wlzXP12dzF2Rc
	 p4bKCzhJtNliCTOKjwmeTyFJU0Gexb1/mRb2uw8ieff4BFHRFqqAiCcznbtnOjYbgL
	 JV6WcSTcuur9WiLhmc6LF8JIVUwLAzh7TtU9G4P0oFwufwGX278D7l8mKJw9TUCRKf
	 UXtdzQYOEKN6g==
Date: Thu, 8 Aug 2024 09:58:49 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	alexei.starovoitov@gmail.com, audit@vger.kernel.org, bpf@vger.kernel.org, 
	catalin.marinas@arm.com, dri-devel@lists.freedesktop.org, ebiederm@xmission.com, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	rostedt@goodmis.org, selinux@vger.kernel.org, serge@hallyn.com
Subject: Re: [PATCH v5 0/9] Improve the copy of task comm
Message-ID: <mywl5fk4ob4c4xekplom3ysiyo57h2iqirbiza6wdka3kdoa7q@exrkx5uwn2yc>
References: <2jxak5v6dfxlpbxhpm3ey7oup4g2lnr3ueurfbosf5wdo65dk4@srb3hsk72zwq>
 <CALOAHbBKzrvibUbj-1W7Z79AZsvOpMeG--EZ0pf2k0iyuPa1_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qwav3xltx7orscp7"
Content-Disposition: inline
In-Reply-To: <CALOAHbBKzrvibUbj-1W7Z79AZsvOpMeG--EZ0pf2k0iyuPa1_w@mail.gmail.com>


--qwav3xltx7orscp7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	alexei.starovoitov@gmail.com, audit@vger.kernel.org, bpf@vger.kernel.org, 
	catalin.marinas@arm.com, dri-devel@lists.freedesktop.org, ebiederm@xmission.com, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	rostedt@goodmis.org, selinux@vger.kernel.org, serge@hallyn.com
Subject: Re: [PATCH v5 0/9] Improve the copy of task comm
References: <2jxak5v6dfxlpbxhpm3ey7oup4g2lnr3ueurfbosf5wdo65dk4@srb3hsk72zwq>
 <CALOAHbBKzrvibUbj-1W7Z79AZsvOpMeG--EZ0pf2k0iyuPa1_w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CALOAHbBKzrvibUbj-1W7Z79AZsvOpMeG--EZ0pf2k0iyuPa1_w@mail.gmail.com>

Hi Yafang,

On Thu, Aug 08, 2024 at 10:49:17AM GMT, Yafang Shao wrote:
> > > Now, it might be a good idea to also verify that 'buf' is an actual
> > > array, and that this code doesn't do some silly "sizeof(ptr)" thing.
> >
> > I decided to use NITEMS() instead of sizeof() for that reason.
> > (NITEMS() is just our name for ARRAY_SIZE().)
> >
> >         $ grepc -h NITEMS .
> >         #define NITEMS(a)            (SIZEOF_ARRAY((a)) / sizeof((a)[0]=
))
> >
> > > We do have a helper for that, so we could do something like
> > >
> > >    #define get_task_comm(buf, tsk) \
> > >         strscpy_pad(buf, __must_be_array(buf)+sizeof(buf), (tsk)->com=
m)
> >
> > We have SIZEOF_ARRAY() for when you want the size of an array:
> >
> >         $ grepc -h SIZEOF_ARRAY .
> >         #define SIZEOF_ARRAY(a)      (sizeof(a) + must_be_array(a))
>=20
> There is already a similar macro in Linux:
>=20
>   /**
>    * ARRAY_SIZE - get the number of elements in array @arr
>    * @arr: array to be sized
>    */
>   #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) +
> __must_be_array(arr))

This is actually the same as our NITEMS(), not SIZEOF_ARRAY().

> will use it instead of the sizeof().

But yeah, indeed I think you should use ARRAY_SIZE() in
get_task_comm().  :)

>=20
> Good point.
> I will avoid using the _pad().

Nice.  :)

Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>

--qwav3xltx7orscp7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAma0erkACgkQnowa+77/
2zI/JRAAoVxukBH7uw9FKXnQL5urmTajhZ9amPoHARet43Vg/lzzBNf6fKGg+8Sw
Ia/9Wj4w2X8FhIeCkj6N9ZS8SaIRgXExdZQxfOdfNWRXk8i+UVm0HzH3maGvLLi7
uSkYvr0HKnB/bk8tjJWDfvEEwNFS0f6rTlz3gcK2AggiDr9N1ZZBKS1/6qXDTgps
Z+83Dzqy6UmjYa43Rg9MLoS5hux8uJyepFVgJQ3YzNoLlT4RCnXz99pTQffEGf/u
Z1pH8dsthc5ObspRQoWHzKVRv2LmatVaitOfoxEnqw7nqcKkwV6hfKYwArb1PR5x
46De/I8Q2SFzcCT+MjcCHQrlYo4ae7YVGpk2dpIYxkFnH7WCR3UeMamLrsPAkydf
bAisGt0aUSSnXv6Nx+AyJzqJVYwfXY87aUMBxU6M6tiD1WaBCxMkgEyCqGRI4T4M
SxLDjWDUNMP3dzrilzfy+7Q5mBSoDP0fyVZD9PvQyj2I3OQuaSco8SiKocb6YPyv
NlIPR7vs2K7n+Cmbv1FtrW2XTDnYsHpUYs1iI81FGoqQmK0I3JM+M1PSFs1m/VLB
UMkeE70pWxJlewI3USP3BVhAVMn9LGP3k0r6eRLlea0y8Y8VRx77S8+D7Im1RNqs
ybegRL10BeXA+FLXX9xvCPi4ClFH2e/r0dFUpNTzg9bDXJG5sr8=
=hUNj
-----END PGP SIGNATURE-----

--qwav3xltx7orscp7--

