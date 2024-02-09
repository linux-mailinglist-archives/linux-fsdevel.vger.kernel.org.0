Return-Path: <linux-fsdevel+bounces-10885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECEE84F271
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9641A1C24C1A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 09:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D651467E8A;
	Fri,  9 Feb 2024 09:42:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B2B66B52
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707471725; cv=none; b=DzHjxmMOx5FirLm2tcDTgBccS5XX3wxBHmMQd6Nj6dB0KgFglT6JN2L6mpUbT52PuQrSZNMkZv9fPRMXkYsRCc8XVa/v/HIrSG7flyIrcfpguZiWjXr+mF9u7CdpASLfOXQtRvr8M2FeWVFXrDR60juEdal5o8t2Pab5bSsw1OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707471725; c=relaxed/simple;
	bh=HBblHBVK+T/pHGkEyVDd8ntNpVOP52/53m6DEgx70f8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T0VUOQmkaawOIl55+939/MKfd+OZxS59piVizk2ODZzMGi1GKpil72hkC0RpexsCfQor8Q6pVO2pirDjGHGIaQZuKgOQzepjD3HtMxRTVSOLW1TGD9GguacHXw0sO99lj+RLu3fwMw4+h/CQ3W2rxKefpz7hMfJ9EVN1VVbPCZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7baa6cc3af2so77711539f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 01:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707471723; x=1708076523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkWlHeW+Ii/nHAjy7BeA1S7Bb1G242rO9yBCBU7fW6w=;
        b=dgo7NamyOGaK0H9sO5aYsa94g2gQ7MDf4fFgUobMxMPfOOnC5BU1GmFuhmFOpxeJun
         D/J3EoV/H3vLc5NLslhoXqxEbd6tg690hY3pZOkEJKaNpLKQwHQ3RzbZYFo0arzKq9IR
         GIPvuAvVqMueTsTnrelR24bx+7G5eLSsT+b5kpG6ZzasST+AaFtrO/IlgHa9SLvG8qEg
         h7ePC4LsAVLA5Y8uo5YsuGjeG+IpjWJRPpEhPUeRG7yMmeN20CLbUAzCFFsck4PPRizr
         f/CXayrtpqUtHPYXf6g+aJFRvJLjg82UUF8QAIHalaqYUnSsvjiK5y8qasnNSnCXv49x
         U2mg==
X-Forwarded-Encrypted: i=1; AJvYcCVBbJbrah8FkJnP5RCQgjTBMR5dce4dpqBnhHZasKRFPglNgBM087nKFzesIRUm2t5Ufy0vk6xJcxO3WQHCx+jhHysrbkCzbnlRaeODnQ==
X-Gm-Message-State: AOJu0Yw76ti2UnPmXZLjnkd1HcgOR8vQu1YaPh6If2d6bQfqEJ4wWMXc
	UAPXQGbNOS6dce2wQXXjZZGXtcqvPotgtqpfQKBnjYuLF08S9FQBwABamResLfsJwvACCLZy6b3
	lhZ6KOGEB+VG+FmI3IDRZg+6Q8dEo0NF/4qgFH67qkuNI4iA+n3sQC3I=
X-Google-Smtp-Source: AGHT+IHPX85UTLCU5j1b0GQA9sPLwiT+M3atEFtbQzJofqSpI8Q0b3O6bOG9fHOfNkzfkIJ16bAKD32qqwCZip7LGiHzeUZ2whCU
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6427:b0:7c3:b6:ebb5 with SMTP id
 gn39-20020a056602642700b007c300b6ebb5mr33233iob.2.1707471723280; Fri, 09 Feb
 2024 01:42:03 -0800 (PST)
Date: Fri, 09 Feb 2024 01:42:03 -0800
In-Reply-To: <00000000000075136e05fbf73d67@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000087bf8a0610efbdcc@google.com>
Subject: Re: [syzbot] [hfs?] KASAN: slab-use-after-free Read in hfsplus_read_wrapper
From: syzbot <syzbot+4b52080e97cde107939d@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15065d50180000
start commit:   88035e5694a8 Merge tag 'hid-for-linus-2023121201' of git:/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=be2bd0a72b52d4da
dashboard link: https://syzkaller.appspot.com/bug?extid=4b52080e97cde107939d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148fa88ae80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15067cc6e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

