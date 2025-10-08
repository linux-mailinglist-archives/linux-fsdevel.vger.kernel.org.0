Return-Path: <linux-fsdevel+bounces-63573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D58BCBC3661
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 07:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2A03C7CA3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 05:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28D32EA49C;
	Wed,  8 Oct 2025 05:52:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00B02E92D2
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 05:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759902725; cv=none; b=pg+CaU887BLKqwXwx88CUTeaZ2S+Y7M2h7SiffkVMR+QQf3HKRHLXSskqN1v73RkkmtHzNiXZFfYzvKL1wNcFtbGbgLocpT55Okawxb+b+HC8K90tte6gkRqNpMJGaJ5pVPqbvc9AAW193AlDTluyL7B3TeKFdQdp2KYBFsUHKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759902725; c=relaxed/simple;
	bh=rISreA05oSPphUeXePaG+iNGh6KKZHmaHX0gxIZn55s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Qdt1v087n0J6/HzPQ4QKbObIIMgj4MSvS9zsNdc/ewGHkC784RAIFHoRedB5gE5kg/y+aRX/SP0Ma/L3yeV8pX/5KrKcdrmo47ErfbHhG0mlvRrrYQwgw4X75CcvInb/KC9ZetBtVJsDxpxxtCGwGgyLF1SFzrQDnOEckZzaKnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42f6639fb22so59724425ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Oct 2025 22:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759902723; x=1760507523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2A6jgIs23tCx0rnkILPWDEiPNOjzuEXCnKHJ2BUu/Ow=;
        b=pBGzJDAoQmUwQb0cmM/zmDX883Q7uMcU1VwSxYSa5tBQCT4+Bej53ncDMLgMnqDPTF
         6AMIZKqOnFQRinteGqEELIRGYSNCyklvWDUc6TrFQrgdoSpHTgRqQAw0E/3JrK7xvEYr
         rErF1cKnhfYDeBwyfMpHnaoA34d8eUPmNMiQEUgryUlcldEzZA596xzrVgxlQQLMdsMs
         iNGr4a86wnTt/mdBNM2IsKMfNbeCittrL6Zz2Bn9YAog7lFXU/2dqCT5qYQVwiiLXEe1
         KX7DQ7ReL2DRaTD39HJGQk/Mth0afv5sbpqDHj/39TAPsbwwh1dj3CtpnTBpcNUczoZe
         BT4w==
X-Forwarded-Encrypted: i=1; AJvYcCVZka6ld5VtJN+cTJRTU4P4I9ZR9NLUtN1LH0PYie4CveeedNDPjlC5hucf+Sfu9jGbwWN//QgPOCWcSvsl@vger.kernel.org
X-Gm-Message-State: AOJu0YzKqTD8jsWPXKaOoAPXehBBGFugM0m/qRl2X8lajV64qGWgjDkq
	5taXpRimiJ4IZy9RvntptWp3V5xxs9Pzv2ffrTh9XYGNKw24iqQyQZKQMLpa+m0WbWrT0KNJexv
	+b+xaB0mJtfFZL0bj2prR94/JV1L4Z0WwJKzG1gGjebwjPqzmOV83r6a/mEY=
X-Google-Smtp-Source: AGHT+IGptM0/W+RC8JNNbvxwbL47syZs+ieVCOeFF3bOYyE+bsCsNYCyWyGD3xDDyj9zvgbuTmomwlV0EBz0plohKVovC+Xba1uN
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d98:b0:42d:7f38:a9b4 with SMTP id
 e9e14a558f8ab-42f8741b733mr17558735ab.31.1759902723031; Tue, 07 Oct 2025
 22:52:03 -0700 (PDT)
Date: Tue, 07 Oct 2025 22:52:03 -0700
In-Reply-To: <00000000000054d8540619f43b86@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e5fc03.a00a0220.298cc0.0488.GAE@google.com>
Subject: Re: [syzbot] [exfat] INFO: task hung in vfs_rmdir (2)
From: syzbot <syzbot+42986aeeddfd7ed93c8b@syzkaller.appspotmail.com>
To: brauner@kernel.org, hdanton@sina.com, jack@suse.cz, linkinjeon@kernel.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, 
	yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 79c1587b6cda74deb0c86fc7ba194b92958c793c
Author: Namjae Jeon <linkinjeon@kernel.org>
Date:   Sat Aug 30 05:44:35 2025 +0000

    exfat: validate cluster allocation bits of the allocation bitmap

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1695f92f980000
start commit:   4a4be1ad3a6e Revert "vfs: Delete the associated dentry whe..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=47d282ddffae809f
dashboard link: https://syzkaller.appspot.com/bug?extid=42986aeeddfd7ed93c8b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a5b3ec980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103820f2980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: exfat: validate cluster allocation bits of the allocation bitmap

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

