Return-Path: <linux-fsdevel+bounces-69639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B103C7F743
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 10:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DB9043464F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 09:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37ACE2F39DC;
	Mon, 24 Nov 2025 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giHLuu/G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D542F39B0
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 09:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763974929; cv=none; b=OSAth3ueDJ3+ZoEJQEHfqwH+VHafswjRZJjwHnsDoIGmltN1UII7JySzFbqoiBqblkm5uzHymPMVvoC2EIQsN0Fu/eA4MbOR3igus0+U4jCBJ2XxGApJMF77kFCUnccpmDlhl6y7VZFCpbWFWY4Yc4GukzsRdsRR+qc+nQ6GDDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763974929; c=relaxed/simple;
	bh=Xa1HPglc2PcytFmjHYth2irvMtpP171yet/ys8HHA8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GNnv82MReR2rLMwwAtivrVTatyJqFd+Fu6pNZtNx0OvaTYJZq8E75DHUMN4/Gu4atsqwcxzcsYw/NLRMdlBf6Lc+YbEow4jufWIgQxDQ2JRDI84KIwSpaEHUt7cfRTWFYxEQuEFpQCDcsYh0UBAjxnCxQq1RGZSin8CX9egxh+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giHLuu/G; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b71397df721so705282366b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 01:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763974926; x=1764579726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NeeLGJj3APe810a7aF6oBE+tf5JgCCG3zWKhawimyWY=;
        b=giHLuu/GD7Th5eflWAataasP19weuaxTquBNxPMY01xj+tUI1oLw9K0OsFxltwayqY
         xLhYgIOFRls0uiLZ5oD/6GhgC8HBVVjPTSfAPBjUyosAROzvOHGcmtqmBOvu9Vz+NypV
         xE4jr3kxuiqshWiOo8tJ6md6hmiKhJKAWUfD36a/XOB35QlLjn9Rnr6h4QHSe6yi8Bv8
         Zur5k8/L//uhuISRBUd4ZsrwGfBHErQl1qhSng5aFe01jYoiHp/jfyocLHV2r0dujOMv
         qtSPXK0A+lLrG/UqjumKEywXllL7lBhYYXJ36aOW+oKBO5MFE0UDa0U3ePF2OXRmCIkK
         /kfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763974926; x=1764579726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NeeLGJj3APe810a7aF6oBE+tf5JgCCG3zWKhawimyWY=;
        b=k1eCLSDti2ut0OPzePox/TatnWsdQSEVlrozfHrENdMA7SLghFm9f66CL1WZ3h3gv9
         xP5ZSx8dYMon07HXIRKvts1FcBfchjrYwGqktoIXqSqbZFh3U47wxY98Jz+1puEtYr5Q
         zlXNYpKrpTsYygfV1HbyTfuvyrL8zao29rpFXrjbKdmh6NSRVP14mwVU00pA5FX4geYu
         NwcjXOkrU0/dfqn10UKHd138SipmYKT1+FcocvWkaKTiC0ci1hTqeBoJJMDTjnHreM4V
         zFbKIiUrWO/FK/aJHxA3ZbC6irSpW+IfSNT3cSbB8TylhHnAWSNmb8CKQmire7cGcj7z
         4jjA==
X-Forwarded-Encrypted: i=1; AJvYcCVaOq2qVXysqLosun50Lwhn7vUdHSvmMv8cXjFEjH/s2Qh0sp3iwwqAFQIhCAW3zg/uPLwR4UBDN7lc0aPZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxjPkok8rmHpUYAMP2cy2DmGSv8SvPD4HIZCw8ucsVPvp3OQlMI
	DkxiPG8enTvJOtiZ8kz5PXDwjjJBdn+fk+y0IEeoiI2V3Cu74XIlJWTi9LEFPqb11s9ASQrhyhC
	8NLVZxeNHLEqzDtPVlYExYaDQqG8Yuy0=
X-Gm-Gg: ASbGnctttk8KTOooHci/6SnIX+kGQdhoL+D4HE/xvKUM9DPYiqCW1bgBIfJHL+Bnob4
	fH6H/zWZWSjbPTcN4qoeInPOuUmf/vmzfc78hCDGCMb8Vd7yB0c8Tg/AiYRpXqTJnq32gbnB+En
	7Vjr2myqYQ+cYF9z1VxTQp7SXzdVs74SJyf3CacRsEXpSWG0UnoH5DCwcevdJ08SIGI2yL3OFcZ
	421hZKcjGC3z9CV5ZSpcL3J1syPjX1q8kt5ib1LevadOwo++6yeuYtZ2bLdaoJZXTxZvepA8vS6
	x9ON5rXPPWup3mhI5i77XRQaUEn89QxnFV0Y
X-Google-Smtp-Source: AGHT+IGQYqCXfhOnkVW5LV48WFaXI3Aas3wdL6BNbS2cmiEkz94292LrlE14eCDJ5kki8BuV6bjT41K3pJaLyedK4e0=
X-Received: by 2002:a17:906:dc89:b0:b73:6b85:1a9a with SMTP id
 a640c23a62f3a-b7671591ebemr1232341266b.21.1763974925546; Mon, 24 Nov 2025
 01:02:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <gyt53gbtarw75afmeswazv4dmmj6mc2lzlm2bycunphazisbyq@qrjumrerwox5>
 <6924057f.a70a0220.d98e3.007b.GAE@google.com> <wtgy54dfpiapekffjjkonkkhpnxiktfp24wdmwdzf4gslrtact@pongm7vm3l2y>
In-Reply-To: <wtgy54dfpiapekffjjkonkkhpnxiktfp24wdmwdzf4gslrtact@pongm7vm3l2y>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 24 Nov 2025 10:01:53 +0100
X-Gm-Features: AWmQ_blH6nBMAXXG5YWe0GFjJX6yhvvmvFgRsXFcH0PlqpOWOxvgxhbF_Zc3QuM
Message-ID: <CAGudoHHfGndcMwXMupOs82HM6c_ajMw8GETxPdkqzORrEq0btA@mail.gmail.com>
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in __start_renaming
To: brauner@kernel.org, neil@brown.name
Cc: agruenba@redhat.com, almaz.alexandrovich@paragon-software.com, 
	dhowells@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, 
	syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sigh, so it *is* my patch, based on syzbot testing specifically on
directory locking vs inode branches, but I don't see why.

I take it the open() codepath took the rwsem, hence the rename is
sleeping. Given that all reproducers find it *on* cpu, it may be this
is busy looping for some reason.

I don't have time to dig more into it right now, so I think it would
be best to *drop* my patch for the time being. Once I figure it out
I'll send a v2.

On Mon, Nov 24, 2025 at 8:54=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Sun, Nov 23, 2025 at 11:13:03PM -0800, syzbot wrote:
> > syzbot has tested the proposed patch but the reproducer is still trigge=
ring an issue:
> > INFO: task hung in __start_renaming
> >
> > INFO: task syz.0.17:6473 blocked for more than 143 seconds.
> >       Not tainted syzkaller #0
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messag=
e.
> > task:syz.0.17        state:D stack:27936 pid:6473  tgid:6471  ppid:6352=
   task_flags:0x400040 flags:0x00080002
> > Call Trace:
> >  <TASK>
> >  context_switch kernel/sched/core.c:5257 [inline]
> >  __schedule+0x14bc/0x5030 kernel/sched/core.c:6864
> >  __schedule_loop kernel/sched/core.c:6946 [inline]
> >  schedule+0x165/0x360 kernel/sched/core.c:6961
> >  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7018
> >  rwsem_down_write_slowpath+0x872/0xfe0 kernel/locking/rwsem.c:1185
> >  __down_write_common kernel/locking/rwsem.c:1317 [inline]
> >  __down_write kernel/locking/rwsem.c:1326 [inline]
> >  down_write_nested+0x1b5/0x200 kernel/locking/rwsem.c:1707
> >  inode_lock_nested include/linux/fs.h:1072 [inline]
> >  lock_rename fs/namei.c:3681 [inline]
> >  __start_renaming+0x148/0x410 fs/namei.c:3777
> >  do_renameat2+0x399/0x8e0 fs/namei.c:5991
> >  __do_sys_rename fs/namei.c:6059 [inline]
> >  __se_sys_rename fs/namei.c:6057 [inline]
> >  __x64_sys_rename+0x82/0x90 fs/namei.c:6057
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f2425d8f749
> > RSP: 002b:00007f2426c44038 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
> > RAX: ffffffffffffffda RBX: 00007f2425fe6090 RCX: 00007f2425d8f749
> > RDX: 0000000000000000 RSI: 0000200000000080 RDI: 0000200000000340
> > RBP: 00007f2425e13f91 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007f2425fe6128 R14: 00007f2425fe6090 R15: 00007ffcd5a91138
> >  </TASK>
> >
>
> So at the end of the day I think this erroneously bisected to my patch.
> While it may sound like famous last words, hear me out.
>
> The reproducer fails to trigger the problem on my test jig, thus I
> resorted to asking syzbot.
>
> First patch I sent for testing was merely a sanity check -- prior to my
> patch inode_unhashed() checks were *always* executing, with my patch
> they only happen if I_NEW was spotted. This patch "solved" the problem.
>
> Second patch added some asserts on inode_unhashed() and syzbot had some
> internal issues, ultimately it was not tested.
>
> Third patch added even *more* asserts and t0his time around things
> failed the previously reported way about half an hour of testing. But if
> the first patch indeed solved something, the BUG_ONs would have
> triggered instead.
>
> So that's for testing.
>
> In my first response I made a remark in my first reply that ntfs is at
> fault.  After a quick skim I spotted d_instantiate() instead of
> d_instantiate_new() and jumped to conclusions. It calls unlock_new_inode(=
)
> later which does the right thing, so it is fine AFAICS.
>
> So what about correctness of my patch?
>
> My patch lifted the go-to-sleep code from inode_wait_for_lru_isolating().
> In principle that can be buggy but is just used rarely enough that it
> went unnoticed. I don't see anything wrong with it though, including
> after comparing it with __wait_on_freeing_inode(). Notably both
> synchronize with the ->i_lock. No games played.
>
> I figure maybe there is something fucky going on with ordering on wakeup
> side:
>
> inode_state_clear(inode, I_NEW | I_CREATING);
> inode_wake_up_bit(inode, __I_NEW);
>
> Going through __wake_up_common_lock takes a spinlock, which on amd64
> would have a side effect of publishing that I_NEW store, even ignoring
> therest of the ordering.
>
> On going to sleep side to the flag is only ever tested with ->i_lock
> held anyway, so it can't be an ordering issue on that front. The thread
> could not have been missed from the sleepers list as going to sleep is
> again ->i_lock protected, with the lock only dropped around the call to
> schedule().
>
> So I don't see how this can be buggy.
>
> At the same time the traces report the thing off cpu is playing around
> with rwsems with the __start_renaming et al patchset, while the code for
> inode hash manipulation is decidedly *ON* cpu -- reported by NMIs, not
> hung test detector.
>
> In principle this still can be a thread hung waiting on I_NEW somewhere,
> but syzbot did not produce a collection of backtraces for other threads.
>
> However, given that the __start_renaming et al patchset is complicated
> *and* that syzbot could mistakenly report (or not) a bug I'm led to
> conclude the reproducer is highly unreliable and my commit landed as a
> random victim.
>
> All that said, I think the folk working on that patchset should take
> over.
>
> My patch is a minor optimization and can be skipped in this merge window
> at no real loss,
>
> My take is that the big patchset *should* be skipped in this merge
> window given the above, unless the problem is uickly identified.

