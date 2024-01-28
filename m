Return-Path: <linux-fsdevel+bounces-9231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ECD83F483
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 08:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C568D1C21F78
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 07:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1466D51C;
	Sun, 28 Jan 2024 07:18:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D28C129
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 07:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706426285; cv=none; b=YWBUFpF/Cjxqxu3U/VR8vNjch7xl4IYFQZWlPfRPJrvSPDd11FEdMCevihhaNxJ+MTWqKu/iNfjA0vW4Uo2+j0hahBn3bPTH2gp8TqGqTiTMALB5b9l7huI7m2PvrI8cWkAzlaFgjJx5FUPWYvshFnCnYdJewsM/htxOV4ZLZrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706426285; c=relaxed/simple;
	bh=D6ZyoKTF6L3wn7H4QjFvGhyvGvKbYTYFoHnQj51K7pA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eHdH5n94EWoB0DFQ6OtSN60mUdZmbQpzitFILhicYhYQhutKHckZ8hAtdMwEZa7jiZF5V/8McRW48KOd0Wc1DJZe8vDSYT3NlbIOf/pRTJFPxYAM2kT2NHno97XXRafnxPP4UViOs45C6HzxyPxRMvaXL3AUnkG5rxGFjEtDEz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36377aafa3bso3516095ab.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jan 2024 23:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706426283; x=1707031083;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ul8wmNFSCMVhgffO/ITwaHvUKPduHDAXYkg9gcF38LQ=;
        b=vIJqTCxwhYjyOa9Yz2Pmsv13K/mC6SyopioVfvdHGNHq1CVVbSkAVMiqoaxUp2NlWs
         3+md4n7w1h1eOCBAwIhjn90fzWp9OP9cuqANWANcc+GICBLd5ThFej/d4/nij9k+cQlj
         j//fc1R+SGEJDlIaSFc/aPCVt3qHA2pLGzgxz3lYPpWXbFBX0smwIizFXWyxkZB6wD7V
         EKG4839p96WNmhRWF6och1rq5ik8xY+0P+CF5sd+TRtXnJw8U1OVNDsh28w8ha+aEliq
         NkOLGYCB+AhDG4XbCa6+tNlhoiHz///TH1OubMbgbGvTB942dMJAqCuzToVxfiuykwHx
         amtQ==
X-Gm-Message-State: AOJu0YyVN6gCbecP2E0rWpcPKaoFuFCYM2xa7k4Grq8DQGZxrGGlVX4F
	Ckht4zcGd03VWBt/UX7zyfyCuREoKKNh443KTDJEohCgYGNsfaJvmlMD4uY8yIRzL3nELFzPR6s
	79QvlUkaCR/OCg1jb6rcTiQ1FnS2iLLyIgPaoIcL5ymrcFdt6gnXmb/Y=
X-Google-Smtp-Source: AGHT+IE87ax8hL/iicqYU4HAN2acMDSk8ljjHL8DXHbMp3/VT5KWOCFtGyYxsWaFr43s1p6HNGKprBlfxx1Usk9EN270xb77Heb0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1808:b0:361:9a68:4891 with SMTP id
 a8-20020a056e02180800b003619a684891mr353817ilv.3.1706426283208; Sat, 27 Jan
 2024 23:18:03 -0800 (PST)
Date: Sat, 27 Jan 2024 23:18:03 -0800
In-Reply-To: <000000000000c6ec640601d95e6c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000072355b060ffc546e@google.com>
Subject: Re: [syzbot] [kernel?] general protection fault in timerqueue_del (2)
From: syzbot <syzbot+500a5eabc2495aaeb60e@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org, 
	peterz@infradead.org, reiserfs-devel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, yukuai3@huawei.com, 
	yuran.pereira@hotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=172204dfe80000
start commit:   4b954598a47b Merge tag 'exfat-for-6.5-rc5' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa5bd4cd5ab6259d
dashboard link: https://syzkaller.appspot.com/bug?extid=500a5eabc2495aaeb60e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169efdf6a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13733f31a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

