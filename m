Return-Path: <linux-fsdevel+bounces-63421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 290C1BB876A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 04 Oct 2025 03:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 076134C2781
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Oct 2025 01:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3DC2AE77;
	Sat,  4 Oct 2025 01:04:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9359C141
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Oct 2025 01:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759539845; cv=none; b=SDbO7mAZHkabWtqGkkC+gyt5Sjt5npcbJXdFovuL2hOGJeQhADbwga37XP3dK7wH0jXaBZ0bGSSP+/H54jiDGjyPkDIMDjJV2wn0DnYU31uOCUji4vpoQAIPq+pITjj2CKN2T7fdyc40h44OdFAYz7o9dyKZ/1d0c7J8bPBQp8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759539845; c=relaxed/simple;
	bh=SOcgETh5xeubM838LXHr8nv9pfekOTux79h+0vKGLd0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HbMWl+Atha4iu/VVTBPo4uqPkONW6DRocgfKPylGZxwgoS+RwQHNpY01UyQQtVGlSekdoaWHfYj9ntkXnA14PbOMTsWtHa21rC+Sm7na4cIQJRwMrDaaGs4xJ89sjmcxMwDFMEpLP7zGTYrxwiGuH1Pfl7HCwbUEjK+qQRwp+kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42f6639fb22so22905ab.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Oct 2025 18:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759539843; x=1760144643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HBSZwqSDmh1BSWgw4JtT806Jg7bQjBuA+gVX18qZT4E=;
        b=d7Qdnt+8yLrM/RNHSKB2PpZy0cA3b/bMbq7Gb38ncnxMl9CxgMomCv44CQl0/bSuM6
         DB/1OMJSlFP3xYBFmeXSmoHCQH9XMvge0Y/pguRSeJy2+5a6ODVybQSMfztzGjZIBu/p
         4CZ88lqLWUXYliyyZQwdy8sqXHNdJfyf9bZndxYwNwkLVL0dq84bYMDty/D3m9LlQB9b
         0fvlUW+EPXFSlm6qKmlufGRGmf8euC8SnIDLTsepDnUBzNMDnFOYsdfKQ/p5ANZWj6Q+
         gTYZ2UDGyXyVDH4CPHER8kp2j9X3FoFrrCX2F951P33HbInl1+JBx9pAvSSW5hzNP6ns
         2F2w==
X-Forwarded-Encrypted: i=1; AJvYcCXmmBa2y/rl6gFUHUoPvgsSb9hxwKNWkG+ByKAcXuFnS9V7C/Cb9dyZ26Wi4uUJ0gXLS9Pl2xyIRkunisDP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7NDVMrVEGrndCdIxckrO5bhzhOapM39rIc2GbGbiWRgi5JOFr
	9tqYgoE/jtjXKN4THlrH9xh3osFqCWcTSZQoip8D8VyvD6EsfoJRBt9r6ENxqfxvka9yxco0ej9
	JeLcZIsRgyxvi1DGXGo7Seikx5nQ53SErG/1cB3yRXt6Z1d/seXtd2sndRvo=
X-Google-Smtp-Source: AGHT+IG5JM3/o6FGfsB9hA9pW+iiPTtSAdodFWPBkviXe5k4KQ+1mesDPtmy+8ZNmTIw34B4iexXbVyss3CJ246tUdhyhjSRaavg
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0d:0:b0:42e:6e3a:3075 with SMTP id
 e9e14a558f8ab-42e7ad84876mr59415045ab.21.1759539843090; Fri, 03 Oct 2025
 18:04:03 -0700 (PDT)
Date: Fri, 03 Oct 2025 18:04:03 -0700
In-Reply-To: <68c6c3b1.050a0220.2ff435.0382.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e07283.a00a0220.102ee.0118.GAE@google.com>
Subject: Re: [syzbot] [fs?] kernel BUG in qlist_free_all (2)
From: syzbot <syzbot+8715dd783e9b0bef43b1@syzkaller.appspotmail.com>
To: bigeasy@linutronix.de, boqun.feng@gmail.com, bp@alien8.de, 
	brauner@kernel.org, clrkwllms@kernel.org, dave.hansen@linux.intel.com, 
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, hpa@zytor.com, jack@suse.cz, kprateek.nayak@amd.com, 
	kuba@kernel.org, kuniyu@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, luto@kernel.org, 
	mingo@redhat.com, ncardwell@google.com, neil@brown.name, 
	netdev@vger.kernel.org, pabeni@redhat.com, peterz@infradead.org, 
	rostedt@goodmis.org, ryotkkr98@gmail.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, viro@zeniv.linux.org.uk, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 3253cb49cbad4772389d6ef55be75db1f97da910
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Thu Sep 4 14:25:25 2025 +0000

    softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17566a7c580000
start commit:   7f7072574127 Merge tag 'kbuild-6.18-1' of git://git.kernel..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14d66a7c580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10d66a7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b78ebc06b51acd7e
dashboard link: https://syzkaller.appspot.com/bug?extid=8715dd783e9b0bef43b1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ba76e2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17741ee2580000

Reported-by: syzbot+8715dd783e9b0bef43b1@syzkaller.appspotmail.com
Fixes: 3253cb49cbad ("softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

