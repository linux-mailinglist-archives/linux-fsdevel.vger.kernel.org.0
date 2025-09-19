Return-Path: <linux-fsdevel+bounces-62184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7377CB87893
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 02:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37FE51C86405
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 00:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A73320E005;
	Fri, 19 Sep 2025 00:47:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5730417A31E
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 00:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758242825; cv=none; b=VRSSG304o8m47ft/x91ipz45uEc1KTj4/mWeD3C8bKy+76w+kcRB8oiTBSsjslCNpYYqeX4a+1O1eB6bV3Prv73NJIyioF2xTACmgBtlez9SF4NKRBVR1sRpfUANJOUTCH8zEg6MeL1flJ/II0fApfgqUta1oPvDABo/RHgHfu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758242825; c=relaxed/simple;
	bh=GAyoTGXiwJpiSJtkzq7eimtPFrQs1luy6Xcd4e7gwm4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Xp/J/Q72YigyZHpl9u4mpjtULA/aUG2tHGNC5tD31pgBGp0dUnWwkd9Yemnq6kGOCI4NZfyWfXRCq7bmvcDWl/xrxGl/OiMNCWVUH4MBrQQYfarzFOSsfiF4p+PZsw1BjOFw4sNZM8USVbbta21X5g9/vMtwfKRvzmQHBSNl9qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42407cbc8d1so20942515ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 17:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758242823; x=1758847623;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F95r+cTSDsZmv2bsi7ZtAwmAtPSWWx5N9hZP+sQyKBY=;
        b=tWVSZo7iE4ZMBB4VRwvyvozjXOKHiHMjB1my3eNdmd0WXEi9c0P+aWCr+X8O/07rJC
         ww9EShCr+RhEsPMKonFe/nlqpESI4Fjv4TMf7mZbFTdE7zs1ksDU2ljuq6xo203LmQxU
         d4FTjzlgtbUe26yGSyqBIo0PHgPOM5IV/EbeCSo8RIGSvDab+Lx/7cqtSjcy8r8UJe+k
         XCK5sq0HZBV7Y/lAGyHa++mIRleFb/lf0it2QRxUvC5SCE+2x4RL8aKmEgqxFqBWaqBB
         BkSeKj81lLQa9fqpuDiQk/W8G7nFXA2H1XNxzWJjwcpQcJMX3YjpB7uSEIH9MPD4Lrh/
         mScQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5Fq+v0R267apH4ewVRIh9xa55m3u0zl5qzxuk+SAs/BvaStqot8B8hKoxLKxPuNsN44vXHziWxkFFy+25@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3GJOegvhgNJ5oagvJwPcNwPjj5clBk35c8J5kkMgvhaRfG6iN
	NMKDHuXUKsRlExwkymvyC/GAVEqnfETCjPu61j9MUVDCsAtpFWhWjLoU2WEgsxCQAit7E9PCUtf
	8zStydEi+Cy02yAo2HueM/nBw5VUMwzqOn1latLzQUZr3u02lMjo59CHdNVY=
X-Google-Smtp-Source: AGHT+IFOkT2sskOvdQRdZJpZwu0XZ4v5A2KP/qDpkW3dcDHnDZoHAMhH1SUsufhBPr8jsYoRlJ6NYQ1DJz7vrsuCddqRfqGjktXv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1746:b0:424:80f2:2a9 with SMTP id
 e9e14a558f8ab-42481902677mr25900315ab.5.1758242823605; Thu, 18 Sep 2025
 17:47:03 -0700 (PDT)
Date: Thu, 18 Sep 2025 17:47:03 -0700
In-Reply-To: <68cb3c24.050a0220.50883.0028.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cca807.050a0220.28a605.0013.GAE@google.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in vfs_utimes (3)
From: syzbot <syzbot+3815dce0acab6c55984e@syzkaller.appspotmail.com>
To: brauner@kernel.org, dhowells@redhat.com, jack@suse.cz, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, oleg@redhat.com, pc@manguebit.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit aaec5a95d59615523db03dd53c2052f0a87beea7
Author: Oleg Nesterov <oleg@redhat.com>
Date:   Thu Jan 2 14:07:15 2025 +0000

    pipe_read: don't wake up the writer if the pipe is still full

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=175fa534580000
start commit:   46a51f4f5eda Merge tag 'for-v6.17-rc' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14dfa534580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10dfa534580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=3815dce0acab6c55984e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17692f62580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1361f47c580000

Reported-by: syzbot+3815dce0acab6c55984e@syzkaller.appspotmail.com
Fixes: aaec5a95d596 ("pipe_read: don't wake up the writer if the pipe is still full")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

