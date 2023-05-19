Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B5470A11C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 22:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjESU4q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 16:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjESU4e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 16:56:34 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AEB10CB
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 13:56:23 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-76fffd0116eso28392639f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 13:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684529783; x=1687121783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dAhsFZWzv4pW+FEJe+j1meXIun7sOpZm0ldqZGqi+6E=;
        b=lm4tKxCC5r2EYc/Yn3aVG8q1z9C9tEXSRaMO2vfnNYZKcKkrGc10QCE+jeZjKdFGyx
         7vzYDQRkhgrOcJjdzZGROdtoEOTuU8rLpCuQQ8RqgRX2F/cEnNlIPKLbpbhJ7LPXjADb
         cme9XPoXka14eZbLxL8Fxna4DEEJvN+COAqDDlZ4hG/z1ci3zUCsrYc7nTT4uwi0+JnG
         jdDdXpEupm+plUfDYZrTVtiWKgbnwTYX5OB30ZcQKqORUJW8Dq9fBHOPtiExBjqs7yqe
         B2nauc9gZAJIAIEvI4KZTB9F27LAK6g4S4Cs6A1RUHRCe16/EemBye4zqsJLPC0RYQeG
         UPnQ==
X-Gm-Message-State: AC+VfDxyJ93+F1dvx2ldw+wLhLYRUWznnbl5VY0uB+josczKZ5t4AOWU
        oXq/Kb9IsZOpIRLvFZNQdPmsulVzJT/LjYMCiUYv3Op0+2ii
X-Google-Smtp-Source: ACHHUZ5eBPeWyWaKDI49prhq7AsL0tX3Bj9eT6ivEGfM3LMeHkEYBzhvJHuqViDOaSy6/2UcdyP6aCq7gupAugrkOgoTWXQny1xM
MIME-Version: 1.0
X-Received: by 2002:a02:b0ca:0:b0:40f:ae69:a144 with SMTP id
 w10-20020a02b0ca000000b0040fae69a144mr1390179jah.5.1684529783286; Fri, 19 May
 2023 13:56:23 -0700 (PDT)
Date:   Fri, 19 May 2023 13:56:23 -0700
In-Reply-To: <0000000000001b987605f47b72d3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058b12b05fc122703@google.com>
Subject: Re: [syzbot] [reiserfs?] [overlayfs?] WARNING: locking bug in take_dentry_name_snapshot
From:   syzbot <syzbot+5a195884ee3ad761db4e@syzkaller.appspotmail.com>
To:     casey@schaufler-ca.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, paul@paul-moore.com,
        reiserfs-devel@vger.kernel.org, roberto.sassu@huawei.com,
        syzkaller-bugs@googlegroups.com, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 52ca4b6435a493e47aaa98e7345e19e1e8710b13
Author: Roberto Sassu <roberto.sassu@huawei.com>
Date:   Tue Mar 14 08:17:15 2023 +0000

    reiserfs: Switch to security_inode_init_security()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=121dea5a280000
start commit:   4bdec23f971b Merge tag 'hwmon-for-v6.3-rc4' of git://git.k..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea09b0836073ee4
dashboard link: https://syzkaller.appspot.com/bug?extid=5a195884ee3ad761db4e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1277fb1ec80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12543651c80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: reiserfs: Switch to security_inode_init_security()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
