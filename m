Return-Path: <linux-fsdevel+bounces-10595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C7084C93C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 12:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0071F277B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 11:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7169A1D531;
	Wed,  7 Feb 2024 11:09:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883E91B7F7
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 11:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304146; cv=none; b=XejyiT8ufrToECdOPoXYXeg5vhxKuceA3+sS2KfdUtMNXy0TV8hDPs34Tz9BWP2RjbPSiTd/PjxIyBAphTP7rXBAYbnReeHDLH2pvkjxyxk3DO5/NQZwNY5m/R7yybhc2zHQWs1UM9vLfwXmum3/ZGhEZFL/jkN+EW+QCuJq4Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304146; c=relaxed/simple;
	bh=5PhO/CSyRdS/kcBg1FslvShsADEHbW2yd9KE30COm2w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WTMzux5vpDL20mkB80jNjbILA5+cOgtrGtAfPGLno6M7r0sbAs39lIEBLo75nyHKv5al+9vlcIcKHgZVa6ZW2avIFUzFWzvo+K+oT2z7JoQBNKaIPJyrsqlr+9qTtrWHjXl2uiO3R8npS0NYiNE2GedfHjJKnFuRzlJGNQwATb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c000114536so30111439f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 03:09:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707304143; x=1707908943;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ON6px046rR8EBHR3nBWI29k5JFBBUrDnkEhtRqAg3/M=;
        b=tERstx4Db38DCISUMxjQnYHdVcqAT5vmaq6mgg/hO22/oqvsDSteekMpcBULNbdyek
         nKaNMbAqNmZ8NZvsXVUTZ3vlOdCiLWv++kH4Pn6LTVcQhJbkXOx2Lvns7ev0eTYknse0
         aiynoQf7zN7DJWkblFfER7bzZMw7iYXYufZ2axqiMHzswRk9ZtGyFW1WTiXmkBR7e+3n
         swExZyS7UaNbhBzTs+ycqrY0zhDiVpZeaOtPowXFy7HtCelIFQCUq200OCazna+yxhcL
         1j7yfmwydNDB/rTNWw2tI6eIv8TvKwAXRi3zTJ5vbsI3A+2prQYugJL5yXMaG44pyK+7
         LXvA==
X-Gm-Message-State: AOJu0YyvQHy/neZ19XMQoNmjv+uc+GFWg/4Pj3R0uxyaU/meneOD+hJ1
	aRUeNhCHMrhgD5ju2S2qesPEzltW2n8xRRre1mMDV1PEJeXLsJel9AKaTXiHdIxTzcB9pp6I45q
	itp4vX7T1QbUfQhg4vg3PoqNm5HG4xoOGtTzAPvkK85o27X3xg139VGI=
X-Google-Smtp-Source: AGHT+IFBWylZ9MvHDjQAjrBJ7NsXQEeWoUUUOY5tLH6qSAC3pqHHpyCcIow7X+8Z+EajQDVj05fZB0vZ65RiQl066en/Vn1eR9pE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:160a:b0:7bf:f9d1:ffc6 with SMTP id
 x10-20020a056602160a00b007bff9d1ffc6mr200027iow.4.1707304143713; Wed, 07 Feb
 2024 03:09:03 -0800 (PST)
Date: Wed, 07 Feb 2024 03:09:03 -0800
In-Reply-To: <000000000000a5f23f05ee4865cf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000027e150610c8b964@google.com>
Subject: Re: [syzbot] [reiserfs?] KASAN: use-after-free Read in set_de_name_and_namelen
From: syzbot <syzbot+3969ffae9388a369bab8@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14fffd6c180000
start commit:   c3eb11fbb826 Merge tag 'pci-v6.1-fixes-3' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=3969ffae9388a369bab8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1615d7e5880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f20981880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

