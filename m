Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABF76B5234
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 21:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjCJUxm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 15:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjCJUxk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:53:40 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E50FD461D
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Mar 2023 12:53:35 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id j24-20020a056e02219800b00322f108a4cfso215743ila.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Mar 2023 12:53:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678481615;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PMB/Bp6i/Q7Jf3FSJY4xm55f2UsK69n5jbmE0xmzr4M=;
        b=skfa0nzpQYmP2z1HdjDSsMeqLlzxcl/svoYd5GpGZ4wgDo7edCaUFPOUre2MRFTCLz
         xI7MjcUIJnDcBUigavcuPHYEcF/juQNZSqPXx3C/+htPldd3TWrSCe+KNeG+0s7x24KW
         D2bcw9ZpX3qwbxwgiWwX6Cx9MluFhS0ltr9G9S2nd5pzxU3WlOm0B2mQD3jlUub9pQF+
         UlzsRCAduDfbORVQwMFatOqd5IzYdx3m5ormdrqUI+NFrsCQ3OfiD2VDFe8NuDdTNMUr
         LdtbJs/rfuLnY54osq1csUVGUPWAhBVULbW/KkO2Af4ux5Yv3w8axrLNNmlMeXKaUB5B
         QTCA==
X-Gm-Message-State: AO0yUKVDKt9Ks4WRXIwEkiq/zd/7m72FRRTc7vyIBm/AapYyNz28vBLe
        mthvVRjtMutOlVDypI3221EzYwQADcoql6tuszv5fgS0x6b8
X-Google-Smtp-Source: AK7set9523d3PJoqOfR2jEMGN0JGPyrp3GPsfgPrueAkojOmuzZ/Lc+Gh00c5VF4ZxpG5/AcRFQhRemv9BGvgc9A0DHDXETLa/gz
MIME-Version: 1.0
X-Received: by 2002:a6b:6a0a:0:b0:745:b287:c281 with SMTP id
 x10-20020a6b6a0a000000b00745b287c281mr12293597iog.2.1678481614899; Fri, 10
 Mar 2023 12:53:34 -0800 (PST)
Date:   Fri, 10 Mar 2023 12:53:34 -0800
In-Reply-To: <0000000000008af58705e9b32b1d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006b11b005f691f4b9@google.com>
Subject: Re: [syzbot] unexpected kernel reboot (8)
From:   syzbot <syzbot+8346a1aeed52cb04c9ba@syzkaller.appspotmail.com>
To:     alexandr.lobakin@intel.com, dvyukov@google.com,
        jirislaby@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, miklos@szeredi.hu, mingo@kernel.org,
        nogikh@google.com, penguin-kernel@I-love.SAKURA.ne.jp,
        penguin-kernel@i-love.sakura.ne.jp, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 7734a0f31e99c433df3063bbb7e8ee5a16a2cb82
Author: Alexander Lobakin <alexandr.lobakin@intel.com>
Date:   Mon Jan 9 17:04:02 2023 +0000

    x86/boot: Robustify calling startup_{32,64}() from the decompressor code

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14606624c80000
start commit:   1fe4fd6f5cad Merge tag 'xfs-6.2-fixes-2' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=edc860b1c9b6751
dashboard link: https://syzkaller.appspot.com/bug?extid=8346a1aeed52cb04c9ba
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12baac4a480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118bf42c480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: x86/boot: Robustify calling startup_{32,64}() from the decompressor code

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
