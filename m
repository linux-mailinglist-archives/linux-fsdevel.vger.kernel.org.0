Return-Path: <linux-fsdevel+bounces-11064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7842C85087C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Feb 2024 10:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180E51F228B4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Feb 2024 09:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB16159B52;
	Sun, 11 Feb 2024 09:55:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3361C59178
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Feb 2024 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707645307; cv=none; b=oEu7Wq7b/LtEh04Y6FC7flEWyesmy8SZHDXLXOagXyPbzUd4wml/Or9h6vITrq8rcq/ZS8iR8d/kYUI4kZQ3dT7F3O6qVCnku4H/pd/flX2T21p6KxD+YqUNSXShbx6njBJMKee7QOGdptCkSyyzCLGn/ei1KQw6eZ7HcOTWGo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707645307; c=relaxed/simple;
	bh=FamyLudsSv714I4GPKAWQ7S6nKsf1K3Kuh25o0PUvSI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MZPjNBsvOa+3qibDoYqMhhZYIpTJEx7zJOlaUGAdwp32x8Fix78ZGgkxmTt4WenNzSMYtV8S1cOkAjv7k9EZ/TsmVd6mZrI+2QdEb7U8g5bBAUxGaPMF2S0q6Kmar06QEI7L+bhNkIBz3y34ZZGosjjpmxinDcZLj88Nt8OLA/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363e7f0c9daso15249635ab.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Feb 2024 01:55:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707645305; x=1708250105;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0XuWyRbY4wXt2Mt6STUVYn8j1a+Yq6fdJoZ0a9NfJrs=;
        b=acJNDvkotTkx83HEU8SZoSerdYMbrmJuXeA67Nx4ri8VuSaJO3FUp/pIVCEkUnOLdT
         jCbGAccrOWA4I5ihihsmYchHjev+t0XPQ7qoRI5zZRNKXPTmf+PeKAlk1Fu4RooKlMtg
         UFZglmyJgf6t6l1McsPQAnRCwxrT/sUtwi1eDvjoCvKUt/CqXAGA5EN1Rt6kFzDoclNc
         c86w4e7TlptBRNDR8rDev2sgvPpkA9EXiIR6xoxo4DYDQQ7derO6EqZ0k1T6n4MoPkuk
         rN/xpJjmiunQC1T6tQBKa6twqFlR+FDMsPSdiNm06twJcAtgkd11UFdDqE7sn1pWpmyJ
         a/kA==
X-Gm-Message-State: AOJu0YwIQJGgQC9Ak2l5FB6M84Sr6gDB2OEfSMam9OJpc+5xl6hRk59L
	ydJJGa95dTLZ9mwVwskJtUN7kOqfR3nj5C4947Fj5xixtDiqJchPM5k1jZyfw+8CSahnu2+XzmP
	ESbvHrcz5zkZ0Bu7A4w04tDG/fYnzgx1vmWF7QRiV2KfcfFV629Os6JU=
X-Google-Smtp-Source: AGHT+IG3YZniosI/CpDU94Ng7pPafv+1B9bQ4XnJzYI/F435oR3FLGTsEkP6RQryGxVbCbrAEGkfujP1a2FR0BA29P31HNaNZa0p
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ee:b0:363:8b04:6df7 with SMTP id
 q14-20020a056e0220ee00b003638b046df7mr338025ilv.0.1707645305395; Sun, 11 Feb
 2024 01:55:05 -0800 (PST)
Date: Sun, 11 Feb 2024 01:55:05 -0800
In-Reply-To: <000000000000a135c0060a2260b3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4a29506111827e7@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: null-ptr-deref Read in ida_free (4)
From: syzbot <syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, davem@davemloft.net, dvyukov@google.com, 
	edumazet@google.com, johan.hedberg@gmail.com, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org, 
	william.xuanziyang@huawei.com, willy@infradead.org, wzhmmmmm@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit af73483f4e8b6f5c68c9aa63257bdd929a9c194a
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Thu Dec 21 16:53:57 2023 +0000

    ida: Fix crash in ida_free when the bitmap is empty

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12fc6ba2180000
start commit:   b46ae77f6787 Merge tag 'xfs-6.7-fixes-3' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ae1a4ee971a7305
dashboard link: https://syzkaller.appspot.com/bug?extid=51baee846ddab52d5230
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127837cce80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12779dc8e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ida: Fix crash in ida_free when the bitmap is empty

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

