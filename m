Return-Path: <linux-fsdevel+bounces-59744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93A7B3DBA0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 09:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A694A17398D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 07:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA332EDD6C;
	Mon,  1 Sep 2025 07:59:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E0A26D4D8
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756713544; cv=none; b=VIf8NAW4xhOgYfb2yjDwxSc+GkCyupC7WoG8+i4CJPlEpHjXROP6gYx2bxzMnQh47Xw1NarOIOXaSiXnRYp9QAGohq1ch+nawAZJmvMlQLdHRKp7KR/D5hjOFFpA0KFyMt3TCSLOLPTK6XVhbCLXDSQYxhQDbJF9uGw5WoUyxDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756713544; c=relaxed/simple;
	bh=U+3HJz2k5gfXojPRjRY9ivcaS+FnuDZv/X2TY8ArTpE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=vCU2J4fTq7j52QVSMXja+byPQsBSfCVWU6K41VncmgdKTBW88XuIh5Z7Wzf0HXmovcP1788otltrVAofgHhRJs0GmwbXl+ESBzRsWE2KY/rS+itS1+JJmv7fdyAg6UKcSxqmvuPn3rtddvKyIalMBB0DjpcDPEniJSZRBBONV40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3f29a0a7671so33112035ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 00:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756713542; x=1757318342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ncCn6bpTVDHk1ba1TpluJzliVkR7s5GToCEpP4HhJVg=;
        b=ippWdSFGzL+1rI4eHzJ9FvYooU+HgRKWZ7ECroMcAu7PUD9kK8fuVJXIgqb2eYrKk2
         xkakBSRjc18WflCLEbXirxlvucv0XNj5uD1SsWOCksAdiY5sRtYODf5RQx7B2h6gHjIl
         7PJu1t2BPPBjCyTU+kPNrnCIk4zKRHFeEzpzZeC3hUXIm2sMBbhkCVKpWTHKHpklcG+O
         GuTRfDpG/aFzZpUDA8NyjFGQ8wy2u25lpaahixeLCyJo0uk6BBfGAB1F9GV6RPjmaStb
         +asz+0wzxpniDhSsd5ZZy2n5TgYigAKcW/Co5C8ljnqjfflK+k9Pxz2udzJUZkmDe1Yn
         pp1A==
X-Forwarded-Encrypted: i=1; AJvYcCW4b1D2jZ+nFft5Nnr66OB2GnYikcZ9A2SDVVcGeJ7K9eNnpTGLAtCh/rIxnv43wGFaSEovpsPdDhFvUXhA@vger.kernel.org
X-Gm-Message-State: AOJu0YyzOo/kwsnbbW2eZV/HmtDXTkY5FcHFW4vqqeYwKDLahOy/NEDj
	m1J2ma6e6DvlcfxYibhEJJHRklZod9vCmOpNTnJx1Vm5oVwkAfd2aUQyXlLS2VT1d/O/+v8k0za
	eoys7dVa1SKq0X1yqQ2ImmXCoasDug9tdJKJ4Di6NhthwoAJFHz/BN1zTSAo=
X-Google-Smtp-Source: AGHT+IG1coevK4BPflUC3vJfg3mRNLVwz6bIIweWGs6nW994OKtQhlFQDvA5RRrv/tDtocb6ctTseJaAcH45ebW8YHSROsp0rn+s
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148c:b0:3ed:6cee:f83d with SMTP id
 e9e14a558f8ab-3f4019f6bd1mr126599275ab.20.1756713541938; Mon, 01 Sep 2025
 00:59:01 -0700 (PDT)
Date: Mon, 01 Sep 2025 00:59:01 -0700
In-Reply-To: <00000000000091e466061cee5be7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b55245.050a0220.3db4df.01bc.GAE@google.com>
Subject: Re: [syzbot] [hfs?] INFO: task hung in deactivate_super (3)
From: syzbot <syzbot+cba6270878c89ed64a2d@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, brauner@kernel.org, dave@stgolabs.net, 
	frank.li@vivo.com, glaubitz@physik.fu-berlin.de, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mcgrof@kernel.org, 
	shaggy@kernel.org, slava@dubeyko.com, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 5b67d43976828dea2394eae2556b369bb7a61f64
Author: Davidlohr Bueso <dave@stgolabs.net>
Date:   Fri Apr 18 01:59:17 2025 +0000

    fs/buffer: use sleeping version of __find_get_block()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=101ba1f0580000
start commit:   c8bc81a52d5a Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=121ba1f0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=141ba1f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd9738e00c1bbfb4
dashboard link: https://syzkaller.appspot.com/bug?extid=cba6270878c89ed64a2d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10857a62580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f5ce34580000

Reported-by: syzbot+cba6270878c89ed64a2d@syzkaller.appspotmail.com
Fixes: 5b67d4397682 ("fs/buffer: use sleeping version of __find_get_block()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

