Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41C77802D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 02:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356769AbjHRA60 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 20:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356772AbjHRA6Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 20:58:25 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FDB3589
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 17:58:24 -0700 (PDT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1bdba3f0e73so5248805ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 17:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692320304; x=1692925104;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0856/LMBKD4uG4QX6/8X6PxHig9I05CynoZA8Z5WMM=;
        b=AsfJO/tOrsxMwdaks7Yc7z+dXlyN6/TeqQFm+n63jrJ1Gh1egahrhlYCdAbkdeKsS3
         MxZ5/eX1GsfrTxajpH8r3HZLrTj1b0PC7L/kajF4HzTAxJt9uovdXIgKbB2G4pmB5hIV
         fQKt6oV3g7z0x/PUHZL6rs89YQK+nX9jD+DljOzMNQaN/c3kVQ41PnYS90Ae6QCYU7Ev
         gEQVrhy5S6B4u0b7MwoZRHCwgVbPiT64gVQ8dYNtbeYY0Mkj0p7Nh6tl+dSrUOZAm/Kq
         8tJoshbUidRe8S5pVfh5Tf3Z6iIcQRoP2A+n5C0i5+YrC19RSdTvQL1gIDdTGa5Fj4Xc
         di+g==
X-Gm-Message-State: AOJu0YyXGt7aT505Y/IXflq8iXIR9JblGj75P0LRINzCE1ynFcJUPWBu
        fDxbyZlnlomdy5RTPxjYfm113FB1dOSxp3APkRHUso0ssxav
X-Google-Smtp-Source: AGHT+IEMJ9nR4BvHyz1sKVWdLnoP4Qk0/Pjw0eFvs4jvQm8Jb7Y8vjiRq96VR9/Xd97rY3qL8XlYyEQi1dp/TgK5czH11dVEJzKV
MIME-Version: 1.0
X-Received: by 2002:a17:903:11c4:b0:1bc:95bf:bdc9 with SMTP id
 q4-20020a17090311c400b001bc95bfbdc9mr335108plh.13.1692320303975; Thu, 17 Aug
 2023 17:58:23 -0700 (PDT)
Date:   Thu, 17 Aug 2023 17:58:23 -0700
In-Reply-To: <0000000000003da75f05fdeffd12@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009095e80603280632@google.com>
Subject: Re: [syzbot] [nilfs?] WARNING in mark_buffer_dirty (5)
From:   syzbot <syzbot+cdfcae656bac88ba0e2d@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, konishi.ryusuke@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 28a65b49eb53e172d23567005465019658bfdb4d
Author: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Thu Apr 27 01:15:26 2023 +0000

    nilfs2: do not write dirty data after degenerating to read-only

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11c5be4ba80000
start commit:   6eaae1980760 Linux 6.5-rc3
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13c5be4ba80000
console output: https://syzkaller.appspot.com/x/log.txt?x=15c5be4ba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d10d93e1ae1f229
dashboard link: https://syzkaller.appspot.com/bug?extid=cdfcae656bac88ba0e2d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127ac14ea80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1693a06ea80000

Reported-by: syzbot+cdfcae656bac88ba0e2d@syzkaller.appspotmail.com
Fixes: 28a65b49eb53 ("nilfs2: do not write dirty data after degenerating to read-only")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
