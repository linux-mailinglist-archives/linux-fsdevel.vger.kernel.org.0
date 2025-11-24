Return-Path: <linux-fsdevel+bounces-69631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 416D9C7F44A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 08:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9718D342E48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 07:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE902EA732;
	Mon, 24 Nov 2025 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/z1wxEM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104FC2E8E06
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763970875; cv=none; b=EMJh8+9d8eIWWbXRj1YQfDqd8kZh7PAM7Bi6ndlb3WUZr+yduAcA5kHemJGXQHLqfQtdmC7Q6wIwcWJbpv0L4aZnzydJJdaISDV1ZrHZseJInNlNMY+uboMtq4roxmPCBetNGOTySFYA4l+63NV0jon2zUFrvJBIQ5n3Rsxo2w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763970875; c=relaxed/simple;
	bh=KT/F7f4tTQnA1jOwd5Ni1R6KPd8yFXBsZaKI46tuybE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvOQqIVAu5p7lXQ8sFY05yx5ExSAiSYo67pTTb9GVh/DbL+jsxc1Fxzo1KKXIkRuG+1ss0NBWSoib+i98o0pnNeZ7mfBAyVLKziBC7u+VbieY/ot9PbspwTIOpAY679SAUlYFTcW1Inh+qXc+icquQuI5h/HQJtG9ebswulpjks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/z1wxEM; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso5861809a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 23:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763970872; x=1764575672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FlC7yVANvKUySfKJcEi61tzYs7uhVVgRqqWDz/Q6iAM=;
        b=i/z1wxEMfErnMXayuhZSZpcGThxPzi5AA4W9XtemNlR9YXybRUs+IX2CrS/1DiNS38
         sPgzPfevaAMhs6rn3j0BBbWdNX8DKNs6QWZQLmn/gGuJkgnpLZo6FmNA0T55KG/o6nhH
         P/vzy2JIN9TFlhj6KDXPRPUJgn+aiIbQnGpPeaLTcJy/Cjq9WzDFfOfP+bHi4Yjw4V40
         y26a1ClzJkLqufhSwAJlRFSL7dnIeyMWDwACLg5khmgfM//KbA9uyIBBD992LGFoUaZx
         rqxdEca+0fC3t7amliTX1ZkfY9PorOqwf551llErrL+db6f/r4S24G+sKTOvOB8LH9Yo
         cInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763970872; x=1764575672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlC7yVANvKUySfKJcEi61tzYs7uhVVgRqqWDz/Q6iAM=;
        b=DRBTg2PyFaZIJCvAplVylcJdFlD043QEDbOHXQnTZyYdAwvtc6XXNQYZSQwNR0Z2o/
         ZlYfJ2A1JuVtgMWGn3WfnbxrmOzddRvvEo80ZXf+PvpVDtqAbUXKDc2EdWOpCq+vrzRn
         3qFpYM+luGcPf4TBy05oWT0V7nzzd+EJ/X+TbOmBmzCUZZ78m4vloRbGBbmIJCSP2jYU
         oavxnhMobRlYHp00jhgm1ncyB+l4UoR3r2o96r+pShkNBYFVhNqVWNjTUz1F06leLzEE
         3QYNEed4zyJAyC6EJmW8MnkFC03EKuQFu3s4ERI9uRnPj+Ol1QmNGvgSuNLQ7j5jyPB4
         4HHw==
X-Forwarded-Encrypted: i=1; AJvYcCXv+pLE6XT1+82CpF7eoLvBIXfUp98Tq8JmCTQWCctkL+L4/FVlGcBczFBoibe8ISbV13mPrMXyPJw0N2oq@vger.kernel.org
X-Gm-Message-State: AOJu0YxFw+sLZt1z4Vi7J7IGtrDA/d75YBrAMaMmpfE2GPEm3swbn2sj
	CsUpSz8gworA/U5hjOlvCmGbwqqBj4veyEjkO2mLfp7qxAuooY9O175N
X-Gm-Gg: ASbGnctWKHREK0VY8rLYoq79TUqX9khpudbl/tYwnzzXWdJCGn1NtLAfDZSbuYv9SRn
	8HRtP3TI0IbxCbMkrsvt4DFe/sOY1OiS+4nS2Pk4l0hOwOqKHCGj3QtrzHGbN6grGYYmK6uQFhF
	oUpYrfL9vALTEMmFtG5jdemBvcmnhrjal6gHv8EwyMiMoHwx9CbGYpqq6/Dkhzg2sPYYJYkTkEu
	4uMZhqlgV6Mja8CUlQ58zoXU6p2M5StKgmycdJW1dZJB28hwlV0q2JWCz5r2mVtN9yNav3ZFr9k
	zurDZyxG9npxiIa4483sRh7ysRqj5jtR3F2t/y65bDDeERjH1bUwNjZfwpweFCKw0nYB2R/+KUP
	KFTRCTP7vUCdfHhu0JYJqo4qwp8qk5iilMs5tXhGYFWA88NgGe5ZXuKwkuNG87p1Cjr9wHvV1rF
	rorOyiTB66DnGH4+f/J3QEN1OzwN4if+e3Mc11kZOhMp+6kMQnqddH2VHBdC3Z/RUd/6Y=
X-Google-Smtp-Source: AGHT+IGtWWuUYPLI1U4Pi4o0OYpw506S88/tH8OAcwEGuSXovPPfsg0e1IiBHAC3h7onJct5SaHDfQ==
X-Received: by 2002:a17:907:a04:b0:b6d:5363:88a9 with SMTP id a640c23a62f3a-b767154772bmr889142366b.9.1763970872065;
        Sun, 23 Nov 2025 23:54:32 -0800 (PST)
Received: from f (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd43e2sm1199292166b.39.2025.11.23.23.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 23:54:31 -0800 (PST)
Date: Mon, 24 Nov 2025 08:54:18 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org, neil@brown.name
Cc: agruenba@redhat.com, almaz.alexandrovich@paragon-software.com, 
	dhowells@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	marc.dionne@auristor.com, ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk, syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in __start_renaming
Message-ID: <wtgy54dfpiapekffjjkonkkhpnxiktfp24wdmwdzf4gslrtact@pongm7vm3l2y>
References: <gyt53gbtarw75afmeswazv4dmmj6mc2lzlm2bycunphazisbyq@qrjumrerwox5>
 <6924057f.a70a0220.d98e3.007b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6924057f.a70a0220.d98e3.007b.GAE@google.com>

On Sun, Nov 23, 2025 at 11:13:03PM -0800, syzbot wrote:
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> INFO: task hung in __start_renaming
> 
> INFO: task syz.0.17:6473 blocked for more than 143 seconds.
>       Not tainted syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.0.17        state:D stack:27936 pid:6473  tgid:6471  ppid:6352   task_flags:0x400040 flags:0x00080002
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5257 [inline]
>  __schedule+0x14bc/0x5030 kernel/sched/core.c:6864
>  __schedule_loop kernel/sched/core.c:6946 [inline]
>  schedule+0x165/0x360 kernel/sched/core.c:6961
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7018
>  rwsem_down_write_slowpath+0x872/0xfe0 kernel/locking/rwsem.c:1185
>  __down_write_common kernel/locking/rwsem.c:1317 [inline]
>  __down_write kernel/locking/rwsem.c:1326 [inline]
>  down_write_nested+0x1b5/0x200 kernel/locking/rwsem.c:1707
>  inode_lock_nested include/linux/fs.h:1072 [inline]
>  lock_rename fs/namei.c:3681 [inline]
>  __start_renaming+0x148/0x410 fs/namei.c:3777
>  do_renameat2+0x399/0x8e0 fs/namei.c:5991
>  __do_sys_rename fs/namei.c:6059 [inline]
>  __se_sys_rename fs/namei.c:6057 [inline]
>  __x64_sys_rename+0x82/0x90 fs/namei.c:6057
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f2425d8f749
> RSP: 002b:00007f2426c44038 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
> RAX: ffffffffffffffda RBX: 00007f2425fe6090 RCX: 00007f2425d8f749
> RDX: 0000000000000000 RSI: 0000200000000080 RDI: 0000200000000340
> RBP: 00007f2425e13f91 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f2425fe6128 R14: 00007f2425fe6090 R15: 00007ffcd5a91138
>  </TASK>
> 

So at the end of the day I think this erroneously bisected to my patch.
While it may sound like famous last words, hear me out.

The reproducer fails to trigger the problem on my test jig, thus I
resorted to asking syzbot.

First patch I sent for testing was merely a sanity check -- prior to my
patch inode_unhashed() checks were *always* executing, with my patch
they only happen if I_NEW was spotted. This patch "solved" the problem.

Second patch added some asserts on inode_unhashed() and syzbot had some
internal issues, ultimately it was not tested.

Third patch added even *more* asserts and t0his time around things
failed the previously reported way about half an hour of testing. But if
the first patch indeed solved something, the BUG_ONs would have
triggered instead.

So that's for testing.

In my first response I made a remark in my first reply that ntfs is at
fault.  After a quick skim I spotted d_instantiate() instead of
d_instantiate_new() and jumped to conclusions. It calls unlock_new_inode()
later which does the right thing, so it is fine AFAICS.

So what about correctness of my patch?

My patch lifted the go-to-sleep code from inode_wait_for_lru_isolating().
In principle that can be buggy but is just used rarely enough that it
went unnoticed. I don't see anything wrong with it though, including
after comparing it with __wait_on_freeing_inode(). Notably both
synchronize with the ->i_lock. No games played.

I figure maybe there is something fucky going on with ordering on wakeup
side:

inode_state_clear(inode, I_NEW | I_CREATING);
inode_wake_up_bit(inode, __I_NEW);

Going through __wake_up_common_lock takes a spinlock, which on amd64
would have a side effect of publishing that I_NEW store, even ignoring
therest of the ordering.

On going to sleep side to the flag is only ever tested with ->i_lock
held anyway, so it can't be an ordering issue on that front. The thread
could not have been missed from the sleepers list as going to sleep is
again ->i_lock protected, with the lock only dropped around the call to
schedule().

So I don't see how this can be buggy.

At the same time the traces report the thing off cpu is playing around
with rwsems with the __start_renaming et al patchset, while the code for
inode hash manipulation is decidedly *ON* cpu -- reported by NMIs, not
hung test detector.

In principle this still can be a thread hung waiting on I_NEW somewhere,
but syzbot did not produce a collection of backtraces for other threads.

However, given that the __start_renaming et al patchset is complicated
*and* that syzbot could mistakenly report (or not) a bug I'm led to
conclude the reproducer is highly unreliable and my commit landed as a
random victim.

All that said, I think the folk working on that patchset should take
over.

My patch is a minor optimization and can be skipped in this merge window
at no real loss,

My take is that the big patchset *should* be skipped in this merge
window given the above, unless the problem is uickly identified. 

