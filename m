Return-Path: <linux-fsdevel+bounces-73069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD65D0B933
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 18:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB6D33028E6D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 17:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15CB366569;
	Fri,  9 Jan 2026 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="moZTw+pg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0A0365A08;
	Fri,  9 Jan 2026 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767978447; cv=none; b=fMJcLi/dKwmVUFCmtgrFmdgcOmzsPQ3EXRHNlsc2o829YGUfxTVFtVwNxNkDK/avxV/r3aAGIGEjcJ6IEQqAVAiwnUbq+HA/VZDPuMLdDON4P0xFkhSoLtcZDTB/PovE0/BCQmB4nQZkP+/G/SBbiNLGYM3Ggc8gK42YBEfRMIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767978447; c=relaxed/simple;
	bh=m5Kc0cyE952elY02862Vfr28p78pQtCDhjd1hEFWs5c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sc3ZKEjDx0XMYvW9amiIJnwHdS4lko+hIZoN1BNbQpjUpr3xIt0V25E+he/g+I+cwpw+qpw9Hp/JS30CAR2HW3ER02r7tTOCoHkl25YZO/O4WgvnpoYa6UP0Y2dZUlrhEIsg1DlllY6iVXSGGK/AtI2HERaYh0WKgGqPZq3b0cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=moZTw+pg; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Jhg+4nXh/yWpugQOihtjQzgGEo99a9CQxTXKQVRNjt8=; b=moZTw+pg+g1GOBWGywVSqi56Dj
	vgvLypCGo8bdGoCT1m1VvqBxCLilUM2P8U3ot9y+jeFtgT62dkjpu4HYIoOoGf81to0sWHbvPlUQK
	IksMFIJPSgc7wadct5T6j4W5FiqspvzbZN74QPlQ7aGGZsZmDqlAyQQ8Jtt5Iv83wAlajZohvgdYa
	50dxaW8ATaaSiZq/sbC8KcxqzGgHxIRT83xEp15aS92mbwh6lIrtlKfKAV8q8DMgoQEwJ5LfLhQaT
	Im/nZbeYoh3TDUvFhx/AV3ElJRQXAHkzJMn//JymNxJ3wNlWJOEHQlt2I9K5kyN9Gf+ldr584RAQZ
	ML+BTDyA==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1veFx8-003VHq-Ub; Fri, 09 Jan 2026 18:07:11 +0100
From: Luis Henriques <luis@igalia.com>
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Amir Goldstein
 <amir73il@gmail.com>,  "Darrick J. Wong" <djwong@kernel.org>,  Bernd
 Schubert <bschubert@ddn.com>,  Kevin Chen <kchen@ddn.com>,  Horst
 Birthelmer <hbirthelmer@ddn.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Matt Harvey <mharvey@jumptrading.com>,
  kernel-dev@igalia.com
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the
 FUSE_LOOKUP_HANDLE operation
In-Reply-To: <aWEWVAqHlTpzsklJ@fedora> (Horst Birthelmer's message of "Fri, 9
	Jan 2026 15:56:48 +0100")
References: <20251212181254.59365-1-luis@igalia.com>
	<20251212181254.59365-5-luis@igalia.com>
	<CAJfpegszP+2XA=vADK4r09KU30BQd-r9sNu2Dog88yLG8iV7WQ@mail.gmail.com>
	<87zf6nov6c.fsf@wotan.olymp>
	<CAJfpegst6oha7-M+8v9cYpk7MR-9k_PZofJ3uzG39DnVoVXMkA@mail.gmail.com>
	<87tswuq1z2.fsf@wotan.olymp> <aWEWVAqHlTpzsklJ@fedora>
Date: Fri, 09 Jan 2026 17:07:10 +0000
Message-ID: <87pl7i4sw1.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09 2026, Horst Birthelmer wrote:

> On Fri, Jan 09, 2026 at 02:45:21PM +0000, Luis Henriques wrote:
>> On Fri, Jan 09 2026, Miklos Szeredi wrote:
>>=20
>> > On Fri, 9 Jan 2026 at 12:57, Luis Henriques <luis@igalia.com> wrote:
>> >
>> >> I've been trying to wrap my head around all the suggested changes, and
>> >> experimenting with a few options.  Since there are some major things =
that
>> >> need to be modified, I'd like to confirm that I got them right:
>> >>
>> >> 1. In the old FUSE_LOOKUP, the args->in_args[0] will continue to use =
the
>> >>    struct fuse_entry_out, which won't be changed and will continue to=
 have
>> >>    a static size.
>> >
>> > Yes.
>> >
>> >> 2. FUSE_LOOKUP_HANDLE will add a new out_arg, which will be dynamical=
ly
>> >>    allocated (using your suggestion: 'args->out_var_alloc').  This wi=
ll be
>> >>    a new struct fuse_entry_handle_out, similar to fuse_entry_out, but
>> >>    replacing the struct fuse_attr by a struct fuse_statx, and adding =
the
>> >>    file handle struct.
>> >
>> > Another idea: let's simplify the interface by removing the attributes
>> > from the lookup reply entirely.  To get back the previous
>> > functionality, compound requests can be used: LOOKUP_HANDLE + STATX.
>>=20
>> OK, interesting idea.  So, in that case we would have:
>>=20
>> struct fuse_entry_handle_out {
>> 	uint64_t nodeid;
>> 	uint64_t generation;
>> 	uint64_t entry_valid;
>> 	struct fuse_file_handle fh;
>> }
>>=20
>> I'll then need to have a look at the compound requests closely. (I had
>> previously skimmed through the patches that add open+getattr but didn't
>> gone too deep into it.)
>>=20
>
> I am preparing the pull request for libfuse today, so you can have a look=
 at how it will be handled on the libfuse
> side.=20
> That contains a patch to passthrough_hp as well so it supports compounds =
and you will have something to test, if you want to go that way.

Awesome, thanks for the hint, Horst.  I'll definitely have a look into it.

Cheer,
--=20
Lu=C3=ADs

