Return-Path: <linux-fsdevel+bounces-29465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C185F97A246
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 14:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AB61B214BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 12:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A701156F57;
	Mon, 16 Sep 2024 12:27:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487841482FE
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 12:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489649; cv=none; b=BQoWYTXjGcAiCnEqk7B9oTqpogH6gOWlR1hoK3+FZqryUSA+RgR7HrC0C3giBfVi/hwJ+/quvJftPTaubDw7mqrWPiApZRxe9P8ORV/sMe0yDbcO1uJYeHIO+cOpz3Jtma7qp5IvLzfAdIpaWlEm3R5dVKJY2uNsEkIWcKaGgKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489649; c=relaxed/simple;
	bh=lf2e9G4m9LHQDG2Z8itTjQUxbHpKuBucViTMkcoDylw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LuzvKoRVmnZtjJJYYR8irJ3xRE4xy5F40RSU7QAE+lGSo2tF4l6T3IgfEk3eW2beUJRFeKeIyFGuad4ALohITQTTzUKsKS8nE1M3KyX106P7hrunYpEdFPxaZ9mSTw3cODiXZPbhGim1ygtAK/xTXS4zgZUKrUoyrQXgCjpE4Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a049f9738fso75531515ab.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 05:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726489647; x=1727094447;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qi5D0eanag+kLndYIYZyyV36JDeC0WoGWF/seypo7ts=;
        b=T63ZQup9W7MTGUGYSL64NnNFct/SWLUwVusjvE6uT50I+B+urSiZppHIBxl8V4910W
         ZyYipLHtgEcs0RtXTZipeXrp+K8CZPZmxyspfaJP6U5lFY82mmDf96d+44yiJTFWCLZY
         nB4jAHnU2PBY7Eu6MMJFhn48OOjkQXPLUM0azABx84DURVDa8jdeyx/E2ZWj8V/HkINZ
         vdJRxOf4wCzYTK6G2TqQLTraVh/Q5yAjcnyxUTr9wpeRturCfV3wmDm0sbkphvtxwP3D
         UFkm3rAyqf7GF9WFJgGADtsdUTkBCcDODqd8mgfwgVD7Ho7M0D91wdPcpjXP+87w/3Wf
         CJnQ==
X-Gm-Message-State: AOJu0YyQGXodgcA9gM3LqsDkbiBgY/3Bjqrpk/DHarOvarvyhSNcGlDB
	C+u/PGsPtmysaVvAxYQU5LxHmANUF2zEXfCppcGMr/Ayenn22/W992KBLsJYY//BSnxLRlDXGeO
	qZShaLhtClah1YlV6u90m8spKghUmNeNgSj6YjNpjkTrJbc4dDO2Xrx4=
X-Google-Smtp-Source: AGHT+IEaWrrLxiRVgyHQIe7Q64+XwrUMrV2wKU5O1jJer1HOI58RewyO9237m2wxuCSLvvYsnjSlQe4HwjkIy78DkRN1ReH2Zfo2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd86:0:b0:3a0:9c20:8070 with SMTP id
 e9e14a558f8ab-3a09c20814emr51780125ab.20.1726489647409; Mon, 16 Sep 2024
 05:27:27 -0700 (PDT)
Date: Mon, 16 Sep 2024 05:27:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66e8242f.050a0220.252d9a.0002.GAE@google.com>
Subject: [syzbot] Monthly hfs report (Sep 2024)
From: syzbot <syzbot+listf98106da71c1298aedf7@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 40 issues are still open and 20 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  16975   Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<2>  11132   Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<3>  8000    Yes   kernel BUG in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
<4>  4040    Yes   KMSAN: kernel-infoleak in filemap_read
                   https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
<5>  3249    Yes   WARNING in drop_nlink (2)
                   https://syzkaller.appspot.com/bug?extid=651ca866e5e2b4b5095b
<6>  1704    Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
<7>  1637    Yes   KMSAN: uninit-value in hfs_find_set_zero_bits
                   https://syzkaller.appspot.com/bug?extid=773fa9d79b29bd8b6831
<8>  1634    Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<9>  1497    Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
<10> 1348    Yes   KMSAN: uninit-value in __hfsplus_ext_cache_extent
                   https://syzkaller.appspot.com/bug?extid=55ad87f38795d6787521

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

