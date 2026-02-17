Return-Path: <linux-fsdevel+bounces-77473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCHcIxL8lGm8JgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:38:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 110F7151F7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF902304812A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DC4328627;
	Tue, 17 Feb 2026 23:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xx8dlhIV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B5C3033E8
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 23:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771371529; cv=pass; b=t4NzuKFZZErvzOOZ73o0hwK3FW0QMzeEozJhJiDw2phikWpC5Ms4Am6QpeNLwK+NB58xgPB10lZyJ+L2pIq/+4F6ZfeKPkIzCdJ40BmN0KYGEv3xFcDqk/eWUU1G9TjApn/5pJwK9uueQ7kEmaIfxLghtKZIs0hr/ojgwVLiciM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771371529; c=relaxed/simple;
	bh=XsvTP6yiZvi4ytL1iQz+6Vp9+MFJkDvicMxuANenwRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l1rImPwEeG0aaYOzt5MY8wGsp4MM5DI5SggPYlygjFnVjJb6bUxa7tGPNL6lDDVwT8qq1qDSGJ2ybqRxvv4ycPXC6O/jhnZTtRvztkAcJaEWAs7ZWcvAVH2EXRaPp73aWf3Ei0XFs9abTnenrG513dBhzuH21ob4DKSLB+CbRaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xx8dlhIV; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-65821afe680so2478a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 15:38:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771371520; cv=none;
        d=google.com; s=arc-20240605;
        b=Zgfpuk56Ral9LzkSlMmna9ugsNoy1TB2ZO1JJPsB37t3EPIPqgch8Maesby04llMfa
         1WtbLwD4Urgju7A/kWkRg0wVFpqHoEmtEDXWSGLA6OzkhwW7VJ2pnUhcwI/ZoOlOz43Z
         l4zKtke/DPWo4YTowi4iHVCQ0diONWWfYO9yYAT6vifWKbCTagPQpmuSIQRaEX5MRW7w
         JSsq03Aang11Siur6/pydk3XNUAGmBWHRLf2vOZx+Rah2uUsItvTC6sqewpqopUDFLG+
         ySusZlLwYhl1OUaA4W113klnbD316Ih+88lmB3xrGXivItZqK1X/xcytKAW5AHLDK8UB
         MEsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XsvTP6yiZvi4ytL1iQz+6Vp9+MFJkDvicMxuANenwRc=;
        fh=v1KB5+ABlgyAKJT5nE8qcK20Qex3it2XzDL2Z9xSDAg=;
        b=Mby6Hij4cdjQYBrKi3UyHFBPhCtNogxZnBjLrCsmJ85jCTHC1YEEq3qFLT363ajJrs
         ruoxl+O0F00WOG3yPrdewRdLEql+kt6W0R51NsUBwPkmn2V85cGFSevd5bUzgvlaRA8w
         cm5QcVMdvXM46uQdntA6piJjNKc5/Qrpp8rQfer3IO7oNDiynFWmvmknjZfM8mah6PMW
         2jfTa6jcCymXdkpQcW2UPPYtkWRsxVtyS4fmSkwtIuPIZOxIME10pMhOaKwC9LX5YRmr
         hzdCTB7pAliWGLrvM4yR9hGBrzZS4fupW1kf+FgO8Z7SxxW/Nv7NjXgi4k6NLZFjVdOq
         iX1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771371520; x=1771976320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsvTP6yiZvi4ytL1iQz+6Vp9+MFJkDvicMxuANenwRc=;
        b=xx8dlhIVXm67kca9EMub8ZDeGyIRAbZZDyQKh4Oz8NMzZ3QbZdBivkbFDB0RVlKgeb
         siwQopVaIbGo+R34YEf0jYURkPxaOmIQGkdWdxrV/zNhqQSy1EHhPmZUwQKw4zycI5Ty
         45NE7UP87aQgfR8b+z7uHDKQKhI1zVKex18kVi6xV3nHuWVDpDjiFrqXsTYt6LtRp2ri
         gZDTgtQ0whqlEP1Shiid25efZE9bv0TCVG4wnnsTD/eujltylo1mu496crHK/FYbnnv7
         Dnz67ZdGQqcGXyAjHsqf+DOaLF66IRVMrZ9JLl1I9YPv/mi6szpXhKt6gjkAm55XUW/j
         sBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771371520; x=1771976320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XsvTP6yiZvi4ytL1iQz+6Vp9+MFJkDvicMxuANenwRc=;
        b=vP1JpQOTrPvE1r//JrfxUOXGXNPW90gDOnqC9Fc0rhryLa3RXTn5Ad2DyyfxoD5QUC
         dFCh1uuPbqBt+ooOSCZSjKF4LxQKOEF05mwdchjxLQnG7uN7Q0ajX0utJu4BJKCAWG4L
         pHkHBF/264IWXiO97Hz6KKATuiJFz7eki/ib6Ob+HAPmC55MnMblUoHSh8UM4RkqB7sa
         vISfPaM3xGwYOwo5RJqAZ47KsXFdg0b/FvDYFjRiVYl7838O81f9jWskF6hjr6EVEebB
         52+a0WsnY2fEf8wN5CeUIaRosxquPK3Z1wB/uALXnpJ+tMXMQYxiOr/m5VIX/zNvuaTD
         7+yg==
X-Forwarded-Encrypted: i=1; AJvYcCVQFVqY6UBiWQY4SBWeO2k4fE8MJo9wxYs+W4QkaZ7oM7NcpmeBnUoYmSljfVd5jJDoA3OUZNmD5+/FucCJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxnGmCmc78fuNfZdRu9L2x8m4wFq7D/O9UZNX/bce3kCpdwMD/D
	ZOfUEuGEOoaYec2nsJgbFxxacH3gO86N1vBw9ozj4+yEewSpm9siQKezr8iOqTrSF46BUjp5eVt
	MxsAIoo4GViPD41HUmW8s5W4iqGxFWc952Z/U7ZuxMmCc9oHGjIEIyUmfn3k=
X-Gm-Gg: AZuq6aKvV7kf+2z6IYLmZxPaPL9YiAptwRqio+tuIYf3KxfMsrwylUmh2NhBUpLahUD
	FwXJwBnEowRVpbg8Y82QzupXdDcBp3AeXtwqGteVRTRB0GBB3ppSQff3d4JSKByvLgjITrstNEe
	WIH+HAqq6cyDBc7BVNGu+GvTpCsN0Abj7AUscAieZUSVryg9RyscjZbyaiLng8e4GLb5aiGTK4U
	DKrRSE2tbUC4dAsphNTukkTn+xn6PR1y7QH9NkerT/BLkghvGdac59mJN9Xk9j3CwAdNWVoNhrW
	YGIiGZSxjUtaNpwwvt4+3NADczu5ucBgeLBXCsZcQdq4wu4=
X-Received: by 2002:a05:6402:13ce:b0:65a:14a1:b1b9 with SMTP id
 4fb4d7f45d1cf-65c77188b06mr1455a12.7.1771371519317; Tue, 17 Feb 2026 15:38:39
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217-work-pidfs-autoreap-v3-0-33a403c20111@kernel.org>
 <20260217-work-pidfs-autoreap-v3-2-33a403c20111@kernel.org> <CAHk-=wj80zwxy=5jp5SAi64cqCZgRjY1cRokVuDPd9_t3XMvUw@mail.gmail.com>
In-Reply-To: <CAHk-=wj80zwxy=5jp5SAi64cqCZgRjY1cRokVuDPd9_t3XMvUw@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 18 Feb 2026 00:38:02 +0100
X-Gm-Features: AaiRm50Ps_CeitSDHmzqYzFTXxSFjPFfTk80dkiB2eb-HFajAy_nyS26-bInmXc
Message-ID: <CAG48ez2YiL7RZ1fm9vwOCDGr9OsDrCHrCmkyRRoGRMWUZjyyBg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 2/4] pidfd: add CLONE_PIDFD_AUTOKILL
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-77473-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:email,mail.gmail.com:mid];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 110F7151F7A
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 12:18=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, 17 Feb 2026 at 14:36, Christian Brauner <brauner@kernel.org> wrot=
e:
> >
> > Add a new clone3() flag CLONE_PIDFD_AUTOKILL that ties a child's
> > lifetime to the pidfd returned from clone3(). When the last reference t=
o
> > the struct file created by clone3() is closed the kernel sends SIGKILL
> > to the child.
>
> Did I read this right? You can now basically kill suid binaries that
> you started but don't have rights to kill any other way.
>
> If I'm right, this is completely broken. Please explain.

You can already send SIGHUP to such binaries through things like job
control, right?
Do we know if there are setuid binaries out there that change their
ruid and suid to prevent being killable via kill_ok_by_cred(), then
set SIGHUP to SIG_IGN to not be killable via job control, and then do
some work that shouldn't be interrupted?

Also, on a Linux system with systemd, I believe a normal user, when
running in the context of a user session (but not when running in the
context of a system service), can already SIGKILL anything they launch
by launching it in a systemd user service, then doing something like
"echo 1 > /sys/fs/cgroup/user.slice/user-$UID.slice/user@$UID.service/app.s=
lice/<servicename>.scope/cgroup.kill"
because systemd delegates cgroups for anything a user runs to that
user; and cgroup.kill goes through the codepath
cgroup_kill_write -> cgroup_kill -> __cgroup_kill -> send_sig(SIGKILL,
task, 0) -> send_sig_info -> do_send_sig_info
which, as far as I know, bypasses the normal signal sending permission
checks. (For comparison, group_send_sig_info() first calls
check_kill_permission(), then do_send_sig_info().)

I agree that this would be a change to the security model, but I'm not
sure if it would be that big a change. I guess an alternative might be
to instead gate the clone() flag on a `task_no_new_privs(current) ||
ns_capable()` check like in seccomp, but that might be too restrictive
for the usecases Christian has in mind...

