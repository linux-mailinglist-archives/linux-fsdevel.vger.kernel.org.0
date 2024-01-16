Return-Path: <linux-fsdevel+bounces-8032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAF982EAC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 09:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E55A283F49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 08:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE1511CBC;
	Tue, 16 Jan 2024 08:20:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA3F11C84
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-360a49993dfso58464725ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 00:20:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705393207; x=1705998007;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P4AGGCWKnuT2bwg8lZv/N9IC2unP9VYmjMc7v61ESxY=;
        b=wWCUPKjt9bSHmB5skUNQqmpBfiBAWkQPoiSDaw2liQticwqjeSblm0rjkvEfUWklR4
         j+eafbjhFjRFBPUioYb37VevMMNzQatwPSxbIS6PNaM8/spDW+4dMqU7486keEgnxlau
         wAFKQkXjphHnpaVzEnzN8RytGjAFOtL31WBeUpLSwkDNTJalr+pVS+RF3Igjx116taVd
         uVQ2eApbsQYNAt9FGXchXTbWTl/x45uU3pT8twtJAcihO78dtQT4QUsKcOiJex7+SQTJ
         lJz80KDgMGMChIEUhPhHEZ4gJK/X81LQa4ENjdC7pUUYNyIAVTPei5vWdLld8lNea6Hp
         TFpA==
X-Gm-Message-State: AOJu0YzhjbwmVMpNsL7QCXA2VchV4VdCzlp3DtWJQOry9V5r1/6Rovl0
	VMvDW/td6+mzgl8ZiGfEDrmcKaZA5UXmVrL1Tw01Pb1cEmFN
X-Google-Smtp-Source: AGHT+IEb61hugOjJ5e8Jm0bjn5QogKBHjP7P1Is1XXv85ADzC6t1Ye75sSF5jszE4L8o1PWkAbSf388qLvDMVz7EDpzCwogHqtfj
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3206:b0:35f:ebc7:6065 with SMTP id
 cd6-20020a056e02320600b0035febc76065mr971207ilb.1.1705393206943; Tue, 16 Jan
 2024 00:20:06 -0800 (PST)
Date: Tue, 16 Jan 2024 00:20:06 -0800
In-Reply-To: <000000000000653bb6060afad327@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004d67e4060f0bcc7b@google.com>
Subject: Re: [syzbot] [bfs?] general protection fault in bfs_get_block (2)
From: syzbot <syzbot+dc6ed11a88fb40d6e184@syzkaller.appspotmail.com>
To: aivazian.tigran@gmail.com, axboe@kernel.dk, brauner@kernel.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yuran.pereira@hotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16c3c513e80000
start commit:   98b1cc82c4af Linux 6.7-rc2
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=aec35c1281ec0aaf
dashboard link: https://syzkaller.appspot.com/bug?extid=dc6ed11a88fb40d6e184
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16783b84e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=165172a0e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

