Return-Path: <linux-fsdevel+bounces-36693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0530B9E8089
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2024 17:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14D0282300
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2024 16:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7FF14C5A1;
	Sat,  7 Dec 2024 16:12:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEEA12C7FD
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Dec 2024 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733587948; cv=none; b=q1GaxBjVxVJL5yJ7gfCtLH+ZNwNnmeaSoZoOw339CEfYd/3bGUYopdfsYnZatv5gExseLDSXeluxFME/qkLVngwrtXtEVcFUze9mfe/PsdEOStJur/pEAMhuzEo+sQ9dGAlY7DrSGHOCTCjsqQ94faT1mAmPviyUGWDimhycmaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733587948; c=relaxed/simple;
	bh=ouwXvSe1knh7wv47Qc6XJmHyUS4VxHpHthoSndAt28g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=t+zQ/A88dRzNbKfAbBoAzHVOU3TjsWys8HuiedTCdFoRG9Xyob6Cm6muryD1Nigt62mF83mcAh3TXj+OEnDnCt3pBrFr5I0+bp0XKn524KgbqCdG4srvx6/DelZOT2QkuVMdn552wmMWuSJVgOJRz56F1rfeVsVmdFLsEGj1a1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7bdd00353so32245405ab.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Dec 2024 08:12:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733587946; x=1734192746;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+JG4qnBLpllsmCaEwFhhtqecdIWaTzL64jr3+YLTZI=;
        b=o45t1DmjOWX099LsbXSQ9GzaezmKP5trhZN/Uzwq6P1b7QWwRK1bcojWr0XzblSVmA
         Kb9brBGXl9nGAo82IksPFknPrRfUmuqHziInBwWDqHjRjqn1agCKv685zLObRGRjHyTp
         1u0NzeZo+q94SNmK8J6VShJtwvYUK5JECdxTP3/PBhoCri2UI8RCnB0GTM/WzfUKH0ML
         laCul7H7VvbFbIJwPwsWGmhXsaSmLafooZoMQnYg9dst/NHVjSLiw5CG4Jtzb8ZaYEhL
         SypV1ReWTzRkPU0dGPZq4MHgxVi++8xA5tfTJM4zX0nUNPYeal7RjYYSh7/hnJP8N3dp
         soCg==
X-Forwarded-Encrypted: i=1; AJvYcCUSVaje+b0bYSdY+k6Gl6O+P2wxEWiVNV+tZpacAvLOls529EftfZxKeJ94YautfH5B7pkIx8b5gXFu9lQE@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx52L7+OqQbFQWD4dpjBNqceJTiURXhyoRXQgc/NzVp3owgLFO
	7mCvPvdycwr11XbvtgU9VKHpufTF6RSm7LnI6PQu8c9LmwKasgwC99ZjOeNkwc9Z0CYEEeC9nHP
	ecxo9uUQk4B4LeqxiM5IpLKwoCXd2hImjgUZFo6Nfxjqc7pCtdBJXu7w=
X-Google-Smtp-Source: AGHT+IEb8qWA7F1OFfn/rTZXkPcErKK3GOUrm2bVUFfqD2TjViVTNYIBdH6488kwbngRgUEBbVtWyGy4o5ywx+cY8o3fK/43vSq+
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8b:b0:3a7:6e59:33ad with SMTP id
 e9e14a558f8ab-3a811e0879emr70609855ab.17.1733587946408; Sat, 07 Dec 2024
 08:12:26 -0800 (PST)
Date: Sat, 07 Dec 2024 08:12:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675473ea.050a0220.a30f1.0159.GAE@google.com>
Subject: [syzbot] Monthly exfat report (Dec 2024)
From: syzbot <syzbot+list4af3b8ed9549444d90bf@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello exfat maintainers/developers,

This is a 31-day syzbot report for the exfat subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/exfat

During the period, 3 new issues were detected and 1 were fixed.
In total, 12 issues are still open and 19 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3225    Yes   INFO: task hung in exfat_write_inode
                  https://syzkaller.appspot.com/bug?extid=2f73ed585f115e98aee8
<2> 1854    No    INFO: task hung in exfat_sync_fs
                  https://syzkaller.appspot.com/bug?extid=205c2644abdff9d3f9fc
<3> 394     Yes   WARNING in __brelse (3)
                  https://syzkaller.appspot.com/bug?extid=ce3af36144a13b018cc7
<4> 36      Yes   KMSAN: uninit-value in iov_iter_alignment_iovec
                  https://syzkaller.appspot.com/bug?extid=f2a9c06bfaa027217ebb
<5> 8       Yes   KMSAN: kernel-infoleak in pipe_read
                  https://syzkaller.appspot.com/bug?extid=41ebd857f013384237a9
<6> 2       No    possible deadlock in __generic_file_fsync (2)
                  https://syzkaller.appspot.com/bug?extid=625941ecc67c107ef2bd

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

