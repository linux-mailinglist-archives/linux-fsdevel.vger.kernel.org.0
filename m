Return-Path: <linux-fsdevel+bounces-44927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88444A6E67F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 23:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1CF189043D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 22:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4761EE7BB;
	Mon, 24 Mar 2025 22:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eX2s1bde"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B491531C5;
	Mon, 24 Mar 2025 22:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855056; cv=none; b=p91iFvav6fun+YT5IRIsbKmh6yVMxPyPuv2spahKExPscNp6wIl2f09+eorInBPUpiX6KGvRN5tzrHT3cw6KVpj3E3mKK3+FHZRnqfQdFGtj5EjcnLXkesrFA1uytbubF5VYTRoLUu5FCIQ6zXPmffFZJVYs59A3s1R3wcoLGY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855056; c=relaxed/simple;
	bh=Q+Zzt8pzMsAcoKZidlF7hVur3wO7pd1WawlETRsumfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IT6Ql+CKQx/Zyy9vDrStMD7/rlGMFqdunuei/+iimDsFfN5xK0f/QMkeUdcVmgI7dnyHJF5ebBy0iz4XPU1Z22DMNoB5UbR6pm9Fn7J+RnFTJqZ58J5h/ge82wwsBaG9UC8a4mXILCfhKg6HeaNWiam081dfCgn1VB2zXIbbrGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eX2s1bde; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so746849466b.0;
        Mon, 24 Mar 2025 15:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742855053; x=1743459853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+Zzt8pzMsAcoKZidlF7hVur3wO7pd1WawlETRsumfg=;
        b=eX2s1bdeX10GJm8/ebSozgehnICtcgBdKbF0ve7R1Aif6LGBOUBSHYhtSIkr8CaGQG
         tEmE4f7kZa+z4XoJcqttjhscF6+0FC0oqELdAOrVVQXz1MyZDA1oZdlQi+SKjF0T2Mvs
         zzkpd6H1RbpDPD2mm5u9OhSbbXunTsMsr3RoPHaiR54LIF2ERDJxiQ0wDGY2ljXHlsBl
         sAdR8Z9roAIKCF2yPZ9wG2KqJCd+Ws+tDOp3QR39Au/Ck/2WegSw+j3L4X1tFa0InQDP
         HiwL+L0ANUjiACIlNQhSjwR9ma+nwtQHym+rbYlLF9DRiFyHbxW1EGML5NNsICgJTcpG
         do5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742855053; x=1743459853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+Zzt8pzMsAcoKZidlF7hVur3wO7pd1WawlETRsumfg=;
        b=h1toUhJMqLaYSZKqpjZf6yE3zMXq3j8z2PWIj54idqdBDxXrMd/sZfexm6NFCSN1B2
         yBBeJP0srYdJPbQd7OuCB/gxQjV0Kh/qL3oJoMfQ+tNkQlt8o4gKLtwZ6QAND4diZNCM
         2RCCb0Aix+YQaRkWzXMoaL0bV2tCg2b33YRlbay05maeBTE1HAr2mB5r2kXuP0oON0bz
         HZWQ7PqBUU8pVOe0CQspAsziP8NZOdxPZ3NB4A5eyqCHWk1RmIeYnWlMq5zanFbswMk4
         R7+vkgyzbQFmfK5PKe2CP0pE7kpVJjislZ6y/Q9lK9NeqT8xsYWa4J6P3lwKAjaCznwG
         u4Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXUzUQJirAXyIZT1sIEwkD36DmBiAQLxN8i4kjSvo7Kdd9N/l12cYUwk2u9uUTpC1WyemlU/2GPIh7bvL9W@vger.kernel.org, AJvYcCXpif2XKNOw7MGq0twnyY7hVLmCn4eazHj0GGYqJ8O/zkCuXaM0dLDAAHhnUL77VpGSrdhj6mlhX1fbVx+G@vger.kernel.org
X-Gm-Message-State: AOJu0YzWW81OPsl7pMRvfZWwXa/F4I1p6SA7wfK1o4oTL7PbTgVF+bc0
	k/3QgqjfOF6iqnqzQduxHRvaonQB/oWDfO+MpRH1F6xhrgKGFm90G2dmE4l4rttyoGMPZGMmQy4
	t2c0/FFojfHOkJ1sBCQ11kYue9nM=
X-Gm-Gg: ASbGncvDMlgIqdzIhEnvH8XxGSVb3chg/mh1Lu3XSqYuej2Fw+bOBcLCSiuOfKPAHNz
	/LIwU9xtN5Luktnjd0VTALRkbp/AQz6k2afQL5Nz/3xe7etqKiVIaWefk+tUqIDwQhE69vQkjUf
	fLY4RqStA0cHO6JtY60NhrWh3PkA==
X-Google-Smtp-Source: AGHT+IE7vveODIuMKV9mImaQQMaSQBJD/AJ0Dw0I1is557b1m41KLoVw99cZoHBh/gGY9eMG1dYS5Y0XXSIMBC/Sae0=
X-Received: by 2002:a17:907:2dac:b0:ac3:bd68:24eb with SMTP id
 a640c23a62f3a-ac3f20b07a7mr1538727466b.1.1742855052484; Mon, 24 Mar 2025
 15:24:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67dc67f0.050a0220.25ae54.001f.GAE@google.com> <20250324160003.GA8878@redhat.com>
 <CAGudoHHuZEc4AbxXUyBQ3n28+fzF9VPjMv8W=gmmbu+Yx5ixkg@mail.gmail.com> <20250324182722.GA29185@redhat.com>
In-Reply-To: <20250324182722.GA29185@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 24 Mar 2025 23:24:00 +0100
X-Gm-Features: AQ5f1JoKAM6ik3I_g3NlPZ0VGOs4ToUGcUruZAghViz1VGc7L4lzi9B3A1nZink
Message-ID: <CAGudoHE8AKKxvtw+e4KpOV5DuVcVdtTwO0XjaYSaFir+09gWhQ@mail.gmail.com>
Subject: Re: [PATCH] exec: fix the racy usage of fs_struct->in_exec
To: Oleg Nesterov <oleg@redhat.com>
Cc: syzbot <syzbot+1c486d0b62032c82a968@syzkaller.appspotmail.com>, 
	brauner@kernel.org, kees@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 7:28=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
> I won't argue with another solution. But this problem is quite old,
> unless I am totally confused this logic was wrong from the very
> beginning when fs->in_exec was introduced by 498052bba55ec.
>
> So to me it would be better to have the trivial fix for stable,
> exactly because it is trivially backportable. Then cleanup/simplify
> this logic on top of it.
>

So I got myself a crap testcase with a CLONE_FS'ed task which can
execve and sanity-checked that suid is indeed not honored as expected.

The most convenient way out of planting a mutex in there does not work
because of the size -- fs_struct is already at 56 bytes and I'm not
going to push it past 64.

However, looks like "wait on bit" machinery can be employed here,
based on what I had seen with inodes (see __wait_on_freeing_inode) and
that should avoid growing the struct, unless I'm grossly misreading
something.

Anyhow, the plan would be to serialize on the bit, synchronized with
the current spin lock. copy_fs would call a helper to wait for it to
clear, would still bump ->users under the spin lock.

This would decouple the handling from cred_mutex and avoid weirdness
like clearing the ->in_exec flag when we never set it.

Should be easy enough and viable for backports, I'll try to hack it up
tomorrow unless the idea is NAKed. The crapper mentioned above will be
used to validate exec vs clone work as expected.

--
Mateusz Guzik <mjguzik gmail.com>

