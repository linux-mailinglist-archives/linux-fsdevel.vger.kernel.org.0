Return-Path: <linux-fsdevel+bounces-23602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AE792F47B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 05:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D141C22423
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 03:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FA217548;
	Fri, 12 Jul 2024 03:49:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F411C101DE
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jul 2024 03:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720756155; cv=none; b=j3gY+vqcm4Hl7JiaKFQXi3AeMxBothtQBLWd4ZObmWDoELENjkkLrYUocrw9az9ytqflSsBagkA79aikaxQleRFGgn9+d22YDDeWczFfPiUfVb8gIHYig4imXVvj6Twd73+NsNlOa6lu+kBydwntHHlxKSM958Zf/uTpkl1kbLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720756155; c=relaxed/simple;
	bh=4rfaUAidddvblASjtkMKjWyJL/CQTzUgNAb30NvOGhU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Jdq7eKNJP/fg4tDWMusNEulkSrGgX+n6aUQvSSEnGDjYRbFmVFXj9AxUukCAKcZtBQIX8ed3lOP/1YSzDQBV0DYkweMzo6w8f4hphVUB38ed1w0VVH/07vWkfTGAdOWy5lEply28JMrvlGT3SEL2mP0DNwjUJ1ZVrkciBzFjzD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-383643cac9cso15574085ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jul 2024 20:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720756153; x=1721360953;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rfaUAidddvblASjtkMKjWyJL/CQTzUgNAb30NvOGhU=;
        b=k/D6TnLLAjH2Kw0QqUiNToUY9LOGpsdGN7FeB010c007WzuIqZ3LUjRQJdo2pmzKj9
         8QN5gB91fOiy598bwo2/FfZcO/B0rs6nIu1wMjUTa1Oy4JMQg4K1UOO6XR9VmC7H0MNs
         JPJpT4X8sXhAJNZmfhnOBcdYb4IhYBE16DwtG+qH3I9UsDKy8nXwvT4xUSNYsdRaboHw
         Rwmul3L9zPUYFvhQU/DZj1KZQcTAtnFhiuWDI8NqF00Lf0MNdIgS0vQnAb3ssYy8Smjk
         U3vx1yvcCSDVa5T7QE75XcV6I7kYG3i2dz5RqpPTzdxnz98ik6qkvblWwAB2WU+5mSZv
         P1Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXiTj1twWJYpT7EGHzFuPn6KUMNb9TXyoKqrrjj9fTKFMLDXHz06oWOnPlsRSdzwSSPx6QAYxs5s7xY9/4/89K/61p/OWvoo6QDG+Hbaw==
X-Gm-Message-State: AOJu0Yw7Ufrq53qpDLr2P8qTKCNsyjVCbAH5Xje0zNqvL73yP1F3AeGn
	ivSM6+APrgRVpq6wZQFxPtXl84j3ksIX6uvCYoQECgFNWW3anF8JOpcDkFURVzldE1DmanpJS+u
	hKvlVhpc0i70gPKI9Hxd6oEmyeiig8nsm/IUNrXbv286Ezs1ch5sm8yU=
X-Google-Smtp-Source: AGHT+IGO1C3eimY+4kIjVYqb90gWSiSxmLVY7QCe5wkotAoBk1JzawhvczBY+BJ5rlCzBB8bpnwnqt4PrdEYmYSUKM6HECZBL4ud
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d581:0:b0:376:44f6:a998 with SMTP id
 e9e14a558f8ab-38a5b9aec76mr2280375ab.5.1720756153127; Thu, 11 Jul 2024
 20:49:13 -0700 (PDT)
Date: Thu, 11 Jul 2024 20:49:13 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040a981061d04c3bb@google.com>
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

