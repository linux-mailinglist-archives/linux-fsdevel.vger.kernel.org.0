Return-Path: <linux-fsdevel+bounces-12301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505DF85E55F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 19:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F1C284396
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 18:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F5C85276;
	Wed, 21 Feb 2024 18:18:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B7A42A8B
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539486; cv=none; b=DU1JXJI7gwRJ00k42gySTcUFV32XoEr0q9GkTbcsNnKRKBXBXW+iUq0Z7sIC7OrRK5nS26rQYsf0gbXhj0kGlzTAmkYo/JG3yiz0Qlfcxkkn9IY0yLrZT+yVREk5ERPIbO9URa2scAQKPiGWhvDxroF9aMgtWvY0Qn0QiBUtjBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539486; c=relaxed/simple;
	bh=Aim7Qpie5ii7CQT/cjFzRoVNO7qGkO73CWE8Fvg1iLk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pSrEpzdmmJveo/MMl8z7ny2cekWKp5Kux4EF32xMKQs7WfNjTwdxZNhu6xHTNXBB0nXWTYwg6bYw9hvM0sSa2EmD6pUoX5LF1LxE9itEL3iayORXPuUmuV+jPNnQGbm4MSaNkfFQPwjKB6kX0BQDksxrd8SzMo8fgJMhy/cvG9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36531d770d1so34567195ab.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 10:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708539484; x=1709144284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MJd9Mq9bf/RBjIYNar7qNvmrsOG2DCgFiKzOfjcbWYE=;
        b=LfGRmMFJUcGB+JhU28k+t3eDaRbn7M0HiSy75+MSfx0IJvGY6xWCtZArdqgH9nTi6m
         7g2hEJ7PI+Er5yP1rqPUR73rNeLtZnsslXcxG5fz3UScaKjuIkt0l6Evyh4pmct90K+P
         hpSIQQugCoO+QgidgN78WSJ9SpvfspmfJZPjsrbpuJ/8J/63PfNnbvHeq3lDnFZdewuT
         jdMkQdhWedcuND6hH68axKw3z2q246QS6YmYeNWvE4CDVPO2VQoeDqDflgbKWaKbziCm
         MYF6XhxQ1YeKJuQbOK6HASXICERqLp3qdWe7Ax6qS6UN/23VNWPc9idfgsjiBVHVKFdX
         7Aqg==
X-Forwarded-Encrypted: i=1; AJvYcCU6C+i8bMmlJGfHKAw+qwKF00qYMj5jfvTnouZaXZgfSfiU8cK1o0xeyTms6EEUACLqshRbXxDq5tzviqWuH2o2MYABjGjTczf+dgABHg==
X-Gm-Message-State: AOJu0Yw1yP7V0H2tNDNWvjSEFI7DNg9gxuL5SxibcDwt4oYUZxcB/+nU
	ACaQhUWnGvCJdMNVQCHvK8n+GAxxNMADXN9O7aMqZCYPlS4ODJ2I1XCbTSYHCu4xXdzJJPZHem9
	90VxZ9Z4pV+uAuRnwhkYJE98AVD02xmqyPWjZAHxxod8br9LyT7msitQ=
X-Google-Smtp-Source: AGHT+IGLjTi1I4UnSLykK1KGsO3JplFSALaCXnxdpBvFruTsaOMe8XAVmVMcSAgBRngvxmFZPL1x1S8GHu+QOv7QW+ugTVfQa3ve
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154f:b0:363:de50:f7bb with SMTP id
 j15-20020a056e02154f00b00363de50f7bbmr1446503ilu.2.1708539483081; Wed, 21 Feb
 2024 10:18:03 -0800 (PST)
Date: Wed, 21 Feb 2024 10:18:03 -0800
In-Reply-To: <00000000000010719b05fed5d82f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f95a7a0611e85807@google.com>
Subject: Re: [syzbot] [reiserfs] BUG: corrupted list in __mark_inode_dirty
From: syzbot <syzbot+4a16683f5520de8e47c4@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1410e3d0180000
start commit:   45a3e24f65e9 Linux 6.4-rc7
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=24ce1b2abaee24cc
dashboard link: https://syzkaller.appspot.com/bug?extid=4a16683f5520de8e47c4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16bd1013280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=101d4adf280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

