Return-Path: <linux-fsdevel+bounces-59648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39670B3BBBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 14:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1AB1CC0436
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 12:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1EA31AF3D;
	Fri, 29 Aug 2025 12:52:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90A1317715
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756471954; cv=none; b=EYxOYQwDmPAnNfkwg6/jegUJl89Zsop9q2fbE5kBwE4ZKy3zFACbonDjQYDwgBqmtIkW+UedRBFDrQ2LEOxI2EI/l9Nc+nr/iDL0eWLghQPujtx7BzLjks3BiowA5MjL7XGT77p+tphP3Syy/L0KdPSAvb20SuBDSDWJ/JOSq54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756471954; c=relaxed/simple;
	bh=6YhTW3nttYtbg0OYtm/M8lkzgV7Sden1epmsfD+aywU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hO9UwJzTh7XzXNE4w3WbISusH5e9qA/RdL6cGZPoo0GiEz0QjdSnMYZF2BrFzfqLeGR3mgA3KA2yJw+r7jvypzSuLT8oBmHpRZz1oe6yu0deKo5jE7rhJsEuQJW/iNpUIbgsBxX+H7jTX996gPZXlkRn7zIPFRXWhtZM4hlBHHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-887146210b8so58511039f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 05:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756471952; x=1757076752;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AzDQIQnRlfn6+YF+SQIkLHm5D20DM3s8MyA0OY21mcU=;
        b=Km7ec+VXKCf0FGWKrh77ULl0hAR6j91BitjOuHvoCLx0XBl/bC7Z0nshjlegKWWhdZ
         EldNHJog3Py3wG1JQsVJ/69tb9NceIQnG+eif/o97nvK0oG0dSuUy7tDTHtP01mxhlxR
         dJ2UgAns7rKFJyNEoJIPqT7g7wyT+/xoBSzfamqJC068ADbfPIF4i25VA1GsKloX3pw/
         I2LxMB9OaPE3kdjjqedeIpd5JPaby1dcvYV9GnhlDKAZM/jm2BrUK/lHWs4zoRC8mdI0
         uByJKExS5GZjMZnNEKh1bbc1f4xhYvLC8on5dmW1b2TO26LNU6FinPYBpzO0fzhiejlQ
         sRHw==
X-Gm-Message-State: AOJu0YwC97uW12NLtt2hiVRR8fycFwSHn1J6+kdsEUrCxzkT+v2u1RBH
	Eh0PiDjQOCY4RAjzloopKv9ZDlXvcaHvCuqoQtL+iLEEGIBu/rAxcsSS5OKlcJ7hNze6ZnKDDRP
	5dESrUOA+1u8NI4TAvfSA6TATemBBdPU+H7/WB1ShxDLPMrLu01kYhZmKeAU=
X-Google-Smtp-Source: AGHT+IFZ2OmXLc5VcYbZol9D6f8r+L3+tOQflVHoUwuqElwgAo4E6RPr7UssXYv5LwKP2DIAMPAfYSCoZWjoNIRzJ7xGKMUz42A0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188d:b0:3ef:969c:c91 with SMTP id
 e9e14a558f8ab-3ef969c0caamr206273665ab.6.1756471951982; Fri, 29 Aug 2025
 05:52:31 -0700 (PDT)
Date: Fri, 29 Aug 2025 05:52:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b1a28f.a00a0220.1337b0.0019.GAE@google.com>
Subject: [syzbot] Monthly fs report (Aug 2025)
From: syzbot <syzbot+listc95489547942700d4b48@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fs maintainers/developers,

This is a 31-day syzbot report for the fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fs

During the period, 3 new issues were detected and 0 were fixed.
In total, 62 issues are still open and 394 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  9318    Yes   WARNING in path_noexec
                   https://syzkaller.appspot.com/bug?extid=3de83a9efcca3f0412ee
<2>  6870    Yes   WARNING in inc_nlink (3)
                   https://syzkaller.appspot.com/bug?extid=2b3af42c0644df1e4da9
<3>  6225    Yes   possible deadlock in input_event (2)
                   https://syzkaller.appspot.com/bug?extid=d4c06e848a1c1f9f726f
<4>  4523    Yes   INFO: task hung in path_openat (7)
                   https://syzkaller.appspot.com/bug?extid=950a0cdaa2fdd14f5bdc
<5>  3643    Yes   INFO: task hung in page_cache_ra_unbounded (2)
                   https://syzkaller.appspot.com/bug?extid=265e1cae90f8fa08f14d
<6>  3416    Yes   BUG: unable to handle kernel NULL pointer dereference in filemap_read_folio (4)
                   https://syzkaller.appspot.com/bug?extid=09b7d050e4806540153d
<7>  2812    Yes   general protection fault in iter_file_splice_write
                   https://syzkaller.appspot.com/bug?extid=d2125fcb6aa8c4276fd2
<8>  2276    Yes   INFO: task hung in filename_create (4)
                   https://syzkaller.appspot.com/bug?extid=72c5cf124089bc318016
<9>  1877    Yes   INFO: task hung in lookup_slow (3)
                   https://syzkaller.appspot.com/bug?extid=7cfc6a4f6b025f710423
<10> 1485    Yes   possible deadlock in input_inject_event
                   https://syzkaller.appspot.com/bug?extid=79c403850e6816dc39cf

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

