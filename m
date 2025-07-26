Return-Path: <linux-fsdevel+bounces-56072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DD9B129C1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 10:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 105B77B18D2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 08:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B526421FF41;
	Sat, 26 Jul 2025 08:56:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB3E21D3D4
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Jul 2025 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753520203; cv=none; b=D07mNVbDb5dV71vf8qpNxVtAODgJMZk3cU3DxxQHmm8ZXM6yigekc0+Z0OZPjJlwt+5uVBk4V3CgeyAq6dI7mQbO9PanCryPtK/DrEW0cSp/2OtmKAZsJn93xZGRun3f2r+4OnK80EGa3L1lvrjt0tpOS5D1xeJI7uxZoexFeBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753520203; c=relaxed/simple;
	bh=r8ZjYIBoHWp3Er4XQQDCMKi4woSIdnfufa1P11ySiFQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NSGloWiq8cCLh8sIbaDL8HasRitfenvRQ4ioeUn9X9szRPAkj50kAFHaXR1p/LUGcQxiewJhXTKfnFoLzHfDHWS0NrXPnoeXgRNL2BIX1UjuWx6vXk9NjA1hiwwovliLofb2cOiq8w2+iVfgDcIsqO6Zq5yBwe8FfHH6+6BXfiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-87c73fe3121so267938239f.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Jul 2025 01:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753520201; x=1754125001;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=13xxILUIH8NwouizMzWPFNtet7N10oMiBjeHQXTNiTw=;
        b=XGKf1J/FNz4F+Pp2BLf2ka+XtgCHbZOZtFpaYpN2vIZUb+62UtY0g/c0ihPKrA9Myl
         4Nkj69ivLRQwoXznE8emhmlhFvZ86lORjK0PiVB+lmcN4sMiWq01Svne7/Ak7y1uN5u/
         wUE+G5fWCU/TUoKm5NdZ+fFZ3V35oB8tyI/4gXR/zG1ce9I6nmojuCb9Zf9rbLIuAAEP
         8s8Q/CVvM9X1Dbu+w7lZJwqLpUECyTCuYLlDS7H3fesWN/l3ebJYQZEDrSU72EV7jA1i
         JOlxFdNnVyJMHNtG27VtFAI8tvvvOfXxKhkMcDkqX8nGEkUZ7slv7CfIYFGtRq+aM8I3
         zywg==
X-Forwarded-Encrypted: i=1; AJvYcCVEi1hiako5GVZUhkFKPw53q95YyamRHSOQgnjb62PWj92enU8+WiP1QGjBLzTzfMOYSF1sFe2p+WquEQWu@vger.kernel.org
X-Gm-Message-State: AOJu0YxQOxaUBCCP6RFGaZckFCor4p6EThGv6SEXVxfIhWkq7HBsFTMp
	DEl5bP3OwjiS1iyf1uaYpSNda7/Td2ZTPXi9WnuRg9Nz6v/bWaC5Jr9pR48QIHR4WTwiBtlIQJM
	itj5T83BmUq5MIx1QeR3MdGuU4rOR68ac0oIGLTCoETyqk+uQAjA+vYoqCLg=
X-Google-Smtp-Source: AGHT+IHkcWhhZHBm0S0ijK0UaSwKbtJPh279kl6oxHrH33UsqKoWhEyfu9+4G4GpidI7QbmrzCHoF+8UHqXa817inWpA6P1t4DNW
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f81:b0:87c:1cc3:c0fa with SMTP id
 ca18e2360f4ac-87fffa87a2bmr811822039f.0.1753520201108; Sat, 26 Jul 2025
 01:56:41 -0700 (PDT)
Date: Sat, 26 Jul 2025 01:56:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68849849.a00a0220.b12ec.0012.GAE@google.com>
Subject: [syzbot] Monthly exfat report (Jul 2025)
From: syzbot <syzbot+lista38bf97afe36425ea6d3@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello exfat maintainers/developers,

This is a 31-day syzbot report for the exfat subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/exfat

During the period, 2 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 35 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 403     Yes   WARNING in rcu_sync_dtor (2)
                  https://syzkaller.appspot.com/bug?extid=823cd0d24881f21ab9f1
<2> 60      Yes   INFO: task hung in vfs_unlink (5)
                  https://syzkaller.appspot.com/bug?extid=6983c03a6a28616e362f
<3> 14      Yes   WARNING in fanotify_handle_event (2)
                  https://syzkaller.appspot.com/bug?extid=318aab2cf26bb7d40228
<4> 13      Yes   kernel BUG in folio_set_bh
                  https://syzkaller.appspot.com/bug?extid=f4f84b57a01d6b8364ad
<5> 5       Yes   INFO: task hung in lock_two_directories (4)
                  https://syzkaller.appspot.com/bug?extid=1bfacdf603474cfa86bd

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

