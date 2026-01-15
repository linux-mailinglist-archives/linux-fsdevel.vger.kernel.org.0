Return-Path: <linux-fsdevel+bounces-73929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D62C9D25327
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 16:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 05257301279A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 15:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2C03ACF1A;
	Thu, 15 Jan 2026 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cVNQ2SFz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0813ACA7E;
	Thu, 15 Jan 2026 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768489907; cv=none; b=TkV7KcR0kgkfzRty6ygbi0PtbDHhO27HCSg9Gx/0P3Vy8ZN5u3KfYUkpO4bIzKTkknVmzGp+sa4e13DNjcT2ZzxO5Mt9mqbvygOCt1iS1hcoOecJ4lt5C9s8+9SRQJGC1EmZbvICXWhqY3emOY7PP4CvI1/ylorr2cie10Lihyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768489907; c=relaxed/simple;
	bh=3fW3FNBfI10ew1mLiB64E+zKB19+2wx/03kItucKsuI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ojp9cl16fU5Px5DTeoxRrgkPHPlu/53sKaO1I2v3rKTqim4x/BE9lAnqxsL51A7OCJu0rPesy79v6f2IMJTU2nKwduBeQO3RmAjc5csJPNF+t0h4U9cz04PZJUhwtIjGDjhno2AOsEas/8GiAeKvE+pGTgldW0pBQsXNj4CLdQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=cVNQ2SFz; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=eHrCBtT5VDzItbrTI+V+BZKQ9uotfJppng936Xl2IT0=; b=cVNQ2SFzeKcxOkO1sXJ/OapeBb
	9gCfw9CVJZT9a6gMs3/eJNK9edV1R5LzLqNjpR30zd4dc2LQKgDoduU9R1rkeDu2oC0Lbc9ywQeIk
	PErhcZTRVwdQrBOgqXbCSHG46cMecxddSr+xQnhaiYDR3qZysEASrWfGLkuQsy6QRf2OQVZEDJKp9
	hb5lwWO7SyumiPGSjEkUXNo5gFz+VIxz/AOAvvtyNvregfFG5VhNXnFxCs6RIIgVhjYqJKrssAie9
	I0P6si4EAyGjIaxDUuxxVu1dudQMxp+Zg4iNYjcV5Ct6Heg4DT9VYOEWaRX2eFWhyXV0NGIpB5REP
	bVZ6Vm/w==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vgP0U-005mtR-Ip; Thu, 15 Jan 2026 16:11:30 +0100
From: Luis Henriques <luis@igalia.com>
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Bernd Schubert <bernd@bsbernd.com>,  Joanne Koong
 <joannelkoong@gmail.com>,  Horst Birthelmer <horst@birthelmer.com>,
  Miklos Szeredi <miklos@szeredi.hu>,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: [PATCH v4 3/3] fuse: add an implementation of open+getattr
In-Reply-To: <aWju_kqgdiOZt8gn@fedora.fritz.box> (Horst Birthelmer's message
	of "Thu, 15 Jan 2026 14:46:27 +0100")
References: <20260109-fuse-compounds-upstream-v4-0-0d3b82a4666f@ddn.com>
	<20260109-fuse-compounds-upstream-v4-3-0d3b82a4666f@ddn.com>
	<CAJnrk1ZtS4VfYo03UFO_khcaA6ugHiwtWQqaObB5P_ozFtsCHA@mail.gmail.com>
	<aWjteRMwc_KIN4pt@fedora.fritz.box>
	<3223f464-9f76-4c37-b62b-f61f6b1fc1f6@bsbernd.com>
	<aWju_kqgdiOZt8gn@fedora.fritz.box>
Date: Thu, 15 Jan 2026 15:11:25 +0000
Message-ID: <87wm1i52si.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15 2026, Horst Birthelmer wrote:

> On Thu, Jan 15, 2026 at 02:41:49PM +0100, Bernd Schubert wrote:
>>=20
>>=20
>> On 1/15/26 14:38, Horst Birthelmer wrote:
>> > On Wed, Jan 14, 2026 at 06:29:26PM -0800, Joanne Koong wrote:
>> >> On Fri, Jan 9, 2026 at 10:27=E2=80=AFAM Horst Birthelmer <horst@birth=
elmer.com> wrote:
>> >>>
>> >>> +
>> >>> +       err =3D fuse_compound_send(compound);
>> >>> +       if (err)
>> >>> +               goto out;
>> >>> +
>> >>> +       err =3D fuse_compound_get_error(compound, 0);
>> >>> +       if (err)
>> >>> +               goto out;
>> >>> +
>> >>> +       err =3D fuse_compound_get_error(compound, 1);
>> >>> +       if (err)
>> >>> +               goto out;
>> >>
>> >> Hmm, if the open succeeds but the getattr fails, why not process it
>> >> kernel-side as a success for the open? Especially since on the server
>> >> side, libfuse will disassemble the compound request into separate
>> >> ones, so the server has no idea the open is even part of a compound.
>> >>
>> >> I haven't looked at the rest of the patch yet but this caught my
>> >> attention when i was looking at how fuse_compound_get_error() gets
>> >> used.
>> >>
>> > After looking at this again ...
>> > Do you think it would make sense to add an example of lookup+create, o=
r would that just convolute things?
>>=20
>>=20
>> I think that will be needed with the LOOKUP_HANDLE from Luis, if we go
>> the way Miklos proposes. To keep things simple, maybe not right now?
>
> I was thinking more along the lines of ... we would have more than one ex=
ample
> especially for the error handling. Otherwise it is easy to miss something
> because the given example just doesn't need that special case.
> Like the case above. There we would be perfectly fine with a function ret=
urning
> the first error, which in the case of lookup+create is the opposite of su=
ccess
> and you would need to access every single error to check what actually ha=
ppened.

Not sure if I can add a lot to this discussion, but I've been playing a
bit with your patchset.

I was trying to understand how to implement the LOOKUP_HANDLE+STATX, and
it doesn't look too difficult at the moment.  But I guess it'll take me some
more time to figure out all the other unknowns (e.g. other operations such
as readdirplus).

Anyway, the interface for compound operations seem to be quite usable in
general.  I'll try to do a proper review soon, but regarding the specific
comment of error handling, I find the interface a bit clumsy.  Have you
thought about using something like an iterator?  Or maybe some sort of
macro such as foreach_compound_error()?

And regarding the error handling in general: it sounds like things can
become really complex when some operations within a compound operation may
succeed and others fail.  Because these examples are using two operations
only, but there's nothing preventing us from having 3 or more in the
future, right?  Wouldn't it be easier to have the compound operation
itself fail or succeed, instead of each op?  (Although that would probably
simply move the complexity into user-space, that would be required to do
more clean-up work when there are failures.)

Cheers,
--=20
Lu=C3=ADs

