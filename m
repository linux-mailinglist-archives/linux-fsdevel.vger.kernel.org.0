Return-Path: <linux-fsdevel+bounces-67417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB74C3F16C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 10:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD74E3B04B8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 09:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22B8317715;
	Fri,  7 Nov 2025 09:11:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE44F316907
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 09:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762506665; cv=none; b=Zm0ypJ2T4bCY88MbIcjwAy8qPHY9yNlAScXKgpZcivgAn4Rejo3KfOIy3K/2BlxVcH1Oym35LXaBj0FvlUo6TMp3WAWstuc7OQfmftgx3ryUEcEKZho6EHOENmhH37YWs6RSawP+OHx8bYGfQuIBecmMW/sj+g+SVpl79BtTnLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762506665; c=relaxed/simple;
	bh=0X1ghcfB02TLkqvJN/K9ODmXaUSsTTg9mWNYYo1nTLA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KDsrZX8vbLvYl6uwOAwOm3uvyk4192kaPMvl3MfQL0gw/h1dgK4Bl76VbBMYUjaqtkTfS+ogL+ATTWHTgb5paxLGItg4dtxyvjF08ILNzjl18ftaUmJyZLe0UE9iOKxd9nT99yyMfeExcjHdePYG+lMcJfab0Y1/1VdfDf6a9a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43331ea8ed8so4447395ab.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 01:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762506663; x=1763111463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mYikHAEUL/saSFKLYHHeo8rdkIeAMjFOGtkJrMNYVw0=;
        b=H6dAy2v3ES4dI6gAfhFLKTQCOSvQyLeFFi1W27av5m/tG9Qv8ATPkSGQtxBFdGqNrq
         wbjBuG/du89lDBx1TNPb2XEc/nAFIHqFxA0m9ETg4NlQFAfDq1tsJiHvEFJXZXBCVfF5
         NM8D7jPLi6UOxAD4MvPvaMwnob0MqmzsO2HNL6zvj2Q39h0mcTeozbB/HXIjdLSbTXFI
         j+/hD4XIznSYRE3ZGX/A4auptQDbfs8jq643ynTk0Kmo47F+/MMM5pva0zHYvB8ScIff
         8xRfRw2j18evzNNspMzMa4GCEtVEWLBSh1tYgl4XsNzc/35Hcb5CmNSekXn5b7ePb6bK
         H5Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUl3Y3x76NAhXXsqC5lrmhULVz5aExRHzTeXYgy4j6n2ZAIOdh3JNVsrgM5X1JWAQMCJms4Nh6V6tstWuIn@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5iAAL/0gV32GthMRpgdQeGPoHJRFGFBdSDzS8IA3mkVTvOME0
	GF3ByliCVWR3G7MxqT7hOLvo8zvSpl9qUVzDYY9mQLvopqDhUgBW8ieba/EbPCXvPAPmUHYg3Gd
	KJtClu1icBygWM0vXprvfQNrKPdzKbmBKRpnHawcTvVDJxEmyFpg6dwLmxno=
X-Google-Smtp-Source: AGHT+IErzOQ7//v4VQB6zTO0Xg0CKL3LrQUKyONErqYqpNX+/RP6WsAtLF5Kws28cG3k81vUpLngvkayi8Tb9oVqdd4KLBvvfc7t
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c23:b0:431:d7da:ee29 with SMTP id
 e9e14a558f8ab-4335f46d880mr30944475ab.28.1762506663084; Fri, 07 Nov 2025
 01:11:03 -0800 (PST)
Date: Fri, 07 Nov 2025 01:11:03 -0800
In-Reply-To: <690d2bd5.a70a0220.22f260.000f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690db7a7.a70a0220.22f260.002e.GAE@google.com>
Subject: Re: [syzbot] [exfat?] WARNING in __rt_mutex_slowlock_locked (2)
From: syzbot <syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com>
To: Yuezhang.Mo@sony.com, brauner@kernel.org, jack@suse.cz, 
	linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, 
	yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 184fa506e392eb78364d9283c961217ff2c0617b
Author: Yuezhang Mo <Yuezhang.Mo@sony.com>
Date:   Mon Oct 28 03:23:36 2024 +0000

    exfat: fix out-of-bounds access of directory entries

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12217812580000
start commit:   c2c2ccfd4ba7 Merge tag 'net-6.18-rc5' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11217812580000
console output: https://syzkaller.appspot.com/x/log.txt?x=16217812580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=5216036fc59c43d1ee02
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11062a58580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e19084580000

Reported-by: syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com
Fixes: 184fa506e392 ("exfat: fix out-of-bounds access of directory entries")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

