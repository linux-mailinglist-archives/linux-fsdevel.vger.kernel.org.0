Return-Path: <linux-fsdevel+bounces-18945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D09348BEC5B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 21:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B7F2869C3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 19:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DD916DEB0;
	Tue,  7 May 2024 19:11:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EB816D9A0
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 May 2024 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715109065; cv=none; b=nN11bCf3D+0ARAMvcBQCZ/Bb7XcilebZt1kPMUc1V6t/tUwPQCLZdZ7o/yMYOEFW6CzlXGdbI1GIG7FNg9MRI/Y0eR7MROxus5XIpn1V0oO3bx2YRZcs8prmE9vOG+zE2E+NnUjKyeOnRrjZiruOFoZmwW+xCh3ndtxIv1AM56g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715109065; c=relaxed/simple;
	bh=MZDRcTYIrPY/KVDPzLf3Ur1jeAmwMRwZb4IO6MJFfP4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uhNYaP4TLZNP+G6HxuapEPseSnrYoPzIb4CYrnfB90jW9AVV9yN4xx4kIADwB2MalzTbeezaF1zDwYnTBO05k/o7dSKy2FnAnf5506IhkqoUOAnKZ0ImoqK3+B9HNAp30OwnIh8F5qvylQ34M1xooO0dmh31JPLuV8vMU9GWa2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36c886e1c82so40151275ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2024 12:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715109064; x=1715713864;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EMMmdnnhlCk6lDibFaruqJ+bDg8KgHzYf4Lb5blyQuQ=;
        b=oShEbi6tSZtx3mP5flj2DSyvAcsDDSKUxH5r4WEkE7ItiBWFyo2xwNpBw9PJxiqYGN
         d43swbBgvUnTeXzupS8yEsENvYPESZM+AZfjgm4AL0ygvr2pwibWMvGSAcgk9IdF0g4a
         vElntBCUoNHx/kRVi3wQjX+jxfhe90QN4r+6WV/SnUR/2MHx60cPUNUynF1K+sKQ5gxg
         fhyIeRvP+HQCynrXqlYd0hDzdsMLX7kgkqTcZfxnEKUGjMLT5CTYGwC2qNKY8TnVa0I9
         VMgJh6H4XXW+div9vomLAqgj3A8HZs18duwGq6TQa7+bRjIJEqqdsUkSNEIDnCrI7pma
         d9KA==
X-Forwarded-Encrypted: i=1; AJvYcCWEmapxMUEmtiivwgr7XDN+kBcDXj+qQW67Smpf1li6hKyp5YnMy4wZW1n25PObLMzFY2LpHWVLGB2P0eNw33qAgCQSMc6VDBbT8ZaabA==
X-Gm-Message-State: AOJu0YztrfounZ4Pdzi6KHpaeRQeIDJ2gX6IGrIOX4FyKJRFUFOOzDK8
	JEvskBZcpFBK7FyRTQv9ycSJ2ONKw8/8FHUXKskWrPhf3sg83OwFqshH6oCm7N4cP5adg9DK+EG
	VC8b2Nw7uZm/Rt0pnJWmMCoA72V/usfIc+NBALjBiv7VCs6Vm9koHW2Q=
X-Google-Smtp-Source: AGHT+IEtr+Z39qefIZO5XPc+3zq+HrmB0hikp4+IjhHgaHCLJ1/SO5ihOTsmd39/5axw913OgOIRhRdWd2p2AaH1XlWhF4l6RT8a
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9c:b0:36c:5520:9597 with SMTP id
 e9e14a558f8ab-36caed58de7mr195005ab.6.1715109063836; Tue, 07 May 2024
 12:11:03 -0700 (PDT)
Date: Tue, 07 May 2024 12:11:03 -0700
In-Reply-To: <0000000000000498630617b740d3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008059400617e1f284@google.com>
Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in rewrite_old_nodes_pred
From: syzbot <syzbot+594427aebfefeebe91c6@syzkaller.appspotmail.com>
To: bfoster@redhat.com, eadavis@qq.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 03ef80b469d5d83530ce1ce15be78a40e5300f9b
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Sep 23 22:41:51 2023 +0000

    bcachefs: Ignore unknown mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17afcbc0980000
start commit:   7367539ad4b0 Merge tag 'cxl-fixes-6.9-rc7' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=146fcbc0980000
console output: https://syzkaller.appspot.com/x/log.txt?x=106fcbc0980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=594427aebfefeebe91c6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d1b2a0980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=135c2ca8980000

Reported-by: syzbot+594427aebfefeebe91c6@syzkaller.appspotmail.com
Fixes: 03ef80b469d5 ("bcachefs: Ignore unknown mount options")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

