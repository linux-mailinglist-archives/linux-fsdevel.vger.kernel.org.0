Return-Path: <linux-fsdevel+bounces-13829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A232874272
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 23:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9542282083
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 22:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0841C294;
	Wed,  6 Mar 2024 22:08:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6311B94F
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 22:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709762911; cv=none; b=ssip8Gie+/vOqJua8koEWQ5DWQ+VcVYYBKZY9kXJkFDnb8Sy/p6SlX4jZwWkNpDn6vBc4SnPAdL3XQF9z55Hlsr7b6PykEhYMFj4Cc5imsAJJsA6P3/+x80Cd5vnx30QIHjhZznT8jUVd/GEFTC/AUHTa80mNDel8OjhKG3F+RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709762911; c=relaxed/simple;
	bh=jObsL/UNTrrOralMnNtL9QtuAbpVCZJ1k/FmyyBW5V8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kc2UtvrMHpjW4myeVx6vnigW1kaVAlylzTExY2t27PxLyXjHA5ALfp+HabKyddI8B8qLgi9BiDjNktk9VE5oTUMzg5TsZGaH0egllBvB3FVf9HepEneEhuvY0/yzfCzhPs7b4PX+ptXXuT+1f7/qoYuAKBGIdSJbWyhXJV8gTa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c7f57fa5eeso29253139f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Mar 2024 14:08:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709762909; x=1710367709;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dP5mf6ppaJeeeqDuDdgoLYu4nUp5wMZfTV0hczsj3VE=;
        b=Qe/Ok+YEA7+P4dvkxwfOtlbuCQNMKP0v2UmRkIHYL1sdT6gYyabHM0iidaQYlwFi3m
         DXwrWTDllHpp/Nag2fhiXVI4trGt+sk3dq/G8DdEjlfMa4imK/IDXrBEXlT5GV7tGxvV
         q3+WnwznEGywLBIc6sJIIKul4JB0SxqP6gsUtsxh7OUP0TIqH9k+Pw3TvZ1xaa36hz4e
         ftT8qUNP3KHHoK5zHPS+PUArj+x4MRhrr416UQrPatVYAPekfC7bHzEwkcCo833eloL/
         kb7Bn59mCyH1sJZiyNhbYielfG2M6MpRvj9N1iFBenQOfjarGq8M8Cs86FsO1SYQ3z+T
         wsSw==
X-Forwarded-Encrypted: i=1; AJvYcCWpA8Frf8Bv1/YUeAOPvbH8X7fILy0S6skQisRIUPjHsrFOKeH/STjXzdrhTPe6wRBjnIFFEONobqhsjy/6NORjbAzGHhZGOMLovzr/9w==
X-Gm-Message-State: AOJu0YxsR7V4UEEkb0TTko3G/AHsfRgpQ9SG11nGpQw+goKG7oE4a6oT
	qVan3+WVERf/1B3TGiuEPSE5n7aVAelKfWxMoewzadORnQ6T93F+lWk3W28qcc//LKkOEW2bteR
	uB3J8r/kk1aJDpgeV7YGy6n/X11yP6xNWTjoiXvmATDZwcEM/iFZAcfg=
X-Google-Smtp-Source: AGHT+IFPqSCvF/0U8pDf7pIswMxHcFHvDUPvrvqAjK+q5PYCkNfskzE7xmuQEyTGAK8OtumE6ovM9gu4ZydBpcx5uQUSMQs6fwxE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2584:b0:474:76c9:b667 with SMTP id
 s4-20020a056638258400b0047476c9b667mr877556jat.6.1709762909035; Wed, 06 Mar
 2024 14:08:29 -0800 (PST)
Date: Wed, 06 Mar 2024 14:08:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d7ecf606130532ae@google.com>
Subject: [syzbot] Monthly jfs report (Mar 2024)
From: syzbot <syzbot+list454fdd6114742843b8e5@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello jfs maintainers/developers,

This is a 31-day syzbot report for the jfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jfs

During the period, 2 new issues were detected and 0 were fixed.
In total, 28 issues are still open and 36 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1815    Yes   general protection fault in lmLogSync (2)
                   https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
<2>  1621    Yes   kernel BUG in jfs_evict_inode
                   https://syzkaller.appspot.com/bug?extid=9c0c58ea2e4887ab502e
<3>  1031    Yes   general protection fault in write_special_inodes
                   https://syzkaller.appspot.com/bug?extid=c732e285f8fc38d15916
<4>  576     Yes   kernel BUG in txUnlock
                   https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
<5>  390     Yes   general protection fault in jfs_flush_journal
                   https://syzkaller.appspot.com/bug?extid=194bfe3476f96782c0b6
<6>  299     Yes   KASAN: use-after-free Read in release_metapage
                   https://syzkaller.appspot.com/bug?extid=f1521383cec5f7baaa94
<7>  252     Yes   KASAN: null-ptr-deref Read in drop_buffers (2)
                   https://syzkaller.appspot.com/bug?extid=d285c6d0b23c6033d520
<8>  144     Yes   KASAN: user-memory-access Write in __destroy_inode
                   https://syzkaller.appspot.com/bug?extid=dcc068159182a4c31ca3
<9>  130     Yes   kernel BUG in dbFindLeaf
                   https://syzkaller.appspot.com/bug?extid=dcea2548c903300a400e
<10> 87      Yes   kernel BUG in lbmIODone
                   https://syzkaller.appspot.com/bug?extid=52ddb6c83a04ca55f975

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

