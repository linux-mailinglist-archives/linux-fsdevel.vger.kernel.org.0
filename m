Return-Path: <linux-fsdevel+bounces-14803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B61387F856
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 08:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57537282A40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 07:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708F053E28;
	Tue, 19 Mar 2024 07:26:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DDC5381E
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Mar 2024 07:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710833188; cv=none; b=hmeWzZeVkkUe6EVPB3J1auCkjVN6fxDVx3nV/x1aSNGJY4VnYjGHzGjVhBpWQ7mq6MvlZgV1GkLsnzlUzYVb0d7jKX6k+HZ7tN1iiUnC3ECPNKvHFErie828srDK9GlXJEakGCzTYQr9kVCjcyMPISxpuMwN8EF92y058YM6+yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710833188; c=relaxed/simple;
	bh=wI1T0EzdWk+Ahj6218/EOyE9S19iLjzHRDYJ+5toT40=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=C3RfqZ9OgHUYq2ApOvjYhhUc/2+7TGCZj6CHph13ylZCb0w2McGha6qNsJNV5x4ytN1EFcQZN0HWqEYRPENXpxX8p6UiJVwozxG8iimUdm56mkTv9DJtqE/gQCNn/VNVMK6OqfsDxnJZiBjdx5oFWg1gG0Nz3qB/Ae+i+Kf11cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36660582003so74521995ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Mar 2024 00:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710833186; x=1711437986;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EWwA4gt2QV2ljMc7dh01T3FMCTXDPFNrXBsk1q+DFxU=;
        b=qa/qSbUsUHPl8sSI9fP0l6bjr7Wy4FBGlp295ed49cJLKJ9UQwFGcWhPDvdhH+x2C3
         sMOV4Ou472fjBh31YBBClD/iK4VL7BF9fX34LYsGR16NjBvC9J6A8ccsiLUDbq/ovDCG
         cU4hPOgmklXvYbYdMht72bNOmUOnaK7cCkr91HZ05MeWvN2jDHVhmWrQf/8NMX3vsjYs
         Tn8CJEYWRW0EE144QuCIbs0sKSTFyCaYBN6MQk3uH/eJyPqLtI7cX074oVBHbKhzzhu7
         WAre3VuLvb5K7xHxVwP35oBfwuucqfaSbAA+1juKjyxQfEplR6cCaICMEhEZbWJGu4qp
         gMNA==
X-Forwarded-Encrypted: i=1; AJvYcCUepwuqgCWEMojHPiRSqAKhyGbtlIoLMmari2ZHM7ve5Emm0EInnPP+ZIEY8gwkleS6CJ6/eZwwVMXaonaBDJzsF0HOGB6+sb9YETBa8w==
X-Gm-Message-State: AOJu0YyuGR9gqt+evoUNhW/Mi/ZqGJPNWH76dH9oITlOlsrFS3j6kzmD
	3JceIGhE0ukOjgNCsC+YlXY0RlRjMRMcv9PIgMPXRtd5EhbvFr7QWoqIQgN265+EtRmrAwCucg0
	C0NiOZt+1s0z2qrDD8ipUl+wGm4d5PUpvQ/X0SyGjYuBKNC43+zEWWY0=
X-Google-Smtp-Source: AGHT+IFtYdMhgryWzdomQCSC8tYxXzyfdXIUYNX82HD8z/KnQcHKQ+ghCeUabP4SxoSefeK7v0plabTaWXIqe1UgCvUuMsNeDBno
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164f:b0:366:b4c8:2150 with SMTP id
 v15-20020a056e02164f00b00366b4c82150mr59828ilu.6.1710833185908; Tue, 19 Mar
 2024 00:26:25 -0700 (PDT)
Date: Tue, 19 Mar 2024 00:26:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050fb620613fe6483@google.com>
Subject: [syzbot] Monthly v9fs report (Mar 2024)
From: syzbot <syzbot+list27b848ebc739cbe61649@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lucho@ionkov.net, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello v9fs maintainers/developers,

This is a 31-day syzbot report for the v9fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/v9fs

During the period, 2 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 26 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1814    Yes   WARNING in v9fs_fid_get_acl
                  https://syzkaller.appspot.com/bug?extid=a83dc51a78f0f4cf20da
<2> 273     Yes   BUG: corrupted list in p9_fd_cancelled (2)
                  https://syzkaller.appspot.com/bug?extid=1d26c4ed77bc6c5ed5e6
<3> 119     Yes   KASAN: slab-use-after-free Read in v9fs_stat2inode_dotl
                  https://syzkaller.appspot.com/bug?extid=7a3d75905ea1a830dbe5

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

