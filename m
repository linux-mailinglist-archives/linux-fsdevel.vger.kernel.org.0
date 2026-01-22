Return-Path: <linux-fsdevel+bounces-75019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGYBOTAEcmmvZwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 12:04:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FF765AE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 12:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 340726AB013
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 10:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1661F3A7F44;
	Thu, 22 Jan 2026 10:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="bSmianh7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368A62E5D17;
	Thu, 22 Jan 2026 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079229; cv=none; b=UEXnGej//uT1+/0P7MW199U084L25GZOWRQLvDZq+XbDlKweaTPuFBcgHaWk6gKFn7V5l8RuGBckp0cObcRV+63MzHwVOwvUOTNGJPhM65i5bmubg/fEKtZ0XMLs7bOVuvlgMrlY3pqWsVPmFeMOgZLh2+85kZ91qpnAh7u67dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079229; c=relaxed/simple;
	bh=wZf3Uf8jsn88PuPSffsAY4gFE3kL5KVWEWgYay0R6kA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HZNAOh/j1MHGPGN9UfrZdaWc2cSUxSc+CA3fgogf1T/eUOPl6uJPT93EBWI/wsgNnmw2baEvrqVy6pRrPa7B2/iETu1TMa9AXQWUGxRALuoOlFHeWusUnO3hybBb9XehTt0op4NF+oG2BRRH8+hhe5zY2bZGuF2Fg00EkSr8HVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=bSmianh7; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=uWe52uShijabMs9oCNZnME8Sh8gPTiJ3hXhZuaAITus=; b=bSmianh7RHeJk4DTuyeThK2n19
	omOWAQOSwasXewKQEslsZ9LWkajWe4QRC1usXJXt4G2O8qndep4KbnY2G9NN26IBvqY8b9d7vGzq3
	j30NkwwDg8tFE+K5JtMAVPqtrBuPjXNMnN8MC56bk4zPgq6MAFf5pwVo3T0j8pPLXOt79wG413pcp
	AY0goUzjPUhFl55dZTGQIqjByicuH7EA0/nQjjg0QuI9uPm66V5tDEv0fs2yRHxpIhpfRj+8RWbUn
	RUHdP7h8fh/z0RH5Ic5QPV8NO5C4hW+nv25mcNKxUeDFugabx5O18sNJqFjqYrC74IBlkqrkGxDTE
	zn13qe1A==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1visJd-008PqJ-S3; Thu, 22 Jan 2026 11:53:29 +0100
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
In-Reply-To: <aXH48-QCxUU4TlNk@fedora.fritz.box> (Horst Birthelmer's message
	of "Thu, 22 Jan 2026 11:20:50 +0100")
References: <aWFcmSNLq9XM8KjW@fedora> <877bta26kj.fsf@wotan.olymp>
	<aXEVjYKI6qDpf-VW@fedora>
	<03ea69f4-f77b-4fe7-9a7c-5c5ca900e4bf@bsbernd.com>
	<aXEbnMNbE4k6WI7j@fedora>
	<5d022dc0-8423-4af2-918f-81ad04d50678@ddn.com>
	<aXEhTi2-8DRZKb_I@fedora>
	<e761b39b-79c7-40d4-947e-a209fcf2bb6b@ddn.com>
	<aXEjX7MD4GzGRvdE@fedora> <87pl726kko.fsf@wotan.olymp>
	<aXH48-QCxUU4TlNk@fedora.fritz.box>
Date: Thu, 22 Jan 2026 10:53:24 +0000
Message-ID: <87ldhp7wbf.fsf@wotan.olymp>
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
	TAGGED_FROM(0.00)[bounces-75019-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,wotan.olymp:mid]
X-Rspamd-Queue-Id: 61FF765AE9
X-Rspamd-Action: no action

On Thu, Jan 22 2026, Horst Birthelmer wrote:

> On Thu, Jan 22, 2026 at 09:52:23AM +0000, Luis Henriques wrote:
>> Hi!
>>=20
>> On Wed, Jan 21 2026, Horst Birthelmer wrote:
>>=20
>> > On Wed, Jan 21, 2026 at 08:03:32PM +0100, Bernd Schubert wrote:
>> >>=20
>> >>=20
>> >> On 1/21/26 20:00, Horst Birthelmer wrote:
>> >> > On Wed, Jan 21, 2026 at 07:49:25PM +0100, Bernd Schubert wrote:
>> >> >>
>> >> >>
>> >> > ...
>> >> >>> The problem Luis had was that he cannot construct the second requ=
est in the compound correctly
>> >> >>> since he does not have all the in parameters to write complete re=
quest.
>> >> >>
>> >> >> What I mean is, the auto-handler of libfuse could complete request=
s of
>> >> >> the 2nd compound request with those of the 1st request?
>> >> >>
>> >> > With a crazy bunch of flags, we could probably do it, yes.
>> >> > It is way easier that the fuse server treats certain compounds
>> >> > (combination of operations) as a single request and handles
>> >> > those accordingly.
>>=20
>> Right, I think that at least the compound requests that can not be
>> serialised (i.e. those that can not be executed using the libfuse helper
>> function fuse_execute_compound_sequential()) should be flagged as such.
>> An extra flag to be set in the request should do the job.
>>=20
>> This way, if this flag isn't set in a compound request and the FUSE serv=
er
>> doesn't have a compound handle, libfuse could serialise the requests.
>> Otherwise, it would return -ENOTSUPP.
>>=20
>> >> Hmm, isn't the problem that each fuse server then needs to know those
>> >> common compound combinations? And that makes me wonder, what is the
>> >> difference to an op code then?
>> >
>> > I'm pretty sure we both have some examples and counter examples in min=
d.
>> >
>> > Let's implement a couple of the suggested compounds and we will see=20
>> > if we can make generic rules. I'm not convinced yet, that we want to
>> > have a generic implementation in libfuse.
>> >
>> > The advantage to the 'add an opcode' for every combination=20
>> > (and there are already a couple of those) approach is that
>> > you don't need more opcodes, so no changes to the kernel.
>> > You need some code in the fuse server, though, which to me is
>> > fine, since if you have atomic operations implemented there,
>> > why not actually use them.
>> >
>> > The big advantage is, choice.
>> >
>> > There will be some examples (like the one from Luis)
>> > where you don't actually have a generic choice,
>> > or you create some convention, like you just had in mind.
>> > (put the result of the first operation into the input
>> > of the next ... or into some fields ... etc.)
>>=20
>> So, to summarise:
>>=20
>> In the end, even FUSE servers that do support compound operations will
>> need to check the operations within a request, and act accordingly.  The=
re
>> will be new combinations that will not be possible to be handle by serve=
rs
>> in a generic way: they'll need to return -EOPNOTSUPP if the combination =
of
>> operations is unknown.  libfuse may then be able to support the
>> serialisation of that specific operation compound.  But that'll require
>> flagging the request as "serialisable".
>
> OK, so this boils down to libfuse trying a bit harder than it does at the=
 moment.
> After it calls the compound handler it should check for EOPNOTSUP and the=
 flag
> and then execute the single requests itself.
>
> At the moment the fuse server implementation itself has to do this.
> Actually the patched passthrough_hp does exactly that.
>
> I think I can live with that.

Well, I was trying to suggest to have, at least for now, as little changes
to libfuse as possible.  Something like this:

	if (req->se->op.compound)
		req->se->op.compound(req, arg->count, arg->flags, in_payload);
	else if (arg->flags & FUSE_COMPOUND_SERIALISABLE)
		fuse_execute_compound_sequential(req);
	else
		fuse_reply_err(req, ENOSYS);

Eventually, support for specific non-serialisable operations could be
added, but that would have to be done for each individual compound.
Obviously, the server itself could also try to serialise the individual
operations in the compound handle, and use the same helper.

Cheers,
--=20
Lu=C3=ADs

