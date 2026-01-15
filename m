Return-Path: <linux-fsdevel+bounces-73909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C5CD23F00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 11:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 371783019046
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 10:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8D73624D9;
	Thu, 15 Jan 2026 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juimNJTS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45613624BE
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768472958; cv=none; b=ds3EdkI44uSiFMChvOXo6SuOkGA+R6LndnBzHQG+pYzgDpyJTiAn6/q/ARf55SGamtooYcdhLirYOZYdk9x43mtByHm1GcBlxIF25LBmZ5lpyWx1DPA52Yiy6gyq15M362VXpwtbuLW2vaTl4dStF49uiGSAERtRoeX1Zzty1YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768472958; c=relaxed/simple;
	bh=RcORP5wCUNlsEmyWgZeI+a5gXDp4vee8ZqAGxOg2NgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQyWleSIdnFWUaIatDFC4H/PzJKsSo8AVVxFpmUxUbvOGNUs1lRvRIl0O1y8gW4mPMD0WA+p+ifew+XWaazs4e2n+V10UqvHkwl5lx80XrcABSOph4wPUNMAW4I4+SIKrqFQzUesjQ5BRkYoGNyXNOQNoIlmYHLIXPnAt5Vkims=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juimNJTS; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-650854c473fso1291560a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 02:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768472955; x=1769077755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1Msyc6ss4re1LefO4+sWBd6FCSYfKgbvEFYJE40EDI=;
        b=juimNJTS+NCZhqKcx4rj6T9I3HIwNTnac17/kolAoFRAjUao0tVBV8rFyguwI2337N
         EZj3t2NCtfY3oSxbzEodkAqUQB1xfzp5rKB2Me5B5Te7kDdORj9H0du9AwcRmXxMXyZI
         31Jcf9kJWwR7bt34N2hacFZpv0RaJDC77RFAY1+cNtGkn8V/j8kwiInGsNfxYYhgle8Y
         xlD4sPjRhpdH3BITEJjEWJ87K+FqD+7FeUyvcVWcWd4y/01g6DKnWDv6KlPZXyrhlzzM
         bAvnzHs313N0K8fHcTHTaou0OJ6fJhDl0V3WV3/oKfKjfJDyu0gsFJUeJtI3venjAKR6
         jQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768472955; x=1769077755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i1Msyc6ss4re1LefO4+sWBd6FCSYfKgbvEFYJE40EDI=;
        b=SR7orZcPvIl7FMvoqBNPmqqSHzqj0xTZazPaJUcqEhmOTYCTjdTrgO5tYo0pGJcpCp
         vdFpyXHYY0m+lrRE4oWnJhpmndYOI7crGFm1KiqD5yglb59M9se53mlG6F9LezIafL9m
         yK1wylGElRiju3sdhQ/WYTeE7BDKanlyfft79WaoZlVtN/eTYykMSes5yjphUXSFefPg
         M7IoNldVYOKPbUQti4/cd09illRanm8SG/GBlRRCIwTO6jhWLqSijAFzBMvLvdlGSpbW
         xhz+YUDEYm0vrAaSIg8fluFft51oFNIQJVyJfXMhk1N56TZkckg59lNseEOBsb9AJLGQ
         7sOw==
X-Forwarded-Encrypted: i=1; AJvYcCVqvPcwQfaWEvXbckUo6xWLKz903zfUpLhko/isUAyUzkiiQm71xO+LdtrmR38qeMNsSrXGi9yMF+a6yMJ2@vger.kernel.org
X-Gm-Message-State: AOJu0YyIV2LtV6jT/4ks/GXi1YuSoJVGJEL6s8BGG/eEKn8zquk5h6fE
	w4HrSlMHgOVn+LnRXcRrr/c1RmeCTUu/+0m9PLiogFYW1bpR43EyKecO8MZtE1Kbob638ro7Iis
	TbcTsaL61dvPWYacu9KROJu9jBy8D/qg=
X-Gm-Gg: AY/fxX6QKXYXqPS4vZDkYl8kYIcjTHUJX1h1J1FOiDzBXASgMp+z1QG2DAGUhTheZDL
	mD+Bj9lDz1dbUr8UVGUhlPPIbFlAoUTIaDF1BLk/ErtPY4/1kyua9ZVyAOF6ipffommE6qHVw7f
	+FFk8Ro0tY5+gNUFw5qk107nvu2XD6ncBUtzhrFgf9tZyIKHhiTDcld9LSQcKq5GArU/WK//IgU
	HaRJiRGatjC8fLpzPubdcHErFsyfJR7w15RDCNmvoBYv1j4XmVXfteZu0HrCOp8i+V5CaMYviYr
	Cyf9IOHX5ShjCJjTudrs17FUPeLtJmuExabkLD2h
X-Received: by 2002:aa7:da10:0:b0:649:81d7:581c with SMTP id
 4fb4d7f45d1cf-65412e189cfmr1602357a12.1.1768472954969; Thu, 15 Jan 2026
 02:29:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOdxtTZ=SuV2GMPuqQJe6h-h-CDiG5yBW+07f1QYEw+kTA4-2w@mail.gmail.com>
 <CAOQ4uxggQekxqavkt+RiJd9s9cdDgXZuVfQrL_qNciBNf=4Lww@mail.gmail.com> <CAOdxtTas63Wky=NeKVMFBfTanCqhGS-9cX-kwc7wFx9COSD+Zw@mail.gmail.com>
In-Reply-To: <CAOdxtTas63Wky=NeKVMFBfTanCqhGS-9cX-kwc7wFx9COSD+Zw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 15 Jan 2026 11:29:03 +0100
X-Gm-Features: AZwV_QiTl64YC5_a7mLksOPc6z0bNmcXmeG5YoA8AfI5jFIaOJdmNdhIT1WCjLI
Message-ID: <CAOQ4uxhhj4k3pVv_AzgNeO1x2uiZKLXdhvXMykM5H-JkgLqC1Q@mail.gmail.com>
Subject: Re: [Regression 6.12] NULL pointer dereference in submit_bio_noacct
 via backing_file_read_iter
To: Chenglong Tang <chenglongtang@google.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 2:04=E2=80=AFAM Chenglong Tang <chenglongtang@googl=
e.com> wrote:
>
> Hi Amir,
>
> Thanks for the suggestion. I followed your advice and cherry-picked
> the 4 recommended commits (plus the backing-file cleanup and a fix for
> it)

Yes, good catch.

> onto 6.12.
>
> However, the system now panics immediately during boot with a NULL
> pointer dereference.
>
> The commit chain applied:
>
> ovl: allocate a container struct ovl_file for ovl private context (87a8a7=
6c34a2)
> ovl: store upper real file in ovl_file struct (18e48d0e2c7b)
> ovl: do not open non-data lower file for fsync (c2c54b5f34f6)
> ovl: use wrapper ovl_revert_creds() (fc5a1d2287bf)
> backing-file: clean up the API (48b50624aec4)
> fs/backing_file: fix wrong argument in callback (2957fa4931a3)

Stange listing the commits out of cherry-pick order.
When you send to stable list, pls send in correct order.

>
> The Crash: The panic occurs in backing_file_read_iter because it
> receives a NULL file pointer from ovl_read_iter.
>
> [    7.443266] #PF: error_code(0x0000) - not-present page
> [    7.444208] PGD 0 P4D 0
> [    7.445270] Oops: Oops: 0000 [#1] SMP PTI
> [    7.446175] CPU: 0 UID: 0 PID: 423 Comm: sudo Tainted: G
> O       6.12.55+ #1
> [    7.447669] Tainted: [O]=3DOOT_MODULE
> [    7.448330] Hardware name: Google Google Compute Engine/Google
> Compute Engine, BIOS Google 10/25/2025
> [    7.449825] RIP: 0010:backing_file_read_iter+0x1a/0x250
> [    7.450810] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> f3 0f 1e fa 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 41 55 41 54 53 48
> 83 ec 10 <8b> 47 0c a9 00 00 00 02 0f 84 d9 01 00 00 49 89 f6 48 83 7e
> 18 00
> [    7.453754] RSP: 0018:ffff9e95407b7db0 EFLAGS: 00010282
> [    7.454694] RAX: 0000000000000000 RBX: ffff9e95407b7e78 RCX: 000000000=
0000000
> [    7.455892] RDX: ffff9e95407b7e78 RSI: ffff9e95407b7e50 RDI: 000000000=
0000000
> [    7.457158] RBP: ffff9e95407b7de8 R08: ffff9e95407b7df8 R09: 000000000=
0000001
> [    7.458331] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000000
> [    7.459593] R13: 0000000000001000 R14: ffff9e95407b7e50 R15: 000000000=
0000000
> [    7.460968] FS:  00007a330957cb80(0000) GS:ffff9cb0ac000000(0000)
> knlGS:0000000000000000
> [    7.463015] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    7.464268] CR2: 000000000000000c CR3: 000000010bfc0003 CR4: 000000000=
03706f0
> [    7.465453] Call Trace:
> [    7.465994]  <TASK>
> [    7.466487]  ovl_read_iter+0x9a/0xe0
> [    7.467424]  ? __pfx_ovl_file_accessed+0x10/0x10
> [    7.468353]  vfs_read+0x2b1/0x300
> [    7.469137]  ksys_read+0x75/0xe0
> [    7.469894]  do_syscall_64+0x61/0x130
> [    7.470603]  ? clear_bhb_loop+0x40/0x90
> [    7.471381]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    7.472486] RIP: 0033:0x7a330967221d
>
> It appears ovl: store upper real file in ovl_file struct introduces a
> bug when backported to 6.12. In ovl_real_fdget_path, the code
> initializes real->word =3D 0. If ovl_change_flags is called and
> succeeds, it returns 0 immediately. However, because of the early
> return, real->word is never assigned the realfile pointer (which
> happens at the bottom of the function). The caller sees success but
> gets a NULL file pointer.
>

Correct analysis.
There was a mid series regression, but it wasn't made available
in any kernel release.

> I wonder is there an upstream commit that corrects this logic, or does
> this dependency chain require the larger ovl_real_file refactor from
> 6.13 to work correctly?

The upstream commit that fixes the mid series regression is
4333e42ed4444 ovl: convert ovl_real_fdget_path() callers to ovl_real_file_p=
ath()

It's not a must to apply the entire refactoring to fix the problem, but in =
fact
the refactoring is a correct logical cleanup following 18e48d0e2c7b,
so I think it is better to include the two refactoring patches in the backp=
orts
series rather than diverging from upstream with a custom stable kernel fix.

Please include these two patches in the backports set:

d66907b51ba07 ovl: convert ovl_real_fdget() callers to ovl_real_file()
4333e42ed4444 ovl: convert ovl_real_fdget_path() callers to ovl_real_file_p=
ath()

Please send the entire backports set as a patch series to the stable mainta=
iners
or let me know if you want me to do that after you tested the backports.

Thanks,
Amir.

