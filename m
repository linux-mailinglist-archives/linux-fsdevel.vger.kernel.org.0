Return-Path: <linux-fsdevel+bounces-40995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 901D2A29D2B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 00:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F281888EB5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 23:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7468221C195;
	Wed,  5 Feb 2025 23:08:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC6920E007
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 23:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738796887; cv=none; b=UuoqjTyzcdtPwdJ+d6n/AuOsiUywYHYm94kYQuVxrBgJ86YeaOM9BZraHpjpfvQniTT54frKP50Mumpy+K/ZpzcniAGubcYoxdDZOoxrWOytvDTib9qyrqlcrSGaSgFmNl3z3V0fOpgvMzOhwixY24pKMzqWSSNXh87Lj6gSHKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738796887; c=relaxed/simple;
	bh=gjX7MpOXiEdWUVzmp8FAMhN0rxb7kDg5PRP3n16r7ao=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cplpTGLuM4zb/J5dU77IrGK8QZ4fB2ZLwxpoByrDCoRt4cCkzqwXbcgQmnrG27FmxFtNcGdI+ED1fKOXC6A9neRG/1T7A0+yWfIGB7eTxnFcWz2L1uqwLj9UtjerqLI7vEmUEsK56ixZ/+4viyFUNqMK847T5A6r5WWPDKMLgyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-844d54c3e74so22636839f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Feb 2025 15:08:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738796884; x=1739401684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MSZdvRE5PK/E0Oh4UzYD1ELq7dQSHG2PmpvdOlnTPIA=;
        b=R56VHSvKAZlxwAyh/9iD8F3hxun8jcEXNkh0vs/apCXdUm54yQk61AayTDkz29SDBN
         Z1EPTHCW4A0tueExfxWNKPV7IycTkgMSxkdasitbM1N6XKZyy3+YivwTMHQb4gLojUHa
         GuZcT7TJB/RDt7NqQj/vrSM9rDq4uBKrjumWtiIgO0dFzJmW2roClXD1AkhVP4AJUOSe
         8lx0J5b+FIDaSUkNq/Uj5WyHUG21RxIlCiu2iZM/0F1+uXXO9aDWlACShEeL5nCXMSS/
         V6g5yunk6Mim/s0te26Z0mQRyFx4kMGxOHlBXdXNz6ihJJqFC3bjmpfv/WNcYtTXQQt/
         /58A==
X-Forwarded-Encrypted: i=1; AJvYcCW3t1KHTMFmk4z/9EaeDC0F7JR9SWaS1Qk2RULOdDF3Dgd0VQG8bFKnamPRcPSsjzVCZtYaFivhx+hXMBrR@vger.kernel.org
X-Gm-Message-State: AOJu0YxT8KjG44WKULsG13U1JzdMMFcO6IHIWMk4B/9ABdiNb3U4q7xw
	va9KholDI4zQR1DmltUERShK56UBOjBmDhzT5haeeW67DckiKKB4YFRsGYpNBsGKyjutVBJOpvp
	J766sMPHQEaN5YKJarsNgS894C5CNYMtnaxp8h+JM5tGPFrycykDpA2Y=
X-Google-Smtp-Source: AGHT+IHRMCsb53bYihT7UWLgEohjNBloMBrHSCbCvfiZOZcFGwdrxwtexKt91m1hpu0359YwFtCoWWSfHtY7xH7QWO+xpXcmA2sO
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156f:b0:3ce:9149:a8b1 with SMTP id
 e9e14a558f8ab-3d04f42c60bmr36747655ab.9.1738796884674; Wed, 05 Feb 2025
 15:08:04 -0800 (PST)
Date: Wed, 05 Feb 2025 15:08:04 -0800
In-Reply-To: <6770ec42.050a0220.2f3838.04a5.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a3ef54.050a0220.19061f.05f1.GAE@google.com>
Subject: Re: [syzbot] [exfat?] INFO: task hung in exfat_lookup (3)
From: syzbot <syzbot+73c8cd74d6440aef4d6a@syzkaller.appspotmail.com>
To: Yuezhang.Mo@sony.com, andy.wu@sony.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	wataru.aoyama@sony.com, x86@kernel.org, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit a5324b3a488d883aa2d42f72260054e87d0940a0
Author: Yuezhang Mo <Yuezhang.Mo@sony.com>
Date:   Mon Dec 16 05:39:42 2024 +0000

    exfat: fix the infinite loop in __exfat_free_cluster()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15ab01b0580000
start commit:   9b2ffa6148b1 Merge tag 'mtd/fixes-for-6.13-rc5' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c4096b0d467a682
dashboard link: https://syzkaller.appspot.com/bug?extid=73c8cd74d6440aef4d6a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101d6adf980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d100b0580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: exfat: fix the infinite loop in __exfat_free_cluster()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

