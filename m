Return-Path: <linux-fsdevel+bounces-75952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPNMCWDdfGl1PAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 17:33:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C49BC8CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 17:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1ABB3013D7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 16:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB64344059;
	Fri, 30 Jan 2026 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmS+Z8no"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB3319F137
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769790801; cv=none; b=auU1QNuE96KykGNfup9iquYWiOsIv9IXZNvOiY5MRYoZxlo+D6Xas2kHCiqRnLsQdCToSod+QUI0cdqDMeb42v5lZ/sqOZMTr7WMekCOqVtkEAI0bF7aVR6ketTNhwa7m648plHrAEhgpzh+A3zZzkq5EBCuqKq5yVG/a98AoE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769790801; c=relaxed/simple;
	bh=Nz0IQMj9gpqoNpwgfkSaMZrBqdMpWsXigzJrbzuVi0A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tlJVD+tZj5SYzHcC0UcIlF7YXeWnTHW2IQbHM2W4OOEzLYrOf7u+MpLpgDAB/SV9rEJLITDsQLQp+RzSRdfyffBRPF/NN5EeHwe7g5Lhw62x+CVpGFCiP8j+7KKYqnIOab5ulfjo5F0mP2M4+dKvptFry+hvZaVbN7IDQ6FZcyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmS+Z8no; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4042905015cso1463735fac.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 08:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769790799; x=1770395599; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nz0IQMj9gpqoNpwgfkSaMZrBqdMpWsXigzJrbzuVi0A=;
        b=WmS+Z8noPYo6Lx/PNgOvWW4SElDfDGf/aIkbLySJKfbXYSANgBNuFoSDjnNZpQS3LC
         1+N7UfwPYvreZH7JvQQ9sLc/5ICvjg4Oa+bYbva0f/Sm0Zgp9bn2cjIKs0ofq59VzC9q
         abCj+x0U/6BEjPRXEHStgu9wtsm/7qzeVkfVXfvsere1eMXPpcew+NdWUmiHVAbvcTiA
         XQgLacwS4v1lgltyzpRVTvVraHrL0MOS0ldZPpVjcXCnC4kcjm1A+QKOR59wg83gnjlL
         jXldP/e+C6MRO5wSBEMmBVN//njJRRS1aoEdY/HZh0CO7SZFWr+Yd4QKy/Vuo/LL9l8+
         CdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769790799; x=1770395599;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nz0IQMj9gpqoNpwgfkSaMZrBqdMpWsXigzJrbzuVi0A=;
        b=hbQ9w0B3QN7DFbzMoUVNhEhQYVIN5lNyWP1n635fsanSxH40ok3/EsRSGBZo/O8/Q+
         bHv2GorzMiXHMTA+jVshnQ1auDd2VM+rMl1X+ihmx9wmKqzjy3cDYbA4oGRjLNmaT5Kb
         I1B0uRXurXmQ6xSgQdNnoo1Oktx+AgBLmdPWyRsuKw40reVADwvsxgXrtB9hNUHqtcF0
         CNWGG6VfolVbloNYmh3WH32Afe3S0EQlryj/gdso0PMnICgTjGDkAn9EsSzAyq43eqAX
         HDBwU7OWg3QnqGgRyRrJz0u3GRyk6WdAquC5eZRCrlOqtJB7XIv1j53VUEF11zishbgg
         uxqg==
X-Forwarded-Encrypted: i=1; AJvYcCUW8EDhmABAqnjxNVIP293r3WEzQCEgJNI7IZcSo/x5Ouuiyrunh1KV6obtRg7kKakcJLWYTHVDjrVh2RCx@vger.kernel.org
X-Gm-Message-State: AOJu0YyNeS9yqlp9rTuYvq8ivmU7siZ6bSH7JD6e/2KTXSJJlTeOAGfP
	a9QoQ7HRGgclkCzfJz2hOfhNPY4r7kGuFWchrTcPlvEZ8B+9g7tZac8=
X-Gm-Gg: AZuq6aJMD8LubPKy16ZeRyqfQ91N1/+xSR5RwQkmGWoXie8cpOm/4vS6qc1UhO729/f
	Y0rND/nU/224oMkUsFdX3QQwn7jLMkBBaKwBeIDdNk5k7VyFMP/IR/gDe6OcmCeDLuLUVLkJelo
	IdcmLMluM1FCZWAoOU/1uyaqt7P9mogOAbm8iV/AatkRyOh073tJmUaTaqiIH+xZPTNzYJoNaxL
	flniol/KBKpGBO7NL5FSLA7krTRqg/kuwELsoQU0t3r6byty2bTVo8UUDXt8Y3WZ8VF+SGXjdFq
	2O4N/7YBJURfAAF1OZqL9FcmhbUNSq2kLYb3FuRloHO5Z3sboH/F0sL5u8eJHlOmYHHg48Iv0vw
	/ey9b/kUudJbUxvexWv66/YqM5yhwVzLyZBzdfZh/vyq6objNirHujVSndKWfYI2o2KS8yHdEID
	/32kTCaYt+mApfEK33aqDAKD+x0LuTsdYlnfwHYU0pJ2yduJRVa67dnGjD7uC2fNNAt1U+fLmwU
	sgmwdRd6rIB7XzWU8IU5YZBexf+0kQ7K5/jh4x6V5u8tIMLM3PYv4zjYLpMBE+oOKzUrc+9Xosu
	vw==
X-Received: by 2002:a05:6820:81c8:b0:662:bf0e:16a1 with SMTP id 006d021491bc7-6630f3cac58mr1638959eaf.83.1769790799063;
        Fri, 30 Jan 2026 08:33:19 -0800 (PST)
Received: from leira.trondhjem.org (162-232-235-235.lightspeed.livnmi.sbcglobal.net. [162.232.235.235])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4095753b347sm5469812fac.17.2026.01.30.08.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 08:33:18 -0800 (PST)
Message-ID: <f0c1d246022214e41ece2b42424be079b182c246.camel@gmail.com>
Subject: Re: [PATCH v2 3/3] NFSD: Sign filehandles
From: Trond Myklebust <trondmy@gmail.com>
To: Benjamin Coddington <bcodding@hammerspace.com>, Lionel Cons
	 <lionelcons1972@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-crypto@vger.kernel.org
Date: Fri, 30 Jan 2026 11:33:17 -0500
In-Reply-To: <97207D44-31EC-474F-8D68-CBA50CA324AE@hammerspace.com>
References: <cover.1769026777.git.bcodding@hammerspace.com>
	 <0aaa9ca4fd3edc7e0d25433ad472cb873560bf7d.1769026777.git.bcodding@hammerspace.com>
	 <CAPJSo4XhEOGncxBRZcOL6KmyBRY+pERiCLUkWzN7Zw+8oUmXGg@mail.gmail.com>
	 <97207D44-31EC-474F-8D68-CBA50CA324AE@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75952-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[hammerspace.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trondmy@gmail.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aka.ms:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 70C49BC8CF
X-Rspamd-Action: no action

On Fri, 2026-01-30 at 08:25 -0500, Benjamin Coddington wrote:
> On 30 Jan 2026, at 7:58, Lionel Cons wrote:
>=20
> > [You don't often get email from lionelcons1972@gmail.com. Learn why
> > this is important at
> > https://aka.ms/LearnAboutSenderIdentification=C2=A0]
> >=20
> > On Wed, 21 Jan 2026 at 22:03, Benjamin Coddington
> > <bcodding@hammerspace.com> wrote:
> > >=20
> > > NFS clients may bypass restrictive directory permissions by using
> > > open_by_handle() (or other available OS system call) to guess the
> > > filehandles for files below that directory.
> > >=20
> > > In order to harden knfsd servers against this attack, create a
> > > method to
> > > sign and verify filehandles using siphash as a MAC (Message
> > > Authentication
> > > Code).=C2=A0 Filehandles that have been signed cannot be tampered
> > > with, nor can
> > > clients reasonably guess correct filehandles and hashes that may
> > > exist in
> > > parts of the filesystem they cannot access due to directory
> > > permissions.
> > >=20
> > > Append the 8 byte siphash to encoded filehandles for exports that
> > > have set
> > > the "sign_fh" export option.=C2=A0 The filehandle's fh_auth_type is
> > > set to
> > > FH_AT_MAC(1) to indicate the filehandle is signed.=C2=A0 Filehandles
> > > received from
> > > clients are verified by comparing the appended hash to the
> > > expected hash.
> > > If the MAC does not match the server responds with NFS error
> > > _BADHANDLE.
> > > If unsigned filehandles are received for an export with "sign_fh"
> > > they are
> > > rejected with NFS error _BADHANDLE.
> >=20
>=20
> Hi Lionel,
>=20
> > Random questions:
> > 1. CPU load: Linux NFSv4 servers consume LOTS of CPU time, which
> > has
> > become a HUGE problem for hosting them on embedded hardware (so no
> > realistic NFSv4 server performance on an i.mx6 or RISC/V machine).
> > And
> > this has become much worse in the last two years. Did anyone
> > measure
> > the impact of this patch series?
>=20
> We're essentially adding a siphash operation for every encode and
> decode of
> a filehandle.=C2=A0 Siphash is lauded as "faster than sha255, slower than
> xxhash".=C2=A0 Measuring the performance impact might look like crafting
> huge
> compounds of GETATTR, but I honestly don't think (after network
> latency) the
> performance impact will be measurable.
>=20
> I attempted to measure a time difference between runs of fstests
> suite --
> there were no significant measurable effects in my crude total time
> calculations.
>=20
> I could, if it pleases everyone, do a function profile for
> fh_append_mac and
> fh_verify_mac - but the users of this option do not care about gating
> it
> behind strict performance optimizations because we're fixing a
> security
> problem that matters much more to those users.
>=20
> > 2. Do NFS clients require any changes for this?
>=20
> No - the filehandle is opaque.
>=20
> Ben

The other thing to note is that this is an opt-in feature. If you don't
want to use it for fear of CPU load, you are free not to change your
/etc/exports config file.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

