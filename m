Return-Path: <linux-fsdevel+bounces-16153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4AA8993F2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 05:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70CE91C24D8B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 03:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A369B1BDDB;
	Fri,  5 Apr 2024 03:43:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC85D256D
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Apr 2024 03:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712288598; cv=none; b=Ey8hn0HOf3aE7ZhZdRFSGdJLQhx8wFm9ie9ML9r6IWd9hLCmDSscUNeo1IwHzTqSCJF53+CE/hXQN202zl4ud+to5IL5ENCRVLGKcGKvsx8mDYi4h20g2GT4OL5fACu2IqU8rgHOZGuHwWqpyA6LKXjw0HCZCLCyfi4doCfsOTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712288598; c=relaxed/simple;
	bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H4kokDHRB9NNKL4e/ojz/h1q0t8ItU9zb28BWUkItdkPbcAgD3rQKXUt57+mdFCfm2FpGDZH6W43q1oCOqTg6dfCWsNsJD5k0O2TpPgjOYa35B8x26N9lKZmyCUwSUtsVqyUbaDFVug+T3bwW9FBXk3cCwPZ3LcegZofOwIREJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c88a694b46so159896739f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Apr 2024 20:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712288596; x=1712893396;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=n0ucrxa1ce5UklJLOHTZ4KwXgf7ecYEDguIA3zKpQklgTcuCix3ASF5wddbWC53ZXr
         YYiBCymJ+Frz313jc9v7nUJHcwV7+nFI3wVr19yqFPOxG/Jo2jdSfkuwf1SLxOkuJfdp
         kWsm7Gt39a+jGG+51qGF7kQIobfWrUp3bWfFfx/YJTYYhZAuo2AF3onaq4K00yCS/6h3
         WIQ1MZH16se+HVq0vLZCWGfPG4aOCfcx6TQYGHYpIS53TYtCY8g8D/MnQ9DwDQw1tC0u
         JKICruNv+2Q6tnTFziHHhJUefR9JogF6MhDNqqJP3M0lf5z9e4GO/do01W18bCdX9ARS
         L46Q==
X-Forwarded-Encrypted: i=1; AJvYcCWR0u/MjQMOaSyvIJqhhSYOhpRO6/Ov2fo3GamwSVexnT6xCKPdPbjvPFMP3fWvL60TbzPamLr8tlK5jiwzyXwYPUKokmDVEBny9+4bmw==
X-Gm-Message-State: AOJu0YwIYAvDmKdWIttT5RWKLGOmHCkTopkfQGR+3j+rOfegAk700UkM
	z6zYGNJHydJDBRSo6u9IaNBAETtiYeMkJtTepP9i1i8RiajjSX1xESUBGoRQwjo0lyXogdAbe0k
	I0js+LVL8V1IGH1/+skZlW2hvMInSOg1cBbHYTL/5gBKSpyqal7CiZDk=
X-Google-Smtp-Source: AGHT+IHFjzv8CNoc6/4+S+f/8xeraOyYdzTyewDxgRGtLwR+czgNzeoy4SNazCpVhYvJOMTKJpxR6ioDqjc478Je8Q7mka4bDHJ7
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3892:b0:36a:a46:69e1 with SMTP id
 cn18-20020a056e02389200b0036a0a4669e1mr8852ilb.6.1712288596096; Thu, 04 Apr
 2024 20:43:16 -0700 (PDT)
Date: Thu, 04 Apr 2024 20:43:16 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086534706155141d5@google.com>
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

