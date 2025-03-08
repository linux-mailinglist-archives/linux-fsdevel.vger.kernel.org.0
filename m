Return-Path: <linux-fsdevel+bounces-43519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889BDA57C97
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 19:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C329D16D28B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 18:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC4C1E25F7;
	Sat,  8 Mar 2025 18:05:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12FA2A8C1
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Mar 2025 18:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741457104; cv=none; b=lF+4fcaIZEozl7iKHrnCc7NkQItWZd08Wte+xiHgP/zy8SO7ge46oHniRKTR2RJ6F3Vty2lQ42kZ1puHTgsV7KcqpfVFnqkHFWwJf6IMpIZWFuKH+ipysNG8wfS+LCqum16gWDmKPwpaKq7ZPnk60Qcl4PdnSopDVXSE6zc7GAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741457104; c=relaxed/simple;
	bh=BFERkLF5tvINM5AMTT7npfSqAfHAEvcSqvUAM7QVZ3I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KgaUjAgTYNN/0yOD+N6N21BQMDQBTbizjo0vHwIBn5v9iKOeX6ViYUFrr9Se2g1m8VFN28HHi+1jTPy3cgWPww6+m8o8QzPgGvq8YGa98Q+ZZ4ngRpa3AP1uvsbL2FeMmiDTSfGDB8YhKrpFW3YYrRbZSgqZaLmtVYj30wMB2VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d2a379bbf0so61970655ab.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Mar 2025 10:05:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741457102; x=1742061902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OiC+HbgW7R0gX7hV59VQWjAiqUZG5JTOlemCDNoKGj8=;
        b=iFNZa0B6SlkC6ebd29VJZAaehyPxHkbkyMHJui4lCeuOu5rB1SfHQsyRtHAgS8m6jt
         2bbRGUWF1mB0lWS/QuROzg4ECUGlaacE/H44SGfGEladCKvXeEX/GSXJI59O/cG36rg2
         lbxZ4c3S8IKV4E+jLx0FsVymb/Rf3LQhhkeH8e49A+sICH+tbk5iD7tJjjsyne8veTyV
         u22ic6wdWL9askmA6QkPH/HMIiSdq5rT8dwjDxLnxVeiBPKvfqLqRo0eOcgZMoVb3SYC
         72CKa3Jdi0CvRUFkPsF1fTL0rbAiSOPxm4OKzjwSWkGrMYi2IIYRC10OKgxuUnKjAGtb
         xeQw==
X-Forwarded-Encrypted: i=1; AJvYcCVjj6YhRpndM4H5Q/2qYow8kXanp/wg2KLmPGiOXL9n+TE/x6Uwq2y58YO/I/wL5U0wW65S1ob3Fh4rS/n4@vger.kernel.org
X-Gm-Message-State: AOJu0YxsGPeuGidcoB0JI9bGdVfcO7VxELRbEH5JArvfkKgUkXpP99PU
	2x67/rsciEALvIqeoXgQa4RnDvOBmN5M6CiwAbKVM6esz8scN/mkbuDd/rq+PJqFt5FhXOI8onV
	PFC4TeizqwgW1O097/wveyfR0qGrkd0/bbpRBfjdZaY4rrTKKxviaVxo=
X-Google-Smtp-Source: AGHT+IHNb06mTcXNBo2l2kG6CG6ZgzR/xmoJHMjCzX6KgJmQOHH+vrlcKgCoFFOUfoQHb7qgCic7gpJhxxqxAoJlleYqBBCxzlUq
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:11:b0:3d4:3c21:ba71 with SMTP id
 e9e14a558f8ab-3d4419ff144mr116769525ab.18.1741457101875; Sat, 08 Mar 2025
 10:05:01 -0800 (PST)
Date: Sat, 08 Mar 2025 10:05:01 -0800
In-Reply-To: <67a310c5.050a0220.50516.0011.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cc86cd.050a0220.14db68.0037.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] general protection fault in inode_permission (3)
From: syzbot <syzbot+1facc65919790d188467@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 14152654805256d760315ec24e414363bfa19a06
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Mon Nov 25 05:21:27 2024 +0000

    bcachefs: Bad btree roots are now autofix

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10305878580000
start commit:   69b8923f5003 Merge tag 'for-linus-6.14-ofs4' of git://git...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12305878580000
console output: https://syzkaller.appspot.com/x/log.txt?x=14305878580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57ab43c279fa614d
dashboard link: https://syzkaller.appspot.com/bug?extid=1facc65919790d188467
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149d95f8580000

Reported-by: syzbot+1facc65919790d188467@syzkaller.appspotmail.com
Fixes: 141526548052 ("bcachefs: Bad btree roots are now autofix")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

