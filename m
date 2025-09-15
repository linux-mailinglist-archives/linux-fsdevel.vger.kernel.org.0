Return-Path: <linux-fsdevel+bounces-61284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD04B571DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 09:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39FF3BD60E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 07:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414762DF3F9;
	Mon, 15 Sep 2025 07:48:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1072D592B
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757922484; cv=none; b=j6o5t4plSIxvAlBMrD305yc1ErzgnadBtqXpBiIJiTrsuS4eLCAb5WJoN/2CWN8KiO7RPrJQ/ZRfsvTcTRHkl0Etk+U/88/EqW8DKHvNsjtzi2pEODtbgnEVeSm0jTkueBqfktfIbECeE3f462jYKn3kz6diuEx/E25urba5FCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757922484; c=relaxed/simple;
	bh=sDqJwn9c7svvbHL1gVSSlKD6t7Spn2ExhaOMtxottpk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MOsKBOEG6qxemKcJV747vvP/6zlLZQiZ8iTnQYszQB9yoUCd0qx8A3Mv7xkHtpT8PQx9pssdHrxNR+TezMJf8edmMxfDZN7489NzF5L4p52YM3CVKd3Myd+iO1LtiG7Xi3Gs0jQlF4s3mqvcvFdNUBW3VZmzau4ClTe6a7ZzyWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-411db730dcaso142660195ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 00:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757922482; x=1758527282;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mUB+sqn22sEooHqNX4QjIWNl0SVDHgDFAZHnR3by08=;
        b=FURvS5zSM8Z8lgo1cvE1ra5BxZx5fwoCnmh6l4PBPCIgeegZSeeSPGqbmvuqtuSh0s
         WAx6t5EIk99qeiYFQp85cDrvPDndw+FE7eHOqgBqHXu82pH+OPDHg3QPe9ffSL5u2xhs
         /UQZ5ZXCAhvs9iEdITmiiBxrwjQkxlWHgP2DL+1YpfSdsDQ3oICMiulIsh5zHaxceRfw
         9jJwQCrMYzN299u3pP9O9ifpYZrx708ZH0mAAx58dqd7/t8SWZTJgPbwzVJ1xcFLOFwV
         63QrCDK2TNvKPBz63///2wKW3zZ/0fiN5x0fURDAURJ9IJlZJEGWJ5xA/mROvMKKhnep
         7ZnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/u32RNgeMtPH30DRF3rTTQdbT4wUkgRxw5oORsyp7gBbfUHfDUe7xDpa3y1qBgB11O1Sco96Xv9MTff6q@vger.kernel.org
X-Gm-Message-State: AOJu0YxoJ88cI3EYu36uv7QPeN016uZp4Q1f2r7yzMHpRcG/I8bvnjte
	OAWQcrYwyrA3R/uPZkNpjLD6s29kCNm+85PzcB6MTsrNOBoTDq1/7QVpHphba8ZyXq+0KP+YE/o
	joj68sMpMec97Fx8uVeVYHqtxV+7iBVn0VtMcVfuR1eL156drYB54iLG83Ys=
X-Google-Smtp-Source: AGHT+IE4CuAPdzy8E4AvKc8mu1VORU1gsGkMG2LeH46HuG2nXACKeM9R4m04zBUAqJVQdjLVNxByaK5Y3triGrs0MdUjLeTFvwJq
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe9:b0:423:f9c6:f21b with SMTP id
 e9e14a558f8ab-423f9c6f2d1mr51696275ab.8.1757922482721; Mon, 15 Sep 2025
 00:48:02 -0700 (PDT)
Date: Mon, 15 Sep 2025 00:48:02 -0700
In-Reply-To: <0000000000008b529305ec20dacc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c7c4b2.050a0220.2ff435.0391.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] kernel BUG in dnotify_free_mark
From: syzbot <syzbot+06cc05ddc896f12b7ec5@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, amir73il@gmail.com, 
	christian@brauner.io, hdanton@sina.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	viro@ZenIV.linux.org.uk, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 55ad333de0f80bc0caee10c6c27196cdcf8891bb
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Mon Dec 30 07:34:08 2024 +0000

    fs/ntfs3: Unify inode corruption marking with _ntfs_bad_inode()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15420e42580000
start commit:   fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1a07d5da4eb21586
dashboard link: https://syzkaller.appspot.com/bug?extid=06cc05ddc896f12b7ec5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e3dffd180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f9e08d180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Unify inode corruption marking with _ntfs_bad_inode()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

