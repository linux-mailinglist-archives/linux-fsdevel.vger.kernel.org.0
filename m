Return-Path: <linux-fsdevel+bounces-74041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42956D2A6AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 03:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 250923020489
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 02:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CCA33D6C8;
	Fri, 16 Jan 2026 02:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4ylF0czn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4A723AE87
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 02:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768532184; cv=pass; b=uCG1SiiVJG8ac/mh0ote7jqgqdclvu3tMjaqeGKpC1/hu6SFNgaqqoiPAw5kHglaNh9CFQ0AESplLz+I5baIS2dO2gR3WiaEsl86mFvXkYTxUfUsLWYcZx1jRihEXYO9DgYeMbrrHrk3BUwCnadL1T8Rsd4ykqGovnHHi/BXS9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768532184; c=relaxed/simple;
	bh=uA3lxL+VCT4+Wwu0Lkltb95sJQXSugpjTR0SXNKJqdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLIDxgrdFaengKZXWbHObmTjY2//9Sg21wWfeXj3dI92iR7NVdF6CC0ppMFjeHog0ITwtS7xMdqh6qi8f0GKzLaL/NdgNHGbtmku+MCw5pWXAUDuMt4i9M0Dujw/avDVnYP7Obwv6ZIdei8vRL0R1wnWuEuJ2g4hVXzHRHdZuUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4ylF0czn; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-501511aa012so186811cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 18:56:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768532181; cv=none;
        d=google.com; s=arc-20240605;
        b=H5RROfoMXX/gRS83rAeip/rKBr1Nhw2Rgzqm/vkOeXesQZbVSLxD18Ah0SyxNV/1Xe
         CVhz/heUTqn/n7FyJ+NNZFVhd9Aoh0oZdM1ZL2pNU51BqU8jAesMf9GvMwFaicPsuSTW
         pETx5m4AMmaARigKWM+f9SiiN3wVK8xRkP3rvXCCQdQuFmR9UKZVIUsZavK3na3TMRKf
         PnJ/vB4XBS7QgvDlazkr7UV/0EiMcULy1CJQOunstphGnrL4jVFCk+m7rYsl1UHugS3T
         BP0sJRZG+xvu4ypq+02VP8Uhh8Pv5flaVaH7/MT79daewLAo8o5z0Popn+ehiCxsL6QV
         VSFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MLt6ORb6U2Ebj9R2h4+wvG1UCOEjGPy/gdaA2YEn6U8=;
        fh=prERnAJ19HDDQUJkzd/URp96/55GH6nMxP8F/+wObfQ=;
        b=W9v0RKz/Xso8/5HX9xJzIFP+W0oNiIrrlO5IwtMuq++3o4woirzrw+o+juVcHXxmk9
         3+/rkTmnPYup0IYT1piV6IeiLYovK9h8rgHMuoDtXvbq3zJbWdYLyjlg2SXQoY4WhOrA
         +qiApUKI415v8yY1a6o6SgbVnfLl9sMWHbbMLGiLh671Rdj+2OsilsRJCOQNMiI0apx/
         g9zdV9qmJL0CShG0AC5GNkqI/WvxwFq6nnpgMFo78tpTWJsjc5OR84X4ci/KPJhczRn3
         sz7yF14BJ6ftZ8Q0cdm9dNzhorbFTyl4K1KuQi5BYJFUCESMCXbAmyJm/iXBS6oeiItv
         ZLCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768532181; x=1769136981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLt6ORb6U2Ebj9R2h4+wvG1UCOEjGPy/gdaA2YEn6U8=;
        b=4ylF0cznXJsb4NLP4E5du8IDmt3q22hd3ZWgnB2ne3yjfMIMojFNBc/PIoO6+U/NXs
         57RTh6I//7Z5Ea+8cq8L8VMeq1b6jUHye4IGwFv4PDLcmZJHgUjkYGhGf9HwNzhPQ9fb
         WWD/xt86UJbTnG/l22FS0ECrQQCmJGDgZYIFWlxY5ZRq+Eez4FBBoTGAskwz2Ddk1mNt
         KBo+evDGPsEZCgg6znQhLYpa6l654W3TzpetYNf52dMh4XMxLa92NJY7hLmhg0PeyRkE
         UQEiWh+FWf+u+Y8dwgBXJgUyJyIEaV21Zicm/1+dW0bqq4+5EJI2uzHD5N82UlrSlst3
         C6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768532181; x=1769136981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MLt6ORb6U2Ebj9R2h4+wvG1UCOEjGPy/gdaA2YEn6U8=;
        b=A5ga8Ul3HrYy6W1vqWURHQhtpZqYPgkixb+O7sk2EMJnj7vhSi+60pgdTpGIcTIvdi
         ziMBh6A1kRuuVkWKYHIz51USg6FYivDmDiD8pGYpeqP76DqyCG2UOO1IagNEuvL/nnrj
         Otw1sJMX3BN+F6w6JWim+YOnEIVl0B/Rx9g/fX7eVr9LlpgmM9rLgpd512/nGz4Z+B2g
         Y3Tk3rvawz65fXbHJ9MAoo6lzI0AOLWulY39IRSJAmhugDM15O+K6YAOEqHiVvG8WVLX
         p8DD2c/yKG1E1GoC7v1Pe6xtp+2eyjmKnVA9UjLiuV71gSGpvtLnGZa1hl3gQsfH/Mip
         ZxXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpLeq9LgbabyAOLSWskIJVLZKFIg26zE5krXxJQCmBSoDkAOpxqOS2yBJL+Sg9kgJ+c3NhBWl+v8kjK6bA@vger.kernel.org
X-Gm-Message-State: AOJu0YwivirIXu+d/Po91WmFe4TMglN61M/ugA+R7afngccf9k6R+Ovi
	YCO2ZWMUbw3MkL8sVJEgZ5gO2pbmBuAQuQxfCJLSi8fAt9ZVUjvNBLTIZu1+K0aP2PNPJRIE3WM
	hf3ky1l4/tUfUFntTxkZnP4aFm6go/hNQof+EEK4Z
X-Gm-Gg: AY/fxX7QBvqA+rsBZ8OPKsS1bKcUbu3i1SThN8rDyxszfKAADWFcAw0sDVVH+ApGWvh
	xW4aC/NFZozRUIZanBrR3WevBj/kwL8Lyh2L4xwKh1SKtQkFIvQBUDKRx4+Qr8snn1+N3u6+Kxq
	s5FBSOQm92Ug+YR5UCCR1/6lz7RZivwgQtS4oHZWkQ5MGA7hBGMoMzT+fxB91IY5F2uaql2075x
	DHSg3BX+4JHKkZl8D2EGYHDZB1XVxWEA82tRXHA5PbhIzkTPqRR1LTOn5Ln10vVlYphve/2qXRK
	vlfCNg==
X-Received: by 2002:ac8:7f4b:0:b0:4ed:ff79:e679 with SMTP id
 d75a77b69052e-502a3753765mr3421141cf.19.1768532181115; Thu, 15 Jan 2026
 18:56:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOdxtTZ=SuV2GMPuqQJe6h-h-CDiG5yBW+07f1QYEw+kTA4-2w@mail.gmail.com>
 <CAOQ4uxggQekxqavkt+RiJd9s9cdDgXZuVfQrL_qNciBNf=4Lww@mail.gmail.com>
In-Reply-To: <CAOQ4uxggQekxqavkt+RiJd9s9cdDgXZuVfQrL_qNciBNf=4Lww@mail.gmail.com>
From: Chenglong Tang <chenglongtang@google.com>
Date: Thu, 15 Jan 2026 18:56:10 -0800
X-Gm-Features: AZwV_QgkkKdsp0jb_IJ0WyNwDLNKU0CrjDwfgGfumHkre_uShEOpxmrIJdb0yWw
Message-ID: <CAOdxtTaz7=TzQizrdMEhjgt7LpuuHWzTO80783RLcB_GP3nPdw@mail.gmail.com>
Subject: Re: [Regression 6.12] NULL pointer dereference in submit_bio_noacct
 via backing_file_read_iter
To: Amir Goldstein <amir73il@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amir,

Thanks for the guidance. Using the specific order of the 8 commits
(applying the ovl_real_fdget refactors before the fix consumers)
resolved the boot-time NULL pointer panic. The system now boots
successfully.

However, we are still hitting the original kernel panic during runtime
tests (specifically a CloudSQL workload).

Current Commit Chain (Applied to 6.12):

76d83345a056 (HEAD -> main-R125-cos-6.12) ovl: convert
ovl_real_fdget() callers to ovl_real_file()
740bdf920b15 ovl: convert ovl_real_fdget_path() callers to ovl_real_file_pa=
th()
100b71ecb237 fs/backing_file: fix wrong argument in callback
b877bca6858d ovl: store upper real file in ovl_file struct
595aac630596 ovl: allocate a container struct ovl_file for ovl private cont=
ext
218ec543008d ovl: do not open non-data lower file for fsync
6def078942e2 ovl: use wrapper ovl_revert_creds()
fe73aad71936 backing-file: clean up the API

So it means none of these 8 commits were able to fix the problem. Let
me explain what's going on here:

We are reporting a rare but persistent kernel panic (~0.02% failure
rate) occurring during container initialization on Linux 6.12.55+
(x86_64). The 6.6.x is good. The panic is a NULL pointer dereference
in submit_bio_noacct, triggered specifically when the Integrity
Measurement Architecture (IMA) calculates a file hash during a runc
create operation.

We have isolated the crash to a specific container (ncsa) starting up
during a high-concurrency boot sequence.

Environment
* Kernel: Linux 6.12.55+ (x86_64) / Container-Optimized OS
* Workload: Cloud SQL instance initialization (heavy concurrent runc
operations managed by systemd).
* Filesystem: Ext4 backed by NVMe.
* Security: AppArmor enabled, IMA (Integrity Measurement Architecture) acti=
ve.

The Failure Pattern(In every crash instance, the sequence is identical):
* systemd initiates the startup of the ncsainit container.
* runc executes the create command:
`Bash
`runc --root /var/lib/cloudsql/runc/root create --bundle
/var/lib/cloudsql/runc/bundles/ncsa ...

Immediately after this command is logged, the kernel panics.

Stacktrace:
[  186.938290] BUG: kernel NULL pointer dereference, address: 0000000000000=
156
[  186.952203] #PF: supervisor read access in kernel mode
[  186.995248] Oops: Oops: 0000 [#1] SMP PTI
[  187.035946] CPU: 1 UID: 0 PID: 6764 Comm: runc:[2:INIT] Tainted: G
         O       6.12.55+ #1
[  187.081681] RIP: 0010:submit_bio_noacct+0x21d/0x470
[  187.412981] Call Trace:
[  187.415751]  <TASK>
[  187.418141]  ext4_mpage_readpages+0x75c/0x790
[  187.429011]  read_pages+0x9d/0x250
[  187.450963]  page_cache_ra_unbounded+0xa2/0x1c0
[  187.466083]  filemap_get_pages+0x231/0x7a0
[  187.474687]  filemap_read+0xf6/0x440
[  187.532345]  integrity_kernel_read+0x34/0x60
[  187.560740]  ima_calc_file_hash+0x1c1/0x9b0
[  187.608175]  ima_collect_measurement+0x1b6/0x310
[  187.613102]  process_measurement+0x4ea/0x850
[  187.617788]  ima_bprm_check+0x5b/0xc0
[  187.635403]  bprm_execve+0x203/0x560
[  187.645058]  do_execveat_common+0x2fb/0x360
[  187.649730]  __x64_sys_execve+0x3e/0x50

Panic Analysis: The stack trace indicates a race condition where
ima_bprm_check (triggered by executing the container binary) attempts
to verify the file. This calls ima_calc_file_hash ->
ext4_mpage_readpages, which submits a bio to the block layer.

The crash occurs in submit_bio_noacct when it attempts to dereference
a member of the bio structure (likely bio->bi_bdev or the request
queue), suggesting the underlying device or queue structure is either
uninitialized or has been torn down while the IMA check was still in
flight.

Context on Concurrency: This workload involves systemd starting
multiple sidecar containers (logging, monitoring, coroner, etc.)
simultaneously. We suspect this high-concurrency startup creates the
IO/CPU contention required to hit this race window. However, the crash
consistently happens only on the ncsa container, implying something
specific about its launch configuration or timing makes it the
reliable victim.

Best,

Chenglong

On Wed, Jan 14, 2026 at 3:11=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Wed, Jan 14, 2026 at 1:53=E2=80=AFAM Chenglong Tang <chenglongtang@goo=
gle.com> wrote:
> >
> > Hi OverlayFS Maintainers,
> >
> > This is from Container Optimized OS in Google Cloud.
> >
> > We are reporting a reproducible kernel panic on Kernel 6.12 involving
> > a NULL pointer dereference in submit_bio_noacct.
> >
> > The Issue: The panic occurs intermittently (approx. 5 failures in 1000
> > runs) during a specific PostgreSQL client test
> > (postgres_client_test_postgres15_ctrdncsa) on Google
> > Container-Optimized OS. The stack trace shows the crash happens when
> > IMA (ima_calc_file_hash) attempts to read a file from OverlayFS via
> > the new-in-6.12 backing_file_read_iter helper.
> >
> > It appears to be a race condition where the underlying block device is
> > detached (becoming NULL) while the backing_file wrapper is still
> > attempting to submit a read bio during container teardown.
> >
> > Stack Trace:
> > [  OK  ] Started    75.793015] BUG: kernel NULL pointer dereference,
> > address: 0000000000000156
> > [   75.822539] #PF: supervisor read access in kernel mode
> > [   75.849332] #PF: error_code(0x0000) - not-present page
> > [   75.862775] PGD 7d012067 P4D 7d012067 PUD 7d013067 PMD 0
> > [   75.884283] Oops: Oops: 0000 [#1] SMP NOPTI
> > [   75.902274] CPU: 1 UID: 0 PID: 6476 Comm: helmd Tainted: G
> >  O       6.12.55+ #1
> > [   75.928903] Tainted: [O]=3DOOT_MODULE
> > [   75.942484] Hardware name: Google Google Compute Engine/Google
> > Compute Engine, BIOS Google 01/01/2011
> > [   75.965868] RIP: 0010:submit_bio_noacct+0x21d/0x470
> > [   75.978340] Code: 8b 73 48 4d 85 f6 74 55 4c 63 25 b6 ad 89 01 49
> > 83 fc 06 0f 83 44 02 00 00 4f 8b a4 e6 d0 00 00 00 83 3d 09 c9 7d 01
> > 00 7e 3f <43> 80 bc 3c 56 01 00 00 00 0f 84 28 01 00 00 48 89 df e8 4c
> > a0 02
> > [   76.035847] RSP: 0018:ffffa41183463880 EFLAGS: 00010202
> > [   76.050141] RAX: ffff9d4ec1a81a78 RBX: ffff9d4f3811e6c0 RCX: 0000000=
0009410a0
> > [   76.065176] RDX: 0000000010300001 RSI: ffff9d4ec1a81a78 RDI: ffff9d4=
f3811e6c0
> > [   76.089292] RBP: ffffa411834638b0 R08: 0000000000001000 R09: ffff9d4=
f3811e6c0
> > [   76.110878] R10: 2000000000000000 R11: ffffffff8a33e700 R12: 0000000=
000000000
> > [   76.139068] R13: ffff9d4ec1422bc0 R14: ffff9d4ec2507000 R15: 0000000=
000000000
> > [   76.168391] FS:  0000000008df7f40(0000) GS:ffff9d4f3dd00000(0000)
> > knlGS:0000000000000000
> > [   76.179024] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   76.184951] CR2: 0000000000000156 CR3: 000000007d01c006 CR4: 0000000=
000370ef0
> > [   76.192352] Call Trace:
> > [   76.194981]  <TASK>
> > [   76.197257]  ext4_mpage_readpages+0x75c/0x790
> > [   76.201794]  read_pages+0xa0/0x250
> > [   76.205373]  page_cache_ra_unbounded+0xa2/0x1c0
> > [   76.232608]  filemap_get_pages+0x16b/0x7a0
> > [   76.254151]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   76.260523]  filemap_read+0xf6/0x440
> > [   76.264540]  do_iter_readv_writev+0x17e/0x1c0
> > [   76.275427]  vfs_iter_read+0x8a/0x140
> > [   76.279272]  backing_file_read_iter+0x155/0x250
> > [   76.284425]  ovl_read_iter+0xd7/0x120
> > [   76.288270]  ? __pfx_ovl_file_accessed+0x10/0x10
> > [   76.293069]  vfs_read+0x2b1/0x300
> > [   76.296835]  ksys_read+0x75/0xe0
> > [   76.300246]  do_syscall_64+0x61/0x130
> > [   76.304173]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > Our Findings:
> >
> > Not an Ext4 regression: We verified that reverting "ext4: reduce stack
> > usage in ext4_mpage_readpages()" does not resolve the panic.
> >
> > Suspected Fix: We suspect upstream commit 18e48d0e2c7b ("ovl: store
> > upper real file in ovl_file struct") is the correct fix. It seems to
> > address this exact lifetime race by persistently pinning the
> > underlying file.
>
> That sounds odd.
> Using a persistent upper real file may be more efficient than opening
> a temporary file for every read, but the temporary file is a legit opened=
 file,
> so it looks like you would be averting the race rather than fixing it.
>
> Could you try to analyse the conditions that caused the race?
>
> >
> > The Problem: We cannot apply 18e48d0e2c7b to 6.12 stable because it
> > depends on the extensive ovl_real_file refactoring series (removing
> > ovl_real_fdget family functions) that landed in 6.13.
> >
> > Is there a recommended way to backport the "persistent real file"
> > logic to 6.12 without pulling in the entire refactor chain?
> >
>
> These are the commits in overlayfs/file.c v6.12..v6.13:
>
> $ git log --oneline  v6.12..v6.13 -- fs/overlayfs/file.c
> d66907b51ba07 ovl: convert ovl_real_fdget() callers to ovl_real_file()
> 4333e42ed4444 ovl: convert ovl_real_fdget_path() callers to ovl_real_file=
_path()
> 18e48d0e2c7b1 ovl: store upper real file in ovl_file struct
> 87a8a76c34a2a ovl: allocate a container struct ovl_file for ovl private c=
ontext
> c2c54b5f34f63 ovl: do not open non-data lower file for fsync
> fc5a1d2287bf2 ovl: use wrapper ovl_revert_creds()
> 48b50624aec45 backing-file: clean up the API
>
> Your claim that 18e48d0e2c7b depends on ovl_real_fdget() is incorrect.
> You may safely cherry-pick the 4 commits above leading to 18e48d0e2c7b1.
> They are all self contained changes that would be good to have in 6.12.y,
> because they would make cherry-picking future fixes easier.
>
> Specifically, backing-file: clean up the API, it is better to have the sa=
me
> API in upstream and stable kernels.
>
> Thanks,
> Amir.

