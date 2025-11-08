Return-Path: <linux-fsdevel+bounces-67531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BE1C42C34
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 12:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AE54734A3EF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 11:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41FF2F548C;
	Sat,  8 Nov 2025 11:46:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD772FA0ED
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Nov 2025 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762602375; cv=none; b=WTsIILEYjDOroi42b8qSbXFJ7vZlfngYC971MT9V6CdHN+OvaqIgxYD7gCjZ2LQlRyHHQP6PJDQ5lSLzs9DWbtWmVG5HjJBN65eqkN8lRVHGzIjrZEWIITngY+dHeI9mIB8mR2yNodUo8SVXlloSqQyVh7Xs6Vig2WWeIDfrMs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762602375; c=relaxed/simple;
	bh=89T+4qHUQTIhG/SFKMt6Ii4GDc1WK8TCsdeL307uyVU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=l43qEFvV/DNP/KkW5wHUXd/VKK8RtfAFUxtFbYVrRw549hNwk4UY9pGrbV3T0oi8A6PJlDwFT1F4CXtNirAGw01IxiPlEVTk1EkERHlDmAf0sKHzIbHrArSq2PU5/0Mg2V0IbU/WMSuj7u9KqE2LLtlPixqtcR2AWkbvT57htx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43373c85296so981795ab.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Nov 2025 03:46:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762602364; x=1763207164;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sT3nWmWtpfLwoiQ/LXrBCnymc6GSizFbMsCyBhkjSMo=;
        b=DrZEO825xn+q88HDZMsk89ebzOPiw7Izo2iiHcGrsCZYbrK4e5BJa4Gwux+LOuNt59
         VqMdWjcr8vqCnKMjWKWZzu4QHeR6aMrTuRZzUP7gA502aYXzphDAcoEv+rfnmNobxIzM
         Cz2628qNbmdyLuMrzgJHUu1pJcSaB89REaZhZK/Zypk8xKrwyQZo9f4cK6zpFGLgobHl
         pFbOFtJtA5JizCQ0UkjSjCuUGmemfKpz0m0KXCRrgrg9T16XoHY1+lfi3/6arExN2UtL
         HItdxcnFpIAUzIaj3D6swYRFYm3heKj7JXaVInVqxSEFXBMrgcuqAdbugiom8G1TaR15
         zVmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaAptoa6zBR/iNezNoW710MeR84+FqVN85AxT9jKbhT+WvWBIkkWCmgf+RJPhkrdoaI1QGxY+rqKo3kqoN@vger.kernel.org
X-Gm-Message-State: AOJu0YyS5ra+A+GJiDnADpHQVw81PQDyh027o7vbiyP+OAu5Vx9jahyS
	g7imLkV1zSyW4iXfHwn2oOp8E0PYucU3/Lg+rH4fzNX2ftKDBdeFTGhliIUNWsxNNedmQFxGSEt
	X4yoZSpb2KvpQzVemDrswo/3fA6UU05EryO4bEza0lk2NGfw8556pU06sty0=
X-Google-Smtp-Source: AGHT+IF0lzmC3C5XiHZSRivjPA0W6wBCehFT2N8SafVZfF0emtOTtW0CiDs6zRdErfomW1D917I2L6HKV6ZJHX+cmO1ZDnUEfj2i
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc7:b0:433:74cb:e13 with SMTP id
 e9e14a558f8ab-43374cb13d4mr7183385ab.32.1762602364207; Sat, 08 Nov 2025
 03:46:04 -0800 (PST)
Date: Sat, 08 Nov 2025 03:46:04 -0800
In-Reply-To: <CAKYAXd-ycMzZ+o2wDMk4tdE8msafQ1syedsC-n19i=0Bba-x4Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690f2d7c.a70a0220.22f260.007d.GAE@google.com>
Subject: Re: [syzbot] [exfat?] WARNING in __rt_mutex_slowlock_locked (2)
From: syzbot <syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com
Tested-by: syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com

Tested on:

commit:         e811c33b Merge tag 'drm-fixes-2025-11-08' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=134eb812580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=5216036fc59c43d1ee02
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1258d084580000

Note: testing is done by a robot and is best-effort only.

