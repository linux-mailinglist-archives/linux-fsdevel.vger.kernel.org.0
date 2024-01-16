Return-Path: <linux-fsdevel+bounces-8027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 239FC82E7F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 03:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3B2284AA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 02:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F37A63B6;
	Tue, 16 Jan 2024 02:39:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0594139C
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 02:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3605e854428so86816895ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 18:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705372743; x=1705977543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R8ngSSPwzCB0UkYkbu61dUKPhREiPfQ00rNKuZC6dDk=;
        b=qGKprk1BWhODtECFqTh3BmlMW44ZQxpRHcQyN3IJCvTa5Gy8jwKYwFYz76NqMzMzBB
         vtT+U/NQaVkliO0HKu0R1/lH9v2dqqcoovJuyH14NAGYLBtij2E5P8OSogevQIz9+3WZ
         hEolt4LyX+USAjQfnVkipOP6QxevpjeO5tqdpUHYk/S0ESdF5IzzynoGSHxNfaeMrz9o
         zuP59wWjW6lchskLylwPK7YNKiMeym8XQU4ywu0oOf1yydW2Exvw2arPQNNrhQ1IdvBj
         1buAQvutOXXikC2KINPGS8wAuuxEHgVKlL+EnSoQBrKNABSLGDZqknl6lupF1+bNhJx+
         UT9Q==
X-Gm-Message-State: AOJu0Ywvq8YONksl64KlKQtQ7/EYhyfEg0sv12yrFOvmp1FmeG7VZUMB
	Hl3Cc8C4GU0mK9DyJk5Qqu31cVNpnl0GiMc3bGh8zCnQs/ND
X-Google-Smtp-Source: AGHT+IF0htZV9KhM8gbYJ54QSqHGhvAd6WcMRYrYtG0u5BuXmXVySNJVn+qVgx/cckGoEkmnUvxczpFtCgCkPNpbY6dP9XYh0v6N
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c6:b0:360:97cb:110e with SMTP id
 6-20020a056e0220c600b0036097cb110emr665657ilq.6.1705372742987; Mon, 15 Jan
 2024 18:39:02 -0800 (PST)
Date: Mon, 15 Jan 2024 18:39:02 -0800
In-Reply-To: <000000000000b26907060cb9f1f5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008e38b0060f0708bb@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in __run_timers
From: syzbot <syzbot+a3981d3c93cde53224be@syzkaller.appspotmail.com>
To: axboe@kernel.dk, bp@alien8.de, brauner@kernel.org, 
	dave.hansen@linux.intel.com, hpa@zytor.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lizhi.xu@windriver.com, mingo@redhat.com, reiserfs-devel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=152ab62be80000
start commit:   88035e5694a8 Merge tag 'hid-for-linus-2023121201' of git:/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=be2bd0a72b52d4da
dashboard link: https://syzkaller.appspot.com/bug?extid=a3981d3c93cde53224be
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15befbfee80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b20006e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

