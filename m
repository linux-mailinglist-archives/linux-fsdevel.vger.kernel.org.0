Return-Path: <linux-fsdevel+bounces-9962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F088467A7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 06:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72A5CB21C4E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 05:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2692517557;
	Fri,  2 Feb 2024 05:55:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ABD17544
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 05:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706853306; cv=none; b=iMYQ1cEj3Q/imCihp5gINUapzym8Rp+VycVe7fmZx3WmgjAmUraNfZ0jA+d/LoK2lyg0btB2HVnmKncYLYAYeWfFfLqzwrALXyu1lkpKg7vrh+/2ig6+jPEweFmylcWvVtpXbtQn2oIN7KOyjRHFBqSPDNtKz+dlfvtbZ8G/csw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706853306; c=relaxed/simple;
	bh=NOpVa/OUtOKujNTyeIEoISQonKHZhoDpyB3fGq9yx+0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mTQis3iWD+7EtNKC8TIMTRC0j6qus9qYgs5xWMbGrEyhGLvtKZU8pVygKeGyUDiobwScTPYIclvQFTH1yM8gEGZDSch5yBsfdwTJL7E8eeBd6bONkMYrr5Bo3xe4Js0vWVqutUeL4shiAlIv9TJVqOnH1HGdfcs1MlOjvU9cSN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363b2ca3fffso1985165ab.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 21:55:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706853304; x=1707458104;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MEc5E3mccOuN0U/Fg3US4nqEiWMGUs8/Cg9UTmyUt8=;
        b=USibYWHEVKPBVCngmuHtvfJlL6i/lmm+PKCWeOInhaDccuQ6soN35xrh8LVFymCt36
         900+eezqzdnUvDjsVvR5qQuMNxuNndr9EJQy3MweN+dLpEL7GeDmxjxx//WQmt3wV7Zm
         BddR38mYm9bkc/6CLG9d2/CSqrda3Dq+vTExPiKUWukNoMxifuLFqMmQpkGvuTywUL3j
         90n0+x00hYgeqTgRQE4ooXaa48UwBQy/5KY9YDaXAT2/EYaTb4h1yaekzNFoVdFGJGQx
         Yooeg14J+kUhAA0Yj+3HWFaNnL1qF47pj4c1ZbHGA0KEh28+kR2SOPtMWlRD3+VXS7Mm
         LehQ==
X-Gm-Message-State: AOJu0YzbBrY1Fvn3UdgRqCGBTKGYzBMMpjGc9qiFCKjavoTxsyU2NwkV
	C7o048s5eg5nRI3/am5UDVGQUccSs874ysL43k/jT8iewB2uaVdX4MvAh5P1E/jX6gDrSReLdrK
	nko+9UDawYfZJlMBBVmSxUxy/UpKtxQ9+Cy8dpNVqBCEvpjKyuRHqRhE=
X-Google-Smtp-Source: AGHT+IEf3r+zk5uKfc0FMTQL6XTpNA9fzR0z9tbBZRA45BY8gcc3opkKkE4tnF+bySDAQ4ej+GUb594OJNLFOmmfwEa0XgK0MlV4
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8f:b0:363:9d58:8052 with SMTP id
 h15-20020a056e021d8f00b003639d588052mr505081ila.2.1706853304570; Thu, 01 Feb
 2024 21:55:04 -0800 (PST)
Date: Thu, 01 Feb 2024 21:55:04 -0800
In-Reply-To: <000000000000f121b705df9f5a0a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e7440306105fc0e2@google.com>
Subject: Re: [syzbot] [gfs2?] WARNING in folio_account_dirtied
From: syzbot <syzbot+8d1d62bfb63d6a480be1@syzkaller.appspotmail.com>
To: agruenba@redhat.com, akpm@linux-foundation.org, arthurgrillo@riseup.net, 
	cluster-devel@redhat.com, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mairacanal@riseup.net, 
	mcanal@igalia.com, rpeterso@redhat.com, syzkaller-bugs@googlegroups.com, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

syzbot suspects this issue was fixed by commit:

commit a0e6a017ab56936c0405fe914a793b241ed25ee0
Author: Ma=C3=ADra Canal <mcanal@igalia.com>
Date:   Tue May 23 12:32:08 2023 +0000

    drm/vkms: Fix race-condition between the hrtimer and the atomic commit

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D11c756601800=
00
start commit:   1f5abbd77e2c Merge tag 'thermal-6.2-rc3' of git://git.kern.=
.
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D9babfdc3dd4772d=
0
dashboard link: https://syzkaller.appspot.com/bug?extid=3D8d1d62bfb63d6a480=
be1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D139473cc48000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D17581426480000

If the result looks correct, please mark the issue as fixed by replying wit=
h:

#syz fix: drm/vkms: Fix race-condition between the hrtimer and the atomic c=
ommit

For information about bisection process see: https://goo.gl/tpsmEJ#bisectio=
n

