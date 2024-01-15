Return-Path: <linux-fsdevel+bounces-7928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F60882D581
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 10:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE9B1C211C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 09:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7DDF9E4;
	Mon, 15 Jan 2024 09:05:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2301EF9C1
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bc3dd97ddaso805228739f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 01:05:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705309504; x=1705914304;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LVx/TRY5+aM3lFW0CEf4g6+AvX+H1vWHWxhHpajIqc4=;
        b=AO+KymVEkgXcG8hlrke0jgk2mYupsqSzNsV+I08uCwePPF40+bHcl8eVN/65M96UZo
         Oqxvf5neyVEyVguq4Z3o9ltuLuaYqrbHJOXdmgkAs9Zyv7mKEXh9xVXlxOsrDq6Ha+ZS
         TJoDU0K/4Rz8i+j2QYCvnfkaC9ppzzTMnBlZr6qrVAqcPEa4UDZ/NVtmkBgHIi9bIy/L
         zEVAgZ7xzmCBhob6Tg/3THtgWUIjN7Ik2ft2hQFvGFKA2Dvl9/918Yi5IZ0J5mgDisBN
         RlRmjYtD9lswH5l6tIY60mLEBZCH0lSG/5Lh/bDbpITYEblr14pxqzBiDYLhIchZ+S9u
         /hoA==
X-Gm-Message-State: AOJu0YwJWTzsI0a/knXLUsCwi2WUrxukJZ0FaN5yaqHH8Ba6VBFFEu9i
	VGmA8J86S+sJV2Swu6tBpLZu9HVdyhI6Ff4S1NYObYyScql0
X-Google-Smtp-Source: AGHT+IFAHtwXsKwRc2tGaNFSUZ/qG8YpZXq3pp2yPUkA8Lw9Fb6OwGxvac+9eyj/z3Ljf8TR9XhcSxHYsB9JfXyjfMYncGkXFaPd
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1515:b0:46e:6732:763f with SMTP id
 b21-20020a056638151500b0046e6732763fmr221883jat.0.1705309504269; Mon, 15 Jan
 2024 01:05:04 -0800 (PST)
Date: Mon, 15 Jan 2024 01:05:04 -0800
In-Reply-To: <0000000000002562100600ed9473@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003bf67c060ef84f04@google.com>
Subject: Re: [syzbot] [ntfs?] BUG: unable to handle kernel paging request in lookup_open
From: syzbot <syzbot+84b5465f68c3eb82c161@syzkaller.appspotmail.com>
To: anton@tuxera.com, axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-ntfs-dev@lists.sourceforge.net, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11feec2be80000
start commit:   831fe284d827 Merge tag 'spi-fix-v6.5-rc1' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae56ea581f8fd3f3
dashboard link: https://syzkaller.appspot.com/bug?extid=84b5465f68c3eb82c161
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a52a24a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=156f908aa80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

