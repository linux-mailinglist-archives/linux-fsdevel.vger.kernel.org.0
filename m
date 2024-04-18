Return-Path: <linux-fsdevel+bounces-17230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B3A8A93F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 09:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917281F21680
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 07:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02709481A7;
	Thu, 18 Apr 2024 07:25:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FB98F6B
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Apr 2024 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425105; cv=none; b=pWV+ehWcaBBwx0LRpMEYpbaLhj24KTsfEgcND5W5qHDBRz6hkTmJpHA2ywMEUhj4uVIFCvcUTfUr5nO1r6nHwwGkqJt9rG3zKJNR9S1z90w+w2Rfwm6yEIEi1RIxTJIEC+9ikfYwe8clYKt/NswAIC61vl0NJsAKmLCX3AgtFpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425105; c=relaxed/simple;
	bh=3BjsP3nfhcuCH1XUcvjc1mQjPG2rS/A9hNNMjKKloA4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=joKXbxszmmDs2yBvOMd3/gH6NLyi79HOr1yK50gwxL5TUdAVKSpJ6L8GQDzH6GnPk4VIA4Fw4HsEGwXd6VKfEKiGzbIGx1/hRJhrz2qwpTAbgLMIbXoxptI0Mwy75sz74miFJe0Et0CKGYvuH6aqY0VtABgh7GnLSw9kZU/LF9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d65ffc786fso79776539f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Apr 2024 00:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713425103; x=1714029903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=emqYNM6uPXqfGXvH8IFE1wN5OYo8rRqGNB03LA9Oayo=;
        b=UmoAUr8XIu3/GvN8CafsoIZyaTJDuqIjTw6M3N0B4JonKETXkfGGm2Vu6HDwNuKe+F
         9I3zgMB9aO4pAP7xeuTbmAq4MFp82XPj1ozgg+KJLT5ZQH7hbbNWXug7/uPXNzTQy7fa
         a9Ps+Cl79eRLsP/OBIZ0kReUV5I/EZpg2WuNz1EAlO0vBEaAH2f/BtzmHjw4LrML1DUl
         Mi23IoMLHb4g71eYRPa64nl/E18lQBSzOuEwTIElERexF7kFdyQlvCLACTlnlSFLon9b
         miMKOklDzH7cPif0dYWyjRKb5sOKLFpC6+Y8p/1v0WQX5z9VE1w9RvFw6f4XZ0mMsPGi
         AC/w==
X-Forwarded-Encrypted: i=1; AJvYcCWdmL78yoEyYBHIKKJlX7/L5c3K3hJRukNuPr3CpCJSnQFOSvWQd3AbxrKNgJPeH6bMA3qUXPywHYV2BTuDCG1skUHuKqtMEkMgYf52NA==
X-Gm-Message-State: AOJu0Yzh46B/hhi+Y/aPbwiRM1HQ4qYYyzACC/u2LZ/Td2rA1EApmhhW
	knRpKhbz76LRiR5Qd/2lONZI5yA+hiBg/vueixQaVUBWt3Fwjki2FTGbaQLCxfbD1A74g7YMOnW
	eN672fPXvr5vM21DuhjOP29rHnzC1ZWRObYf9uBtLDt8IWXz6iz6Ozu8=
X-Google-Smtp-Source: AGHT+IGF7JBT1SXcfdi6VGIsYxKj6xCHnV9Ax77U49+mdHX7Gx1j4+mnLdCI3KvBBHJuH4ka95TKOzduhybc14CQuB94/6DNyKVL
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22d4:b0:482:fa29:27fa with SMTP id
 j20-20020a05663822d400b00482fa2927famr103840jat.1.1713425103510; Thu, 18 Apr
 2024 00:25:03 -0700 (PDT)
Date: Thu, 18 Apr 2024 00:25:03 -0700
In-Reply-To: <000000000000e21aa80604153281@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a4f241061659def0@google.com>
Subject: Re: [syzbot] [jfs?] INFO: task hung in jfs_commit_inode (2)
From: syzbot <syzbot+9157524e62303fd7b21c@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=155eb8f7180000
start commit:   4f9e7fabf864 Merge tag 'trace-v6.5-rc6' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b32f62c755c3a9c
dashboard link: https://syzkaller.appspot.com/bug?extid=9157524e62303fd7b21c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101aff5ba80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d78db0680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

