Return-Path: <linux-fsdevel+bounces-14247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F79879DAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 22:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759061F226C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 21:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6765145673;
	Tue, 12 Mar 2024 21:43:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5BA14534E
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 21:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710279787; cv=none; b=FKJDyZAsaovhYD3s306f6kp3JsH3PKdk8fq3CYcaPJs2uYgz60/r1pNBnPBjfc/KzZKaQhx3+GFg54u32rlS5/vBAC5fzZ7WrlBvtjEjBC7MuSI9b8kMF3Ck8cW+F4jx5Q+qLhIOABDowoxL7YYb+IO28GhQXtNWI723Ga8N4+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710279787; c=relaxed/simple;
	bh=+ntyJa0Ew8nKgl61n+Nh2FH6rWw/YsnJ8ujp1FK4Ip4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZJh2g7IVtQazgObcuzBBOPzSZDDfl+7Qwp1oXOlzTNY4W+Xi8yV4B8LoBGBgmzE0nN6oeTvVX3SifGpPJ2QzjmWsK6nIRqwVmRRRRgeJHazo1vV/YGIaXxF+NVoHPOwthzuXon3gcFzdwC0ZMfY/ys4c/4/dESFz0q+NupR0gsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3655fa1722bso2164105ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 14:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710279784; x=1710884584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WPwkHRiTWni56jLRMYYCYOfrKQED61Y88uUu4x05NAw=;
        b=N/OyngmTMnuT7tk/CrPaGM+TWaU6wKZMRSwjs1Z8ClJXi+3myqD0TaJq+8IChUZXqN
         y0Pc+CH8xhXuCxB1tyocZZVn9cHlxLu7uLpIVTfaoBBolka406WAhIvHZ6bHPCZ1yY50
         8+BpkM0s/5/6UgKaJ64LBGbthIwlirMfQXCjvz41ySmEpD5yLyL8IMieu25iE+uXXpH7
         k55mvFVfwTKI5nptqFv8Mj/36+iJhKGXQRf3yG23XdJ8VOSUxRsdlb+GnkiooOUvuesN
         bMnxb216jgqj7vKn3Er+caJdZHEjLEbveM2fHpzy5ZoNMPypTyRB8miXi8o1Xsm8rPxp
         7gLg==
X-Forwarded-Encrypted: i=1; AJvYcCWYTgwhhU0LB89bCh/j47DNN0ONSPffP22rVqwBqND9gEocFEDAY/2BGMe3irxL2PvgYdYQjt/0UbhL1ymNZ45O7Bo1FhjJ0Ppgd2ZDmQ==
X-Gm-Message-State: AOJu0Yw2oiNONJXGheF1ckp0D03nxY6gwDaUzmrrdHT1h+rypBfhbRgh
	eA9IaHtzDyVT3ZjwzfT1wsKCpQlJsUHnSOsuOGxOtBilBP11Hmily+B+p7DpYe1dhQ5/E6e1hSh
	dR8daeCS77aqNOC71aGIulY82/A1udx8iezXmPORt2zRWvEFkf3gKnmA=
X-Google-Smtp-Source: AGHT+IFOpyNj3FNGoLTzOFEnZ+tR7pSAuEVi60fFlN8TuPJlT3LzUp25kdsOJOotvBru3ani52Sg/5sSOVe3e3YqU/YqtNadiw2j
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2c:b0:365:fe0a:b366 with SMTP id
 e12-20020a056e020b2c00b00365fe0ab366mr42803ilu.1.1710279784538; Tue, 12 Mar
 2024 14:43:04 -0700 (PDT)
Date: Tue, 12 Mar 2024 14:43:04 -0700
In-Reply-To: <000000000000ac8cda0603cbb34c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000634c606137d8b99@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in insert_state (2)
From: syzbot <syzbot+d21c74a99c319e88007a@syzkaller.appspotmail.com>
To: anand.jain@oracle.com, brauner@kernel.org, clm@fb.com, dsterba@suse.com, 
	johannes.thumshirn@wdc.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit a1912f712188291f9d7d434fba155461f1ebef66
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Wed Nov 22 17:17:55 2023 +0000

    btrfs: remove code for inode_cache and recovery mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14342f8e180000
start commit:   f7757129e3de Merge tag 'v6.5-p3' of git://git.kernel.org/p..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b32f62c755c3a9c
dashboard link: https://syzkaller.appspot.com/bug?extid=d21c74a99c319e88007a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1202e640680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e949f3a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: remove code for inode_cache and recovery mount options

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

