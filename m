Return-Path: <linux-fsdevel+bounces-8373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2F58357F4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 22:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB518281BC0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 21:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B8C38DE6;
	Sun, 21 Jan 2024 21:38:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E6D393
	for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jan 2024 21:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705873086; cv=none; b=UnBCWMmn8QmKrA2z2QLlLBrXwAeYJeQr1cU5fiW+LM8kpZIRtL9vgmYSox3+MNx7/fhz0m5s8MRTAn4oqB4OIKMw2R7rqior+AmWFKLEOFb7Tu0Uy1OwYjGPv0b1uoLp37CzrKB0VxNdL/2oMHh+1Rua173tmPUWeD3bUJ8XQjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705873086; c=relaxed/simple;
	bh=ADtN1ZtRhdvwA5SdPpt6av/OuYK6N5Bzl984h3cTbck=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=elgvSNyZFv6VvQhxfB57QxTtR20+0fTbhaSy3EnKx80BJdpEy/Hc5kDYo52nJtgvgROo+mYQdS9/G/jphSkP6LD9r1u3c2kaUUWMF0lkPqsLgHvNdXLISAWVEmxS8qGpVCFUoIDtH25Sbs5t12+B4u6FvPxBN29EI54vXEr/ljI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bee30dea21so248386039f.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jan 2024 13:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705873084; x=1706477884;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HfXiDPxljx4DtQYUMkH1jn3pRTh3NiwPfhc+Si6O028=;
        b=KhyDJjWfenV2oXLJAA6X5YtPd9byrlJ9g0AeSIYmzpyfBdecvABc5FPSrxUzakhWpT
         8jzkFkW7zRezlkCwEXtPV0iwzevZgtC2O44ntaBrgsXpVIc5ZPDF5dvqfCIlTtm/bpsS
         NpC5Hiaj4R1SjZzmwF12td+v3Ngf3Is7SEZFaRKrHUIjk8r9J/jNljYMA+aqzidmmB9h
         xdU0z2cS1Q2IoLFBzwN7z6+eFKHFVqFMY2t+AG8umuJerZ5cAo1WrOgROWW9HlbbZ+/l
         0x5z36hU4GACNIHcb2Xj8ygZAiARiBjW5qO0PcAGvZ7fo0O0h04IVJD7E9SYoZVOkI/r
         Q/LQ==
X-Gm-Message-State: AOJu0Yy15u5q+RutmaVNOLn7VdkNzAj2R9SF9UGJplOteeH7tiMEYdNE
	mHJGFJ9buD7MfRLswNfO8F1QTqdUvqkOkFlfVPbAC3I1l1hNJHrYOh8nIldBCnTDQQy12jjdP5B
	5PJYUKTpzKoLHb1Vj1xrXKL36ELRDdKVCchneadA56quB+twkF7UgX3w=
X-Google-Smtp-Source: AGHT+IFtw+I9gj7qbGr9UFRCY4KkCPGRElTHhUML0jEx0K8voDN5+lX4C6oO2F04Gf6gZ94y/s6i4OtORoTdBF4fRcEQyrmv4KZc
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194b:b0:361:9a35:48f5 with SMTP id
 x11-20020a056e02194b00b003619a3548f5mr235049ilu.0.1705873084079; Sun, 21 Jan
 2024 13:38:04 -0800 (PST)
Date: Sun, 21 Jan 2024 13:38:04 -0800
In-Reply-To: <0000000000005f0b2f05fdf309b3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003567b1060f7b8724@google.com>
Subject: Re: [syzbot] [reiserfs?] kernel BUG in flush_journal_list
From: syzbot <syzbot+7cc52cbcdeb02a4b0828@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, reiserfs-devel@vger.kernel.org, roberto.sassu@huawei.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1556b3dde80000
start commit:   4652b8e4f3ff Merge tag '6.7-rc-ksmbd-server-fixes' of git:..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d855e3560c4c99c4
dashboard link: https://syzkaller.appspot.com/bug?extid=7cc52cbcdeb02a4b0828
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103dee6f680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12883df7680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

