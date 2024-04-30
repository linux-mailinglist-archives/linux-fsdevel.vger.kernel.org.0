Return-Path: <linux-fsdevel+bounces-18368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9470C8B7AF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 17:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50FD7287451
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 15:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E93143734;
	Tue, 30 Apr 2024 15:04:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3FA129E9F
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489445; cv=none; b=fELCUMUPJk1MrigM+k2XyPNi7D+kTJ4KwXbLQchz+zKhshhqV1EJdyIGXnmpyJNqtVLFRKEC8EqnSJdO0m1ZiovjbXMCHf3eYCsaHh91p+MhRh0Wly5eFUD7we8ZNofP1C/CyxgmCSRkN3MxwgRsSq6Pwv22kKOeTTzLUFYBeYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489445; c=relaxed/simple;
	bh=g+eaDs/HNr91gYab7fvFMZUmUzQXEdyjAn6OH6gxOuM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=okzuJTD4+CnzbkDHz7e1/U6MvHCJ8nXPChmQQHu8D98z5cqE3uFpB50pG+hS5wlXa/kymS/C44H45+XXKQaWlLFZuQnhrsMlQ9UNdj2HEUB7z4dl+R2p5bvD/fjxQPfjyYWsKFNA7tteA4ZaIQZ1nMVdQpePfjMLVGhgbPKp3dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7ded69927d4so162263439f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 08:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714489443; x=1715094243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RXCBsJ9VpJqP069pIpVcCX4AQCkHuzifZjAsyl3v/7A=;
        b=pzTmdDRW6gjlzGSPRF0RPiVPPx+zwrdPfexhd5I71sstq7ZR0VuYL60M9tQmVfMP3z
         L9lcku+L1gYkMX6nThYNcOF2jrH8vx5dUlrWMg4rCpT1Yl/T5U+gRkLQm309c7KFRJrH
         +8qraqRo4jkDEBhzkDvp33yQItnmlxqeguRPuemSZEFGs5KZMrLFJVdG6wt5nbdTD9T+
         Xmm+8VNT8POR/Buamlt0OhxbooK2vVs61f9cLBnkRLOlE+rRvZghxJVMar7lyklnptOD
         yftapPcBrH36cvOGQXxQkOyTGYoceAIu7+7+b+SilA9qysNO8D8VjEPGmSygmuy1XI85
         P/sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTj3f8IWxAmrxH2gQ+kCEOBMCjon1qosAkFIWFG+tEwbKv5OE136fH3C7yCCls8PiPJZJW2bnUi+PGt1XhZpSuRxQHR3cWelTAj55p/Q==
X-Gm-Message-State: AOJu0Yyycd2Mg/CnGgm9ivnfU2gN9EZ1RQ2tSialcVzUrr+tECCaPfIW
	JNYgVJmWMkGgOoHx5DvnGI6IRfwRrVDXhk5zzPyUhDhZZt1yAX8mgFqd9T6I1+wBBpzb1/ECARi
	Xof7bL7IuDC8ETYjqf86s8mqB9dq/1rCqJvNVYG5jliwIR08S4dgItVE=
X-Google-Smtp-Source: AGHT+IGkd8oAm76xqllvXiuSWamFxZZiYiLXM1NPguwb9PwGX3UzuHCPrjUn7xv8FxEBtfkwICP8m65fHvN8Z8HUb/km2DGAfMWu
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:37a9:b0:487:ea0:dc07 with SMTP id
 w41-20020a05663837a900b004870ea0dc07mr1194901jal.0.1714489443214; Tue, 30 Apr
 2024 08:04:03 -0700 (PDT)
Date: Tue, 30 Apr 2024 08:04:03 -0700
In-Reply-To: <00000000000072c6ba06174b30b7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003bf5be061751ae70@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in mb_cache_destroy
From: syzbot <syzbot+dd43bd0f7474512edc47@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, jack@suse.cz, libaokun1@huawei.com, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, nathan@kernel.org, 
	ndesaulniers@google.com, ritesh.list@gmail.com, 
	syzkaller-bugs@googlegroups.com, trix@redhat.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 67d7d8ad99beccd9fe92d585b87f1760dc9018e3
Author: Baokun Li <libaokun1@huawei.com>
Date:   Thu Jun 16 02:13:56 2022 +0000

    ext4: fix use-after-free in ext4_xattr_set_entry

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1011bcf8980000
start commit:   b947cc5bf6d7 Merge tag 'erofs-for-6.9-rc7-fixes' of git://..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1211bcf8980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1411bcf8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=dd43bd0f7474512edc47
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d2957f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1620ca40980000

Reported-by: syzbot+dd43bd0f7474512edc47@syzkaller.appspotmail.com
Fixes: 67d7d8ad99be ("ext4: fix use-after-free in ext4_xattr_set_entry")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

