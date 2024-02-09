Return-Path: <linux-fsdevel+bounces-11022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976C784FE18
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 22:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C7B1C2276A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 21:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD1E168C2;
	Fri,  9 Feb 2024 21:02:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A5516426
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 21:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512545; cv=none; b=NqqOL9OZCpio83FvhwXKtzqjBUrJCgKc6pWy3+ZyzriyechYVnt0QnN+I86FIGY42jlb8po2fKURYtTAXENAM3E6F3JXOFRDSMWgLr9xRxrBQPfQ9JsCSJjdJurMPhmjEKjlTYNv5wVbomqAUYNVRc0RIo+zlYwv3LOgVXBfFe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512545; c=relaxed/simple;
	bh=WgibBrlU6T4eXUzDVCOSNWEs66Aa9oXI/mZ3GDgnatM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dIQC420WVAiHZSXKXvPuKmPUS2te9Fqj5AYizCLVHB/mYgDDVllYSkFHi4iyuZV2CO+wl3HEBAmlalPfvuogwvNPjVSpX2ZXYrcHjMCBqiQx9TkzmsQZmpdHegZJRjXKGpl3O+uk7A75DBTAYzaepfukgkNnjaP8qRYoLh6w360=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7baa6cc3af2so159930239f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 13:02:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707512543; x=1708117343;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wwAHi1OEwvXZHPw3U8Gj0Jg3whTACRFUm3C58cyAxvU=;
        b=V+59gnnjdb1J7/ubWTC83L+Q0sKKKJDq0XnSAp5EHNyvpDfqzgSh2O/GXYseWseLLk
         tM4hAv+mrno9a1sGDzM8Ru2slTaSCM4wPnlbefS8ihlj/nEy12LERt6WOmzvA00YisSl
         K4xrS88TeuVL/GA/k7MwQzWF3scteIM7Xyb6848Kx9iqDWdUHd2Exm6tsScCkuoJnTip
         VtbqqSNK3GwtK8gu9220vwJbGed29U7V2V+BzUyi+A6amS94ZWMMd1Y0W1hG9BNA6RKr
         wEIe1xewyTGB1bAO81M1UUvYwut0m7MgNUIZkXxVbsKCiG7UtzTHQ7cXe55BijFRIRSM
         Fbhw==
X-Gm-Message-State: AOJu0YwpRYL3P35sBU86jmGBrqyxxOtgHguiyEWclJyzHljFvoznc13I
	eAkW60KA6BechCMOHwG48DKkTCckk+6k+Z/Gt5+RLCCzkDeSo3rlxRN8LrghcrWnRXIsLm1mTFB
	froMkA5BEbGTINclDwEU7dkPb4sYTWL0CJLzCkOjSAkuT5PwkL5L7b1H1VQ==
X-Google-Smtp-Source: AGHT+IEJ1RdOjMEXNe5nhfHDVXltpGOM2ZcLzIybheZvNYUgA3JWEHeljE5m0jau7MVy3DQMEKmIfwXVFwx1HJPKH9mi9Y64sfWi
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19c8:b0:363:8f57:27e1 with SMTP id
 r8-20020a056e0219c800b003638f5727e1mr21907ill.2.1707512543325; Fri, 09 Feb
 2024 13:02:23 -0800 (PST)
Date: Fri, 09 Feb 2024 13:02:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009837e30610f93e95@google.com>
Subject: [syzbot] Monthly hfs report (Feb 2024)
From: syzbot <syzbot+list132bd40b722d4af2d2e4@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 5 new issues were detected and 0 were fixed.
In total, 45 issues are still open and 14 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  10190   Yes   KASAN: slab-out-of-bounds Read in generic_perform_write
                   https://syzkaller.appspot.com/bug?extid=4a2376bc62e59406c414
<2>  8514    Yes   possible deadlock in hfsplus_file_truncate
                   https://syzkaller.appspot.com/bug?extid=6030b3b1b9bf70e538c4
<3>  8170    Yes   possible deadlock in hfsplus_file_extend
                   https://syzkaller.appspot.com/bug?extid=325b61d3c9a17729454b
<4>  5127    Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<5>  3291    Yes   KMSAN: uninit-value in hfs_revalidate_dentry
                   https://syzkaller.appspot.com/bug?extid=3ae6be33a50b5aae4dab
<6>  1866    Yes   kernel BUG in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
<7>  879     Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<8>  764     Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<9>  685     Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
<10> 635     Yes   WARNING in hfs_bnode_create
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

