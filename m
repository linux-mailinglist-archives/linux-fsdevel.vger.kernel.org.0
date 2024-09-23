Return-Path: <linux-fsdevel+bounces-29848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D13D97ED5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 16:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD781C21308
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 14:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD3A12C526;
	Mon, 23 Sep 2024 14:51:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF45276056
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 14:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727103064; cv=none; b=d/iw5YgLvhHaV71iv0f9wixF53Sib7T5y+NznL08QdKT6K2wEneXqUlKPivl2non4fDaPp2Nrkrkb/igrldMa/c3y4Ya0zqTmC/55Jhndaa01h6SEw8AZnmsemQXsm73UREuVTVuV8GoNq5ofWcVhO/t4q1TYG0gNhEAQ/4l8eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727103064; c=relaxed/simple;
	bh=YsLNiuzmi1wrmAuatVC6xslA+iYn5hgaujYclaNzQNk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ktz1mPuWDgZeLj1gmoMmGhyEQirlWrlWc9mVmUBydlq+Qi9E7gqycZbuyYGJb3C7mravR0Nf7civF1K6wpcaHs2tacw3wDUlpyGu0fw4ZGzqfWykGzUJnoXY9swUjrdiMhPVrR+8o2Fj+TWtIzs85Eg08nLbq+5fr+T94GkL8po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a0cadb1536so34810405ab.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 07:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727103062; x=1727707862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7AeTkDfohCw/ioRoFoMZY7YtsBLLJmfv+55fxk/LPGI=;
        b=v800AuLP/h/bV9wggeQGR1hqZA09vmPfagbjE5SAsQ70vCMFFArfDJvehgHfYhQvl/
         aMYbpi5wlIR5RZuOY3Z5qKHQwWV/X5x4dPfm2Xb71O2xY6zmejWP5JqF7bl7zqLJCF4I
         h5uALoqw2/pNq8cmqlsnY9LI9z0trqdNvQHUTV20Gkkd1Oa0VOnAk/6oaZaqiEb0upLH
         LFNOA5jqDtCLnfgmWtGYuHN6A+0+iaAbYnIyogg+7aU9ijtNswddj0jH0/bLU9Q1NiCn
         F91x40PxMVlYeXjUzIzXhQVF0r6ERCIbIwwbaKaDuUk3DP8MiJwdJBbxRZHpXCoDmcAm
         QMLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5MpKE9z3yf0pUfGVQCHHgMGsJlthIfn4OVOI8KSXqJBhrxdBHymse1c4RmYOoN3n3IwAjNGp3o7u+1tpb@vger.kernel.org
X-Gm-Message-State: AOJu0YwWpqD+ABJNxCKTXn2p0qZUYKU8Vp/OaxqdfnW87Zx6o4REBpi+
	5ohz8HIMszrmj136wn5tqsF9ym+ZR4C0UuRqOIF6Db4T7x7E/gOicCWA4eaPiLX0c7OsNtRs2u8
	rslv5IL1WhffGqQZX9Sh6C+NWM3mEVU+UbIUMQEZ21/4tNsji9N+FMC0=
X-Google-Smtp-Source: AGHT+IH9lk9hJ5CpOJ1knBbw04q5l9TGSb5ILPuW81vINoazoI9gxgu4rXH3nmHuWg+KiTAzWocxiuPWM9jrIO2nGvOao3NIMESk
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0d:b0:3a0:9043:59ac with SMTP id
 e9e14a558f8ab-3a0c8d387bamr103314065ab.25.1727103062089; Mon, 23 Sep 2024
 07:51:02 -0700 (PDT)
Date: Mon, 23 Sep 2024 07:51:02 -0700
In-Reply-To: <tencent_E58DB7922A5DF0DDAB19394FA78D84A5FC07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f18056.050a0220.c23dd.0010.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfs_iget
From: syzbot <syzbot+18dd03a3fcf0ffe27da0@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+18dd03a3fcf0ffe27da0@syzkaller.appspotmail.com
Tested-by: syzbot+18dd03a3fcf0ffe27da0@syzkaller.appspotmail.com

Tested on:

commit:         de5cb0dc Merge branch 'address-masking'
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1374619f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=547de13ee0a4d284
dashboard link: https://syzkaller.appspot.com/bug?extid=18dd03a3fcf0ffe27da0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=178e858b980000

Note: testing is done by a robot and is best-effort only.

