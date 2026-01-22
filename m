Return-Path: <linux-fsdevel+bounces-75001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMhyDDD2cWmvZwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 11:04:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FB264F88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 11:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 139095AB5DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 09:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2003A3ED119;
	Thu, 22 Jan 2026 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="obMQfawo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CA8346A04;
	Thu, 22 Jan 2026 09:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769075570; cv=none; b=MBJ+f/Tu5pQJszhOb5MQPg0vMeuTc11ds1uWK408MW4+M6H+SsK69eBWm52B38jRZOt69Niqf9AiH1+OHEnI4ruqvSKpKsbHlsS1YqW2EZOgeg8+1gUzQxENJjfiSqiWsPr5IAudsy7ZqK7iiPUvOIpfNcU1E2tc5S0B+18Ri6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769075570; c=relaxed/simple;
	bh=uiRELxybvMLXY5hOJuo8vXMz4wONO8F+2Iamtli/QkM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gUXSFcT5Lip+FP0viApBvHngcBcAzhoGkGksCZzVugqDyiWduVcYaw8bfKBX0CJ4n8q45VXKOJpHmLAv5UMN8gJtJsyFWCNia1dvR1IpCrecdg3qtiS7ya80FAwXC/x2/M1RRXt4G4OBAHRpS4jMnnkB7Yrb7DvAnM/dYSxgVO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=obMQfawo; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=4FJiaTk4fo+4Xs6DTIJxX76pXONpkLqW14IHY2GjctM=; b=obMQfawoPkiSkZmC97gYWgW5xo
	9nvLnvMPOHHpqk5UVal9c4tTyRdfB4I6ZWi4f+iTNcxuL1WcOHsqmHHXuVsbo7MH01rM+WY+uZe7p
	MJHSBfCt5rBJZVco0GcdDOjppA2OnXXPZzRiUqPTxgT7iUZkZdhzYErC+Q6uv5Ax5EV5UoQzlhN7k
	FoyPq5pJtqRfM64qg4plicVOGiqdhJbJ95k6NY7tnifmSBBecXa1qqbCbD6koDi3EUtnbpEx/nB2N
	1Kuv67zGqsIqaAjCO/0vtO2N7qn0kfeg2ytLyZV4tI5g3ASer6FGNsZiSOPaW3ug+YHnFPO6U2Rmh
	V1MChOrA==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1virMc-008OaH-Bf; Thu, 22 Jan 2026 10:52:30 +0100
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
In-Reply-To: <aXEjX7MD4GzGRvdE@fedora> (Horst Birthelmer's message of "Wed, 21
	Jan 2026 20:12:49 +0100")
References: <CAOQ4uxhMtz6WqLKPegRy+Do2UU6uJvDOqb8YU6=-jAy98E5Vfw@mail.gmail.com>
	<645edb96-e747-4f24-9770-8f7902c95456@ddn.com>
	<aWFcmSNLq9XM8KjW@fedora> <877bta26kj.fsf@wotan.olymp>
	<aXEVjYKI6qDpf-VW@fedora>
	<03ea69f4-f77b-4fe7-9a7c-5c5ca900e4bf@bsbernd.com>
	<aXEbnMNbE4k6WI7j@fedora>
	<5d022dc0-8423-4af2-918f-81ad04d50678@ddn.com>
	<aXEhTi2-8DRZKb_I@fedora>
	<e761b39b-79c7-40d4-947e-a209fcf2bb6b@ddn.com>
	<aXEjX7MD4GzGRvdE@fedora>
Date: Thu, 22 Jan 2026 09:52:23 +0000
Message-ID: <87pl726kko.fsf@wotan.olymp>
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
	TAGGED_FROM(0.00)[bounces-75001-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[ddn.com,bsbernd.com,gmail.com,szeredi.hu,kernel.org,vger.kernel.org,jumptrading.com,igalia.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luis@igalia.com,linux-fsdevel@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wotan.olymp:mid,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: A2FB264F88
X-Rspamd-Action: no action

Hi!

On Wed, Jan 21 2026, Horst Birthelmer wrote:

> On Wed, Jan 21, 2026 at 08:03:32PM +0100, Bernd Schubert wrote:
>>=20
>>=20
>> On 1/21/26 20:00, Horst Birthelmer wrote:
>> > On Wed, Jan 21, 2026 at 07:49:25PM +0100, Bernd Schubert wrote:
>> >>
>> >>
>> > ...
>> >>> The problem Luis had was that he cannot construct the second request=
 in the compound correctly
>> >>> since he does not have all the in parameters to write complete reque=
st.
>> >>
>> >> What I mean is, the auto-handler of libfuse could complete requests of
>> >> the 2nd compound request with those of the 1st request?
>> >>
>> > With a crazy bunch of flags, we could probably do it, yes.
>> > It is way easier that the fuse server treats certain compounds
>> > (combination of operations) as a single request and handles
>> > those accordingly.

Right, I think that at least the compound requests that can not be
serialised (i.e. those that can not be executed using the libfuse helper
function fuse_execute_compound_sequential()) should be flagged as such.
An extra flag to be set in the request should do the job.

This way, if this flag isn't set in a compound request and the FUSE server
doesn't have a compound handle, libfuse could serialise the requests.
Otherwise, it would return -ENOTSUPP.

>> Hmm, isn't the problem that each fuse server then needs to know those
>> common compound combinations? And that makes me wonder, what is the
>> difference to an op code then?
>
> I'm pretty sure we both have some examples and counter examples in mind.
>
> Let's implement a couple of the suggested compounds and we will see=20
> if we can make generic rules. I'm not convinced yet, that we want to
> have a generic implementation in libfuse.
>
> The advantage to the 'add an opcode' for every combination=20
> (and there are already a couple of those) approach is that
> you don't need more opcodes, so no changes to the kernel.
> You need some code in the fuse server, though, which to me is
> fine, since if you have atomic operations implemented there,
> why not actually use them.
>
> The big advantage is, choice.
>
> There will be some examples (like the one from Luis)
> where you don't actually have a generic choice,
> or you create some convention, like you just had in mind.
> (put the result of the first operation into the input
> of the next ... or into some fields ... etc.)

So, to summarise:

In the end, even FUSE servers that do support compound operations will
need to check the operations within a request, and act accordingly.  There
will be new combinations that will not be possible to be handle by servers
in a generic way: they'll need to return -EOPNOTSUPP if the combination of
operations is unknown.  libfuse may then be able to support the
serialisation of that specific operation compound.  But that'll require
flagging the request as "serialisable".

Cheers,
--=20
Lu=C3=ADs

