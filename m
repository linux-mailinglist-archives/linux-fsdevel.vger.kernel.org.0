Return-Path: <linux-fsdevel+bounces-52776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A8DAE6744
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 15:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33FF27B2060
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 13:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D472C3774;
	Tue, 24 Jun 2025 13:52:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F07C2C3264
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750773148; cv=none; b=FzbHVW7us2J/5ybiTvZ+vCSZoN6NcO/qNS/sxxav2RrZD2SKq5OR73J2BN+8qJ8SppAFlA7BD66oZxs55BlOHHEVaXKQFYqucyAH4OSzHuZvHM9CzigrOPCOYPVQPBOZGuRBi8xcUpS6zA5oSavpc9ieJvJFypWrQ6EZWr6hwIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750773148; c=relaxed/simple;
	bh=oXZ8co1e8mmwl9zX6KlK8xWZmne+5OdHNz2El37jtVM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OwDM4mkuqXRjnGWGCYiqUKhW0ZNljhDEvS0JZ6QsK5vKLii9o6cQ49vNQ9oSg2Y3j8DEFQ/V1eFiuH5z7QW9z0RqzbQgsntw34qboZAvrAt7iB8HxxjndiM6g4tA6DdJaRwd8YDqpvnf4FGX6nEwVmPbdepB3V9okexwDjB1AZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3df2cc5104bso10123655ab.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 06:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750773145; x=1751377945;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uin6lLcwohm4lv9WyITuwcyVt/c+X4e6jvHm3Unx2MU=;
        b=SLXGCVQFPvCkE5GYu21TE/Sku1FsN2MZmHSNHJ/myiitq3FXchcbUEEf4LsVnTiScE
         +zt60/5jPm8IrsS+HcjA9vxiDGphSWBd0dhEq9ak3jp6pvPFNpbW5GAxrkTYFnZJuQes
         rOIpgoNX7DkssxvEu9Fay2JBybw/M3pXw54DBl/rw1wCep+QKoUl8I6VZmosXN+2vH71
         PoqLr2rwdkkWrLFKI18D2AY/vnVZt4h7UQ3BtRnGMdRRvhkr80IM3Y4/A3K6fJnyDqDB
         97Iz7QlhogTaRCCvtmWDo2jCYRzE8mkuDW3Aac0PLSX87FB+2VIpsFLfHd4xd+PlaN0M
         b0mg==
X-Gm-Message-State: AOJu0YxaxatCfKs99VpoyBhNGWHeX1y44H5EClrlMLtceXmDgyjpaPg4
	nTtO/McbAtoSFTsXv2xD34pWehbZDq9I4EKc4bDZ17eJZjk+4P+1r2TrR1RDt7twPSBq0iN4sit
	bVudw2VEv8LAbYWSueWTrN/jrPW9MY8AyPzc7vlDseWapydvtOSP7FbnTRZE=
X-Google-Smtp-Source: AGHT+IHvKvf/vVCdxwI030nwml5wrDQ6tlpXgTpPK6b9n0FXCh1L+iUC7/Lp70pNFIbf6gAfOug2uCJ+XPGVXDcG1bXFt78OzyPB
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2b:b0:3dd:c1ed:d901 with SMTP id
 e9e14a558f8ab-3de38cd92b9mr212604135ab.21.1750773145639; Tue, 24 Jun 2025
 06:52:25 -0700 (PDT)
Date: Tue, 24 Jun 2025 06:52:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685aad99.a00a0220.2e5631.007a.GAE@google.com>
Subject: [syzbot] Monthly hfs report (Jun 2025)
From: syzbot <syzbot+list8132deb081c630ffb070@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 46 issues are still open and 23 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  90790   Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<2>  17637   Yes   kernel BUG in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
<3>  13270   Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<4>  8079    Yes   KMSAN: uninit-value in hfsplus_cat_case_cmp_key
                   https://syzkaller.appspot.com/bug?extid=50d8672fea106e5387bb
<5>  4225    Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
<6>  4084    Yes   possible deadlock in hfs_find_init (2)
                   https://syzkaller.appspot.com/bug?extid=e390d66dda462b51fde1
<7>  4039    Yes   KMSAN: uninit-value in hfsplus_attr_bin_cmp_key
                   https://syzkaller.appspot.com/bug?extid=c6d8e1bffb0970780d5c
<8>  3875    Yes   KMSAN: uninit-value in hfs_find_set_zero_bits
                   https://syzkaller.appspot.com/bug?extid=773fa9d79b29bd8b6831
<9>  3134    Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<10> 2893    Yes   KMSAN: uninit-value in hfsplus_lookup
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

