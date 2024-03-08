Return-Path: <linux-fsdevel+bounces-13999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CC78762C5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 12:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F9FC1C215FA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 11:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8043755E54;
	Fri,  8 Mar 2024 11:10:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C090C55C24
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Mar 2024 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709896206; cv=none; b=ib45t6vPIF3kxJ7Yu0PR5Kfpz4931mAWzUqvUV6nHWM/UgSoSKqz/WhEY3hqrzLlbVy1Ih+qhctwBFLcQX2pGlAivhZDN7AvgBXGsmKba+hc+ALsoCWQlvhgoHYZOzpDXy+ElsBke65op23CIdocXRAQvA4GABcnMfkxUWFqLaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709896206; c=relaxed/simple;
	bh=FrYzcEw0p+l4M5ctio1889wXMZgzFn5PhPC+9nAVQMQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=vGbpwUeF1wVsEQNyAQvjMob90ZIJmJvvlPu0Mk8wnAoow32vvAoNOp3m7HBU1OWrryy3GuUNvlrdLmPtjW9kREpAjpYZTAxCaeDQM6F2Qz8YYZMDdkJmzn39AQ8sJ5IC2QsqGJrxZ5co+7u48rws00HfBd1sMXYTkYWzyVxb8Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c83a903014so202501939f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Mar 2024 03:10:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709896203; x=1710501003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQ8TufsD7KPXCcu0y//i8jXNAGtGghQ7YVU08pwafXc=;
        b=uCfTHtVOEiEhtqgOHdgxCk0a6NlYGASU4qXWVqYuj7dkyMydSoXcm1Nc0VtQNiyote
         yu/MghYEW5S5dmlerGrv/8Ims1ypbNHChrGeIb+oqSW6MhDOZbC3Vq7O2fYjETYHmz/i
         80RKQEHFf0yQ/eZNXbHntbAjk3sRF+d9bwDxg6gb5SR8+fuiNhSUc3jMhQnVH67RPE7L
         huXzgxMyQEfeHjeILPr67n66BeJT2w2LahOvlCBTLcEpHhqIvXbWYZPozzYGRCEEzHRM
         hGiPgLrF49Du8VHNLDLuqSgHX2eBVLBqBGHOThUIEs6Tbqj5j3bF6VC73LM2ZGdeSuf+
         l38Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXqvMWTmZyyI83J1i9Gtffs2NPGmorYUQjby3sQUdlXwB9tKboDObMUfCekKg38aKe72hn6UlXrkRRc3xPS/P4h2RgjDY99VOz2Nt7/g==
X-Gm-Message-State: AOJu0Yw/lmMCxOpI9Sf+ilL6kJKjo81i2ADmfeCLc+x6e136gBUL9sJa
	5Jc0Zl6QkTRuvS0UGmCJEy4XlOgfIajbhDn/ubb/h+lelgDIf9pEenxBq5ZVNdx6AjEkm+vB7LV
	FvbzugGCln2nyikgFZ83QI3NvBP7HVMEbAlamL/2SWGhLkM+epGqo23o=
X-Google-Smtp-Source: AGHT+IGrLI/lkv//KLnRzr8N0GslKr2WdWvndoicXU9vRVvsv+s8NjyH+J4paVGfZOzRmFDKbXuH24vQEPpqDo/fnF7pqFuARKZw
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35a7:b0:475:402:bf46 with SMTP id
 v39-20020a05663835a700b004750402bf46mr413607jal.3.1709896203803; Fri, 08 Mar
 2024 03:10:03 -0800 (PST)
Date: Fri, 08 Mar 2024 03:10:03 -0800
In-Reply-To: <000000000000fd56c405eabc7b6d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4c7fb0613243b62@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in path_openat (2)
From: syzbot <syzbot+a844a888fbc0ba4829ce@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10a231de180000
start commit:   833477fce7a1 Merge tag 'sound-6.1-rc1' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd3623e135f4c106
dashboard link: https://syzkaller.appspot.com/bug?extid=a844a888fbc0ba4829ce
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10dfb81a880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a68f24880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

