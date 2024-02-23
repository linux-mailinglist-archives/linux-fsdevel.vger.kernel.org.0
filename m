Return-Path: <linux-fsdevel+bounces-12628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8187B861F08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 22:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43B71C223B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 21:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB2E14AD04;
	Fri, 23 Feb 2024 21:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fc9fMdJW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C064B1493B6
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 21:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708723586; cv=none; b=RgQDk604l3Lzgj/Tk4Hlf8HvjkaVseSxMCcl28y8Emv5tV9a2hAU9+OYRY6PdqpgGXYytiHuNEerBPJ9Os8Jlh6vz2J9hhkxtf1aSpQgD9Q+oSa8DIjGiG0VH4MJi8vTo2LHR3HEYvXgssT2LZSQznblqaZ4Rm56ZpF8nLlVUw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708723586; c=relaxed/simple;
	bh=/UMBBO4plUyUH4SOp7YIoGKcqlyGlmv4B19OS+xAN98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHMMKDU8mCMheESOQjMRohFW7m7JeVz8LCnw+ru4vZwu2QQQ3uBH5vM1u0oLSMzkySMg26xS84Q54KjsWvt1FjhuU7/++WOIaVUS4PRfWVeeg1M+EXysErEtwEkfpqDm+jQI54OTg22raEcXOuUzkHrIuGl8gsS34xXPqld49HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fc9fMdJW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C20C433C7;
	Fri, 23 Feb 2024 21:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708723586;
	bh=/UMBBO4plUyUH4SOp7YIoGKcqlyGlmv4B19OS+xAN98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fc9fMdJW17jvW159gS8Br9ltki1AdzF1dfOsewIa+ZZU8pbxeyGUdBqQuKQ/6869K
	 dEzw4IrB/d0xxmT8peD9hI81/BRhnkunagQd8D2TvmiodelG2LNsRLwO4Jwmq6l1ql
	 T7btuJ+4vtZ4HtQzxwYkbJ9qdES4JKADpyI3IsfrcuVoMZJmdunVg3uJAoiE9kw07H
	 +y03zyV5x6e2qDKAzFHaKTTDOEwm1oQdAANaXBbOyjjxK6fYBGqxFSZcf5yduEErzz
	 pd5py87HqogXy6ggzDvFoGLAsmGtFBSsQTsyOl7XPi1jReMFe/c9GHrv1TUKvi22ba
	 QgSkViWuX/qzw==
Date: Fri, 23 Feb 2024 22:26:21 +0100
From: Christian Brauner <brauner@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>, 
	Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240223-schusselig-windschatten-a108c9034c5b@brauner>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
 <20240222190334.GA412503@dev-arch.thelio-3990X>
 <20240223-delfin-achtlos-e03fd4276a34@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240223-delfin-achtlos-e03fd4276a34@brauner>

On Fri, Feb 23, 2024 at 12:55:07PM +0100, Christian Brauner wrote:
> > Apologies if this has already been reported or fixed but I did not see
> > anything on the mailing list.
> > 
> > On next-20240221 and next-20240222, with CONFIG_FS_PID=y, some of my
> > services such as abrtd, dbus, and polkit fail to start on my Fedora
> > machines, which causes further isssues like failing to start network
> > interfaces with NetworkManager. I can easily reproduce this in a Fedora
> > 39 QEMU virtual machine, which has:
> > 
> >   # systemctl --version
> >   systemd 254 (254.9-1.fc39)
> 
> If something fails for completely inexplicable reasons:
> 
> Feb 23 12:09:58 fed1 audit[353]: AVC avc:  denied  { read write open } for  pid=353 comm="systemd-userdbd" path="pidfd:[709]" dev="pidfs" ino=709 scontext=system_u:system_r:systemd_userdbd_t:>
> 
> >   +SELINUX
> 
> pidfd creation can now be mediated by LSMs since we can finally go
> through the regular open path. That wasn't possible before but LSM
> mediation ability had been requested a few times.
> 
> In short, we have to update the selinux policy for Fedora. (Fwiw, went
> through the same excercise with nsfs back then.)
> 
> I've created a pull-request here:
> 
> https://github.com/fedora-selinux/selinux-policy/pull/2050
> 
> and filed an issue here:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=2265630
> 
> We have sufficient time to get this resolved and I was assured that this
> would be resolved. If we can't get it resolved in a timely manner we'll
> default to N for a while until everything's updated but I'd like to
> avoid that. I'll track that issue.

So I want to provide more context since I took the time to track this
all down in detail.

The failure you are seeing is indeed an selinux denial as I've pointed
out. The core failure is dbus-broker. That cascades into all the other
services failing. When dbus-broker fails to start polkit and all the
others won't be able to work because they depend on dbus-broker.

The reason for dbus-broker failing is because it doesn't handle failures
for SO_PEERPIDFD correctly. Last kernel release (either v6.7 or v6.6,
I'm not completely sure right now) we introduced SO_PEERPIDFD (and
SCM_PIDFD). SO_PEERPIDFD allows dbus-broker and polkit and others to
receive a pidfd for the peer of an AF_UNIX socket. This is the first
time in the history of Linux that we can safely authenticate clients in
a race-free manner. :)

dbus-broker immediately made use of this but messed up the error
checking. It only allowed EINVAL as a valid failure for SO_PEERPIDFD.
That's obviously problematic not just because of LSM denials but because
of seccomp denials that would prevent SO_PEERPIDFD from working; or any
other new error code from there.

So this is catching a flawed implementation in dbus-broker as well. It
_has_ to fallback to the old pid-based authentication when SO_PEERPIDFD
doesn't work no matter the reasons otherwise it'll always risk such
failures.

So, the immediate fix separate from the selinux policy update is to fix
dbus-broker which we've done now:

https://github.com/bus1/dbus-broker/pull/343

That should make it into Fedora asap as well.

The selinux reference policy is also updated in addition to the Fedora
policy:

https://github.com/bus1/dbus-broker/pull/343

So overall that LSM denial should not have caused dbus-broker to fail.
It can never assume that a feature released one kernel ago like
SO_PEERPIDFD can be assumed to be available.

