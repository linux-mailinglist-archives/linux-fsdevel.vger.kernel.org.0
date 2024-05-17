Return-Path: <linux-fsdevel+bounces-19635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 039238C8041
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 05:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0F51F22668
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 03:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17492C144;
	Fri, 17 May 2024 03:45:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1FDB672
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 03:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715917521; cv=none; b=qG3XoG1ESbmW328j+U4SNsHr5Iu7HD9YTXRj4xcCrF4DT7+Hs3grn7A0AF9MbGuWOG9fx167pyID0H+XiapeOjnpyE9B65voU2xz7f/n5mc9Uefm0meyvcjlsm+v7BUG6ThaZAmRayKT8ZLqhYwxUFVfNOqDTPdrIMb3w5WzYGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715917521; c=relaxed/simple;
	bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=E/u9NTOfZyUbhdhW///g3ZY3AnCCi5saohusF/Wnhbxm5/u1wmgDrW56GZSlnrlKq77ekVmzTRG5h73MsuRFwkNGL/Zy2M0WcQagmRnHPfOezQVOPGCMgVwvJl+V0HA/TsSvpcP0jIvo+3Q41EjcYoPeJ/7ZhouvBHp09jGh4YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e1de4c052aso627421439f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2024 20:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715917519; x=1716522319;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=brivEsMC38mU+5dJjW5PZY4AmloivDVvEO3wJdh281MQHHCajyPESAJ9YJC8s7JbMv
         T549Y1HyUtri+85Mmj8Dsw1Mfsaj+qaZQUZRNCn+9PjJ7KVWLn2Z5rsR5nUw/N13TgpO
         OehTocOexEXfJd7x4P1lprAsXr7Ii4Hkjza9U0WyFNBZZaqkT/rkr4lUpyOKemvb3K0B
         RNqsmQbBUnPuMeUFzXnbXfU7d3uGwJsFUAEKo7lTd7RCYSx/89gCJz8cQx9j4htl07wI
         nQfFsYg1Q+vQslyvZ7UjOCrjAnqzc6gsFdxj74B38eyNncUZiOKiblCPl9DSQxEL98OR
         d9rQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8mfeyytv5w28kInl3/TCrzOeQo3wBAQl5SIT0NfvDjm/Sj07LKqsGJVgYhPRfSaNpPNgbfLC0OpmeaMz0RAEODcHtRG4HUExeteOM0Q==
X-Gm-Message-State: AOJu0YzziqCYOmo6L9umOUzBK3wG/M0kna0nhLx8IeN1f7ntZ0AWoXan
	4ugT2hlz+ztvzW8F7wO9HiFOUFJO9bcsi6jm812kREKTObXpNI+KbLN70lR22h/T+pMzCFjI7UL
	MxOrAq+lGJ6U/Pqdl0GqxVLszf+ZwaR1LhxpMqNCvrcu6mxZ8eqvdtm4=
X-Google-Smtp-Source: AGHT+IHeRF5znd2RauvqwoQWzfQBK+/EpMeBkZLGuJ5vLdevUzahzVwExTNmN2kCcFtSeiUfNNLxE7EvP+y7R4QwsCuNtP2hxld8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2727:b0:488:b7c1:401b with SMTP id
 8926c6da1cb9f-48958e0d1e0mr1629654173.4.1715917519347; Thu, 16 May 2024
 20:45:19 -0700 (PDT)
Date: Thu, 16 May 2024 20:45:19 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000346e8f06189e2e1e@google.com>
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

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos

