Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECC158B849
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Aug 2022 22:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbiHFUsK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Aug 2022 16:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbiHFUsJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Aug 2022 16:48:09 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443CB7661
        for <linux-fsdevel@vger.kernel.org>; Sat,  6 Aug 2022 13:48:08 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id x2-20020a6bfe02000000b00682bffede8fso3040663ioh.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Aug 2022 13:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=6veuc/XHAxtn2Xroc6Y8PJ3UWlSKQeS+PX4HS+juUVM=;
        b=ui9HuF37K+tfrMfciTRx1By3cO7FfXlMP2CpYsptUgM0Ooo80edby9Kqio7LZR17xw
         xiGZK6QOMJ/zo8LVId4FK8xzGz/P/d0qkTNLlG5/nZCGlfFonT1P/ZbASBA9i1EXDaBv
         zYjA3D55UcF7MD4xnMxw/oK4Lh6RyUsvBHI01mfu7XdnOjIhFaXoDpXxXChubDL2NhFl
         Cpw+9Dwb85rTsuChVFrX7dWKcZpcTITGlvKzi1T2gqcBGYb1DH00jT2l8XMHnEuGY178
         pWQt1aOw7VaP/o9QCyKEJdF+nc9tE/7DTr170sohHZO/We5oEFn/JlPIQbZShECUgLN/
         lQUQ==
X-Gm-Message-State: ACgBeo097i3+Hu6+7xnoEafdt8CsamG7G0ghr1ECry0WUjEAuxbekcMm
        ePFww5kzqqwktnXEHb3XPPZxNUte8u7JwoUqnBB6iswZ6Twz
X-Google-Smtp-Source: AA6agR5XWoTMTg8WspELDXHq4ObjTW5Sza4vp/U8sJQu61nNhwbxCz94Dx8ZlDCKEV6Eg5gQNxMtkC4uL09b2zbMSriONduq5s/p
MIME-Version: 1.0
X-Received: by 2002:a6b:d307:0:b0:680:bcfb:bed7 with SMTP id
 s7-20020a6bd307000000b00680bcfbbed7mr4687069iob.61.1659818887648; Sat, 06 Aug
 2022 13:48:07 -0700 (PDT)
Date:   Sat, 06 Aug 2022 13:48:07 -0700
In-Reply-To: <0000000000005b04fa05dd71e0e0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000309f9e05e598b315@google.com>
Subject: Re: [syzbot] KASAN: out-of-bounds Write in end_buffer_read_sync
From:   syzbot <syzbot+3f7f291a3d327486073c@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        gautammenghani201@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14aab3ca080000
start commit:   200e340f2196 Merge tag 'pull-work.dcache' of git://git.ker..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16aab3ca080000
console output: https://syzkaller.appspot.com/x/log.txt?x=12aab3ca080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a3f4d6985d3164cd
dashboard link: https://syzkaller.appspot.com/bug?extid=3f7f291a3d327486073c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e211fa080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14866761080000

Reported-by: syzbot+3f7f291a3d327486073c@syzkaller.appspotmail.com
Fixes: 6e5be40d32fb ("fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
