Return-Path: <linux-fsdevel+bounces-77237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNh/FTcYkWl8fAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 01:49:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8FB13DD5E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 01:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AE893013730
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 00:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C63A1FECCD;
	Sun, 15 Feb 2026 00:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="U3cCV4rF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB79015ADB4
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Feb 2026 00:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771116593; cv=none; b=us+CDpmc/iP/lpzG+ddjM5mP5k40POY/D9x8+9DLWlh6sMsBh+20ZeiKowQaUSsnZLSefqPqSNDvcMo+Q02Cnh2nupvX14vBs45rL0affxSPS+dZ1DWQzNaKTFqO1E8xyLhiZHPtWovB7brQ1Sm2/RLa1RRoo+I8lQN9jdhmLDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771116593; c=relaxed/simple;
	bh=wk2Db1EOBKWK24Vs3UbAWk9XamXIVWJo/Tl0/SV13X4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=knkuQb/YSDHTPT2xezeFL4ySxCZp7bXpbgoOGCeDjwT9/kZZCyjq1QimbjjfrGGIdValq0L1xOjoCFYQGQ7fzWrHSuRfN9whFWGM71iMXB2RvNrr0VsxUzc63sk75aQ6WFvrPelFVYnnsojlsmdVx8da5H0mlcULNPra/1LUx1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=U3cCV4rF; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 61F0nY6U1884363
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 14 Feb 2026 16:49:34 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 61F0nY6U1884363
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1771116575;
	bh=wk2Db1EOBKWK24Vs3UbAWk9XamXIVWJo/Tl0/SV13X4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=U3cCV4rFyyS3cTyNlTQzioBhyUQzR4ksgk/QryLX0XiyYzG1OI2sFg3jvVZcQiQ1C
	 YxZDfjNmT0UQlqlTIJkEfIQfYpnVr1wDkA8Oyah2p8rJjTDSzMxlHkJhJupl5TjJIX
	 Hv7CBEOgl0WpWUufa3Angu35vnxyCmyYTC4LZBGSURCiAoBn3WXfVSMzkjOicSt95E
	 ugOxufCHs6z7BTgGcUADw3hKcnFTYf9rLS1N6w10tOel4G6H6BqSyxczMvLailrgOd
	 nHqC9l6cZ3CQH+Mp33r+Xdm5RjoI893WfOVm5uLKnrMvRMOzCKspiEkYjmNuYFsDPu
	 3wQ1Sv8OzY8kQ==
Date: Sat, 14 Feb 2026 16:49:28 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Askar Safin <safinaskar@gmail.com>
CC: christian@brauner.io, cyphar@cyphar.com, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, werner@almesberger.net
Subject: Re: [RFC] pivot_root(2) races
User-Agent: K-9 Mail for Android
In-Reply-To: <20260214162039.1388837-1-safinaskar@gmail.com>
References: <92837188-C667-4A2A-9D34-85E5F1A5D597@zytor.com> <20260214162039.1388837-1-safinaskar@gmail.com>
Message-ID: <C2C0C6F5-D882-4F5A-83E8-CF97B6BC1642@zytor.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026012301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77237-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[zytor.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zytor.com:mid,zytor.com:dkim,zytor.com:email]
X-Rspamd-Queue-Id: CA8FB13DD5E
X-Rspamd-Action: no action

On February 14, 2026 8:20:39 AM PST, Askar Safin <safinaskar@gmail=2Ecom> w=
rote:
>"H=2E Peter Anvin" <hpa@zytor=2Ecom>:
>> Well, it ought to be easy to make the kernel implicitly prefix /=2E=2E/=
 for kernel-upcall pathnames
>
>If some kernel thread executes user mode helper /=2E=2E/sbin/modprobe , t=
hen
>the thread will execute right binary, but still with wrong root (so modpr=
obe
>program itself will likely misbehave)=2E
>

You're right=2E What is really needed is chroot("/=2E=2E") before the exec=
=2E=20

I was thinking of file accesses like firmware=2E

