Return-Path: <linux-fsdevel+bounces-21297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB90901614
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jun 2024 14:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F7132819ED
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jun 2024 12:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6C628371;
	Sun,  9 Jun 2024 12:24:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B961BC58
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Jun 2024 12:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717935844; cv=none; b=B3Pvw82dMKyoJY88F+SWH9aiXmKxrgi+8we3014GQfsfBWwDN/45YosvEI8q59CGQwddiuW48O+0k5T6FtpXzGriG4nocyPv/xEQ/xASma+GnQX86r5s0gxGH8ke+VYga3uC/R/2/DTGrSmDRvluYKX2/WQxErL4Xp6WeFrmXPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717935844; c=relaxed/simple;
	bh=Kcph++9N+3JuC505njQvJBuAr5da5Ttc2ke9K0Xt9f4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KMzixc3AtQGNXwPUG+sy+GuZi6K2OE4XeGMphi1J7jczi1tqc/hJo7saY6fdxgO+d4ynRZEv9f03sHmSwybkJr0VD097mEoeTEfm0vWCgKht8rfoPxkjpTth96BtGECIEo1NavNeZ0Ve4ox1+WuwDNjvj2VKJKdQmTsiBE2dDaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7eb1d659c76so449878239f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Jun 2024 05:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717935842; x=1718540642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sLqhBcU9jwlvP/mrXCqjLuATyuFlQ7094WyS5VW+rN8=;
        b=S6ZSSgDgGXe35ttRQq5Qnr6tGr++LXxaqa0XeshkyUwvZFKeW4iehQYXYODyjKWmUV
         AwNDb5IgQzXs455EH6kZVfgI70yjNjD/pF8Gjhlorxnw+2aHHQ+dVHNBwz5RdpqaOfJl
         w+RY2BSPfQBaLrh3pUNetrn55AT2uiLCHSlTr3SDT/tENOG8eE9WB53XNSV9liTJNtP5
         +tsh47ZwGZwd7DddGCNt1i9GrYI+mF8Wq1qUGnZUD5s/xtDFoOT87ssTWA1X1gY22MTP
         Cl9Tu5wf6vnk+Ya5wgbh/fbDylEcdichSNGlPoECern0UgBk376br2vLDw/JV67RVeGw
         OfEA==
X-Forwarded-Encrypted: i=1; AJvYcCXopqJawyIuNsCWPU3MQjJ5mXttxjtGOQa/r8iAh6ntXsMkRmAfAYnXeoGx2J+7eVURfQVWk8VmR0sPBu5mfK1Ph89zV71w2gM91iMvtg==
X-Gm-Message-State: AOJu0Yy5N/MSqBmwv1hM5fZZp1je2MNfLN8sqYZEd9hrQGSk9nsgthMK
	/V/QWWzQqhtgY3yvshVflWIWHRqa3rCa5YbOmHqW/aB1g5rNnWyDGo5M5sog5OMfTCLYuj/0juZ
	QqWRJJi0+HwpLhqbq65sCLST+t5AwQtzRNTsqDOteehZosbHYs+wU2ys=
X-Google-Smtp-Source: AGHT+IFvfnC0DzHVjfhCUDuU7hk3k/fPKOm2hiULta9pJspJ9sNRGRfIulLgrGuf/01F165Qv3e/tUklQ3pkaNxQidGQq7Ib1Lz6
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:270a:b0:4b7:cb85:c0de with SMTP id
 8926c6da1cb9f-4b7cb85c294mr217708173.4.1717935842167; Sun, 09 Jun 2024
 05:24:02 -0700 (PDT)
Date: Sun, 09 Jun 2024 05:24:02 -0700
In-Reply-To: <0000000000008160ad06179354a2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009ea02f061a741be4@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_fs_recovery
From: syzbot <syzbot+05c1843ef85da9e52042@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 7ffec9ccdc6ad8356792f9a7823b1fe9c8a10cbf
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Fri May 3 14:55:17 2024 +0000

    bcachefs: don't free error pointers

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13191932980000
start commit:   ddb4c3f25b7b Merge tag 'for-linus-6.9a-rc7-tag' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=05c1843ef85da9e52042
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1464ea2f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130db31f180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bcachefs: don't free error pointers

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

