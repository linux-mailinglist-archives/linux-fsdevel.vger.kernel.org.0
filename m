Return-Path: <linux-fsdevel+bounces-16349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D39489BA44
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 10:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A132D1F2196D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 08:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CECA38F99;
	Mon,  8 Apr 2024 08:30:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B33249E5
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Apr 2024 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565029; cv=none; b=bY1UVUYR4vr6BbD3JClgbpd7704liQWrPP1Wz1AMGDRAAMdBHsYQ8p4yqaDUSX6Dv4/aX4DvUtu8EaXpi1n5+z13pQhTau4yMQUalRwUU5X6H3cm4QGa/0z8D675B+Gry1/OM96p5iGbxz8156zojJonxVYmHvBMCp5jtfp5G2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565029; c=relaxed/simple;
	bh=eW6HHTjr9L7w98H2JegTDIjKkHZ6BAuulufPxGFONAU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lsM3WKMbm7TAv+K1X8zCiEYW5cyv7P8ytimO69xzmeqH9xOhKjh2XJwvisKTucbVEYnM37dP3w1aHb6RiMTIANUwf7WsnnWO3a5z+eO9QmSYl+no0wm1d5kcOqMCRj6LlD7r4Rg4E0AWVRnfymn+zuTh+XjovZpocSTeoD/sPTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36a179df9fdso16800815ab.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Apr 2024 01:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712565027; x=1713169827;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYp6meHrV7SDBZGv0nvYZyr3yCM2oLscgHmCYKKOr+Y=;
        b=q0dKZnvxyZYynATXXfA7KEVVqh3zVv1EFC+5/EN133q09VnGzEIuhNhhbeEAqSH3gs
         iMg2VhJIN9vVQW1jLAOqw3KnfER4k/+r8g9yKT0ZYZWv//GhiTN/1YPUEi1d7Ot23CeP
         1gbIa0huYlc1BgSkYvS8Ap54WIrkczS5v8JW9fR6rmpZ7S0BEojYYG+tJ+1NJj91iAt+
         Jbq0ZLwPOlYCKrjZXb7onV6DZ4v4lfRBD8IL73d7nQ17GZOC5G1efbP5J9DAnr7hJBt6
         M8dbA9/Dmlj0PRwob6LqlSq68lPgpavQnvn+W5T0Ik06lNRhp2pdZbNtvjHJ+B/VGrAz
         SeHw==
X-Forwarded-Encrypted: i=1; AJvYcCXynIRCAR5uKdoMHFBJnSYcYslJtTcl1M505jyPlymDT8wCTTdC5qPXrX9RNEW4tQ/M/TXbMfP7651s8UuNnvmk//SWFyQYW7vVPiEx0Q==
X-Gm-Message-State: AOJu0YwwWai1CL0OGnpUJ7prBZi46nN609724JdENK8K5lJrt5z4ZQL9
	rXSUWdKrzI1LPTeXzgigZuyqHC63rkjjNCUIa4mQvAlj39uMi5imh97sRfeRzUQnUWREIQWiGNO
	Coqk9b17th+m1G22YLf6aUi910jw+Z1rBuNvecKxKCW59qVfNUB/zz2Q=
X-Google-Smtp-Source: AGHT+IE0LkOkZrbY/Ax4wld/wm2B12jY/C3Yr7wTVd62FXGRgS4wS4LErl/8peIS1PNZ4hb06CRil+kngxLj6DzqtYmnJO+CEbJi
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0d:b0:36a:2a29:5b4a with SMTP id
 i13-20020a056e021b0d00b0036a2a295b4amr46139ilv.5.1712565027174; Mon, 08 Apr
 2024 01:30:27 -0700 (PDT)
Date: Mon, 08 Apr 2024 01:30:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000198fc20615919e19@google.com>
Subject: [syzbot] Monthly jfs report (Apr 2024)
From: syzbot <syzbot+list5219cabcace6cc8e0864@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello jfs maintainers/developers,

This is a 31-day syzbot report for the jfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jfs

During the period, 4 new issues were detected and 0 were fixed.
In total, 26 issues are still open and 39 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1934    Yes   general protection fault in lmLogSync (2)
                   https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
<2>  1762    Yes   kernel BUG in jfs_evict_inode
                   https://syzkaller.appspot.com/bug?extid=9c0c58ea2e4887ab502e
<3>  1098    Yes   general protection fault in write_special_inodes
                   https://syzkaller.appspot.com/bug?extid=c732e285f8fc38d15916
<4>  598     Yes   kernel BUG in txUnlock
                   https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
<5>  583     Yes   WARNING in inc_nlink (3)
                   https://syzkaller.appspot.com/bug?extid=2b3af42c0644df1e4da9
<6>  412     Yes   general protection fault in jfs_flush_journal
                   https://syzkaller.appspot.com/bug?extid=194bfe3476f96782c0b6
<7>  233     Yes   kernel BUG in dbFindLeaf
                   https://syzkaller.appspot.com/bug?extid=dcea2548c903300a400e
<8>  92      Yes   kernel BUG in lbmIODone
                   https://syzkaller.appspot.com/bug?extid=52ddb6c83a04ca55f975
<9>  82      Yes   KASAN: use-after-free Read in lbmIODone (2)
                   https://syzkaller.appspot.com/bug?extid=aca408372ef0b470a3d2
<10> 74      Yes   KASAN: use-after-free Read in jfs_lazycommit
                   https://syzkaller.appspot.com/bug?extid=885a4f3281b8d99c48d8

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

