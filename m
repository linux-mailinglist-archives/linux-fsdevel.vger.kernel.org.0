Return-Path: <linux-fsdevel+bounces-52616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA07AE4861
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 17:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454B316B0BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 15:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E211328A1E0;
	Mon, 23 Jun 2025 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KK3z2ZZa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1287328C867
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692201; cv=none; b=FgQUlnkOgfAXSKVgLgoFFIytAVRwCoQKKqSVOoTCMiCalPRYkU3VipSBoLV6I72wcQotlo+Dw24PEjdL9jwbuUsWQAEHk6ku2yR6sowr4nap4Z7jcElNACyWjlnMVkeLr4h+OEIh74QILM1pv0ax6UKqaB9W0zRuILy/L2G26ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692201; c=relaxed/simple;
	bh=lGS+0f0d2TPqmr39/urKxDV5nS75hlwL5bSZDFpp3aI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vAAquUEjmxLaCneXnHA9/2Bm5CvpJjkUCAeXA7epCVW/Cv9j/s96ySl5zbVfLpc/ABpNwjFlSC8YRfzDpuvV7nXnXfIfDrzXr5MNRLdWcGZTy5xU3kEtkut1y55pvU2WT7OBAA6A6GoEXFWVPLED+7JQlJEi4CiBYqY6huoq9lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KK3z2ZZa; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-70e23e9aeefso33190057b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 08:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750692196; x=1751296996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5C+Macx0w6ywU+A/VvTC8HUBWMBBqnb8N7PQsKLlGDs=;
        b=KK3z2ZZa3naySG4UBYRrXHNJN/sqjzJpgXzbYb0hEdHli+tdbUhGQTl5KoG8t/KN7t
         D214XNVYjV6nLye/i29wogBvV29DVSPI9KOaiDb+YMNaztf8aTUC/k7xJScXA9Km3mTf
         vdm3tYLqIDaS+EqE9dmNSp5O/zvxlpiSz9SyMB2insFUqY1fHSSazu1jp2AbgLgXYtqM
         yYK4m5WPyl4ieQ6Yk+A/xmRBReFHox5fh8w2gzIRqovUMJz8f93AjdSK/kAZj/L0ur/x
         kBWqgEEEAY5RwKz/oAxUA4neebUJU0B9f5mx4RHm8tUqDmIZbsyKfM5b3aKa1fvm5Uso
         PdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750692196; x=1751296996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5C+Macx0w6ywU+A/VvTC8HUBWMBBqnb8N7PQsKLlGDs=;
        b=eMrO2gKtGWy91FRzXSxj2gPmzyT9vEKpc4VUXOOCJ9DaNG1I4zYcMzonWx7yMVjLqR
         BccDEeRALLAqhGAGTFWzeqPzMy+V1AgMe//1GiBNPy6RpangEo5+d/tS7zubPjtinagK
         IETvuRt2sbdVHNqCFMOcKZ7ua5bkMcwtrHVCbka3jf2maM9F9+KLkAKtekvBDqCOWauw
         6366GPr2Is+CI2wDZAKfBzHOrd1v3dcxNoH4sjeK39CM9V0/UyadlzChx/lpnmlk4BTy
         i6OsHvdjoRbh6pingvBKmOfenqyt3kgHT7a6UZgtP5x+ihPqcHvGqxha83trGMf52n4m
         iBLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmPGpgmTYM9HcNYeP7Rc3ndxvqVQjZxW8He7cTs2rPzrG5tRCj+THjnuIEjk7YYf1FyRoqPzQX/ohxsQxf@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyi1X1cZj7mynbsl2+O4jPMA6Z6VrumuRHDcpU3EFM8CEeIXPn
	glGLsl7zg4XpflWaNFzF8gQgIuJdUShsozbED9VrG5ABFrWj9OVjDhlXxRI2YSDvC+FVrwsM/ZC
	F0NFqUN+QbXSY0Kmi5dd11aaUDGM9bc2GQHtftOI1SHMshD2EZfg=
X-Gm-Gg: ASbGncuF1Lm8H7bZUgGEvDw5eAorE3PzbRDuManYGp8MpV+qfnKmzfyNWu8VBQGh0aQ
	AMs4nvNqHjDU8yDlEqc/Y9y1QFgUSrFkrYIvYqzaZEBfOz3NWM/lETeqL9+owEEMkYuo2MP/4iQ
	HInSMe3Jj/26SHULynWRDhRJ9Wk+nUTQ3Irr992ZzjbHY=
X-Google-Smtp-Source: AGHT+IFDWmvezTtn24M48J2+gCwvEZrGp1xjw9YXsal4m8rI9IlwaC+CRLf7Nu9lLnMcBNv3Itll1k7csRHQcl6+zOM=
X-Received: by 2002:a05:690c:4a06:b0:70c:a854:8384 with SMTP id
 00721157ae682-712c63f3440mr197154127b3.11.1750692196000; Mon, 23 Jun 2025
 08:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFj5m9KOjqYmUOYM4EgDBrJ-rQxEgOhm+pokmdAE6w+bCGrhSg@mail.gmail.com>
 <CAHC9VhQ0dyqsjsNt98yiPCGsiuUXep3T7T24LWWRHy8V8xjV4Q@mail.gmail.com> <aFiwMxE4OlcFp7Ox@fedora>
In-Reply-To: <aFiwMxE4OlcFp7Ox@fedora>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Jun 2025 11:23:03 -0400
X-Gm-Features: Ac12FXzfEPBnZct18t2NRX4DFqCH556EcUr1vJpCOtWVUEWdAIFOvsXhC2LL9A8
Message-ID: <CAHC9VhQjF3L0B0GiZq-yWBMKjBMZ_qtnuG0Dn9g=bzjkFMYJig@mail.gmail.com>
Subject: Re: [v6.16-rc2+ Bug] panic in inode_doinit_with_dentry during booting
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 22, 2025 at 9:39=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
> On Sat, Jun 21, 2025 at 02:40:41PM -0400, Paul Moore wrote:
> > On Sat, Jun 21, 2025 at 2:08=E2=80=AFAM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > Hello Guys,
> > >
> > > The latest v6.16-rc2+ kernel panics during booting, commit
> > > 3f75bfff44be ("Merge tag 'mtd/fixes-for-6.16-rc3' of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux"):
> > >
> > >
> > > [  OK  ] Finished systemd-modules-load.service - Load Kernel Modules.
> > >          Starting systemd-sysctl.service - Apply Kernel Variables...
> > >          Starting systemd-sysusers.service - Create System Users...
> > > [  OK  ] Finished systemd-sysctl.service - Apply Kernel Variables.
> > > [    1.851473] Oops: general protection fault, probably for
> > > non-canonical address 0x8cbad568292ed62c: 0000 [#1] SMP NOPTI
> > > [    1.853362] CPU: 9 UID: 0 PID: 269 Comm: systemd-sysuser Not
> > > tainted 6.16.0-rc2+ #328 PREEMPT(full)
> > > [    1.854923] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> > > BIOS 1.16.3-1.fc39 04/01/2014
> > > [    1.856374] RIP: 0010:__list_add_valid_or_report+0x1e/0xa0
> > > [    1.857366] Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa
> > > 53 48 83 ec 08 48 85 f6 0f 84 76 2f 76 ff 48 89 d3 48 85 d2 0f 84 5c
> > > 2f9
> > > [    1.860338] RSP: 0018:ffffd152c0de3a10 EFLAGS: 00010286
> > > [    1.861244] RAX: ffff8aa5414d38d8 RBX: 8cbad568292ed624 RCX: 00000=
00000000000
> > > [    1.862439] RDX: 8cbad568292ed624 RSI: ffff8aa5401f40f0 RDI: ffff8=
aa5414d38d8
> > > [    1.863622] RBP: ffff8aa5414d38f4 R08: ffffd152c0de3a7c R09: ffffd=
152c0de3a20
> > > [    1.864810] R10: ffff8aa5401f40c0 R11: 0000000000000007 R12: ffff8=
aa5414d38d8
> > > [    1.864813] R13: ffff8aa5401f40c0 R14: ffff8aa5401f40f0 R15: ffff8=
aa5414d38d0
> > > [    1.864814] FS:  00007feebef42bc0(0000) GS:ffff8aa9ed02f000(0000)
> > > knlGS:0000000000000000
> > > [    1.864816] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [    1.864818] CR2: 00007feebfb58180 CR3: 0000000117f4d004 CR4: 00000=
00000770ef0
> > > [    1.870018] PKRU: 55555554
> > > [    1.870020] Call Trace:
> > > [    1.870029]  <TASK>
> > > [    1.870031]  inode_doinit_with_dentry+0x42d/0x520
> >
> > Thanks for the report.  I'm assuming you didn't see this with
> > v6.16-rc1, or earlier?
>
> It isn't observed on -rc2.
>
> >
> > Do you have any line number information you could share?  Also, based
> > on the RIP in __list_add_valid_or_report(), can you confirm that this
> > is either happening in an initrd/initramfs or on a system where a
> > SELinux policy is not being loaded?
>
> Looks the issue can't be reproduced any more with -rc3.

Thanks for the update.  If you see this again, please let us know.

--=20
paul-moore.com

