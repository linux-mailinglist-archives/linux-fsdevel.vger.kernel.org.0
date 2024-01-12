Return-Path: <linux-fsdevel+bounces-7845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0228B82BA02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 04:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 959F7B21BD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 03:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2E01B27F;
	Fri, 12 Jan 2024 03:39:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463BD1A735
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 03:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bef5e512b6so235662039f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 19:39:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705030743; x=1705635543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xsULNSwGIqV6VUSGukBMzcLGajKxNSaJ734615aHwHA=;
        b=U0KtWdulR/WuxbwQpgRXqk1Oo6X+Nk5uCbFvEx4jjxSAmyKI25d0ETarr/BI59FIzo
         3M0fJQ+jAbTHnLHV6CoA3zV8YMBl7jpyDEF2aE7Mr95HTchKNFOVJgCD6fvGOLNwfhZA
         tC15VtTI8gIyw2B3eBrLJAzhHgkLVDEsUaNbXVlGlY49NhdGbk9Cic6XaiZ2WbQaZGkj
         KLDe483Ivlop9uHj7NPd/FExmTMX5+cnvtaTLU67LH05eq7s77v7TFp9vcMcaZONtVNz
         wfzW1gOceTHm5tm5K6gQgAm5SvP8WI5GnRLKL1rGnSfJOCI3If6N1u6aPZjlV0ZoH5Dy
         2nlQ==
X-Gm-Message-State: AOJu0YyQwWi9e1bGwRqOEy/I9AlKP2yx7r7cds3zjLy0+GkEuOHfQgfH
	n5x6pI7J1bkk2UIool4TQgz3Dqsll1+Udjrlx2J7XN7HKBWN
X-Google-Smtp-Source: AGHT+IFGqlpsi8dlH+HvtsYNFd8ARrOfbhWwGMTrVn2p9Ud5mrQRWT6kM7YT+oCmAt1Ng0h+W+FtJ+N/1VkAem0GQDq7T9nGEFaW
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:304a:b0:46e:50ab:6a54 with SMTP id
 u10-20020a056638304a00b0046e50ab6a54mr43374jak.1.1705030743535; Thu, 11 Jan
 2024 19:39:03 -0800 (PST)
Date: Thu, 11 Jan 2024 19:39:03 -0800
In-Reply-To: <000000000000ff4a1505e9f961a2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ccb6c6060eb767bd@google.com>
Subject: Re: [syzbot] [jfs?] general protection fault in dtSplitUp
From: syzbot <syzbot+172bdd582e5d63486948@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1268fc69e80000
start commit:   a70385240892 Merge tag 'perf_urgent_for_v6.1_rc2' of git:/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea03ca45176080bc
dashboard link: https://syzkaller.appspot.com/bug?extid=172bdd582e5d63486948
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15692dba880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15017b2c880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

