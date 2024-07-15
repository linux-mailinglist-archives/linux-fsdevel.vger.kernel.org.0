Return-Path: <linux-fsdevel+bounces-23651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A63F930E42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 08:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B72531C2105F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 06:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BD21836D0;
	Mon, 15 Jul 2024 06:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcSkKarE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119B0139CF7;
	Mon, 15 Jul 2024 06:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721026110; cv=none; b=OyphorpLYpYNB9tOBbdSb8fgkKgOCrOBaL+9kvGyqDQyWpRA2gJwV/hptwTlNtSR3B1d0D3u6YzrkrzCu920BbHHIZQqUFKKzS/zW0z+CqLYNUswdJCVq4arVlVwQLRGAZyV/swuCr+p/3/xpNHnWYALuuqamPqzzZgTDxVwn5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721026110; c=relaxed/simple;
	bh=Yx51EBHd6ANNdgx2r5XWJA67JqrEZ09U5J7g8muBbA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iwetZCFuHkJ4OA79Y2gEW8WRYqoJNIZ83nu81geU5iPzvEAcaZc57/jjj8/09+tyHDlr11SqiQr3WZyyhppmJRatDHYsoDJJD+IoCfoDprQJiMq2RNU4OWW43cSv1fSqxcMxbjXThGCEhZbfHFVmlpc3gPXsYAewswOAaXh7r/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcSkKarE; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a77cb7c106dso456118166b.1;
        Sun, 14 Jul 2024 23:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721026107; x=1721630907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Oz8knHFwgcqwN4/UwgnsxKPZXuajSlpZ5Udb9VAOsE=;
        b=RcSkKarEBXo0H2CLm7vLK4pV3h2AOOT9w1QNHh1g43UoXvr2wQvdxaiTzU967Jf/+V
         wEmEskkx7BNgR0dQKru462V4xrCIF3csCEJYqgwY2sdHHrdBdKG8Gfzf6hHy+fKBbmi4
         1QaO/tpuE4HVvp92Llwgh9XGMIX7fLfUleLgPM18rzqa0JYJKs9fFEwXlhnKDnxHBQrv
         /wjytjpon0S0Jzltoza1fhNYr29j0VuRqv9IXGp9cRcNt+1hqxmkdGRgjOLNQSlgbGzy
         SUTGEt5wsD7PdLt+vh07+ZXPk1YhgeuMFrk6TI4enaa+bkipOBzi+JLdwvvydZmh5EnY
         eKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721026107; x=1721630907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Oz8knHFwgcqwN4/UwgnsxKPZXuajSlpZ5Udb9VAOsE=;
        b=Qw7pn6ep9+HXV6AKEF8wO+lT3GrJMyvoZfUSu3BKbaN5tM25zFSUaq0PCIY25E6fpa
         77T5wipzm18ED6bipPRT2s8q6vkUZW/ngEmA5imdC8EUnDqnEnX00sR0UQsbPyNH17xL
         +czuJVIFhxi2zoxfTY9H3U3E3k/fsrywqVWSD/hlfwqeNBFcQrDyNyMy6wNo0Ztf6O+t
         bx1OTonhrD6O7K3JfzgwH9ali/4RLc/3jDdJQ8JVA4udc1ZyD70tebSM6AzCACFO6KQB
         meZ09PO75ajz+lKIOrsigwaRVYabbCDxvcysIFyrh3Vow9l3nwZQFAFYTChMox5s1tm0
         mkng==
X-Forwarded-Encrypted: i=1; AJvYcCU7sxc/IEQRGLB7zQQxVSJpgP7olOzJzzC/fsOuZ5H+KSVAEz1jALa2AK4N1xUxfIwFtK+/9WdUqiYzBJFuSDi4OXVDuIVc2eO5n36IHtnnQ9v7/ACN2OHwT/PbGLptMpAUzePbdkYxS+Z0Xw==
X-Gm-Message-State: AOJu0YxP5PU6VqU7K5/FJEtw9ELt/d4SVDZFIgv38itslw9VevA5eYzZ
	gEv+I9cnGRj9SNf4BGdJDj7J49DBgzgo/AmnWFEBbCdBz15jSv6aO5KYVoKTcXRdiuHYZMMv47K
	XO9t8gwliFkeOj3g0zJ3punbUfsI=
X-Google-Smtp-Source: AGHT+IFtUK0GDN1IP407bIvUHWtj24fuvQ8qMVGYdvPU/HOxjiPGs3TvhUe4PRCPTzf2/o4lHI6B3VUjSvRU8L8wSMo=
X-Received: by 2002:a17:907:9496:b0:a77:e2e3:3557 with SMTP id
 a640c23a62f3a-a780b884a19mr1490182766b.57.1721026107041; Sun, 14 Jul 2024
 23:48:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com> <CAOUHufawNerxqLm7L9Yywp3HJFiYVrYO26ePUb1jH-qxNGWzyA@mail.gmail.com>
 <4307e984-a593-4495-b4cc-8ef509ddda03@amd.com> <CAGudoHH4N0eEQCpJqFioRCJx75WAO5n+kCA0XcRZ-914xFR0gw@mail.gmail.com>
 <CAGudoHEsg95BHX+nmK-N7Ps5dsw4ffg6YPimXMFvS+AhGSJeGw@mail.gmail.com> <56865e57-c250-44da-9713-cf1404595bcc@amd.com>
In-Reply-To: <56865e57-c250-44da-9713-cf1404595bcc@amd.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 15 Jul 2024 08:48:13 +0200
Message-ID: <CAGudoHH1HxDX9jhrpVzhyUiVv4WqL9kPjk3s468N9GynTZFuqw@mail.gmail.com>
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
To: Bharata B Rao <bharata@amd.com>
Cc: Yu Zhao <yuzhao@google.com>, david@fromorbit.com, kent.overstreet@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, nikunj@amd.com, 
	"Upadhyay, Neeraj" <Neeraj.Upadhyay@amd.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, willy@infradead.org, vbabka@suse.cz, kinseyho@google.com, 
	Mel Gorman <mgorman@suse.de>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 7:22=E2=80=AFAM Bharata B Rao <bharata@amd.com> wro=
te:
>
> On 10-Jul-24 6:34 PM, Mateusz Guzik wrote:
> >>> However the contention now has shifted to inode_hash_lock. Around 55
> >>> softlockups in ilookup() were observed:
> >>>
> >>> # tracer: preemptirqsoff
> >>> #
> >>> # preemptirqsoff latency trace v1.1.5 on 6.10.0-rc3-trnmglru
> >>> # -------------------------------------------------------------------=
-
> >>> # latency: 10620430 us, #4/4, CPU#260 | (M:desktop VP:0, KP:0, SP:0 H=
P:0
> >>> #P:512)
> >>> #    -----------------
> >>> #    | task: fio-3244715 (uid:0 nice:0 policy:0 rt_prio:0)
> >>> #    -----------------
> >>> #  =3D> started at: ilookup
> >>> #  =3D> ended at:   ilookup
> >>> #
> >>> #
> >>> #                    _------=3D> CPU#
> >>> #                   / _-----=3D> irqs-off/BH-disabled
> >>> #                  | / _----=3D> need-resched
> >>> #                  || / _---=3D> hardirq/softirq
> >>> #                  ||| / _--=3D> preempt-depth
> >>> #                  |||| / _-=3D> migrate-disable
> >>> #                  ||||| /     delay
> >>> #  cmd     pid     |||||| time  |   caller
> >>> #     \   /        ||||||  \    |    /
> >>>        fio-3244715 260...1.    0us$: _raw_spin_lock <-ilookup
> >>>        fio-3244715 260.N.1. 10620429us : _raw_spin_unlock <-ilookup
> >>>        fio-3244715 260.N.1. 10620430us : tracer_preempt_on <-ilookup
> >>>        fio-3244715 260.N.1. 10620440us : <stack trace>
> >>> =3D> _raw_spin_unlock
> >>> =3D> ilookup
> >>> =3D> blkdev_get_no_open
> >>> =3D> blkdev_open
> >>> =3D> do_dentry_open
> >>> =3D> vfs_open
> >>> =3D> path_openat
> >>> =3D> do_filp_open
> >>> =3D> do_sys_openat2
> >>> =3D> __x64_sys_openat
> >>> =3D> x64_sys_call
> >>> =3D> do_syscall_64
> >>> =3D> entry_SYSCALL_64_after_hwframe
> >>>
> >>> It appears that scalability issues with inode_hash_lock has been brou=
ght
> >>> up multiple times in the past and there were patches to address the s=
ame.
> >>>
> >>> https://lore.kernel.org/all/20231206060629.2827226-9-david@fromorbit.=
com/
> >>> https://lore.kernel.org/lkml/20240611173824.535995-2-mjguzik@gmail.co=
m/
> >>>
> >>> CC'ing FS folks/list for awareness/comments.
> >>
> >> Note my patch does not enable RCU usage in ilookup, but this can be
> >> trivially added.
> >>
> >> I can't even compile-test at the moment, but the diff below should do
> >> it. Also note the patches are present here
> >> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=3Dv=
fs.inode.rcu
> >> , not yet integrated anywhere.
> >>
> >> That said, if fio you are operating on the same target inode every
> >> time then this is merely going to shift contention to the inode
> >> spinlock usage in find_inode_fast.
> >>
> >> diff --git a/fs/inode.c b/fs/inode.c
> >> index ad7844ca92f9..70b0e6383341 100644
> >> --- a/fs/inode.c
> >> +++ b/fs/inode.c
> >> @@ -1524,10 +1524,14 @@ struct inode *ilookup(struct super_block *sb,
> >> unsigned long ino)
> >>   {
> >>          struct hlist_head *head =3D inode_hashtable + hash(sb, ino);
> >>          struct inode *inode;
> >> +
> >>   again:
> >> -       spin_lock(&inode_hash_lock);
> >> -       inode =3D find_inode_fast(sb, head, ino, true);
> >> -       spin_unlock(&inode_hash_lock);
> >> +       inode =3D find_inode_fast(sb, head, ino, false);
> >> +       if (IS_ERR_OR_NULL_PTR(inode)) {
> >> +               spin_lock(&inode_hash_lock);
> >> +               inode =3D find_inode_fast(sb, head, ino, true);
> >> +               spin_unlock(&inode_hash_lock);
> >> +       }
> >>
> >>          if (inode) {
> >>                  if (IS_ERR(inode))
> >>
> >
> > I think I expressed myself poorly, so here is take two:
> > 1. inode hash soft lookup should get resolved if you apply
> > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=
=3Dvfs.inode.rcu&id=3D7180f8d91fcbf252de572d9ffacc945effed0060
> > and the above pasted fix (not compile tested tho, but it should be
> > obvious what the intended fix looks like)
> > 2. find_inode_hash spinlocks the target inode. if your bench only
> > operates on one, then contention is going to shift there and you may
> > still be getting soft lockups. not taking the spinlock in this
> > codepath is hackable, but I don't want to do it without a good
> > justification.
>
> Thanks Mateusz for the fix. With this patch applied, the above mentioned
> contention in ilookup() has not been observed for a test run during the
> weekend.
>

Ok, I'll do some clean ups and send a proper patch to the vfs folks later t=
oday.

Thanks for testing.

--=20
Mateusz Guzik <mjguzik gmail.com>

