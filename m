Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48813770C93
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Aug 2023 02:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjHEAJc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 20:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjHEAJa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 20:09:30 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14434694
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 17:09:27 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3a7292a2ad5so4628778b6e.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Aug 2023 17:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691194167; x=1691798967;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FoY/PwFD0Rg65vVH6VJq/xffUWgs1OqWSy1dP4FgMIQ=;
        b=MPTqp1Xzn8impvadGPl/y5TVsYI3TQQrbbIFfAv2xyg0t9j6ow/Hx/uVdc+g9HzL0E
         2kzQG3NjqoF1LBMAfZNdpWpJszQwvfGcIvYTlSu3IMqQVpO8WzmZmCP3Mdtj/qN3RTSO
         EGfr6plMdztf/z+RN2F1o4DykPXysNdh9TcH//BbLUHx+w+zJob+hVuVydudd3td5hJy
         MQD85wDLbmk0MuLqQMJfZj7kfPsYFLuZEaGJlJAq7HniSspRGk+2SSX2cqL/5fora46o
         DW5Y8xKk0+wkQiHXcJHxKEPYWU4v6oMgbSsvkz5CDNxRI6dY0L0xAdCUtWuXvBulqlyk
         vcKw==
X-Gm-Message-State: AOJu0Yx6fyoa14qa+xaaAjSy9v5KGm/HnNCErbeDnTKlwewv9+xwa8D0
        Q+zQEIYjNi2pp996/2Dauh766T7QU2QDDiaCjIVGrzP22n8X
X-Google-Smtp-Source: AGHT+IHzZpeBgcO6v7s1Q4yu3YWAWP/RE2nVc5pSgc2PsDu2FLAxNAV7Vpa/NM77hMlzGvEouqMcspaw7MDkHJ5NQYnjtdSJZ8F2
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1812:b0:39c:a74b:81d6 with SMTP id
 bh18-20020a056808181200b0039ca74b81d6mr4782033oib.7.1691194167195; Fri, 04
 Aug 2023 17:09:27 -0700 (PDT)
Date:   Fri, 04 Aug 2023 17:09:27 -0700
In-Reply-To: <000000000000f1a26f05e9a72f57@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000094fcb0060221d31a@google.com>
Subject: Re: [syzbot] [fs?] WARNING in brelse
From:   syzbot <syzbot+2a0fbd1cb355de983130@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        liushixin2@huawei.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit f6e2c20ca7604e6a267c93a511d19dda72573be1
Author: Liu Shixin <liushixin2@huawei.com>
Date:   Fri Apr 29 21:38:04 2022 +0000

    fs: sysv: check sbi->s_firstdatazone in complete_read_super

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15e8976da80000
start commit:   77856d911a8c Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17e8976da80000
console output: https://syzkaller.appspot.com/x/log.txt?x=13e8976da80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f967143badd2fa39
dashboard link: https://syzkaller.appspot.com/bug?extid=2a0fbd1cb355de983130
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11393ab3880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a2a99d880000

Reported-by: syzbot+2a0fbd1cb355de983130@syzkaller.appspotmail.com
Fixes: f6e2c20ca760 ("fs: sysv: check sbi->s_firstdatazone in complete_read_super")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
