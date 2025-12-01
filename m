Return-Path: <linux-fsdevel+bounces-70326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1CEC96B20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 11:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF43C341EC9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 10:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1675C302CC6;
	Mon,  1 Dec 2025 10:41:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D0413959D
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 10:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764585701; cv=none; b=LlZScMaUXtPhtQSqdXsk6hsMao/BCxjdTDrEG3KRv/T4SLWlN9C7RfnFIaO+hZSuQ98CLHFTay9JxCJn5hJBdtLnbEkbTFIxpnkNnRVUwjTkNr5I3msZXQzhLmYJnVjBHoYjhQL6DTcEt3CfO+HNfNEI6lUVhxkuoVn+z5UhSJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764585701; c=relaxed/simple;
	bh=SZkRJslHxWM/1KnuKHVABEV3usEKDJfCeo5b1Q58YnY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pUHSmuTM6GDoWUEyU9eSXYXtiLOsfO86zycBap1YC27khGm+W+VJKawvZoRri6G3EdWur53C30R1eXbfto6TCZpiDW/vkIpUr6UWheria9RljHgAoqZ4yiUFmxdADaOYJv18l9QH11dmaeDU8WccIhkILCDRQdSjxgd7QxPv42o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-9498573d465so235132039f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 02:41:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764585699; x=1765190499;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SFirapMvjK1jvUYgeSuamFBEDZlg3I7Pfv8S53FS7vo=;
        b=LArm1d15dEynddOgO+3rjUFFRo6GDxsgGCJ/lUcOzZ2WkodQ1ODm7rmlSPYMt1cxlQ
         OsnWSe7mrBEJtpaADT8T6jrC+EZmxVHosu+8z69wiIX8j58m3MU3b0/AYTkARhbOogKZ
         FaEUKlAJFG1OkrMyCOS8TX/ZgjYNwhuUjGGeRWAXqesNm8yY6ZD6ZK4u3bw64iqe7Ql7
         Xvr4Y43oGCXey38q+k0gIyR2AtuftjOYH/hYdP/f6w0FWg+vosPkLqT/m2KR4J3D+mKU
         6APEbPWqlPh/2Q9fPlRMsD5iBs7SAwbq7kOpvvu/xwwe7ltnrlXGy1WPnvRaOK8l6CM5
         OaOg==
X-Forwarded-Encrypted: i=1; AJvYcCXVQBTR/kMXc9FW2UC5JtmEvVgNex1gue8SQGLj3OnUOayNWGcgZn2lkN8XnD7v0+ya2RwDR5558hMPIF1t@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6D77OxkWs89vxXAMX8xdUb6M/5XhPW6ybcCSDSbTD9lQeOfHO
	62tGCzXXnidcnWBov6hbBNUPjx3qtF3n7hb/1TK84BsSBNpPzkSicCkRgyaQX2IQRZpaPNsw7wp
	X6gVNZpJOyBZ96gxVmoHVbOHkLdTrW14hVvbtG/dW/641T6a99EvZGbF0yIQ=
X-Google-Smtp-Source: AGHT+IGUOSCgW9aRJFPqeRScfXKGk80MCUpp/3d+Z6s5pNtV2q8JPpAgMENvJ/Kp4QO0VIJuxTWFPQMS5TVKpv4oyF+V3EddduYc
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5e:c113:0:b0:943:5a3c:7525 with SMTP id
 ca18e2360f4ac-94939e118e2mr2540676739f.1.1764585699481; Mon, 01 Dec 2025
 02:41:39 -0800 (PST)
Date: Mon, 01 Dec 2025 02:41:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692d70e3.a70a0220.2ea503.00b3.GAE@google.com>
Subject: [syzbot] Monthly exfat report (Dec 2025)
From: syzbot <syzbot+list882e2ba54bc3ba7e2148@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello exfat maintainers/developers,

This is a 31-day syzbot report for the exfat subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/exfat

During the period, 0 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 39 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 627     Yes   WARNING in rcu_sync_dtor (2)
                  https://syzkaller.appspot.com/bug?extid=823cd0d24881f21ab9f1
<2> 20      Yes   WARNING in fanotify_handle_event (2)
                  https://syzkaller.appspot.com/bug?extid=318aab2cf26bb7d40228
<3> 5       Yes   INFO: task hung in lock_two_directories (4)
                  https://syzkaller.appspot.com/bug?extid=1bfacdf603474cfa86bd

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

