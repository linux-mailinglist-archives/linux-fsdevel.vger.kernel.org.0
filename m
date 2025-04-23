Return-Path: <linux-fsdevel+bounces-47054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2328FA9819F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 09:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD7E17C759
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 07:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B748270ED4;
	Wed, 23 Apr 2025 07:50:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F06F26FA60
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394642; cv=none; b=l3zt37zRCWSbMDbf7sHUtVyoD8Yr/UqG0ju6l+K8DbsTE7TXnano+1bcOC1mW0THR53wBiOHkGGkC2D7RQRIXrfTCi0DheBsk2xKxFEjxAJYsotOciZiIkg/3D+6X5d0cFO0Yomvr/JRMttfA48YLSt8T7mfnu5wPyfbewY8vzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394642; c=relaxed/simple;
	bh=al+frGc8+s1dm76ODqj2Z8/1RnDsvo23VzeIBR3RsDQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uDQlWKDuXNRbvhX0IHN3FACrafshJlSqkInSHO4TTsjfhDwaVytzd0y2gL6d0/ZNFVCxO9eqcYjdncub9kX+3ozI0U8tosqgFh3+35gxLX9yTrx0rJWJ2Jsq+CAmNL/zG0fFoXXODpvOahb/MkfXkmF5LVjZ2LLy8NfzR1laJmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d8a9b1c84eso70994935ab.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 00:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745394639; x=1745999439;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nuThavoLQFnNNllqB36w9iF3pcSUNQsBnPw1UbIkX/0=;
        b=SgyYTNbTLWword9JrPo4y14i+129926ts4rLZYueIIXj3Rxws1czErsEikbJVZ8fdJ
         hjPmDG+dBEVlpcrL7xl/JTnJiJxrBgZpDPAz8VwKZrB9g7qvBINoNynnP+jIB/LAO2er
         TS8tHGyLxP+y0SqRFn47sgKaTkBjY9se+5lpfcJB+Cygvlx4PX7n+6+OXyuwzjUGxk6d
         J120OF4pabZmuEHs022QTouKMmzLurx8cazWAZkheLSq9sqQaYasBSdbXYMtVjQHJ9WL
         FG2uYSU+8JzkDEkeRSMZY+EJDHzxUQYqdaxRT7Mh+nQdHdmm1ZNecLzjKFTDjeBplqjb
         aytQ==
X-Gm-Message-State: AOJu0YzKdHA+7C0YWejwsCiBP9YCykTC93cdt6srwgTOURqtzwABI3xe
	4Q95sNxPL/yBlPB0o13tOzHIKH043DoTrUwsv2GCwRnCkjX1KgjkBQwCjjIc4KufXaLEu/JoFhC
	I3fbbm5OVBHGrJxSKLXD6uQtd/ZVKiG3Hn5t109wc/9XavtH0QTu4xfw=
X-Google-Smtp-Source: AGHT+IEONT04EfO3W2Xdd6K5CAX2eA5M72ZERzdf9qHibbRkS+VeKdqg5K5btTHGxTAtSvaoucaL48YKipCxDBTpxYEEPDetZRf2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1526:b0:3d8:18d4:7bce with SMTP id
 e9e14a558f8ab-3d88ed65543mr189879555ab.2.1745394639409; Wed, 23 Apr 2025
 00:50:39 -0700 (PDT)
Date: Wed, 23 Apr 2025 00:50:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68089bcf.050a0220.36a438.000c.GAE@google.com>
Subject: [syzbot] Monthly hfs report (Apr 2025)
From: syzbot <syzbot+list4354a0e836e319a1f6c0@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 3 new issues were detected and 0 were fixed.
In total, 44 issues are still open and 23 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  74123   Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<2>  15640   Yes   kernel BUG in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
<3>  12534   Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<4>  6506    Yes   KMSAN: uninit-value in hfsplus_cat_case_cmp_key
                   https://syzkaller.appspot.com/bug?extid=50d8672fea106e5387bb
<5>  3643    Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
<6>  3561    Yes   KMSAN: uninit-value in hfsplus_attr_bin_cmp_key
                   https://syzkaller.appspot.com/bug?extid=c6d8e1bffb0970780d5c
<7>  3427    Yes   possible deadlock in hfs_find_init (2)
                   https://syzkaller.appspot.com/bug?extid=e390d66dda462b51fde1
<8>  3321    Yes   KMSAN: uninit-value in hfs_find_set_zero_bits
                   https://syzkaller.appspot.com/bug?extid=773fa9d79b29bd8b6831
<9>  2867    Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<10> 2701    Yes   KMSAN: uninit-value in hfsplus_lookup
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

