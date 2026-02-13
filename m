Return-Path: <linux-fsdevel+bounces-77145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILb5IG09j2mtNgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 16:04:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E7C13764A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 16:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFFE03023051
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 15:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA8D3612C8;
	Fri, 13 Feb 2026 15:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="3d1HQObh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3517244694
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 15:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770995050; cv=none; b=P47E8m4Sa54EDD4tqrWYpk+CAhsjOzImsqjIP0rgGs9WHCdUUukOzX1WnLHmD/0qThhiOnBcXECmtn/jxtLJUQeKfv0571SqzJyYT39RDGGXvKNmlT0JziR5ra/qGeF0U1U+uvNgeUKNZXHP04Exxbd6V8of1jQW78G4JCSQggs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770995050; c=relaxed/simple;
	bh=iziwASgbDf451fNnBWT2hmLAV7UoyGj+TY2iBQAaxwg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Yz7PGojSHa80C8MN4g4VkNvC483htoNjN5jsKZnY3aTavl6bzDeu0V+6hGp+CRZ0gpZ7qMY2oDE56iCtiJhFTOOgnQO1BWF+2/BK+RZpXp0bY5UPJbjOBODYAdplvBjfKw1hyW8SfqIwDqJHS/8i2IQ/n4tHJTkMZCFieKJy4cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=3d1HQObh; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 61DF3Yc4827216
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 13 Feb 2026 07:03:35 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 61DF3Yc4827216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1770995015;
	bh=yyRoVAqO1pBd+FWso7opMUD94VlBZt0CW5NF1iV+qmM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=3d1HQObhMMEeCF+v8bMZAA/VMOsyJcqr9XKdX9pKd0lqKzS0MHoLwXgTwoKnjUXCT
	 4O2I6xWdNvT8C9v2qqbnGYPaHIw40rQkSGuDSp2Sxs+UmGdvaT1J3oIHByCtp/2oGh
	 Lgei932+30j6aUxym2HRsq6hhOB65T+GicErSnvB6XksNBeXkpzQ8/M642OQNTSsT2
	 mi4MarJBGqBsu0KD/bCw4BEmJK3Vg4m4rBSP7GbIfXEI93YPiZ/i2O1a1mVxgAcNEE
	 43J3Io+jEx2GZCas9585fYjGboh9/MV6aL6dtxajiyjrfZr7BCov8Zcp6Gvree4TF6
	 XSrLO0uVYdA8w==
Date: Fri, 13 Feb 2026 07:03:29 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC: Askar Safin <safinaskar@gmail.com>, christian@brauner.io, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        werner@almesberger.net
Subject: Re: [RFC] pivot_root(2) races
User-Agent: K-9 Mail for Android
In-Reply-To: <2026-02-13-bronze-curly-digs-hopes-6qdLKp@cyphar.com>
References: <CAHk-=wikNJ82dh097VZbqNf_jAiwwZ_opzfvMr-8Ub3_1cx3jQ@mail.gmail.com> <20260212171717.2927887-1-safinaskar@gmail.com> <CAHk-=wgS5T7sCbjweEKTqbT94XxmcPzppz6Mi6b8nKve-TFarg@mail.gmail.com> <2026-02-13-bronze-curly-digs-hopes-6qdLKp@cyphar.com>
Message-ID: <4007566C-458F-45C3-BA9A-D99BCF8F16B4@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026012301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77145-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,brauner.io,suse.cz,vger.kernel.org,zeniv.linux.org.uk,almesberger.net];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[zytor.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cyphar.com:email,linux-foundation.org:email]
X-Rspamd-Queue-Id: E7E7C13764A
X-Rspamd-Action: no action

On February 13, 2026 5:46:34 AM PST, Aleksa Sarai <cyphar@cyphar=2Ecom> wro=
te:
>On 2026-02-12, Linus Torvalds <torvalds@linux-foundation=2Eorg> wrote:
>> On Thu, 12 Feb 2026 at 09:17, Askar Safin <safinaskar@gmail=2Ecom> wrot=
e:
>> >
>> > In my opinion this is a bug=2E We should make pivot_root change cwd a=
nd root
>> > for processes in the same mount and user namespace only, not all proc=
esses
>> > on the system=2E (And possibly also require "can ptrace" etc=2E)
>>=20
>> Yeah, I think adding a few more tests to that
>>=20
>>                 fs =3D p->fs;
>>                 if (fs) {
>>=20
>> check in chroot_fs_refs() is called for=2E
>>=20
>> Maybe just make it a helper function that returns 'struct fs_struct'
>> if replacing things is appropriate=2E  But yes, I think "can ptrace" is
>> the thing to check=2E
>>=20
>> Of course, somebody who actually sets up containers and knows how
>> those things use pivot_root() today should check the rules=2E
>
>For containers, we don't actually care about chroot_fs_refs() for other
>processes because we are the only process in the mount namespace when
>setting it up=2E
>
>In fact, I'd honestly prefer if chroot_fs_refs() would only apply to (at
>most) the processes in the same mount namespace -- the fact this can
>leak to outside of the container is an anti-feature from my perspective=
=2E
>(But the new OPEN_TREE_NAMESPACE stuff means we might be able to avoid
>pivot_root(2) entirely soon=2E Happy days!)
>
>I think the init(rd) people will care more -- my impression this was
>only really needed because of the initrd switch (to change the root of
>kthreads to the new root)?
>

That was the original motivation, yes=2E The real question is if they are =
anytime out there abusing it in other ways=2E=2E=2E

