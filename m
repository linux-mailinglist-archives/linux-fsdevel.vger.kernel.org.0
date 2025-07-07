Return-Path: <linux-fsdevel+bounces-54141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A9EAFB894
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 18:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDED21AA62C2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 16:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6066921E08D;
	Mon,  7 Jul 2025 16:27:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9961FDA89
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751905625; cv=none; b=X1PIOP8aALSZXDhfrayaPFHZ+adp3qLFyG2rnDNkVR+19EcAmcBwtAG0jMy+cP7OYnfuBpdnu9eqUrh6z5kxjxuzmFSKCmNFGhoVGEAhyuTupwZS6f1IjpPXpLZlnE3txKYKEiGmPON1IkycXGHp9Ss+NEpM5QKcubrPwehJmrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751905625; c=relaxed/simple;
	bh=tc7S7/eJ+4S+9/JAOptsRxuYDB7uxt0LSF1mHlb94MA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MUPWzhrqLlv3tgvk4KYqGwQFknXi24ak26VY0YgNCdoCAkPosG1F6tCDFcbbXRo2MJDafdHOFfTHSOex2Cgavc8aStTDDdH12v0Y+M+YRlwggfBegCTvASWZsjbUzygdcZc083IunA0uagIGGoIk7tUVb3pR4vHPykjznZuZTSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86f4f032308so659365739f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 09:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751905623; x=1752510423;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xd4C3A0IQjFn8w25wCpwJKDvBmxbazZS3RQuLT16nfA=;
        b=g6TmznbSOaBRDAEjvH9Hh8y0WR5Mm9mA2o3kwscFF4vyjrO9fAbC0r6oReXPKcXG8/
         PEM+gUrtVlHImV5e82oJKHY/AbJ0hw2VcY1fQjF/gZL6pMkB6oP2MeTUkWMYhBnmixaq
         HT1foGuCe6l9fBRcUBSVEphrOHq9sJsZpDprdtvJKrT7bF+laRRFoiD8fn8mdQDE+uvp
         ptnHUJQ38jM0ifZ5Q2ripQy7E/emNph8CLzTXZ9NrXB0TSJ6yhD5E4sE5dLHwJXmEKAX
         BZn4vSRLPkU0dcdvMAppaq+Hgn4ZO8hiehllo7X4MWnq++NPz2jsl9lx1//d/3ymOnhf
         gNSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNIP/rZpTpPpviShmNUfsZYQ0M9U2xtBm6CD07SzkR8HVXiK0dwnbcEIXFMMQqUx4F3Mj9JsktmS1wlM1m@vger.kernel.org
X-Gm-Message-State: AOJu0YyodDJRX3kFmKrDCniFlOm1W81ZG8p5qU5HLcm2Ac0U+iY2stgU
	Ln5EsIqUEXZAGEhrx9nQXoEAIk9OBBeuC+5+xYsU8/d0MJ0FS8r6Ue9k3Kahl0nFbsTi82is+VW
	1pZCkLvIwg2ch5/sdbmqDzI60iuT68Lw2nUpsjmmWzeSuJtH8goScHqfJuXE=
X-Google-Smtp-Source: AGHT+IHzzX7Mg4FWi1z+qau3zmFOwheiXBj8VZFTP5NPpqzbwVV1SNLfCRtgBd4ZnG2nf2LTtvp0fsLXmVTgqzJqinccbR/z9+l3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2a:b0:3df:49fa:7af5 with SMTP id
 e9e14a558f8ab-3e153a55f96mr3025755ab.21.1751905622720; Mon, 07 Jul 2025
 09:27:02 -0700 (PDT)
Date: Mon, 07 Jul 2025 09:27:02 -0700
In-Reply-To: <6710d2a2.050a0220.d9b66.0189.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686bf556.a70a0220.29fe6c.0b0e.GAE@google.com>
Subject: Re: [syzbot] [fs?] INFO: task hung in do_coredump (3)
From: syzbot <syzbot+a8cdfe2d8ad35db3a7fd@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, asml.silence@gmail.com, axboe@kernel.dk, 
	brauner@kernel.org, frederic@kernel.org, gregkh@linuxfoundation.org, 
	hdanton@sina.com, io-uring@vger.kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	tj@kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 2af89abda7d9c2aeb573677e2c498ddb09f8058a
Author: Pavel Begunkov <asml.silence@gmail.com>
Date:   Thu Aug 24 22:53:32 2023 +0000

    io_uring: add option to remove SQ indirection

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ec9582580000
start commit:   05df91921da6 Merge tag 'v6.16-rc4-smb3-client-fixes' of gi..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16ec9582580000
console output: https://syzkaller.appspot.com/x/log.txt?x=12ec9582580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45bd916a213c79bb
dashboard link: https://syzkaller.appspot.com/bug?extid=a8cdfe2d8ad35db3a7fd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a2228c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d48bd4580000

Reported-by: syzbot+a8cdfe2d8ad35db3a7fd@syzkaller.appspotmail.com
Fixes: 2af89abda7d9 ("io_uring: add option to remove SQ indirection")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

