Return-Path: <linux-fsdevel+bounces-12710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 052D68629A2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 08:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BCBC1F21C62
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 07:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8C6DDDA;
	Sun, 25 Feb 2024 07:28:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBEFD520
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 07:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708846085; cv=none; b=uVnDnOW14eyVkJmgS/KM8XHFVpnldcC10uyvqaoo9d35TT0snv2RKImWMSsJI9UxBSj5W7Q80aaxwevtg81TBZmgwoiKGrRQ5cv9T3ZX935V18Wq1hAj+UaFf9KDDQiQoeYWXfjZL3Q9jjk8Zo5OaXh9v6YvLC//Vk+KTZHNLvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708846085; c=relaxed/simple;
	bh=unoUZHnNLWo85kVwRNGfukzNpxB9UQvc6x3BLRWDZdI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hX2I3fP2pUB7exXtahiEjnjUx2uXvrjXFuwTFvuBYphSLzJ/T18aOtgZC/umKeDBcuajG9nzmB/84qoUad8SO7OOcruJ0A7+qjwXntbr23wdvnTq9XuAr/GLQXpuC/U5B2dGDtTpFUwnQC11O7mrnwDvFlSCgFAXB+n3pJ2uT8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363b161279aso21237025ab.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 23:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708846083; x=1709450883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TzsFQMYU8YtNGOBZjM6fd0mO1h4UtTBUtieIA5+iT0w=;
        b=CokPVjl9DKi9XLzvuYgD9nYYHfHrc1Zj2mbmFoflB8Fln3j4e7hVuvy4EclL5VvN57
         Fs2C2yakIpKe99Jxr8+KlgntEw8LwZrZ9gMupJUvfIHIvYG3bPGK0gAhUB/62aoKn6Uv
         i0ddhot00WCrXjlYCRU2+L6841S70hPnzPCHn+RIFzHmCphygFfkLs52e+asXvKc3d6b
         Y1dn4jzWAyT6TJKwQEptNxB+gJrSB/j5drI2fuavDQqcHKdSd5D/BLVttDQw0hbi9lXk
         Ncqy829EWVBoCejylYunDuxkTUnLZM47UCPOeS/wpBrQqIA1auZ8WWbka5G7NUa+LrGt
         eJIg==
X-Forwarded-Encrypted: i=1; AJvYcCVlYeDNM/NA4cRdJCoCtJUcOqLmV3NkxBKW/ZWgBKNE1AIbusXAJf2HZGuUcnVfr/llZ1QwiHTbWmbXqQtQcqaXDYxZqG9d0DNC9eQfbw==
X-Gm-Message-State: AOJu0Yzkxbh9FsbpKj/cwAWLrcCiHyyFePCuwuh+9VKIpedbk7r+ZHu3
	61wvzBQf/LOieKCpeThvERc7f/l2ke6M+CD+RRy/MsVmHgTa0xWbjUExvoXufkxYe093g6p7a7h
	uSs6GqkjeSy0UcSYzlqzLIpszQsXs6ynfNAXUBHlE17s5GEM9o7QayQs=
X-Google-Smtp-Source: AGHT+IHMzsSTbqyGkWMdz6rESKzE7k0hvpJkoDrMjtx+4rAEl5iPtoYZeEnv9sgMQieN4CN0vwu7qeu/Lc7SMTpoBQs9YEgIvxul
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0a:b0:365:4d61:fe6 with SMTP id
 i10-20020a056e021d0a00b003654d610fe6mr251453ila.1.1708846082942; Sat, 24 Feb
 2024 23:28:02 -0800 (PST)
Date: Sat, 24 Feb 2024 23:28:02 -0800
In-Reply-To: <0000000000006c9d500608b2c62b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bfed0206122fbb7c@google.com>
Subject: Re: [syzbot] [x25?] [reiserfs?] general protection fault in lapbeth_data_transmit
From: syzbot <syzbot+6062afbf92a14f75d88b@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, davem@davemloft.net, 
	edumazet@google.com, jack@suse.cz, kuba@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-x25@vger.kernel.org, ms@dev.tdt.de, netdev@vger.kernel.org, 
	pabeni@redhat.com, reiserfs-devel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12dcaac4180000
start commit:   1b29d271614a Merge tag 'staging-6.4-rc7' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac246111fb601aec
dashboard link: https://syzkaller.appspot.com/bug?extid=6062afbf92a14f75d88b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=150a0f73280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107fcaff280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

