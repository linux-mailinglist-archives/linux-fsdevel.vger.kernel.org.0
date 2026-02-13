Return-Path: <linux-fsdevel+bounces-77176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOl1NQyFj2mRRQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 21:09:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3E113953E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 21:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A3DCE3018B9A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 20:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE3326E6F2;
	Fri, 13 Feb 2026 20:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="tb4RRWb9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AC51F9ECB
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 20:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771013364; cv=none; b=SvNSLUkdgyL9slY2mR7bs/G5rr4aEUMd7nzj4113GH59Ka9e1u9CMdmJ7mbBIRc1eqNH7wbMehCK2YEqayY9W7GEAnMVr65tqipM2A7fWM+8Sv3Brm5eWkUvoO8IMgV2YWqc8CCTH55xqpe6p4EFWhr2nmDMPm/q93Sc0nn3Iq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771013364; c=relaxed/simple;
	bh=3i16EHAQpw9uMZ2ioNTzC4k8VVjEmAHkCv/k/8oZngY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJEUSpuzoSkhhMfakqrRmfMJ4iFyfGnjTfhAUgbMpgg85cadKGfMZaN8lFGCHVI4x9dwnxo1PChxJ3gLPCtH0sIVxvs5LfbV4UQzegqTZMrQmtg7vDxpUKvnzpyyIPErEkNTXdeO56eB3tE2pra+UjRZjLMLhvi0HnqeKk2xB1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=tb4RRWb9; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2607:fb90:3709:ce04:bf4c:86df:148a:f3f5] ([IPv6:2607:fb90:3709:ce04:bf4c:86df:148a:f3f5])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 61DK8C9O947670
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 13 Feb 2026 12:09:01 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 61DK8C9O947670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1771013344;
	bh=BBGVmzPwic8t1TTmFkvnrAF/eqD9Q/6qbYj0G+64LxM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tb4RRWb9BbBHC529h6nxLpnUmEkSVaaNs+Orcg52dtu13xo+wDyRp9hr/WIFviRVV
	 4XkHwZaPjgd92V3v/rN4GgfbO8bRMd4Bbzho6sJx5NAaMx0F47CJ/bD+Ps4M17lyZV
	 fjvsEageuPsjpRPz3tinrtV5lDe1Ezc/lElGxfN+zOFUt4suOcneqvj5hQY3bUX4PE
	 4Ba2pZnhl+SdhizqO+pkxGE0p/AffI1Lnn42z0kAmfeUqa1FFStgKL6ilUJjYSnZxF
	 U4sGKBjHDIvhUIFh3/bHmrEJCsHywji9x9cj0WoLVrDrpoke3KaxO3w2vH6FI/IsOx
	 Wqfoas2DlO/aQ==
Message-ID: <e4f5c818-205b-4450-9ffa-0dba8757b6f8@zytor.com>
Date: Fri, 13 Feb 2026 12:08:10 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] pivot_root(2) races
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Askar Safin <safinaskar@gmail.com>,
        christian@brauner.io, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, werner@almesberger.net
References: <CAHk-=wikNJ82dh097VZbqNf_jAiwwZ_opzfvMr-8Ub3_1cx3jQ@mail.gmail.com>
 <20260212171717.2927887-1-safinaskar@gmail.com>
 <CAHk-=wgS5T7sCbjweEKTqbT94XxmcPzppz6Mi6b8nKve-TFarg@mail.gmail.com>
 <2026-02-13-bronze-curly-digs-hopes-6qdLKp@cyphar.com>
 <4007566C-458F-45C3-BA9A-D99BCF8F16B4@zytor.com>
 <CAHk-=wgQDOUff_F28xaTB-BvSHs9YC3bxXJa0HjpSTAUyPF-Ew@mail.gmail.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <CAHk-=wgQDOUff_F28xaTB-BvSHs9YC3bxXJa0HjpSTAUyPF-Ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026012301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cyphar.com,gmail.com,brauner.io,suse.cz,vger.kernel.org,zeniv.linux.org.uk,almesberger.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-77176-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[zytor.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DC3E113953E
X-Rspamd-Action: no action

On 2026-02-13 09:47, Linus Torvalds wrote:
> On Fri, 13 Feb 2026 at 07:04, H. Peter Anvin <hpa@zytor.com> wrote:
>>
>> On February 13, 2026 5:46:34 AM PST, Aleksa Sarai <cyphar@cyphar.com> wrote:
>>>
>>> I think the init(rd) people will care more -- my impression this was
>>> only really needed because of the initrd switch (to change the root of
>>> kthreads to the new root)?
>>
>> That was the original motivation, yes. The real question is if they are anytime out there abusing it in other ways...
> 
> I guess we could just try it.
> 
> How does something like this feel to people?
> 
> I also changed the name from 'chroot' to 'pivot'. Comments?
> 
> Entirely untested in every way possible.
> 

Before doing anything else I would like to see if we can simply get rid of
that behavior completely, regardless of which process is running it. As I
posted in another email, it was always recommended to not rely on this
behavior since the beginning -- whether or not everyone listened is a whole
other ball of wax.

So to be correct: it was Werner who wrote pivot_root(8) for klibc as well,
this is literally the entire file:

> /* Change the root file system */
> 
> /* Written 2000 by Werner Almesberger */
> 
> #include <stdio.h>
> #include <sys/mount.h>
> 
> int main(int argc, const char **argv)
> {
>         if (argc != 3) {
>                 fprintf(stderr, "Usage: %s new_root put_old\n", argv[0]);
>                 return 1;
>         }
>         if (pivot_root(argv[1], argv[2]) < 0) {
>                 perror("pivot_root");
>                 return 1;
>         }
>         return 0;
> }

kinit from klibc never used pivot_root(), as it was specifically intended to
exist in the world of initramfs in rootfs and replace any further in-kernel
mounting code.

It was definitely a mistake to make initramfs == rootfs. rootfs should have
been nullfs, which is being fixed now, finally.

	-hpa


