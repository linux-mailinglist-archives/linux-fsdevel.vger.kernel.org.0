Return-Path: <linux-fsdevel+bounces-62937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A49FBA6361
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Sep 2025 22:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0E397A1E5F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Sep 2025 20:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4ED23B60C;
	Sat, 27 Sep 2025 20:43:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B78234966
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Sep 2025 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759005814; cv=none; b=tec+yufsVeOa/Mk9Cai1QbvGdSpdAy8x+fG1pafxfhhQB8gtUqtI6rj0FQ0/9310wIQR2/aNwwUrJEgQ8pdfT1nCmw1s8pRObg8hO1voCW9yxNxlpBrD/m9xtp0knbUOxOxA/aFMIyQbvLXcGY76vPgBAk9OTlnVyltkLs45+Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759005814; c=relaxed/simple;
	bh=qqBNq/oUNzv1hAru+OxUOa6rS5cuxigsQJFLGKWRZdo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MfDJVuAabIHmRQzrXS7cUrgcs/fJbOHB7cpa57d4un9ZhzYB6qOHuiIC7DX8g0ZbWXcm19pXwk8/KA35duwxoSuSnfofyCGKjh/34ru9cx9FayvheTqtQy2G+ZtQrqNFcq3P6SvYdx2bUW2krG0aJnNRKBSUf1ib0bud0jwtosY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42640cbf7f2so73306355ab.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Sep 2025 13:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759005812; x=1759610612;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FgBEakLBjEpirRPbTwgwa5y0PQU9iFXK7podnyDdGFo=;
        b=kuszTBJizfK08NdReX9MTDYz+uo4JgP5aR05SU902qnMKFcpt7k0/HE/lPi73SaCFB
         CxifsM6RLKIGM2n1IiS0m95vl5qe2TtGoHya1rAkJUDLDEd9TdfCZbwP6ApwrF+ox7FP
         9E+A6ABoaM/wKuqvETIsnoYhO8iu4z/Xw5sI5EDVj4mA9gu/vKGfpObGlYqG8E3LzY+I
         z7zWMTkaQNC+Aaw8VDfr4f5hhTiK76bd0Fa/F56izibzjjWUF2/TvrRwinEjV5m10d1W
         XjY/Atd3mTKC1W/ABV2iKLpvbfIGXOz5nLteioEQkItV3/jEHHWp9IbrKZ5FsEYw5KPL
         uFJw==
X-Gm-Message-State: AOJu0YycQl1Xiw1ZcQc6rZfi639Z98mX82TFXFKplaz9bcMCtAgPSmou
	Pzfb4jWXNuCnIhgErHzGI9h8rJ7rMYR2wQUkkHexPOZzMP9+zVY3GdJ/uheoKiEh0RbeK6ifa6u
	UXOEOcTOOJNbEVU/b58jtiL3m7MJcWVVOc13ht51IQ4SJh9bBFHUheCj3HcM=
X-Google-Smtp-Source: AGHT+IHcWSgPNFSvO6mQyB/YDZRCjBZCIJ25Cpiocke9IOek7/btuCYSMPD3yyQtTw736wjaRKzMuhgG5Vt+bT39t1euh/0Cp1I2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc8:b0:428:76ec:b2ba with SMTP id
 e9e14a558f8ab-42876ecb4a2mr68817625ab.12.1759005812046; Sat, 27 Sep 2025
 13:43:32 -0700 (PDT)
Date: Sat, 27 Sep 2025 13:43:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d84c74.a00a0220.102ee.001c.GAE@google.com>
Subject: [syzbot] Monthly fuse report (Sep 2025)
From: syzbot <syzbot+lista4945a96c9c404d48254@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fuse maintainers/developers,

This is a 31-day syzbot report for the fuse subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fuse

During the period, 1 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 45 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 454     Yes   INFO: task hung in __fuse_simple_request
                  https://syzkaller.appspot.com/bug?extid=0dbb0d6fda088e78a4d8
<2> 46      Yes   INFO: task hung in fuse_lookup (3)
                  https://syzkaller.appspot.com/bug?extid=b64df836ad08c8e31a47
<3> 2       No    KMSAN: uninit-value in fuse_dentry_revalidate
                  https://syzkaller.appspot.com/bug?extid=743e3f809752d6f7934f

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

