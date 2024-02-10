Return-Path: <linux-fsdevel+bounces-11051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F35B8504CE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 15:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B7491C20FB9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 14:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835C75BAD8;
	Sat, 10 Feb 2024 14:59:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3AF5B5CD
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Feb 2024 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707577147; cv=none; b=AnxgpIJjeMDFHUA6CUb+DqkPm7OsW4a3zCM0PA1fIg2tnR5LxrbR0D1HUOy7wzLOD3COWpgNoQdRw2BmBlrM78kkBaw2Mk7dHa+tfULCMQN17yy/+FDxVijJi/4IdZGfm4Iq9tDavUAuT+N4EQoTTK81oRlVxuiIKRyvu0buOOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707577147; c=relaxed/simple;
	bh=iMfLEeTHTbt85d74UE8+VxZe4C33mSor9bptkb0ZW3Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HN+H68Pwq8uPqw77y9TK0sa9OTXB0AiumULaJ4hFdOfd8HS626CyoE67+lMoxSx9UbhSsdzh3gFoGfhRSUa8Knatvxmad0HJv4CRpn6tiRQWeHsKFJdtqbGcFy/9/NAfqMmKG+QSAGDrnnLUxjZJmkIEp8C8zHK/ZCicyphL8Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-363e220bb2fso16998895ab.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Feb 2024 06:59:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707577145; x=1708181945;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nBaTulYzbUdDpsiTgalVNpa6HlwtpwY9I9TOZGhZE/M=;
        b=VbKsmfMz3X4oIMbjCSQE4Pxl0Sj86Nw85rs4cQgnKCh8AGUQQqwsQ5mvEmCja41SsA
         LvJbakIdwo1WXfPd/EGYwfd6lnozZMta2b85q1vBF4czM70/ffa/T8855lEEkSoBEzua
         1Vh1ibHG500ljR5K2bc08iiEVP7BF9l73YZW+YsfRAMIgtBNR8eYecbS2xgo1XZHKtok
         NEG7pUZwiEsrolJNaaE8xSc6GveR70Bsb1jsaLogP/vTUN9FGsH7AigSDklLGzDY/qXH
         3jQ/7c2rNGRup2YxIshZtswHPPPhOVDsIA6V46D76lbudXkzIW+kNSLRawh1I/flP+Hr
         zvHw==
X-Gm-Message-State: AOJu0Yz9jNXsYuVFqNlBn6z5y9gQn6n/Cr6bIPN9xuDLwsnJAEr3K9+7
	Xr5IyMaGwApnmTaG60qs3+UgK9NoUi/Z7aXugCWtCcz6JZv23XKPWptCABJMIdIZlo4k4tdRoAD
	FmFuRmI3tlL0OS7h+7/Dfu6xJyRPanqNo8R3j5RI8nicINjTXVnacf9I=
X-Google-Smtp-Source: AGHT+IGmAQRbDJqel4FaA4qUReFM5I2NwHCScpZnNSB6C4xHvyv5rabwFqEEw+dDZRjdgu4En3nr0xI0AspplmuTO0iQkmpt9pYy
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2e:b0:363:ac48:e28d with SMTP id
 g14-20020a056e021a2e00b00363ac48e28dmr222334ile.3.1707577145096; Sat, 10 Feb
 2024 06:59:05 -0800 (PST)
Date: Sat, 10 Feb 2024 06:59:05 -0800
In-Reply-To: <0000000000000126ec05ffd5a528@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002903a406110849e9@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_enable_quotas
From: syzbot <syzbot+693985588d7a5e439483@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, axboe@kernel.dk, brauner@kernel.org, 
	jack@suse.cz, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, nathan@kernel.org, 
	ndesaulniers@google.com, syzkaller-bugs@googlegroups.com, trix@redhat.com, 
	tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=147e5b20180000
start commit:   89bf6209cad6 Merge tag 'devicetree-fixes-for-6.5-2' of git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b32f62c755c3a9c
dashboard link: https://syzkaller.appspot.com/bug?extid=693985588d7a5e439483
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ba1fefa80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1636640fa80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

