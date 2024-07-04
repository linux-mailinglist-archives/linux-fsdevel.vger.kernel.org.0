Return-Path: <linux-fsdevel+bounces-23127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AED9277AA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 16:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5DB1F26EC4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 14:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8311191F70;
	Thu,  4 Jul 2024 14:03:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0419F1ABC25
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jul 2024 14:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101784; cv=none; b=gWSEUX3+hyVnmCyO5UcYS8A5rezHCI1K3Grei3noFPzahZzXix7RhsdCt+pnETRVETnRUqnH/gkASn11ZEWJ98ysl0GAlNqQga8lzC+2JdcSh8WVnzA933fJRUI6MzhaTweMo6BoAWMnbmMONnXJPcYxORWBYp+FUug/SEhgPpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101784; c=relaxed/simple;
	bh=FeFJ18n1kp/+wia7uWCMd7mc09yH7XDJWWm75ZOB3j0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H04aEqF+efuEzAOk6F3h70tItRspke6vUSWHSq1lnTl+a+IhvOP2IicfQ+2TmsDHK7IlwKV7460wFvwWUTR0RWq6BT1UsVWRp4MHCzPyIwk1m/Ff8xtvVC2DpkZq7g+74gdAiBuZXxiAfGa+sb1DmnPlYFBgDqRmm5TlpD5RMgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f12ee1959cso91403439f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jul 2024 07:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720101782; x=1720706582;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2MFu0Vvjl11woYTcFBgJSbf4fZOqby39eiMdbGhwcbY=;
        b=NthMXpTwyc1cZ+cqHqYYep/4h86bRFODW78wmTQ7YoG3oPUhQSggcbVciehOUBjsvF
         j5FTWnvOseCZ+rLYooKHQDjkrJZotF8LgsYCUrgSXOfAyFfQPzu/CPEJ5nPzvQbIIW5e
         nrXw5JEESRLT+GdgtpkQw7HFstK8BtN2uoxu6/ulr4kFzodQpoin3/VEnExI/hK+Byzg
         olM4gUnILRRhD7UODw9UqMtZG1k9c4XFjy3qwPY3MEojpyh5cIw0YOLxJKhMrY404y86
         K/wOoqZE7pVIv1Lm27xwWXSgy94u78jD6I5kaKrPWv4/kOG6kl122WM+/v9BfD/m4sh0
         cZ7g==
X-Forwarded-Encrypted: i=1; AJvYcCXDwHjeDYapuEkI4UgDaPNNpy2prqW5RvJmUxYNQ/wzsr1Z8lr7ClezLd/NH/zGCCN7PevEZMtttDLX7GpSqhp2huU/2PWN2JTGbdC/4A==
X-Gm-Message-State: AOJu0YzdpG4+exaelE5rjSw1zwP92YwO2+kCYV5fAB7pLMB/rN0CvybK
	bPRYuE6whip77tlZwC3/peXHbDaAEiX3AiWPBYy2sdb0V1RqOhcs77fyvVZNYkuPxOTqbhmKt1S
	QUpcJr8rX2MLhnZVLb/oXz342Tz/UX2FnR8GenCyPGczCK7vav82B8to=
X-Google-Smtp-Source: AGHT+IG3z1yiP+WDt+Se4A168xPC8xr6NJzaqkmWzpP6rB2eaIoHhuGAgnV98AGH0YOdSfC3IF+/dJPQrpHi76LWi6BD+3sH3sci
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9825:b0:4b9:685d:7f2a with SMTP id
 8926c6da1cb9f-4bf5fe43c39mr82395173.4.1720101782219; Thu, 04 Jul 2024
 07:03:02 -0700 (PDT)
Date: Thu, 04 Jul 2024 07:03:02 -0700
In-Reply-To: <00000000000093a8ec0615b682a9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4fe57061c6c6774@google.com>
Subject: Re: [syzbot] [jffs2?] KASAN: slab-out-of-bounds Read in jffs2_sum_add_kvec
From: syzbot <syzbot+d7c218ea1def103f6bcd@syzkaller.appspotmail.com>
To: brauner@kernel.org, chengzhihao1@huawei.com, dev@elkcl.ru, 
	dwmw2@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, richard@nod.at, 
	syzkaller-bugs@googlegroups.com, walmeida@microsoft.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit c6854e5a267c28300ff045480b5a7ee7f6f1d913
Author: Ilya Denisyev <dev@elkcl.ru>
Date:   Fri Apr 12 15:53:54 2024 +0000

    jffs2: prevent xattr node from overflowing the eraseblock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12204ae1980000
start commit:   fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=aef2a55903e5791c
dashboard link: https://syzkaller.appspot.com/bug?extid=d7c218ea1def103f6bcd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1309ca57180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f9afeb180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: jffs2: prevent xattr node from overflowing the eraseblock

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

