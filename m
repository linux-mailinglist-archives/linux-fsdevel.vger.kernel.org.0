Return-Path: <linux-fsdevel+bounces-49080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D0AAB7B60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 04:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2327C1880472
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 02:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A133F27933E;
	Thu, 15 May 2025 02:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="i3nM6aZS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66A654670
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 02:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747274498; cv=none; b=pRqa3drP9b6V6xqP1Wg0SPAsfL9844rzs71wvKXmGm7hp+LYhtB02ZP7T2+TTMuFyezEVpuCmmaflHY8LMCP+MLPpCrkde/7Zr7qkDiYMcs2SE6J+HMW0zcCa5hExMG2BF+Q2iBMLeXp1F9WXTpDDcvbDQTLMLaQ1Qah9Tc9ntk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747274498; c=relaxed/simple;
	bh=Ys33O/zgHEEBRUX0TZ7+hETBTcCcg+4QlDnFZ+FeywU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K3FCiars196QXoQMHqWa8kYh+kCV3SY2JjWz7VGUPsbNyCuYobS8Ksr1+ZK6tU08triiXvsJ5mnMlVNzRDbY5LZOthqif8A3qfJhMrdF5Dy2y9nwtfE6l4x68I2xY1/mb0+pOeIeTKYSjKek4R/Q7vCyHUHJBugWh1q1YAGXv00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=i3nM6aZS; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54fd1650afdso439708e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 19:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1747274494; x=1747879294; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3igWJBklYuK9G/0qmdyO39ElstyriCzMZS8fl9pAzNM=;
        b=i3nM6aZSvfXtFBi7OBC9WHCtAmwswWTQtadoFx3tu3mO3jJ+AvBHdIZp0DVxfVYFdg
         cghxdPQWzaFwBmPdVZl5A1x66XaL7xi2FRNVFL+jObPWt/ur9gclYeRafPEu8bd55szb
         DDuofG8jwVi+Wb03fsUrj27tIr+l8AL9Sk+rR4xCllDQlQhzUr0CZBpTQuxiEwKpqCWo
         AbwC4lBHwnqDlTfBf/kJswpeGnSnVuid0WEMmvJnSFDx1mKc/Ggdua7OMbg2mT/aFL8l
         Uew+X9EW2JwJVyCC5sJButH8WBrvMsnM2wqG3ZnqcNUJ/Bnpj4TeTDgTmiYOntU13Zr/
         NwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747274494; x=1747879294;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3igWJBklYuK9G/0qmdyO39ElstyriCzMZS8fl9pAzNM=;
        b=QS4LV6Zxj56ALuze8XJGNPkc0vDEG6w40Rf7lREIyN73Rw6Q659Cll14K6RGvK3YA2
         34woVcPY7jlXhMbZ45ttmCC1QnOm+dj4mSnLrJkxDKAoY6IxQ+Mn2CDmrJbScynnIpxk
         Z2Y4dLXEiYIAxWnBaUYgvJ13ciJv3aXra7+7VghdiF6yrgW5Lp7vF9HuLYpdvWgZ0f5R
         KLIqpXXYVnCpu2LR8TpTlHdtr8YtZ7+GahfJX8ClC8poDgym6qu8Bzh6358TLIkwd2rD
         En7fq3vIrrhA8pjKXRWU1A5HvoLMLgo5X5mYXPMT1sK1Nd62Uotqp+Thzx0KLpu+60SH
         oTeQ==
X-Gm-Message-State: AOJu0YxoLJipi1qF2q7seT3szsY1v2/Zt7SLtlgJhesfCbiHTvJYNZ95
	hM2x2bESVE63a4tQs1vaNwejwWUtm5YyNedKOUNyRK6ldwFspGeJFaixG7+2/18=
X-Gm-Gg: ASbGncsETx521QKYgGs/jRwcJyR6t6TZnj6om6hl5+lBoxZOoiDKBAGeCP0xtjqn45Y
	Hk3cI5N7MQJ8wDJ0auB6TW6kg3HVkXC2GqAb9Xq9GSuka1yfje7x4JXKSfIPDFEXLn9AAACLuDW
	SrFm2DiDImmuB3iqgPFyx4o8+R1+twrUE+urtRU1ojNKVenxPfsc1EeFK3XWRf0swIkMCsjCoT5
	Mf8VmPlGpxGZUiOczFMdOMZFT3NrJx4KoIRCmMC3Y6VF3F1gXb7gbezPLL3sLWGKCcYoSwUGY8S
	8/N7NPZnd2tX9koLEyTQpio6oaAoSkyHfwzYwid7cWCoG5ZdCYDSwQ==
X-Google-Smtp-Source: AGHT+IEeIBvJX6OKvUbZqPpng9PWrTVmUIp6FebTgR/KxxOKTDCWY581tYEO2BmhEHo+OorC8cDfjQ==
X-Received: by 2002:a05:6512:3e21:b0:545:381:71e with SMTP id 2adb3069b0e04-550dd127e21mr220128e87.40.1747274493797;
        Wed, 14 May 2025 19:01:33 -0700 (PDT)
Received: from [10.24.138.144] ([91.230.138.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54fc64bf6ddsm2451584e87.193.2025.05.14.19.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 19:01:32 -0700 (PDT)
Message-ID: <58e07322349210ea1c7bf0a23278087724e95dfd.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: remove mutex_lock check in hfsplus_free_extents
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Yangtao Li <frank.li@vivo.com>, glaubitz@physik.fu-berlin.de, Andrew
 Morton	 <akpm@linux-foundation.org>, "Ernesto A."
 =?ISO-8859-1?Q?Fern=E1ndez?=	 <ernesto.mnd.fernandez@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com
Date: Wed, 14 May 2025 19:01:31 -0700
In-Reply-To: <20250511110856.543944-1-frank.li@vivo.com>
References: <20250511110856.543944-1-frank.li@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-05-11 at 05:08 -0600, Yangtao Li wrote:
> Syzbot reported an issue in hfsplus subsystem:
>=20

Could you please add the issue into the issues list [1] (if it is not
there yet) and to assign it on yourself?

> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 4400 at fs/hfsplus/extents.c:346
> 	hfsplus_free_extents+0x700/0xad0
> Call Trace:
> <TASK>
> hfsplus_file_truncate+0x768/0xbb0 fs/hfsplus/extents.c:606
> hfsplus_write_begin+0xc2/0xd0 fs/hfsplus/inode.c:56
> cont_expand_zero fs/buffer.c:2383 [inline]
> cont_write_begin+0x2cf/0x860 fs/buffer.c:2446
> hfsplus_write_begin+0x86/0xd0 fs/hfsplus/inode.c:52
> generic_cont_expand_simple+0x151/0x250 fs/buffer.c:2347
> hfsplus_setattr+0x168/0x280 fs/hfsplus/inode.c:263
> notify_change+0xe38/0x10f0 fs/attr.c:420
> do_truncate+0x1fb/0x2e0 fs/open.c:65
> do_sys_ftruncate+0x2eb/0x380 fs/open.c:193
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
>=20
> To avoid deadlock, Commit 31651c607151 ("hfsplus: avoid deadlock
> on file truncation") unlock extree before hfsplus_free_extents(),
> and add check wheather extree is locked in hfsplus_free_extents().
>=20
> However, when operations such as hfsplus_file_release,
> hfsplus_setattr, hfsplus_unlink, and hfsplus_unlink are executed
> concurrently in different files, it is very likely to trigger the
> WARN_ON, which will lead syzbot and xfstest to consider it as an
> abnormality.
>=20

Which particular xfstests' test-case(s) triggers the issue? Do we have
the easy reproducing path of it? How can I check the fix, finally?

> Since we already have alloc_mutex to protect alloc file modify,
> let's remove mutex_lock check.
>=20

I don't think that I follow the point. The two mutexes are namely the
basis for potential deadlocks. Currently, I am not sure that we are
fixing the issue. Probably, we are trying to hide the symptoms of the
real issue without the clear understanding what is going wrong. I would
like to hear the explanation how the issue is happening and why the
warning removal can help here.

> Fixes: 31651c607151f ("hfsplus: avoid deadlock on file truncation")
> Reported-by: syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com
> Closes:
> https://lore.kernel.org/all/00000000000057fa4605ef101c4c@google.com/
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> =C2=A0fs/hfsplus/extents.c | 3 ---
> =C2=A01 file changed, 3 deletions(-)
>=20
> diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
> index a6d61685ae79..b1699b3c246a 100644
> --- a/fs/hfsplus/extents.c
> +++ b/fs/hfsplus/extents.c
> @@ -342,9 +342,6 @@ static int hfsplus_free_extents(struct
> super_block *sb,
> =C2=A0	int i;
> =C2=A0	int err =3D 0;
> =C2=A0
> -	/* Mapping the allocation file may lock the extent tree */
> -	WARN_ON(mutex_is_locked(&HFSPLUS_SB(sb)->ext_tree-
> >tree_lock));
> -

I am not sure that it's the good idea to remove any warning because,
probably, we could not understand the real reason of the issue and we
simply trying to hind the symptoms of something more serious.

Current explanation doesn't sound reasonably well to me. I am not
convinced yet that it is proper fix and we see the reason of the issue.
I would like to hear more clear justification that we have to remove
this check.

Thanks,
Slava.=20

> =C2=A0	hfsplus_dump_extent(extent);
> =C2=A0	for (i =3D 0; i < 8; extent++, i++) {
> =C2=A0		count =3D be32_to_cpu(extent->block_count);

[1] https://github.com/hfs-linux-kernel/hfs-linux-kernel/issues

