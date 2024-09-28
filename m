Return-Path: <linux-fsdevel+bounces-30298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DCB988DB5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2024 05:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A168E1F220C8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2024 03:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A68165F05;
	Sat, 28 Sep 2024 03:15:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624DB15B13C
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Sep 2024 03:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727493305; cv=none; b=QMR5d6XSZJUlaWouPdT69DDUfcjFZOHmR9X2AbBi65PGf7iJ9EIY7W0t7SgOaKF9GeNx7fKFcaWuwJWCoQG0hbxCYtqjfpsLOYXLdVBWKg2AkMhJezM6m6DEyO8H8Yb8rhv94O8cesY70tSffZ3FaOVxw5u/Iu70NV16W0tbFQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727493305; c=relaxed/simple;
	bh=GI5PlcA7k1T0SPN11Js8TGmiwDLVxJmVmNY0LpQ2u+U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Xc3DXD7QjrglrJ5QnWeM9myPxqYAnKtUdnHUqzAVyEEHnpgpCnK0ZyZ4PYzCVC2ea//xoLM9E6MC2x0Ow5b0aVzAnXs2t0Xb97eI2oWit7JgPANeT2K93CZW+WaYWdx0g56j6RHh2DtuM1fxWj1oYWbZqO3BU5ttYyA4rwmgCUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3440fc2d3so22794095ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 20:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727493303; x=1728098103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=of15A6+c6OVOnBSyfpHxoxeIJmFo7yniresxfuX6ydM=;
        b=eAQUaTOn4bKHoWyVLUxWyT0G5M/9peQbVImrBbO+aSGviXvn0+WJSsGh6L4GX333Ph
         AscaI5j8NZBj/1/IsihpG6GhAZU9Cu1MUdXIsEADMd69pQ0ufPyxHOQGH7XTQkCNkv6x
         IlLQWeauxM4jCD6EsF0hWySyR2ZJETtMJGBcoJ/m3nhiVo8ljwf2ZzQfBAYdlAT/Juw6
         gaJMKIbhpg85/Cj/RRxdW/6IraO+O3h9C7v3zDP8N7GWyit2FwkG9BjrKuPyU0X6BUcL
         ks1lOt+LfY8MB05FHlj7/23QcazIWkFroc8fZaG/21qk6/7QHvfokK0IQ7CwiiwRD1pE
         NRMg==
X-Forwarded-Encrypted: i=1; AJvYcCX8z1kGIAJIMeBHrmdWpstELLBx8/OC7x83rGm9LGT+Be77f1IACeW6fbvMQ8Y9FFhNOzlYpfHmHMXt3qOf@vger.kernel.org
X-Gm-Message-State: AOJu0YwhgEI65VLwVDA3iUGXnhgbDuHMhukiUalw2mh3cgS+7ozXiMZO
	9hK9oWHob12/z7XToGQCGWQxKcqaOCbUqAKXq7hhZXEwT5o/gmJjVWfndomvUV2X8H4H5EGcMAb
	lv5EL2kHq0iLSPeqDPPG1eZpr1wDqrFu/von/IUdZdtWwEVV8lcXXBlk=
X-Google-Smtp-Source: AGHT+IHu8aR870tmrsFMAh7OqP99syBX1HGq/p1JiP29OwoRwxJ4K6Doqd4JttMGza8m5LGwv+PabDf3IkTBzM6HF66aIQu76fpN
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a7:b0:3a0:92a4:a462 with SMTP id
 e9e14a558f8ab-3a345161df1mr54434605ab.10.1727493303471; Fri, 27 Sep 2024
 20:15:03 -0700 (PDT)
Date: Fri, 27 Sep 2024 20:15:03 -0700
In-Reply-To: <0000000000002dabd805ee5b222e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f774b7.050a0220.46d20.002d.GAE@google.com>
Subject: Re: [syzbot] [hfs?] possible deadlock in hfsplus_file_extend
From: syzbot <syzbot+325b61d3c9a17729454b@syzkaller.appspotmail.com>
To: aha310510@gmail.com, akpm@linux-foundation.org, brauner@kernel.org, 
	chao@kernel.org, jack@suse.cz, jlayton@kernel.org, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit be4edd1642ee205ed7bbf66edc0453b1be1fb8d7
Author: Chao Yu <chao@kernel.org>
Date:   Fri Jun 7 14:23:04 2024 +0000

    hfsplus: fix to avoid false alarm of circular locking

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16c5f59f980000
start commit:   90d35da658da Linux 6.8-rc7
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=70429b75d4a1a401
dashboard link: https://syzkaller.appspot.com/bug?extid=325b61d3c9a17729454b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=159253ee180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11afd4fe180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: hfsplus: fix to avoid false alarm of circular locking

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

