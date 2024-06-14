Return-Path: <linux-fsdevel+bounces-21697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8879085F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 10:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ACB31C21FDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 08:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4B71836E9;
	Fri, 14 Jun 2024 08:15:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E084D5FBB7
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jun 2024 08:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718352923; cv=none; b=H8OF6uUTEYpsfiu1xMFKR2j2vcYqJ7KSzhSYySwyX+ajKskbS5HxrEY4IKps9vQDka5M3ctx1q0FqG+KORrUw2w+3SuaPBlQrFXQBNYrDg+iMnZ3rM2ff/34iaEmcdNZ17wo12hstL3PcYaylpN0l/rQfbxrBt+3gNy0a0sE9DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718352923; c=relaxed/simple;
	bh=4WHVIBJ3D555tdNg04ZngNBnZIVWhvCMAzFMaswUvRE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Qw9yJWC2uF1AwAZwsDhczIpx0W4+rKMgcnxq72Eecsk8S86r3K/QGRMCc6w8KNP/HcsiEzHbZ1OpMWVzKPYBRYiQrPMlHqGf+K/AcKbgDZMWpGH17jDQLElezjk41ZinDeEtJ22j5o5d6oCFN56ktZmV7RDxTX2ZmaEfGpJ2EwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eb01189491so199179539f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jun 2024 01:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718352921; x=1718957721;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ufqmCNorKhcm1V0n33VpfHDH7mK8yeTm8oqi7TEKMcY=;
        b=Dp3dNmbwM39ljMT9SGkEg+XjUH82YeiunjGQMe/Gu1JAvQV8LmbmVGD5DHIux8adoA
         wrZUxydAeQfDsJBoilfR7owRJGcUhi1uB2Nfo/gVE3djMrytJ+l1tCWmn9Z1/TCcECM7
         gtKaazdA2ARVQ72yxS7NWN7B9Xv0cSit9biyZnupzqq7CtBKt+FnPbcU890HKQc4oo9i
         sIrT9U0feLZxVaBpFGInifLyExDy1DOHFBBCHU6xZ1U8snZcujflc4pmocufvBgRWf+t
         vC8xsyCwGeh6nzPE8/nexh8jHZ5Cut/E04qHiyhqF0KwztuApUD05hRaB0mO/UHST2tS
         DaYQ==
X-Gm-Message-State: AOJu0YzGdhJtZToGitmtS/b9VfhTrczRBkT+NYo2+sYpxSv1QcBgKM7x
	KJS1JijccGfHugGVXgOHyQXWvC6W5N0OxxejFPnQWQX48nWD9LO751EJgDDtdiboohcUSsvtXqN
	pGkvAEbocjDvxa9tsawzg831uFjCBzcT7HgsWunposaG8IILZK9Na/6o=
X-Google-Smtp-Source: AGHT+IFuC4GnQROLhrD1IHSlaSk6xrNzhyHkQx9Ru/5y+4t7u/sc7gkYfvc54v6jjHK0GvVprTPT9uRyeZb2DlVjNmNkzaAOOz7z
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1389:b0:375:a535:f7bc with SMTP id
 e9e14a558f8ab-375e0c75f5amr1290805ab.0.1718352921132; Fri, 14 Jun 2024
 01:15:21 -0700 (PDT)
Date: Fri, 14 Jun 2024 01:15:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000768f55061ad537c6@google.com>
Subject: [syzbot] Monthly hfs report (Jun 2024)
From: syzbot <syzbot+list78403d946dffa425f364@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 3 new issues were detected and 0 were fixed.
In total, 45 issues are still open and 16 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  27193   Yes   possible deadlock in hfsplus_file_extend
                   https://syzkaller.appspot.com/bug?extid=325b61d3c9a17729454b
<2>  9791    Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<3>  7680    Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<4>  5890    Yes   kernel BUG in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
<5>  2252    Yes   KMSAN: kernel-infoleak in filemap_read
                   https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
<6>  2075    Yes   WARNING in drop_nlink (2)
                   https://syzkaller.appspot.com/bug?extid=651ca866e5e2b4b5095b
<7>  1413    Yes   KMSAN: uninit-value in hfs_find_set_zero_bits
                   https://syzkaller.appspot.com/bug?extid=773fa9d79b29bd8b6831
<8>  1339    Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
<9>  1165    Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<10> 1070    Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

