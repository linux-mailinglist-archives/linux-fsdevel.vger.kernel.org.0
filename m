Return-Path: <linux-fsdevel+bounces-39655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFC5A16807
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 09:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5623D3AB1B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 08:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DBD19342E;
	Mon, 20 Jan 2025 08:15:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B0C191F8C
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737360927; cv=none; b=kk6qUhYSJlXU6wb2CdFfZpazwYPnqNpCxcHSGxYXPOtJgUNKze6+oDyiMY6282713yBgtlQqa1AqY0x6lQPTSrs3LBjj2DIVOg9djBJjW26w7belGDfeIOgz1XbOmOLhasZGXfqqx53qo8bKnc2XWMR5j0NWsg47mV5vLFO7h9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737360927; c=relaxed/simple;
	bh=1Vq5+hEFBXUQX9wmmrsDY25TAT8bkyF7zHCzS6rBMo4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=t/3uslJCBOyr5H3qJpADNZuQuAIw6nYVtiCVy4rYruCZ1vMVxWUL0ZFliuHxCPRtNrlHZ7sUrBI0ECgno5uyHXUDxNgDa8hOUU2D/M5qynEevZXnWbefc/4OJ6oHZ6MYMa92p8y8z+Kz9sn1YCh+BehcK83GOhbzk4XPcPbDQPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-84cb447c2faso315439239f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 00:15:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737360924; x=1737965724;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8qeYRR6qXC/owm5m1kkPbUarIY+/FaOGabt8nYyW0D4=;
        b=JR5oIhXoorOZ39chxRPNjDNoWe4QzwU8pU4MXQfZHE1vQtp7FnsNAsEewJOevzyKLE
         IYhclPBM4sz2HfXyCdtnHZSUbnklm/eDXh3gecSUu+cbnXJy4LM2etEP9IBgsj2lC5E6
         LiVHKJaxSvo4U8NGSqHsFNxVvqS3RPsAJNom1SMS3yOsqHNKytpngcfnxbCmlrJ6uNRE
         PkMdAXXn/dsanT7MTTk9izVcoLHW09QiCju9ekZ21Jyn4C39hWZBlBxcN9S78K9Lr+g8
         nQ8asIBJ+P3BBKI5HNwHkNVsdtp5oIS/FEXrkJzgU/XrUfd9vdlxSbY6J7jjWm7xZHBq
         t6yw==
X-Gm-Message-State: AOJu0YwzOiHEHYWEvzWRzdMmdAGSlW5XpEzfUcEvHkwIWctPLJq95MES
	+XCPeh3pXZliRNTTX2iFNO7xCzh8+ZtllpYuxuFsbud+j9L9d14UVMjnOi63yfRSaHPClv5ApvI
	Q0Ro97ClReogLaBWTmMhvdsic+tHndI5bwWlqYAkws1d/zRDAaSC7g4k=
X-Google-Smtp-Source: AGHT+IEBU92F2kM5KouOai5/3GaAhFuD+9bLfGFOJGc1GG9NMU9UkwEVV9u4S9ZU/t2Znnrunkg6uNBP8xTSy7NbaHzOFctEuUeP
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca47:0:b0:3ce:9091:b1c0 with SMTP id
 e9e14a558f8ab-3cf743ab638mr98377015ab.2.1737360924357; Mon, 20 Jan 2025
 00:15:24 -0800 (PST)
Date: Mon, 20 Jan 2025 00:15:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678e061c.050a0220.303755.0071.GAE@google.com>
Subject: [syzbot] Monthly hfs report (Jan 2025)
From: syzbot <syzbot+list6b6c0ded30f354a11c3c@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 45 issues are still open and 22 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  50656   Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<2>  13133   Yes   kernel BUG in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
<3>  12001   Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<4>  4274    Yes   KMSAN: uninit-value in hfsplus_cat_case_cmp_key
                   https://syzkaller.appspot.com/bug?extid=50d8672fea106e5387bb
<5>  2638    Yes   possible deadlock in hfs_find_init (2)
                   https://syzkaller.appspot.com/bug?extid=e390d66dda462b51fde1
<6>  2500    Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
<7>  2483    Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<8>  2461    Yes   KMSAN: uninit-value in hfs_find_set_zero_bits
                   https://syzkaller.appspot.com/bug?extid=773fa9d79b29bd8b6831
<9>  2358    Yes   KMSAN: uninit-value in hfsplus_attr_bin_cmp_key
                   https://syzkaller.appspot.com/bug?extid=c6d8e1bffb0970780d5c
<10> 2228    Yes   KMSAN: uninit-value in hfsplus_lookup
                   https://syzkaller.appspot.com/bug?extid=91db973302e7b18c7653

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

