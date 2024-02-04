Return-Path: <linux-fsdevel+bounces-10222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AD8848E0E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 14:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3C1284519
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 13:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F71225AF;
	Sun,  4 Feb 2024 13:30:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AA3224DF
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Feb 2024 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707053427; cv=none; b=q9fiA3Zs21rxDzuQgC3DTkzTc6rOZYcbs74fn5mUtsiACyYBg32EztPOwL6pdJslZTZCGlZsXOL6txPrZyf1gU9CQBBEc9Ag82ZKFYnnbQCbXP/Ym7PqeCJL6Zk9w8d2UarA/smjjgzxZbPgTOr8kWA/yvnQKRbONY1SIhZy81c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707053427; c=relaxed/simple;
	bh=UaMSnAIomP0d4/QVoz2dzuPbz+yAssf64Z9+owHSSDo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=t4bbRhZhqE/ahN3/b41/S5S3pWpb9T6eITnbDl93yrBl33+d7+7qH+JpK0asu1LL/6u5zP1NnMVYn4CqnIBrkntQ613lz81SYEG/kYXeLSfN1ckHEabjzc/QcQPo+giJK3tVdhj5Zd+VNx7XhTJq7Gk3zxcG0vsI6IIB9JawTp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bedddd00d5so314389839f.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Feb 2024 05:30:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707053425; x=1707658225;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tzM0gFWX358jgiBmOqZtwQSB/F2tsNwCbyAEBJz63Vc=;
        b=uL4O9/rXwsJYsbTlX2MiYvvby5AijKz6bckr46KNVhqP5YkcP1XKjb6R0jf5EJfbjl
         Dz3Mc2HCilbK2Psr02Y00Eag0YuyEL2kPZOE3bjskJqDExqKJL1kHNJWFfuXY2mQ+qar
         x9oV5g5YUaD0Zb413M0FvYmLrJRcB2jajga0OpUT2ca4ks6gV/ZU+vAjRV37bm/RkoZY
         O9DgH54DfoOUkIrFLff+nTCThb/cPboPUZg/G6f2I0AhE2DVuP1GtmsvJhCpCf0uulgY
         4gEnUClCGX51cf0itKcRYdZbacdCI1sKlIHEhubyiUibF25TNrNuce1GjgPPXfI5T5ND
         eBeA==
X-Gm-Message-State: AOJu0YwZWESoQQh1SRcLNxI6jBu0uM9QHpoy+HUaaqCR3l80ljWBYi66
	I0vfmTlIPrRfcUVXTz49xtIs6oopzzwXkVta6yoYXXFT6SdcmH8e05myxL1Jv9qfHQLdFukp/ay
	vU+8vHJiic6BZ2RPXyBGAw/gVM/FQL7AYJpUKhBtWzqTHWrztdmLLSIE=
X-Google-Smtp-Source: AGHT+IHCw+64iELG79qhBXYxXl02VqldZ1Z1z7ljzrHWmEXSfj/t9tLgEWnk5meIw7bn7d7KKARtlDI3i6cpUlTad/3ij0mEVaHC
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d11:b0:363:c8ba:ea5a with SMTP id
 i17-20020a056e021d1100b00363c8baea5amr46326ila.6.1707053425706; Sun, 04 Feb
 2024 05:30:25 -0800 (PST)
Date: Sun, 04 Feb 2024 05:30:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d4e8006108e5989@google.com>
Subject: [syzbot] Monthly jfs report (Feb 2024)
From: syzbot <syzbot+list857c7d203040989b10bd@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello jfs maintainers/developers,

This is a 31-day syzbot report for the jfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jfs

During the period, 2 new issues were detected and 0 were fixed.
In total, 34 issues are still open and 31 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1661    Yes   general protection fault in lmLogSync (2)
                   https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
<2>  1416    Yes   kernel BUG in jfs_evict_inode
                   https://syzkaller.appspot.com/bug?extid=9c0c58ea2e4887ab502e
<3>  985     Yes   general protection fault in write_special_inodes
                   https://syzkaller.appspot.com/bug?extid=c732e285f8fc38d15916
<4>  574     Yes   WARNING in inc_nlink (3)
                   https://syzkaller.appspot.com/bug?extid=2b3af42c0644df1e4da9
<5>  527     Yes   kernel BUG in txUnlock
                   https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
<6>  357     Yes   general protection fault in jfs_flush_journal
                   https://syzkaller.appspot.com/bug?extid=194bfe3476f96782c0b6
<7>  279     Yes   KASAN: use-after-free Read in release_metapage
                   https://syzkaller.appspot.com/bug?extid=f1521383cec5f7baaa94
<8>  109     Yes   KASAN: user-memory-access Write in __destroy_inode
                   https://syzkaller.appspot.com/bug?extid=dcc068159182a4c31ca3
<9>  104     Yes   kernel BUG in dbFindLeaf
                   https://syzkaller.appspot.com/bug?extid=dcea2548c903300a400e
<10> 84      Yes   kernel BUG in lbmIODone
                   https://syzkaller.appspot.com/bug?extid=52ddb6c83a04ca55f975

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

