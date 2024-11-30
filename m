Return-Path: <linux-fsdevel+bounces-36185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0129DF13F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 15:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB6802812DA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 14:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED72619E971;
	Sat, 30 Nov 2024 14:44:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7ED19B3C5
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 Nov 2024 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732977845; cv=none; b=ECD2rHj58cLXL48FvhU2nue3o5zmuk3pi6H8QYZJZuJ2UR4V+EARJ1ZIsFXk0oaeFKppYCbNfrgwP3LY7Lee1oamwa4SgngLcz9dTSyul0m0veJq9F6JGl4uS5URp01K9I+7mGPBpr9qwGG89KZumLp0kTBCQF4QBZadR6VnfRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732977845; c=relaxed/simple;
	bh=/2me3GlS88an3RLsz+gmPqqJsjFVKRchDVf0XYxw0yA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aaO0A48CPT/ET77ihaBYNMJvgHTeqGj6OXzTHPUEiUDv8s9cIt41ded7blnQhDP5FaxbCmDhziBFFjCbZIjEGhuHPZUG934G6Gr/MBJE99OJ3qeYys7pBlvHYCsI8nyo7mZqq3ErK3e/nrh27bz7jJ9fmThgyhNttBcvN8Bx5gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a79088e7abso23566575ab.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Nov 2024 06:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732977843; x=1733582643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NLpCxVWUm+FLHYgY6UmUs8QAXQBwFoHMQc5QOpBkoP4=;
        b=HWkm9g1etqIw+2t1G6MxnGKKDAVddOFdTHKboeZycjg6w1nMKNSn0QRl8vy2RQEevC
         A9/B15M4YEsbLEiV/iJA57TwCZ0x13/62a94zS1aY8+2USo7zrAVwSKExTpyhO5ZGn7h
         n6rgK3farL9tGphFD6xwSo34shnLr4c7V+VtpFLaAz6Hrs8GMEcngM62IbMBgbKR9ZA/
         ndkFkZ+PyygGAqM/iS0joKcZF/Ngh54e4ZNj2oST5zGuIK0MaElDB++vTEbjA6RL0enP
         uUf7jK0tg5xEMCPeldz+5T+StXJy4l632eaC9jeheod44odpRNv7uM7zRkQt7qnnswoB
         BidA==
X-Forwarded-Encrypted: i=1; AJvYcCW9TLXYm084d6tHHlGCYCw/brm420PTPjp0+FjOsh8POmpGSC/IPb4V9w2bXjjTDpuh0+qeMbhY3iWKTrIy@vger.kernel.org
X-Gm-Message-State: AOJu0YyAGH4u6du6gMYMqutyYPA7/hdJtIn9+nj8OKavwC1EupWsCCUW
	dIr/kPECt6poFYRw7ft2ik1xUx69VoYh0pZcdxs3fuEwIz6ftKMf3vHfleTQnpxy1RHlU5yTjD/
	AtlLUeF9DKoXm+zyLG3FXn2oQRmi9abeU999fVQ5jH5CJ/YYbliTevSg=
X-Google-Smtp-Source: AGHT+IGKM3IQM8HG3HSI7urzSPpJKTU55OY0Q6Z5kYb4DXB4yN+jXJMypP7rSsTOQ4NnPvpsotgixPfEKNRfhZjHxhSEQLvvMk5g
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4405:10b0:3a7:c5ff:e698 with SMTP id
 e9e14a558f8ab-3a7c5ffe892mr96045695ab.0.1732977843441; Sat, 30 Nov 2024
 06:44:03 -0800 (PST)
Date: Sat, 30 Nov 2024 06:44:03 -0800
In-Reply-To: <67238110.050a0220.35b515.015e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674b24b3.050a0220.253251.00dd.GAE@google.com>
Subject: Re: [syzbot] [netfs?] kernel BUG in iov_iter_revert (2)
From: syzbot <syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com>
To: dhowells@redhat.com, dmantipov@yandex.ru, jlayton@kernel.org, 
	joannelkoong@gmail.com, josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, miklos@szeredi.hu, 
	mszeredi@redhat.com, netfs@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 3b97c3652d9128ab7f8c9b8adec6108611fdb153
Author: Joanne Koong <joannelkoong@gmail.com>
Date:   Thu Oct 24 17:18:08 2024 +0000

    fuse: convert direct io to use folios

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13e29f78580000
start commit:   f486c8aa16b8 Add linux-next specific files for 20241128
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10129f78580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17e29f78580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e348a4873516af92
dashboard link: https://syzkaller.appspot.com/bug?extid=404b4b745080b6210c6c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131f71e8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12bc200f980000

Reported-by: syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com
Fixes: 3b97c3652d91 ("fuse: convert direct io to use folios")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

