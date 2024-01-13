Return-Path: <linux-fsdevel+bounces-7909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A3482CF5E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jan 2024 00:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA4A1F22055
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jan 2024 23:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59A118056;
	Sat, 13 Jan 2024 23:43:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378811802B
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jan 2024 23:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35fc70bd879so63649295ab.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jan 2024 15:43:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705189384; x=1705794184;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zVTEW8gc72M35iNvfDiHYtRKqIshGB2+jqJ982idX6k=;
        b=ji1EBnO0rCnma9bMOarhUbXsZt7RZvwt5kY2/NA4jR3VxY6VJxYgBZJ0JOhFnRLakI
         QW/iBhVCtScxi7/G/5OxO+ChU+mYHtyR6sq5Z4K7o+m0LDx/LJe3JITfmz4E0dexAa2I
         qxdgKhzKd0q0DVQMJILYqYR+lvynnWiub/vhy8uAXfD2MBt/LsEyiR/oggPtqeWtl3i5
         XkBf+OlYDNneq6VMdRpcDpoHtxXfEjqjhb8Ftd/WnqJEoI4y/vvp1vVO7WYFabwEyMBf
         +u26f6NHMMUjeo8pOCdCWYUg0e5YsFDJxI50lsSDnoBko4iCsOJ8p2MfyDDbyPr44AWV
         vhEQ==
X-Gm-Message-State: AOJu0YxQDOMAZCxGECbzqUihur5ZDmFsCl7iY/ykxNB006REOBEc/cQO
	9WBwEB/ssmVehataFKs49b0JVyg/yWV0DMPRYNsrI/wswryv
X-Google-Smtp-Source: AGHT+IEoE88xswoj1XMACKCuRvTqh3qvUyE+/ZEIUu0VnsFJvYaDtYF86Tu5LYULFTn2qTIYM66IXQwHIh12WrkP+WjTC6B3RfxB
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a03:b0:35f:affb:bd7b with SMTP id
 s3-20020a056e021a0300b0035faffbbd7bmr535715ild.2.1705189384468; Sat, 13 Jan
 2024 15:43:04 -0800 (PST)
Date: Sat, 13 Jan 2024 15:43:04 -0800
In-Reply-To: <000000000000ed1df405f05224aa@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008942ff060edc57fb@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_set_state
From: syzbot <syzbot+f91c29a5d5a01ada051a@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, axboe@kernel.dk, 
	brauner@kernel.org, bvanassche@acm.org, hch@lst.de, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, martin.petersen@oracle.com, nathan@kernel.org, 
	ndesaulniers@google.com, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, trix@redhat.com, viro@zeniv.linux.org.uk, 
	yanaijie@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10f71683e80000
start commit:   8f6f76a6a29f Merge tag 'mm-nonmm-stable-2023-11-02-14-08' ..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=94632a8e2ffd08bb
dashboard link: https://syzkaller.appspot.com/bug?extid=f91c29a5d5a01ada051a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15af0317680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10de04b0e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

