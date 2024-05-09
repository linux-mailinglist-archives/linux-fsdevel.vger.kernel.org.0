Return-Path: <linux-fsdevel+bounces-19215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C438C159B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 21:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C2F1C21E93
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 19:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2F480022;
	Thu,  9 May 2024 19:47:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7117C2ED
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 May 2024 19:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284025; cv=none; b=u/KrC5c00AUGezDiqvWUTqR20dYumpjDpe9ZHVPradfak/cRvalO+o29ibZWO1OO32aygLkZvqLkmqwI6/iU80nZv/SE4NPtpCn4JixXSUCFhAmPi5571aIXdufuhQTlTH8tCKwJnK5j/MRb8+Pt4QW5e0vOxV3p4yzvq6V2W+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284025; c=relaxed/simple;
	bh=Kc+4KbDEOPf2dGokV72TS0X0dQSm9vXGDWnMVG+oKpg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=upufHGN8dRy20spVO5v6by30D4YJ840/Hs8IGzem4FaqdBYjvM/Te9SMvjm1UxMCeHhM1mDFvV3UwItK16uxEbtirxS2XQTmvfHwHW4aFFlS2wWUtWqOSQGn+Nfr0+Jjp3cRnR4kMcdv1OyfAgGZQd+dGdujXPbtNbfeBM5AfFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7de9c6b7a36so135654739f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 May 2024 12:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284023; x=1715888823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eUpDWeNdwTu/kjq1nCV2ON4vsT4uwa9sN0FBco+5YAA=;
        b=bNNFYOL1QwM6jW07NARWyFgtGvcZQlxU6MqSL8PwG04hCpmF1AybZiRZh3lxTrLCp2
         OSTewLHgvGyNxr0iyaBYGREdZeECBb4Yt9fICgfO/gmierLQR+FOJrPCF1rupwXKzyMI
         DLR9yt+EcNCnvC0/7bAh5o7n1sGJIOyZtbYXu9ojFMwnf/ZvRGgdn+Xv5rjCbZ9us6fl
         WoBMxh9gfLhQQOaQoqhiTktTfQTBcoZksFRSLpnSZ9PvJYx5bnjBjAyI9V2pyz+BBYJ7
         guElWL3M/vp3CJf8mlRkqWscfCIsHaJBBNyqBV2VEI6X+2grYrxatHo83Mp1r7wS6W9o
         gmJA==
X-Forwarded-Encrypted: i=1; AJvYcCVh0LqJk0IkCdDSDPbfTzfqmcrMKSsJvV85OUFVh8ugXYIAei4YKJfG6J7qajGpDzX+FtT9xFZ+uw7vJ/XNMO3E1ZXwDhHi1WSUjSJDkg==
X-Gm-Message-State: AOJu0Yzq381+kY0K4gi7auQwNkjQ3hMXbaF+SUq4wn0PWK/N8hlEetCb
	HhqaYGjn129oF5AtHtFuXCuVLAZWgpRn4DeHANfu0RxdSYXvemHp6c+6vq2SdtWS8J8YavUgCw1
	LnpW1GYpo5jixfO2tUTrFsznYtrkbiNJ9LPt0k85NtzM/xNqZA5TNV9M=
X-Google-Smtp-Source: AGHT+IFL7mpUk3NvnsMAFAD0opjcqCMStNVhCeAo6AMI+GlYk2KsYMOEnWkz4hm+4MpqDd+OAdaM3pp3FucnoGoAOtmsWL18I/gC
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2727:b0:488:7bb2:c9fd with SMTP id
 8926c6da1cb9f-48959341c45mr32573173.6.1715284022834; Thu, 09 May 2024
 12:47:02 -0700 (PDT)
Date: Thu, 09 May 2024 12:47:02 -0700
In-Reply-To: <0000000000009f0651061647bd5e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000decb7906180aae28@google.com>
Subject: Re: [syzbot] [fs?] WARNING in stashed_dentry_prune (2)
From: syzbot <syzbot+e25ef173c0758ea764de@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 2558e3b23112adb82a558bab616890a790a38bc6
Author: Christian Brauner <brauner@kernel.org>
Date:   Wed Feb 21 08:59:51 2024 +0000

    libfs: add stashed_dentry_prune()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=111fb9d4980000
start commit:   443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=131fb9d4980000
console output: https://syzkaller.appspot.com/x/log.txt?x=151fb9d4980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=e25ef173c0758ea764de
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12fb63f3180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e68f6d180000

Reported-by: syzbot+e25ef173c0758ea764de@syzkaller.appspotmail.com
Fixes: 2558e3b23112 ("libfs: add stashed_dentry_prune()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

