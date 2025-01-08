Return-Path: <linux-fsdevel+bounces-38673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8C6A06683
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 21:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2CC16761B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 20:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F9B2046B5;
	Wed,  8 Jan 2025 20:42:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF44A2036FF
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jan 2025 20:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736368926; cv=none; b=ZRjQ7LfxhhOlR0Q5GhCRhPdQlUsRhaCi+0c4+OfGG+kDdSqF8rPDHJnRuLcHLNXbGXH4gIsE/KOZk/r3T18EJnZF4b/X02U5BIe0I0ztWnH3XgCDZDAmlDT46nPcpPb+ZexfoFNmE83tdCYNrW9iqYrxFepNxeJZPYs1THXQSbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736368926; c=relaxed/simple;
	bh=rJ0PBgRJ8JQ65hZJ2DfAQJvAcwVTjGP1dqjfW1aqmOc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Xc/q3b+f5dl7dp0xZbDo6j7wcuAutyD1MESrIz9GX5gFM5z96oUvqD4Ag4TpxwyyNYVuvCU6wfR7O5Tl491o1m5W0nsx1+VlA4QP9iexR6p5c11F6dpT4Ov2NzQKOSLj1mMCsTkObWhFAHzcKEdbqhqZNfcoWwX961pz8OTMvus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3cdd61a97easo1222535ab.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jan 2025 12:42:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736368924; x=1736973724;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MNs6O3kkr3r5I7w/dw3fJq7XUHf1uqk5MiUvua0Nv68=;
        b=smcCNenF+Oo8ZAzcKjwMhuQgjC/bMn56fsS3LAd1dxXOLXKEU8rftPo3hc+iHMEgYE
         tT//68lZBxzRgb35A2rp5JNd9vLW/KQIJNk/bOKCifC1lpImG2M3ILfVf2Eddre6EYSj
         dtmnfUpRBoPtWDHKMqSvGnEEdBU4FU9MEekTxsMS7LtBmS6s5qHTD1psaorQk0nNF0ku
         ebjKA9RnhGu62ZuBjeK5sQi9kZO1IDteu9hIH2EUhSYBSTUOx0FmHB5FSlBFJiFP7viP
         Aeule6EOpjZfiYd9K+TjOzNUYkBnZk1+JKanZfPBmRYJH47Vc4TWulgTBTqAhe9MAzHZ
         kH1A==
X-Forwarded-Encrypted: i=1; AJvYcCW5HGRIrQPQvS7ZpjX31Dknw/F1BSm1dp/J984DFO+q8sjAJiyCAu0tAEpbu0D3rMIUKxxsYWOuPnsiiyQp@vger.kernel.org
X-Gm-Message-State: AOJu0YzQj7sAvZOVT1r9YZ9PDbv+TfrAJLeFnmbVeJSdL2Sfel3hy9Vu
	N0ZdXJc9yvKBpyLJJVDSMdwRH6VyFC51Tt6XJpj8p8xuHKWv3zjJ3sQSYD5B0qRYGQP3000pu1p
	rfE29MQduX1kkLnDkBxsNSXcoYjUilgJHav4OiP3BpLD/61/sEOCMBj4=
X-Google-Smtp-Source: AGHT+IECo9lGm603Dk8vIUiGK8QpkBSx6h1ErbJnWMSVgNgDWyfFyYFqwgh99vQBrvmYiQIujlLwDkp4H2G7ucDx9e5v5WFae6xI
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1605:b0:3a7:e800:7d36 with SMTP id
 e9e14a558f8ab-3ce3a9b9cdcmr31182255ab.10.1736368924026; Wed, 08 Jan 2025
 12:42:04 -0800 (PST)
Date: Wed, 08 Jan 2025 12:42:04 -0800
In-Reply-To: <0000000000003d5bc30617238b6d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677ee31c.050a0220.25a300.01a2.GAE@google.com>
Subject: Re: [syzbot] [overlayfs?] BUG: unable to handle kernel NULL pointer
 dereference in __lookup_slow (3)
From: syzbot <syzbot+94891a5155abdf6821b7@syzkaller.appspotmail.com>
To: aivazian.tigran@gmail.com, amir73il@gmail.com, andrew.kanner@gmail.com, 
	kovalev@altlinux.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, stable@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit c8b359dddb418c60df1a69beea01d1b3322bfe83
Author: Vasiliy Kovalev <kovalev@altlinux.org>
Date:   Tue Nov 19 15:58:17 2024 +0000

    ovl: Filter invalid inodes with missing lookup function

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ef4dc4580000
start commit:   20371ba12063 Merge tag 'drm-fixes-2024-08-30' of https://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d806687521800cad
dashboard link: https://syzkaller.appspot.com/bug?extid=94891a5155abdf6821b7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1673fcb7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15223467980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ovl: Filter invalid inodes with missing lookup function

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

