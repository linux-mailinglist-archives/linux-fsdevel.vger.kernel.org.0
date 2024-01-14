Return-Path: <linux-fsdevel+bounces-7911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AAF82CFBE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jan 2024 05:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0980B212AE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jan 2024 04:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EE21854;
	Sun, 14 Jan 2024 04:59:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C35A1EF13
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jan 2024 04:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3607404225eso64257395ab.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jan 2024 20:59:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705208344; x=1705813144;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1yzbyB1MM/qDWFyaL4yvVd/nqNiYOiwdyqZ6k+sJI6s=;
        b=N9udOADg5Zu79+Wbl2UG+JK/aNr+4afFiCnB54/IT5ClZoYfYNtXCRL4MZMLiFfMn0
         Eg7VP8WId7wLqvVsYi5Jv0Xlt/ShcP9GTbZ8djUBDZ5jxIZcYRQppb6RyJFhRPhVwdqZ
         9hNYc/9k8p9oeXsUVfw+z6Dqx4qRa3HhmHEW0jQWtagfrtK3Eetsdfx4/fw5cCsg/lzn
         F2XRxDM3HVoZ5DpGOJhZqONMrq/FBcf1elUWSu3M4iBYHylYGI6VZeFCRoui8TM0Scpd
         kFHDe0CZkGUQqVEglkaQsWh4aQAb80rjJMUwbslKaaPaVIUKMNdqbnw/x7f7Tn0hqJE8
         feBA==
X-Gm-Message-State: AOJu0YzFEKiNrYbFu4ELQHfsESpGJirB27NE2lFdxZ/7HZXmA7bJJuPn
	cdFbjokhKZBvI+n3SUtkIx0Iog98BAN1Vyw+rtltl4r8dzOp
X-Google-Smtp-Source: AGHT+IHBDuAaOxdVHgR+iN/a+oZFT7qSw7dVS5C0/k0TTWWkBfcAEdgjJpfCp3zy7m15WYrGZPJ+T7WIoz+4GDZDzmBqlgps0PP+
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219d:b0:35f:f67a:e55a with SMTP id
 j29-20020a056e02219d00b0035ff67ae55amr296300ila.5.1705208344213; Sat, 13 Jan
 2024 20:59:04 -0800 (PST)
Date: Sat, 13 Jan 2024 20:59:04 -0800
In-Reply-To: <000000000000aac725060ed0b15c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009fff64060ee0c1b7@google.com>
Subject: Re: [syzbot] [f2fs?] KASAN: slab-use-after-free Read in destroy_device_list
From: syzbot <syzbot+a5e651ca75fa0260acd5@syzkaller.appspotmail.com>
To: chao@kernel.org, eadavis@qq.com, ebiggers@google.com, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 275dca4630c165edea9abe27113766bc1173f878
Author: Eric Biggers <ebiggers@google.com>
Date:   Wed Dec 27 17:14:28 2023 +0000

    f2fs: move release of block devices to after kill_block_super()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10639913e80000
start commit:   052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12639913e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=14639913e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=878a2a4af11180a7
dashboard link: https://syzkaller.appspot.com/bug?extid=a5e651ca75fa0260acd5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167b0f47e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11255313e80000

Reported-by: syzbot+a5e651ca75fa0260acd5@syzkaller.appspotmail.com
Fixes: 275dca4630c1 ("f2fs: move release of block devices to after kill_block_super()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

