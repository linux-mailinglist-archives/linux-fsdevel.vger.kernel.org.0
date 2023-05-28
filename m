Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94345713963
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 May 2023 14:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjE1MKe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 May 2023 08:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE1MKd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 May 2023 08:10:33 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DDAB6
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 May 2023 05:10:31 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-76998d984b0so380545639f.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 May 2023 05:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685275830; x=1687867830;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wm6IKPj1vMMJrUxmKpUlCDI+xA2XUJA6ZIRpAJeh0E8=;
        b=h1a2OiHR2yKf4jq3iwd6dTlMcpHil45kU8b6t6lYLXIRHYdpS1FUO181/RcX0CyZq4
         a6LB34yAdIUn1B3pGcgbmSuhm3xFTw7qjmATE0RKqwm9CGqtz0ktMUc7c7UYOX4eIckD
         nLOo4GlQHQIAKCBlIoFQ1/FxHH2Xs/ot3ha8bfOeNt/0C3Ki8GRT6fOLmKI30FTMbd/B
         9+dl18bZrFn7g6IKoqKa46Yxl2hsJpiDTPgvJkV818huBvDWTAOcTE8tt4mo3dDmarpy
         p3JhF3alMahAsJDWUDXwG4xHQKRPvONugcRq88dwern/b9ra9kQt0uXZHs+/DLoSbn8a
         58BA==
X-Gm-Message-State: AC+VfDxL/J9x7lULLpPnWIZDmEtUi10izSywrYN/bBx0ThoYc4VkiUdk
        ekd6n1BOQJlUSO7wxp38z/jBMk5quwXPUAj26RHCMSddzRh/
X-Google-Smtp-Source: ACHHUZ4CR5b8H0wmXLm7aJuF4Tdf0/z5aCLMklVGTfClc5kah2GMYkAu7IYkwVnC9s8+LAyLxMv4TPJTEkHgsZglzH11TYR1f/JW
MIME-Version: 1.0
X-Received: by 2002:a02:948d:0:b0:41c:feac:7a9a with SMTP id
 x13-20020a02948d000000b0041cfeac7a9amr1722550jah.5.1685275830699; Sun, 28 May
 2023 05:10:30 -0700 (PDT)
Date:   Sun, 28 May 2023 05:10:30 -0700
In-Reply-To: <000000000000540fc405f01401bf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003ccc9b05fcbfdb68@google.com>
Subject: Re: [syzbot] [xfs?] general protection fault in __xfs_free_extent
From:   syzbot <syzbot+bfbc1eecdfb9b10e5792@syzkaller.appspotmail.com>
To:     dchinner@redhat.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

syzbot suspects this issue was fixed by commit:

commit b2ccab3199aa7cea9154d80ea2585312c5f6eba0
Author: Darrick J. Wong <djwong@kernel.org>
Date:   Wed Apr 12 01:59:53 2023 +0000

    xfs: pass per-ag references to xfs_free_extent

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1007e5c1280000
start commit:   02bf43c7b7f7 Merge tag 'fs.xattr.simple.rework.rbtree.rwlo..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c59170b68d26a55
dashboard link: https://syzkaller.appspot.com/bug?extid=bfbc1eecdfb9b10e5792
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1798429d880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161b948f880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: xfs: pass per-ag references to xfs_free_extent

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
