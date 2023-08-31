Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F91978E3FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 02:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344921AbjHaAbi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 20:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbjHaAbh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 20:31:37 -0400
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD35FCCF
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 17:31:34 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6bdb30c45f6so471279a34.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 17:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693441894; x=1694046694;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n+Ys1cwjPfgqv/vEsA4s7A+pElm5Cn9tj91Zioe86LI=;
        b=e/gOYIq0zVATP3WfdPcxKxEq0S98P8dB/Nt28dVhtMygHYhi6XDmwBQtYPTsUdHkZt
         9dRAYAlOjAbFW6eY0lFARUOVGCPwJEd0Kru2J4P/tu+mIofzUhErq7N4mWJhvBhA/nOk
         XQJ3CT0odqL4pQDELcCvzdzQe72J/+TLVAXWeg9iX5YsoUSJ9zjj/VtB3O9Tp+ADhLhM
         Eg9gIGAua1MfFipRDoUfYGu3oys4zCM5GTiG7KVIN72aqGUvcoYBWKJFCPQN5PTNxdni
         SOict09uxhIXNqwJWyzrSs24KdJtJQFXB8fJovQdGQUNziGHLf4OBupozQvZ2pfPiBXh
         s42g==
X-Gm-Message-State: AOJu0YyaYfA5xt0PqkYYxirc5qSsMUf/lfMWnOVVW9skjhOZCzq9SUoG
        aYlamhB4zkSnK2t6vsu4eC+ohiJSbQEb4GBZ7dMQq/iSMkqd
X-Google-Smtp-Source: AGHT+IH/xFTz4XQxoutjF9VYd71vW+qQX2pv9ulRwbHgizHfCMrd72ah6dGGlmAvpkUjeFfrdGqRibIV1gy5WEuRRlQQHGWoS/Gy
MIME-Version: 1.0
X-Received: by 2002:a9d:4d0e:0:b0:6b9:a422:9f with SMTP id n14-20020a9d4d0e000000b006b9a422009fmr374752otf.1.1693441894159;
 Wed, 30 Aug 2023 17:31:34 -0700 (PDT)
Date:   Wed, 30 Aug 2023 17:31:34 -0700
In-Reply-To: <0000000000009531dc0602016bb0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c9d5106042d2abb@google.com>
Subject: Re: [syzbot] [ntfs3?] BUG: unable to handle kernel NULL pointer
 dereference in hdr_find_e (2)
From:   syzbot <syzbot+60cf892fc31d1f4358fc@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com, astrajoan@yahoo.com,
        ivan.orlov0322@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
        skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 6e5be40d32fb1907285277c02e74493ed43d77fe
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Aug 13 14:21:30 2021 +0000

    fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=151f20a8680000
start commit:   4b954598a47b Merge tag 'exfat-for-6.5-rc5' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=171f20a8680000
console output: https://syzkaller.appspot.com/x/log.txt?x=131f20a8680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e3d5175079af5a4
dashboard link: https://syzkaller.appspot.com/bug?extid=60cf892fc31d1f4358fc
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ee0aa6a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100eaedea80000

Reported-by: syzbot+60cf892fc31d1f4358fc@syzkaller.appspotmail.com
Fixes: 6e5be40d32fb ("fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
