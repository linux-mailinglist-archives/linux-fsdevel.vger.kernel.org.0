Return-Path: <linux-fsdevel+bounces-70335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5657BC974F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 13:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F2C3343CB5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 12:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAEF30C608;
	Mon,  1 Dec 2025 12:38:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915C530AAB3
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764592710; cv=none; b=G8lxsUYJFWKz+N39E4NdakPSzB7AglJ0QYclXbwGsRkUfnG0bR1Ltu9jwCdFcjUrvdaXYto/GWoDoJk8hTcPLd9SSIeyf3rxgW/o3jMtkj9RcIiNPJqgGelq+Z3KMWp2tv67cPmpgouUg7M53H+lu7DqkqHgvG6SJTYqUNU9dDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764592710; c=relaxed/simple;
	bh=HGu+ynPoXgAe0s5TgI4DJpZFoYNnIfKEUHeSy++Mj0w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rG10IvuQYbyMhb/NiLSZvRBUPrNeR0oZxOcwQS4XIPah4SWk8+kPyb/DjVOUAXmS8auZLNj3NA/y9/tlxu8gFwW7NItWVvxUZYmmAFN3XJrGEfd+6Z/fz3HaFXuZPN2NRFDjpq0WpDwgJfZmBRPqG8B7IaKJWOYtLQVywtZ7fus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-948faee04b5so231643939f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 04:38:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764592707; x=1765197507;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bJHnzAxKZXcnngnZb0PCR2C0mXsw37Dh78lsQRyw33U=;
        b=hvrWh7XbkfABxWtdUjhPeGgEeM7YhQTc2rg5J3c08Po61yLzm6UtSEleGwRK1ZpRXr
         vUhEkRp+0yMeyH8QBh92VG9QzRpJ9m/nutHuMrOlWui0XVtmblMI0k1RdGoUtilgZHC5
         sNyeSEOIkMNqXwvVTe9RT+c/l+4g0yLjoXkpYAO2iwdIC+jTI5o6gxBZc+28+i5zvlEn
         1WvR4Bk127TYa6Ol2jCUitTsS0aen9AUhTC8G2tFLXiYNN1m2WYxtb0DFiukLBm6ziTr
         Ez0hzt3yf+srR3A2J8McDs+NeIHIwuDr2LpGFJ1BYTIkZKG/u2shenPKC2TQ0mAnceKA
         +jzQ==
X-Gm-Message-State: AOJu0YwcGRkvEULj+XUMsnRCXoW5myrRmrspOIAuqFiQTRhlE4/Ucml2
	FMhU6NIAhDq+pXhYObUbFStVHTasLo0RUDPhdWcvtcl7OfEdhz+IsD21PHDrB2Y/1bmT2sCqtt3
	OoBgyvjknawHHPQo0OVmx7IkjNKCVAsGPtleRfQugWCQUJxHXQfKCsL4rnhw=
X-Google-Smtp-Source: AGHT+IGUr6bZz8toMu24RMRCB1ZtXcWG9RoOcuNLxWeozke+XLTzcsVIw09AsUsugx7IMm9/GomWc6soi6ATBfJWgMhCLoaKycNg
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c12:b0:94b:f053:7e1 with SMTP id
 ca18e2360f4ac-94bf05308bdmr362276039f.19.1764592707733; Mon, 01 Dec 2025
 04:38:27 -0800 (PST)
Date: Mon, 01 Dec 2025 04:38:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692d8c43.a70a0220.2ea503.00b4.GAE@google.com>
Subject: [syzbot] Monthly fs report (Dec 2025)
From: syzbot <syzbot+liste59e570350282744e4e6@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fs maintainers/developers,

This is a 31-day syzbot report for the fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fs

During the period, 4 new issues were detected and 2 were fixed.
In total, 61 issues are still open and 402 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  9200    Yes   WARNING in path_noexec (2)
                   https://syzkaller.appspot.com/bug?extid=a9391462075ffb9f77c6
<2>  6901    Yes   WARNING in inc_nlink (3)
                   https://syzkaller.appspot.com/bug?extid=2b3af42c0644df1e4da9
<3>  6451    Yes   possible deadlock in input_event (2)
                   https://syzkaller.appspot.com/bug?extid=d4c06e848a1c1f9f726f
<4>  4631    Yes   INFO: task hung in path_openat (7)
                   https://syzkaller.appspot.com/bug?extid=950a0cdaa2fdd14f5bdc
<5>  4352    Yes   INFO: task hung in __iterate_supers
                   https://syzkaller.appspot.com/bug?extid=b10aefdd9ef275e9368d
<6>  3649    Yes   INFO: task hung in page_cache_ra_unbounded (2)
                   https://syzkaller.appspot.com/bug?extid=265e1cae90f8fa08f14d
<7>  2365    Yes   INFO: task hung in filename_create (4)
                   https://syzkaller.appspot.com/bug?extid=72c5cf124089bc318016
<8>  1925    Yes   INFO: task hung in lookup_slow (3)
                   https://syzkaller.appspot.com/bug?extid=7cfc6a4f6b025f710423
<9>  1654    Yes   INFO: task hung in synchronize_rcu (4)
                   https://syzkaller.appspot.com/bug?extid=222aa26d0a5dbc2e84fe
<10> 983     Yes   INFO: task hung in user_get_super (2)
                   https://syzkaller.appspot.com/bug?extid=ba09f4a317431df6cddf

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

