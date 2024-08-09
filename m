Return-Path: <linux-fsdevel+bounces-25501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC53C94C8F3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 05:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D22E1F21F28
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 03:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D6D1A28C;
	Fri,  9 Aug 2024 03:50:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E2612B93
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 03:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723175419; cv=none; b=u3CcPLPLsExXdoOhQybGpVnBVcnRzTCzcXY24wU6Q1jjFclPmAXceMbKsFHh3ms8aIL8Rsw+8AvoeBfht3ZHSV+Pn5UWFRiBswp+P3JY7GZNjeQlVz6shgeTi+WH41uV4tadil7BMOHsKqDpo1jpBuHJEnJty2YsP2dpHcV5xdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723175419; c=relaxed/simple;
	bh=4rfaUAidddvblASjtkMKjWyJL/CQTzUgNAb30NvOGhU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Z5rZDQbDl29Yt+MrTyVyCFg8VJ/HmGv0Pqs4fRovpnj667RIODDFpWoFfjNZPBqna10urn6ESomyPhl1wgQFVzMToawMAfOAq/OrlMc+WWRf8PjtBC/R5Njbq4b2mgtDChRrWwNSBUTkoGLo4QmXli5isflhhmxWM9M9/bDVjik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39827d07ca7so22594125ab.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 20:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723175417; x=1723780217;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rfaUAidddvblASjtkMKjWyJL/CQTzUgNAb30NvOGhU=;
        b=lv1gVx/p3Yy/Atl9q8rOhTRSZPBRoCPmfhPp0kwlLw7RZ0y31y0skv+rN9XbdaEdt8
         Q/kwZEwn1x4IYmZSLwccfWF7ofLE5KiYnDGLhZxQunip6EPrn0aUfFXSdjsphmN/MNGH
         KV4ZYnaSQuTY1Jw4TOaqiJ8cbnS7zMXj1hZIgAsid18miembK04TscJkbOdms2wpm5pL
         GYgp6J48zqi+4d+o6x0INrhb+ZtIhYNl0AjeuMPpf05UyQKZ6hkBhkGOOhDQgGLbTPno
         NWu3phkRIHo7mEtQVs5EJfIlXJVvwwbcAzMUXpBbHWopljBzljrkrZh4rMmf0towYJ9a
         8fEw==
X-Forwarded-Encrypted: i=1; AJvYcCVrR6XOeEVFdZP4I1OwSE7+OUSEphB1Pw1jxMj4161BSVspxdAkjOH91UmzZAyhA6NeMH343ByvWDMjM633@vger.kernel.org
X-Gm-Message-State: AOJu0YxqpjKDZz0a3YTo3sa3t/IJpOvqmy0am0m/rzwCcxZh7HYgj4ub
	CkXBLagq83mbq1hDO0B55bgVc0TU0X1gPvM8HZiH0AJPN9oCjEwMCvYMb1zjU/xou1dU7Zd8whn
	TD+Q37DKu0+Y/7dG8HBC0vFB9mYThMeDUnZ3n7Jb7wnObHVdF1eooo0g=
X-Google-Smtp-Source: AGHT+IEhfZW6ZwPLwMEdatuWL8mACVJv/vGSrmoYB+9RCPKIz1Pld9ffsCQYIrDsLJeKZpfgMIlDUdXIn+peTo1c2iEuyDmsTbmb
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a26:b0:39a:ea86:12f2 with SMTP id
 e9e14a558f8ab-39b8c785092mr363745ab.6.1723175417242; Thu, 08 Aug 2024
 20:50:17 -0700 (PDT)
Date: Thu, 08 Aug 2024 20:50:17 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a17b01061f380ade@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_write_inline_data
From: syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, eadavis@qq.com, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nogikh@google.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=f4582777a19ec422b517

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 10 trees can be found at
https://syzkaller.appspot.com/upstream/repos

