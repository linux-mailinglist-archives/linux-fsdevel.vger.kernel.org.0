Return-Path: <linux-fsdevel+bounces-12163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5292785C201
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 18:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850C21C22095
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 17:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DC37690E;
	Tue, 20 Feb 2024 17:07:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162DC1E48F
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708448828; cv=none; b=dPfDKViIxCjQ+TuDXKXAI3Hlq4ZZdRj9seMiIXpcdeae0VCtI8MSo9ZvbvLw4Zf69I7dYRRuuJvVizxGxXV7OqgB75WxMS7diZ9c0iXMs9iC6E8Su6BMDPePqKdo7zxnr1bnxtwmqVHHBDX9xSbaAb25UUpEjPkWSnxLHKapTQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708448828; c=relaxed/simple;
	bh=fpOYDYG45k8U9HV65cDW94tz/kvIcbCC6Xq+v6pMoEE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lQ8fB4JYzb2FTGWoUWtltDJgHSluf2iCkKOnTGg5z0S5VIsxYLso9DqgpwKU0MoWAMqrbzyEUbNzbyEI2MIER3BqizdzMIifv2UombL1gZWUggvYNOgQLJt2VDarLxvdaOWk2jdgMuSxKvSiq5L92hXwnPS47a+glXk9XdG6wmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c0088dc494so246183339f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 09:07:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708448826; x=1709053626;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VoB9Sna81nB4vSaNge+i8EhIjXereiwccH3aqSzPYT8=;
        b=JIXAVJXNETkPlfXiO+AUVavRNqlGtIEat6EY5pR+jhcRe3FWpXkbvBdrpZPlwCG60b
         bj+tYWg4bOku0Hn97xzKGN/NXW4MEk7rDxkAY+ykldbiQ9sVTaCQypk0e+cHSPwrk/JF
         DyAGdjHZwhvFjt1yatZMWwd78yOtOPeZ4IRzclNpuUsmkb019ifokc5z7nW8WUmmTEi9
         wOgAL2TVPRcBk/s2sbzdJXNm5yoQvRXfXQ/5o63gMSjLxuphzgrQJT2s53uPEkXcu+A8
         aPRiZqMLtnh+a17DdLoblTxxz9RRLoHkIGq7jD84f3cr6eYAY22+DUK7XbQsRD8f14zv
         T1Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWEZNpn2uOAB7qmOmKZJErdoR6fkQSWfmEy7aAAAtZneXGqw9xilVctieHJnVkYZfQ4MZjkjjP1mQd6r2ldKk3Yd/CTag6/5YOJUpG/IA==
X-Gm-Message-State: AOJu0Yzi/MWD1QhXhwU1MpPkajsLyQXu9rfJxfz79QLRQBEiMWyf3186
	SS6RUtumCOsHFHSeBEHEI4Y180MptNgziNcWj6i1DHFHhrI+xbDDetQbULe8kRnE6tqNEUz88fu
	YMMdVovbv9EItMPQd4SDACro9EvHx5gzAiZmJwyE5/g0CVXszALYho28=
X-Google-Smtp-Source: AGHT+IF/3RaeuI4CtitYxgcUNh3Is+XjhShaqoOBbnB9V16ZP6HtCD2adFQBNxOo4oeozbzjVfa9j8UiQubiKpaMwAhfub19N5aj
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3f07:b0:474:35a3:6300 with SMTP id
 ck7-20020a0566383f0700b0047435a36300mr42842jab.6.1708448824305; Tue, 20 Feb
 2024 09:07:04 -0800 (PST)
Date: Tue, 20 Feb 2024 09:07:04 -0800
In-Reply-To: <0000000000005f876b06075a4936@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a34ce0611d33dfa@google.com>
Subject: Re: [syzbot] [jfs?] INFO: task hung in lmLogClose (2)
From: syzbot <syzbot+cf96fe0f87933d5cd68a@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, postmaster@duagon.onmicrosoft.com, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14cf63d0180000
start commit:   b78b18fb8ee1 Merge tag 'erofs-for-6.6-rc5-fixes' of git://..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a5682d32a74b423
dashboard link: https://syzkaller.appspot.com/bug?extid=cf96fe0f87933d5cd68a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120a1c45680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1230440e680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

