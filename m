Return-Path: <linux-fsdevel+bounces-18835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E778BCED2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 15:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE282822C9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 13:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7A878C89;
	Mon,  6 May 2024 13:18:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE9B7641E
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 May 2024 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715001515; cv=none; b=otrn5PZJoHAbXdGU3y2JysEEullQ396fM9DlQp2Th9ICInqMXsM45Demd2zewzY8pGUxLM5FWRligJv6SNm1Pav9vs4ZsTVDKlnMaKINelD3pfupJxB2Rgl8a/0BvMhZKeCofC3zabvi7t3VMpQDux9z1lY3/wvwlZwA1C7kqWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715001515; c=relaxed/simple;
	bh=V/up/2lYtF398jVbxFQpvlOQdOIQO1W2NMWn/hoN80Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=blyxxoNKDryTDp/a3L57ryPCe0ozDH2Kki87o7m1ssARMcvJ5TxHeRqwcrEDKAs5Uech6Vdfv8wcfQNg9Af3G+RpfKBaM9klm/y9oEM/uo4YAHl11EcaJOJoy2UdXtWeXeDJks4hdcDo7BZ46mduMyrwcskeeq3hxHAdMpiYgKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7dee48ec44dso213181039f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 May 2024 06:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715001513; x=1715606313;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YcwKLWuIXegQ7OmHl8ESKsXo8407Y2njqb3uaJ2tHCE=;
        b=RcGGgp0vFH0uKVnqLKGnl9RKKpnuC0es8ZY5n1FFegaWosHZ4B96UUHnfkO7Wj6wAF
         CPGLJ23xPxgk3tP0B9oufehL1m5ORNw8JCGRecUumVkpgbH0lvo9USPduHvucJdIl99+
         13zioqrqRW/m5njeKbZYWJFCbcn7rsZva9k0m3eW+oxGPkh8B9w5oCxg5pkRx82BW4Ti
         zABorHLgXYoWCd72f5BC5wj7xXSYmq0FMvEMse5CO3atlpV7B4f07yHEYEUBLVI9Am/P
         CL4RuZSocU+HAQZSvBoc3gUgN8TIP6KSXGUNHKlKymqB7j7KmhjUsL0DZW1G5bMe+aCc
         F3lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHQGvjk67dhM+mqZT+JPabuO80dlFFsyP7u+v3hkPQOxM25QGjkhMOFQA/VCN/e5OI8wvzqqHIvg7rvTyDlarNJsN+/Dy4dyD4rbr+0w==
X-Gm-Message-State: AOJu0Yzwq4Xftw0OhAqb3r8ZpgUQinByq4KHOnE9kePGL4MzfVSHYXXt
	hsLrtE3CdNl7bzQHmL8jPEaaMAIU71DYE89NPAcu5Jav7RC9eJE/R+6xWifLAYDhh4dP8cLEYRe
	5/dKK1wkpvPSW+rcbIMWgaWbYnPyqG1rwmYrMSvqU2eMuAgxAlAQgWPw=
X-Google-Smtp-Source: AGHT+IEy2h9Lv/3WyA81977yE/QNPlDFgusZ7+onp68DOwCdTvOR+oQtdUkse+NjyOVDBoqsrIzTSZb3JP8nVs5cajVEaMZcbctg
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2489:b0:488:75e3:f3ce with SMTP id
 x9-20020a056638248900b0048875e3f3cemr296968jat.0.1715001513464; Mon, 06 May
 2024 06:18:33 -0700 (PDT)
Date: Mon, 06 May 2024 06:18:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ffdf280617c8e726@google.com>
Subject: [syzbot] Monthly ntfs3 report (May 2024)
From: syzbot <syzbot+list0a6d53d08fa90971e6a1@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ntfs3 maintainers/developers,

This is a 31-day syzbot report for the ntfs3 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs3

During the period, 7 new issues were detected and 0 were fixed.
In total, 38 issues are still open and 48 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  11902   Yes   VFS: Busy inodes after unmount (use-after-free)
                   https://syzkaller.appspot.com/bug?extid=0af00f6a2cba2058b5db
<2>  5503    Yes   possible deadlock in ntfs_read_folio
                   https://syzkaller.appspot.com/bug?extid=8ef76b0b1f86c382ad37
<3>  4669    Yes   KMSAN: uninit-value in longest_match_std (2)
                   https://syzkaller.appspot.com/bug?extid=08d8956768c96a2c52cf
<4>  3286    Yes   possible deadlock in mi_read
                   https://syzkaller.appspot.com/bug?extid=bc7ca0ae4591cb2550f9
<5>  3080    Yes   possible deadlock in ni_fiemap
                   https://syzkaller.appspot.com/bug?extid=c300ab283ba3bc072439
<6>  2684    Yes   KASAN: out-of-bounds Write in end_buffer_read_sync
                   https://syzkaller.appspot.com/bug?extid=3f7f291a3d327486073c
<7>  2085    Yes   possible deadlock in attr_data_get_block
                   https://syzkaller.appspot.com/bug?extid=36bb70085ef6edc2ebb9
<8>  729     Yes   possible deadlock in ntfs_fiemap
                   https://syzkaller.appspot.com/bug?extid=96cee7d33ca3f87eee86
<9>  723     Yes   kernel BUG in dnotify_free_mark
                   https://syzkaller.appspot.com/bug?extid=06cc05ddc896f12b7ec5
<10> 141     Yes   possible deadlock in ntfs_set_state (2)
                   https://syzkaller.appspot.com/bug?extid=c2ada45c23d98d646118

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

