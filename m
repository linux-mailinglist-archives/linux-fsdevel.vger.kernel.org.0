Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1DB69BD7A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 23:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjBRWQY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Feb 2023 17:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBRWQX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Feb 2023 17:16:23 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA6811E92
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Feb 2023 14:16:22 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id b15-20020a92db0f000000b003033a763270so747647iln.19
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Feb 2023 14:16:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHsGASxn4uSpXV+2HTVe0iufvQ5emn00jv5p2JD41NQ=;
        b=NcHgaCQfCgWVzRULJwyTVseRe2Z3l2Ha8JKp6lAbMJkhatvUM76gALa+umB6/1Rq0+
         5glMdjhQKZyqSyTniviYV0dB4qJutKGeijlBq5vbs4uHGlFEGFLSSK37zMJREeS6N9iY
         9lCIaRWDW6Z/NGb9L2K2Yt9BU4IPpVSlV/APsi6WKoRhIU1RCuBv6QHgorwrCHTM7q6v
         wIBb+BpwMPcOUI5YFuNLFVhKBtzXzkae2ry4BtfOBeyzUvNTvAkghH76pNayMhp4BMZz
         kBIgJ8woO3GF67FTTxnrtcv6KoUWlmr8ez/ULgjGCKCB4QuOpGJh8dkWS46u7Z/QoHuq
         786A==
X-Gm-Message-State: AO0yUKWGw0xCqBMVcV0YMwMAZ/ZQHMK8wKGxZOUVG204HXMN2jXzL9tj
        vS+aa/8IWbjBZPRLuti+yojzoU+JfRuHDw0KhreRFOQAKW6g
X-Google-Smtp-Source: AK7set81YNapfqNQN/UzWAcnjhBZNW5cOTuUpKTrlryiSRsou7OkgLiS8ErPWr/uxepSxYs5OQH2sbSHGA092OPmq/y0k9QkOI3p
MIME-Version: 1.0
X-Received: by 2002:a05:6602:c:b0:718:b11d:a972 with SMTP id
 b12-20020a056602000c00b00718b11da972mr1403521ioa.36.1676758581499; Sat, 18
 Feb 2023 14:16:21 -0800 (PST)
Date:   Sat, 18 Feb 2023 14:16:21 -0800
In-Reply-To: <0000000000008f00f7058ad13ec8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009fddba05f500c785@google.com>
Subject: Re: [syzbot] [net?] [ntfs3?] KMSAN: uninit-value in bcmp
From:   syzbot <syzbot+d8b02c920ae8f3e0be75@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com, davem@davemloft.net,
        edward.lo@ambergroup.io, glider@google.com, idosch@mellanox.com,
        ivan.khoronzhuk@linaro.org, jiri@mellanox.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, ntfs3@lists.linux.dev, petrm@mellanox.com,
        phind.uet@gmail.com, syzkaller-bugs@googlegroups.com
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

commit 4f1dc7d9756e66f3f876839ea174df2e656b7f79
Author: Edward Lo <edward.lo@ambergroup.io>
Date:   Fri Sep 9 01:04:00 2022 +0000

    fs/ntfs3: Validate attribute name offset

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=149cdbcf480000
start commit:   b7b275e60bcd Linux 6.1-rc7
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=d8b02c920ae8f3e0be75
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164c4a4b880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=152bfbc9880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Validate attribute name offset

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
