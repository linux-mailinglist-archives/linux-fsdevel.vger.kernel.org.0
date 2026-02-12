Return-Path: <linux-fsdevel+bounces-77055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHZFLQMrjmn5AQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 20:33:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC52130BB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 20:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0188E31298F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 19:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFAA2D5C7A;
	Thu, 12 Feb 2026 19:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="fo1MUWkn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE12274B44
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 19:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770924712; cv=none; b=hKtryr1LcKjLyPEfdu37Zd7lljf+bgwULHKnpkuf/8NJCnibVQB2pV3IBFyq3TZEdGeXTsC6ABKkT278SR5uSgQuPjoX9rD3FLuqPw4FS1GB5kCllxyLxVazy+Vuzv/SrJw/ZiJAr56wG92XNvzLwvszzVHlf+myEk6cjH4W++g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770924712; c=relaxed/simple;
	bh=2kkjPPH2QPwRg2MCEe/sJUhcaECBkTZK+aA2EVet3Vw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=eJ60v4IUthTkH28B0BES8S2XPlxKmnFeii1e8SuL4LXRiVqTnhNwBo64j3AmYftRoJ+bZ/p3yAFh1TtIl7L8a4lcQMdOU/Ljtgm7b6nJVh31dub+0SVxeVAnMKXku8EknSh4qRcbHGeI1USw03stzovH0/ETK2a5OyvBry/OKPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=fo1MUWkn; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 61CJVRh7401104
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 12 Feb 2026 11:31:27 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 61CJVRh7401104
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1770924688;
	bh=AyXa9GZtBEnIiXEIZ0mPCnHS4e91MoQMFwxi7DtMyYc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=fo1MUWknBPcoj93so/4/zetL3Er+sk24L3PTOKyZAFTpccZz8829kQ8i5bEc2807h
	 qLF1Ti3tSU/1OerOieIU3Ts3UqagNiPjxHNipOPUr4vQmWuGfPl6sZ0ru4PtxEknDn
	 G+x3yHxl2dctYf08eYBeunBxPfu6QFrYQfhmDf3g13f53gjaTaIpyFiaL3zALYJw6Z
	 h+cbt/vsL+GDK9b4Ti/B+jBvqwdkILJpz7opw777wFpQCbtWqALATdNGupNZNyAkrQ
	 CSeKZ4jEgVio3TJvU4JT1Bd8oIoB3+AKXfvJ2uCgx0NT2g8tBsHdLiOXjq1W/NBKG7
	 IpWZE5sksUc+Q==
Date: Thu, 12 Feb 2026 11:31:19 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Askar Safin <safinaskar@gmail.com>
CC: christian@brauner.io, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, werner@almesberger.net,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [RFC] pivot_root(2) races
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wgS5T7sCbjweEKTqbT94XxmcPzppz6Mi6b8nKve-TFarg@mail.gmail.com>
References: <CAHk-=wikNJ82dh097VZbqNf_jAiwwZ_opzfvMr-8Ub3_1cx3jQ@mail.gmail.com> <20260212171717.2927887-1-safinaskar@gmail.com> <CAHk-=wgS5T7sCbjweEKTqbT94XxmcPzppz6Mi6b8nKve-TFarg@mail.gmail.com>
Message-ID: <1FC2FB1F-BDA5-472D-A7DB-D146F6F75B16@zytor.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026012301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77055-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[zytor.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email,zytor.com:mid,zytor.com:dkim]
X-Rspamd-Queue-Id: 1BC52130BB3
X-Rspamd-Action: no action

On February 12, 2026 11:11:55 AM PST, Linus Torvalds <torvalds@linux-founda=
tion=2Eorg> wrote:
>On Thu, 12 Feb 2026 at 09:17, Askar Safin <safinaskar@gmail=2Ecom> wrote:
>>
>> In my opinion this is a bug=2E We should make pivot_root change cwd and=
 root
>> for processes in the same mount and user namespace only, not all proces=
ses
>> on the system=2E (And possibly also require "can ptrace" etc=2E)
>
>Yeah, I think adding a few more tests to that
>
>                fs =3D p->fs;
>                if (fs) {
>
>check in chroot_fs_refs() is called for=2E
>
>Maybe just make it a helper function that returns 'struct fs_struct'
>if replacing things is appropriate=2E  But yes, I think "can ptrace" is
>the thing to check=2E
>
>Of course, somebody who actually sets up containers and knows how
>those things use pivot_root() today should check the rules=2E
>
>               Linus

It would be interesting to see how much would break if pivot_root() was re=
stricted (with kernel threads parked in nullfs safely out of the way=2E)

I have gotten a feeling that pivot_root() is used today mostly due to conv=
enience rather than need=2E

