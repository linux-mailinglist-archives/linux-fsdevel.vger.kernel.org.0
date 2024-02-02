Return-Path: <linux-fsdevel+bounces-10110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFED847B53
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 22:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C961F2A55D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 21:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22E681759;
	Fri,  2 Feb 2024 21:05:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88408174E
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 21:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907925; cv=none; b=sBH0eNSz0IEw7hj6uOkE14xZgDGu4c32UbL3GtsGtqnVwUS7CjPEAw+gPcZOKC0OFbH5jEn8DHbI65tsmx2CFHaj7CZJtmeeiP5jePwMLJ+XayZJFYsN9ww9F8KUXdE21wVMzGzCU0iNB+p3Pg312FkH+ozc+/cc6VkLP2YzhRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907925; c=relaxed/simple;
	bh=OEvr5+/yj2ihjujNxK4XVMyOABYMSi6tbqhkyqIcGII=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ks39YEhYzB1ELB5s8gcvXZeg6sCRzIWWEJKagFOVsmtJSeW8U+72VkzG0Qqp+NM1U0/7ObFgeLuLwkNuWDXPvMd01IsGT/2hcuj3OeC30wONDa8wjc5CuiJiK0AqjMDgE7WU6pILIpDq6NR+2NtlpeX0x5T4e2KL1PkPOjVo328=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7becfc75cd4so201439639f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 13:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706907923; x=1707512723;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tN2jUIgOwKh+WxF6WnNkQPAYfTv3IkyDk5IO5TckmRo=;
        b=u3gLgI8wAnDTyDBJlJoL9a9qjIRmURuvkTwmMSP7aBksiKdZBWoYevMwN29Z/CMrAs
         t7rxWNix3IzpmPhdDwS8TH44qbLNkIL0cHpYLDMX3AXDfV1uSeJaFqugxRUgdwbF0eCF
         ZGeKTWjJmh2ciY9kuyRCbeI7c+g0mK/EusKP1Wg7q8llN/42NgWVz/DCwP3RW3IuiPys
         ismLPTig/bQS9M3BRFX8bSab6iy985kvbQNykY1nXHQbq+dC2tRWWgfG0R16viB0dulr
         UbGnlI+R8in2eSmvPEERtV36DLtQlL6qUI256hMxL/6N3lJbaOfPC/ksxWnf1piqRlc9
         ap1w==
X-Gm-Message-State: AOJu0YwHN34KU0jrErch0OmnOKOuYH3JNFVnbM5xzBzorD9l65+gkIwg
	udt8t+u6aegkzW5oXOWPfx1ZTkSv1nkzadFLwGdMS0rIKH6CPhJPKC+I30py7XttLXj6ej7cnIf
	p5FrODDn0bji2kX7tlKwK68S7KEd+iuyp1Gk3OuaVns/kiPrsMq1+EP8=
X-Google-Smtp-Source: AGHT+IFqGl04LsBhODxZQWt/9Z5loRCI9Hxb5onmXoKXECF1BuW6tfK/uoGsAEoRuMJbCXHJwMHofLY+efqmGCSL2YQh3mPm9utS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bc2:b0:363:8336:b21d with SMTP id
 x2-20020a056e021bc200b003638336b21dmr194522ilv.4.1706907923174; Fri, 02 Feb
 2024 13:05:23 -0800 (PST)
Date: Fri, 02 Feb 2024 13:05:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ce0ca06106c7894@google.com>
Subject: [syzbot] Monthly kernfs report (Feb 2024)
From: syzbot <syzbot+lista950330f639d85c965e2@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello kernfs maintainers/developers,

This is a 31-day syzbot report for the kernfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kernfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 11 issues are still open and 20 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1714    Yes   possible deadlock in input_event (2)
                  https://syzkaller.appspot.com/bug?extid=d4c06e848a1c1f9f726f
<2> 227     Yes   WARNING in kernfs_remove_by_name_ns (3)
                  https://syzkaller.appspot.com/bug?extid=93cbdd0ab421adc5275d
<3> 30      Yes   INFO: rcu detected stall in sys_openat (3)
                  https://syzkaller.appspot.com/bug?extid=23d96fb466ad56cbb5e5

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

