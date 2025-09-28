Return-Path: <linux-fsdevel+bounces-62944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B455BA6F4A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Sep 2025 12:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7F1178C2F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Sep 2025 10:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806572DECA3;
	Sun, 28 Sep 2025 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ud20ASVs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF00A2DC785
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 10:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759055603; cv=none; b=O+ecHk2ID6QEnnDQv0IPOIdI1Lc1NqlTvZ7X3L1cmZ3w6j3t9tn3hYTJtr2XMVzJ1JYLNp5dUWNjyPWWX9g4GCpmpkrUsWiQsbqvuMxrPMwmMDl9Et03lX1LG7g1wqLP6kxFvA4Zra6TTfoJH/64kuLf0GKYRldF0z04UK3wrYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759055603; c=relaxed/simple;
	bh=W1P4GzY1bC9YgmxJ2fNnWAboDU4JuIT0DBDqxALFX0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xp2wELqHfaP/5OOe2X1u7l6sFWWJR9WWl6u+qxrvEGA3IDxWmR4u5E2fgOgbwK6Wl2Gix4Qsapr2yDzUapkJdsoCgyVS3SPE7K1J7a2y4WUOUOMISZM0JVhfavKIbGipVq2V2KQluujDNydVS8yuUw4VIWFALGsaSHlt8+iGHNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ud20ASVs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B937C4AF09
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 10:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759055603;
	bh=W1P4GzY1bC9YgmxJ2fNnWAboDU4JuIT0DBDqxALFX0M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ud20ASVsnYuE5kNMszyEQpSoR0Bq4bejcUKHOUGjiL35VMUaD5yL3aWJSfDAcC6Td
	 gZvVM+w5J+fLJk+M+cm+C5F6V8+n4QeTYvqpgUamaRejIQgk3V0BlYAFNlqYQL24Bc
	 DWcQUU6VEeKpDUxZxLhye5/BzKyKh/wIMTJhcQ4gOf6DwgjgyJduc9FxYI2tEQHU8G
	 Smimz0KWLOn1bqbGAIREMMYENc9PlF8rWaED7GAKDBcxtwEhefJidnd2amv8AtvhLY
	 P0w6Rw13h6lhC3C6zgIAqhb2YGn56pNaWFWlqBEqDnFrzkyAsiQ1FYLlftVUlNnfCZ
	 N4zqSVcCig0bw==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-31d6b8be249so3514850fac.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 03:33:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWr9YaqPGVX3dAdoh1pnmnuDsyZlXgHubldv+/6cX7ZY9chSYnkjBhNgGOM8akbFsaMawz5itSvg+pOky58@vger.kernel.org
X-Gm-Message-State: AOJu0Yz47/D4X+Cap9MTbrBqWuo96wxO3Ib+6ByBf0ivuqe0MiO9rcYJ
	0V8t4qwdf3s9toT8XvcGFuX559vOmMgpLms0ulYIjeJ1n8pMeJHt/d1PSDEcLp4iaGexPZQ8Yp4
	enDFIsUnOnt5F6luq95jJK0I1W8CKOFI=
X-Google-Smtp-Source: AGHT+IHHkBehFxa/bp8CnX34GBVpEV5VAfmAS0oqHk9Wg6vhKkRCMfTaIXQ9hfF+1UwB0EGnwQh5Kq0MuUSpqvkAupk=
X-Received: by 2002:a05:6870:a118:b0:315:b618:d6be with SMTP id
 586e51a60fabf-35ef20c8e8fmr6297578fac.51.1759055602481; Sun, 28 Sep 2025
 03:33:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
 <20250916044735.2316171-2-dolinux.peng@gmail.com> <03ad08d9-4510-19fb-bbad-652159308119@huawei.com>
In-Reply-To: <03ad08d9-4510-19fb-bbad-652159308119@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 28 Sep 2025 12:33:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ix+taHWpKAeYsNBQMoxG6f7E9vyO=yqjrh5_AnjrXZbg@mail.gmail.com>
X-Gm-Features: AS18NWDE1zAXVuNiUSbLmdX4xI4485zsbYvsUyBO0gNsC9FdVLBA2B2bjlgQB_4
Message-ID: <CAJZ5v0ix+taHWpKAeYsNBQMoxG6f7E9vyO=yqjrh5_AnjrXZbg@mail.gmail.com>
Subject: Re: [PATCH v3 01/14] ACPI: APEI: Remove redundant rcu_read_lock/unlock()
 in spin_lock
To: Hanjun Guo <guohanjun@huawei.com>, pengdonglin <dolinux.peng@gmail.com>
Cc: tj@kernel.org, tony.luck@intel.com, jani.nikula@linux.intel.com, 
	ap420073@gmail.com, jv@jvosburgh.net, freude@linux.ibm.com, bcrl@kvack.org, 
	trondmy@kernel.org, longman@redhat.com, kees@kernel.org, 
	bigeasy@linutronix.de, hdanton@sina.com, paulmck@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-aio@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, linux-wireless@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-s390@vger.kernel.org, 
	cgroups@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 5:22=E2=80=AFAM Hanjun Guo <guohanjun@huawei.com> w=
rote:
>
> On 2025/9/16 12:47, pengdonglin wrote:
> > From: pengdonglin <pengdonglin@xiaomi.com>
> >
> > Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side fun=
ction definitions")
> > there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
> > rcu_read_lock_sched() in terms of RCU read section and the relevant gra=
ce
> > period. That means that spin_lock(), which implies rcu_read_lock_sched(=
),
> > also implies rcu_read_lock().
> >
> > There is no need no explicitly start a RCU read section if one has alre=
ady
> > been started implicitly by spin_lock().
> >
> > Simplify the code and remove the inner rcu_read_lock() invocation.
> >
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Tony Luck <tony.luck@intel.com>
> > Cc: Hanjun Guo <guohanjun@huawei.com>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
> > ---
> >   drivers/acpi/apei/ghes.c | 2 --
> >   1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > index a0d54993edb3..97ee19f2cae0 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -1207,12 +1207,10 @@ static int ghes_notify_hed(struct notifier_bloc=
k *this, unsigned long event,
> >       int ret =3D NOTIFY_DONE;
> >
> >       spin_lock_irqsave(&ghes_notify_lock_irq, flags);
> > -     rcu_read_lock();
> >       list_for_each_entry_rcu(ghes, &ghes_hed, list) {
> >               if (!ghes_proc(ghes))
> >                       ret =3D NOTIFY_OK;
> >       }
> > -     rcu_read_unlock();
> >       spin_unlock_irqrestore(&ghes_notify_lock_irq, flags);
> >
> >       return ret;
>
> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Applied as 6.18 material, thanks!

