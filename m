Return-Path: <linux-fsdevel+bounces-37283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 860339F0B7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 12:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3651888248
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 11:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B510E1DF757;
	Fri, 13 Dec 2024 11:43:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3001D1DF277
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 11:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734090185; cv=none; b=SFP/yYfs3GXR1mDS8jlQmx7Rq6yzCiOZ+KL0QNieqBZnjnws3qw1jvV+DfsbusNI1xaPN17xgkR0FKt2GAlF4sgTFvKHjycegVr+IbnG3TIK66FIQeKZxLQr675EwmMBbIVJP7NHi/C2nZLzfELnmR5lV9JsEmW3ew+gDpiwy1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734090185; c=relaxed/simple;
	bh=estDcRIo9Ps/V70akpJUOEghJnsuWqhCaWrCUbyCJD8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BH2TtFEiqLPK4AbXw59CjJBK47E1Qd0oaiPAkTTbBhLxJfw8vnCmvSukkTsv7j05GFxOGAZCFEBjwxH6OyCPQJzT6iqXAJ3lao4qCb7kv7jsDrLghKD+RTOkG8j5LGuSxHTfRlYSbRxNprDyI+NgLhaK/808febIjnmcQ+MhAxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a81357cdc7so26925985ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 03:43:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734090182; x=1734694982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6njtYwuuhlt+oJFig9mpzBM61IwvHlJyPr4iUNckOYs=;
        b=g6wuvwTq/ycqO8qigPFSa8s4ZWgtsOi79dsMefU83HwgnkrwW66ajbvL82plBFdFx1
         rcNXxhXXpvocPC0IxiLrp9QAX7A2hgfIVyobSZYvJHWiGfow47waWpVBMxL2ttjxJYRA
         VAOUAQywQKPttMZZNMmPr6vb6fJuXr6T8FCaePeI/kBiKTksoriMkfzdDBxMvIZl9EMo
         LvEvrVKu0eFcSUG3TcoxFapybMOOSG2QdrX2LLGTLG8stnEo37MCu/ovnO0lwMZZUW+3
         xpjU/zo9UI5nJznZTlTUvJ60l4JWcLwlZIRGVyDF4qsxqdKtf0oATlKZChk7wEiowSnD
         GlNw==
X-Forwarded-Encrypted: i=1; AJvYcCX2b5ihFJUvnEkr5JLgG6N3op+gGzTikdDkuvxqOJgNFW/+wOad4I1C2GcqbO8ftIQfVvYRZTo/XAE4vwK9@vger.kernel.org
X-Gm-Message-State: AOJu0Yy80xplZVr3faQjha8iypMKppiekHX+DLzAKrX7gQwVTSMZipBl
	bnnFudVx8OpW8pTDdbFC8ku+/LQIPtoceHC31+RK6MEhc1qM7HVME3dS3P1OhwGHlsBWtJR3oHw
	RcxiDicnKKQU3dzQBX+CUcZrV2XLYPdeigBxdj6F/LozrABbnTnl8Gwk=
X-Google-Smtp-Source: AGHT+IHDAFY/TJurokeAD58Ic6k8Gv/vDg0siFvYAkQ1NFVck19SuU1w02dmhAQMhWSSadJDht8QTW+J8baOcxgzM5T4zE7FxWYz
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c47:b0:3a7:c81e:825f with SMTP id
 e9e14a558f8ab-3b02d78812bmr23955515ab.9.1734090182295; Fri, 13 Dec 2024
 03:43:02 -0800 (PST)
Date: Fri, 13 Dec 2024 03:43:02 -0800
In-Reply-To: <675b61aa.050a0220.599f4.00bb.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675c1dc6.050a0220.17d782.000c.GAE@google.com>
Subject: Re: [syzbot] [tipc?] kernel BUG in __pskb_pull_tail
From: syzbot <syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com>
To: alsa-devel@alsa-project.org, asml.silence@gmail.com, axboe@kernel.dk, 
	clm@fb.com, davem@davemloft.net, dennis.dalessandro@cornelisnetworks.com, 
	dsterba@suse.com, edumazet@google.com, eric.dumazet@gmail.com, 
	horms@kernel.org, io-uring@vger.kernel.org, jasowang@redhat.com, 
	jdamato@fastly.com, jgg@ziepe.ca, jmaloy@redhat.com, josef@toxicpanda.com, 
	kuba@kernel.org, kvm@vger.kernel.org, leon@kernel.org, 
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, miklos@szeredi.hu, mst@redhat.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, pbonzini@redhat.com, 
	perex@perex.cz, stable@vger.kernel.org, stefanha@redhat.com, 
	syzkaller-bugs@googlegroups.com, tipc-discussion@lists.sourceforge.net, 
	tiwai@suse.com, viro@zeniv.linux.org.uk, 
	virtualization@lists.linux-foundation.org, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit de4f5fed3f231a8ff4790bf52975f847b95b85ea
Author: Jens Axboe <axboe@kernel.dk>
Date:   Wed Mar 29 14:52:15 2023 +0000

    iov_iter: add iter_iovec() helper

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17424730580000
start commit:   96b6fcc0ee41 Merge branch 'net-dsa-cleanup-eee-part-1'
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14c24730580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10c24730580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1362a5aee630ff34
dashboard link: https://syzkaller.appspot.com/bug?extid=4f66250f6663c0c1d67e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166944f8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1287ecdf980000

Reported-by: syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com
Fixes: de4f5fed3f23 ("iov_iter: add iter_iovec() helper")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

