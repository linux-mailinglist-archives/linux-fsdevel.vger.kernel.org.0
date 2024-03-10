Return-Path: <linux-fsdevel+bounces-14079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A73877737
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 14:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FD99281593
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 13:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C5E2D60F;
	Sun, 10 Mar 2024 13:58:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBC212B89
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Mar 2024 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710079084; cv=none; b=geecU8t0/Wa0JB3PJP/h7sGcezaD6IW7kcvGQdteYX+xRiYRraWFDJnh3UPmkXH/jspZR4Bu/KmTyeUhhrzodt1gjcdnx7ivQJCjGnmMiHHy2WUeVftpl8NQMBmjRMXmHEE91qMP4n79qnwMY4Dy9u63tARy+jvxJtCfbPcr5uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710079084; c=relaxed/simple;
	bh=JyzhFgbDOx6Af7bUiMEd5wkx93ZXqSufoFai6eWCL4Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=et1JoEGn1u6SvBNxFwJzpS/gpk3ccgOrMHPM+wYs9qz5TsEDXr4035LpvIopXDjTH+DI4SesHb2YfhNz1z1JOObXMIA9rJvuT9tnIC+5pgd2sQyttEKMajiO6F4CpAfCWWcpuBtanpdZeLf8eB0Tgunxxie3lhyol4EWfxz7G9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3663022a5bdso22594445ab.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Mar 2024 06:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710079082; x=1710683882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E7Pfnp5j39cfC/fSqSZPc3kGFvrwJmOZXFYwh42T5KY=;
        b=MZ9LfXjJ7XNacDDrJJD8JeOWJXdFclrNr2AZ/yjWP0mRYxyvdCyMJ6Wb8pj7hMxi9R
         dFb9ah7Ih0sahEV5HY7Z448lpa0ay2uPKaPzQaMCTje8pYu4fgjQQUYsKj40syINYsPl
         vUrx7+ZUodk1lHc3BZKIPrjoHCe+1xR0Hclvw6m5uT+mR5vX+a8H7RqWAA16HDKxHSa9
         r/IsuzfhuUJpv0xC+qDZW069wOmUykGXJ19DKLfblPTzVyvAWpd4KNlCT+14/ttSySch
         hjDHHTDMqVHTutixaktlOcsmq+4LArMMPRnjspBdVrpLWxNwqFGey+E/z7vkEq9JWN1C
         gflA==
X-Forwarded-Encrypted: i=1; AJvYcCUuWVonQzQDDQ/xRVoawXevy0DkvSRH6aY1D1aRii7Mu0tXAJxoNV2tAQdSjR1r8ioaCsoZyWEc+5Pj1TAq6YDOmbmoOcNrIFYnQ/521g==
X-Gm-Message-State: AOJu0Yzv2AqLqy8bUEM0nMhsRCHnLsM7m8bCZTOSt7PG8EDlX3tB7Km8
	KEzoosiDqJ1YRWxN/4+iu71UCZyfi61LNgnRGOkoGyUMXTsMEQmD5IgcjlYjFNqrgdsOhDh4F3+
	W6z4V2HpkBeufVFvXTXJmOyR9w5HncvKkMaT3CujvZpXFrYgnN5NAgZo=
X-Google-Smtp-Source: AGHT+IExp4lwXhNhAd5/3buXSf98psR5D7lEbmBh/I8nG3rHvlv7l+v7cW1K/yhJZmdwAlLr/Tjob2ioIYNPPYX5UR/n1ISmSGkT
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214c:b0:363:b9d6:1261 with SMTP id
 d12-20020a056e02214c00b00363b9d61261mr309014ilv.0.1710079082223; Sun, 10 Mar
 2024 06:58:02 -0700 (PDT)
Date: Sun, 10 Mar 2024 06:58:02 -0700
In-Reply-To: <0000000000007898e505e9971783@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003becc106134ed015@google.com>
Subject: Re: [syzbot] [jfs?] BUG: unable to handle kernel NULL pointer
 dereference in dtInsertEntry
From: syzbot <syzbot+c853277dcbfa2182e9aa@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16cb0da6180000
start commit:   a4d7d7011219 Merge tag 'spi-fix-v6.4-rc5' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=c853277dcbfa2182e9aa
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15cc622d280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1762cf83280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

