Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA55686910
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 15:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjBAOz1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 09:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjBAOzZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:55:25 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083A665F30
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Feb 2023 06:55:24 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id z12-20020a92d6cc000000b00310d4433c8cso8527613ilp.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Feb 2023 06:55:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHi5bo3BzN4qPZ3mH6tPOGWzgbCBFQ/FU5LJ+gZiS0M=;
        b=ydxOrzNMpXzNktirSu94bznjSRLi5gWl2eVGgEDvy7F8fRN+qgmtaxlHkaB/FzaBbr
         OEiRlOPM2IXZpmW9/2Ud1qvRYzBSlOmyV4s35/G7RpdmZs/PfoplUarPxsWxAoSThRpM
         MxCNKrjgCFeWlWvzfKkTjeOyNG9jlJyBs83CK6ddp/bgzFpvrbVSCWYNpq1BRPmdFAOy
         A/IMiDRvW82a1BAV54ZnbjcrM/gLAQDPQoRP1v5jgmePe4TXFGmzUBzD+5mJKHC5BnE1
         vJ+n3hFO5mDDQdIyhqHeMXqeLZ/WaHZSmr8VIb8w8SdY2Q8HtLf6zB8LMCwSlmPgPSue
         7QoA==
X-Gm-Message-State: AO0yUKWrMoER+OzSoLIKCm8HjjbxdyNCTfoK6Wl4z9bEz5OpLoJAifHe
        V1aklU9cc3IbfAOLyFg7iGyU5DDlv7P1Zp8CVBRaQGp5ICJB
X-Google-Smtp-Source: AK7set+UGIpl3wTKHaXpzg2fKL3h3H9zyaLxeaTVojjCe5oJvNoD9IYP7owJ4jx6i4ZQp7jUcj6Al1H/hidiUGa7GTzzorVtLAFy
MIME-Version: 1.0
X-Received: by 2002:a02:9468:0:b0:375:c16b:7776 with SMTP id
 a95-20020a029468000000b00375c16b7776mr540197jai.54.1675263323110; Wed, 01 Feb
 2023 06:55:23 -0800 (PST)
Date:   Wed, 01 Feb 2023 06:55:23 -0800
In-Reply-To: <000000000000fea8c705e9a732af@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047848f05f3a4a32f@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: use-after-free Read in hdr_find_e
From:   syzbot <syzbot+c986d2a447ac6fb27b02@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, pjwatson999@gmail.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
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

syzbot suspects this issue was fixed by commit:

commit 0e8235d28f3a0e9eda9f02ff67ee566d5f42b66b
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Mon Oct 10 10:15:33 2022 +0000

    fs/ntfs3: Check fields while reading

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1268739e480000
start commit:   55be6084c8e0 Merge tag 'timers-core-2022-10-05' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=df75278aabf0681a
dashboard link: https://syzkaller.appspot.com/bug?extid=c986d2a447ac6fb27b02
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164e92a4880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=126f7ac6880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Check fields while reading

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
