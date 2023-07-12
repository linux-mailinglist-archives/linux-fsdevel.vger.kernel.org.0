Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91347510C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 20:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjGLSyh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 14:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjGLSyg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 14:54:36 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAF91FC0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 11:54:34 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6b86d2075f0so8425326a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 11:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689188073; x=1691780073;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZMH+f/qQs35ft7PcSxeJWZ8yv3i3Olk8Bn6x6Aux/0=;
        b=Xx4MNlhlxVH/670UTDSvQpFKLzZC1GY/KpgNCca5hoyuSTCg7+41bAkbGwtFnrX6Zl
         ZNXzE3b1pRzhPIuNLDRCjk8/hjBQZawPuU9VVYko08PCDB1tdgDEnSOkhZv/ZbUd0Qso
         XqQDKA5xZVAD0fkOCh9sbUKdvOMw2kMEFxsv02tBxreZnukIec+R3XZTct9qTogIV0c5
         v851QH3wQ0bVEVD/zg0hTJV1tQ8Jqw/YzCQFAWF13TGYV66C+0aKDRKmSeI5sxBKlnoh
         mKK9bTkTpfdFTNhUqMqDK2cj1/1yA6S7H5YMjSNL0ZX88siVbr/+chplB7/XVZsdwcmh
         EuTA==
X-Gm-Message-State: ABy/qLZpOcQ+Db5/DkXUf01ERDpISw2IIwc7m6lPFmVpeV1ptXdNTD8r
        xiKzdQcaXEZPothWLKJ2Ck2h4/pi6z9JHg6ljJM4wTVf38zp
X-Google-Smtp-Source: APBJJlFsJIcb0rdx4JjgRS1wq5NhoTjU9MPmFzmv1EP3Vle1AIKr62xgl7dheKEiVE6GkXdOnIQBkcJkfp2R0puLgy6N5pzwWkeT
MIME-Version: 1.0
X-Received: by 2002:a05:6830:2056:b0:6af:a3de:5d26 with SMTP id
 f22-20020a056830205600b006afa3de5d26mr6113119otp.7.1689188073476; Wed, 12 Jul
 2023 11:54:33 -0700 (PDT)
Date:   Wed, 12 Jul 2023 11:54:33 -0700
In-Reply-To: <000000000000881d0606004541d1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001416bb06004ebf53@google.com>
Subject: Re: [syzbot] [fs?] INFO: task hung in pipe_release (4)
From:   syzbot <syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
        dhowells@redhat.com, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 7ac7c987850c3ec617c778f7bd871804dc1c648d
Author: David Howells <dhowells@redhat.com>
Date:   Mon May 22 12:11:22 2023 +0000

    udp: Convert udp_sendpage() to use MSG_SPLICE_PAGES

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15853bcaa80000
start commit:   3f01e9fed845 Merge tag 'linux-watchdog-6.5-rc2' of git://w..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17853bcaa80000
console output: https://syzkaller.appspot.com/x/log.txt?x=13853bcaa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=150188feee7071a7
dashboard link: https://syzkaller.appspot.com/bug?extid=f527b971b4bdc8e79f9e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a86682a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1520ab6ca80000

Reported-by: syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com
Fixes: 7ac7c987850c ("udp: Convert udp_sendpage() to use MSG_SPLICE_PAGES")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
