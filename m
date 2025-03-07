Return-Path: <linux-fsdevel+bounces-43469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00181A56E3B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 17:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3970C1688CB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 16:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1A123E25A;
	Fri,  7 Mar 2025 16:49:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3A421C162
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741366145; cv=none; b=pC4a5wT3PFv3U8cGAx+yO38o7BsLzxG/pBm7+xrf67QzMpQLv++U79gNXdg2XCt/LIo+08YOROm4/JIeu34dxAEj2UoHXZgbzuRK9C5DYSHmeY6F0c36Fh7t9cEYMHvRkbCZNAzY+LS4RchiS7hXp9wM2hl08aIPTkkUurxyFs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741366145; c=relaxed/simple;
	bh=/wJpuBYFGqyGsKcbfLoTIr0DnUogrkKUH5AuAlKld8E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZW8x1Hwx4wNyaaA0l1R7UHQsOsfXKaaxCpeGK2fB/YfkRzSuHoXgrE/GG6W1tZdmjBe59GAwYo5RYim3lpO6Bg/eDtmg4DJ7QBC9gsuZ6ozeSaUt8pk5MTPX/qdNZUv1fPIMIwBz+vvkQ0YICcNEbFgXyhhf44KJkVndMpLtoGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8521d7980beso186050339f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Mar 2025 08:49:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741366142; x=1741970942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IStmfP5lSAveeL/IsEub3Jooz8LSUrjwYZpqh/aSwSc=;
        b=vDU2wjN9jGrZXlO9kszb8ffBFRsOgYKFOxkGHyLnadbKpoTcX2PX5Tjc8MGnwX4smr
         slr1T2ecGgFz68XNiPYkhfQvH0DtDuKnLHjkm5pAt76aM1dBQ9zoR8qeaF/GurkyVzUq
         w+HndBFBI9n2joaVHX+yAoqXXNJclz3cKKyfcu8tinz83z7R0AJrrQeEAuiqxHUfSzYP
         WGRVHAk0CaP60a0pLkqLhgmK9zoKv/R+Uha0VpKqMi9giQDAPAR0yhhnW4OYdh0PWntM
         Jctf4dLLHm/yOecgvlbMl2IJ/cWPP/njodIWOFax3Oh2eJRjUmTdjMmIShhCtjV8hVHr
         SAqA==
X-Forwarded-Encrypted: i=1; AJvYcCX4tg/XprIYD85OGm1huk1c+v6mCFeTJ48KdoSE7TzZeZCsZzi4w6nxH1PTbKpLAaeDZ1uOVjbsCdPdWgwc@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq7dvHhzIcgZlIPGZLWZJVgiBRMGo+TVN0loS5lo9oJDcLyuHU
	dRTYoAHNw4Ntk1FgNwzvI0mUot6RFSW0XnvzWXHn8AjQ2tLm0Vt0jEGlWHY8qi5oD3WLFoF1dHm
	NREB1O+eDC3mlr4q4H7jsiQSdWWfVxEorn9KmeTQxEjYYSPv2+IYgxDE=
X-Google-Smtp-Source: AGHT+IEQEA3LcE1eWTG3gvh0ZwCgkrms9t2GE5rGU0lzz95rIXyhA51eK+YLb5oJtrQ5onsKI2ZsJZJE+ZXfTS9GGEQJuyO9T+Vh
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174b:b0:3a7:820c:180a with SMTP id
 e9e14a558f8ab-3d441a12ce3mr52846825ab.19.1741366142691; Fri, 07 Mar 2025
 08:49:02 -0800 (PST)
Date: Fri, 07 Mar 2025 08:49:02 -0800
In-Reply-To: <CAOQ4uxjxbhJPDCBnuMMmkPchFiDOwX82-35jbhbrQkbp2Rsy6g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cb237e.050a0220.15b4b9.0083.GAE@google.com>
Subject: Re: [syzbot] [xfs?] WARNING in fsnotify_file_area_perm
From: syzbot <syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, amir73il@gmail.com, axboe@kernel.dk, 
	brauner@kernel.org, cem@kernel.org, chandan.babu@oracle.com, 
	djwong@kernel.org, jack@suse.cz, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com
Tested-by: syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com

Tested on:

commit:         ea33db4d fsnotify: avoid possible deadlock with HSM ho..
git tree:       https://github.com/amir73il/linux fsnotify-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=12494878580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=afb3000d0159783f
dashboard link: https://syzkaller.appspot.com/bug?extid=7229071b47908b19d5b7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

