Return-Path: <linux-fsdevel+bounces-8399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C5F835D4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 09:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD60D1F22162
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 08:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6656B3A1CA;
	Mon, 22 Jan 2024 08:49:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27CA38FBC
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913346; cv=none; b=nX50w4vp63IUeO8wU6KUY9nPXPW8UCQo4TKCfBaFcyqHcMxh+utcyM6XlRLvc7Wg+Q4KXIPIIWoRk5D8DNAql3G3rUAimHRWn3+FQYQF68I8H1h3SzDoCVIUGbsaNSFkOWR1++NR86LoROek+QlxuPoXQaI0sBSCwrw93o97hZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913346; c=relaxed/simple;
	bh=R4ntAACS9EzHmtoY+v8OJQB2l8ziPJ7bgywydPrpGq0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=obUon38CJ5m+N2+QZLkV0CDMmDNJqvYz7r+j+HWahRXnxvzF+Kq5QSuHmlQWrGeIS9lWO6l6VtvAzH5McU6zcQ05WyStHHFSs5kvT4kb3AXH+i8XmeOCUNE7dmoPW7HAQVP29BrQlHAx42y9as6s6Mu/JbtDMT2n398xL9e8ezM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bef5e512b6so328386539f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 00:49:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705913344; x=1706518144;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/8AVNdoQPWp2f+5W+nX8tickhqM+iD/Jmzv3V7hzGW8=;
        b=T4wFmUVhix6jUO7xiSpxPfGMsYsdcs/j6qcykDNQJ4JonSbmgH6uZrvEfaWWcE2rQT
         qWsFEWr4OLADECGFMt3+uz5U2IliXgsqMHqzS9QLU804SsRJTCVvYTeimvObxE51Tf2g
         mzpA45OxFK9mtbm0NzN4TCR4ZaBMVoR+AF9j3btLm9jcB0rT/8U7+ga67Uy/Znon1e7C
         un0z2aVl/FOKT5shyyrbo00VquH4aUK3RiZ9+wDPGMpsLgyIttbQHAPEGTKz7cUPZ8bP
         ln4g5lwenlJugIfsZ4RBnP0cmiUme0xFrlMatW//Z5TX+Vnafn41175UKoGzHPP9FErz
         spZQ==
X-Gm-Message-State: AOJu0YxsWQV4y5e0RKCjwXWUob9qCXLIAaTvEG9HUS9TLpodp97Mm4vJ
	ESkcVih5hnvzQWT0cp4TN2kf1vJHpF71CqhsOTPGedWz87/6zcPiUDxjYxzR7cntzUTqayCPw08
	NyPZ7CvmMohgLEN6uM3ah0g/INinhE6SZes4Ni/BhWaaHtF5IIDRCumQ=
X-Google-Smtp-Source: AGHT+IFaDWbAjrBpuywanw5LizNvNrqLAq0GCqWgR/4DCPzj4MqX6RfZ27xHLqW+RrSsPc5IGN3ykdyaOyQIVlVWBXdSpuPU9Ayb
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2108:b0:46e:dc29:f36f with SMTP id
 n8-20020a056638210800b0046edc29f36fmr307033jaj.2.1705913344037; Mon, 22 Jan
 2024 00:49:04 -0800 (PST)
Date: Mon, 22 Jan 2024 00:49:04 -0800
In-Reply-To: <00000000000020a5790609bb5db8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e39a56060f84e6d9@google.com>
Subject: Re: [syzbot] [reiserfs?] kernel BUG in direntry_check_right
From: syzbot <syzbot+e57bfc56c27a9285a838@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, reiserfs-devel@vger.kernel.org, roberto.sassu@huawei.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14bedc9be80000
start commit:   305230142ae0 Merge tag 'pm-6.7-rc1-2' of git://git.kernel...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=e57bfc56c27a9285a838
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cb0588e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ce91ef680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

