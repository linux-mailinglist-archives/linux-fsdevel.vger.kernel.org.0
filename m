Return-Path: <linux-fsdevel+bounces-23479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5A592D182
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 14:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90139284149
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 12:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BD6191491;
	Wed, 10 Jul 2024 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S01nk2H0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09886848E;
	Wed, 10 Jul 2024 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720614271; cv=none; b=VDEj0zcNHUUlJ4SiZp2OcVr+7k9zu+1BsWl6XVryzLgkrnreDeARHgCXp0FAwRnVLvTpJV46NL91glNbTaU52xqoRJggLNxfuaSJfrDqDAH+mIQrKzr2hQoM49+EmetyVuPqmyYbWD8iJv3pQ4D07sGakR8oAibnQWJKqeCsoxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720614271; c=relaxed/simple;
	bh=kbU7tD2GBgU8NvEktzRkbYPDMzRKvaYJa29eeuiH0V0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAYprRjBk3mRf4XrCdqh9ojz57Vn3n6eUJ7U0wgxInfPH5xEnyJjQVo/Gxnsi36SoE3Qk22F+zeVJpl5M3bb5Bvv+r11DJPpDz0WJLuWCTd385uhfrziyHMBPXSypHQVjYpjX+mm/6scGVWzrAeLTHlgRJqf5wGQyl+OT9TblOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S01nk2H0; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a77c349bb81so579195466b.3;
        Wed, 10 Jul 2024 05:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720614268; x=1721219068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mv9Ma+PfTP3jkLEGca17uO0MTJeX8PXN4+wRnopYpKE=;
        b=S01nk2H0/a/lXTYTZcSwykt/ss9ZSZf2uIiDo3mRsgY/PodKHCxeIebOvk3Gv6jgjM
         UsYnyDY+Qhth+au7JWb77fIz0TrA3XjUY5sp37LfAxVDX+3mddTGdiQ2PJVBC90kZ11M
         6ier1yLsHEHOT/5JNMeGTxE2bhXb/CPhANuTJU2cttOkN5xdEovy4y4nUcJBSQxlKxbU
         rmGLQqGT6g8FYgkxgChTHPEpi6fdSM4OW0h5/maG/L04xkYF091JdcGyAzPOrJGuAHVa
         Va/miIAC4W8ju5OgyNG4RPvPVTzxth9mtU34xcOkkPUJe2IMR1DfQZ3I1rxzLkHRfCJw
         +1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720614268; x=1721219068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mv9Ma+PfTP3jkLEGca17uO0MTJeX8PXN4+wRnopYpKE=;
        b=Wsz0XjK1EX9KepWkQE/nS+/QELPvufpLGdnAqpuNGBD7E7G3+e7pcT+qzMp6mZVVPW
         zEjNnZ4MIUaX4Og9uMq+jn2mPqwHeu+5HjhZXFqEhfD4J2OVQqZmXWYL5niNkswaaUEW
         dncX8slaLqqjdjCSv7kKqhvTGDiiaojhMOPltd2IWPrIeM9a8nKF2YBEUvSFQhTUAj6m
         VXW6EiQKUT0diLlC8XMZU1QmQeJgmbt3daEFAbGJzmwE2NWrrb2/lPkHOlwy26GufTqT
         OSm2zKaViECY2R+JE9MmKybrOz98W4GzeFm3K3X7yxZlvd1ybj1RrVW3jNFQoHLnL1P9
         zZNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkbd7En6LtXrN/jIZ0rqn3/ImKCvbw3AlLfiMTEOkcTwkqk2pvT9QtNDn+ihd7z2otr+yYgfkIP3d7c/WsbDV2rXWV0zi3K2pUtw9IEy2jxqN5RzqovL3/HQvjESi6sMFgEYjnyET9PV/7Iw==
X-Gm-Message-State: AOJu0YyqO5kqqheSaBSeIPMDoFDENp7Nt5mNnyfyxDc42L4h+td8+OB+
	HKsTyKdmNdFmXq6TSKejL5JL5FXUYfzvbDHhtMYhS1TPUBfQrJ62oPSziOPhdACIPBDGCM+znk+
	VSwfh/32wvIhBHauzQAzXu+4xXrQ=
X-Google-Smtp-Source: AGHT+IEXhNr2COma1ZTpeoyqBrcvGs3CYE3G72PaJVMCpLT5Ns64zmX9n+ExOaPDVMP2uN5DPhWGtpOWxmooj8sHVHA=
X-Received: by 2002:a17:906:cd0d:b0:a72:8d2f:859c with SMTP id
 a640c23a62f3a-a780b6ff0f7mr302169566b.33.1720614268121; Wed, 10 Jul 2024
 05:24:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com> <CAOUHufawNerxqLm7L9Yywp3HJFiYVrYO26ePUb1jH-qxNGWzyA@mail.gmail.com>
 <4307e984-a593-4495-b4cc-8ef509ddda03@amd.com>
In-Reply-To: <4307e984-a593-4495-b4cc-8ef509ddda03@amd.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 10 Jul 2024 14:24:16 +0200
Message-ID: <CAGudoHH4N0eEQCpJqFioRCJx75WAO5n+kCA0XcRZ-914xFR0gw@mail.gmail.com>
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
To: Bharata B Rao <bharata@amd.com>
Cc: Yu Zhao <yuzhao@google.com>, david@fromorbit.com, kent.overstreet@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, nikunj@amd.com, 
	"Upadhyay, Neeraj" <Neeraj.Upadhyay@amd.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, willy@infradead.org, vbabka@suse.cz, kinseyho@google.com, 
	Mel Gorman <mgorman@suse.de>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 2:04=E2=80=AFPM Bharata B Rao <bharata@amd.com> wro=
te:
>
> On 07-Jul-24 4:12 AM, Yu Zhao wrote:
> >> Some experiments tried
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> 1) When MGLRU was enabled many soft lockups were observed, no hard
> >> lockups were seen for 48 hours run. Below is once such soft lockup.
> <snip>
> >> Below preemptirqsoff trace points to preemption being disabled for mor=
e
> >> than 10s and the lock in picture is lruvec spinlock.
> >
> > Also if you could try the other patch (mglru.patch) please. It should
> > help reduce unnecessary rotations from deactivate_file_folio(), which
> > in turn should reduce the contention on the LRU lock for MGLRU.
>
> Thanks. With mglru.patch on a MGLRU-enabled system, the below latency
> trace record is no longer seen for a 30hr workload run.
>
> >
> >>       # tracer: preemptirqsoff
> >>       #
> >>       # preemptirqsoff latency trace v1.1.5 on 6.10.0-rc3-mglru-irqstr=
c
> >>       # --------------------------------------------------------------=
------
> >>       # latency: 10382682 us, #4/4, CPU#128 | (M:desktop VP:0, KP:0, S=
P:0
> >> HP:0 #P:512)
> >>       #    -----------------
> >>       #    | task: fio-2701523 (uid:0 nice:0 policy:0 rt_prio:0)
> >>       #    -----------------
> >>       #  =3D> started at: deactivate_file_folio
> >>       #  =3D> ended at:   deactivate_file_folio
> >>       #
> >>       #
> >>       #                    _------=3D> CPU#
> >>       #                   / _-----=3D> irqs-off/BH-disabled
> >>       #                  | / _----=3D> need-resched
> >>       #                  || / _---=3D> hardirq/softirq
> >>       #                  ||| / _--=3D> preempt-depth
> >>       #                  |||| / _-=3D> migrate-disable
> >>       #                  ||||| /     delay
> >>       #  cmd     pid     |||||| time  |   caller
> >>       #     \   /        ||||||  \    |    /
> >>            fio-2701523 128...1.    0us$: deactivate_file_folio
> >> <-deactivate_file_folio
> >>            fio-2701523 128.N.1. 10382681us : deactivate_file_folio
> >> <-deactivate_file_folio
> >>            fio-2701523 128.N.1. 10382683us : tracer_preempt_on
> >> <-deactivate_file_folio
> >>            fio-2701523 128.N.1. 10382691us : <stack trace>
> >>        =3D> deactivate_file_folio
> >>        =3D> mapping_try_invalidate
> >>        =3D> invalidate_mapping_pages
> >>        =3D> invalidate_bdev
> >>        =3D> blkdev_common_ioctl
> >>        =3D> blkdev_ioctl
> >>        =3D> __x64_sys_ioctl
> >>        =3D> x64_sys_call
> >>        =3D> do_syscall_64
> >>        =3D> entry_SYSCALL_64_after_hwframe
>
> However the contention now has shifted to inode_hash_lock. Around 55
> softlockups in ilookup() were observed:
>
> # tracer: preemptirqsoff
> #
> # preemptirqsoff latency trace v1.1.5 on 6.10.0-rc3-trnmglru
> # --------------------------------------------------------------------
> # latency: 10620430 us, #4/4, CPU#260 | (M:desktop VP:0, KP:0, SP:0 HP:0
> #P:512)
> #    -----------------
> #    | task: fio-3244715 (uid:0 nice:0 policy:0 rt_prio:0)
> #    -----------------
> #  =3D> started at: ilookup
> #  =3D> ended at:   ilookup
> #
> #
> #                    _------=3D> CPU#
> #                   / _-----=3D> irqs-off/BH-disabled
> #                  | / _----=3D> need-resched
> #                  || / _---=3D> hardirq/softirq
> #                  ||| / _--=3D> preempt-depth
> #                  |||| / _-=3D> migrate-disable
> #                  ||||| /     delay
> #  cmd     pid     |||||| time  |   caller
> #     \   /        ||||||  \    |    /
>       fio-3244715 260...1.    0us$: _raw_spin_lock <-ilookup
>       fio-3244715 260.N.1. 10620429us : _raw_spin_unlock <-ilookup
>       fio-3244715 260.N.1. 10620430us : tracer_preempt_on <-ilookup
>       fio-3244715 260.N.1. 10620440us : <stack trace>
> =3D> _raw_spin_unlock
> =3D> ilookup
> =3D> blkdev_get_no_open
> =3D> blkdev_open
> =3D> do_dentry_open
> =3D> vfs_open
> =3D> path_openat
> =3D> do_filp_open
> =3D> do_sys_openat2
> =3D> __x64_sys_openat
> =3D> x64_sys_call
> =3D> do_syscall_64
> =3D> entry_SYSCALL_64_after_hwframe
>
> It appears that scalability issues with inode_hash_lock has been brought
> up multiple times in the past and there were patches to address the same.
>
> https://lore.kernel.org/all/20231206060629.2827226-9-david@fromorbit.com/
> https://lore.kernel.org/lkml/20240611173824.535995-2-mjguzik@gmail.com/
>
> CC'ing FS folks/list for awareness/comments.

Note my patch does not enable RCU usage in ilookup, but this can be
trivially added.

I can't even compile-test at the moment, but the diff below should do
it. Also note the patches are present here
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=3Dvfs.in=
ode.rcu
, not yet integrated anywhere.

That said, if fio you are operating on the same target inode every
time then this is merely going to shift contention to the inode
spinlock usage in find_inode_fast.

diff --git a/fs/inode.c b/fs/inode.c
index ad7844ca92f9..70b0e6383341 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1524,10 +1524,14 @@ struct inode *ilookup(struct super_block *sb,
unsigned long ino)
 {
        struct hlist_head *head =3D inode_hashtable + hash(sb, ino);
        struct inode *inode;
+
 again:
-       spin_lock(&inode_hash_lock);
-       inode =3D find_inode_fast(sb, head, ino, true);
-       spin_unlock(&inode_hash_lock);
+       inode =3D find_inode_fast(sb, head, ino, false);
+       if (IS_ERR_OR_NULL_PTR(inode)) {
+               spin_lock(&inode_hash_lock);
+               inode =3D find_inode_fast(sb, head, ino, true);
+               spin_unlock(&inode_hash_lock);
+       }

        if (inode) {
                if (IS_ERR(inode))



--=20
Mateusz Guzik <mjguzik gmail.com>

