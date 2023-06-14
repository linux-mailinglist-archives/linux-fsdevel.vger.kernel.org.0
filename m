Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3BA730967
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 22:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbjFNUr3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 16:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbjFNUr2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 16:47:28 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88BC268A
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 13:47:26 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-777b6a2582dso756563139f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 13:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686775646; x=1689367646;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XmYyn6KjnwCcEInr35KmY2CR5pAuogsMVf8CnIOKBGw=;
        b=cZqb2hpDzAkeHfHsHcGKep2ZQQvt6uKVs6bhkjUGV1zD1KCPIjkD8hookCtvRb0Ufa
         naTlXPs8TsB9NqfvPSDra5IgEUdN001E+FQ+jywkmKCiGclpziZSUMD21NSIalW8qVbn
         q2PTHwAs0TWhJIEAVtwfFYS4xpiD0sUMmoOXGU/+JKJn1zyiqBPYXbupEGxWPDhyvQjE
         HQ6JYoyGj5uYNjzdkr3UMYp8AamTiTqxeZydMSCOsV8dOyoJXJ9tEFi8OZxXmZvdwZdU
         FvHhVJhPpqm2xP84zQnd6alECWG+hYV+SuGSwK6AF4ftUSkJcdAVoP9LgfmvZJ3cQqGq
         QTvQ==
X-Gm-Message-State: AC+VfDx1Tb0zCbYem0yBVgrT5dVkyZEYSKVnjLzJxixr2II8AZOu1fJD
        W8wPdB0XuQE6QKAW2hnpLb8vSOv2CPCsmIPDb9XUdGJPT4eS
X-Google-Smtp-Source: ACHHUZ5ToLA16XDVvAhNW/25+v4XSEYndMm5DT0kaatIkxpwnMZIf/zfE0p7x9xA3A0Lw+CqVJxIM7cy7H1J0ip7ZWuN4posFSI+
MIME-Version: 1.0
X-Received: by 2002:a92:d24c:0:b0:341:3354:7688 with SMTP id
 v12-20020a92d24c000000b0034133547688mr218650ilg.6.1686775646277; Wed, 14 Jun
 2023 13:47:26 -0700 (PDT)
Date:   Wed, 14 Jun 2023 13:47:26 -0700
In-Reply-To: <0000000000004f067905ea8ab9b2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003656ed05fe1d0fa5@google.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in dquot_commit (2)
From:   syzbot <syzbot+70ff52e51b7e7714db8a@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, boqun.feng@gmail.com, jack@suse.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
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

commit f0f44752f5f61ee4e3bd88ae033fdb888320aafe
Author: Boqun Feng <boqun.feng@gmail.com>
Date:   Fri Jan 13 06:59:54 2023 +0000

    rcu: Annotate SRCU's update-side lockdep dependencies

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1355576f280000
start commit:   ab072681eabe Merge tag 'irq_urgent_for_v6.2_rc6' of git://..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8d5c2ee6c2bd4b8
dashboard link: https://syzkaller.appspot.com/bug?extid=70ff52e51b7e7714db8a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11436221480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15133749480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: rcu: Annotate SRCU's update-side lockdep dependencies

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
