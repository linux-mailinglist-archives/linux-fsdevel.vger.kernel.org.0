Return-Path: <linux-fsdevel+bounces-32831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D089AF68B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 03:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD2328172B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 01:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEC51F5E6;
	Fri, 25 Oct 2024 01:14:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C291173F
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 01:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729818848; cv=none; b=VE13k9fXFRaMYpyJ7u68Bb+JYuXNQ0o3CvT76fW3mYRujr9as7cCy3NA5bmbiIZuLqSrzOtRpdEymbVIHIkrPsGuVa9OYq2NJobNRc5uIp9ulL5BhCjZbrY8vv8fupD4eXA65GDV1ePLTGqWdzsaNaM8PNx9w5Y5xZ2NqzlidNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729818848; c=relaxed/simple;
	bh=pDpDrDPgqn1rWuPf4vWJjM/QhwM5DXeysn5Qug/olq4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dSsY5IytLgZUbc/MC87L+ykQrgoQzmEjQxSjvc0xRj1pTQgwtZXXopIdXI9R8fV8d/k2xBnHtt4duOETZ4f8jR/Ha6qE2L1rqfLTZMV0Lay0tQnUgke8YqVzwwVk31nQS5x0QtVim7P7Hw7tyVdZtpdaK3QmQcp5IHc2G8n90ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c4ed972bso11376995ab.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 18:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729818846; x=1730423646;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOZsZyIJmZeHEQPVNHkWmGsoWMx76fs5Fvyz/nsiQgY=;
        b=lIb6JXScpGn88Z4+eOlfbcsYeI1vtIbKGefGVmPRgkkJavdxIjskCtr/nj5qIFZsT0
         hKfpKIvhi2zefj2B0+9DC45at74CWAf+nX3oP8MyBBAzNQeiHedqzx0Kx3NLDwYKU2BJ
         Q9fUMGjPhF4Wuqk1v2FLmjikGz1ySnO8+JpyUqVhAmE9nHEhbb/iLHm3zDGGULBgLxvI
         4HTLtGVSrEJyPrkJLvV33DiFN9qXFWrUTgtO13yuwen5PHbdNdoZwYEx1Uug7uQPpyvG
         sgcf7XdhdIY4kbN8a/bdSCCkv5JEIQ3VdtAK6UqRfN3/igv6vQzhSN+a/q8kkZSTvAZh
         KbCw==
X-Forwarded-Encrypted: i=1; AJvYcCXWFoG9EvZSbUJFdf0s0GkcaBvlp9KfkC+NkqYrLP+76iXeYlYzF66sitqA1AJkW8Xc2+MeIure0X95Akoj@vger.kernel.org
X-Gm-Message-State: AOJu0YwQfGcxuGfmovV/DSCnKS8SKON7VO3Nzb4f/o7jCDptSXzGYsua
	Mp+RTi7ezlXI9zWROvCZ1/FSJGZhldeDd+bY68hFCD9s4hZ8zlNJjMGeVz1+mf2116qrNaKoz3l
	IekSQf145rNjS9dl6eFhQ3UzGSj7LQf/1g8If55ic2Q/HxYbkgOp6ZbM=
X-Google-Smtp-Source: AGHT+IGOjltPBrz6CEsrXS0y1SoDlaDKKPoKA5PSdGZVz6ycSLBxXb8Nnn0qnpjr6zRJ+fl8sGud8IaiQJe6+LFu8+phyUzjp/zo
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1707:b0:3a0:915d:a4a7 with SMTP id
 e9e14a558f8ab-3a4d592fb67mr91969855ab.2.1729818845820; Thu, 24 Oct 2024
 18:14:05 -0700 (PDT)
Date: Thu, 24 Oct 2024 18:14:05 -0700
In-Reply-To: <000000000000a519120616f973cb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671af0dd.050a0220.2eb763.00ce.GAE@google.com>
Subject: Re: [syzbot] [fs] INFO: rcu detected stall in sys_mount (7)
From: syzbot <syzbot+de026b20f56e1598e760@syzkaller.appspotmail.com>
To: andrii@kernel.org, asmadeus@codewreck.org, ast@kernel.org, 
	bpf@vger.kernel.org, bristot@kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, ericvh@kernel.org, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, juri.lelli@redhat.com, 
	kpsingh@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lucho@ionkov.net, martin.lau@linux.dev, 
	peterz@infradead.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev, 
	vineeth@bitbyteword.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 5f6bd380c7bdbe10f7b4e8ddcceed60ce0714c6d
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Mon May 27 12:06:55 2024 +0000

    sched/rt: Remove default bandwidth control

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=126a5e40580000
start commit:   3b68086599f8 Merge tag 'sched_urgent_for_v6.9_rc5' of git:..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f47e5e015c177e57
dashboard link: https://syzkaller.appspot.com/bug?extid=de026b20f56e1598e760
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1775971b180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1290b320980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: sched/rt: Remove default bandwidth control

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

