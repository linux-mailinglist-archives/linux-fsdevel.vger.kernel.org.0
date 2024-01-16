Return-Path: <linux-fsdevel+bounces-8029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A07382E846
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 04:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B316B1F23A40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 03:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF49748F;
	Tue, 16 Jan 2024 03:35:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4666FD0
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 03:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3607ad143c2so79784365ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 19:35:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705376105; x=1705980905;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QDZPKLWcldx4Qh4G0TWmxOUwgI57VtugrnMHdb+OGCE=;
        b=xFOKC5iDU6AF3Yp9FEr2Igd/xKirCgeDdugrMvIY4rbS/Uqn8sas1E624J8xTMhZ6y
         /hvw59XnM2ExhGRgEXWcU/KGlqw6//ThvWVuUHYPvewV5UjioroT2RjPmrdWbuG1K5Sh
         qVRuzBm9MDohqGMrr7xlBycPiEwpH6AAbR5XaBFK7cD06JvAagwZaM/EIWL5w9GXZR5K
         y96RJfeab5vekofm5Fh2Y2XHqHvS0eRfYmW+S4QpchyT6BMOKh1D9vc/ptSJx0hxZqup
         YIpwO8XaYY3DLwF1QJiWD/PBp/sOpmG/OCKoDynQLSEcBke8SF8wTo062q7Zjxmtpqph
         XYpQ==
X-Gm-Message-State: AOJu0YxfkUPzIwHroHDS1SSLQVswYrI5WbW08ecaGFV/CzMPg2yW9ke3
	ed0GmDm1LWWtSGXMjQOywXDkkP0Q4oLVw5Zg1dJW16C3sFXC
X-Google-Smtp-Source: AGHT+IEmZtzkNJYz5yodsOTO/J/hRFV4GXetYqHl0g4+sQzW/5cRi3XB6vwH0HMFagaNmW5Hf5yS7qVF2+p4VnVeERztj0SwH9gi
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c49:b0:360:6649:29da with SMTP id
 d9-20020a056e021c4900b00360664929damr962185ilg.3.1705376105526; Mon, 15 Jan
 2024 19:35:05 -0800 (PST)
Date: Mon, 15 Jan 2024 19:35:05 -0800
In-Reply-To: <00000000000057049306049e0525@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa7c3b060f07d0ab@google.com>
Subject: Re: [syzbot] [gfs2?] BUG: sleeping function called from invalid
 context in glock_hash_walk
From: syzbot <syzbot+10c6178a65acf04efe47@syzkaller.appspotmail.com>
To: agruenba@redhat.com, axboe@kernel.dk, brauner@kernel.org, 
	cluster-devel@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=165bebf5e80000
start commit:   3f86ed6ec0b3 Merge tag 'arc-6.6-rc1' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff0db7a15ba54ead
dashboard link: https://syzkaller.appspot.com/bug?extid=10c6178a65acf04efe47
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e4ea14680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f76f10680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

