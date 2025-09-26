Return-Path: <linux-fsdevel+bounces-62853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B43BA26B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 07:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D8D81C01DC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 05:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6B12773FE;
	Fri, 26 Sep 2025 05:14:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AEC262FE5
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 05:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758863673; cv=none; b=Ou2ffDUGys2xl5CcG4wOFxoDDLfmEzjdf46Up542/6Kf5hhWdhrbAd1fOfFKVLt1LUuntWxZIHLyYcxe/+pG8jG9sb2RNRaqD/mhUwtXHieDGb02rVBEygkuvYeqYn+5NiSCpaIVsieTDDDXnYitO8XKZMHw8rdl9SKSsGPnhdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758863673; c=relaxed/simple;
	bh=lC761gkFpOQdcOGlWNPdTnK0sldm5KiE8/0aVMwxt04=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bqkDpNmEsUjmHb+/z4xVDPKEVkXw/AQ9205Ro7HFchcO4r7EQxgXrtD6uBCZbXW/SIYnaaJ34J/GRiom5rOhEsu31cPJeoLHENnlpxm0NdOy2tpQHyawV3trZYn9voRODgSqkBztxZIECKn55UbIghHTHZkHAP0fOK+PkF7InRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-893620de179so377924339f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 22:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758863671; x=1759468471;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DG8Duv53QLwynlPB4debmWfpydCbn0S0pF1aGiZ5NhQ=;
        b=k57/NUSKFK9rQ70r6Zi8YIzJuy2pJD+40HrOpz+/GFH8aJo+O0DYThpSvG6qhCnhHp
         ZqE3gzTdoDx/wXGAt5onwmUOPKEm13tw8OLNXHf/TwdI6HbwAi+37Rl17lJp1CpVZe70
         lIDhQwod8hRqxm5AFS9eKvtUZRA7lWS6/bnSv+rV7UWgJf3d4ZuPQ+2kCRw/g7CKmzTd
         hq2v7UeqgTots7TbVbQfkhpmObCHuJmBh7eoJoFpv/UKnpdTd9WUDURMtysS475EVzDA
         +7SQF9cQCRH7JsNHVGChjWtSh+8amqe1ka/Stp/ZBV+0efQZ89UG24SePLVnJYJbstID
         aQ+g==
X-Gm-Message-State: AOJu0Yz/FpjK2oBRZXyC1DmPNObUPu5jKCQHzOAMXX4YmqkGNm8T83cB
	niBDmK9ENCZ+5Wg0gfpsA5b5tvrWhIzsD4kl4iEpN33uF3Id7vtE9BS7jTsIUEdVS5zjOmGtKY7
	d6fVelINmPjImK9GnPDsV0drRJ99YoLatsfVCuMetGd9zZpG1VRCY6iMK5k4=
X-Google-Smtp-Source: AGHT+IELGfhN0y0KKDaSMd9rjqVPYY0bokUyRgxktBIKZ0Q8NPzeQeOSQfb4BnmJZFw6DCMeYez/tARdzr75t5UHET0GkAIjTV5A
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1609:b0:424:7f5a:9423 with SMTP id
 e9e14a558f8ab-4259562f38amr85226455ab.19.1758863671182; Thu, 25 Sep 2025
 22:14:31 -0700 (PDT)
Date: Thu, 25 Sep 2025 22:14:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d62137.050a0220.3390a8.0007.GAE@google.com>
Subject: [syzbot] Monthly hfs report (Sep 2025)
From: syzbot <syzbot+listc1009fe7bea3a4e7174c@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 41 issues are still open and 25 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  13773   Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<2>  10556   Yes   KMSAN: uninit-value in hfsplus_cat_case_cmp_key
                   https://syzkaller.appspot.com/bug?extid=50d8672fea106e5387bb
<3>  5157    Yes   possible deadlock in hfs_find_init (2)
                   https://syzkaller.appspot.com/bug?extid=e390d66dda462b51fde1
<4>  4862    Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
<5>  4680    Yes   KMSAN: uninit-value in hfsplus_attr_bin_cmp_key
                   https://syzkaller.appspot.com/bug?extid=c6d8e1bffb0970780d5c
<6>  4208    Yes   KMSAN: uninit-value in hfs_find_set_zero_bits
                   https://syzkaller.appspot.com/bug?extid=773fa9d79b29bd8b6831
<7>  3496    Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<8>  3491    Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
<9>  3140    Yes   KMSAN: uninit-value in hfsplus_lookup
                   https://syzkaller.appspot.com/bug?extid=91db973302e7b18c7653
<10> 2635    Yes   possible deadlock in hfs_extend_file (3)
                   https://syzkaller.appspot.com/bug?extid=2a62f58f1a4951a549bb

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

