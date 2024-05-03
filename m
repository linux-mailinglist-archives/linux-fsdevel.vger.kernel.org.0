Return-Path: <linux-fsdevel+bounces-18563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4E08BA5C7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 05:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664841F22CC0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 03:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9344D208D0;
	Fri,  3 May 2024 03:44:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33E718B1A
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 03:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714707861; cv=none; b=Lo6E65zDbVCXG4FfsCMmF9Or4Oko2QxZIl2alrb07P5MvGpChxKLEDPBu3YcEHd7sZeEw+ZwBoRQHHb5J70IJHSfLoPqpqx9GV5yGWH0nPFqwOj8MSkgeXkfh/htjbetsYcJNQZ9UAREJ8BBEhJh9FlFcfG0YVm5JLNnk6PjHNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714707861; c=relaxed/simple;
	bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fz7TT3H7DSvBTLyl1OYZpfcRZZ3hzzBpVlW4roVRoje1uk2lRtPZmYVbfMJJI+upsiGWM0gBV7R7nfw8RjGIPi3LWpFZEyX4D3bLXRPAoLk5BHbhGeUqw47BM0yPFArNZUw6m8V9NMqIaEF5n2NMIdMnZOq9WONzjcbR6bowQmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7dec9dbd40aso566839139f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2024 20:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714707859; x=1715312659;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=afeplKUubJFbezc76ZBM6+KE2wmVVQhXvQaNSxzmQo7wgW5xGCf+BYIGvEBokJL8bT
         ZcpJsgFT4bGCYtgiB5X0gN4Wu1Ab3V3ZEuaIPVulLqatGf38KBDeTGUHDUOfaS1dqhtR
         fM2LBHWslNR3zdyBAypZJrUTfJv1KqTqB0chXQFiCsDMCS4qHiYarmZnBBPAFKf8qV98
         iw8vDZoXyjzqTEeqJSiRn9KhnWNu7jA5eWpm8zyIYQklt6+NsTCmh0kuRT7HysuKRtC4
         BAMysPyHII27NeM/j2ZMuPYnrevh8SZxjOfwGQQ/D8yTd757I+TSNtsL6cWhYsOQdWHs
         5P/w==
X-Forwarded-Encrypted: i=1; AJvYcCWdkt3LGyY5knNvhZ57A4+GJ+5+6tyf/mUUMFJV+FVChvdVvert0Zk+Huf1TW29bxKxt1C0OqjdpEtVBNqfhJBFPczPooT2jaQo/Ev2bQ==
X-Gm-Message-State: AOJu0YyYZB+q8rNphZeGbjusigO6OHC4Z4vgbNy0zhxqiXWd2ywiu68M
	XRQKql5SgbtWxcRI8Jf42IiQl3m/xznOZDj6YorB67LHP/4cdtwY5+JHRGyA4bt0wDoa8tIg5Ny
	3cZ49Bn59GbFJsjya7ll4rtib/pp6fL8tR1pd92C1Sigo9vl9oA6cS3Q=
X-Google-Smtp-Source: AGHT+IF6jdtVimKJ3sPtIlW6psc1aZK/nSNQxAxNcKk6WGV4mZGOrwytWBePLmVCVM24GexqMQgZkn/SIF5cdqAA9s2wWfiSdIMn
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3f0f:b0:487:5b21:e66f with SMTP id
 ck15-20020a0566383f0f00b004875b21e66fmr65625jab.0.1714707859267; Thu, 02 May
 2024 20:44:19 -0700 (PDT)
Date: Thu, 02 May 2024 20:44:19 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d873390617848870@google.com>
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

