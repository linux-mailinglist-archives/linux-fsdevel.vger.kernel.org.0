Return-Path: <linux-fsdevel+bounces-52713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D33AE5FC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B58901921C55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26852727ED;
	Tue, 24 Jun 2025 08:45:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01328271472
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750754737; cv=none; b=Im7+UDMFhiPxVsmV5Z6NOaFicNeqjBkxtEBZ63+weHMi6d5xEh5agzzl5hGpjahIxhYXjPjhzTAk6XZjdz6z5Af0vnqOI7+Pm9yRzONXeayzaENRil15nHekp4wUM0CtICknorqbPY+GHaHDwkyMQc/lm6A7ViP9NdlNbMEuJUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750754737; c=relaxed/simple;
	bh=LxScJQ6ro4GvdbdJIKpsHVPgmLgfonuIj3S9IWuHJB8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=MC0k+lvZfy8AFNM0f/tT9eZ0UjP8UoIQGJluOwqfzZGk7o5+b7ulthe4+2S8u07X4PmIatBu8KkuoLl+kBDRioLB9HnhhD01XvPV2EWgPAAz7P2ap20I9uciWJwQ3TszBOAOKvZMyEPkKhdfAxfb5cyd3t/ouDcr//tEKnExiks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-86cfea700daso385027439f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 01:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750754735; x=1751359535;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Is/Dj6D8uDldr6+hAOeVsyjOW0K7iYI2+3jaozOfMg=;
        b=L0QS7HklMugTGb9HwXuQPCYwjO1y3sObIw0hN+s2LttFR0AjI0KN0Mou1NPy3iZCj5
         9lUTPPl8Cl5OZGiGjcwoHeMarCSroczucRFqHshDh3okh1Zu1FSgjCgd0ZkbK0gjeDyp
         nJPmtKx8l6C6aSahx20QeXaxLH1vvHGkCc9fBbMPLWh9mJQzPbh/l9GRwiBFuXvx7VTe
         D0MmqDN5dsXGMo9RH8Sl0yGdtIgde/QXnAOFF3WH1kn91kLGu1ZsM7L5JV9WLm1pbs6I
         /U/T+rBSTn5euVeU/ctRNnAAC+r7brP+km1ctFdbgBjboG4RKdoNeVEvWehRjOnCYjFK
         JdoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6CrO/SZj6ylC3Ya201LuyFwvbXIa+Vzyboav2W4YYpojzwsXsRwPCCq7nKSboDFv2Wj+WZI2hUM4pAEhU@vger.kernel.org
X-Gm-Message-State: AOJu0YyIIU4oibKFf3HSHSVB6xP79YF/H1xLj5UO/AGY5pWVBIvItLpi
	UZ8VR2DK88EJVeOq9cSKgpDQPCKf67ZDAgJvgLTtYQAw6NK6sGeQAWt2mWm50gunHznfQuowjLU
	fC34DOrcNyN2MtnDrdOAOjkjiSLbnFqz/R5UdPCxu/Q1V3DAL04C3cXHj0d0=
X-Google-Smtp-Source: AGHT+IG5LfRE5qH6EyaBOHypODeoHO8Hq5efKEK5vsvSwUfKkRkPu87bZmxLuT8fuVhrg6QLEBN+NufZlQ/qqgCx3x7pM4dupdUN
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2482:b0:3dd:d6d5:62c0 with SMTP id
 e9e14a558f8ab-3de38ca32eemr200271985ab.12.1750754735044; Tue, 24 Jun 2025
 01:45:35 -0700 (PDT)
Date: Tue, 24 Jun 2025 01:45:35 -0700
In-Reply-To: <20250624-serienweise-bezeugen-0f2a5ecd5d76@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685a65af.050a0220.2303ee.0008.GAE@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in pidfs_free_pid
From: syzbot <syzbot+25317a459958aec47bfa@syzkaller.appspotmail.com>
To: brauner@kernel.org
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

> On Mon, Jun 23, 2025 at 11:27:26AM -0700, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    5d4809e25903 Add linux-next specific files for 20250620
>> git tree:       linux-next
>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=150ef30c580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=58afc4b78b52b7e3
>> dashboard link: https://syzkaller.appspot.com/bug?extid=25317a459958aec47bfa
>> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a5330c580000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c9f6bc580000
>> 
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/16492bf6b788/disk-5d4809e2.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/7be284ded1de/vmlinux-5d4809e2.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/467d717f0d9c/bzImage-5d4809e2.xz
>> 
>> The issue was bisected to:
>> 
>> commit fb0b3e2b2d7f213cb4fde623706f9ed6d748a373
>> Author: Christian Brauner <brauner@kernel.org>
>> Date:   Wed Jun 18 20:53:46 2025 +0000
>> 
>>     pidfs: support xattrs on pidfds
>> 
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a1b370580000
>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=17a1b370580000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=13a1b370580000
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+25317a459958aec47bfa@syzkaller.appspotmail.com
>> Fixes: fb0b3e2b2d7f ("pidfs: support xattrs on pidfds")
>
> #syz test: 
>
> #syz test: https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs-6.17.pidfs

Command #1:
want either no args or 2 args (repo, branch), got 4


