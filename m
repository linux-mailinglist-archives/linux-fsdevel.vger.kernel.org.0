Return-Path: <linux-fsdevel+bounces-67416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29097C3EF3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 09:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA7BC4E6AE5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 08:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D098B30FF3A;
	Fri,  7 Nov 2025 08:29:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AB030FC38
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 08:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504145; cv=none; b=OkM2I02T+kKS9/9FaY11WIXUWf/O7LebfccOTa7GMBF+xGRP/szxK2TVgXaCBwAi+cE/EEKorl6X8UGXRAlraed6bcMQQUSoWYptCgxB2+Z6UcrwfsV1pTbWZAjVtnM7RR2kg5fdE1PX4wJN30HMMxCJ1YFdRPIPxAJib/xMdBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504145; c=relaxed/simple;
	bh=eM1w4ZBPbYDyAQqhBKm9yeExpXKafhylVz6psHKWs6U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WD1ImX062bMVoBWHQu8R58lNfrmpAHpHDa/SV8gixOZ5q/czz2zj+TcG4R0JL7Emnhbhwdoo6hZu6s3Z9lwNkuNpvMXlU9joZ7OjOyJ/zuMc+RDbsXZveiKJay8xsLvCjFP7T7sQUsOulDtIgQCTXB/+vQeZ+tRkq0Luw/Yefxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43322fcfae7so5821455ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 00:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762504143; x=1763108943;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKGznwLgsnKxvJl/fWRptQzEdBM9eB+r6Y3776TINlY=;
        b=Y0UXAWiPAa9xYq5j5n3S9BwOmJBend6K+UjyQRIYSC3NfehwDv7Z0G8i0zRWPKl/Pe
         NzCHe7iB0SMsFcdPcjSqK7SbAK2GS0aYwCCHLC1SFQkCMqcOsFEFLopVjI6zCRwnKT01
         5X6jDFclbRriCoJ7s8lA2hnCthUpIWnzx9+TZ7a3jaFUD0GVZIVmsukShjt1tR1jtDwj
         cF9YW9lN0k8pbistqiWvlOejJrgYKS2Ox5yu8+2d83i5dI61HeE/8sRge24kgc5Z8166
         rLO1nY9q+6MaScELae4TTQ//n1FlzusUYrLyOF3LIAIw11l2XNiqK9tPX/QPfIFRcQIU
         yZag==
X-Forwarded-Encrypted: i=1; AJvYcCVc0Wk04g5qLrM3eCCQ5Obx8Wh6nbFbGfC/lacbQuK1+q7VITSZne43oL+gHNItqa4kV1o7PlJt5wwsy1rX@vger.kernel.org
X-Gm-Message-State: AOJu0YyIjHUDswQCrOfxy+z1C2ATqs+D1Df5SADXjuhQViRJQZbfgjyb
	3QokMX70/6DlguauQ2J8i8ENrJDfzq9IvezWk7EjHDad93oibk7lmEjW/UZqjE8Dd5t+INpPl8x
	D62OtM6Fh3zHZ0X+lsuLB+cAjU/VMrX5N39mPyf+ud8XLZIvC9bdjIYFRWmc=
X-Google-Smtp-Source: AGHT+IEt1bgr9GIx2Or3Ca0/Z0L3S7pHJ8nBvQxShCSy3z44CnyOYbrWwdfo64jehAdnzG4RsKxW4YkN23qeQYugiXbwPm/aB5pP
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0c:0:b0:433:3100:b3ea with SMTP id
 e9e14a558f8ab-4335f43dd27mr34640935ab.16.1762504143207; Fri, 07 Nov 2025
 00:29:03 -0800 (PST)
Date: Fri, 07 Nov 2025 00:29:03 -0800
In-Reply-To: <CAKYAXd8HxiEGLS4zBFEKAcxT_qtAFM8Ng0YKZ5seTnB3A_-RVQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690dadcf.a70a0220.22f260.002a.GAE@google.com>
Subject: Re: [syzbot] [exfat?] WARNING in __rt_mutex_slowlock_locked (2)
From: syzbot <syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com
Tested-by: syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com

Tested on:

commit:         4a0c9b33 Merge tag 'probes-fixes-v6.18-rc4' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16bb9084580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=5216036fc59c43d1ee02
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14711114580000

Note: testing is done by a robot and is best-effort only.

