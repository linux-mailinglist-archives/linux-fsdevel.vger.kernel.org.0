Return-Path: <linux-fsdevel+bounces-32447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E771F9A588F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 03:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EAC328243F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 01:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BBF17BB6;
	Mon, 21 Oct 2024 01:30:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF84314012
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 01:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729474204; cv=none; b=G88f25RtO0w2SViksWOE1QU3SuUaF1yHVEhktg38n6zpLyMdkP9uKJAiJZr2nYxvM7wKVB+FB7LiRfZp/4kf+WTXpueZUwdFml9hIOmj3TkVzMeapzanZu9Px6dbAnSs0poDEQyaXH+p5Tu2TDYkl+sjzgySsbXBTPVzCnLBbD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729474204; c=relaxed/simple;
	bh=ynbTadkrAyrszDiQBPEFVoIBeehpsN7JSf1jIw8+/bg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aJiSoRaxtp+0TalZ+4IMkxYXHkN1i1guBtp5cJFgbay/r9g3kkG4uxML21gry4EPkTdzOgfP7gs5e7lzJw9LZ+tkLvURpMu1Qk7+GBR+OffRB2ihTnoRF4A1X48WMZhkp3L5cARr1J47EXpGDSpPKRhlIOeuXJ/v2m0e/ub75xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83ac1f28d2bso191025439f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Oct 2024 18:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729474202; x=1730079002;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7a/5Wi6uyRRX1fKyisouWG44yQPcxNqJSu6QJT4RokA=;
        b=qMZ+TiFEgydBDhAE50ROc1vTmLKZ40U24tf/HFn2AkE5gO5kvatJ5C0uqK4zgNaueq
         Hkvouc+GusJvX+ptBknJQVxnGim95ee2p38hLvaP6cL1prFox6t+X3NwdZU1ZBclfB+Z
         N6+vojw8vfl0o+3aT60btNAx4cjVve167OuFnqvP74xk7nshAs4qtiJVPXpafQPpjRLB
         agRPQIaAc3Juv1/JQ4MUQPr/F8WKg8lFwqYfSBMpf7oAI2etSkVPkMjHa9KrKItHzDP3
         VkjALyiz7ui1+VJo8nv93iboylKugeTaNA/lwD5jbB2JNkzKC4+Mb6Nzfjnw9e+hVz3x
         700A==
X-Forwarded-Encrypted: i=1; AJvYcCVQlpjfY+wcn1liWwoF0OM53wcnKNhYDCTSCEnRvqlUGQ4wnfdHfjmgtms6lEZdgR7fQ0CyH9qm7brH9IW3@vger.kernel.org
X-Gm-Message-State: AOJu0YxtoG4DLsDJA82sVYRbsFcpcjsKjY5UZV9gXH/iDjjSgP+Ltj6J
	UUIOwkGN6PWrW6uPsWLeHQOObp92WPGT9kqUXo5A2vw3iI1Xu5oKxjXDt5t2FJF9jcUdvKlmR8I
	X2rMo8eWmCGZ6Ja9dFH1VpX6RrGECHQ4x5mpxNfuEy1etq/+KhfcuogU=
X-Google-Smtp-Source: AGHT+IESUssgUI2mMrU2sS6AJpDAO6LLvlP5eIWqnHWQ6KVhV2ANGPOq0bjh5/I78cJ2KMnX0Dxd+mXwdP9W+WGXehgIG3IzrHhu
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:50f:b0:3a3:f82d:ba43 with SMTP id
 e9e14a558f8ab-3a3f82dbbc5mr52685825ab.25.1729474201949; Sun, 20 Oct 2024
 18:30:01 -0700 (PDT)
Date: Sun, 20 Oct 2024 18:30:01 -0700
In-Reply-To: <6714bb39.050a0220.10f4f4.002e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6715ae99.050a0220.10f4f4.003b.GAE@google.com>
Subject: Re: [syzbot] [fuse?] kernel BUG in fuse_dev_do_write
From: syzbot <syzbot+65d101735df4bb19d2a3@syzkaller.appspotmail.com>
To: hdanton@sina.com, joannelkoong@gmail.com, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, mszeredi@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 5d9e1455630d0f464f169bbd637dbb264cbd8ac8
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Mon Sep 30 13:45:18 2024 +0000

    fuse: convert fuse_notify_store to use folios

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=120dc25f980000
start commit:   15e7d45e786a Add linux-next specific files for 20241016
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=110dc25f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=160dc25f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c36416f1c54640c0
dashboard link: https://syzkaller.appspot.com/bug?extid=65d101735df4bb19d2a3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1623e830580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16582f27980000

Reported-by: syzbot+65d101735df4bb19d2a3@syzkaller.appspotmail.com
Fixes: 5d9e1455630d ("fuse: convert fuse_notify_store to use folios")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

