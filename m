Return-Path: <linux-fsdevel+bounces-72155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D9CCE65E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 11:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD3F2300D422
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 10:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC87A2D061D;
	Mon, 29 Dec 2025 10:22:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85C328150F
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767003740; cv=none; b=ufgEQW4QbqeOjD1szUUNnNIcHjHs6v6ZR+VxpaYEZlXvh0o8C3aimZhCZPsL+XR/fkaM17pGZ6tP8yH/PT3l+Wb0aMu2/qsfdxKCssef8RapJ9BTIk0vNP7SsHGGuDAjFnb/NHP8G9TXp4PaOXOFTu/xbo4Ktl4IgkizEF+BAJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767003740; c=relaxed/simple;
	bh=nKUQxR8gNCDm9qtv+QLbIbqgN+JBDpCOfDVyIjdIz68=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NxDwb72uUdQUhP1AeSpFkkxZZmpmUmZzME8F5W5H675twM2iVLTaVHQNAxiafoR0YcuRFJ6vPhj/lc8m8P6F5zZHpRBRU1uL3DEWtQe7u2IlCXAGt0YwM17WLTa6CDII3XK/cqNcOExtOXT0Cb21j3DWsorHR9YWRwHd2jumlDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4501b05fcf1so6760932b6e.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 02:22:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767003738; x=1767608538;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v9lFlYm211DlBJm+toEjgGyTLhxVxWfn7oBdOhoTpak=;
        b=VJ5gcCpSdHpoGb1yWKgA2du6yfE6aDMkboVSyBBuvJqXuN5RTG5ARA1sb1j2EJSROe
         y8W14awEL+Ja8QA/GrySgbANqEZJDwQXg3i3n2DmDXY8VLRaSngYeNk1HXJN1Ok4rQdf
         fyfA8vsoQCLoP6Wy1QZHPb58z2E52Dr8zMSEPKjJp+FuJ15D4OeF1S3Xh/pB0u738+ds
         MzlJbuk23GsBoccblgAEUlUzSPm1XCSMtXqz7tkiBm9aWusw2k11khEShP3deREqi2jO
         DYc9fF/MB7RooxlraOCAAnccMYDx/Ir9ZQ/SQOv2nWNYUpA0QTaAjs3KUekQvgdMIq9F
         ePsA==
X-Gm-Message-State: AOJu0YzpJ9AhPRUdTuwO4DvWWs1peFdxhJTw6HxF8trQXReVLnJQQZ+A
	SQo0I2hoBB0O+DbLL89bLTSn+fXKOJtWwFDrE0jWFAc9myxQlAAvZ1ESIfMG5GV0hwkFzttjjWb
	j2rlsQ1Pjp7dQLIXbS+KdR9kd6XnLgd7My3LatjzVMAGKIrOZPIlaWng7Cdg=
X-Google-Smtp-Source: AGHT+IFIVmKGmCV8q+qKC9g9SzsxhDuVNQO9SkdGVti+CO/mjGtYX2CAoU660AVyoY8fLhlJTsGSdmgqeWrvxss86mClcHWB38nt
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:dcc8:0:b0:65d:7e5:d49d with SMTP id
 006d021491bc7-65d0eade78cmr9896317eaf.72.1767003737784; Mon, 29 Dec 2025
 02:22:17 -0800 (PST)
Date: Mon, 29 Dec 2025 02:22:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69525659.a70a0220.90d62.003a.GAE@google.com>
Subject: [syzbot] Monthly hfs report (Dec 2025)
From: syzbot <syzbot+list96869fe6582bac30b4c6@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 25 issues are still open and 31 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  158424  Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<2>  14781   Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<3>  6107    Yes   possible deadlock in hfs_find_init (2)
                   https://syzkaller.appspot.com/bug?extid=e390d66dda462b51fde1
<4>  5557    Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
<5>  3246    Yes   possible deadlock in hfs_extend_file (3)
                   https://syzkaller.appspot.com/bug?extid=2a62f58f1a4951a549bb
<6>  1842    Yes   KMSAN: uninit-value in hfsplus_rename_cat
                   https://syzkaller.appspot.com/bug?extid=93f4402297a457fc6895
<7>  900     Yes   possible deadlock in hfsplus_find_init
                   https://syzkaller.appspot.com/bug?extid=f8ce6c197125ab9d72ce
<8>  661     Yes   possible deadlock in hfsplus_file_extend (2)
                   https://syzkaller.appspot.com/bug?extid=4cba2fd444e9a16ae758
<9>  450     Yes   KASAN: wild-memory-access Read in hfsplus_bnode_dump
                   https://syzkaller.appspot.com/bug?extid=f687659f3c2acfa34201
<10> 386     Yes   possible deadlock in hfsplus_block_allocate
                   https://syzkaller.appspot.com/bug?extid=b6ccd31787585244a855

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

