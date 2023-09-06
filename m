Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126F6793752
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 10:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235570AbjIFIqj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 04:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjIFIqi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:46:38 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BABCFD
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 01:46:35 -0700 (PDT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1bf39e73558so46065875ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Sep 2023 01:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693989994; x=1694594794;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F82xWmip9IdB9K1IuccZ0lyqvzI+AMyxxyRv3A0SdbA=;
        b=l7k6dyfXV8jolDq1UANaJUIuBGUmXntieM9u3FORHJ+LZOVwMsp+eD+SQ94JuCxrXw
         NzChbAHHVmY1Kz45CfFGrqgLpBpk/qzldp+imxE0kgYNPEAABTw4vkDzZOHa9dOETv5Y
         sz/PLn3AMojiBKIjVices47FjJbN4PFn4YjhjtjuJIFKFceOX0CW1WSSQQpB+du31mSW
         emvMvJuLHFBLV3jHk4Bt7zrN1/vg9SR2G6YS2XxgxRpNaqr5t56iGrXCbXr7XTEonznL
         tJ3tRz0d8VXBZSE/uF+fI3Xx9Fm0mV7gz1gfQhiloa9JhX7D0qYLCAUK2TyPMN0/fCvV
         fANw==
X-Gm-Message-State: AOJu0YzaLy9jm1bJ88q0OhiZOMUyS8qMNfql5txW26HtgNL3ETgtz5gz
        EavVgm8yjebJjpDttmE1I6y50WMg6YjvZECyLfU+zrtUYLvd
X-Google-Smtp-Source: AGHT+IERdvXTN0zg2NK9HGOO67xq14GfcjLS9O8KCfPWx8VrJav+JpS5RMKQHJN1Q/BZPwTJBzxRvlw8ZbKcgAIWaJJjbOdOuFmy
MIME-Version: 1.0
X-Received: by 2002:a17:903:1d1:b0:1b8:d44:32aa with SMTP id
 e17-20020a17090301d100b001b80d4432aamr5528873plh.1.1693989994384; Wed, 06 Sep
 2023 01:46:34 -0700 (PDT)
Date:   Wed, 06 Sep 2023 01:46:34 -0700
In-Reply-To: <00000000000057049306049e0525@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de54840604acc740@google.com>
Subject: Re: [syzbot] [gfs2?] BUG: sleeping function called from invalid
 context in glock_hash_walk
From:   syzbot <syzbot+10c6178a65acf04efe47@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 0be8432166a61abc537e1247e530f4b85970b56b
Author: Bob Peterson <rpeterso@redhat.com>
Date:   Wed Aug 2 14:24:12 2023 +0000

    gfs2: Don't use filemap_splice_read

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1470c620680000
start commit:   3f86ed6ec0b3 Merge tag 'arc-6.6-rc1' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1670c620680000
console output: https://syzkaller.appspot.com/x/log.txt?x=1270c620680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff0db7a15ba54ead
dashboard link: https://syzkaller.appspot.com/bug?extid=10c6178a65acf04efe47
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e4ea14680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f76f10680000

Reported-by: syzbot+10c6178a65acf04efe47@syzkaller.appspotmail.com
Fixes: 0be8432166a6 ("gfs2: Don't use filemap_splice_read")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
