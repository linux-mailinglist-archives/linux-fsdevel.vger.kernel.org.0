Return-Path: <linux-fsdevel+bounces-60020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC79B40E69
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 22:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C77C454540A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 20:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AE735334D;
	Tue,  2 Sep 2025 20:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XNGF1FdT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998492868AF;
	Tue,  2 Sep 2025 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756844027; cv=none; b=N/Du6R1DQ8VRHZaF1yAaMxRt9KE9odLUocUOMuF0zkwOX+qs83pHj6pjBaJMJ9XVDdmRwsM7nnQbw2Zek5wegdbY/LfbgxYpyi39SVfRY5qdd7oqHsjWLDM+zCb9x+vjGtfdIPgalbjdOCfoPpFjaZMaFrFl1aXBJoLX6OrQBjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756844027; c=relaxed/simple;
	bh=a6PYMNQ4lyH7aqWba75DkNnb6H2UHxlLGIoeUGL3RV0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g8jAEjzNri23Pvqp5PG0K9Lis06nYyqjZV2yrDrc6LhPWpfY2baGSAgSC7T2JagbsAwXfle+g60tZgkR8RiuLIQZrnYpb27g4muWOrj5n8K1Nf64RsEHNiTMm2+x0b+WwTLO2hhMImQl0+nSvbJI1o5WKNbdvqGP9TAjrFACn9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=XNGF1FdT; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=jLYd9kJDNFIbM8A/XFAy+5m3+sM8LhAOwAjVxLcNeZ8=; b=XNGF1FdT2iPxgEKbcc0f6z/+MI
	MolGT5w1OChcF3xRukhJkZtondENT1xxHjwra8+meQmDcuAjBzDWr6RCj1+WjdlZQwAnJ/b6CoLoW
	b1ijM4mn2zAkmMkUnMSH5+JlVRKAWE+4puUnUTTKEUYFQiaMB9ZQXm19wq2BCCjRSGRlYsunS0TUf
	liv53OBOf1Drk2iPOl6wWDHfr8THVcptsw+kRKAIrxy2QoqrliXjN+T17wzaAnHpu/eDaavL/GSSy
	Vht0/vP6He5R1EsoO+rHLqW36Y6evhm+COFIic/a5jEM4L6I+4V2mLOl5/oNqon+wbUK0a3CE2+J4
	/8/Th68w==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1utXNr-005rF7-DW; Tue, 02 Sep 2025 22:13:39 +0200
From: Luis Henriques <luis@igalia.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fuse: remove WARN_ON_ONCE() from
 fuse_iomap_writeback_{range,submit}()
In-Reply-To: <CAJnrk1bd62RcE9UU8COdpzSF0kk3DPYwgmwk+xCQew0-C43WXg@mail.gmail.com>
	(Joanne Koong's message of "Tue, 2 Sep 2025 11:31:35 -0700")
References: <20250902152234.35173-1-luis@igalia.com>
	<CAJnrk1awtqnSQS0F+TNTuQdLDsAAkArjbu1L=5L1Eoe0fGf31A@mail.gmail.com>
	<87bjnssp7e.fsf@wotan.olymp>
	<CAJnrk1bd62RcE9UU8COdpzSF0kk3DPYwgmwk+xCQew0-C43WXg@mail.gmail.com>
Date: Tue, 02 Sep 2025 21:13:37 +0100
Message-ID: <877bygsjda.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 02 2025, Joanne Koong wrote:

> On Tue, Sep 2, 2025 at 11:07=E2=80=AFAM Luis Henriques <luis@igalia.com> =
wrote:
>>
>> Hi Joanne,
>>
>> On Tue, Sep 02 2025, Joanne Koong wrote:
>>
>> > On Tue, Sep 2, 2025 at 8:22=E2=80=AFAM Luis Henriques <luis@igalia.com=
> wrote:
>> >>
>> >> The usage of WARN_ON_ONCE doesn't seem to be necessary in these funct=
ions.
>> >> All fuse_iomap_writeback_submit() call sites already ensure that wpc-=
>wb_ctx
>> >> contains a valid fuse_fill_wb_data.
>> >
>> > Hi Luis,
>> >
>> > Maybe I'm misunderstanding the purpose of WARN()s and when they should
>> > be added, but I thought its main purpose is to guarantee that the
>> > assumptions you're relying on are correct, even if that can be
>> > logically deduced in the code. That's how I see it being used in other
>> > parts of the fuse and non-fuse codebase. For instance, to take one
>> > example, in the main fuse dev.c code, there's a WARN_ON in
>> > fuse_request_queue_background() that the request has the FR_BACKGROUND
>> > bit set. All call sites already ensure that the FR_BACKGROUND bit is
>> > set when they send it as a background request. I don't feel strongly
>> > about whether we decide to remove the WARN or not, but it would be
>> > useful to know as a guiding principle when WARNs should be added vs
>> > when they should not.
>>
>> I'm obviously not an authority on the subject, but those two WARN_ON
>> caught my attention because if they were ever triggered, the kernel would
>> crash anyway and the WARNs would be useless.
>>
>> For example, in fuse_iomap_writeback_range() you have:
>>
>>         struct fuse_fill_wb_data *data =3D wpc->wb_ctx;
>>         struct fuse_writepage_args *wpa =3D data->wpa;
>>
>>         [...]
>>
>>         WARN_ON_ONCE(!data);
>>
>> In this case, if 'data' was NULL, you would see a BUG while initialising
>> 'wpa' and the WARN wouldn't help.
>>
>> I'm not 100% sure these WARN_ON_ONCE() should be dropped.  But if there =
is
>> a small chance of that assertion to ever be true, then there's a need to
>> fix the code and make it safer.  I.e. the 'wpa' initialisation should be
>> done after the WARN_ON_ONCE() and that WARN_ON_ONCE() should be changed =
to
>> something like:
>>
>>         if (WARN_ON_ONCE(!data))
>>                 return -EIO; /* or other errno */
>>
>> Does it make sense?
>
> Yes, perhaps you missed my previous reply where I stated
>
> "I agree, for the fuse_iomap_writeback_range() case, it would be more
> useful if "wpa =3D data->wpa" was moved below that warn."

Oops! Since it was past your signature I totally missed it indeed.  Sorry
about that.

>>
>> As I said, I can send another patch to keep those WARNs and fix these
>> error paths.  But again, after going through the call sites I believe it=
's
>> safe to assume that WARN_ON_ONCE() will never trigger.
>
> I am fine with either keeping (w/ the writeback_range() one reordered)
> or removing it, I don't feel strongly about it, but it seems
> inconsistent to me that if we are removing it because going through
> the call sites proves that it's logically safe, then doesn't that same
> logic apply to the other cases of existing WARN_ONs in the codebase
> where they are also logically safe if we go through the call sites?

OK, you definitely have a point there.  And also the WARN_ONs may be
useful for future changes as well, thus proving they can not be triggered
today may not be reason enough to remove them.

Note however that my reason for picking these two in particular was
mostly[*] because their assertions being true would result in an obvious
kernel crash, while in other WARN_ONs that effect isn't immediately
obvious.

Anyway, tomorrow I'll send v2, keeping the WARNs but preventing these NULL
pointers dereferences.

[*] I say "mostly" because the other reason was pure accident -- I was
actually reading through that code :-)

Cheers,
--=20
Lu=C3=ADs

