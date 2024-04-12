Return-Path: <linux-fsdevel+bounces-16802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7B98A2F32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 15:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7E31C20C78
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 13:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B2F824A9;
	Fri, 12 Apr 2024 13:18:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28F281AC7
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927903; cv=none; b=fnz17UmY5GC1PQbZqFE9FifX9oKTJZpYcGZYm0wSmD26o2o13FrKICQfCL2IddErwBQnaiHkRMqP4iWhbGUy7fwwTkwuRA/JxkWgsg63Fkrfrhi1f6LOaRAHR52a1Q+lL9BeaOSZNav5sYE/yiij+UCGrsMoqUAi3TYKLHv9P2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927903; c=relaxed/simple;
	bh=8paOf1b2ZdWmbAcpzi5dPqOHFQ4WfKdYlsrMjVePZ1g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Z4XE9aKrEKVf8DVzXX+gJ5uiekUD6bgV9nL/UZBPAeNEmjQryawi7Dl8JTqnGHrzsRM+/REG15PK1pzGMMb8oYJGpgOpZB88vCZpFmpN2nnqGza064sQxpE9wS/A4Rw/tcDj7mxC4tZrDOKBZFiqWyu6Q/YA2YzaymS8zwQsZLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36a0b315926so9948675ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 06:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712927901; x=1713532701;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P3cHTthowrpp9xIJFbk6MbY4tgEyPpmEH92M1HEhhi4=;
        b=MEMkzjINXPKipFGLA3xR5erXpo68JIdfiAcygaI4f/SUDUpJs3Pxi/j3nlZPN1GSXn
         GryOr0u2HpYZySBnK/Sn3eOwG/n5PCZZgZRnYYhbqgXS40u606uc4He0efNndeAx/lGc
         mPtKSzz82Xm4q0IYVmcbc0u/NOGmFA8ubAOexWTV5AjKzW9Zw4n2uewae1LFWD66T7GE
         gibqCt1yEtnj19VglNNbMT+DyvFjHu/CaL4S68bIekZrSjyCC7upMrTf8iCrIu06QKiv
         cw6jaghsoUBCEHSzBTlu2kVv8GQmD8/s+2pa5eZPlypn1g5EtT6X5UZE7sAHwdhvRiis
         p9LA==
X-Forwarded-Encrypted: i=1; AJvYcCV3lSzLtfiiQU33iGTao04GLJnvf4coCaVjgsFTTxrM6fxJNXheok/UD/83ukROERDjhRWU5u3eqLnOs2Vx6wClJw1tGqxBYxKHKhKU7w==
X-Gm-Message-State: AOJu0YzDTlqxDgiVwjyPgKsTGIq0E5Jb8RI2TJezwyAe8G3BeaTIqYHG
	I95HjlVwYyuCQruO1zqQKLvlMW19zFCcLKAN6J7Jgqz3QQwAH65QQagFPvrRbfim5kgjX860gd9
	JADVIt3Ep3+BpGNAVQPFuAlj3xnrG1hZJ7g0Lt4cx5ivvTQj6Bslo9Xc=
X-Google-Smtp-Source: AGHT+IEMAfwHuimoEKjZt2qj0wf7iSh3NykVvAIrOhyP0+q3Nt3cW3irN4/F48Acaa7IVFZSN/tVZnCUIvaFeZJc4rG5bSLCbLLR
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a89:b0:36a:220b:4078 with SMTP id
 k9-20020a056e021a8900b0036a220b4078mr181862ilv.5.1712927901318; Fri, 12 Apr
 2024 06:18:21 -0700 (PDT)
Date: Fri, 12 Apr 2024 06:18:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000158d280615e61beb@google.com>
Subject: [syzbot] Monthly ext4 report (Apr 2024)
From: syzbot <syzbot+liste73a7dcf846b305a7eb2@syzkaller.appspotmail.com>
To: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 6 new issues were detected and 1 were fixed.
In total, 27 issues are still open and 131 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 8793    Yes   WARNING: locking bug in ext4_move_extents
                  https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad
<2> 706     Yes   WARNING: locking bug in __ext4_ioctl
                  https://syzkaller.appspot.com/bug?extid=a537ff48a9cb940d314c
<3> 435     Yes   WARNING: locking bug in ext4_ioctl
                  https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
<4> 151     Yes   INFO: task hung in sync_inodes_sb (5)
                  https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<5> 33      Yes   KASAN: wild-memory-access Read in read_block_bitmap
                  https://syzkaller.appspot.com/bug?extid=47f3372b693d7f62b8ae
<6> 20      Yes   INFO: task hung in ext4_quota_write
                  https://syzkaller.appspot.com/bug?extid=a43d4f48b8397d0e41a9
<7> 19      Yes   INFO: rcu detected stall in sys_unlink (3)
                  https://syzkaller.appspot.com/bug?extid=c4f62ba28cc1290de764
<8> 13      Yes   kernel BUG in ext4_write_inline_data_end (2)
                  https://syzkaller.appspot.com/bug?extid=0c89d865531d053abb2d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

