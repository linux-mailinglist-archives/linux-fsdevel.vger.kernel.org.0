Return-Path: <linux-fsdevel+bounces-26104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133DA95461B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 11:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC43828504C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 09:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D4F171079;
	Fri, 16 Aug 2024 09:48:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15F316F0C1
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801702; cv=none; b=IiSp40YNaSnXBaM922KSx26Z8QXFz8OZwYgGOtHmieIUk8V4aWau+JGO7GDEKViSGgpKbAYYwoVcYXnyYtj29G6nyJzAKVrlV9Kaq1Phavas3ETlDOP6XCZjIAao+AvvHvud4UsOJCqqRuoJ+7lKsjv2X1K9+KVsIp4X6lXD0Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801702; c=relaxed/simple;
	bh=fHd2H6G8r0OkMiDyBcNxaNMNzQBskTZKqe6GWug0Ek4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hNnNFzy7m44IOZ3eW7SBXvShGvVChzvvGe0fAzfcKa6gbqEw8V6cPf5igZmRCQq7S/m3XXDuUz1IYxDFpyH2xQFvNE+l2cKQZm4oxI2I0oNN2wu9ExR/ky2ZEANRVr9IybxFrtBY3VOVtofUJX4AHD6Lt/0CPESo0p+q4JeVOKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-824e12631c3so216650539f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 02:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723801700; x=1724406500;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6H0K+T8JmGoiCujE8WWSsp4Gdtnp7htEs+6zPlS+74k=;
        b=oKVEFY//bUBblxnxqfaI/tcpGyhbu1m60X+nFNO0h4kgVuaP7ab+W4oel/TCZc4+yx
         t1Du8QXDRxx+I7P/hsGiriYRLJ8QOOQn4OTba3p3sqzh+eTFq5KB9hA41IevSNphePnT
         +q77KZONgZ84TVtLuWU6Rx5gZrwrFH7EAZqoNUhn8kbZteQqyUpgYDbvrbuXkr7GN3Pb
         mGgQsy/Aqew8P6hyaKjCrhThlbX3BA3K18ezuMfMUxMhnZXXuXluz3dlxFN5LSQWr3GC
         lAcZMbjll8Kl8xwmMh9ttKaoqGLdQwmwKW7UO2sT4Fs5kdIi09anekRRfcd40jTC1meN
         HVrA==
X-Gm-Message-State: AOJu0YzwTaXTwaq6WsFP5fXrDijNlhYQJ+RS1F79VRVaoU7PirOQyGqG
	vAN7mLdtDnoTapK17M2yLmo59Ynmr8hN+8OzkgKb7ZW+cyc9/muAaWLDOaUWtPanvYR82WOZXLi
	TAjHa8/nIiP1cpnMLox4iShzhsROh34Wt8T70lUzs6rhCOvJSRs4o1Ig=
X-Google-Smtp-Source: AGHT+IHAuUZdL/oCUSW45SYTGXofedcY2Fs6PIcJXnVaJr7IF9ecdc2xoy7Gwrx2fZmpnui5PIvo023Q2IapmAVRqDG8isyTvO1D
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2711:b0:4cc:d5e0:a114 with SMTP id
 8926c6da1cb9f-4cce1389aeemr75817173.2.1723801700142; Fri, 16 Aug 2024
 02:48:20 -0700 (PDT)
Date: Fri, 16 Aug 2024 02:48:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000002325061fc9dc44@google.com>
Subject: [syzbot] Monthly hfs report (Aug 2024)
From: syzbot <syzbot+listef5adb95de3cde4707ca@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 43 issues are still open and 20 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  31655   Yes   possible deadlock in hfsplus_file_extend
                   https://syzkaller.appspot.com/bug?extid=325b61d3c9a17729454b
<2>  12078   Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<3>  10932   Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<4>  7266    Yes   kernel BUG in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
<5>  3004    Yes   KMSAN: kernel-infoleak in filemap_read
                   https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
<6>  2922    Yes   WARNING in drop_nlink (2)
                   https://syzkaller.appspot.com/bug?extid=651ca866e5e2b4b5095b
<7>  1551    Yes   KMSAN: uninit-value in hfs_find_set_zero_bits
                   https://syzkaller.appspot.com/bug?extid=773fa9d79b29bd8b6831
<8>  1470    Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
<9>  1370    Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<10> 1217    Yes   KMSAN: uninit-value in hfsplus_delete_cat
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

