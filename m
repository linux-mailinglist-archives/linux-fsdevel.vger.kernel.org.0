Return-Path: <linux-fsdevel+bounces-43549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51858A585CC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 17:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA81E188DB24
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 16:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452B51DF99C;
	Sun,  9 Mar 2025 16:20:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F1D14A09E
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Mar 2025 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741537204; cv=none; b=rcYlDzpD1NyWVtLw4TVIktF5n1r0Aq4R3U+8mdmBf1L3D0W2Tzn2zcNFl1/nFDtfTXMbetc+NXvUIIrg+NkXW5AgdHW+n10jIUbSmHUaL1SUVIG5hSYBKBZ4GLB+FO4jpudrZegA3dMZpijn40ytBktMozhM6mx5uiC8rjd8bSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741537204; c=relaxed/simple;
	bh=UJv+3p818hAynouGODGqPemY4sdL2sg5sl1CQD4WCAY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=m7auB91+Z8lJD1k1KBtUYaVkX3QTAVFrLUu8oQCPVZ/UrZ1ay8t4LBlPJMcmUhrgTJ7q3wXQA+fr/2Uz7ETicI5CtyH+WbR4h2lZftXeUWE6d2+BEz3U0FsU7GATmeuj8VKT4UEQzt7K2sn+7vjP4cRgJvyIMqw9hkGJFZnGKeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ce8cdf1898so27800735ab.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Mar 2025 09:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741537201; x=1742142001;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kvHzXY7sxLiJE9tWVn3P+7dA0tfrkLHjWoYFez7ztlI=;
        b=eHK0SdE+iVtYAqMu6dcqHdMJExZBdewcZKXzvmQz1njvKsObrOC0tG8lgHHcVOskLo
         dlfxkcSKPZ3rF7msyUbPzMvpEkOcEPFANPibe1CPHHUGmc/GUviE09M384GOSbqJrcO5
         BRZ9HAfb7SsJ9N9o5OxKyEq3qF3pITvcYWENxxwu5KnqQN2X0yjVXzgdVjB7hZK4BMxb
         CU0oeBXftnpMNJSlxKf5+O8Zr8c+hi9cEoOJUi7MTdJQzlBq4VX2/PFRHd6eCJY051iG
         gE5ap70bo/yzx2nUYnS4rHFZ5YtP3Uli4qr6sCtdPUqJ8jQA/76bc9S9SCpCiK1bw37v
         PIyw==
X-Forwarded-Encrypted: i=1; AJvYcCXUsX65Zz3ISDRlsrSi1+5xEzelcBsw3oQsto2YwFygzjyW0FcEiGwF8kCoOxwytCT6rjMPnG6YcGsaIGtA@vger.kernel.org
X-Gm-Message-State: AOJu0YyszPrNt5cJtlcPd5IG1F1TgcxQfk+t9ZTmSAl5jxLiGxcUm3ig
	S0oC52E3TaLk4KPYmoTs+uqi1eW+b6aYhP1Lqq/pcJC8QZg2AA1ctbQl8D4y+6+MdIg612AimHS
	T+14P46T4dZ2AASbzBnLNnqS7JVBIez/fY3pDUGCWBXX6nq4w9Oz3TtE=
X-Google-Smtp-Source: AGHT+IGzBV6/Mmw1jYJbp4k4xeAwt6EP5l8CLTLHNIXSvmWfgnNG3Eq5hlJ73B1hltOvdNhKNoHGM4Vwa3Q3wdVte9AmRIZsV4VY
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:240b:b0:3d3:fbae:3978 with SMTP id
 e9e14a558f8ab-3d4418ed8e7mr107345105ab.9.1741537201441; Sun, 09 Mar 2025
 09:20:01 -0700 (PDT)
Date: Sun, 09 Mar 2025 09:20:01 -0700
In-Reply-To: <CAOQ4uxj49ndz2oJcQMhZcXTAJ+_atUULNLPzLAw-BLzEdFwV+A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cdbfb1.050a0220.3d01d1.0000.GAE@google.com>
Subject: Re: [syzbot] [xfs?] WARNING in fsnotify_file_area_perm
From: syzbot <syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, amir73il@gmail.com, axboe@kernel.dk, 
	brauner@kernel.org, cem@kernel.org, chandan.babu@oracle.com, 
	djwong@kernel.org, jack@suse.cz, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com
Tested-by: syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com

Tested on:

commit:         b63f532f fsnotify: avoid pre-content events when fault..
git tree:       https://github.com/amir73il/linux fsnotify-mmap
console output: https://syzkaller.appspot.com/x/log.txt?x=11fd1fa0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=afb3000d0159783f
dashboard link: https://syzkaller.appspot.com/bug?extid=7229071b47908b19d5b7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

