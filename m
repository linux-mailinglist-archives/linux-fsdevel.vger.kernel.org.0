Return-Path: <linux-fsdevel+bounces-11068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7F8850C6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 01:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF7A1F21E82
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 00:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D81417558;
	Mon, 12 Feb 2024 00:00:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBF95396
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 00:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707696006; cv=none; b=s5htZvQ7s1amLv6+O3fDkYCcWZFrsrbhuUGlCU/IAc9YoveLrwn33aWjmys79v9kEpNveHE49n2K3wgwPnf7feb2raJgggNeOBjD4vruEPmMskyKZ5q5lFHDL1JR+0npMfUVekCCgRJhYQQa5EmJWamljOdZoE9mfGNiCCg3zG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707696006; c=relaxed/simple;
	bh=JQH3bGP0Sfaxj2eCFe5H9MccjiugtupxIysd0pL4ZXw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IDJxFQc+xZ3ntblmy6XxUl1fEHCDtDm0L5yfVSG1B3JPISvEClmYC5fqRV9WPdy/o+1lHiY3izGBC4BqpwS3Gco/utUNL0xpyAAXd0HAbwpRPUpmXbDzks/zzr4f6CzoIrV2PPXoHU11MZNgtIwQUTmmc+5VsJUm0XdKni++Gf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-363d169c770so33640235ab.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Feb 2024 16:00:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707696004; x=1708300804;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QEtJpQMQObyxFAndxkl3jMzodLW4BfLQf1d+4n4EzAA=;
        b=mWiJMRy0DujWFMytEpA1xB9clO4BTMNKhwH++JjBZvL+Y9xfER9KhCQZxbHisoKHOM
         tJwgjqBgu2nEfbWDU4p6QC2pP6B9BT4z3a2Kf4a2B6MZz11M6hGgbttbjeHAZDtTzlOV
         nGqIKkNP8GnYjSN2Ee/mu7cXasWJgxfnI3sL+ndE8ycTeh6lZdzhm2AU0Xu3XYcM5BZS
         rjvi7mrcL2Fgb7nbcDBwDLM8uQJQjW+13hWelX9lmTvi6ydS00SYOunwCjWzy0p4n/rz
         jPZBNv2hhi1cPSUJc2uvzNh63cmAGyxMSy2NiMhuB5YiN5zGSKF94U2A73Yo4dmHQu91
         fpyg==
X-Forwarded-Encrypted: i=1; AJvYcCXrykfZtOi2WMb6cV7VXxLmN+5ynTE46dL3wCILkOmQ+oSQmnntT6OSWRSHC5/oUh3rpr4y0DDi3al+g4ikArdE8g4R/RQSINrRHLTXBA==
X-Gm-Message-State: AOJu0YxcxWdsIQaxL+gcGGJLV6+e5ApOruQc050kicWcIgPoOhwdeZfL
	X75bHGGDetHSSHtQKtyj9UEuXXBJBtsjUV3LJAInIpDuNp47VQOUusURdHx53K+ZfQIjRqNArsM
	t6fpgPLCIC3xGkgVa85BIxzFZCwuNlSaq5p4ScfVI98Fn2arV/+wJFEw=
X-Google-Smtp-Source: AGHT+IEKIuOMw8JbKg2Kv6fI5S3YSY+xiVn8YLrrANJRKL7SuSEdLpBJbWMZECkqP3yzIeQ6TZFBLMUg7q2TJNYj4CqXCoNyoERc
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d84:b0:363:e232:23c6 with SMTP id
 h4-20020a056e021d8400b00363e23223c6mr486052ila.5.1707696004388; Sun, 11 Feb
 2024 16:00:04 -0800 (PST)
Date: Sun, 11 Feb 2024 16:00:04 -0800
In-Reply-To: <000000000000e17185060c8caaad@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9df7e061123f594@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in lock_two_nondirectories
From: syzbot <syzbot+2c4a3b922a860084cc7f@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, axboe@kernel.dk, brauner@kernel.org, 
	eadavis@qq.com, jack@suse.cz, libaokun1@huawei.com, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu, 
	viro@zeniv.linux.org.uk, willy@infradead.org, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15477434180000
start commit:   a39b6ac3781d Linux 6.7-rc5
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e043d554f0a5f852
dashboard link: https://syzkaller.appspot.com/bug?extid=2c4a3b922a860084cc7f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1687292ee80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d8adbce80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

