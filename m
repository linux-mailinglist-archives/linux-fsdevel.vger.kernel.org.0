Return-Path: <linux-fsdevel+bounces-25392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E76894B631
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 07:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02A31F2477E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 05:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F06F13E41D;
	Thu,  8 Aug 2024 05:20:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AFA13CFA3
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 05:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723094406; cv=none; b=ri0+9aVLTjoOSOAWFYZPlTeU2xk5rh+45nRfWb71cE0JrWf0Yac/0x9HGAR5lt9KB1u6OjmcRhQhj1o+x1cNHYKiPfduCPo87os63iw+tqEane8XJxx+dJLbcaxfpX8m148Ee6x+A9TEmRW2h2uHGACyOm4OtVe/HUXHJu1WlRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723094406; c=relaxed/simple;
	bh=5fs52SLgd/Wa9Qk6AnGY2MINv0qRxrKfG2vAjMob6wo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rH7nfgFpidzt4HScX/Qgz4V2N8xpKBPv6jYkNUoGoQ1irSfQ/rB1uWHkj0U2wBa2j5z3N+M02j8DWHGvspin9UGSicpHAB+5SYe3OXXSWfW4yjH0AwXhxiApW38+e/zYlBTmFj4fNjSodUuijjecQobENvGY/1tDlISH7hs4PTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8223aed779aso68806539f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Aug 2024 22:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723094404; x=1723699204;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n/8Sl/8wtZuOpXGHi6WNR/MUTmmUjWmBACkoHV+PUDs=;
        b=B/ARTTsy0mS0fxY9QWoV9HpF4caESivcS01yUlz9J9HwvT+IP0cipGbvf6Ckp6z5lu
         4/1/8pgTfzN4li0ZrJ7LG6xTTBehSyf0IIkUj2VkAngWLFsY/ykUf/p+D7Efgcks7S9z
         xkoeyX/Sfheug/40/OyXOtqIupvrq3CE6YTj3M7vyfbyscsHTNYTPPc4CH+P5hGVRCgv
         F9UIxBAB+rhBxdpvsBby11fdCzs6rr/z09lB/OdbNJPBCa114O4ankhD4zDbhsQ4RwyF
         Z34ARxDBzyIB1h/GRBu6apOt/j3oX8EEhhGl2/7Y9VA3MNuE/pLLIMwC894DlDDrvZUX
         J5Eg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ1Syl1fUArX2UB/ABWXpkCrWICL0nnrRQLrG3XSFikI4yJiVtZTqWee3vNE139J0DJTqGZEotY2G9TH3C8cUGJJXOuVuX19llgxEYrQ==
X-Gm-Message-State: AOJu0YyxC4LidcfkSt2p3QcMk7yzkqCpdIm35au7orerTvFEVEjCFcPu
	VHlsTCOhJ5ygFyy1nvW5wByiXul5nj+9QpSSgmVqbMt3yTYFyfQlq2yZ4vznx+esihLFV6fZkBu
	3BH7mFWvAmNxiwlksXt1MzykmDaAVQP5iJIjQnnJRH7XBRDoBy7VvBn4=
X-Google-Smtp-Source: AGHT+IF7GD4v7lHspJC+Jfs24j4tamRlFwZl1OSJoLkUDwS5Ibf9MNjk30+Z0IWeFZHASh3iI8qbJOSsalcz40AT5pDGZk+0wk7E
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:130b:b0:4c2:7a26:278b with SMTP id
 8926c6da1cb9f-4ca5e153b10mr47876173.5.1723094403922; Wed, 07 Aug 2024
 22:20:03 -0700 (PDT)
Date: Wed, 07 Aug 2024 22:20:03 -0700
In-Reply-To: <000000000000f52642060d4e3750@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dc521a061f252d4c@google.com>
Subject: Re: [syzbot] [fs?] BUG: unable to handle kernel NULL pointer
 dereference in do_pagemap_scan
From: syzbot <syzbot+f9238a0a31f9b5603fef@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, seanjc@google.com, 
	syzkaller-bugs@googlegroups.com, usama.anjum@collabora.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 4cccb6221cae6d020270606b9e52b1678fc8b71a
Author: Muhammad Usama Anjum <usama.anjum@collabora.com>
Date:   Tue Jan 9 11:24:42 2024 +0000

    fs/proc/task_mmu: move mmu notification mechanism inside mm lock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=141753f9980000
start commit:   fbafc3e621c3 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=298e57794135adf0
dashboard link: https://syzkaller.appspot.com/bug?extid=f9238a0a31f9b5603fef
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1108a595e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16777bbee80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/proc/task_mmu: move mmu notification mechanism inside mm lock

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

