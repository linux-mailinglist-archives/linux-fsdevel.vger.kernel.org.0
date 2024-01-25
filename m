Return-Path: <linux-fsdevel+bounces-8838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F25383B7B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 04:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72F29B25557
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 03:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BA47490;
	Thu, 25 Jan 2024 03:17:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56B763AC
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 03:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706152625; cv=none; b=YMnBpltHSktX23YNtS+NMhZw+5zz838INgyT+zkWzxxcIHqV+LSrJDqbiZgSXWJ2oOi5VjM4umGIhAVzzHIuRx4KingsIuP3rHEMG4iApZ7E2v2sxMSsAmEewtim0/o1Q/QTifWNmtP7V2JdkzLUJ1xL6o4JKUd05gAhY794rW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706152625; c=relaxed/simple;
	bh=3b4QVeF1pYvzutP3o1SR8RZDpRDEWY4FFGHRQYxAq34=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LgLmHoWc/5CjkxIcN7NGkyHg0/FsCDqEaINSpgkCaulis5s7YlPiGR+/8aKYRNZ/e3OHT2dXhqBwAxn2WXvkA8KLrHSH2WygOmbuELl9oDYoBV6xis1OvkLJwrqyYCimhPEHIkAJg8uFuPbmHuG4DmNBX8W4CN2TVf8PwflmlE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bbb3de4dcbso979791939f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 19:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706152623; x=1706757423;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLRpZma8mtLPRBhL0fvyMPkNbwpSrpDOLPb1BBDBo+Y=;
        b=UiZbfx7DAb49lgdST/i2mkLc7OL8cMOK1DoEd/8DIEgAg3Jm8A8KXeVs+o28+d97NO
         R43bKXA8pi2v2zUGu3UfhpRco9BmbB2zI/5DVPrrcW5vzjZY3HZcCIdPKpfKtQGXl36a
         XCLAq7jraz5YJfPhhJU03aaTKmplYrlQi9YJdz09Nfcp5vww1JVOY5WX1Sl6wqvBDZgg
         iwk7NmLBn2lQhtma7/dCwPCCcojP7WDPOWu/b3hZeEAxuc3V7DBJDZXC0RL3mIWGWNva
         3dxPZJHkQ6bMCMJOQXNQj3v63riDwKKmLdBt34DiUOrD6W8tF4A993Y7Yy2YEaJAXX11
         ks4A==
X-Gm-Message-State: AOJu0Yzka3KzDWo8PrXqasEI6EDuB5dccSTaQIGBPhWIwOlq7PZZ52kF
	4HsLVBhZXAj1Nx/EZaW95BCD+1+uNEFHQmttMwNdonkZlnuRnY56G3vrFXvOryN94BIcE7JeuJ8
	Ue0JBKEHNZchxFcax7nQB40stzrHQ/pctjMTiPf+mXhMegxioMTiJJsw=
X-Google-Smtp-Source: AGHT+IHKRif9C2TVCAnTB+ddDTrv8NsXW4n+JGnOJwbfjQJTlgshEPUGDuOThKi5/ROZbD1cuw/iTate8kx83vH4uJP39FCE7aVp
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22cf:b0:46e:d5b8:e1e2 with SMTP id
 j15-20020a05663822cf00b0046ed5b8e1e2mr11984jat.4.1706152623065; Wed, 24 Jan
 2024 19:17:03 -0800 (PST)
Date: Wed, 24 Jan 2024 19:17:03 -0800
In-Reply-To: <000000000000562d8105f5ecc4ca@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000007cd5c060fbc9da4@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data_end
From: syzbot <syzbot+198e7455f3a4f38b838a@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, axboe@kernel.dk, brauner@kernel.org, 
	jack@suse.cz, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1682e45fe80000
start commit:   90b0c2b2edd1 Merge tag 'pinctrl-v6.7-1' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=93ac5233c138249e
dashboard link: https://syzkaller.appspot.com/bug?extid=198e7455f3a4f38b838a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17277d7f680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123c58df680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

