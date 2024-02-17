Return-Path: <linux-fsdevel+bounces-11907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFC6858D93
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 07:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35671F21D8B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 06:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0836D1CD07;
	Sat, 17 Feb 2024 06:55:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531BF1CAA2
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Feb 2024 06:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708152906; cv=none; b=XxWuMtHt6SNICAnuk43gB92TU20AjWaelgJ3xRnQ19I2q9CQuwNywM+jSimDbDkn3xK0f8iPJIyiial/n3Q4gdDh5aJt6UDc4+HpRXiT17u9oSrzzw/UVEo0/ihiXHHQnrdS0NWqMrN2I2GfQ7U3b+icnOW1R2A5TnCw3n2Cv4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708152906; c=relaxed/simple;
	bh=XCKmRa8OvWWr/wpERXwIUEIe4VxxedApN8DupDmFWFg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QgVtX9g6MG3VZ8oqaFiU/T1QKH7NuIgOmSEc4npVkWCsX6R5CbW9HFScSopwGJ6N6bs1yOBZnEAQRhNVOWJmExQ6qTNRYry87b4IO5STbHdeM+siVgTBe6sjdJZiuSXzT94LoClvhYD2zECCT6217dmNqDV40fbrdxAFe/uT5GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-364ff869140so16505525ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 22:55:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708152904; x=1708757704;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eE/v1a6EPuJ4IWbbdsxCBh4oB8voPOR3Qt95C7NeL9M=;
        b=jRJKFT8T1e9GRWUYEwVKl/6HXvngfyxTLV59tjJILdSV4U0wULMiG4wIScIfyNSosV
         EhFMD29PBJUwrxn/6s+KZkxyhabxYjHWqTnX9Q7lvbM5WkyEzcOFQ+SLvtx2+RexUJ7U
         YeQ/6MOmqH5klN4K7RkI75plKN2mRNO0sqP7LMquzgAtvHfn6v77P61WNGKKF5xLRCnn
         8h2exw06Bc1PvV81mbZdR5HaVn+VzFjZZcRj/ZxVtEDYAVdSRLM0DkXMkwE4AnzHXre1
         MeaZEFgNC/fvLGX/WBcMh1tZbu5HQ6vKDEam/p/KES4K71YZcXNQHXg0w9Tj+DrVFm71
         7lWg==
X-Forwarded-Encrypted: i=1; AJvYcCU3eN+vJCEpda37waz6VSr7NvVdQWd8bWi5ZzJ24SN/Wf/2g5f7TNLNwiS1hHMT+Hv8qe+a0tSiNDxw/jbU7eC/P993dQ6cBVcaE44isQ==
X-Gm-Message-State: AOJu0YxjcbBWW4fXtKQPVdGkCsrN5HDjHHAXxE7aw7SntcL4KytUsv9R
	YevUblhBDofJJVRlMValWJVGdjDw+XBjV7J6UATSERcD5wXh0jmJFKHFWNyn+0ZGHVpK7w9C4xH
	T40QFvyUwNz2tHTrxUcludiMHRhHU+W/Rtp9JzETUYa9EBwhVYHBOtU8=
X-Google-Smtp-Source: AGHT+IEsTWnd3Zmtdyp3LBGnhw/QBCcmSqa++u4WlR6/Mep/n6UHU5tUgL+YBVoPEHfe9m2ZELZURir5PEUKbFB0otAf5ThLEN7F
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16ca:b0:365:1f2b:7be8 with SMTP id
 10-20020a056e0216ca00b003651f2b7be8mr2901ilx.5.1708152904555; Fri, 16 Feb
 2024 22:55:04 -0800 (PST)
Date: Fri, 16 Feb 2024 22:55:04 -0800
In-Reply-To: <0000000000000d7d6e05fb6bd2d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001924f506118e5748@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Read in ext4_search_dir
From: syzbot <syzbot+34a0f26f0f61c4888ea4@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, axboe@kernel.dk, brauner@kernel.org, 
	jack@suse.cz, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu, 
	yebin10@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d6758a180000
start commit:   7475e51b8796 Merge tag 'net-6.7-rc2' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d05dd66e2eb2c872
dashboard link: https://syzkaller.appspot.com/bug?extid=34a0f26f0f61c4888ea4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10221a14e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112fd18f680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

