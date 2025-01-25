Return-Path: <linux-fsdevel+bounces-40121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6838A1C554
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 22:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86251886FEA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 21:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EAA2046BE;
	Sat, 25 Jan 2025 21:55:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A121A1F8ADB
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jan 2025 21:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737842107; cv=none; b=l8uyQTc7a9wTAgnI0FtLcT7mpwLRkl0ztN53GVF+dOEXQf3wxdEj8ZlkqTCk9Y1sxohBlrUuSt5PwNikORlmAE+xcQ2ppCO+CMaykn8RFyqiHf7VS/CR5i3Ror1BHJISHriujPCwtswDPqj2880fg24F4k+PMvruRy2yyXpWW5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737842107; c=relaxed/simple;
	bh=bwBR3fuEC8PVVlMsFNDyLkNaucUTs4Tx7p3x6jpTMQw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DLC7HJIthQ64Nl1mj6IQD0tSjVDO06xbwiBX+ifrsU+y/3H7sNrlz+3E9eLUln+/7iyefuR6A/ZJa8M5DcKZZFpvGcoh3O0vFTRzAfBoxNlN7m10RKG7GbPqoOAxIfjxT7gGiNa2KHKgENU/REe3w76xS+9kqbzI+Mls1dPYSn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a9d57cff85so60615885ab.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jan 2025 13:55:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737842104; x=1738446904;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qn79vjOFfVyJxrbn1jWju0s2olA9BA4zL54Tk/jcQb0=;
        b=wrMju3yXu7lpFG1T1bJDkZd0rYo4M8fdLOjtDZ4MT32g8zyY9404OrzkQXHnUyk0ym
         6jWCDIlI7jKs1jw6qbGKs4BALkKZjFVNoF5BlyolwqPRbZDla4H8XZQzh8SdSbnGM3q0
         ceENPIIM1FPwYSz0c9rNEQzsYjomeFZvwUCAb38H3d5Hxn4wHgVGTZSjG7hrfZYfAegv
         /5ISSpJmBmvAJVwSLhJpxpawte+B4ZJJ6UlGevcDzInIN3G2Nau7HtoEdAysQHIX4ZJQ
         8YH9NUz+crN+vZ5nf50wQ7c/YqKtDNWNSotCF1rZ8kQ8wewZjsjhHwHfxY7/b1Xr/Cft
         V7WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHxx1SjPlyhfwajUPSW90skLw6tirdvrArzrJtNwVfkmFckJ45yupIlwMqJTVccywGAijTdrBv8+15F1Ty@vger.kernel.org
X-Gm-Message-State: AOJu0Yzneb96eNRC3MHGpVNJLbbNEaSyjPdWJcP9ScmlxZM9GXmaxdQr
	+ximZpnXeolCI+PMuNYib7su/bVtsTGeaVSkr5F8ehuz/GJ6isl27/G5DUijDBaq8Lqn2AR022N
	GRQogO+uXUrNi4z0nrMQZ7NI5MPoodBjHW9TVJGSm101Ag0wXPP+UGSg=
X-Google-Smtp-Source: AGHT+IG/Jd2TuYUpHNx5S/9NiwZ7wInG5ad3EamCLESmf34q/YppWBgBcrbMVmkzTbaERgPVbPfOPEyTqYKKKndiBfIZofCbnYuQ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1749:b0:3a7:5cda:2769 with SMTP id
 e9e14a558f8ab-3cf744201a4mr339522535ab.12.1737842104791; Sat, 25 Jan 2025
 13:55:04 -0800 (PST)
Date: Sat, 25 Jan 2025 13:55:04 -0800
In-Reply-To: <674f4e43.050a0220.17bd51.004e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67955db8.050a0220.3ab881.0015.GAE@google.com>
Subject: Re: [syzbot] [exfat?] general protection fault in exfat_get_dentry_cached
From: syzbot <syzbot+8f8fe64a30c50b289a18@syzkaller.appspotmail.com>
To: Yuezhang.Mo@sony.com, daniel.palmer@sony.com, dmantipov@yandex.ru, 
	linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
	wataru.aoyama@sony.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 70465acbb0ce1bb69447acf32f136c8153cda0de
Author: Yuezhang Mo <Yuezhang.Mo@sony.com>
Date:   Mon Dec 2 01:53:17 2024 +0000

    exfat: fix exfat_find_empty_entry() not returning error on failure

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=149b5e18580000
start commit:   f92f4749861b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=df9504e360281ee5
dashboard link: https://syzkaller.appspot.com/bug?extid=8f8fe64a30c50b289a18
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bfbb30580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124e7544580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: exfat: fix exfat_find_empty_entry() not returning error on failure

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

