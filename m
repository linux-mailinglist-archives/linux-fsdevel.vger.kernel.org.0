Return-Path: <linux-fsdevel+bounces-77191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COLULJa2j2mpSwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 00:41:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1565413A073
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 00:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A36D303F077
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 23:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB44C33B6F0;
	Fri, 13 Feb 2026 23:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="fCtNIvJO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EDB285C98
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 23:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771026063; cv=none; b=L4oBeWmubiMOlzVG+mlj+H1Tk2cfbWdo41elof+McUPQoH+1vhiC5nwh2QB8HMqBc9xstzzuIxHp4qjPlWWCJvdocFJDEe4pmIcYKJrTHx1/7VpzrpjLKnzLLVPtUBYUWeLramkTDBPkeYODsc4TVt0shgCZXT1cTGIRjaMO7nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771026063; c=relaxed/simple;
	bh=nVAg5uymM79Q8Tpw7L7KHUmUEf+4b1gxzpGaMJnK8fQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=e3f5HPb490mWNyztfoOUU+m7QUDDsv/nO3xMv9OQTY+h6Skh1dRLxvkykvn9IGdIbb8CFfPfJCT2S9CBnqJ/Yj75fdR0dcInlJTilhAtcm+ECgbAyQWUBFbriv8gRUGfdFbla5wFXLNIoWXdTm/2JP0T6CGeLenWtQ3+XVmSAPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=fCtNIvJO; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 61DNeg351039255
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 13 Feb 2026 15:40:42 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 61DNeg351039255
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1771026043;
	bh=ewsxZNzSz/YSBTA/lR3Wy3Wj0hJvTFd5ZNSmuQThrNo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=fCtNIvJOJ9L41qIkZAqFw3yrSbA4ny3+Fnx76rnzBgdikMP8roWxJpJ5WJNkgS8c3
	 0TfU0ra0rhjmcM6fd5qYzfDoF1+bqACy2wIbqh8gQOySUnIQWaV3UNMLgUMGlIu30V
	 dEmu8BCvfrAuaKBHVRMvYmvUr0/3pvScIMPUbdgyfXPp+buJj5xCxd1ZOWbOzzyGD7
	 SGQhWW2N1itZA0PW/ED4DvMkzrPp+Y9Z2nWrXCvWE/JE4TIdOwBPb1UKvzOxoxHsV2
	 SSmqIQNMkOpNnro1/kF+oInAla5SalmPSGGlePwSk7+xGWzVHsBAOVSGPC1rjp8Frp
	 qPHYH1d1/QNPg==
Date: Fri, 13 Feb 2026 15:40:37 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: Askar Safin <safinaskar@gmail.com>, christian@brauner.io,
        cyphar@cyphar.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org, werner@almesberger.net
Subject: Re: [RFC] pivot_root(2) races
User-Agent: K-9 Mail for Android
In-Reply-To: <20260213234147.GS3183987@ZenIV>
References: <1FC2FB1F-BDA5-472D-A7DB-D146F6F75B16@zytor.com> <20260213174721.132662-1-safinaskar@gmail.com> <1caf6a70-e49b-42c7-81d0-bd0d6f5027bf@zytor.com> <20260213222521.GQ3183987@ZenIV> <92837188-C667-4A2A-9D34-85E5F1A5D597@zytor.com> <20260213234147.GS3183987@ZenIV>
Message-ID: <5F1429A9-A1BF-4FF1-A33F-4CE29C423419@zytor.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77191-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,brauner.io,cyphar.com,suse.cz,vger.kernel.org,linux-foundation.org,almesberger.net];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1565413A073
X-Rspamd-Action: no action

On February 13, 2026 3:41:47 PM PST, Al Viro <viro@zeniv=2Elinux=2Eorg=2Euk=
> wrote:
>On Fri, Feb 13, 2026 at 03:00:49PM -0800, H=2E Peter Anvin wrote:
>
>> Incidentally, how is =2E treated?
>
>Explicit no-op at any point of pathname=2E  "=2E=2E" is
>	while dentry =3D=3D root(mount) && (mount,dentry) !=3D nd->root
>		(mount,dentry) =3D under(mount, dentry)
>	if (mount,dentry) !=3D nd->root
>		dentry =3D parent(dentry)
>	step_into(dentry)
>and crossing into overmounts (if any) happens in step_into()=2E
>
>See handle_dots() and its callers=2E=2E=2E

Ok, I was just curious=2E

