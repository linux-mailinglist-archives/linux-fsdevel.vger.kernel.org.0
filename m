Return-Path: <linux-fsdevel+bounces-17943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D5F8B40FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 22:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA8D1F229EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 20:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996C428680;
	Fri, 26 Apr 2024 20:57:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049801EEE9
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 20:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714165024; cv=none; b=lGEUrkJB60jK78D5nRVIFr8hELyvje4oKYgeDyPrryc3MwLbF9jsxXqb78eFU9Pf4h0ZBohSQqWlhAKLJfTBg86E2iFZ/s920DP2QPvBBHEmk510W41OG4DW4PDc7DtY1wgr/NH445KI+8P7icGm5edWjBtVKaXix5WqDGLQuQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714165024; c=relaxed/simple;
	bh=ColKp8LTeqV3MomYovw1AaLOb4uUmnU2k5nxP/XTD6M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qFcWuaD831Wtw18KDXM73G5Xq+XdiZiDga/os2kwhUhen6lvYuEZYbafpRw/l1keItbsCFhdKQ1QFuEyd9LquPqHiVpkOxNhyKFcf8yhbHD7j90mvGF4yDCti175qqI1PSb/2bXpvW5C2B4Z73ntkSy6z5OkmWhew75diHiQxhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7dab89699a8so258580939f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 13:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714165022; x=1714769822;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wmPxjA1cjQgQAONaZgBDFgfHJ2vCvymGfali2ADE1s=;
        b=KLcAV3K0C+PMeaDroXtdcpDg9ngZGaJ+4tgmkndQZ5MI2MxI9SfY7Y09el2ifHZnF6
         nDuRfj9LJzBzCGrkBi44TzqYpXYeKB+7KwkVaaWeaa4s+Tin3PjuMQ43VURJt1YT90gw
         CUVjwnlmBuXoLjXH7V2alt8WvuHwTYLbkXh0TXgcF3DySjm2RR33kpPToic1bF4uVp2v
         i/1CTdEI8SAePoE+hnaFpFyOiMu30XlLsFpz9QnwidB15SNBvbJLZYHeL9vR1TMuG+uZ
         fkZVXil0H8ntUTtqBM2yuq73D3XPU533h+FCH3ujDc2jDr+nj7QQZIsyZ+IzUXwW4jVW
         4c/g==
X-Forwarded-Encrypted: i=1; AJvYcCVUpgBaeTGekQUiTdi0+dMQhmk4cZ9LcDctmNahAHJjwBIMBQUyyZZnhdrZ+t2RLLfdA7AFTo44ZWBlp9mNrU4qEPjkPZtV6w5Gx/SQ4Q==
X-Gm-Message-State: AOJu0YyUxD5TW8cmOMSkh+wNFTHjqide4o7A6TC09c7BQNUAr5D72EEf
	HEIGk4l64Mk3Svk88AR8g/rmg8txss0YxYmvJBNZUp/3n/Mp3CFR8dmpuOOl+5w920DBNFC3c/e
	lX9/pmau5pfa7f6dx4JXITDMXzOmbELGy8hxGN1QtTBrcxLj5/wWugjE=
X-Google-Smtp-Source: AGHT+IHBare5qaUO/kJwI42/lbgUs9Vos7M9Tuo43dypHaC5WkLmbSXOx39jMzLVqNXtInVCffs3LOc42jWH6h5bBadKTSIgegTA
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1451:b0:487:1189:3544 with SMTP id
 l17-20020a056638145100b0048711893544mr312104jad.3.1714165022327; Fri, 26 Apr
 2024 13:57:02 -0700 (PDT)
Date: Fri, 26 Apr 2024 13:57:02 -0700
In-Reply-To: <000000000000f386f90616fea5ef@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e1ae2061706252a@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in chrdev_open
From: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, 
	clang-built-linux@googlegroups.com, kari.argillander@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit ef9297007e9904588682699e618c56401f61d1c2
Author: Kari Argillander <kari.argillander@gmail.com>
Date:   Thu Sep 2 15:40:49 2021 +0000

    fs/ntfs3: Make binary search to search smaller chunks in beginning

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=144f18b0980000
start commit:   e33c4963bf53 Merge tag 'nfsd-6.9-5' of git://git.kernel.or..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=164f18b0980000
console output: https://syzkaller.appspot.com/x/log.txt?x=124f18b0980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a05c230e142f2bc
dashboard link: https://syzkaller.appspot.com/bug?extid=5d34cc6474499a5ff516
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11655ed8980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12499380980000

Reported-by: syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com
Fixes: ef9297007e99 ("fs/ntfs3: Make binary search to search smaller chunks in beginning")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

