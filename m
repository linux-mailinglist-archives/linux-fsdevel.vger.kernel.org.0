Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57F4B11CC53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 12:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbfLLLfC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 06:35:02 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:35231 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbfLLLfB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 06:35:01 -0500
Received: by mail-il1-f197.google.com with SMTP id t15so1398993ilh.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 03:35:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zFl6E7DmT67W68XqVzR2aCsqjcFpWexNUq+6/CXmVUk=;
        b=gQw0XUiSlu6zbaONVulDs/qlJD71EvsLCqhZkmgRLPnKaHJYh0b14x/MD5FDhdbXYV
         UEbssSD4WWW2DwtEdwT4M1kecyxUNDTrVdHnyYsdwjNBvC8sqnwYebiDSnXa24zzG+2U
         s6iH42hejTFXLsLEhEbvjDgFrwBqlSeR6FMtThWT2UkvWUF74W9cwPH3IPe+h4KSAdOA
         60afP+jvE+5k5zNpbwos5TDcRSL4bYGmg88f5u5hbfjC3oJpdyC/IMH0/91JDEKg7R5e
         H/XdYXvdfxuwF1X3evHfqo3M1FVQ0Tg4iyZQWi2lVikQhYa7uOX2PtYP9cP4httjqEGY
         HuGQ==
X-Gm-Message-State: APjAAAV3u9pDkWuZcrZ0gR7mK2sBUvIbAyM3FbLTSvUp453oyV7nAyeA
        rCMSOm0wCD43DRCK6epB63Z/HiYpOWq6Gb5JfxrQ6mkvDK9U
X-Google-Smtp-Source: APXvYqx7tAF42179GqyQGzxmn7mnoZxL7LgtxR3PNlsI/lOpd2FmYULEa+vakNib69tHnoQvSF7+iHISpB+uiby7hAsvBYRTiqDc
MIME-Version: 1.0
X-Received: by 2002:a92:3b19:: with SMTP id i25mr7844146ila.85.1576150500982;
 Thu, 12 Dec 2019 03:35:00 -0800 (PST)
Date:   Thu, 12 Dec 2019 03:35:00 -0800
In-Reply-To: <000000000000b6b03205997b71cf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b949ee0599802274@google.com>
Subject: Re: BUG: corrupted list in __dentry_kill (2)
From:   syzbot <syzbot+31043da7725b6ec210f1@syzkaller.appspotmail.com>
To:     a@unstable.cc, alex.aring@gmail.com, allison@lohutok.net,
        andrew@lunn.ch, andy@greyhouse.net, ap420073@gmail.com,
        ast@domdv.de, ast@kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
        bpf@vger.kernel.org, bridge@lists.linux-foundation.org,
        cleech@redhat.com, daniel@iogearbox.net, davem@davemloft.net,
        dsa@cumulusnetworks.com, dsahern@gmail.com, dvyukov@google.com,
        f.fainelli@gmail.com, fw@strlen.de, gregkh@linuxfoundation.org,
        haiyangz@microsoft.com, hawk@kernel.org, hdanton@sina.com,
        idosch@mellanox.com, info@metux.net, j.vosburgh@gmail.com, j@w1.fi,
        jakub.kicinski@netronome.com, jhs@mojatatu.com, jiri@mellanox.com,
        jiri@resnulli.us, johan.hedberg@gmail.com, johannes.berg@intel.com,
        john.fastabend@gmail.com, john.hurley@netronome.com,
        jwi@linux.ibm.com, kafai@fb.com, kstewart@linuxfoundation.org,
        kvalo@codeaurora.org, kys@microsoft.com,
        linux-bluetooth@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-hams@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-wpan@vger.kernel.org,
        liuhangbin@gmail.com, marcel@holtmann.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this bug to:

commit ab92d68fc22f9afab480153bd82a20f6e2533769
Author: Taehee Yoo <ap420073@gmail.com>
Date:   Mon Oct 21 18:47:51 2019 +0000

     net: core: add generic lockdep keys

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d37cb6e00000
start commit:   938f49c8 Add linux-next specific files for 20191211
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11d37cb6e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=16d37cb6e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=96834c884ba7bb81
dashboard link: https://syzkaller.appspot.com/bug?extid=31043da7725b6ec210f1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dc83dae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ac8396e00000

Reported-by: syzbot+31043da7725b6ec210f1@syzkaller.appspotmail.com
Fixes: ab92d68fc22f ("net: core: add generic lockdep keys")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
