Return-Path: <linux-fsdevel+bounces-18822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C55C58BCAC2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 11:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6526B1F23112
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 09:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189D91428EF;
	Mon,  6 May 2024 09:36:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75723142636
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 May 2024 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988166; cv=none; b=fGdlnG5HNKA6a4QggwurQ/VIbZ06GmwfbF0r+HIe4xaxdmETNfT6IChgyC2TTlvA3kBbkliW1hOaeWegKsNJXkOLnb+bIKEpwovCa47rNFP3G8bj7sUy7FhADI1hNcnCufE6ZAftdOp1WQAwiLKfzVhWTjW7UjC2zZEqGRA+B+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988166; c=relaxed/simple;
	bh=AnhUQnMdGrRZOxXZdeozV6MOrXgYCXG31theF87blOg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=czfg8nCHTL/engccWJe/Y77DcjzvZEHWJue1c8ijBpPMcLPXSLd/2nM7zkhRHVoU9Ny6LFlJe+DZ5PZlOn1pck31ZG/LqZkF6Tmu1oW4++df2mhjL6H0HbpXjK15BR9hXgHQ6eTrFc8Ievx1fCIia0LURJqUpwDYKXK3QLfygBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d9913d3174so222550039f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 May 2024 02:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714988164; x=1715592964;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zv5x6Nmy7t07YX+YnaK0VGIx5sNBuwgtq9Vcfuj51bA=;
        b=aMLhmmeqaHgQE+KY2FtWJnbhbo28SQgUu7JteofQknaYoBzwp8vp2SaR1oeULcR8tX
         JwBdtxiDa3kQfISQll8Iq1fcMOKxZ4l5ZcYRw5S2zvW6SLaLALJB6hWCHFxjcjEqRLz2
         RQOr1/R6Y29K8mKhQWHwZBrJ33/LjlxwmZYfozJ6gCZzRQQxKBfNylhNOS20iE6zkcxe
         X1JrB71kPulaRlAFtC980MRPvOaNE3Llc3gXSDYI0obu52OVVvK7gmxPTzcYHWkAJKYE
         MYfnHnXr3JJ1jv+ctfl5nO0gWfxu/leQwavAQF/A+xmY5ukE7FK4Hb5HxJlY/dacT8SN
         GsFg==
X-Forwarded-Encrypted: i=1; AJvYcCW9cG+EvCh/Z+smQ1HohYahz61dgRMmXzRMBgFCTwmI44qspTBBAwBJRvJqLZaP0cCUGcd4CHgYmh/8ZKtGbsxSBOl/tjVM7JSLII2RDg==
X-Gm-Message-State: AOJu0Yy9wNMeBY2Y9ptb+n8acr4CBfTYTP81eNLOICtboKnc/YMksXd6
	c+xk5hPqXowFINi8vcCNNMj+nT5r6fcH3XAhNl2Q/VXU6JEsJRWJvez9FanZwqCL3+xCW7iQr0F
	uW2gsv2/WKHMs7inf1Ll6ryL42/xGCj4+CGkgdIx2xAauNtYh6vFm62w=
X-Google-Smtp-Source: AGHT+IHO4idvgpUvaa9A/19lxtxEAU+Qg+pRM/VhI3hOV9Bck/gnw+u3jLIrwc8UwbOl8L8uFiEpCXGD2usdmZFcNGsYW9LgrsS7
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6414:b0:7da:6916:b435 with SMTP id
 gn20-20020a056602641400b007da6916b435mr353342iob.0.1714988164735; Mon, 06 May
 2024 02:36:04 -0700 (PDT)
Date: Mon, 06 May 2024 02:36:04 -0700
In-Reply-To: <0000000000005c46090617b917e7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005a730f0617c5cc76@google.com>
Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in __bch2_bkey_invalid
From: syzbot <syzbot+ae4dc916da3ce51f284f@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d789e9a7d5e2799f4d5425b0b620210d2fcad529
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sun Apr 14 03:59:28 2024 +0000

    bcachefs: Interior known are required to have known key types

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1070e9df180000
start commit:   b9158815de52 Merge tag 'char-misc-6.9-rc7' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1270e9df180000
console output: https://syzkaller.appspot.com/x/log.txt?x=1470e9df180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=ae4dc916da3ce51f284f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a910c4980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15490b54980000

Reported-by: syzbot+ae4dc916da3ce51f284f@syzkaller.appspotmail.com
Fixes: d789e9a7d5e2 ("bcachefs: Interior known are required to have known key types")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

