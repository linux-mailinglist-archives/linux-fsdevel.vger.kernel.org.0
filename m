Return-Path: <linux-fsdevel+bounces-73660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E87ED1E53E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 12:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15CF4301142A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 11:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AB03904D0;
	Wed, 14 Jan 2026 11:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqqSg+rR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58EA387576
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768389066; cv=none; b=YsCuXdglFpMJFvWR+pwW6E4wk9FM/qyFywswu1mL6QJ2L1Gw6QUaJgSHe2L7/TveuRI/v+mWmnOrS1lUhvfmhla2yGj5hJiH6R87DSR5qtVBCHofLax0z6hvMyhF/UexLWyjTe9Ns1/Zdxs+XLwr20iVnxiIEV9jimuFTpYIIh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768389066; c=relaxed/simple;
	bh=dYXJ+3/Y+1uFxB2KMYxd+5BvpBbpBAXDHVuU+nFk0WI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KgDBHLEW3tCFeOAKXIWrT91OmN3GzTSdB0VGDy+We5MqnUPT0jPP//9rIp3uHmeWgMQ1BbNHOxMUA5QlbaCD/2aWDt2YamZMevH/XSM3yNt1L0F8gKl72EQfxTS+dKDZ2QlTTRVvv0xEGlw0PnhJuQ1WzarsgeoC/JkLTqcvbxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqqSg+rR; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64b9230f564so11777721a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 03:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768389063; x=1768993863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VT34YMbl2a3FTwrRv5kF8kobf5UeHV0Zw6UP8Udfbs=;
        b=eqqSg+rRTiya1iCAyMlcZnoAvx2baSIqAWVkZUVsZ6Phh1vWkt75EiSaqmMkX1Iwzh
         MwMuYSgUjaXFv/bsjZeSjUcaApv1ueLLRv+gDRmPGGE51qxgXwoJDculwmBJdX3bEqKq
         PzmNmlE0l4QUeZ6dO//P+8idLaB+o3S9lJUpd7f3R9vzVEOJyX6HOZOErX0CXflGTVZI
         JlgnUjGx7nRDKFODe5lJ8znz/neCTecT3TLE8xRLop0fjvn3RQeFVDhQl6RcZXjalwLE
         FNL/BMd2biNEFacBbwcV20+v/a8DdYtJrBDlyFNTcYECgKfQT3Fe4mPick5PCti5C4VY
         PCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768389063; x=1768993863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/VT34YMbl2a3FTwrRv5kF8kobf5UeHV0Zw6UP8Udfbs=;
        b=PnI12JHvHgmJXa37BpauYtossXCnY5E19X3gpvrqnGTk+Fvy0LRr/9xpA4C8wZEOWm
         hNkmE92qmGj6wdXezansEPeO/Ppzli/MZP7i2ax6w5XDuZdTRpBAhiBN2qDV+PDSt6pD
         X9WUaTXG3YaosGltKuuNz+2YMRQho2AlHv0kJ7uXW9Sm5v8DaQkK6r6tI1BsmPPJ89Jy
         +Kx30A5Gr7XanU6cFq8XllCQBkMYNuLRE6gAJELanuRI9TQ8tebqhUyzjy9JzYL33NqN
         fkNop1kYtGdElXaW9We/xFTaX6lRhyo340Ml9XWsmhcG2pFUnIMoLy225am08DTfqsQY
         m0Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXEGD15gujLaFBQLl6j6lWhywNWcqzjo/nxSg6KzvMm11OcRSKrmRajvhg2Ne6o1Mv7rO7gLi5IK5AK6h8L@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiek465Z1fyf9fSpFn+4rjMpr5fDkCCKiONIfm1U9/YABB7vI8
	mCcHdPuoFUAXsjAfoH8/W93g6SkA21j/x6IYPjDVfu3J8luJOdL/7ufP0wXVHyy4AaR/Y58Mw8p
	Fb8LnUNDoBgNVQguSyaiWId96U4SRACg=
X-Gm-Gg: AY/fxX6P2OOAaGpgfzrsjaknFQZZez7KcBQrhogLgNDMHnCwvmahBefr/eDF38UP/Js
	OBemJJC+R5wljZiTCQGrmj3i3am8SBTKu0eI4+fQtj33vCSXp8ht8vaJJlsb62rZwZQ2wqrXIAV
	7ynC/ko1xfBkCzK5cTJ6AI4WCUxo48iMMjgy5OpezynYIRsJqf133C/MpfNF2M1NoNxPrFcc1VF
	oDctlplZMvYi57JlKu13kIQ1Aptd3oVFLpoHZxQQ+Zp/sOspXl/diUVocPO03fKnGIOGqqCCbOu
	vYlkQ1nAbCdd/mTusrx5cLQClluDTQ==
X-Received: by 2002:a05:6402:50c8:b0:649:c56f:5847 with SMTP id
 4fb4d7f45d1cf-653ec10f91dmr1805891a12.10.1768389062895; Wed, 14 Jan 2026
 03:11:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOdxtTZ=SuV2GMPuqQJe6h-h-CDiG5yBW+07f1QYEw+kTA4-2w@mail.gmail.com>
In-Reply-To: <CAOdxtTZ=SuV2GMPuqQJe6h-h-CDiG5yBW+07f1QYEw+kTA4-2w@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 14 Jan 2026 12:10:51 +0100
X-Gm-Features: AZwV_QhSAdDnmU19Rxok3pJKNXg6QWgWO6U7iEGdWi3dQhx2kRnSwFIqJaBzvEA
Message-ID: <CAOQ4uxggQekxqavkt+RiJd9s9cdDgXZuVfQrL_qNciBNf=4Lww@mail.gmail.com>
Subject: Re: [Regression 6.12] NULL pointer dereference in submit_bio_noacct
 via backing_file_read_iter
To: Chenglong Tang <chenglongtang@google.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 1:53=E2=80=AFAM Chenglong Tang <chenglongtang@googl=
e.com> wrote:
>
> Hi OverlayFS Maintainers,
>
> This is from Container Optimized OS in Google Cloud.
>
> We are reporting a reproducible kernel panic on Kernel 6.12 involving
> a NULL pointer dereference in submit_bio_noacct.
>
> The Issue: The panic occurs intermittently (approx. 5 failures in 1000
> runs) during a specific PostgreSQL client test
> (postgres_client_test_postgres15_ctrdncsa) on Google
> Container-Optimized OS. The stack trace shows the crash happens when
> IMA (ima_calc_file_hash) attempts to read a file from OverlayFS via
> the new-in-6.12 backing_file_read_iter helper.
>
> It appears to be a race condition where the underlying block device is
> detached (becoming NULL) while the backing_file wrapper is still
> attempting to submit a read bio during container teardown.
>
> Stack Trace:
> [  OK  ] Started    75.793015] BUG: kernel NULL pointer dereference,
> address: 0000000000000156
> [   75.822539] #PF: supervisor read access in kernel mode
> [   75.849332] #PF: error_code(0x0000) - not-present page
> [   75.862775] PGD 7d012067 P4D 7d012067 PUD 7d013067 PMD 0
> [   75.884283] Oops: Oops: 0000 [#1] SMP NOPTI
> [   75.902274] CPU: 1 UID: 0 PID: 6476 Comm: helmd Tainted: G
>  O       6.12.55+ #1
> [   75.928903] Tainted: [O]=3DOOT_MODULE
> [   75.942484] Hardware name: Google Google Compute Engine/Google
> Compute Engine, BIOS Google 01/01/2011
> [   75.965868] RIP: 0010:submit_bio_noacct+0x21d/0x470
> [   75.978340] Code: 8b 73 48 4d 85 f6 74 55 4c 63 25 b6 ad 89 01 49
> 83 fc 06 0f 83 44 02 00 00 4f 8b a4 e6 d0 00 00 00 83 3d 09 c9 7d 01
> 00 7e 3f <43> 80 bc 3c 56 01 00 00 00 0f 84 28 01 00 00 48 89 df e8 4c
> a0 02
> [   76.035847] RSP: 0018:ffffa41183463880 EFLAGS: 00010202
> [   76.050141] RAX: ffff9d4ec1a81a78 RBX: ffff9d4f3811e6c0 RCX: 000000000=
09410a0
> [   76.065176] RDX: 0000000010300001 RSI: ffff9d4ec1a81a78 RDI: ffff9d4f3=
811e6c0
> [   76.089292] RBP: ffffa411834638b0 R08: 0000000000001000 R09: ffff9d4f3=
811e6c0
> [   76.110878] R10: 2000000000000000 R11: ffffffff8a33e700 R12: 000000000=
0000000
> [   76.139068] R13: ffff9d4ec1422bc0 R14: ffff9d4ec2507000 R15: 000000000=
0000000
> [   76.168391] FS:  0000000008df7f40(0000) GS:ffff9d4f3dd00000(0000)
> knlGS:0000000000000000
> [   76.179024] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   76.184951] CR2: 0000000000000156 CR3: 000000007d01c006 CR4: 000000000=
0370ef0
> [   76.192352] Call Trace:
> [   76.194981]  <TASK>
> [   76.197257]  ext4_mpage_readpages+0x75c/0x790
> [   76.201794]  read_pages+0xa0/0x250
> [   76.205373]  page_cache_ra_unbounded+0xa2/0x1c0
> [   76.232608]  filemap_get_pages+0x16b/0x7a0
> [   76.254151]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   76.260523]  filemap_read+0xf6/0x440
> [   76.264540]  do_iter_readv_writev+0x17e/0x1c0
> [   76.275427]  vfs_iter_read+0x8a/0x140
> [   76.279272]  backing_file_read_iter+0x155/0x250
> [   76.284425]  ovl_read_iter+0xd7/0x120
> [   76.288270]  ? __pfx_ovl_file_accessed+0x10/0x10
> [   76.293069]  vfs_read+0x2b1/0x300
> [   76.296835]  ksys_read+0x75/0xe0
> [   76.300246]  do_syscall_64+0x61/0x130
> [   76.304173]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Our Findings:
>
> Not an Ext4 regression: We verified that reverting "ext4: reduce stack
> usage in ext4_mpage_readpages()" does not resolve the panic.
>
> Suspected Fix: We suspect upstream commit 18e48d0e2c7b ("ovl: store
> upper real file in ovl_file struct") is the correct fix. It seems to
> address this exact lifetime race by persistently pinning the
> underlying file.

That sounds odd.
Using a persistent upper real file may be more efficient than opening
a temporary file for every read, but the temporary file is a legit opened f=
ile,
so it looks like you would be averting the race rather than fixing it.

Could you try to analyse the conditions that caused the race?

>
> The Problem: We cannot apply 18e48d0e2c7b to 6.12 stable because it
> depends on the extensive ovl_real_file refactoring series (removing
> ovl_real_fdget family functions) that landed in 6.13.
>
> Is there a recommended way to backport the "persistent real file"
> logic to 6.12 without pulling in the entire refactor chain?
>

These are the commits in overlayfs/file.c v6.12..v6.13:

$ git log --oneline  v6.12..v6.13 -- fs/overlayfs/file.c
d66907b51ba07 ovl: convert ovl_real_fdget() callers to ovl_real_file()
4333e42ed4444 ovl: convert ovl_real_fdget_path() callers to ovl_real_file_p=
ath()
18e48d0e2c7b1 ovl: store upper real file in ovl_file struct
87a8a76c34a2a ovl: allocate a container struct ovl_file for ovl private con=
text
c2c54b5f34f63 ovl: do not open non-data lower file for fsync
fc5a1d2287bf2 ovl: use wrapper ovl_revert_creds()
48b50624aec45 backing-file: clean up the API

Your claim that 18e48d0e2c7b depends on ovl_real_fdget() is incorrect.
You may safely cherry-pick the 4 commits above leading to 18e48d0e2c7b1.
They are all self contained changes that would be good to have in 6.12.y,
because they would make cherry-picking future fixes easier.

Specifically, backing-file: clean up the API, it is better to have the same
API in upstream and stable kernels.

Thanks,
Amir.

