Return-Path: <linux-fsdevel+bounces-36581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F799E61B5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 01:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916042824E1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 00:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0254C9A;
	Fri,  6 Dec 2024 00:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhldsJqr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568764A00
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 00:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443611; cv=none; b=fl7XtYtYGl+T0gV176aMhmPsMBmqy50uqMz7Idn0FqJaJCyid4VCWJGEvr3DLFFhuO7TJCgUqqHCEz9sVAH57YzQjzZFAtjczW0ybOnR3AP7ZjZXHnhijUakTTJLAmoFtkaGYqfAEl92XyCvsr8g1p+2ALlxsG5AWS9AE83iYgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443611; c=relaxed/simple;
	bh=BVMKpQx9NkyFErHkOF29sErzBdXTtBlL5U8/xSKMk/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=apXOxP+vFhgoPpccZ5FhaPkNLCyKYkLHBri2CkMeX3nFiKACVGCxmGtc3sMKQ6kyjrnt/9VsZ24MMj3Qo/QDG2kJNiptswumQQdpQ8y52iGo93mrab3B41xqxZc3Q8YOl1Bw8I8r5G0jcw+LD3WVHsZinonIh7ZKmogaAP+LaD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhldsJqr; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4668978858aso12602011cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2024 16:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733443608; x=1734048408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHE2GeRTsKVGlPGwb7T82oK78Qetfeo8hQTHiUpstJg=;
        b=QhldsJqreVc8SPSxbtv8ad3boLhAiwKh7PSZKz2Rp2MPGuhnBaK+Y15LAa4ui2caDI
         nbiPl27OTZRFw4jHVP/fPDE70UceQ7zCBAM2UCZWfmbiCwXlUiMFyzQMvmx9Sb3IVWfz
         GkEl9a1lE1IhsWnspRbPGtMjoDR/pAjap+1oSBRJ6nG/T+e9X1dMcXe9eXcLdUHSPvVQ
         zIVv0w/q0yt2TSg4MgbJJJHdqs3jLDSob6Il10ZyG9b+wgFFKTYAUOa24QMtvJBn+bKK
         i2q86enKuPnrPb+S5gNPcpiM6iHZx1il0Uu7IKLUbsXSznuy0d5GOLpzp31EHb1XopBa
         xUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443608; x=1734048408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHE2GeRTsKVGlPGwb7T82oK78Qetfeo8hQTHiUpstJg=;
        b=jcfTnuO+DYN6BagLbj5gHNc57btGXKyqiS/QLg9WIyE7D/PZk1RsbcZHhRatDndgNL
         LdVPy7m/rKwscClQFuJmDHLpYf3gUUsfPfRF1op7HICfDBL3ZcmxNg+Qig2HELoJF2xy
         IPS0gOKNbzJXX/Nk4SQG9+Y6ah++r4s9GhQbVLJRv3+9mFmOMscTkTamRqF7MOZmLQGC
         FCD+d/QHXkMh/if9DKaIvUBbcP/z3tjDsJmwiwEv2xmPTBeIXC1SgtOsmHUg9ov1ysgD
         LFGs6IPN7NvLwwp0gB3KEI/NbHK1dBDOkcicYZdbv9zkYt1yFeewfIHUg7vxhi6bQklP
         uOag==
X-Forwarded-Encrypted: i=1; AJvYcCXDLSrp/yRdWKKvA+B5yBAbEex0mwNL2xVdSApjlipX5WqPiVolu+Bs/s+pCYcTyqv4AkKz1OacaatqY0gl@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3iElVGzjwfIeNFhZeftbxym8w/Eo+cclGrcFNVBTn/8cEVvYU
	XIZb3j6reO4ftEts+PY0W1+oUefADRlM+nvQyBDR2vniSzajKWGHBo1TvWJy3nVch+vHqG7vEbT
	tQnaglZhA3vLH/x6JN8guHHhWUlk=
X-Gm-Gg: ASbGncvsaF249l80EZZj3+J37rpy6YFatGQSEk+lgAnpRDLg+AsKMP3ZKDAq+KpDZ6s
	pV3KuDIlc2jp2VD8+WwbUAf5Uq2RCqDVpTHi6DbN1ZGM8F+o=
X-Google-Smtp-Source: AGHT+IEgBFJxLHZ+AAMa41mC5e5YNxLA/aua0W4jRLQRgJPmMY6dXtvF1MKDJJVEY/Z+6Y9ywNLmvdYJvc0Vq+p7b98=
X-Received: by 2002:a05:622a:22a9:b0:466:ac03:a714 with SMTP id
 d75a77b69052e-46734db8b01mr22603621cf.36.1733443608092; Thu, 05 Dec 2024
 16:06:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114191332.669127-1-joannelkoong@gmail.com>
 <20241114191332.669127-3-joannelkoong@gmail.com> <20241203110147.GD886051@google.com>
In-Reply-To: <20241203110147.GD886051@google.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 5 Dec 2024 16:06:37 -0800
Message-ID: <CAJnrk1bwYjHGGNsPwjsd5Kp3iL6ua_hmyN3kFZo1b8OVV9bOpw@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced timeout
 for requests
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	kernel-team@meta.com, Bernd Schubert <bschubert@ddn.com>, Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 3:01=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/11/14 11:13), Joanne Koong wrote:
> [..]
> > +static void fuse_init_fc_timeout(struct fuse_conn *fc, struct fuse_fs_=
context *ctx)
> > +{
> > +     if (ctx->req_timeout) {
> > +             if (check_mul_overflow(ctx->req_timeout * 60, HZ, &fc->ti=
meout.req_timeout))
> > +                     fc->timeout.req_timeout =3D ULONG_MAX;
> > +             timer_setup(&fc->timeout.timer, fuse_check_timeout, 0);
> > +             mod_timer(&fc->timeout.timer, jiffies + FUSE_TIMEOUT_TIME=
R_FREQ);
>
> So I think this will require much bigger changes in the code.
> fuse_check_timeout() is executed from IRQ context and it takes
> the same locks that are acquired by preemptive task contexts.
> So all of those now need to disable local IRQs before they
> acquire: fc->bg_lock, fig->lock, fc->lock.  Otherwise we are
> in a deadlock scenario (in many places, unfortunately).
>
> A simple example:
>
> [   91.466408]   _raw_spin_lock+0x39/0x70
> [   91.466420]   fuse_simple_background+0x902/0x1130 [fuse]
> [   91.466453]   fuse_send_init+0x337/0x680 [fuse]
> [   91.466485]   fuse_fill_super+0x1c8/0x200 [fuse]
> [   91.466516]   get_tree_nodev+0xaf/0x140
> [   91.466527]   fuse_get_tree+0x27e/0x450 [fuse]
> [   91.466559]   vfs_get_tree+0x88/0x240
> [   91.466569]   path_mount+0xf26/0x1ed0
> [   91.466579]   __se_sys_mount+0x1c9/0x240
> [   91.466588]   do_syscall_64+0x6f/0xa0
> [   91.466598]   entry_SYSCALL_64_after_hwframe+0x73/0xdd
> [   91.466666]
>                other info that might help us debug this:
> [   91.466672]  Possible unsafe locking scenario:
>
> [   91.466679]        CPU0
> [   91.466684]        ----
> [   91.466689]   lock(&fiq->lock);
> [   91.466701]   <Interrupt>
> [   91.466707]     lock(&fiq->lock);
> [   91.466718]
>                 *** DEADLOCK ***
>
> [   91.466724] 4 locks held by runtime_probe/5043:
> [   91.466732]  #0: ffff888005812448 (sb_writers#3){.+.+}-{0:0}, at: file=
name_create+0xb2/0x320
> [   91.466762]  #1: ffff8881499ea3f0 (&type->i_mutex_dir_key#5/1){+.+.}-{=
3:3}, at: filename_create+0x14c/0x320
> [   91.466791]  #2: ffffffff9d864ce0 (rcu_read_lock){....}-{1:2}, at: sec=
urity_sid_to_context_core+0xa4/0x4f0
> [   91.466817]  #3: ffff88815c009ec0 ((&fc->timeout.timer)){+.-.}-{0:0}, =
at: run_timer_softirq+0x702/0x1700
> [   91.466841]
>                stack backtrace:
> [   91.466850] CPU: 2 PID: 5043 Comm: runtime_probe Tainted: G     U     =
        6.6.63-lockdep #1 f2b045305e587e03c4766ca818bb77742f953c87
> [   91.466864] Hardware name: HP Lantis/Lantis, BIOS Google_Lantis.13606.=
437.0 01/21/2022
> [   91.466872] Call Trace:
> [   91.466881]  <IRQ>
> [   91.466889]  dump_stack_lvl+0x6d/0xb0
> [   91.466904]  print_usage_bug+0x8a4/0xbb0
> [   91.466917]  mark_lock+0x13ca/0x1940
> [   91.466930]  __lock_acquire+0xc10/0x2670
> [   91.466944]  lock_acquire+0x119/0x3a0
> [   91.466955]  ? fuse_check_timeout+0x32/0x630 [fuse c290dfa1c1147720280=
56af34b9662cba2d155b5]
> [   91.466992]  ? fuse_check_timeout+0x32/0x630 [fuse c290dfa1c1147720280=
56af34b9662cba2d155b5]
> [   91.467025]  _raw_spin_lock+0x39/0x70
> [   91.467036]  ? fuse_check_timeout+0x32/0x630 [fuse c290dfa1c1147720280=
56af34b9662cba2d155b5]
> [   91.467070]  fuse_check_timeout+0x32/0x630 [fuse c290dfa1c114772028056=
af34b9662cba2d155b5]
> [   91.467104]  ? run_timer_softirq+0x702/0x1700
> [   91.467114]  ? run_timer_softirq+0x702/0x1700
> [   91.467123]  ? __pfx_fuse_check_timeout+0x10/0x10 [fuse c290dfa1c11477=
2028056af34b9662cba2d155b5]
> [   91.467156]  run_timer_softirq+0x763/0x1700
> [   91.467172]  irq_exit_rcu+0x300/0x7d0
> [   91.467183]  ? sysvec_apic_timer_interrupt+0x56/0x90
> [   91.467195]  sysvec_apic_timer_interrupt+0x56/0x90
> [   91.467205]  </IRQ>
>
> Do we want to run fuse-watchdog as a preemptive task instead of
> IRQ context?  Simlar to the way the hung-task watchdog runs, for
> example.  Yes, it now may starve and not get scheduled in corner
> cases (under some crazy pressure), but at least we don't need to
> patch the entire fuse code to use irq_safe/irq_restore locking
> variants.

Interesting! Thanks for noting this.

It looks like the choices we have here then are to either:

* have this run in a kthread like hung-task watchdog, as you mentioned abov=
e
* have all fuse code use irq_safe/irq_restore for locks
* use a separate spinlock/list for request timeouts as per the
implementation in v7 [1], though will need to benchmark this to make
sure performance doesn't degrade from lock contention if lots of
requests are submitted in parallel

Having 1 extra kthread per server as overhead doesn't seem too bad to
me. There's already an upper margin of imprecision with the timer
implementation, so I don't see the kthread scheduling imprecision as a
big deal.

I'll restructure this to use a kthread in v10. If anyone has thoughts
on a better or more preferred approach though, would love to hear
them.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20241007184258.2837492-3-joannelk=
oong@gmail.com/

