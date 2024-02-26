Return-Path: <linux-fsdevel+bounces-12737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C89EB866747
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 01:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B209C1C20993
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 00:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFF933EC;
	Mon, 26 Feb 2024 00:17:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174AF81E
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 00:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708906626; cv=none; b=f/8DAPTzDpomnD/Ky4Z3Kuj8zyBVSv3ztg0D8g/3KITp0QyxDbQs4/aBC8ZF32Nee1TSxaaVd6j0YCzZbNvrOEkihYSw/XCZFFi5LYsqij0BFBxJY8BdptJjCdjoM2FTTFzR0Zd409ja1gotCzB3X8amkYpbAMDARkDJc1kAHI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708906626; c=relaxed/simple;
	bh=uEPs3JVf4orzGIZKaOSre7Yc6cd3i87Gg03dlkfwZjo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TL0yIlB38opYkamBRICCjQudlHM0bLGPMGN+lXgp4pFAjKSQgH4QoGHqYDcewtgU5xenOoaQMPS3gAAJOX35Cn+UVGdgvmUg5+28JEbBFfn4fOM7FAngON9QlJ2moeZHELHCwQztXhoQg8x6KgMcgaIJevm4ZE74OMxYwPq4ftE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c78505a39eso270965739f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 16:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708906624; x=1709511424;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+KxGTuAn7JS3VSjYdk/J4G72DLu6mPsYSoTotXdZcE8=;
        b=QcNOPfW8jOsvib2As8osKOlnLUySZvVyyPeEprtpHWEGn9/rsc//nO2J5tKlVGFGZ3
         6trWNTnjfoKhQ6wq8qvvxSmbnZg48MML/qB9NjychJoAcU8lu7Op4+poIcwVyMvI+ren
         zHoGOhoRzaGUyBMcT+y2V+sX/UZYSieh+sF8agUZwVkb1rMmIuO6XfI+N9CRfi20D3kS
         nqQqRtbp27lUM8BbvKGDbM+hNM63hEpdxin6WUYKhvrl11952TpgYdnGH3nBwUlL145P
         fYLMPqbBGZfSoOC72eosRYMWLAaVAgngzoJU/imhWDicXBd1+jwKct4zL7zSRwXjydDB
         dWjA==
X-Forwarded-Encrypted: i=1; AJvYcCUp6Ovs6DBsF71Or5Nz236zeZSgdyXIRw7tpkRfGQwojg1wrxB5CzZl+zP5Cz9OdzmJtVQgohHlFPSpiEvYel6ZDj5MAhLzAm4LRsVX7g==
X-Gm-Message-State: AOJu0Yxcn9sMGvXIIQ7f6+7WFP7R6sIqDH+u+wF56JoXcDgOpb5q+f6R
	vOzyJwoYHiwxmXUFU54nGjY8ROds0Ujrk8TzBt6AU6u7xRYcnmVeXRCPqVI3hRyw+If+SRYOlEz
	WBG8JiK+DrJYPfNtyQTKCNLzV+9DCzQpA6abdKuDAAMRpcVR/cIJZRR8=
X-Google-Smtp-Source: AGHT+IEPdJiPXQk/Y5Ki4jmV6bC+J2REozS48fthEdh4ECHPMOB3DaTaQA533+TxJ4Giih0NBiJmzLT2i4axTx7Ya5eMyMIBM8aQ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2710:b0:474:77e9:bb16 with SMTP id
 m16-20020a056638271000b0047477e9bb16mr134065jav.0.1708906624287; Sun, 25 Feb
 2024 16:17:04 -0800 (PST)
Date: Sun, 25 Feb 2024 16:17:04 -0800
In-Reply-To: <000000000000a2c13905fda1757e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b8d8206123dd402@google.com>
Subject: Re: [syzbot] [hfs?] KASAN: slab-out-of-bounds Write in hfs_bnode_read_key
From: syzbot <syzbot+4f7a1fc5ec86b956afb4@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12e81c54180000
start commit:   e5282a7d8f6b Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=162cf2103e4a7453
dashboard link: https://syzkaller.appspot.com/bug?extid=4f7a1fc5ec86b956afb4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12feb345280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123cb2a5280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

