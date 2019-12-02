Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55DC110F116
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 20:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbfLBTyC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 14:54:02 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:42221 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbfLBTyB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 14:54:01 -0500
Received: by mail-il1-f198.google.com with SMTP id n79so665714ilh.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2019 11:54:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=sYedtpyaMKG5whWJkf6dyBRhk3jwnlp5j6dMs2CqDFU=;
        b=PpwH+NCQBwXcGG2NoeOYl1pCfldRv5zcFm2OXcXfGSCpaSCHv5uokxc2kt5A2B8lYq
         qMiERZ6ZyxE1SQkhOpQlhpANuQMC9wYP0y6J+bw+JcAHwqQbbipNct7lpmXTSF5mSTXg
         Z7hQfRQR9amjnshCkXmPbW7NiIypCPwNOnyK7t/zFwXg+LVrHKDTGRkmiFS4BeHqDOxg
         O5nO+OULcKghRm1ic7sDEl2SHDhD2vPvcR0chF7RficjXtSHuWmcAO9jUL8BekuthwAs
         I3FC3NZc7hI3V77BCOUP9xPppLPWoPyAIKiYJ8FVbvnF6la1HnSAHXwqqUpj2u7KAK0D
         XXUg==
X-Gm-Message-State: APjAAAX5VNDnwX1OhGwAMg4oi3LlMIclmiwCt2i9PkpFKFzn+k4LJ5Q9
        9AeHpRx8jCd1bxNncS0EwPHqF0mcZrwjNMT/C5lI7BC32pIn
X-Google-Smtp-Source: APXvYqwCsGxdE1Q39uMe3w+N7P34H3tGUIGjHKavf2twfv9j9z6nDvvs/vMFI7BQnMa0/lyn5/xB48hDQosPeU+CdJaN0K7ha/dE
MIME-Version: 1.0
X-Received: by 2002:a02:b47:: with SMTP id 68mr1505294jad.49.1575316440400;
 Mon, 02 Dec 2019 11:54:00 -0800 (PST)
Date:   Mon, 02 Dec 2019 11:54:00 -0800
In-Reply-To: <000000000000a6324b0598b2eb59@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d6c9870598bdf090@google.com>
Subject: Re: KASAN: slab-out-of-bounds Write in pipe_write
From:   syzbot <syzbot+838eb0878ffd51f27c41@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this bug to:

commit a194dfe6e6f6f7205eea850a420f2bc6a1541209
Author: David Howells <dhowells@redhat.com>
Date:   Fri Sep 20 15:32:19 2019 +0000

     pipe: Rearrange sequence in pipe_write() to preallocate slot

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16085abce00000
start commit:   b94ae8ad Merge tag 'seccomp-v5.5-rc1' of git://git.kernel...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15085abce00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11085abce00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff560c3de405258c
dashboard link: https://syzkaller.appspot.com/bug?extid=838eb0878ffd51f27c41
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=146a9f86e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1791d82ae00000

Reported-by: syzbot+838eb0878ffd51f27c41@syzkaller.appspotmail.com
Fixes: a194dfe6e6f6 ("pipe: Rearrange sequence in pipe_write() to  
preallocate slot")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
