Return-Path: <linux-fsdevel+bounces-37876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3928B9F836D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 19:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22531188ACBF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CBF1AAA34;
	Thu, 19 Dec 2024 18:39:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1776A1AA795
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734633563; cv=none; b=IW47hgln8lFazJNnl0d9/iCWkDYPV9mt/PnaeoH+F4CjoLnsVANVNOyRzmZo0ciNsGcpIi6rYBBaUUqOIMOlIMsL5/zG3p91wSsf1mkfJHOOCZhl48mIuVaRIZtO4fwZJGFlo2OqLnqzlc2GZZ0oNEKSQUykrYaLWPzbQNoO4QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734633563; c=relaxed/simple;
	bh=U1Uiegv1ZCct7k2+fvSUzSZtJGd1SAHqs/owApShhco=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=k56hkKI2HlsMfOBT/XMhHxICkvCYDWEQ61gDx6wYfdci2DgOSPPFgh0AbJ+s2vgiDBEzHgV6kPV4lkH9tyScw/1OJITHY5wkL+aUXg3reWzPWsd0lJWv52FsBqlM6MUreW0hs8zJdbNZh+9LPZ/pfwNhIBOuOh0wXTIr6C+mO9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-845dee0425cso90773139f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 10:39:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734633561; x=1735238361;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/CDzv1PSPwjXGx+dM7QMgYslMHLNIYGCNHyyf7EERzc=;
        b=Wslayz2ER7zrFbo1AnA12qACfGkoOUcBcYvearQZImnTU48mK8hwZbF7zFw8MStJl6
         Sk2lA9zvQYUWLhjpJW2Qxwcd+z7Neh5IxDY5kHcswChqB49HIFRqmDApAxQVv0C1nvfH
         BKRx+Yli1NxoTLCJr/oCNxh+bwlgCtB9axyshnUKEMSiW1yselCFwSl5s28kka7Y7Wx7
         NKiuuv+MQuNMU5/Lr52cgDyJd6UauYRAqXfEcAsgT6d9LgNVP4AV+LNyPLSHJBCBYdEh
         J5Gs1tzyiq8AS1CF2tcL+9VCiRlduHTmmV+YXRERjWYDNqxi0wY22wGPodB1TudQojKi
         8AEA==
X-Gm-Message-State: AOJu0YyRsee2iqlSwdy2Q/zFkWL0woBIeMahxttbDgn/pxy/slBuJqrc
	zF/o9cm5vWHOUdvEAln8LbWNpdzoT1dQhq8p/2D27N/UL+UaRddKi5+TwNjPTCNwjcqloemyRwn
	hpwWJh0mvbj1K173om4rsS5xqNQbaSoTTqZC10oUJS1CIskNeZDY8Hq4=
X-Google-Smtp-Source: AGHT+IECwR3Fdj7t7KRiwon0ybqbRErDkk6EIDXR8FSpzw7wBBZZYmfD2PThhLYSrcWnIC2aqeOSSe7adfL46H2dmvxrgtldE2cZ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:7289:b0:844:e06e:53c6 with SMTP id
 ca18e2360f4ac-8499c229208mr61364439f.11.1734633561312; Thu, 19 Dec 2024
 10:39:21 -0800 (PST)
Date: Thu, 19 Dec 2024 10:39:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67646859.050a0220.1dcc64.0020.GAE@google.com>
Subject: [syzbot] Monthly hfs report (Dec 2024)
From: syzbot <syzbot+list2d8c80c53431a947568f@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 2 new issues were detected and 0 were fixed.
In total, 44 issues are still open and 21 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  11793   Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<2>  11502   Yes   kernel BUG in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
<3>  3398    Yes   KMSAN: uninit-value in hfsplus_cat_case_cmp_key
                   https://syzkaller.appspot.com/bug?extid=50d8672fea106e5387bb
<4>  2388    Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<5>  2260    Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
<6>  2202    Yes   KMSAN: uninit-value in hfs_find_set_zero_bits
                   https://syzkaller.appspot.com/bug?extid=773fa9d79b29bd8b6831
<7>  2121    Yes   possible deadlock in hfs_find_init (2)
                   https://syzkaller.appspot.com/bug?extid=e390d66dda462b51fde1
<8>  2002    Yes   KMSAN: uninit-value in hfsplus_lookup
                   https://syzkaller.appspot.com/bug?extid=91db973302e7b18c7653
<9>  1806    Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
<10> 1800    Yes   KMSAN: uninit-value in hfsplus_attr_bin_cmp_key
                   https://syzkaller.appspot.com/bug?extid=c6d8e1bffb0970780d5c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

