Return-Path: <linux-fsdevel+bounces-13828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C246F874270
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 23:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62900B23009
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 22:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410791BC58;
	Wed,  6 Mar 2024 22:08:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2E21B941
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 22:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709762910; cv=none; b=lG0GF2lRVrGPpdIZJvyF5Xn/TdO8wrEvO45dYfrH1awPGbtQjKDZq0Qosw0Q4M5Xa16pAImi2SeaI6mXnNpFyeAOEbDw8gbkSlruIt1sZKrjDqRj/uUWjg2EObQN5p23J1CW1uacYJisL15gfCkmp0MkvpSZMVOWAjR2skATk4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709762910; c=relaxed/simple;
	bh=aLqD1qqrg4H5cW6Sta4E4emtGDDwylkjtBqP6jN8U8A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sZndUocCwgRm85knM64dvjtwPMxf89+k+ljgJ7hyptdmqHHSTmG1wncgPE6EQT349V0r4UuJErv+4aQ51rKmB+LsS1u4t1SVsj66UDFuOknIWjMvpiguU6Ie1/dTLMrnI0cQ5fXBG+L9/7bgZXx2SHmINawRapzM/yDwVUURC5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bec4b24a34so32663539f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Mar 2024 14:08:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709762908; x=1710367708;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ydl/05qviZ59DUb0+tYjcpB6jNkUerBbrbnghjwTq8=;
        b=LdEt72WRYjK9eRDy8PWsIGqib7uNHXXEnwpIkyDZ/sm4D0VH/O18FLxYHjHoFUrLNG
         6TEOhjSfSj/f9Vr7y3N5u7u2Rss8YZ81pQ7Mk8OPJTTuRXEF+srp+OHd3WluTrDsUob7
         LRJ3PydWPkc7DQMv/PXVSEMIaSACziNVICJIanlnJ772HVgGaRGRaN7OUp5h+uaxmfwb
         Yqw+QYv4ZqjZBXpJ9JbzLNcrVkKyOu4pPpBjrdzcIN+CJZQZ2urUJe0mpiR0o1HdThHO
         dtFP/cV+3kH2boCpaaOYzI6GjsZ48IXDCKxo2A6eDsWxqskUYnjje2eW+Xa7JYOAF3RZ
         K5Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVL6x5IO/IlZ2txh4Z4Jzz2kcmXnTm/va4HAzZu5318EJVYXyfJdPiCSpZMheMElsDISBZjqZBfTgtMcVRG7TW8HSg4UxCrULvhcacDqA==
X-Gm-Message-State: AOJu0YxeOz/y/HUT+RL5jUvyjthSoYIoKL+VDcLizJmD/ZjDZLzkFred
	HRZs8Clm0nwfRo5Upnnb7MwlDY0FbDkm1Yy6wzug+TiirG4oGjfWJhCF7hmdj9jOA00JXDuFgHw
	r3/FZTi2r+xMn3pVcX9vDasvB3iBUv8dxz2Y1Dycp6K5yZEvVY8xTWsc=
X-Google-Smtp-Source: AGHT+IHR5Fsp+gGDp4OcyRnoO0IK33EA0UpUzzcluBuUVwW4wDXOTe81M5JhSUqqlYaFC9Jb17KkZBZ1+SYYbowiauDgOoKSai0W
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4818:b0:474:dc73:2aa4 with SMTP id
 cp24-20020a056638481800b00474dc732aa4mr576597jab.3.1709762908799; Wed, 06 Mar
 2024 14:08:28 -0800 (PST)
Date: Wed, 06 Mar 2024 14:08:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4506f06130532c6@google.com>
Subject: [syzbot] Monthly exfat report (Mar 2024)
From: syzbot <syzbot+listfd275f6d56fcfac99f4b@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello exfat maintainers/developers,

This is a 31-day syzbot report for the exfat subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/exfat

During the period, 0 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 14 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 362     No    INFO: task hung in exfat_sync_fs
                  https://syzkaller.appspot.com/bug?extid=205c2644abdff9d3f9fc
<2> 59      Yes   INFO: task hung in exfat_write_inode
                  https://syzkaller.appspot.com/bug?extid=2f73ed585f115e98aee8
<3> 43      Yes   INFO: task hung in lookup_slow (3)
                  https://syzkaller.appspot.com/bug?extid=7cfc6a4f6b025f710423

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

