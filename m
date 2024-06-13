Return-Path: <linux-fsdevel+bounces-21601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3C8906498
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 09:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD682845E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 07:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBE913848F;
	Thu, 13 Jun 2024 07:10:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8223C137C48
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 07:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718262604; cv=none; b=UBL1uwUPF+7VLNkD3yH8UcYd3q8S5cfvWmyruCXI23NVMrJcU6Yczl1Uohppg4CGZw1hvAvzpglxXyCRHxtY/1Cw/TtlR0oqAXeLt1GN4/MmbPz5T6YRpiiqCbSdc+zHM3KpI+WO/cplkaEXADbRz+Hvy45Kni2f54dcktxPu7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718262604; c=relaxed/simple;
	bh=UavKaEB4DbE0mb7PFeaIw0rauXivG803iJsBEqpFwS4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S2/Ts9Ttx/pVaSMYkSg52loN5dFbVdSaU/OGSfXRNRXqeafCtwBUkkME82cDkMUVHu19jhKtewIN+0nGA0lZFCbR9iV5EmsdHGsvL0gmyDHQ70/zYYgqyEQrENkEbCZJXqep+anwKk2QgHgpej+56ZPmnWsMT5UtdM9nM74P40s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-375cad499bbso6704835ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 00:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718262602; x=1718867402;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQWgev5nUxYpPl/WHfuXFafrRGKjucseNOMQaKcQQfQ=;
        b=OhE1SSm5ZUZEspa4wqrjVcfNhRLk7aCXxgxJOFHTM8/xAlZ/Sc5W5XCLowGBHh9vZ4
         n9M5MqTRr/J7zyiFr/aJkspMnlU4HVZozAPatmheiJ/zGaDAMbA8cRrbpSv+xVGeDUQz
         RHJLAIHPDO+/KEy3MQDKtKUc4IqjlWNYtplIO6dT8MkszxjWCs+b1SczNvZ/CguedniP
         yhUokkTe5r4LMH6gEYswBCPr8ZapeNmTkLTioAo872/IpatxUBWTbti07OAoCwcyPh5E
         FNO573r7vk7zE5xUW80/brYPnm8I+pHjD14/BZL9IemKWaaoUt51hzfEK1FpGtnu9KQd
         0kfA==
X-Forwarded-Encrypted: i=1; AJvYcCVeJMc3m4dbdexkNglqQSsxmdt4i3j7WEb8F96Ko3Jn+Pa6XufgIMS7IXIWMEM9kX0QVanyCk3DWm7PSa7ykhh+U9oqpIieioFmzEd0Bg==
X-Gm-Message-State: AOJu0Yyii6KkJs1nwoPWshJeSgJxbQW4ltjJvWLBMviZjuRW1hva+e0z
	Uu03hUEjJHGZAZBND9vqaAbpnROafHr1feIbJ+CHsc5UD/BPZWPgu1dvBcuaeWxe2RmkYFJ5U0u
	kyqX2GQcBoS8oZzEOEKPwwLu4e51HUYjMEwOXnVraDbQWKIGeRDlYRgQ=
X-Google-Smtp-Source: AGHT+IE5eqyRghVCtd8saZy/KF08X8UvVYhYuLZxnWQEa/pPnl7NXvLxH2hJUNAjtITL5iPVlfzdsS0RNygG00T+Nind0RT2S61P
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a1:b0:375:9e20:bee3 with SMTP id
 e9e14a558f8ab-375ccfb5385mr3010275ab.0.1718262602470; Thu, 13 Jun 2024
 00:10:02 -0700 (PDT)
Date: Thu, 13 Jun 2024 00:10:02 -0700
In-Reply-To: <IA0PR11MB7185204ED80582B2C8D0D582F8C12@IA0PR11MB7185.namprd11.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d2576061ac030a2@google.com>
Subject: Re: [syzbot] [squashfs?] VFS: Close: file count is zero (use-after-free)
From: syzbot <syzbot+b2cfdac9ae5278d4b621@syzkaller.appspotmail.com>
To: airlied@redhat.com, akpm@linux-foundation.org, brauner@kernel.org, 
	jack@suse.cz, kraxel@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, phillip@squashfs.org.uk, 
	squashfs-devel@lists.sourceforge.net, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk, vivek.kasireddy@intel.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b2cfdac9ae5278d4b621@syzkaller.appspotmail.com

Tested on:

commit:         c7db1220 fixup! udmabuf: pin the pages using memfd_pin..
git tree:       https://gitlab.freedesktop.org/Vivek/drm-tip.git syzbot_fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=11b1bb36980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58a2adb83f90b327
dashboard link: https://syzkaller.appspot.com/bug?extid=b2cfdac9ae5278d4b621
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

