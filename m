Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2876E6AA633
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Mar 2023 01:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCDAYa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 19:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjCDAY3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 19:24:29 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034E1367F7
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Mar 2023 16:24:27 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id k13-20020a056e021a8d00b0031bae68b383so1095297ilv.18
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Mar 2023 16:24:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZYmyZcEFeCrpiQdyta3UENL3SqrmhwvXMRdTdLZxLU=;
        b=Dw3e+sCkrKk3dZ3W9D09imey2qlH1riUVBZM3V3K4oMLgLhV+fiBXRYPEGRmro8Ggx
         mSxY7CB/hsob5e6knuPATpCHVkN98RgKGni7vNVIT2TWoJfQCK3NCQR9IfvCSdbn3X1k
         9q1tYzC2sqtkdZUkR8SDfaezMAF9tR60SQz0m73gKyM9rP1Lys75H8Zqvo6YEKd/7qbp
         hOu1lzmSeVRx1nMyRi8a1zz0UxsnowvWQKtMzyOLHZ0VF/0NGvQd3c5WtkiLeNBuPOvR
         NSbdBlhWn4c0CBn70mAHHXcxIZA3VbbmREbsbTMihCP5ViefX9H4G3w7oQ02q2su/7I7
         tWow==
X-Gm-Message-State: AO0yUKUWPcynm5XudjgNdyJRIN1EbROPjqtQRkgWH8oR+HJ82gWLm1W0
        1H2iOFUJmDY5V/2KlHeuuqWSHbUqCYMXLQmSJdMCsPFjm+KZ
X-Google-Smtp-Source: AK7set8lUEUPhNB1YHgN5ADW4DD1Pqs+xKieEI7h+pTBvr4zCVYoG0kIoZ7cSEJvk0tCug/77ditPeuKPIbWMZnEGQ1uyIKvf65b
MIME-Version: 1.0
X-Received: by 2002:a5d:93c1:0:b0:74d:5a9:b55a with SMTP id
 j1-20020a5d93c1000000b0074d05a9b55amr1580274ioo.0.1677889467347; Fri, 03 Mar
 2023 16:24:27 -0800 (PST)
Date:   Fri, 03 Mar 2023 16:24:27 -0800
In-Reply-To: <0000000000001544f005e381d722@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac777e05f6081529@google.com>
Subject: Re: [syzbot] [fs?] KASAN: use-after-free Read in kill_fasync
From:   syzbot <syzbot+382c8824777dca2812fe@syzkaller.appspotmail.com>
To:     chuck.lever@oracle.com, frederic@kernel.org, hdanton@sina.com,
        jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, rafael.j.wysocki@intel.com,
        syzkaller-bugs@googlegroups.com, tony@atomide.com,
        ulf.hansson@linaro.org, viro@zeniv.linux.org.uk
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

commit 69d4c0d3218692ffa56b0e1b9c76c50c699d7044
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Thu Jan 12 19:43:58 2023 +0000

    entry, kasan, x86: Disallow overriding mem*() functions

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17adfae4c80000
start commit:   972a278fe60c Merge tag 'for-5.19-rc7-tag' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cc990589d31f8d6
dashboard link: https://syzkaller.appspot.com/bug?extid=382c8824777dca2812fe
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141c2dac080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1590cfa4080000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: entry, kasan, x86: Disallow overriding mem*() functions

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
