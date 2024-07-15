Return-Path: <linux-fsdevel+bounces-23711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA38931A98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 20:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D83BB2264B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 18:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E3C12B17C;
	Mon, 15 Jul 2024 18:58:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DDF762D7
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2024 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721069909; cv=none; b=aUsW3ZDW+z7ITKC5AfusBy4wWOkDeaqgAOR2ZHgrGv8+1QFQheDdhJ8h59zvCLnxATnfS+mnT64Zb7zyZqlAVDqp+6yRMJA+vsdyQxdKScpJGjKQEbns42okYQaYmcklGAwxct/0RrFSVl1aIIgM1bNSgoFRMCXrrBWJlPNghUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721069909; c=relaxed/simple;
	bh=CY6PWv8H3KhC110hyOjmpJmbBBZx4l8RXYjoZZsvS84=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DH7BfjGMlNKo3eDaVp3rDgmAYpXr8ZdurTP5LzPZHy+VjKFgnoTPFJqRT2+Nxm5BQ9W72VgId0mTlO4Kjg3eTirOuNmJDKnWzov5TJvbkP7fwhflAfoFEfS2SpPF4mVMd2rUWAfh1S+UxIVi7ByE4oDIs+WnM0ufcgz6Oj8QrVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3810df375d0so48518675ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2024 11:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721069907; x=1721674707;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AvJYbgXXuIoKcXDaxUCAc8E+cIgjRwR+GgSHpz32uFg=;
        b=UEiPEE8GTS7OWuiSr0gkqOxxUHMt5C9QdcFc1fCUKgjK3p37oFd1GhSYAMaNmUXs3M
         R90QzQjHIDqldZTFk/Sq/XPmLSwyDCIo1ctTDxy+woF6s95Mrqk4OW5jo2q7dgH9PVry
         KWDxzU7EiQGm72KIPnbj2r9fwFUqUvnASG9Z/De9iiQSOUIIjjssiseiaDoi5LdCoWx/
         BHnyyZPf+aciOdJexs8gZciTqljf40eoHwcbSAjcbtu/io1EkMVTM7T9lRnOiOPZYNx/
         yOnhDS8j9X9pMGaxB49KShPkjQZs9mEugtLBZMRgSZtKsqDn9Qr8dQLUAB0GL1n5dUNm
         6n5A==
X-Gm-Message-State: AOJu0YwDm6u6T+KUNj4mJFSChOVTPEu1dbZXQrfNbM/XE4UFF8ARnDrI
	SYyMnKUaFZpzN9YnJXMMXfyP9ebd5k0sMzYUdVl90EUqyYnZMA0wy6p3xGehlOGuOAiPkzKw0CL
	broWmHm3f6/D0OxvRVcBoEEIKz97rRLdPJcr8BYaF5BgNfHcGHwPbavM=
X-Google-Smtp-Source: AGHT+IEAntkkKJQwYWJoP0APVlCWkx+EV5ZRAWX+U3l9yHH9TtkcZf52L1iVeKLmb6+BaKGHeKrmXQs3nNRewIIbedZcMFDmzJQr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13af:b0:381:37d6:e590 with SMTP id
 e9e14a558f8ab-39394c98e44mr500685ab.2.1721069907486; Mon, 15 Jul 2024
 11:58:27 -0700 (PDT)
Date: Mon, 15 Jul 2024 11:58:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000783846061d4dd043@google.com>
Subject: [syzbot] Monthly hfs report (Jul 2024)
From: syzbot <syzbot+list3ec8045314d28d24d911@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 42 issues are still open and 18 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  31308   Yes   possible deadlock in hfsplus_file_extend
                   https://syzkaller.appspot.com/bug?extid=325b61d3c9a17729454b
<2>  10825   Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<3>  10057   Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<4>  6645    Yes   kernel BUG in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
<5>  2388    Yes   WARNING in drop_nlink (2)
                   https://syzkaller.appspot.com/bug?extid=651ca866e5e2b4b5095b
<6>  1446    Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
<7>  1180    Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<8>  810     Yes   possible deadlock in hfs_find_init (2)
                   https://syzkaller.appspot.com/bug?extid=e390d66dda462b51fde1
<9>  767     Yes   general protection fault in hfs_find_init
                   https://syzkaller.appspot.com/bug?extid=7ca256d0da4af073b2e2
<10> 472     Yes   possible deadlock in hfsplus_find_init
                   https://syzkaller.appspot.com/bug?extid=f8ce6c197125ab9d72ce

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

