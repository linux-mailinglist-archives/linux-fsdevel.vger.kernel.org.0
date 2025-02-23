Return-Path: <linux-fsdevel+bounces-42366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7F0A40FBB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 17:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE483B62AF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 16:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAFB136326;
	Sun, 23 Feb 2025 16:29:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22631757F3
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2025 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740328145; cv=none; b=NzvVciT8UZ8Tlb1faRyK7EPx472909RIXYBLjfefGcp6rmV6tmodf1putyB9ps1DoELThqkXkQKhdPpCrp2KGXh+EoAUOL8xvHpyuWLgkedfAZkaSErdhzCny7YCyY4YTvfz+Zt1YGWyWsPVgS4CYCloFsjUS2xTC30G2t6f6Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740328145; c=relaxed/simple;
	bh=BJJMIAODFBZ2zV28pMTXGqIeFv9HDdzI5mGygrT99MQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tEAupAacckzYr4y2VDX9JMk+vQI65J6wWv9CTRYi3La00ZY79JT3Cg9fMEouRGv8zzrE0I+ZgXUZfmnegi2y5Bu9aT7vmDhQcWrkIBWa5NUMcGaFFH/dBYoehqvTxzzsg43Lp8Cb7ifHoqYy0ziv5bYTwRzD/31GVPWtxuC0ZJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d2b70f5723so75502495ab.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2025 08:29:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740328142; x=1740932942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qePKE6DKwAycNvqydZPkWZJjbpYUhcvm8VYZZd2e7n8=;
        b=qZ28t+1SFto0brcHesOifZE8fJdLtU6AgFqqkcf79HZWe17qK4day5ro8e1AICspcc
         cHQShDXGXgwi1Qcg12ymS6NWlcUy9xhFNfEAaVCe4rL4vEZNkfKxLAbHCHIZfJNU2Yzr
         CVvazbCMh0IIJTBal0WwU5ahM2DxhIy1vXss5neFCp+PAcxUpM6/jwxWwYItwecyZwpo
         TJ85Ep0cuGBHKAMF7NqOf7zauj9YE8lwlor5cuq1KDO6+kMg7gNexh8+ekQq8vt7mUT1
         ITtv/JsVjfPHpCxB4RzixnwWGcTm2oaDw5CTlpPLi9Vdkjfvshbl7JbMORIJ+dOZHZ2Y
         LvKg==
X-Forwarded-Encrypted: i=1; AJvYcCWgoT/bMbAC4VXzuUFnCvX735RBi2v4cDxcZa/sQFhJq2mb+dNDmOezFDaa2U+GfmLlxSgdMrxGD5fnnQqw@vger.kernel.org
X-Gm-Message-State: AOJu0YzSAPkmmyVjnFmT//C00CLOWF0yptXs5uL7rW5yy9tdHG3WUH+s
	nmRxuQ/294DqJuXX9vf+hnUg4g6Ce6KUvwtlwoeUwHKF+KprJMkAGUpBn0FHHfjQ/ur0/Ke/f4J
	1z/zCsnrYb4/cTIxWd93HE1ABhH8PAQaDLZzj14IwvLIBvbJn73crRAY=
X-Google-Smtp-Source: AGHT+IF6ncIokCXD/xSm4YeShFCIAC7B7m+EQVnJ7HuY8dQfDkKW8DFwMJjcCjPOGWK9RChupBmxaF8xlmmMNx5tXa4n6XlTSQkl
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3092:b0:3d0:21aa:a756 with SMTP id
 e9e14a558f8ab-3d2cae4c215mr112255575ab.5.1740328142383; Sun, 23 Feb 2025
 08:29:02 -0800 (PST)
Date: Sun, 23 Feb 2025 08:29:02 -0800
In-Reply-To: <CAMj1kXE1WgFkP5RG-VhC_P-gMDtyipW7nvE+i+JBSWXW1bqbhg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bb4cce.050a0220.bbfd1.0032.GAE@google.com>
Subject: Re: [syzbot] [efi?] [fs?] BUG: unable to handle kernel paging request
 in efivarfs_pm_notify
From: syzbot <syzbot+00d13e505ef530a45100@syzkaller.appspotmail.com>
To: ardb@kernel.org, jk@ozlabs.org, linux-efi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+00d13e505ef530a45100@syzkaller.appspotmail.com
Tested-by: syzbot+00d13e505ef530a45100@syzkaller.appspotmail.com

Tested on:

commit:         ec7518a8 efivarfs: Defer PM notifier registration unti..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
console output: https://syzkaller.appspot.com/x/log.txt?x=15dfc7a4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a97cba3fb7e034
dashboard link: https://syzkaller.appspot.com/bug?extid=00d13e505ef530a45100
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

