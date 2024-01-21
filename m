Return-Path: <linux-fsdevel+bounces-8361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2094F835450
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 04:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75F51F21FEF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 03:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566A63612E;
	Sun, 21 Jan 2024 03:17:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB9E33CD0
	for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jan 2024 03:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705807025; cv=none; b=bm+12thTqNL0kRHHZGM8wTxwrKwyaaX1yVaag5PgUU1Kl0I9W8yollmKIuW7UkCVLvxylCyFujfORghMqYGMQ7fYZihJEOVcfPdl/LRA4LT3lIN997ib7N2kkdal8nHFqKAxBEMH7LgaVWq6HpSPDxs3VTzFl0acipj4Ja5bqbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705807025; c=relaxed/simple;
	bh=Y3U3gmSoBpPBqejzWBvJi7czCL1r6vTqCtRFhtN/0lc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dU0yJ9EFfhARf+/dz2TBICtqH4Xo01UkM61XB2Dq6H5Gz9rPUua7zhApObbU2AdAR0qkKP0U/3giOTYCe5ThHiOTFpHHdr/Yxcrisht2bSyPo6ABpc5AxhLP+XdLyVFUIjb8AFSzad0XvZGahJDuewxtECnedNsyP5/pQD6pdy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-361a954c3e6so23667065ab.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Jan 2024 19:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705807023; x=1706411823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O5EGxrXRJliwproW9XKS8xWAASP6Q517tHhuqRHfHFo=;
        b=rIb6B+m3SqfxyILTcMgLgbED1fbqJPSUHisdWFKkc89WJ5zh3f1Dh0a/YShfKGGu9V
         f/RvjFmE/yxut7RuAsx2I3FrRYSM1jKeH3/GHUHWlgH8yQcWsVZxQ9e4MAVuFE8+cIVn
         F38la7DcaJa9FL7P+tRadwO73fvfTYuORW/ADQypGSFmwmapN3UtsW3xbpCHd9GWcWfH
         3mCpgwPPYsMBvYqw0xrVWforqy251StR38FdaunceSK+Gc8jSq71KtMA2H3irN5oyEUp
         vWoJxEUrHFpfY9LgAEW4IY9t2ZGxI8tbZDH1vulpexJU6KmPWFZUQ6ADGV7fj1D/XahP
         rQ8A==
X-Gm-Message-State: AOJu0YyeKKf5uREkfxTqqzkSz/fzMvMdbDVlEOLaC1PjtWNKI/Smc4cs
	W3dNHH70gUKLOb5YnDuzWpI8osZ2XHu2zyt/Mc12tUbRFETaVhmXWtcQrT4tlWy2zBWE//DEEb5
	VUFE9syGFZc8KEzUJlWPFsD+9oG8PpE6Ik/EHdEZTtDFcGF76kXduAjE=
X-Google-Smtp-Source: AGHT+IGRGmSbpZOAandnep2TjFNdtBtmS5GbpJlBkr8Y1TPC2FaHN1DScWFyE7Braf3ZajxeC1wTuTX0WO0vt0Bcv1KhDuzrh6nD
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d88:b0:360:d7:186b with SMTP id
 h8-20020a056e021d8800b0036000d7186bmr274095ila.0.1705807022976; Sat, 20 Jan
 2024 19:17:02 -0800 (PST)
Date: Sat, 20 Jan 2024 19:17:02 -0800
In-Reply-To: <0000000000001eae4605f16be009@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8f68a060f6c259f@google.com>
Subject: Re: [syzbot] [reiserfs?] kernel BUG in balance_leaf
From: syzbot <syzbot+6a0877ace12bfad107fc@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yijiangshan@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10cc8ee7e80000
start commit:   88603b6dc419 Linux 6.2-rc2
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9babfdc3dd4772d0
dashboard link: https://syzkaller.appspot.com/bug?extid=6a0877ace12bfad107fc
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12bdb82a480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108acc94480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

