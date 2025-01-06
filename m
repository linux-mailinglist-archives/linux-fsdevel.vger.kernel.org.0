Return-Path: <linux-fsdevel+bounces-38417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B367A022B9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 11:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C503A2BE5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 10:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8773B1D9A40;
	Mon,  6 Jan 2025 10:13:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D021D63C0
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 10:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736158384; cv=none; b=MJGnrgu4IpsCgyQ/H43far0EL0Uz2K4P4YYW+vIS1a/TIIVOUiJ8nwlGn1mJy2fEEWyOCUC/xYfAncdFlHhSyp1rR4hjpJONsghlmpgYo4WQS5C5xHwpF7zChCfhuXgj7SpoHkuFvzzBgYXC/tyzM9dlWCgD5z95TUaMBAJuHqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736158384; c=relaxed/simple;
	bh=XeTcN8HQDf70ty/qif6ItyOM19kAeUof8p1RZpWKrbU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WjEXguusfgFgbuCz7h3sDW46M9QYZRyqsc4F52iLOxbvp47zFD2M4oWypoC/yvIdwQjjF0ksc8Gh1Ubu/A3m6GZzao6t/vI9Ua64TioIGqdMuyTvFcXh4Y/x+Gt4TqZQJwNPcOrHXTccB5HGa7D0/s5LnYgWapu3xBKJpWk4+b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a9d4ea9e0cso139482315ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2025 02:13:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736158382; x=1736763182;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xtWZv33IZyOf9FvTWCREpfTFlPCek/vecHg1yjjoDAQ=;
        b=Wk68WctKmhlV4/3HXHLmS0XlEnpAxmrB/nWfBbw09lhIJRt9axHMD+dY8ktsYL8w+c
         bDdbY+pSuMvEJxhYfv5gqLnm6LJkkYI0Q6tAtL98Pi1yNFqo93PIB6rTTVmG47pKKWbB
         KYmoSASZr+2M5q6x+Z3TuONAV1aEhpT/LGHO5co5rNFWPjCeutxH7TQp7TUEYZ6sarif
         azvRWSUR3IPYockKQqMdpi/03Snlig2Bem3aujt4x2Mjm/H6xqgunrEhFBji2fVImq+x
         bs5LVN2LA3ZwwngIvUgoFlDiDlm07WoMu377wbmaa4uHSeioNBWdA04a3JEFY1YAHi1B
         R4HA==
X-Gm-Message-State: AOJu0Yx5hT5DB6q6StpGwQBrau6pdcVAVG5MBTR0tMolvbaAFUG2ho0N
	XjFeNVT4c40njlWv+BZP0z6YxEtjKgt759zFXZnf2E5q6cmkscqvkYxwAxU8LZZyKB+vGs0W3D0
	9ObbxTOZTrfSyYHirq+OaoGp6NPehiei8uO7a37oDNoZqp3VS3YHI+t4=
X-Google-Smtp-Source: AGHT+IG/bV50OSe5sIeaHRLpgKECgwp6mzf6akaxz+MrZshIQ7c/K0c34JW5VI27l55Ulk5q1raGdlXCjlYXZ3p0rEBmwwPBcZ/9
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3201:b0:3a7:e286:a560 with SMTP id
 e9e14a558f8ab-3c2d1aa30b7mr436486055ab.2.1736158382005; Mon, 06 Jan 2025
 02:13:02 -0800 (PST)
Date: Mon, 06 Jan 2025 02:13:01 -0800
In-Reply-To: <CAJfpegv2hgjB9xvxFY0+wN2P74kZSN9_w_mffdv=e6Vib1atJQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677bacad.050a0220.3b3668.0007.GAE@google.com>
Subject: Re: [syzbot] [fuse?] KASAN: out-of-bounds Read in proc_pid_stack
From: syzbot <syzbot+2886d86a850adcd36196@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2886d86a850adcd36196@syzkaller.appspotmail.com
Tested-by: syzbot+2886d86a850adcd36196@syzkaller.appspotmail.com

Tested on:

commit:         7a4f5418 fuse: fix direct io folio offset and length c..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16bf44b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=74cb3c592a813341
dashboard link: https://syzkaller.appspot.com/bug?extid=2886d86a850adcd36196
compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: riscv64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

