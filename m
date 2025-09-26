Return-Path: <linux-fsdevel+bounces-62909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FA8BA4DB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 20:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB09B3BEA41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 18:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9E62FFDD3;
	Fri, 26 Sep 2025 18:13:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8DC277C9D
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 18:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758910412; cv=none; b=cJxONZHXzxLujIi+JxQdi44mLHrWRNjSSji4T5Cq1+p3+37Koi+Yb5pNTGerE3Of9SY7byqwRPuvChXAYjqvmD7UT6MV73WL7jjuSzn1iE+4Yo9nUzanWDQL4xcgIomsHa5Rv8+3wHswK7f/+4GqOTkX8VhjuPZO0Ob6r6UlTVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758910412; c=relaxed/simple;
	bh=Y4MacUweR9Sb2UzA5K/8xmpkwo1sje1B0Bb3PUY6nFU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=i2GD9NZUxsmahtMxIW2dF/XmPIIHAKCncSFtZIseGM/a3TXi994lomH5CEzbfwrWz7IYyBQQcQ/zrDE9tEiQcIYuGEb62s/FVBTzqJZ1SipXNaRnexetiWoxGRWup9dLO7pgJFQoAi3Aq1HNxPa31Jluj+lCxLiK/Jr7JAeUmDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42486f6da6fso35461255ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 11:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758910410; x=1759515210;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=trW/5NZOPRaukq5PbeSv7HCfuq1dc+w+tUhzCR2hFEg=;
        b=Lk1/Q5KOSl6nIIVK7Sl52U0X0fSVLi/X1EIdov5gnZOzmbSyUlDQU0idS27WdhDC+w
         +/jMTf4L4Rz1+lBigaAOA2XHBYGYOul55Udp6ufWSyRObjVup508Ip/KtL2qpX/6oH6d
         4nWrZ3cgtQehCwZvEGJwaddghSeN2Y7z2k3pErH6BAk+HbkKY6P94Nq1ROGN45iIxKPd
         HUrFDMmLtQpp3lb51K/mgrBOnrcVn066dXztCZP8vFAxYAmT9gkNH51hhIYnPdNgUOGc
         QCQitzZpjxG5p4xLZXQr/0ByJNXvMKJbC7Y45GfIl0s/38SaYWWzJNGnTVjnFMTDJ9n+
         s3HA==
X-Forwarded-Encrypted: i=1; AJvYcCXbCYn1Qm2RGXejRObAokWtYe4yWsGQbSs8IiycOiog2vBX3u5l4hy+nlsEPzV76kHS3zWe4hm2NUf2+TJw@vger.kernel.org
X-Gm-Message-State: AOJu0YxlzXF3jHzS0tUpauWGA90zMuaaKelm2RFy13ER0rJmCQa7UFcG
	BEVq8+Q3I+L+rdaR3uFteWB10rs1VrsnqU1cGEZQN+hPe+Ox1MvrNWcfx8qCymuRwJkoO1ySl0q
	lMjNGZSwbmgfcgQy1tvwqvPoIH9BTRlVLNyWwmjCqw4JFHlO4GFuoOMgaMeQ=
X-Google-Smtp-Source: AGHT+IErxeL7xZBwcqKbjwuUdAQvqvclikF1LKb7JolrauwF35tFenXJzZr4pP+7hdqoDn64jIhyZX+nNkIE7fTJaGjGtUTAaizL
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ce90:0:b0:40d:e7d8:63fa with SMTP id
 e9e14a558f8ab-42595650bd3mr89971875ab.26.1758910409965; Fri, 26 Sep 2025
 11:13:29 -0700 (PDT)
Date: Fri, 26 Sep 2025 11:13:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d6d7c9.a00a0220.102ee.0008.GAE@google.com>
Subject: [syzbot] Monthly exfat report (Sep 2025)
From: syzbot <syzbot+list5c996330145ae76e69a2@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello exfat maintainers/developers,

This is a 31-day syzbot report for the exfat subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/exfat

During the period, 1 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 36 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 485     Yes   WARNING in rcu_sync_dtor (2)
                  https://syzkaller.appspot.com/bug?extid=823cd0d24881f21ab9f1
<2> 78      Yes   kernel BUG in folio_set_bh
                  https://syzkaller.appspot.com/bug?extid=f4f84b57a01d6b8364ad
<3> 16      Yes   WARNING in fanotify_handle_event (2)
                  https://syzkaller.appspot.com/bug?extid=318aab2cf26bb7d40228
<4> 5       Yes   INFO: task hung in lock_two_directories (4)
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

