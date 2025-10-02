Return-Path: <linux-fsdevel+bounces-63213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4548BB2C49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF81F1C45E6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E73265629;
	Thu,  2 Oct 2025 08:06:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE06F2F2E
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392365; cv=none; b=aUdWd/W/XYKmFjYcnKsSWNGfI75sP1D+pNGzyskd3+cCIDBt42LDMq83xwoNJydkB5O9SXlzSu2saBO470/wtOhLxInM9RhV4WFcGB8IYtyBytRfmGE93Ga1LNIF4tVQOZ1Z0g8burBwKHXGvt6Lm9RDTVj1k/x/ECif6EaK4S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392365; c=relaxed/simple;
	bh=H2f+b7bYF80DwF/uu1GLXQLAHJtRAh3KzgqzNeXWvjg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sVqv9w2moRHCx/6ACB0GmPhM94WLqxv+ZHutTGaQJRatzQxQgSn4kDrbn8J73tyivaS2VQEqtiJV6QvukaatFeaBjY/RfviighBEl66t7ZvbvryvoFvDbA2aY5+YBIQ7SijplwPfsB8JecHYeXYHN7KVq22Suio10IHQSAz7UoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4257626a814so9088095ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 01:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759392363; x=1759997163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwnfbejvU/0snnp4jupt0tXVwPkfHCODhEws6EOmv98=;
        b=Xlg0vzdUgauArMrzjBYPbtEXsjsxXoQMkcfNGwnFy3T0SOQLX5aW1QIfWwrhOLLrrd
         Luo4KQEyuqWrFkm9DpbVjuSEdu6Bl303eg97WVzbATWHxdu41INHNDZ1nqXYWPmr+XEh
         ikx69ptRCM7a3Fq4/3z/3TlhInRubbsfC6txWMN/0fdwM5TauH6O/JqQ+m5PLczapZ4z
         rewccEbttUwOy0FuOxFAB7KZsprp+wKbE+i49HFGNB3Tf1Kj1kwu553WoBUyNh7cyiwP
         O7/cwNZRXg1ZICaqg4WKALuxhSaRJTw6fN6X12IPbBbY5Nup4vW2Qc2L/n6D175u/xax
         orjg==
X-Forwarded-Encrypted: i=1; AJvYcCUnnG0SyrJILFjYjzcn13YSK4gYZEz0Kq/kHzt8qjoUIoxayXH5Bt4QAhqHrMXI7xL99E26cKI5lCcHBw+E@vger.kernel.org
X-Gm-Message-State: AOJu0YzeMYdBSJ5wN/GETXYP4S7OqzqSY7jiJjQqsKtkN4AfSlY//xGu
	mCqgBEGchAfJytHXc8s2257t9qzGFjQlzCQEn0yXs2KUtvbSAoWcc18aoj9xqVlTjVz8cvCLfee
	h8JIVkAPd1sia4Y6vM2IrrdH8WLue5TF4BGfJByUhOpLNPlAeugOQZvcGUQg=
X-Google-Smtp-Source: AGHT+IG32w4FLuxtEn6BlB7z8u28oSCKGQTynJTLuVTKOUpIoywYs5HwgY0t0PbJ60WEHPtN7CF3apR6QCzLf8Rr1gSx8kZ1hHQR
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3521:b0:42d:84ec:b5da with SMTP id
 e9e14a558f8ab-42d84ecb8ecmr54089555ab.10.1759392363003; Thu, 02 Oct 2025
 01:06:03 -0700 (PDT)
Date: Thu, 02 Oct 2025 01:06:02 -0700
In-Reply-To: <68dd8c99.a00a0220.102ee.0061.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68de326a.050a0220.25d7ab.0780.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in copy_mnt_ns
From: syzbot <syzbot+e0f8855a87443d6a2413@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, anna-maria@linutronix.de, 
	anna.schumaker@oracle.com, bodonnel@redhat.com, brauner@kernel.org, 
	cgroups@vger.kernel.org, cyphar@cyphar.com, davem@davemloft.net, 
	edumazet@google.com, frederic@kernel.org, hannes@cmpxchg.org, 
	horms@kernel.org, jack@suse.cz, jlayton@kernel.org, joel.granados@kernel.org, 
	kuba@kernel.org, kuniyu@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mawupeng1@huawei.com, mkoutny@suse.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, rostedt@goodmis.org, 
	sd@queasysnail.net, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	tj@kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit be5f21d3985f00827e09b798f7a07ebd6dd7f54a
Author: Christian Brauner <brauner@kernel.org>
Date:   Wed Sep 17 10:28:08 2025 +0000

    ns: add ns_common_free()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=135eeee2580000
start commit:   50c19e20ed2e Merge tag 'nolibc-20250928-for-6.18-1' of git..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10deeee2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=175eeee2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f1ac8502efee0ee
dashboard link: https://syzkaller.appspot.com/bug?extid=e0f8855a87443d6a2413
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1374b858580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15602092580000

Reported-by: syzbot+e0f8855a87443d6a2413@syzkaller.appspotmail.com
Fixes: be5f21d3985f ("ns: add ns_common_free()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

