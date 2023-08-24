Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AEE7874AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 17:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241870AbjHXPzs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 11:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242355AbjHXPzh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:55:37 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1479D1991
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Aug 2023 08:55:34 -0700 (PDT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1bdd75d2f73so13108135ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Aug 2023 08:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692892533; x=1693497333;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+aXdP1B+FgxdGCzykCKzGTnnvyJ+Lx6s4rg1obN7Qbk=;
        b=HYBZQSgapebj9OFi63YMhQYGE+W71zNyvDw6P1yLVJaSS//TXJ5kV39B9MIUXr9qX2
         XgxsMRugGAWWY3rqk8d2HLgTSi40TRe9RGptUwVtrCPUmrcg0v1LDK2cQ2u+Dodu3eaI
         sQTDD2EDfh+5Cc4HBbth8OnRV4bfy6JgDjH71SDIEnpqCQoAhoxhxDE4J8+W5dXh1WM8
         uzkUNVUvgIqPYpNjDT5NuiUk06Mfgj/lpm5Th+EEcBBGhxegk8yejlAZrcdwTW6GOrth
         fdlkdDQEZcoRGtZtfa4cDDhgm+pSIewGzu/ykJM/yGxLNM5CgpyOV2SX+DwqzYknbI0M
         HW5g==
X-Gm-Message-State: AOJu0Yxkek83ClS7TkEe6ThXk3Zttw7EQ6SSPtsn1Lux7JfsMMt0NU+k
        aBMnprTEamks3FpOjFs98BNELKOBU8mhurj77PwVaMjiwPaJ
X-Google-Smtp-Source: AGHT+IGlMDpByqwKN1nPkwOZ6cneGx5U8uHqYAq4mzi8Dm1fiSg/5r5iCD6/x3lo/kY24VLtNZrGpmu0TbdY75CrMu5ucsZiquhn
MIME-Version: 1.0
X-Received: by 2002:a17:902:f551:b0:1bc:e37:aa5c with SMTP id
 h17-20020a170902f55100b001bc0e37aa5cmr6759816plf.1.1692892533578; Thu, 24 Aug
 2023 08:55:33 -0700 (PDT)
Date:   Thu, 24 Aug 2023 08:55:33 -0700
In-Reply-To: <0000000000000f188605ffdd9cf8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b658e0603ad424d@google.com>
Subject: Re: [syzbot] [f2fs?] possible deadlock in f2fs_add_inline_entry
From:   syzbot <syzbot+a4976ce949df66b1ddf1@syzkaller.appspotmail.com>
To:     chao@kernel.org, hdanton@sina.com, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 5eda1ad1aaffdfebdecf7a164e586060a210f74f
Author: Jaegeuk Kim <jaegeuk@kernel.org>
Date:   Wed Jun 28 08:00:56 2023 +0000

    f2fs: fix deadlock in i_xattr_sem and inode page lock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=167691b7a80000
start commit:   cacc6e22932f tpm: Add a helper for checking hwrng enabled
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=157691b7a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=117691b7a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=171b698bc2e613cf
dashboard link: https://syzkaller.appspot.com/bug?extid=a4976ce949df66b1ddf1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103c6bb3a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bb51c7a80000

Reported-by: syzbot+a4976ce949df66b1ddf1@syzkaller.appspotmail.com
Fixes: 5eda1ad1aaff ("f2fs: fix deadlock in i_xattr_sem and inode page lock")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
