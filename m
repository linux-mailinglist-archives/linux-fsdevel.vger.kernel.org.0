Return-Path: <linux-fsdevel+bounces-14296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A3287A9C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 15:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A064B281B5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06BA9444;
	Wed, 13 Mar 2024 14:50:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4CD4A0C
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710341405; cv=none; b=oFHdmCUY6HPPkAkfgZuOjzNwKuJ748SZf+/xILGLCD/3NN8AZSJXKsHF+3rRdWG3X50n6rukEh+EDZ5/G43Vm9mjK6B9Qs8Xx9y6tL9LYB817n1cS1sKtnp8qHYNFZ2MJjpgZZWZZG/HaolcpAsqnlQWUr4a8l6FVEL1qc2Cy0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710341405; c=relaxed/simple;
	bh=H6AP99/+5wUD2f58Es09ZZ9Vhv5jul9GXOyCS3ukWcY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uaeURhdPtr7+URJhja2FPgN6tiV838tn9DYJtdjhpblKWOh9GHr8rwRgNZyZI68SSokbDif8pki/ttACdKia+Qv6IqpVYO64RCY667CaRQzRmIJY6LIXtgSELrHvvtYtToYdeEX12Mz1inv0ubS1XBosveJPpgzVX9/3ieWc4wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3663022a5bdso14659895ab.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 07:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710341403; x=1710946203;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pBqXF+FtEC98JPe7hVSSvBQgwR2DkFM1Y3dRr1bdJDs=;
        b=rdjM62Xf7ry4PyaRSvn7/hpYEHOXws6mR/ig9v+HfoWGrMNI2CAKGSHA1grbyA02cC
         flrpf+7DiOPbvWxVM8G90xHadCIzotrd+E95aZCzoSmQSBEkCC9HJfTwJEqt66iZO16T
         z9Uc7t9qmGfa0s682mqqmM47351dkMIM9aZCtxlJYDIltV/XrUPY9MA2hZGXKm8OV/Sb
         9P+x4clXb7pqxeJseuXnQivUJifo6wEzRGnq/kNRKJ+s+W87gDprEMpmTWslV6LolSCY
         DorhfPlC0jl1mF+VmBZHD6qo573HV2lkL5VXZlo7l66VEFwOH0WjulGzisEumPYYCXtV
         Gzxw==
X-Forwarded-Encrypted: i=1; AJvYcCXgpcKqDoKZryyGyQ7opnytDeBEWKi6MvUo8Mq7HO5MpDu7jzdr+Pl6Rqu7HAHXpI/UDhQ0Ijueib4DYknFWZZKkCc35hk7r+fF9y7O4g==
X-Gm-Message-State: AOJu0Yyf1C8AWpjKZDzXXVvRMFEMmXHX27s7fSiRMhs/+4vOJdHaUIdN
	H5qL8nUx8mH6fvLYFp3ogdj0TcQlshD/UqmkP8p/myQD86/PWmAUFkqDRqfZBrUEDPr/pKZb0RX
	h3WwZaMXCu5VbqzDEfhXV/SqeeDKrxoiYpCMUyMrLMwM2uknimgbjJRs=
X-Google-Smtp-Source: AGHT+IE/nKeb60I7S1447N7p6nt1amMYQgnAkwkywJB8/ZNa7GHWQrU7DmYHP7hBdfeVeAYsfJKzbhQ3eGlGodGUdOWmyLZKDxOl
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2a:b0:365:3e12:3eb1 with SMTP id
 m10-20020a056e021c2a00b003653e123eb1mr5642ilh.1.1710341403338; Wed, 13 Mar
 2024 07:50:03 -0700 (PDT)
Date: Wed, 13 Mar 2024 07:50:03 -0700
In-Reply-To: <21fc3ed1-de3d-4027-b775-ef061eaca53d@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca7cd306138be344@google.com>
Subject: Re: [syzbot] [f2fs?] KASAN: slab-use-after-free Read in f2fs_filemap_fault
From: syzbot <syzbot+763afad57075d3f862f2@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+763afad57075d3f862f2@syzkaller.appspotmail.com

Tested on:

commit:         51fc665a f2fs: fix to avoid use-after-free issue in f2..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git wip
console output: https://syzkaller.appspot.com/x/log.txt?x=113bf9fa180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1fcc0a6ff51770e5
dashboard link: https://syzkaller.appspot.com/bug?extid=763afad57075d3f862f2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

