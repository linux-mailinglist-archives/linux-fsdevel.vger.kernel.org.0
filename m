Return-Path: <linux-fsdevel+bounces-23902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C14F934975
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 09:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 017FDB2251A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 07:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B013B78C75;
	Thu, 18 Jul 2024 07:59:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EBA768EE
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721289565; cv=none; b=C+Pe/GxKnEFb0r4MSNyuctkfcYu7p9qDpeFz7W85IR2nsXADsIIRVQSolp1xvsBUZFV94fMJHPDXYhnd4ha+owjWYbBZBxr4RzqFjw8aKdewiB7ceJ5ynAPJ3P8+gpV7Q6txmDtS/rppVlyDBaImf79YZzx77FSjx5dryBNZFZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721289565; c=relaxed/simple;
	bh=iHJvg5p6ljjkOIDgZWQcmFfi0Y1NKHZvbW7p0qF04Qk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EkHnwyhVpRd37zlySL0KGXpPWOoK1HzRRWXSkoaYlajqYyWYfpSBMkna90Shp5eow4mPbIRXgd5uHIrdTIHK0WKMahaR6/B/tRDnhjB/RRIfE1AVWrpFVGjFoTgqY/MZSyrXPM6UMLkVCEcZj/n+pJ/EH62VocAvFctuFDvKLiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8048edd8993so83182739f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 00:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721289563; x=1721894363;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SHV4zKfzs5x96MeKzOONV81pwLBbmFsAPIuyFbuSkKc=;
        b=g4y9Vm+0uBKOiw6Or3JGFaGBIO2DFaUWm/7keH6z7Cq37SiXGZ+ip62UFYkNURoXPH
         02Dr/h7MGpZg2WQCVKWuIqERXwWU16sHHBjbrMAiclUVOZOGJX+t06hd63OfX0IScu8Z
         N+q+8FlQ/TvuVUAF5fzzNnQWxi84pOg9kuXOJ1Xfyer3nhQP1Jjy2nGg7b/F8uIeES2g
         rd+hTygiOVCL2PEFFVgaJ7AL4QpPlt5iGDplznZcNClNWN7bXEK6NQLO8vMs2yrlpqvE
         RCQSuLhXT6UxLeDw8amGUFn6Q42auaoRDj0kAEJ5bqK9/yzv4GAs6he+mUWd/tZdG5OX
         i06g==
X-Gm-Message-State: AOJu0Yx53Bca0YZfV/WA3bPuHB1O3gcmF1MoULnNHkucpgyfF9GZv+vW
	k5ixsgkFrTZIQGoeI4AZIW0ThCYQiMSs0wh/2tDEclWuI59d9JfwC+pDXkOkaozYISjVikxxbUX
	rNC2h+Ys4xTGF1SpQ25+9iW7vHPpBLtlDHY9qpxNWRxVEPGQf1LlxaX8=
X-Google-Smtp-Source: AGHT+IGFvLmyMLdMmeI+i8Xzqf7GwFhBg9/Q7LokY8RMP+e23aQRukE1B0UdVqIn74NMtdfxMgVjRFcbqnzNaMYm26Jq5arsXEvJ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1605:b0:381:c5f0:20ef with SMTP id
 e9e14a558f8ab-395526d992emr2867015ab.0.1721289563027; Thu, 18 Jul 2024
 00:59:23 -0700 (PDT)
Date: Thu, 18 Jul 2024 00:59:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f5cb0b061d80f4e1@google.com>
Subject: [syzbot] Monthly fs report (Jul 2024)
From: syzbot <syzbot+list44baf210a6a389320a95@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fs maintainers/developers,

This is a 31-day syzbot report for the fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fs

During the period, 4 new issues were detected and 0 were fixed.
In total, 40 issues are still open and 349 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4025    Yes   possible deadlock in input_event (2)
                   https://syzkaller.appspot.com/bug?extid=d4c06e848a1c1f9f726f
<2>  2605    No    INFO: task hung in path_openat (7)
                   https://syzkaller.appspot.com/bug?extid=950a0cdaa2fdd14f5bdc
<3>  1138    Yes   WARNING in inc_nlink (3)
                   https://syzkaller.appspot.com/bug?extid=2b3af42c0644df1e4da9
<4>  1094    Yes   INFO: task hung in filename_create (4)
                   https://syzkaller.appspot.com/bug?extid=72c5cf124089bc318016
<5>  825     Yes   INFO: task hung in d_alloc_parallel (2)
                   https://syzkaller.appspot.com/bug?extid=55f124a35eac76b52fb7
<6>  575     Yes   general protection fault in iter_file_splice_write
                   https://syzkaller.appspot.com/bug?extid=d2125fcb6aa8c4276fd2
<7>  445     Yes   INFO: task hung in synchronize_rcu (4)
                   https://syzkaller.appspot.com/bug?extid=222aa26d0a5dbc2e84fe
<8>  349     Yes   INFO: task hung in user_get_super (2)
                   https://syzkaller.appspot.com/bug?extid=ba09f4a317431df6cddf
<9>  320     Yes   WARNING: proc registration bug in bcm_connect
                   https://syzkaller.appspot.com/bug?extid=df49d48077305d17519a
<10> 295     Yes   KASAN: use-after-free Read in sysv_new_inode (2)
                   https://syzkaller.appspot.com/bug?extid=8d075c0e52baab2345e2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

