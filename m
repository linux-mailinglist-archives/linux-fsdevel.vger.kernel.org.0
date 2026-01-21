Return-Path: <linux-fsdevel+bounces-74891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA0OBQQmcWl8eQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:16:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9ACE5BF2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E815C68C9E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 17:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C86340DA5;
	Wed, 21 Jan 2026 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="aT5ide7N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2D6348452;
	Wed, 21 Jan 2026 17:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769018198; cv=none; b=mcyxb+EFwNWSUYWjNd23EQRxZoR0o6wNhZ3LdciXgyaO3284xNzwmSosQpwmJmPgAnJW+n7aa+P6NLixJhVn/+UAGanLKRtXaUg31WlItcClj/b1k6OtlXYcUU7IcOdnLRR8dz8Whtq698O3lJBIYjaOZDrJMfwWIllg3oW/nqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769018198; c=relaxed/simple;
	bh=DXdMGPIW7/PPrYdCjuyf1yCAwIUpn27quJ4MeXauIDc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QnI3T0A7mSOy1gAsRtSkI9DHtv3Wur4+ruQfrFASKna8F6Q6/WkPNcVd+HZ94uubxOsixkDivwPZm3x/61Ro95Fdd8yixLEVTGrtal8u91dAfJeFqfMN9avSkeOB09sd+qMKOoTc2tauYIVJ0mCd9VcvhnYgFCVbhoZEw0aL5mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=aT5ide7N; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=m3Epy0AtawqM4edbGGu6EzMFOO396a69rOhtKKxxgcQ=; b=aT5ide7NhibXPQjwRD9B86vKOl
	2jKoucwZhy9WAd8T5t1LTW5qYBp1wCD2qjh1xbTOoL38u0e/zDffZVxbvKEvO+BnP62l3qYfisKeH
	395a/O9xY6nOqFN0WWuxHF3a6RHYfCMGC0NfO/kuQUyad0id4U3hzsOt9mH3IoGR9hy5PdaOqpnu2
	Sr8caUgbMR0ml4yaS6BrZLwa3qdZgNF7zJq5TCmcly6R1ZJ8qlSTCQu8c08iYOl3uCAual5agUVRe
	ytCaFtIZElkVOQP2pOgsr+v5NNxtFaPdybJYkdrXrAiolavXMunov4W+oEGu2W6AQrlThtnoSSY3v
	YOl2zfsg==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vicRA-0088nl-U0; Wed, 21 Jan 2026 18:56:13 +0100
From: Luis Henriques <luis@igalia.com>
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>,
  Amir Goldstein <amir73il@gmail.com>,  Miklos Szeredi <miklos@szeredi.hu>,
  "Darrick J. Wong" <djwong@kernel.org>,  Kevin Chen <kchen@ddn.com>,
  Horst Birthelmer <hbirthelmer@ddn.com>,  "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  Matt Harvey <mharvey@jumptrading.com>,
  "kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the
 FUSE_LOOKUP_HANDLE operation
In-Reply-To: <aWFcmSNLq9XM8KjW@fedora> (Horst Birthelmer's message of "Fri, 9
	Jan 2026 20:55:06 +0100")
References: <20251212181254.59365-1-luis@igalia.com>
	<20251212181254.59365-5-luis@igalia.com>
	<CAJfpegszP+2XA=vADK4r09KU30BQd-r9sNu2Dog88yLG8iV7WQ@mail.gmail.com>
	<87zf6nov6c.fsf@wotan.olymp>
	<CAJfpegst6oha7-M+8v9cYpk7MR-9k_PZofJ3uzG39DnVoVXMkA@mail.gmail.com>
	<CAOQ4uxjXN0BNZaFmgs3U7g5jPmBOVV4HenJYgdfO_-6oV94ACw@mail.gmail.com>
	<CAJfpegsS1gijE=hoaQCiR+i7vmHHxxhkguGJvMf6aJ2Ez9r1dw@mail.gmail.com>
	<b2582658-c5e9-4cf8-b673-5ccc78fe0d75@ddn.com>
	<CAOQ4uxhMtz6WqLKPegRy+Do2UU6uJvDOqb8YU6=-jAy98E5Vfw@mail.gmail.com>
	<645edb96-e747-4f24-9770-8f7902c95456@ddn.com>
	<aWFcmSNLq9XM8KjW@fedora>
Date: Wed, 21 Jan 2026 17:56:12 +0000
Message-ID: <877bta26kj.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : No valid SPF,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74891-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[bsbernd.com,ddn.com,gmail.com,szeredi.hu,kernel.org,vger.kernel.org,jumptrading.com,igalia.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luis@igalia.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B9ACE5BF2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Horst!

On Fri, Jan 09 2026, Horst Birthelmer wrote:

> On Fri, Jan 09, 2026 at 07:12:41PM +0000, Bernd Schubert wrote:
>> On 1/9/26 19:29, Amir Goldstein wrote:
>> > On Fri, Jan 9, 2026 at 4:56=E2=80=AFPM Bernd Schubert <bschubert@ddn.c=
om> wrote:
>> >>
>> >>
>> >>
>> >> On 1/9/26 16:37, Miklos Szeredi wrote:
>> >>> On Fri, 9 Jan 2026 at 16:03, Amir Goldstein <amir73il@gmail.com> wro=
te:
>> >>>
>> >>>> What about FUSE_CREATE? FUSE_TMPFILE?
>> >>>
>> >>> FUSE_CREATE could be decomposed to FUSE_MKOBJ_H + FUSE_STATX + FUSE_=
OPEN.
>> >>>
>> >>> FUSE_TMPFILE is special, the create and open needs to be atomic.   So
>> >>> the best we can do is FUSE_TMPFILE_H + FUSE_STATX.
>> >>>
>> >=20
>> > I thought that the idea of FUSE_CREATE is that it is atomic_open()
>> > is it not?
>> > If we decompose that to FUSE_MKOBJ_H + FUSE_STATX + FUSE_OPEN
>> > it won't be atomic on the server, would it?
>>=20
>> Horst just posted the libfuse PR for compounds
>> https://github.com/libfuse/libfuse/pull/1418
>>=20
>> You can make it atomic on the libfuse side with the compound
>> implementation. I.e. you have the option leave it to libfuse to handle
>> compound by compound as individual requests, or you handle the compound
>> yourself as one request.
>>=20
>> I think we need to create an example with self handling of the compound,
>> even if it is just to ensure that we didn't miss anything in design.
>
> I actually do have an example that would be suitable.
> I could implement the LOOKUP+CREATE as a pseudo atomic operation in passt=
hrough_hp.

So, I've been working on getting an implementation of LOOKUP_HANDLE+STATX.
And I would like to hear your opinion on a problem I found:

If the kernel is doing a LOOKUP, you'll send the parent directory nodeid
in the request args.  On the other hand, the nodeid for a STATX will be
the nodeid will be for the actual inode being statx'ed.

The problem is that when merging both requests into a compound request,
you don't have the nodeid for the STATX.  I've "fixed" this by passing in
FUSE_ROOT_ID and hacking user-space to work around it: if the lookup
succeeds, we have the correct nodeid for the STATX.  That seems to work
fine for my case, where the server handles the compound request itself.
But from what I understand libfuse can also handle it as individual
requests, and in this case the server wouldn't know the right nodeid for
the STATX.

Obviously, the same problem will need to be solved for other operations
(for example for FUSE_CREATE where we'll need to do a FUSE_MKOBJ_H +
FUSE_STATX + FUSE_OPEN).

I guess this can eventually be fixed in libfuse, by updating the nodeid in
this case.  Another solution is to not allow these sort of operations to
be handled individually.  But maybe I'm just being dense and there's a
better solution for this.

Cheers,
--=20
Lu=C3=ADs

