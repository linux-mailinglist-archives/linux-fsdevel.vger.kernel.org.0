Return-Path: <linux-fsdevel+bounces-36390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C2D9E30F1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 02:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82534167388
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 01:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5C72C181;
	Wed,  4 Dec 2024 01:51:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BABE22094
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 01:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733277066; cv=none; b=a19gG/92FpikAw5276pPIAUWQVxxXvowBPM+9JsR02Gf50Ji5J/87mcY33UPnwDp/yyB95dx0eXRfOB86PLHBtuS6MjI8p8guA5qlxjzILGuBSNvQiyFckQAVkT6eypbXTfh64tlYLhxsgRXGuRuy8bAgUaO9krz6QVLfp6jK5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733277066; c=relaxed/simple;
	bh=rWtZF8Dus1RjbJZaZTLBXSr66OIKeFm9TueYUIt7Zoc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SUas8ZbS3VBVeZI+2DUiKae6wptuE+6BITssHgo1MotXj7F8QhkSofAhaEe+H9IqjVSWS2M8rl6uaF//uXOyCUDVfANknF/ODwF5citdGKkxZ8NHAIGC/GKLa836bEMO677+suyKNR9NUpNECsVcahsCYz95eIfTDIPuAjD/RSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7e0d5899bso95117135ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Dec 2024 17:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733277062; x=1733881862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojyRDzOs4L5r1zvt5rLALFwRhgSLoRI+YAka9dryW2U=;
        b=s+CXkE91SWYduGm//4HLBNOoutM/AaqJE2P5oSSFCCgfbGAa0bMzFqgM8SVlj/DbEM
         eRwgiMH/IjHBz+J97YCpM8CbwSuDOtmcK48ecwTg5oh4eCY5nYQh0NXfIxhRfAHu2Qy4
         n/qBCF0UbyS4rKcjM4rU9VTWETcpZr0tJFlOd9/FStUBVw5ZHjuiqNcRMj8G962ymfcG
         SV3Dn/hU3xjKArq+SDmy06uaicRpXVkz2cwPCCCLXYmTInQtkBy7F+LzTjHHHijJvJrR
         tiRtZtbdOrF/iLB42voxmffR+i5mIEYYF389j8t2D7c4ycn9RBkAwQn9g9A3wf9AfBdX
         xPEg==
X-Forwarded-Encrypted: i=1; AJvYcCUpOt44++grSCdtoy+OxzzVgBDHEo19vNBH2A0Usr4t2Q1T2xT3nxSL/mecPGbulU9x/Ag/sTaM58D2+qFs@vger.kernel.org
X-Gm-Message-State: AOJu0YzWkRAuKcX14JBq7toJLjxsAOs7dhqd9TV046ORmW4Z/AwSXkjR
	ibroTW6LpKNp6EZK1z3qfDBIKfJVR5sHy5Spp4aMXa9aJe5x2Ch/uGVcUJLtTNuMhFJT2d/xNhP
	VCWOYNzLsAhV7hskuKm0JU+BG6UpRcGFdrd8UWtFNF8KFHV8CNtRXLXQ=
X-Google-Smtp-Source: AGHT+IGmDky9ubXMdmWEyJvsqWfLs/KF8vdb5UnF3UfBT6VPtkSCq7Mi1MPMv2mpAS+sZb0fM/xrpgyQuWJKEeTuR3Zk+AqaSlPn
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fce:b0:3a7:21ad:72a9 with SMTP id
 e9e14a558f8ab-3a7fed5f51amr26749215ab.17.1733277062597; Tue, 03 Dec 2024
 17:51:02 -0800 (PST)
Date: Tue, 03 Dec 2024 17:51:02 -0800
In-Reply-To: <589149.1733244622@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674fb586.050a0220.17bd51.0057.GAE@google.com>
Subject: Re: [syzbot] [netfs?] WARNING in netfs_retry_reads (2)
From: syzbot <syzbot+5621e2baf492be382fa9@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, bharathsm@microsoft.com, brauner@kernel.org, 
	dhowells@redhat.com, ericvh@kernel.org, jlayton@kernel.org, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	marc.dionne@auristor.com, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	netfs@lists.linux.dev, pc@manguebit.com, ronniesahlberg@gmail.com, 
	rostedt@goodmis.org, samba-technical@lists.samba.org, sfrench@samba.org, 
	sprasad@microsoft.com, syzkaller-bugs@googlegroups.com, tom@talpey.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5621e2baf492be382fa9@syzkaller.appspotmail.com
Tested-by: syzbot+5621e2baf492be382fa9@syzkaller.appspotmail.com

Tested on:

commit:         12588c3f netfs: Fix hang in synchronous read due to fa..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git netfs-writeback
console output: https://syzkaller.appspot.com/x/log.txt?x=135e1fc0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=5621e2baf492be382fa9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

