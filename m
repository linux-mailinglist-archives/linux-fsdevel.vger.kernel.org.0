Return-Path: <linux-fsdevel+bounces-45219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B37CA74DA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 16:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93180189D8F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 15:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07191D5162;
	Fri, 28 Mar 2025 15:22:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E3A1CF5E2
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Mar 2025 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743175325; cv=none; b=YwCiKJUy2YGkB/u1Hm5/xGtMT1boWZntEqnA0zK3fNBBIlqMDb+dEU9rhpafS8+o39W6PvZ6d5/WkfD//cnyxHHwQUqMHc0A9Hc2FaVQjawAI5alSGW88vI4cJPfZfjrCtqRHSMugxuMnk5rqwHGw7WIZcBCw++ijWJuc9b5hFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743175325; c=relaxed/simple;
	bh=9u95qfVKYEZf6M88dSEifsWoCD8sVYPu1+QrOe8tpdY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=f3nJgEmkMYg0rk97htRvBNRtlCjsjRtfycpkgiXyorY6l4sXJZNbivqumggFCvSXD+J6EVHz2kMlNgmmpX8sB33Qk4pvmhyAhyCftHiMkpdxBLXAzKlhesvQJsqFDlsIFnAEfhjKs8iEk53FNtG+VtYPmnPacE/KNmo+CNOx7JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ce8dadfb67so24877535ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Mar 2025 08:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743175323; x=1743780123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jR1mo/hCOtE3isFlkNzr3KUW3jS8AIZP6mXHPyq23eY=;
        b=YiYGYtDQ+P0RDfcovhfksjrIbUnml5b0wdtOfkvR2MrLo6GaaJMe2oCCfesf5kVfaC
         V1pFGKwQ30be+wtwC4XQwWoOvskMYy4xQ309L555QtL2s/2ytJU2JVkfzkne5xMeBIqh
         rW26lARUXxYC4BWYexdxtd1cxC1IDpvuQqDsc/cqgAWvQYZXbZBfas9msXfFAeal+8u3
         jatJmJHlxKYZp7enBCYghMhvRmNbeMM44x+vbTWN4LUZesaQnCOVcG0a6lMvmI3Wp7G1
         Zelxzx+NV1jBeDVbCHjOev6cWa1qfvRFRH+2tQamE8qr6XyIQzfP8kpE/OKYKsF79Hpk
         o6xQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLikFSIsyA6PvLFOcEc8nKt9RQjVoXf7WB7rzqC5GmE++Gp/XVF/Kt0wl0wuogKcL3g29lGxPquauRXWj4@vger.kernel.org
X-Gm-Message-State: AOJu0YyZkt2nt8Zt/WcuOCVmbgKYbJEegK+79dqFPRbmsqgFpBdYBaf1
	5QG4kvY+YwUT9lQ3sIrrW5SH+PA3fWljh3q5+i674uwjWfyi9ZRX4d7YO1KS0aj17G7nfKVPvCM
	L/Eb6PfqXbGwlf08bbz9hg9b5Y/SX8H34+xV71HRqlBxRZoxguXZyGrg=
X-Google-Smtp-Source: AGHT+IElOaU5aRIupz74EKbuSIxjuKtTVjRX81gJc0lcI6gjdITkNBPpSaXxPL8+zRjuYGJj3QnRTP8hXZNuoJpP4xv0FZKbVDAc
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c7:b0:3d1:79a1:5b85 with SMTP id
 e9e14a558f8ab-3d5cce290e8mr94000855ab.21.1743175322807; Fri, 28 Mar 2025
 08:22:02 -0700 (PDT)
Date: Fri, 28 Mar 2025 08:22:02 -0700
In-Reply-To: <20250328144928.GC29527@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e6be9a.050a0220.2f068f.007f.GAE@google.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
From: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, brauner@kernel.org, dhowells@redhat.com, 
	ericvh@kernel.org, jack@suse.cz, jlayton@kernel.org, kprateek.nayak@amd.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, mjguzik@gmail.com, 
	netfs@lists.linux.dev, oleg@redhat.com, swapnil.sapkal@amd.com, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com
Tested-by: syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com

Tested on:

commit:         aaec5a95 pipe_read: don't wake up the writer if the pi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1598064c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d5a2956e94d7972
dashboard link: https://syzkaller.appspot.com/bug?extid=62262fdc0e01d99573fc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16682a4c580000

Note: testing is done by a robot and is best-effort only.

