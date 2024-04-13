Return-Path: <linux-fsdevel+bounces-16859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3E98A3C39
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 12:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9F81C2117F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 10:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471973D977;
	Sat, 13 Apr 2024 10:29:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BC539FFD
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Apr 2024 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713004165; cv=none; b=pSTqo8bnU89L1HggUeOu3rIAnd2mBAwaH4TAE5/HLaG8gC9r/zF+NlLet/q/lXrA6BkeqKjfAB22HS0AEejsZYcHYdDjrfY7SrbGzJsxmC7uVngW2oZqK3Eyp/fzGblCaPJCc96DPQndinRgxuR1CB8oTfATPtl1uoggg5FFl2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713004165; c=relaxed/simple;
	bh=V9loeSc4IECq3fxQnzrP6pehUmg/2JflKx4mR5R8nXs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qX6Bw/TMAFg5By+zO62TvcLqrAWz+x1pRsKG4BXuTl5U536dt7UBXSv5j1/okDGXQFDgJ09pYGVomvuN8kXepd6U41D5FX3IBKsNlD4BBhpJtpxUdCtO8Gz6r85L8uXy1tqHRKht73P9nj704DUY+2qrma8OfNLg0Jay6wrT+58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36b0ad52a87so13710605ab.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Apr 2024 03:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713004164; x=1713608964;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uLtKsq0VwINExJJun7o7HSXh8fWOT6rp0lewqu3Iurk=;
        b=JaTrdK1w8/sjT1ymH01tHjP/0MYmjl9rHTXFRQdnTP2aV0RM8kucTpGILLG9W3vJFu
         FTI8vNRhPR3gmv5O4o6y1Wwf+N3blSmj+0H4UjCp/cWb6tdkHGrAics0TnUXJeyr2PqL
         st+cHVPLlKN4rs+K24zxo0eBiXFtK/ET2WlDPnEEx8I1n2iHlQ06adifkYCFNvqpvCiH
         VomTYnuElpqPaLouJOQ5VKnA8Es5CemQQrJqEIpy8aCD46Stx5Z4lhbXYvAgeHuFXG/L
         rPxWkbaYDWgnLa0qudaLxyrRWWWCybkTXYBXqesn6a5EY2xhLhwepaaOwJRnQ6SN6Z7A
         ZKKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTHdeu/M2NmJbHvRJA7N2HWYAySRys7oPvqI8vHypPnFpyk0pI49gm2O4ZcTgfgDPas5mpexjOMZpvw/cNeoSRjrfOK0nCh28LIySHqA==
X-Gm-Message-State: AOJu0Yxh8Ik5WeoyWFq/F0GuuF9UVQzG3XRT3oUGvjpMYRb+URAQZn8/
	Fy/ge/jMc014z0qtwZh/px54cvYnlkFKtyqNtY+C8hB2swpV+pxprkxvwe1NBCx/aGqS+idkKxr
	oCjdIDG+z0WbbrRtxMoAj1f8iWxD53aPQs75PZKPjmZQDwF7Vi6EBgaI=
X-Google-Smtp-Source: AGHT+IEbBv5golGdck82zYT7VdnqUxrDuq+0YFtaoJS4PcQHU4sgfH1SEXp7Ye8MxD8F0nCNKiPM93GrBg6wVk6VsKNLWYPChVRY
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a8:b0:36b:7e8:3851 with SMTP id
 h8-20020a056e0213a800b0036b07e83851mr313392ilo.6.1713004163888; Sat, 13 Apr
 2024 03:29:23 -0700 (PDT)
Date: Sat, 13 Apr 2024 03:29:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b005380615f7dc07@google.com>
Subject: [syzbot] Monthly jffs2 report (Apr 2024)
From: syzbot <syzbot+list87c7a7f61f75d325f246@syzkaller.appspotmail.com>
To: dwmw2@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, richard@nod.at, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello jffs2 maintainers/developers,

This is a 31-day syzbot report for the jffs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jffs2

During the period, 9 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 1 has been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 616     Yes   kernel BUG in jffs2_del_ino_cache
                  https://syzkaller.appspot.com/bug?extid=44664704c1494ad5f7a0
<2> 12      Yes   KASAN: slab-use-after-free Read in jffs2_garbage_collect_pass
                  https://syzkaller.appspot.com/bug?extid=e84662c5f30b8c401437
<3> 7       Yes   KASAN: slab-out-of-bounds Read in jffs2_sum_add_kvec
                  https://syzkaller.appspot.com/bug?extid=d7c218ea1def103f6bcd

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

