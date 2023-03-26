Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3AC6C9700
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Mar 2023 18:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjCZQ60 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Mar 2023 12:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjCZQ6Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Mar 2023 12:58:25 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CF64EF9
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Mar 2023 09:58:24 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id z65-20020a6bc944000000b007584beb0e28so4129764iof.21
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Mar 2023 09:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679849903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vq3vDhPKDyeaes7/yEj7BE2fi8mRxBSHslw2Y4HzVzo=;
        b=gvwQRpaNtak6N4+E+Td+CW1V2YXiL31N3S1yrwViUx2MWVGhuQ+/r2bcQh4nD9wzo2
         e/mm2gpjaBcT0hwNStPz++LiuCv6HEC02QMnooViUhuXrWC/OGKgcxx9OxWKdODrlhxj
         MS6gi+GiZPxB7ESJV9ZHN0TwHRqFferIJ8TEX76De8xIJmqpTPO+xwDDoxWknld2AwCx
         hOZ+cp+Yrzl6rQX6ArndN0pr8CN9sU98T16/D0F6REYlBzEYZEltEQkqUJjkxBzSifAG
         aBI3S4nMZfMTg3MeY1Z4hmRuqTuB9r2vpDDKePKclVcNO6hxcxnrd9oq0STiq6y8kbH6
         0rfw==
X-Gm-Message-State: AAQBX9dIyMMdk//Radx1at6nNb706xWjdDm6U3OFM+ModRKv0P9tUlmU
        QAJQ0l++1d0Fx0kTpOfU+5nYAOelm+6tEkYGA+/6JRRbub5y
X-Google-Smtp-Source: AKy350ZxaK9M2hsWGjTlFcnGNf6JQhjgwxQU0n7BtyFmcs5MnBJvxa5UgxtQAcQDiPhBHQRlms4xXz3PeQsI3QP/1gxw83C0O+GA
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4d:b0:315:3821:b56b with SMTP id
 u13-20020a056e021a4d00b003153821b56bmr5010047ilv.6.1679849903389; Sun, 26 Mar
 2023 09:58:23 -0700 (PDT)
Date:   Sun, 26 Mar 2023 09:58:23 -0700
In-Reply-To: <0000000000000ac4cc05f6e7f12b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c4832e05f7d088c6@google.com>
Subject: Re: [syzbot] [f2fs?] INFO: task hung in f2fs_balance_fs
From:   syzbot <syzbot+8b85865808c8908a0d8c@syzkaller.appspotmail.com>
To:     chao@kernel.org, hdanton@sina.com, jaegeuk@kernel.org,
        jiayang5@huawei.com, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.1 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 10d0786b39b3b91c4fbf8c2926e97ab456a4eea1
Author: Jia Yang <jiayang5@huawei.com>
Date:   Wed Jul 14 07:46:06 2021 +0000

    f2fs: Revert "f2fs: Fix indefinite loop in f2fs_gc() v1"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13426789c80000
start commit:   4bdec23f971b Merge tag 'hwmon-for-v6.3-rc4' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10c26789c80000
console output: https://syzkaller.appspot.com/x/log.txt?x=17426789c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea09b0836073ee4
dashboard link: https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1320ef41c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100b561ec80000

Reported-by: syzbot+8b85865808c8908a0d8c@syzkaller.appspotmail.com
Fixes: 10d0786b39b3 ("f2fs: Revert "f2fs: Fix indefinite loop in f2fs_gc() v1"")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
