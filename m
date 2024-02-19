Return-Path: <linux-fsdevel+bounces-11973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE5E859BAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 06:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93ABC281DDF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 05:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741DD1CFAB;
	Mon, 19 Feb 2024 05:26:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB103C26
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 05:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708320364; cv=none; b=U6SamNFW9nUO/VVvjTOdrbem4eQOaEh9FdkjxGk4nnmcPzmquQI0yJmz6+zB8mOmBCDMwH7o0U4ct9uWmqf+UKeqwe7+NeWmu2Yt6j95gWN+kovqFsysUaEXlZdhHdjmEpNDHLUFSUHbmB3eUVwQBkgBAOeHVUMT6zS9oO6LwhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708320364; c=relaxed/simple;
	bh=/UamSygtRoHGtpPGb62UgKOiavVW2OhoLRhrRpKJ3bY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VN9V1lecX6Y1DDyXlDL8/Z6Kd0NCXzS9K8ny0A8GsfNgm2QCQeaiEbcVJb1nhvFMHExOeLm8SLpMhlZnWtEHoJ2bgFXQWJFpBitC3I9hPVGQjNi/42FkUPXniK02gMnBNeQOLHteuFEbCLo1qtRdOFFJ6UrBF70+siuQVW92zo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c495a44754so332081839f.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Feb 2024 21:26:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708320362; x=1708925162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NOFoFESmvlklSQbncNSApOvu+sIjkHC5FQZ3He6zZio=;
        b=CBrYWM+p/treTE96o7dfoy8dACaSytohXArpS4JFXSn+jEJ/7EQOnbgA542t1D2c5T
         kXTMc7/gQSpOdkX29FFlzconEKhDImSebBX29TQS5vN5iTameaPs/iN5bBaGYJDzUcjv
         POsl+CNuqUamGDfl80VXSkdmEeUW3Mcak2CaGxXbLPE7xETiJ6xdW3mdBcM4lVzf9JSc
         VgaE/npHdAdaG0wk33tlUysQ+JrOKtte1XvY/10Aj/lkAxVDc27/Vx+VrGvNXkEhIlYY
         7Vn8jqvtapv3zuuRgQXYrR3e7BMSFdujF7XSKoqHDGW20ScUPxp/lX7XkTJEW9DUoque
         l6VA==
X-Forwarded-Encrypted: i=1; AJvYcCXyG31iI0ccRTSQ2FY2qpI8rz9OcFiCkheLfNLA86PIFjSi2Eo9zEmPIWEfZh33S38JxI5kL6/Phv6GsRCLNIk1ylriGUr9irqm+tAh/A==
X-Gm-Message-State: AOJu0YwnOfLuxucGbAV4xVo1vczXzTBlTmZT4PHwZGLey56VAA3SvIvz
	dsvHQu7ZfP3sa6gL0CMYwv7B62IQbPtCQR6agpX3XwnjlhlxAVufYU8PRcdGSCtd7cTVb8pFJSU
	M3J1Lv33PnSm1OuFWsk5mg6WpUShmzc2GoBggardhWDL3pGF0kcOgb0U=
X-Google-Smtp-Source: AGHT+IHSD6r+WANqHstIaCKHCJUTmPR9yzzjf/m9rmHwC3SEFCPekxM9WqAzHDkGdt/XQG/5sU2TdpvwzirUzbIFiKnXK8KWO+xb
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2b:b0:365:3328:6324 with SMTP id
 g11-20020a056e021a2b00b0036533286324mr99180ile.5.1708320361966; Sun, 18 Feb
 2024 21:26:01 -0800 (PST)
Date: Sun, 18 Feb 2024 21:26:01 -0800
In-Reply-To: <0000000000004f9dd605eabee6dc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000056790c0611b5548c@google.com>
Subject: Re: [syzbot] [jfs?] INFO: task hung in __get_metapage
From: syzbot <syzbot+84c274731411665e6c52@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, damien.lemoal@opensource.wdc.com, 
	jack@suse.cz, jfs-discussion@lists.sourceforge.net, jlayton@kernel.org, 
	kch@nvidia.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13310158180000
start commit:   1b929c02afd3 Linux 6.2-rc1
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=68e0be42c8ee4bb4
dashboard link: https://syzkaller.appspot.com/bug?extid=84c274731411665e6c52
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1702dc54480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b9eaf4480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

