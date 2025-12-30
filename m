Return-Path: <linux-fsdevel+bounces-72240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CF0CE94AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 11:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8103D304379E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 10:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D9B2D839F;
	Tue, 30 Dec 2025 09:53:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD782D5416
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767088404; cv=none; b=DQvDGlKWaI3tZK06iCSrOmpD1uSPlmav41WbcyxKTMm3kGPF662QnFxbD5oQ7P0RWA5QvpXCc4QYI+z+4djlCn5hbE/EsPbqQUzMN+cvlm0w45BnqPEIpKUkkD70bnDUQFWDVe/vMEsn+PqablEnEi14jEpA4HXSqvhlQxyRbEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767088404; c=relaxed/simple;
	bh=TIJj8tCZQBC8KkFXOAg3ggQqI7D+wtg0pqoAkwRdvOA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mP6X0reaor9a+RxSVrX3fmztYLK4xdWDedgm6ebHGkeOW7u5PjH0SBpVi/cxhuT/tzVvGGMK+n/H/dy41MzQhSMCkKYVd/MhTWRP5rd8RZ+5RwhdCltiai0K27j6EKrbpTnrnMbmOo4W7sUkx8wGb12v1dXuEjPkeHc2GlgDWVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7caf4cdfa28so12906506a34.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 01:53:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767088401; x=1767693201;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0wOozAproODoMHhT3fg8SYRI8IM2vh9K+YuGuxSN5ZA=;
        b=vy/SwzYXb6ZAqcGrq4z2j7XtG9K2mYon/1kbGXu5chjH7O+fZZPLcBjk949V3LNufr
         p1dF+WVWpfqVX/cZ2VXuLfnA3Pjqsw5JoyWmZcUYvg+b6XpUoDf1YOBffdE0k4Rc7YpY
         4yO4/5Pg77Ft/kzgEuCmgxmDYpbjYCY9qO9/wMK4/vgAWrWAp6o45qtXGz1q3ykAvaPW
         +UV8A3Ln9LeoD3ZE4MY5TgwTtBkoAq7oJtPbfqwg5LXKKCt2c15z7XEkj2SSLftgXWio
         kWwYRi6nA/ZDRnhe1G5JXKCSAEe7QQhtHgUEoSvuXEgeBmaAtvk1zqTRtQU8BtB8fJQJ
         pSzQ==
X-Gm-Message-State: AOJu0YzhPOloEG7vRazjfmZsd1Y6v/smRcMAfP3hS1HICRhnWdp1oY6c
	kiuY9ntaC5AZjVF2Ji6PDtb0Le64zVxpLGLh7LIHP0Y44cCHhofS2kHDjncERJjhzx4bqmgl/P/
	ruDuPkAehRynW5wr6t3I3NKmO6mfio5+GoeFh0/N3Sm/6GIEDcKjl8kEv/so=
X-Google-Smtp-Source: AGHT+IFpALkFA7nHf1icTSzVQbhXqh1i0YOQ/TLRVQSf7FNcIsGs0vlVbSVfZzY52qaHgHJbJPuFNzJCHSiwCtlZzvcqzirXK+WQ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1ca7:b0:65d:860:4ede with SMTP id
 006d021491bc7-65d0ea5b64cmr14921579eaf.46.1767088401640; Tue, 30 Dec 2025
 01:53:21 -0800 (PST)
Date: Tue, 30 Dec 2025 01:53:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6953a111.050a0220.329c0f.0571.GAE@google.com>
Subject: [syzbot] Monthly fuse report (Dec 2025)
From: syzbot <syzbot+list1765dc5d709968827b68@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fuse maintainers/developers,

This is a 31-day syzbot report for the fuse subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fuse

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 45 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 9449    Yes   possible deadlock in __folio_end_writeback
                  https://syzkaller.appspot.com/bug?extid=27727256237e6bdd3649
<2> 524     Yes   INFO: task hung in __fuse_simple_request
                  https://syzkaller.appspot.com/bug?extid=0dbb0d6fda088e78a4d8
<3> 47      Yes   INFO: task hung in fuse_lookup (3)
                  https://syzkaller.appspot.com/bug?extid=b64df836ad08c8e31a47

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

