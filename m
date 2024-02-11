Return-Path: <linux-fsdevel+bounces-11066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA8685097C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Feb 2024 14:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADDA282E81
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Feb 2024 13:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C855B5D0;
	Sun, 11 Feb 2024 13:54:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C93E5B20C
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Feb 2024 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707659645; cv=none; b=pqJdCFS+Mb4PPaSbdfgOEQRAaZLGnWSVpMUybdJsND4kx9OcQoE6QJ9oWzzjsM3BeuqZ9qr7NIZ6PIDxaBVkO0UcrI40az8l28BdTpXfx839jyHPLwtvB5i5HSzNO/P5XFYxp/BVY4eI65B/AiuyFk+MtmadbVpaQ80oQCjaf1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707659645; c=relaxed/simple;
	bh=QfskRQ2tZ6z9kHMofE2PlUlWAZ+urn2hRUM0gskw7w0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=A0weBT+AW6dkmOUHve69syta5QDJLVAiTyN9KVrc58N7naDKH6uoJw5M37nbyAuasf6F+6aYuKS5o26xeVrTFIHw+vxz592mAhmSvp2o7tpPBeKDTXzliKdkYzQ/kvfiqpfVWftLnU1zA3rh41SwCemkSqCWly1aXw8sXd/8XX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-363abe44869so23677285ab.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Feb 2024 05:54:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707659643; x=1708264443;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ADU4lvVGHE+3HsoT81VTSwjst6sh3uN/uviuVPMtQJo=;
        b=OfI9h1Rmw+HeakiNfwu1WEo+VxQbqh4AiR9Mxb5r9Wx5tapU3iJ/1KiS7cG8M+QvJB
         1smTCYHqGZnH+rTzrUYQCjm/wyOpWLAZZGAgK1T/jXGVeCSCtU092ViwwfTncNj8EnV8
         nCGuqxLGbQmuasqeVNEzuONhpKQqF9Rm9cyJ8lKekkWF8VewGEOSZxTu/MlnJh/SqL4r
         swIoQFy12q2HpHrsFyXpTLW50MvtMuNnZTPdE9LMLDaVcUEl0psTNvcQ0VPBzoaNz869
         Suu415QpihSg/ctf5KlYMCUldlaQFQ+385O1aqA6xb5/F3/tl+tOlIDGlFe9mTrTLNKr
         YzKw==
X-Gm-Message-State: AOJu0Yx2x+yUrQspizC8MII9CuH50CWa2qFo95mh6+SG0P2wrgiFkRzd
	3lf+Fn/CWgzKOe7XzzQsk+02KDnRLKfTXwxfG7liFSrRnDbYiTC8HAk3X0zaQbXphZHLoG7IJ25
	/HSMJ/Q5zD4WZFhPn1DeDwvLCFWbnZ2SJvp34rnIT/rucWvncicASicg=
X-Google-Smtp-Source: AGHT+IEz0MKD6kefqXkAR8vdX7DHm+pBCnj4hCMq0YjZ2b81XNvAEYMDkgb9lwV3dq8/C/1XVyKqbkLkaD23oLLgYdyAf2Qpun4S
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d02:b0:363:d720:a9d0 with SMTP id
 i2-20020a056e021d0200b00363d720a9d0mr383219ila.3.1707659642864; Sun, 11 Feb
 2024 05:54:02 -0800 (PST)
Date: Sun, 11 Feb 2024 05:54:02 -0800
In-Reply-To: <0000000000001655710600710dd0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000690cfd06111b7ee6@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: out-of-bounds Read in ext4_ext_remove_space
From: syzbot <syzbot+6e5f2db05775244c73b7@syzkaller.appspotmail.com>
To: achender@linux.vnet.ibm.com, achender@us.ibm.com, adilger.kernel@dilger.ca, 
	alex@clusterfs.com, axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	kernel@collabora.com, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu, 
	usama.anjum@collabora.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1764f648180000
start commit:   e6fda526d9db Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e3d5175079af5a4
dashboard link: https://syzkaller.appspot.com/bug?extid=6e5f2db05775244c73b7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a56679a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d76b5da80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

