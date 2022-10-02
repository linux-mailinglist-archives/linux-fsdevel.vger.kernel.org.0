Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961105F2533
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Oct 2022 22:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiJBUEW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Oct 2022 16:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJBUEU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Oct 2022 16:04:20 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5D0303C1
        for <linux-fsdevel@vger.kernel.org>; Sun,  2 Oct 2022 13:04:19 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id l18-20020a056e02067200b002f6af976994so7164547ilt.16
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Oct 2022 13:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=alt+Pnmjzew3cSMHF8D4f4jTWwNd/We9mTfqo5aLOos=;
        b=XrNGo7TDHLxD99gk0vU5ChaDiyk2reURj2jxILXIIWY+c/SNCQJRs+V7g6T6JjKPNC
         vXDfm95NgXlTiHHfEc3kLRUvcoqhDIGiKMTKm1DEmC4aqYrbcia0UHPo9GszOaJahtXA
         KeJehD6OGgMcQEn7Z1dZY+pzvK7H8Tm1m4uXiokdEZJ9G/ObOWPzmX88f6752OSwdzNs
         rD9fQ2GkUthGLE0wFIiTY6bL3gWIwFuPP1R7nPwYlScZAHdheVELvLIrSig1AALgIHRA
         NcVLqh+T//xzWk+dusTLpZFF1sm/CL7XJojswqG735ZTKX2Tw0WuS7NUwzv211inhuf5
         qpNg==
X-Gm-Message-State: ACrzQf3JmfBDCb54j4InHyfiYIlzgLxUoHPJ4iFMOWu7MAcoPIO8FYG9
        nM0jvb5u3EkbhqnvJv0rDsMeY+gXbLGEepQo8UtuvvJ2R+jZ
X-Google-Smtp-Source: AMsMyM6VLcxZo3tjaJFXzbN/lsdTicHGhkOT9Fp7uoyQ4GhRHFgxHmgHscdmxDLKobMFvIgDK8W1sDcVNrnUqYDMsKocGpjcH2gM
MIME-Version: 1.0
X-Received: by 2002:a05:6638:150c:b0:35a:f7a9:c3d8 with SMTP id
 b12-20020a056638150c00b0035af7a9c3d8mr9235231jat.38.1664741059255; Sun, 02
 Oct 2022 13:04:19 -0700 (PDT)
Date:   Sun, 02 Oct 2022 13:04:19 -0700
In-Reply-To: <000000000000eca83705e9a72fb9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007ae43605ea12bb12@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in ntfs_trim_fs
From:   syzbot <syzbot+b892240eac461e488d51@syzkaller.appspotmail.com>
To:     abdun.nihaal@gmail.com, almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
        skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17b6daf4880000
start commit:   f76349cf4145 Linux 6.0-rc7
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1476daf4880000
console output: https://syzkaller.appspot.com/x/log.txt?x=1076daf4880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=b892240eac461e488d51
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133c8540880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b74870880000

Reported-by: syzbot+b892240eac461e488d51@syzkaller.appspotmail.com
Fixes: 6e5be40d32fb ("fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
