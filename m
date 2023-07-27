Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E2F76602C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 01:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjG0XOd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 19:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjG0XOb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 19:14:31 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74A12701
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 16:14:29 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a5b92b4b63so3069430b6e.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 16:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690499669; x=1691104469;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1rPvaF6OOJ/U+YAeLPtcgmuDs5ZebXxvGSINN1V35cM=;
        b=JvuqJQTlhDAEdP1/fHYhemhMgRHoQrpFr/JlyTIvaBJIQFjjnaHYxVG3Qs2lHPLPmz
         mNy+qqT7dFYUNjKzos0xMAqrr+T1kw8u30WXM4fzTRaAjf+UoY3+JyZdxC5m+gEWZzmN
         TPJ7dZ/J9hxiogJWf/l5QNaDur9Ct+SEeKnl8JOCPOqF6fN5l+0b9wPpDYdItX9pFtcu
         hyQQvhVk5wVJrg/J3pSkiXUsvnkbBPPAj5YnHigPLzhP7XQf5cUtstuNY/jFWz1HDdoP
         wDajFNreTK1MMQ2dbA5D4PFO6DX/QqnKhvw5ugI/PTG2XsU3PpvgFYrI0KDtWpE2CS5X
         351w==
X-Gm-Message-State: ABy/qLaOI4dkAmTbHBctn12Ys3XgE9jD8m3Rk0x31JrTiy1C/QB5nF5I
        lYoXASUHl5bodeGl/Y+a1PStCKWY84YE5G4REkhiMId95Qk8
X-Google-Smtp-Source: APBJJlEW3A9Hylxq1g07WDmdfR32/vGq1EVapb5OIXuzXwTElrsjV1PAQHPcVWawdzwRYS3XtenGxKggp6cwPaHdP5tcaCjiHkHc
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1305:b0:3a1:e88d:98b9 with SMTP id
 y5-20020a056808130500b003a1e88d98b9mr1342693oiv.7.1690499669138; Thu, 27 Jul
 2023 16:14:29 -0700 (PDT)
Date:   Thu, 27 Jul 2023 16:14:29 -0700
In-Reply-To: <0000000000000cf7de0601056232@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000045a44b0601802056@google.com>
Subject: Re: [syzbot] [gfs2?] kernel panic: hung_task: blocked tasks (2)
From:   syzbot <syzbot+607aa822c60b2e75b269@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, arnd@arndb.de, cluster-devel@redhat.com,
        dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 9c8ad7a2ff0bfe58f019ec0abc1fb965114dde7d
Author: David Howells <dhowells@redhat.com>
Date:   Thu May 16 11:52:27 2019 +0000

    uapi, x86: Fix the syscall numbering of the mount API syscalls [ver #2]

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=169b475ea80000
start commit:   fdf0eaf11452 Linux 6.5-rc2
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=159b475ea80000
console output: https://syzkaller.appspot.com/x/log.txt?x=119b475ea80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27e33fd2346a54b
dashboard link: https://syzkaller.appspot.com/bug?extid=607aa822c60b2e75b269
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11322fb6a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17687f1aa80000

Reported-by: syzbot+607aa822c60b2e75b269@syzkaller.appspotmail.com
Fixes: 9c8ad7a2ff0b ("uapi, x86: Fix the syscall numbering of the mount API syscalls [ver #2]")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
