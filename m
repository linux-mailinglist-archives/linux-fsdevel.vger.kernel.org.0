Return-Path: <linux-fsdevel+bounces-73947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E9DD26542
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 18:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A9284309D9A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765943C1985;
	Thu, 15 Jan 2026 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="SoK39rXk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA3C3BF307;
	Thu, 15 Jan 2026 17:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497299; cv=none; b=jJskUdd56kdD5AqrujtgS3dO3LjOiBe8jtpPiwmfYgO6cNVhacnUCzEZUbDFbqVYM50JePePEU94Aw8gY9tlRTMOFTn84bHM7Ntn2PjlXUhOlZjV1urt0uzEhb6e/6mXnQRVU97e7Rtu7XLr+Y8dJwYkgcLOZ3qIGcAzC5QB92o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497299; c=relaxed/simple;
	bh=ie94QjaOlOWX68+fNUphYUGkQebp6sOQwNKDHG51oEQ=;
	h=From:To:Cc:Subject:In-Reply-To:Message-ID:References:Date:
	 MIME-Version:Content-Type; b=nIHxVLpuE37sWJ3XePdGN//91Uto6KDFECfVoZGTXocP7Ad/SSPDCmY2d3wEPWhKYYPKYVGXKi81Izw3TnpvzrloPy6JEA0mr8U8XHHQZaLfE8SiQFhexpJIxWCLhpiXPz1+jiATGRwFSoAxHhFASsYHRdLF3LiRdXyzAkm6LSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=SoK39rXk; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	References:Message-ID:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DoOMMuoT5cAAWyt3qZcAYOl6yoaf/Q3EEjGWl24xIfs=; b=SoK39rXkA2iWb/Gd3y09HKtllW
	gfPu/PaQHfxQ7q6i+lKE0+/Z/Oz7XtjJYcGbZWvbspItLPaVjnYCsDeZ81LkM0uhHGyiKjz2LTYk0
	7Tf2oMby5TWIwKwdYWB1T3Q0Yft2gZrvkmSvZhNlU2Q7aiG2no45/0mwCl6AZTQjZZsbUuyKIUHc3
	W68W6N3AmAXge5ol9DqdeobP2b968jFAhI53Q26qW8gLgdPAAhidmuOrbG/y/XV4dmqTuHn4Qrivo
	j1NNUlM1NM+53Ne9JG8hZCIFw8nbl5BKOA3O4Bj2FGy/hLd2zXyHY2RLX+HBTa1ViMcSPDoARqQL+
	R3yStliA==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vgQvk-005pkZ-8i; Thu, 15 Jan 2026 18:14:44 +0100
From: Luis Henriques <luis@igalia.com>
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Bernd Schubert <bernd@bsbernd.com>,  Joanne Koong
 <joannelkoong@gmail.com>,  Horst Birthelmer <horst@birthelmer.com>,
  Miklos Szeredi <miklos@szeredi.hu>,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: [PATCH v4 3/3] fuse: add an implementation of open+getattr
In-Reply-To: <aWkEWEgerlDv0bt6@fedora> (Horst Birthelmer's message of "Thu, 15
	Jan 2026 16:25:32 +0100")
Message-ID: <87qzrq4xdw.fsf@wotan.olymp>
References: <20260109-fuse-compounds-upstream-v4-0-0d3b82a4666f@ddn.com>
	<20260109-fuse-compounds-upstream-v4-3-0d3b82a4666f@ddn.com>
	<CAJnrk1ZtS4VfYo03UFO_khcaA6ugHiwtWQqaObB5P_ozFtsCHA@mail.gmail.com>
	<aWjteRMwc_KIN4pt@fedora.fritz.box>
	<3223f464-9f76-4c37-b62b-f61f6b1fc1f6@bsbernd.com>
	<aWju_kqgdiOZt8gn@fedora.fritz.box> <87wm1i52si.fsf@wotan.olymp>
	<aWkEWEgerlDv0bt6@fedora>
Date: Thu, 15 Jan 2026 17:14:43 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Horst,

On Thu, Jan 15 2026, Horst Birthelmer wrote:

> Hi Luis,
>
> thanks for looking at this.
>
> On Thu, Jan 15, 2026 at 03:11:25PM +0000, Luis Henriques wrote:
>> On Thu, Jan 15 2026, Horst Birthelmer wrote:
>>=20
>> > On Thu, Jan 15, 2026 at 02:41:49PM +0100, Bernd Schubert wrote:
>> >>=20
>> >>=20
>> >> On 1/15/26 14:38, Horst Birthelmer wrote:
>> >> > On Wed, Jan 14, 2026 at 06:29:26PM -0800, Joanne Koong wrote:
>> >> >> On Fri, Jan 9, 2026 at 10:27=E2=80=AFAM Horst Birthelmer <horst@bi=
rthelmer.com> wrote:
>> >> >>>
>> >> >>> +
>> >> >>> +       err =3D fuse_compound_send(compound);
>> >> >>> +       if (err)
>> >> >>> +               goto out;
>> >> >>> +
>> >> >>> +       err =3D fuse_compound_get_error(compound, 0);
>> >> >>> +       if (err)
>> >> >>> +               goto out;
>> >> >>> +
>> >> >>> +       err =3D fuse_compound_get_error(compound, 1);
>> >> >>> +       if (err)
>> >> >>> +               goto out;
>> >> >>
>> >> >> Hmm, if the open succeeds but the getattr fails, why not process it
>> >> >> kernel-side as a success for the open? Especially since on the ser=
ver
>> >> >> side, libfuse will disassemble the compound request into separate
>> >> >> ones, so the server has no idea the open is even part of a compoun=
d.
>> >> >>
>> >> >> I haven't looked at the rest of the patch yet but this caught my
>> >> >> attention when i was looking at how fuse_compound_get_error() gets
>> >> >> used.
>> >> >>
>> >> > After looking at this again ...
>> >> > Do you think it would make sense to add an example of lookup+create=
, or would that just convolute things?
>> >>=20
>> >>=20
>> >> I think that will be needed with the LOOKUP_HANDLE from Luis, if we go
>> >> the way Miklos proposes. To keep things simple, maybe not right now?
>> >
>> > I was thinking more along the lines of ... we would have more than one=
 example
>> > especially for the error handling. Otherwise it is easy to miss someth=
ing
>> > because the given example just doesn't need that special case.
>> > Like the case above. There we would be perfectly fine with a function =
returning
>> > the first error, which in the case of lookup+create is the opposite of=
 success
>> > and you would need to access every single error to check what actually=
 happened.
>>=20
>> Not sure if I can add a lot to this discussion, but I've been playing a
>> bit with your patchset.
> You already do ;-)
>
>>=20
>> I was trying to understand how to implement the LOOKUP_HANDLE+STATX, and
>> it doesn't look too difficult at the moment.  But I guess it'll take me =
some
>> more time to figure out all the other unknowns (e.g. other operations su=
ch
>> as readdirplus).
>>=20
>> Anyway, the interface for compound operations seem to be quite usable in
>> general.  I'll try to do a proper review soon, but regarding the specific
>> comment of error handling, I find the interface a bit clumsy.  Have you
>> thought about using something like an iterator?  Or maybe some sort of
>> macro such as foreach_compound_error()?
> Not in those terms, no.
> But I don't think it would get any better. Do you have an idea you would =
want implemented in this context?

Yeah, I'm not really sure it would be any better, to be honest.  And I'm
afraid I'm just bikeshedding...  My suggestion was to have something like:

	err =3D fuse_compound_send(compound);
	if (err)
		goto out;

	for_each_compound_error(op_arg, compound, list) {
		err =3D handle_error(op_arg);
		if (err)
			goto out;
	}

But again, this is probably unnecessary.  Or at least not while we're
talking about having compound requests with 2 operations only.

>> And regarding the error handling in general: it sounds like things can
>> become really complex when some operations within a compound operation m=
ay
>> succeed and others fail.  Because these examples are using two operations
>> only, but there's nothing preventing us from having 3 or more in the
>> future, right?  Wouldn't it be easier to have the compound operation
>> itself fail or succeed, instead of each op?  (Although that would probab=
ly
>> simply move the complexity into user-space, that would be required to do
>> more clean-up work when there are failures.)
>
> I think we need all the granularity we can get since different combinatio=
ns mean different things in different contexts.
> Imagine you have a compound as the current example. That is pretty much a=
ll or
> nothing and there is almost no way that one of the operations doesn't suc=
ceed,
> and if it goes wrong you can still fall back to separate operations.
> There are certainly cases where the compound itself is the operation beca=
use it
> really has to be atomic, or for arguments sake they have to be started
> concurrently ... or whatnot.

OK, got it.  I guess that errors on atomic compound operations will then
be handled that way (i.e. all or nothing), and it will always depend on
the combination of operations.  Anyway, the devil is always in the details
and I'm sure you've been putting a lot of thought into this ;-)

Cheers,
--=20
Lu=C3=ADs

