Return-Path: <linux-fsdevel+bounces-42065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73063A3BE38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 13:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1834B162B9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 12:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA4E1BC094;
	Wed, 19 Feb 2025 12:35:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606BD1DE8BC
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739968523; cv=none; b=DieoynAzdz7F/WvHjlCSRw+tl0sqvHNdlj8yhN/a9oNfGTLWg7CANY4pQfw+rCz04wAvv2uCsAWBLYlaXi1NgwcGYQDuht3m4ZwQlJXwjl1fFJxd6h7hfPJ5ErZ8gEQ1qt9ZEU3hCdhQQHoPZqoVBnkTWz/PLT4U2Wf+yQXubwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739968523; c=relaxed/simple;
	bh=j/dc1VpWzAYMng4cMhn0zh4R4rf3LGP1QYSyVP4Dl5Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=knutdsNnZaXk1QMdZwImCnNpTwWLEe++tv/mKyBwbzVHU3uzdGorUf+s7x2bvzT7cWX2gnsC+q4pSkEvlKp1ooKqjK+65mjzQmAKIE6MPDMZDt0atPHpN4YSuXQVzpn9AwE70S1w5XGq/Q41mByYQeKiEaQbhBIMHcqsTOOq1wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d2b1e1e89fso11008595ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 04:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739968521; x=1740573321;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bkwiZ0yOIfJpjcP0g90Xxcuz3evpjUpvvJsCWnN10IA=;
        b=K7hD96CxqnkDEVr+rKZHLa2O+7Ch+EVtoSYlaSo+Zt3dx1fgY/6YZnbA7kN4P12eEW
         2E+XtVXDlLSQ4QKZ1CpbU/G7C744K2W9a6wFY5P2kx1fuYFMSt4tU+1WxKIxcfuXoa7t
         51UVUrtmqMYfJTDbaUc8xe9BDmL5vvggVBAzNNa/a4J1J0ENfuMSzw7fMi17PLFRwT/3
         wr5yenTZu2kyhNwE2ANW8viYvdbUWvDgBV01uQcTL2n2KnKGYCqjAJQnPSiq/2VYFzmP
         mlUB/YyoGUnlAm3kw5LdyYXccRO42/fh+K9ysakFE/YNpWJqVMPzxewEhk9U+Eo5EWvZ
         ES9g==
X-Gm-Message-State: AOJu0YyhmMgKqcX2z/EF/TSzcsQDKi2nJnZ8UviUqR+/H5TtohD5qqoD
	cbJVafskzeAej7CrYnWt1cCdu8lNSrAJblA9D2VtISXlhPQldusvJsWm48tXyTVlb3D5bbqniuu
	iN4xUfol80x45uYoLkoO92ZUIf5Q2bxUNkB8TByvJU+esvZCS9rqFD9E=
X-Google-Smtp-Source: AGHT+IG69LGDutTU11/v/OdTOcXCteXA3LgdwC79Z9Ktipmm6KW2i65mTGy2RJOLEYuFyiVuvYS65W9Cvh6r+DgxZtMYRzl1aori
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2181:b0:3d1:4b97:4f2d with SMTP id
 e9e14a558f8ab-3d280763f51mr132538045ab.5.1739968521525; Wed, 19 Feb 2025
 04:35:21 -0800 (PST)
Date: Wed, 19 Feb 2025 04:35:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b5d009.050a0220.14d86d.00e3.GAE@google.com>
Subject: [syzbot] Monthly hfs report (Feb 2025)
From: syzbot <syzbot+list3025ad65a9369424c0f5@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 43 issues are still open and 22 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  58216   Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<2>  13879   Yes   kernel BUG in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
<3>  12134   Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<4>  4961    Yes   KMSAN: uninit-value in hfsplus_cat_case_cmp_key
                   https://syzkaller.appspot.com/bug?extid=50d8672fea106e5387bb
<5>  3014    Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
<6>  2963    Yes   possible deadlock in hfs_find_init (2)
                   https://syzkaller.appspot.com/bug?extid=e390d66dda462b51fde1
<7>  2775    Yes   KMSAN: uninit-value in hfsplus_attr_bin_cmp_key
                   https://syzkaller.appspot.com/bug?extid=c6d8e1bffb0970780d5c
<8>  2732    Yes   KMSAN: uninit-value in hfs_find_set_zero_bits
                   https://syzkaller.appspot.com/bug?extid=773fa9d79b29bd8b6831
<9>  2560    Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<10> 2430    Yes   KMSAN: uninit-value in hfsplus_lookup
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

