Return-Path: <linux-fsdevel+bounces-16803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F30A08A2F35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 15:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 817E5B230FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 13:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1557782891;
	Fri, 12 Apr 2024 13:18:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520DD81ACA
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927903; cv=none; b=l3bUD++nPLxXyx9qnrIBKdiLiRhdNDeLJyE0BjothvdtkfctDPQ9rujtO4k+K2bw7wRGuX0M27CCwag23+Ca55mH7ZLoGeS6vXs3WZj9WRibkbscW4eQvKtNa6PcXjMNDPoG4/py/A2jTaaEzJiYhDj2mrmnfL0/3fsb6rBB05g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927903; c=relaxed/simple;
	bh=xtU+d19LG4MPGscfH1my7E9dNfuL/OL1dpiYCyhsLXg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eb2N2BsK1V3kt9Uieav61NwiszP6MmVhj8T5ZT69VhmTtQhwdleMqaLuAFXB3GiYvqgJzvzPjzcgzlsCCDUkMfLtvUANsqtFtyodGLhhzmFKQZL3Qu8DCiWnztya2qVLa/lD196tA5pBhXvWcaDemG8Oiu3A6DgPMVSQCD+7NsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36afb9ef331so9774895ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 06:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712927901; x=1713532701;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0MAxcojav4R2FnR2JiCAEt723LmVtvdXwB0RfDKb+ic=;
        b=HGujHZar8C9EEDs5PdelAP34ovvqduqNaEauWNVgKZnW9DUkwgXQ6u4YAFtrHK+oMp
         OpwjD34luTnhr7Q4+PPEXKK+Hy3Ac6F2JPK40zFJl0/mlfomROlH2inXtBwSnEXGep6K
         hNrVOlAT0e37zfVg5Guwq4gc6BXIvLLpGsZb0EFEHe/uwaLOCN6Zdp3uvRhttjmanOtO
         WhdJi216DbXly+47dr0e1wgX5pu6OKQWN9TgMWNbgMMQHnlgy9WLSTUJvsqFYrq8XbGi
         m/val4o+RoNhIWsl3jGw87vjIzAp6lGFkqQVXjtAm7huC2AETTiMjHz9tXPnuI631DHU
         2duQ==
X-Gm-Message-State: AOJu0YzGGVvljE4ZiotOoO4MtvBHk7hBtK1q4OA9sreaePHyK4rLavlL
	b69YfxP5SUYUxGUOnz0PLHQe3WsuC/2g6RtKbRcLfT4d0zf8ARXzX5m2gvVwTpWWx/XS6iBqytu
	F3hNiA8rhsGIUCz57Cm0emAF3BtwZO7W+BuAEyGL+JhZ2w7x0fhvlPlM=
X-Google-Smtp-Source: AGHT+IEmI6d2kkOw4B4KBc6Z6xshqREBf0r3V0elGD8G2sssXiU8wMN8w6eAA8RVdH8eloDdNe6qgXAA045HnRYO2NmOY8DhAHEZ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1985:b0:36a:12aa:5e51 with SMTP id
 g5-20020a056e02198500b0036a12aa5e51mr222752ilf.6.1712927901559; Fri, 12 Apr
 2024 06:18:21 -0700 (PDT)
Date: Fri, 12 Apr 2024 06:18:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000019398e0615e61ba1@google.com>
Subject: [syzbot] Monthly hfs report (Apr 2024)
From: syzbot <syzbot+list813261ba32d10ecb0c80@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 4 new issues were detected and 0 were fixed.
In total, 44 issues are still open and 16 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  13341   Yes   possible deadlock in hfsplus_file_truncate
                   https://syzkaller.appspot.com/bug?extid=6030b3b1b9bf70e538c4
<2>  11844   Yes   possible deadlock in hfsplus_file_extend
                   https://syzkaller.appspot.com/bug?extid=325b61d3c9a17729454b
<3>  10206   Yes   KASAN: slab-out-of-bounds Read in generic_perform_write
                   https://syzkaller.appspot.com/bug?extid=4a2376bc62e59406c414
<4>  6225    Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<5>  4270    Yes   KMSAN: uninit-value in hfs_revalidate_dentry
                   https://syzkaller.appspot.com/bug?extid=3ae6be33a50b5aae4dab
<6>  2681    Yes   kernel BUG in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
<7>  934     Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<8>  828     Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<9>  767     Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
<10> 707     Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

