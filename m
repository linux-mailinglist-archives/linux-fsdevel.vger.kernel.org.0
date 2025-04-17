Return-Path: <linux-fsdevel+bounces-46641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6BBA92B76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 21:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F33FA3BA882
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 19:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8A21D6AA;
	Thu, 17 Apr 2025 19:05:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AA21B4153
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Apr 2025 19:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744916704; cv=none; b=f7KzGWC1rECgf3RIlzDAYNau2cBeCVx1/qumYOCH1Xd5B6NbefltoYZCScShV9gV1pTeNqZ8es2cHPKR3zmJV84u0SVUq+TLH4VJjoAX4Fd9mSxCiUjg/C8q3n3LZEo1bxOlWIltrDAi8jFceFg38voEjses/TsXOBib7uvNghw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744916704; c=relaxed/simple;
	bh=Lp/x4hsyjk1lrQeZ1Kgo1pqlXATJ3hoYx3Qb6KavKlg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=p3E1xrf5RWT19sWePqlM4RSB1XCw9Ug89RvJ7XPu2iWwu/OZ7FREFac9I/azrVb+z9x3RwjkCYB+oq/SJlCdlj02uNKgkt+bqFbp29MTylFCiUQBnaOxgBZDnABqRejWiCyWS2VM9pDVMw5NV/vwAAvDjkh//ojudev2O8RxECA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d6e10e3644so12196505ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Apr 2025 12:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744916702; x=1745521502;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KDqIhlkWTqThWDXFkLVbvNGoVB1KtUo6BHvjxJ84as0=;
        b=eFVzO2aUcyMg4U4PVU2pUv/him2wZbULiLqDBcwfq6rN2PsW0C/sU6+F7I0Vgz9tF2
         XvtmhIOagfiF/KBdP8HxWMhSmN9HFnKKXUs13RJrkfqnfUrFiD2iC4HyYxfa+Ec4jPmO
         Y2FfJuWhftBPWbG61EVoJPg8w9s0tkr+5G1VwrJtTQlcXnOoaQgaKufky6ikmJxb+r0u
         YjNeChHc2ETN2+Rz0rBzr6rAIGG5ImpQoj5YZoOEYMI0CFBITaC6z8x54Ld4QobW1zGe
         UAe7xfWXthLtBR0i/uy7Jjcr1gXDWHAMg1JtXikWUWIESGioILP+mLUBxd9hF4SzuTQe
         TAtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcvmiyPSky6Izt2cKPKm+3zmULePwbxZ+UxWYeMn/8LxX7KPIaW1DqyrQaOVCqPG69L/z4LN0ljNvhYLy8@vger.kernel.org
X-Gm-Message-State: AOJu0YwsaLnyZJqnLm84L2FEuinPI72Ji1ulydlivla9RqN9X8x+X/8n
	M5F3qiRrxoPEaHYC5qgrp2mCXKFRONGohY4pwZuUwA1WYjS+86L7t6K4vuJtB7fGmbYkciMK7d3
	Y+3rWg4X7WgWGVzT3/Rc+yyXZBW8d/2vFZ2lM/GKAY1sTw6CDY16wfFQ=
X-Google-Smtp-Source: AGHT+IGMy3JS/eMvnnBxJwZNSXj4+Ok3tvc14TB9u694TsHVxHKohoNEk0XUuZ8ts04fZXTAk2+3+VT6CLq/z8y1+ILRfSTHA3Ub
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0b:b0:3d8:2178:5c79 with SMTP id
 e9e14a558f8ab-3d88ed9561bmr3343255ab.7.1744916702351; Thu, 17 Apr 2025
 12:05:02 -0700 (PDT)
Date: Thu, 17 Apr 2025 12:05:02 -0700
In-Reply-To: <679ff200.050a0220.163cdc.0032.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <680150de.050a0220.297747.0000.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_btree_node_iter_init
From: syzbot <syzbot+7b8a2c442d5a4859b680@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mmpgouride@gmail.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 3a04334d6282d08fbdd6201e374db17d31927ba3
Author: Alan Huang <mmpgouride@gmail.com>
Date:   Fri Mar 7 16:58:27 2025 +0000

    bcachefs: Fix b->written overflow

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=125aba3f980000
start commit:   6537cfb395f3 Merge tag 'sound-6.14-rc4' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=6cc40dfe827ffb85
dashboard link: https://syzkaller.appspot.com/bug?extid=7b8a2c442d5a4859b680
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1055c7f8580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bcachefs: Fix b->written overflow

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

