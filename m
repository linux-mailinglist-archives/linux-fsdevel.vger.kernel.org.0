Return-Path: <linux-fsdevel+bounces-1733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC6C7DE12B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 13:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497E428119C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 12:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF853125DB;
	Wed,  1 Nov 2023 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="30M76bIl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iaB1DzDW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ADF613C
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 12:58:59 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD59DC;
	Wed,  1 Nov 2023 05:58:54 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1698843532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SWUnEh6XW9/W7DLWKsdahGToSptXq7swAyngnisC52k=;
	b=30M76bIlVflBqCCitsRhE+s18iWhKakGePKEieuSV5J+DUrqDBNa95RL8c9tjyHzGvS879
	miwOWjTEET/JcyR7+IcWwde4IsiD1fKQXGmM/JtTmOINrlPfrAveABoCSSM+RxsHvGCqj2
	JKAra6A58yjTXK7Wisou2KyXzjlNfNFiUtwuHqMJcHVtuvl2fvM7/nveQzPOLfbXyoPLMR
	yIi+tbJDoCCVwPhADENXd1vBFK690Q5bcQE31JahHaq6stW3qOLMVnOAOpLGqXFLfl1y2q
	0BlPG9LuRd/SprlEnHFWti6y00cDc2JE21sVzkgtY2gcHyttagKd05Ab9RIPJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1698843532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SWUnEh6XW9/W7DLWKsdahGToSptXq7swAyngnisC52k=;
	b=iaB1DzDW6lOg8Ec9QhS5dsYFAVz46LGqEBVNLbQLXr0grx4QqKk5VzZnBgaTuDzsugZyZu
	XMm2rK/pmM8DetAQ==
To: syzbot <syzbot+b408cd9b40ec25380ee1@syzkaller.appspotmail.com>,
 adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] [ext4?] general protection fault in hrtimer_nanosleep
In-Reply-To: <000000000000cfd180060910a687@google.com>
References: <000000000000cfd180060910a687@google.com>
Date: Wed, 01 Nov 2023 13:58:51 +0100
Message-ID: <875y2lmxys.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 31 2023 at 22:36, syzbot wrote:
> general protection fault, probably for non-canonical address 0xdffffc003ffff113: 0000 [#1] PREEMPT SMP KASAN
> KASAN: probably user-memory-access in range [0x00000001ffff8898-0x00000001ffff889f]
> CPU: 1 PID: 5308 Comm: syz-executor.4 Not tainted 6.6.0-rc7-syzkaller-00142-g888cf78c29e2 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
> RIP: 0010:lookup_object lib/debugobjects.c:195 [inline]
> RIP: 0010:lookup_object_or_alloc lib/debugobjects.c:564 [inline]
> RIP: 0010:__debug_object_init+0xf3/0x2b0 lib/debugobjects.c:634
> Code: d8 48 c1 e8 03 42 80 3c 20 00 0f 85 85 01 00 00 48 8b 1b 48 85 db 0f 84 9f 00 00 00 48 8d 7b 18 83 c5 01 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 4c 01 00 00 4c 3b 73 18 75 c3 48 8d 7b 10 48
> RSP: 0018:ffffc900050e7d08 EFLAGS: 00010012
> RAX: 000000003ffff113 RBX: 00000001ffff8880 RCX: ffffffff8169123e
> RDX: 1ffffffff249b149 RSI: 0000000000000004 RDI: 00000001ffff8898
> RBP: 0000000000000003 R08: 0000000000000001 R09: 0000000000000216
> R10: 0000000000000003 R11: 0000000000000000 R12: dffffc0000000000
> R13: ffffffff924d8a48 R14: ffffc900050e7d90 R15: ffffffff924d8a50
> FS:  0000555556eec480(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa23ab065ee CR3: 000000007e5c1000 CR4: 0000000000350ee0

So this dies in debugobjects::lookup_object()

hlist_for_each_entry()

>   10:	48 8b 1b             	mov    (%rbx),%rbx

Gets the next entry

>   13:	48 85 db             	test   %rbx,%rbx
>   16:	0f 84 9f 00 00 00    	je     0xbb

Checks for the termination condition (NULL pointer)

>   1c:	48 8d 7b 18          	lea    0x18(%rbx),%rdi

Calculates the address of obj->object

>   20:	83 c5 01             	add    $0x1,%ebp

cnt++;

>   23:	48 89 f8             	mov    %rdi,%rax
>   26:	48 c1 e8 03          	shr    $0x3,%rax

KASAN shadow address calculation

> * 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction

Kasan accesses 0xdffffc003ffff113 and dies.

RBX contains the pointer to the next object: 0x00000001ffff8880 which is
clearly a user space address, but I have no idea where that might come
from. It's obviously data corruption of unknown provenience.

Unfortunately repro.syz does not hold up to its name and refuses to
reproduce.

Thanks,

        tglx


