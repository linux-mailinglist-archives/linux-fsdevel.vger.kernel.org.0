Return-Path: <linux-fsdevel+bounces-75024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOPFE7wPcmksawAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 12:53:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE67E66419
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 12:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D151A8C8065
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 11:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDB53A9DAF;
	Thu, 22 Jan 2026 11:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="anHHWTiJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B52341063;
	Thu, 22 Jan 2026 11:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769081138; cv=none; b=AOClxduImgedA/5Pz1EDb2iXeClg9//fj+f1Q0NsFHuBvzoaWIny6+4thH1KysGHfR8Za+1eQYLzcan2zYAr0cML+dG2R0iVd339ofOaWdY7ZSVBjGryn1jKkxd9h19ofqLDJNeIFo77T3y3Sgnh+gynwWoECcAZX/uhEGXgDGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769081138; c=relaxed/simple;
	bh=k/bGDsHYIZy3UgfGjSb3D564YGtdr5kuh7K14Aedje8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tc4LKvHBOIrDo+F6ZdIlnSQtuYYLgqLzJh/wNGk1pTmLmvnzknJ8LVW+6faNfmka5QaPXxPwDAFTpNkosBVfuN+ECyYXLOuOOrpo1TDnTzErUUDFiMgO4MwfRPpOx2mkHw2FSxDl558iQx0vkcD4bLMzd+NuXIr4YMLDRKQ2isA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=anHHWTiJ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=K86s43oIOLg8c5t6XzC74Os4B1VobMMYTMn3C2L8LIA=; b=anHHWTiJ4DybskMQmdPEd0fYcf
	W3FBhNHynJGh1xAoTzbj1TNelQoTfQ9O8d7EmOCHdaUbw0tlTVQ6ZaPgTfHEqynmklfMtr/r41ugA
	T93YAhmmGGu1CwkkX4vzpr7FvtCWQedlWppy38F5mNS2tQ+hVW0E8XfVF1Vr/5EKljpLjsiPI+05G
	+eWlTV1+wzAHwgwDpzN7wMEVFpLBQJ1LTV0PfOwnSoLiaY8dsRCV4okhJZ72YI7IPxRRbVIG03yab
	QSRh41iHAo3uJnmO31U1jA6Vmx78dNs3BgOJnkwxjMb/cCdnffIbq29UcvDjeBET5J+n5fVS728BN
	plv8iWQA==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1visoV-008QSg-6z; Thu, 22 Jan 2026 12:25:23 +0100
From: Luis Henriques <luis@igalia.com>
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Bernd Schubert <bschubert@ddn.com>,  Bernd Schubert <bernd@bsbernd.com>,
  Amir Goldstein <amir73il@gmail.com>,  Miklos Szeredi <miklos@szeredi.hu>,
  "Darrick J. Wong" <djwong@kernel.org>,  Kevin Chen <kchen@ddn.com>,
  Horst Birthelmer <hbirthelmer@ddn.com>,  "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  Matt Harvey <mharvey@jumptrading.com>,
  "kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the
 FUSE_LOOKUP_HANDLE operation
In-Reply-To: <aXICIREIL46NcaK8@fedora.fritz.box> (Horst Birthelmer's message
	of "Thu, 22 Jan 2026 11:59:41 +0100")
References: <aXEVjYKI6qDpf-VW@fedora>
	<03ea69f4-f77b-4fe7-9a7c-5c5ca900e4bf@bsbernd.com>
	<aXEbnMNbE4k6WI7j@fedora>
	<5d022dc0-8423-4af2-918f-81ad04d50678@ddn.com>
	<aXEhTi2-8DRZKb_I@fedora>
	<e761b39b-79c7-40d4-947e-a209fcf2bb6b@ddn.com>
	<aXEjX7MD4GzGRvdE@fedora> <87pl726kko.fsf@wotan.olymp>
	<aXH48-QCxUU4TlNk@fedora.fritz.box> <87ldhp7wbf.fsf@wotan.olymp>
	<aXICIREIL46NcaK8@fedora.fritz.box>
Date: Thu, 22 Jan 2026 11:25:22 +0000
Message-ID: <87h5sd7uu5.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : No valid SPF,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75024-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[ddn.com,bsbernd.com,gmail.com,szeredi.hu,kernel.org,vger.kernel.org,jumptrading.com,igalia.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luis@igalia.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,wotan.olymp:mid]
X-Rspamd-Queue-Id: BE67E66419
X-Rspamd-Action: no action

On Thu, Jan 22 2026, Horst Birthelmer wrote:

> On Thu, Jan 22, 2026 at 10:53:24AM +0000, Luis Henriques wrote:
>> On Thu, Jan 22 2026, Horst Birthelmer wrote:
> ...
>> >>=20
>> >> So, to summarise:
>> >>=20
>> >> In the end, even FUSE servers that do support compound operations will
>> >> need to check the operations within a request, and act accordingly.  =
There
>> >> will be new combinations that will not be possible to be handle by se=
rvers
>> >> in a generic way: they'll need to return -EOPNOTSUPP if the combinati=
on of
>> >> operations is unknown.  libfuse may then be able to support the
>> >> serialisation of that specific operation compound.  But that'll requi=
re
>> >> flagging the request as "serialisable".
>> >
>> > OK, so this boils down to libfuse trying a bit harder than it does at =
the moment.
>> > After it calls the compound handler it should check for EOPNOTSUP and =
the flag
>> > and then execute the single requests itself.
>> >
>> > At the moment the fuse server implementation itself has to do this.
>> > Actually the patched passthrough_hp does exactly that.
>> >
>> > I think I can live with that.
>>=20
>> Well, I was trying to suggest to have, at least for now, as little chang=
es
>> to libfuse as possible.  Something like this:
>>=20
>> 	if (req->se->op.compound)
>> 		req->se->op.compound(req, arg->count, arg->flags, in_payload);
>> 	else if (arg->flags & FUSE_COMPOUND_SERIALISABLE)
>> 		fuse_execute_compound_sequential(req);
>> 	else
>> 		fuse_reply_err(req, ENOSYS);
>>=20
>> Eventually, support for specific non-serialisable operations could be
>> added, but that would have to be done for each individual compound.
>> Obviously, the server itself could also try to serialise the individual
>> operations in the compound handle, and use the same helper.
>>=20
>
> Is there a specific reason why you want that change in lowlevel.c?
> The patched passthrouhg_hp does this implicitly, actually without the fla=
g.
> It handles what it knows as 'atomic' compound and uses the helper for the=
 rest.
> If you don't want to handle specific combinations, just check for them=20
> and return an error.

Sorry, I have the feeling that I'm starting to bikeshed a bit...

Anyway, I saw the passthrough_hp code, and that's why I thought it would
be easy to just move that into the lowlevel API.  I assumed this would be
a very small change to your current code that would also allow to safely
handle "serialisable" requests in servers that do not have the
->compound() handler.  Obviously, the *big* difference from your code
would be that the kernel would need to flag the non-serialisable requests,
so that user-space would know whether they could handle requests
individually or not.

And another thought I just had (more bikeshedding!) is that if the server
will be allowed to call fuse_execute_compound_sequential(), then this
function would also need to check that flag and return an error if the
request can't be serialisable.

Anyway, I'll stop bothering you now :-)  These comments should probably
have been done in the libfuse PR anyway.

Cheers,
--=20
Lu=C3=ADs

