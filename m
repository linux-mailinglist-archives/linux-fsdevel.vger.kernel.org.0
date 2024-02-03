Return-Path: <linux-fsdevel+bounces-10116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BB6847E4E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 03:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED85E1F28B35
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 02:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCDE747D;
	Sat,  3 Feb 2024 02:07:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAF46FA7
	for <linux-fsdevel@vger.kernel.org>; Sat,  3 Feb 2024 02:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706926026; cv=none; b=QUtX3enXeSxXW/teB8K2c7J5ox4zwC+BafKeZ7M7Alkm3B4/T8FL8+ZgoblmrG2JGMZ6qMsE2XOEkWXOwUktH6iX4t7zXgmmn/tDd9qhExhGub7I7Ufsnj3rDOHKQnLLN1LS62cG57a97tNMr4o5si42X3aqC0W94UOdk2wTcA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706926026; c=relaxed/simple;
	bh=i+JDF/U16A0h2ReCuKESPregCblwWsIb8m6CUL60Wpc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tqYy2e87dDmm2uVt3tZyGDvLOlTmfcGhyfQo+few0+H8oTmU9WSfevmL1lzzLQGqlO59mkQGc3i1FlZJij+A2D9u/JLhsuDkgbVV4hiRerMsyk6NwhBw4KXieoILuKGcq+wzXYZCo1HwPodj/XCF5yMu0MhfkISlrx+L74zQvBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363827f3e55so15517555ab.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 18:07:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706926024; x=1707530824;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gbrmRoGKWhe6TCC1sGE2MFNaSiHwcC3ZaDKpsmrHR/s=;
        b=woWHGEgjj4KZESp8UFwKvvCLYsqajwEEAP3Hugs0182e/8EOkg4sOpKvQbZ8vdTfQ1
         1C6t4EFztMGhzJuQ96tJpYOrQtg0dLE18jRt2zEO4uCHVpwTTtBHhs/o1rkM23NggfnB
         a7fIjG3UXQ85TFfrMgIb7WXFHLrQPsS34Ux/CRaddo6CmLY4zHGFoyBn3cO8/nn41HbM
         i59l2UmJsfrHsVRXzsImkySoJ2mWKxoBgedjYNRWT7+rhfhcY06T89Y3tERyiPuRheh0
         42TcE6R9qmO1XPw6GJZQNWIyAn+9iegDEvGwTh4oZA6bR/83mIqxB5jJ9sNWheAwQkZh
         JHAA==
X-Gm-Message-State: AOJu0YxNJBKfJaVXCfmhJ+A4Z/FQrJXE1clvFlBiJpY32Fhr/uZpXxBB
	EsUaxAcFi2sMVATSFhpdxnkXaJQm/7C5tXxvi/eQOqaJilAhlzx9vBLV11c+c346A7zMYmzCUNy
	CZUrlBWX4OSPdGqShiKST/0iY7h3Hw93il5dcIrVIWS/nsIMqWTRmeCQ=
X-Google-Smtp-Source: AGHT+IHwGrrxGICgqXvjF1ce4ToGFnpyWKkdzcU/b4TT1Lnl5bhAvElMzunisL/xzV0/F+QhMt/En7jAWF2jmQunOuCuK0a1HyCw
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170d:b0:363:85de:452c with SMTP id
 u13-20020a056e02170d00b0036385de452cmr341535ill.0.1706926024094; Fri, 02 Feb
 2024 18:07:04 -0800 (PST)
Date: Fri, 02 Feb 2024 18:07:04 -0800
In-Reply-To: <0000000000002a909705eb841dda@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000052fe42061070afc4@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_block_rsv_release
From: syzbot <syzbot+dde7e853812ed57835ea@syzkaller.appspotmail.com>
To: 18801353760@163.com, anand.jain@oracle.com, brauner@kernel.org, clm@fb.com, 
	dsterba@suse.com, johannes.thumshirn@wdc.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, nathan@kernel.org, 
	ndesaulniers@google.com, syzkaller-bugs@googlegroups.com, trix@redhat.com, 
	yin31149@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit a1912f712188291f9d7d434fba155461f1ebef66
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Wed Nov 22 17:17:55 2023 +0000

    btrfs: remove code for inode_cache and recovery mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=149a0a38180000
start commit:   7287904c8771 Merge tag 'for-linus-2023011801' of git://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d24faf5fc10540ae
dashboard link: https://syzkaller.appspot.com/bug?extid=dde7e853812ed57835ea
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f7a805480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10df5afe480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: remove code for inode_cache and recovery mount options

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

