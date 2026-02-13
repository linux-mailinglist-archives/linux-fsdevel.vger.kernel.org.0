Return-Path: <linux-fsdevel+bounces-77177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aB9KBimKj2nURQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 21:31:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 718471396EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 21:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B892D303AA8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 20:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F8127AC57;
	Fri, 13 Feb 2026 20:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="k107cytf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8450A1A3160
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 20:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771014491; cv=none; b=GStjBhXmrtgrpzxBPYc6XcWD0gAbLFnThnzBJPE9LvjU0EHZ7sbGF/VIZO74Hkcop9XOThJSm/7LLh5ceJi4Dm/psLZc4fxxFgXzgEz/EmuLsNDxww6ZjrPaY98zHXN0rfIA20kS1bOYX/+nuNopCCUYPUXhE5YMJwd/yBUhn6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771014491; c=relaxed/simple;
	bh=bV6u1QJ33pT9R5UtGl8hMGgpD+FE1GJqXFZPTfvj6bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZ+bLjii2TtF0f4nkYIu5l12VwKqC6t0WJ0EK6T8GA7D77dVKbrdR4c3LJG7M8chUmk+Gr+YF5EFz5iH4dVP3bVsEq0fUgHbyIGjduJaJbzALYIKO1oAd4WPpLRdq0djrpU2xw8jMq9FjvP+IJwawlr2BJF1K+jZR4KPR/J106Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=k107cytf; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2607:fb90:3709:ce04:bf4c:86df:148a:f3f5] ([IPv6:2607:fb90:3709:ce04:bf4c:86df:148a:f3f5])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 61DKRki4956354
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 13 Feb 2026 12:27:51 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 61DKRki4956354
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1771014473;
	bh=fr5Ww//soWpigRDforGRYrNXkcZA6CZ3CnzmCRHb9uY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k107cytfO4V+KuEu7H5+CVGJ8yj9RNPJRQjsr8Kcdb8EnV/uFukgrH+wNCThjvuFu
	 jblw2zSBdFc/ssn1x6lapSEIhUE5ASQXmZBGtdsSWWEy+qHmes/DbWb91lyOU5qShg
	 5UxZwQhauOeu6W5TVeWP8DTv3+4hzBCNHYFiiJLQwKEqxX7KwY/vdC6T+L2yu9vNAR
	 XPOCe0tTvD9GXITdBmaBLplqfDxpNL3c8+WiaF7gR/E64u0y5Qtog9bNt1tth3sfIF
	 t44wR46eO5/GkP1uutjMj063XJaDvXhmf8T9QnIW+pHFJBlkuJWReTgjPEhJO3PDno
	 vnON7aqq51Lnw==
Message-ID: <1caf6a70-e49b-42c7-81d0-bd0d6f5027bf@zytor.com>
Date: Fri, 13 Feb 2026 12:27:46 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] pivot_root(2) races
To: Askar Safin <safinaskar@gmail.com>
Cc: christian@brauner.io, cyphar@cyphar.com, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, werner@almesberger.net
References: <1FC2FB1F-BDA5-472D-A7DB-D146F6F75B16@zytor.com>
 <20260213174721.132662-1-safinaskar@gmail.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260213174721.132662-1-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026012301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77177-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[zytor.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zytor.com:mid,zytor.com:dkim,zytor.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 718471396EF
X-Rspamd-Action: no action

On 2026-02-13 09:47, Askar Safin wrote:
> "H. Peter Anvin" <hpa@zytor.com>:
>> It would be interesting to see how much would break if pivot_root() was restricted (with kernel threads parked in nullfs safely out of the way.)
> 
> As well as I understand, kernel threads need to follow real root directory,
> because they sometimes load firmware from /lib/firmware and call
> user mode helpers, such as modprobe.
> 

If they are parked in nullfs, which is always overmounted by the global root,
that should Just Work[TM]. Path resolution based on that directory should
follow the mount point unless I am mistaken (which is possible, the Linux vfs
has changed a lot since the last time I did a deep dive.)

	-hpa


