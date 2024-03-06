Return-Path: <linux-fsdevel+bounces-13756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862FB873706
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 13:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EA8FB22F2E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 12:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4C913172D;
	Wed,  6 Mar 2024 12:53:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C2B12C53D
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 12:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729602; cv=none; b=OtOKWL2li4XQVjppXI0RHQ6QVHv7TShtcr8xqSx+6jhA39CXNJ1ryyi8oqARXGPa+H61NKduGMKp5wbbOQ4bcxkWZwedZ4YvSotpqQWdQ5NUVtyuZH/XODdwwtpbSbhwQ4mzhfLvwnATiSYNs+4+EU8FjKyWM3B7h2Bg4k9Kb9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729602; c=relaxed/simple;
	bh=9+t9Y7EpY+Nh25tbLiKHuxy0RxzvNfE8+vLUCPQG2B0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JV9tj5XNjVTkdQ6WnU7zzCi9jc21loxHEj6F6QLI/Ay4F7NBLBjSNEd92qNL88c5FYuS/Ins2S2St7ikZchR3YMoKlG+e7ZTehKwr65qsOujXc2zJRsHYJ2Av41nUN4LNhTp9DYoKMqjvUC9WmAGprXWOiOBstgH/pomk0Uz6s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c85f86e4c7so236064039f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Mar 2024 04:53:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709729600; x=1710334400;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gou0OiZ3/4qiZbmE2nZGs4XwgQLrszXKYnscoVCGmpE=;
        b=N2gjZ85xIUAy2aUvKvjJj2fGXEnHQn6/IGAHdl4lCuvVLSxH4NG9IEQ4ibE3M9Yux0
         wUrBgYw3kKCyc/B1gBPZeIlZTYMXj8geX8B6hKpOY9TUiz1299a2x3kEf/v5JgEfYLJr
         PSNIzhQ8lvu5Ar3o+cxNl6nUKCqWf86eIg3GHTJ/qSXDXPZoRI4wUUhC/WLCkfyS0rDU
         5NnM5I1+TBmFj82hZTEWAKOBSD7CYzYcUUBPZa1+ugqzB2Xoxxfb0aR8QM3+lB/4VReX
         FmmVcvila7N9OGwO2kfk9hl34vLzH496+nSuM3vWdNqkHRL2pehz4OyIM/+qd/sZRclW
         gb7A==
X-Forwarded-Encrypted: i=1; AJvYcCWkv9hwOMAPcMp8oA8eW5ZUt5UZ7pIG2pQqP858vGmcV0xmLN8bmP29B0jPktSWsGW2SGAlVnU4sri1fc2nlwHrOcd4vAf13Xn4XnlAaQ==
X-Gm-Message-State: AOJu0Ywn3z9cqvKXqRo29J3ShtXHboage1UoxGcc1AdlHz78x8Mnj9Tp
	2MPqvL4DiKds0pgW8KDf5zFn66iBxngkKfI2WsQglitlI+eVi//sDJeuF6Cqp8nhT+OU1m9OE18
	K1/ARBzjbMpWT8+eQ+R1pbvgyYxpV7TQXkAyxa3XB6Am2pIdXyqz6vIU=
X-Google-Smtp-Source: AGHT+IHye2it3rgUqKQhQ+qi8X1zN6qRtpc3cVbcToHSfNtqcRix4qPLQm4dcuStQS6HxSOz4woPjklF59wFcml7ddR5LgzbYIXw
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:40a3:b0:474:e855:ddfd with SMTP id
 m35-20020a05663840a300b00474e855ddfdmr242316jam.6.1709729599914; Wed, 06 Mar
 2024 04:53:19 -0800 (PST)
Date: Wed, 06 Mar 2024 04:53:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077157f0612fd71e8@google.com>
Subject: [syzbot] Monthly kernfs report (Mar 2024)
From: syzbot <syzbot+list0fd290f5a0f10ba9dc82@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello kernfs maintainers/developers,

This is a 31-day syzbot report for the kernfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kernfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 12 issues are still open and 20 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1761    Yes   possible deadlock in input_event (2)
                  https://syzkaller.appspot.com/bug?extid=d4c06e848a1c1f9f726f
<2> 245     Yes   WARNING in kernfs_remove_by_name_ns (3)
                  https://syzkaller.appspot.com/bug?extid=93cbdd0ab421adc5275d
<3> 52      Yes   KASAN: use-after-free Read in kernfs_next_descendant_post (2)
                  https://syzkaller.appspot.com/bug?extid=6bc35f3913193fe7f0d3

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

