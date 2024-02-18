Return-Path: <linux-fsdevel+bounces-11963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D748859A27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 00:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC66B2814D6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 23:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406F771B4A;
	Sun, 18 Feb 2024 23:02:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8172AF10
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Feb 2024 23:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708297325; cv=none; b=p/2erBy2qR/h7jGhJW1pFDE8EMyU4P6T97dXWjlns8a+BRapK7rGlWcp2CpuJULoqULmdIhdFrdew4+PwGtw8uYiDU2Z3tCFh8Rv2E87glOMQUttkMLBS/A39cKBV8UPv820dp5tENuhiwQI6EKIlcbB/ytGMIDfuYabQDYnYdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708297325; c=relaxed/simple;
	bh=gx08vrFga24mpJKJ6CkD8XwWwRlSzoVynbkz6tjlUdU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NFYu411FtI7UBLI46PLXVF221aFzrbIbAX5lqjMt7fS/3Da9a28i33HTZU2sp1yI4RbtsPbc8Trzonzby78urGgdjdxROd6hpBHqyRlAwLECMFnKwroJT12euAcezlrbI5vT6QLDPtlqDY24IaNEggEF4X7kdtm2wCplo+a98gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363dfabfb34so35337575ab.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Feb 2024 15:02:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708297323; x=1708902123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jbqMO01/H/iqr4yf8kLtqB/zmeOqiP/DRUeUMAwyX08=;
        b=gd+CuOWdUzu1iVNWQk4IH414F2NTjLup6tzpxirrsLEpmaNe08rbOI3tARWfiMZ9Dk
         uJUB0uIgte/dKLvusHFQDB6rKdLNygUaz6OuhwuMCRh/ikGKBUxpgyJBdTOnviXsV7Ac
         6AjL2c6sv1WDv49xELIpdoPBfDboO6qv33guQnjD9S0EXL3DHvh0BSGbwhUoe7+8kBPs
         nZ/8zflhDSXnlx3/tXN9QpvCnKy4T6xLIA9jZySWYU0YKVUWk3Y+vEvCDPB9gLmriPIe
         hf9AfUyUxWmKm2m4TP1GyHEUiIznwgIDbkfqezxS/yz6RmrRguOX0SvDwcN1inVR8bjx
         e1Tg==
X-Forwarded-Encrypted: i=1; AJvYcCU3gVHklbCdDd2RW8vHgXNfWQsM9UYJm8tiXr6Y+SBKc/WpsMLUj2wQHFURTgAy/1ZL4lTtx7QttGi4Mr+rqKnFZ7bYz+wsXJJz9haboQ==
X-Gm-Message-State: AOJu0YzEzCnS9pTtFvI7nHOfgqhEePHzjLOIgGUmHrhr4Jpw9zg7NPfv
	18iKaRmWlQUKfGFYUtvpDy/xjOcR6jl72Xe7rdUMY+ElYVb21tCDCQ6Q11RIPHoMD5fpFf1fvG+
	Zn3XuT2WwNPLRipWmnWIndS7bKqvQWzwHUAEPoxh8nl4Xg1p8dlSxT0s=
X-Google-Smtp-Source: AGHT+IESg5nnX2NxCKLcT/j7td4ev2NPLuE2YZ2CwDqs2gyjCZhR5rLABe2T5nq7AHEkvwhfpPGVVoAbHx10tudQ9hnZVE8Tt9ji
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d92:b0:365:21f4:701a with SMTP id
 h18-20020a056e021d9200b0036521f4701amr328766ila.4.1708297323738; Sun, 18 Feb
 2024 15:02:03 -0800 (PST)
Date: Sun, 18 Feb 2024 15:02:03 -0800
In-Reply-To: <00000000000081dba605f19d42dd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026ff9b0611aff742@google.com>
Subject: Re: [syzbot] [reiserfs?] kernel BUG in reiserfs_cut_from_item
From: syzbot <syzbot+b2c969f18c4ab30419f9@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yijiangshan@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1272f362180000
start commit:   88603b6dc419 Linux 6.2-rc2
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9babfdc3dd4772d0
dashboard link: https://syzkaller.appspot.com/bug?extid=b2c969f18c4ab30419f9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14edd048480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a5c50c480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

