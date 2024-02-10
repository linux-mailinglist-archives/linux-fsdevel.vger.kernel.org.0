Return-Path: <linux-fsdevel+bounces-11035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAF7850237
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 03:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535AF1C23A63
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 02:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5FF539C;
	Sat, 10 Feb 2024 02:39:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A245228
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Feb 2024 02:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707532745; cv=none; b=CApVBg0ZF9VdvgCJKacZtBr4RgHYfnghwdsALPW+YtpZvjJW9yNCbml5sE8vLPChqerHO0AMzYhoPLY1KAlGFjALKZglt3h5EUJ7IM7Lx0dCl1SOl26lI8IZhz91U4Cb77+XoL6jdGj8YOVF2Ei02WhKFVocMCHon3aCLkQE77A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707532745; c=relaxed/simple;
	bh=D+fB0DQYR4+Y7FRjY7YzjMHNrRi8NOpqPaTpD5wwxsk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LApXVgYaKgppEmdZIU7AGhV/oOaazqJqWK7Q2beqJY72eGprJ47+CDUjWYUVJYSGb0ZzzTdpJZrxqR5BRfu0cbrUBd8Chx2eFmyD3qJncPFHZrsGsRxb9AjU3wJnfmwbuFkvhFtV/pMcSQVJf66dhiSsrL2KpbH4sNAXHIU+RJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-360c3346ecbso11789855ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 18:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707532743; x=1708137543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OWM21qHV5orMzk1Nz67T3FN5h2j8+31W1VLKBA0wUOU=;
        b=GznVVsTCz/ahsrDsagUhfL3cwf6IguZV2kKYEQsJHos2C6uGnY6/D2Ev6EewoUbaED
         /Nc005EaBTlDonGZVTJ9DVqviioSeaci/Hve2hTYJFZuiPWy6WSLlqYn9eYilEdPbT+K
         qILazy8Mof89tlYNO36ALAQZ14j/eXeVpKehDQLxyFaRlos8R7vc1CEguokNmCrXgOjy
         tDSwD7LnEog43IrHr5Uleix5rMmjn+gZyOlRGLjqqaGUY8KB5YTvq7YO08Ru9s5PRD5r
         85Lod3o4IjYfJtgzemO47I8tHWbC5Fx7G8/J7ik5QJzLhJ7KAERLfeBQT9iJjZVVXpMu
         9Jyw==
X-Gm-Message-State: AOJu0YykIE2KRtXp+TgUV75PoZfyRWwYRQNtpAfFG5V/j6NZ4+/pwJ64
	L1yzc773298iNrXQEzbGo9Jd9jhpWo3EJxdGPfLMmoebWgPoiIAQm83RTCzm4xMWRvWOdaIfQhm
	0ptIhCUyBzPFV3gp1wNC/3uFG8C84AQ5O4j/+mqoVGAD1uMbku9Q5lgY=
X-Google-Smtp-Source: AGHT+IEXNqjkF5J14OtuOm01hnu2WZuAmeaDPUiI1iw7xGbxruT0g9LnpKGbRkyb8TbF1nJqgjH5tZ3phJa+S+kiRLjwpM1PBYES
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b8c:b0:363:d88a:4640 with SMTP id
 h12-20020a056e021b8c00b00363d88a4640mr68972ili.5.1707532743138; Fri, 09 Feb
 2024 18:39:03 -0800 (PST)
Date: Fri, 09 Feb 2024 18:39:03 -0800
In-Reply-To: <000000000000cc796105ec1e4c7b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098e3db0610fdf2a5@google.com>
Subject: Re: [syzbot] [reiserfs?] KASAN: vmalloc-out-of-bounds Read in cleanup_bitmap_list
From: syzbot <syzbot+174ea873dedcd7fb6de3@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, bvanassche@acm.org, 
	damien.lemoal@opensource.wdc.com, jack@suse.cz, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, neilb@suse.de, 
	reiserfs-devel@vger.kernel.org, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1257a6ec180000
start commit:   f5837722ffec Merge tag 'mm-hotfixes-stable-2023-12-27-15-0..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8e72bae38c079e4
dashboard link: https://syzkaller.appspot.com/bug?extid=174ea873dedcd7fb6de3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14db6ca1e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12159e5ee80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

