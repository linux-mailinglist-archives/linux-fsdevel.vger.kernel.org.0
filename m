Return-Path: <linux-fsdevel+bounces-77175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEAUDfiCj2lTRQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 21:00:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 839B51394CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 21:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9D6E30305C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 20:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D79F339A8;
	Fri, 13 Feb 2026 20:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="QSUiSSb3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2D69443
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 20:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771012850; cv=none; b=ozDsXGgxcrcyJ7QtaQd/Il4q7+zkUSBWZLFmeUCu8k7MC2USkyAgp9cqN3NAko+c/hZIyiSZN8QUQK3Gh8WkDVqETq5T4PT03wZivgExGjZyMPCvvbuTCGT6TZCyVjrWCRa1F0l+wBfBqYUAKwyJByErpRfTGn3bNql7I04RZL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771012850; c=relaxed/simple;
	bh=43V9QkwULXbMLfDHcawson2l5RZ7e+3T4tZdezLYJvo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FAtvjVTOZixUnHaJxhJAi+moQbK3Mccg7t6aaa7DdeyR+MsLMq2KMw+BmC5zc6O3GiKA+SI3Y7uCt5sg7vgiHuovoTjBcXNRtfn5h7YVJ553lV1ewIGxWO29u4BL612gwjrT6GmarTdIMNKyzbfl8g5G19aOm1NwfYxQtlmC5Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=QSUiSSb3; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2607:fb90:3709:ce04:bf4c:86df:148a:f3f5] ([IPv6:2607:fb90:3709:ce04:bf4c:86df:148a:f3f5])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 61DK0AOm944664
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 13 Feb 2026 12:00:13 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 61DK0AOm944664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1771012816;
	bh=Ng+OGrcrDBDhNDdtESWgKziI/7dJR1RhSjRq8VeioWI=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=QSUiSSb3Rw49rHJhS7nL9EfFLAEYbQE066TScBpKjv8eW3ZuHugx3UEgcCp2YGc+4
	 J+RFKrcZ+5ga86ce1XYVrptwfHVTSpVG/XYLgCpl+oCjkX9iB0gkhmq4F9GtTKTear
	 +MVsb5Cr9rd+VJERF879h7IgdBFYMyYaUsR2boRZDos/Td+yvME+glf1c6GbqbRRUP
	 JKvPn5vqOIeWGy3rgs2gm3ia1vC6lx5NUlnv1sFwmRcYT2mqRYnXnoWGCauOr0X6yh
	 +9FDXc0rvKCFzMIofXilQaa0UhTocw7dq8wn1bxuWQ/eT5LHOeyx74wS+BE3by21lK
	 Dn/S5Ler37K8w==
Message-ID: <f5050b26-e5bd-41b9-8b3e-1b87888095a8@zytor.com>
Date: Fri, 13 Feb 2026 12:00:10 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] pivot_root(2) races
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Askar Safin <safinaskar@gmail.com>
Cc: christian@brauner.io, cyphar@cyphar.com, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        werner@almesberger.net
References: <CAHk-=wgQDOUff_F28xaTB-BvSHs9YC3bxXJa0HjpSTAUyPF-Ew@mail.gmail.com>
 <20260213182732.196792-1-safinaskar@gmail.com>
 <CAHk-=wiB7BN2BnBjk5y2Zim_vveYg7GAZA_N+XjrptY59Qnzzw@mail.gmail.com>
Content-Language: en-US, sv-SE
In-Reply-To: <CAHk-=wiB7BN2BnBjk5y2Zim_vveYg7GAZA_N+XjrptY59Qnzzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-77175-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 839B51394CE
X-Rspamd-Action: no action

On February 13, 2026 10:39:58 AM PST, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>On Fri, 13 Feb 2026 at 10:27, Askar Safin <safinaskar@gmail.com> wrote:
>>
>> pivot_root was actively used by inits in classic initrd epoch, but
>> initrd is not used anymore.
>
>Well, debian code search does find it being used in systemd, although
>I didn't then chase down how it is used.
>
>Of course, Dbian code search also pointed out to me that we have a
>"pivot_root" thing in util-linux, so apparently some older things used
>an external program and that "&init_task" check wouldn't work anyway.
>
>             Linus

Yeah, no doubt. The real question is how much it actually matters as long as
there aren't kernel threads in the way.

I think I wrote a pivot_root(8) for klibc too (* which I now note has a harder
to use equivalent in the girl of nolibc in the kennel tree ;) *)

Either way, the documented way to use pivot_root(8) is not to rely on it to
change the actual process root at all [the same caveats are supposed to apply
to pivot_root(2), but was not written down in that man page:

>        Note that, depending on the implementation of pivot_root, root and
>        current working directory of the caller may or may not change. The
>        following is a sequence for invoking pivot_root that works in either
>        case, assuming that pivot_root and chroot are in the current PATH:
> 
>            cd new_root
>            pivot_root . put_old
>            exec chroot . command
> 
>        Note that chroot must be available under the old root and under the
>        new root, because pivot_root may or may not have implicitly changed
>        the root directory of the shell.
> 
>        Note that exec chroot changes the running executable, which is
>        necessary if the old root directory should be unmounted afterwards.
>        Also note that standard input, output, and error may still point to a
>        device on the old root file system, keeping it busy. They can easily
>        be changed when invoking chroot (see below; note the absence of
>        leading slashes to make it work whether pivot_root has changed the
>        shell’s root or not).


This was the originally intended operation, and the "chrooting all processes"
(for some definition of "all") was specifically to deal with the problem of
kernel threads holding the old root busy.

The description for how to deal with an NFS mount makes it even more clear
that the chrooting of other processes is NOT an architectural promise:

>            ifconfig lo 127.0.0.1 up   # for portmap
>            # configure Ethernet or such
>            portmap   # for lockd (implicitly started by mount)
>            mount -o ro 10.0.0.1:/my_root /mnt
>            killall portmap   # portmap keeps old root busy
>            cd /mnt
>            pivot_root . old_root
>            exec chroot . sh -c 'umount /old_root; exec /sbin/init' \
>              <dev/console >dev/console 2>&1

So if any real-life user of pivot_root(2|8) actually followed these
guidelines, things should Just Work[TM].

That, of course, is a big open question.

	-hpa


