Return-Path: <linux-fsdevel+bounces-18101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263848B58A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 14:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D676A2885A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 12:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5961175BC;
	Mon, 29 Apr 2024 12:34:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE7FBE4E
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2024 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394066; cv=none; b=tIJ0IWtFSp5BaW1qczNXbyPthBq0qtYClLKTVVGfRxQw4V+hwMvnebnHZQ39R+QyztzQ7X0d0K34YnnebM7K0YvApd2OaV6c41+cXEIAlQhTa4bsTFtLsc8parpAw6Sk/mwIX3Xr0yuW0rrB8J+bai8tTtLosTfv+34jh8Rv09I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394066; c=relaxed/simple;
	bh=zNX4dvMj8sMaSc/H5ov7uAslSWACWgUB2DwD63KMJfc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MmBptOHjVM9FA8nODiII5loMs9bfkNuxBcwJzqU0wxKhSAtYu2imUjz9dt7KoCfg0O82tXfSKjP5ObJKOWkjKp1YyPvII1QOfyLv//AOLRwPj3IXUduIW5uVpMyAuT4PiCZ8cUYM+Z02LS2B227OhQoA+MQkLU/wG4edP30Ej+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7dab89699a8so492695039f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2024 05:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714394064; x=1714998864;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lIcH+uqjp3vumX9YpVxoQmZo6VBkUG5FwDdMSz/9KgE=;
        b=Dr8uk2i9+Yqcj8MF59m+y6mOoHByvGuIlhV69nK2n72PQJYdNn4ZsBIGo+UHXSLbzF
         ZJOw4XuowaHeWDr8HHH1iVXuP7oDsmEHevbwJPkXgLeOffmpO2Z8de2l2XMYRqT+TeTt
         W3FmYQBhcm68Fxf7czd05oHfzI6HmcgqLX3BJTNoCbQurJcMRayeUgw+pMAqk9ztRkY/
         kUFyOKYYwJLPJP4OKekVlU08azTdiMb9yEMAIET+A5yodf75dzzGwLe4tO2laISYaS4k
         3pm7KrC42OtqGbtGl8NZgbQ81Nue4juBsXv8SUoRzarhWs3VLh53+dcvbMu4JnJAeeW/
         UlYw==
X-Forwarded-Encrypted: i=1; AJvYcCUJzPcquA9ia//Teb3lDQLX+v7FXlYrgHIFu2c1bf+zJPsB5kf6nYxiPfpC9vGbw63Qnw3GM+o9tZzm6EOPnEIyKbbJkBYR5S3HQlFn2Q==
X-Gm-Message-State: AOJu0Yz4lVA7AIzDcoVDOQJ52YbD//vpQjvBY0PHlj4uSauWk3VHuiFF
	Ni9OJ0Miz0Tv9MmJyyU2vR1BpuZjJwTgkqsrxi3XBfZmeg+z8DiOSQ6zSTrLCJYKY1KwPrP+vJW
	5Ftba8cB3U56E2bDqpGb1uT0QgahO1TP25RHBWUV2Em82CcQfZN1cQAE=
X-Google-Smtp-Source: AGHT+IFmGFq5GWv4TOIvJdOwBbT+UeOKGABz5MfdMy4OwFM1jJZ30xEQ78iGkI8pgziDJHL8eka2027lOFMUoQQis9xo9C0fNNFr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3d89:b0:487:c6e:1bf2 with SMTP id
 ci9-20020a0566383d8900b004870c6e1bf2mr816814jab.1.1714394064267; Mon, 29 Apr
 2024 05:34:24 -0700 (PDT)
Date: Mon, 29 Apr 2024 05:34:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000034bbf206173b7991@google.com>
Subject: [syzbot] Monthly gfs2 report (Apr 2024)
From: syzbot <syzbot+list8ffe20412d57261746c6@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 6 new issues were detected and 0 were fixed.
In total, 11 issues are still open and 31 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 61493   Yes   WARNING in __folio_mark_dirty (2)
                  https://syzkaller.appspot.com/bug?extid=e14d6cd6ec241f507ba7
<2> 746     Yes   kernel BUG in gfs2_glock_nq (2)
                  https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<3> 108     Yes   INFO: task hung in __gfs2_lookup
                  https://syzkaller.appspot.com/bug?extid=8a86bdd8c524e46ff97a
<4> 90      No    possible deadlock in do_qc
                  https://syzkaller.appspot.com/bug?extid=8ef337b733667f9a7ec8
<5> 22      Yes   INFO: task hung in gfs2_glock_nq
                  https://syzkaller.appspot.com/bug?extid=dbb72d38131e90dc1f66
<6> 12      Yes   WARNING in gfs2_check_blk_type (2)
                  https://syzkaller.appspot.com/bug?extid=26e96d7e92eed8a21405
<7> 1       Yes   KASAN: slab-use-after-free Read in gfs2_invalidate_folio
                  https://syzkaller.appspot.com/bug?extid=3a36aeabd31497d63f6e
<8> 1       No    KMSAN: uninit-value in inode_go_dump (4)
                  https://syzkaller.appspot.com/bug?extid=bec528924d6c98923e5d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

