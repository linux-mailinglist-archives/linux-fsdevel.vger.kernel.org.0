Return-Path: <linux-fsdevel+bounces-54769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 662ACB02EAE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jul 2025 07:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93520189B9D6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jul 2025 05:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB71219D09C;
	Sun, 13 Jul 2025 05:16:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013D013C82E
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Jul 2025 05:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752383764; cv=none; b=HDOV/WfedtVmSDGq10S3wX48mF3bKz/H5it1mIuEjbotO6JIYtDDXSXhzExyFzdN/GAHDrZHDa+u7DiZCynUkTLPJDN0OtITSoMazZnYiM1L9XRsuQZ29JZsSNi2CXpYstN/29rgmZpY0gzGRjX0e39JMF0BSNWBATPusVBY6wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752383764; c=relaxed/simple;
	bh=KaX8JZDBQRrknH5V1BiCsjLxPQHPtL4K/I4ePVO5df0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=snxaE7G9IUcTdJQVnIiYgAyq8LHa94el6WW1EUjgQfZQh8TJ5n0w0uqsKLlEQOb8TrpDlkEr3OCNrvmcyFKCjl0tohyxOgZgzr/ELuHktsOi1CAsSUDZoqgtbF4AQ1wKD9yA05T2NCoj3Wezt6Gh6PbOCezwHi+QhAyPUdcjpmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-876a65a7157so309289839f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Jul 2025 22:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752383762; x=1752988562;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tgpX6hD7GrjQcqjiIlbZW6vXkUDki5U8wW6v/gISqd0=;
        b=dqvKDdppMSlRmK0bGHQTetlf7WFLw+AIstg5c2H/ZRv/ZH7yYc+c+9kCxGAG9qCi7P
         URBuC1Not7BiLME4FJaIyQKw8WgepeiAyTYoD9iLnjutozaYCbZuL4+6WozeSklpqmtQ
         dpzgx9g6UjHaR5zIhm+y+sZVwaSoyBaw0KuxdrPAbQzPR8QDS5TrazhdCve4u1msdz+R
         q5J97kilNdp/sA3xjctnkUgWPY2SlkS2py1DjgwlHuNdkz2idn3ROc1yJE2HFUDmD4js
         hdAWPCeIXUSGkcB4pihT0LUaKGL7zrkGsWNfMzCyA7oRmhKBBk++AxwJjXGETYcwaD5o
         CZNA==
X-Forwarded-Encrypted: i=1; AJvYcCV6vy+19vawjdf5jz8/5ZedYiU/wm0zJFl9nx0xVJWOcvWLoWp4SV2UewrxgxrKLKCWpnPfM01R+Gbew5I+@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh9b9OOROh3uZ8gdHjtvFiP6GHjRXEy4XL5MYByF3wjmUbaN9l
	8yGh5o1gUVeEeeQ+3F+dOrscyr21ouDKsZnJ58BpIXk48QZixaTiNli+Nm/R+lIjdyUMiVTEIRB
	dTV9d7iDkmpx9oRND3vZod1mmQc2coOOM92p8ikEBXkKZH/JfjcVxh4Jfc1Q=
X-Google-Smtp-Source: AGHT+IE5TAj6ixNXi3mwMFFkvM1B20dWMHYj8zdo+DgdUZ+dVVXcK6/2wL3n9BrJ2Wqj1AVmU6DrbMY60n+7W6uE/VpW/4b4J7xJ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5d:8553:0:b0:86a:441:25ca with SMTP id
 ca18e2360f4ac-87966fd24aemr1318525839f.6.1752383762008; Sat, 12 Jul 2025
 22:16:02 -0700 (PDT)
Date: Sat, 12 Jul 2025 22:16:01 -0700
In-Reply-To: <6824d556.a00a0220.104b28.0012.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68734111.a70a0220.3b380f.0020.GAE@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in do_move_mount (3)
From: syzbot <syzbot+799d4cf78a7476483ba2@syzkaller.appspotmail.com>
To: brauner@kernel.org, cem@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, lis@redhat.com, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 3b5260d12b1fe76b566fe182de8abc586b827ed0
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Fri May 23 23:20:36 2025 +0000

    Don't propagate mounts into detached trees

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=160a018c580000
start commit:   bec6f00f120e Merge tag 'usb-6.15-rc6' of git://git.kernel...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9683d529ec1b880
dashboard link: https://syzkaller.appspot.com/bug?extid=799d4cf78a7476483ba2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17eb1670580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17794cf4580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Don't propagate mounts into detached trees

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

