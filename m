Return-Path: <linux-fsdevel+bounces-59162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C169CB3550D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 09:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C16680657
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 07:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693F82F7444;
	Tue, 26 Aug 2025 07:13:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9161B19FA8D
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192416; cv=none; b=I81nXymMaqE8RlBigmoH7wXnHoBozQnyFc0fDl48xF8GTUGb0jllponmnwuNZrS2EIySypPT2w8Nl+KreLiIZzeta84KFMJojmliliaBAsytWZbHiHXZq+hDZog7WW4bsGsRw73SPIOBh9ZVtAPsa0u0pOM2f9Byg5Mx7QDLMjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192416; c=relaxed/simple;
	bh=1FuBkqFIabgtFYenvUjjzRPxZoBYerHuUXc+RO9orlA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jVB78mu39s+QCBFWrdNxz11LjZ0W5PC2DdJ+R+hKFHZilyKQZdAlPBXvAeZhesv3BBnD/TZe7cqeNghynsq8kPpYSWJPsjbu21tKPc/rIcRPtjcLyUXAC9xv2zEIcdQpzkMH3bdUh210aE/odWRGXgvsRfLCN8sFq4NgBDN9alA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3eab737b99cso26304025ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 00:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756192414; x=1756797214;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jPUJLTCW+VGEQ1LsWf3zUxjP0zIDrdC0uYjAPHNBV3A=;
        b=Z96uVBjCWv2IDea09K+6zh/dXeo8/7eds/t3e4QWAHpUBQXhtTMvhWOYot1qpE5a8v
         FlwQZqYBYw/5LoOTVLZKQ5i5awHGzfFH/sgPWVTGRWofX951hMK6i4NEMgTo6BC3N9y9
         6bovHuriMBhmri2bJB68p+F0xZzvnZO93/oAC+ML9UigG6X2DFAGFASn6l5zLnbjqvnz
         PA/3LODljhjd7YzvuOTlbOU7LK9i4++teUe7d7QwDpRnU2d/pdO5LEWIA4f1Pl296mcC
         dG2eg3q2Dn1Agx3Vs57zFcN0prvAxRQWkqkJV48ihj1Nrk22CyxdBHYrw800bxVsOqKW
         TcBA==
X-Gm-Message-State: AOJu0YxwA4lE9RwR9eC2eyKwohHiPTe0FrheJQJYy87E374SjbjG2pLq
	EnOr+qLQHlPed4E/RA+m+afji/oa9A/txf/3DiFLcb4ct0a1IrAFY1d+AHeHVhN5hAwICn4SJmZ
	mO0rQ1WOuKmOqj7PJhmGv6gH960WpDJ/tpeGEhAzdrZVzkYiZxbWdfdkbx7w=
X-Google-Smtp-Source: AGHT+IHkx0wZd2J60BKpDyIXDeNnPSsA78PqWlgb4F6xOsewL8rjHw4CMigtGvTSdkNr4EX8nidVXCZByFsqispjKvZQY5f+A6pX
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c268:0:b0:3e5:4631:54a5 with SMTP id
 e9e14a558f8ab-3e921f3be05mr243600775ab.18.1756192413798; Tue, 26 Aug 2025
 00:13:33 -0700 (PDT)
Date: Tue, 26 Aug 2025 00:13:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ad5e9d.050a0220.37038e.00af.GAE@google.com>
Subject: [syzbot] Monthly hfs report (Aug 2025)
From: syzbot <syzbot+listc4fd87023dbf3e7eff58@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 2 new issues were detected and 0 were fixed.
In total, 43 issues are still open and 25 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  106342  Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<2>  13601   Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<3>  9699    Yes   KMSAN: uninit-value in hfsplus_cat_case_cmp_key
                   https://syzkaller.appspot.com/bug?extid=50d8672fea106e5387bb
<4>  4816    Yes   possible deadlock in hfs_find_init (2)
                   https://syzkaller.appspot.com/bug?extid=e390d66dda462b51fde1
<5>  4627    Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
<6>  4377    Yes   KMSAN: uninit-value in hfsplus_attr_bin_cmp_key
                   https://syzkaller.appspot.com/bug?extid=c6d8e1bffb0970780d5c
<7>  3343    Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<8>  3050    Yes   KMSAN: uninit-value in hfsplus_lookup
                   https://syzkaller.appspot.com/bug?extid=91db973302e7b18c7653
<9>  2736    Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
<10> 2402    Yes   possible deadlock in hfs_extend_file (3)
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

