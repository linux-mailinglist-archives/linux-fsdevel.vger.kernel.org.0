Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08ADB5A5794
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 01:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiH2XaW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 19:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiH2XaV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:30:21 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7F858DDC
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 16:30:20 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id bh11-20020a056602370b00b00688c8a2b56cso5600590iob.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 16:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=2YEU8MGiYyA7ikKAvgdFuLoxWCy3ALSR6+S8uCZED4Q=;
        b=bJejZnhNSjPmJujCi2bL41eBHG0MJmr/p1CJBpt5Q8yD76qzqJDwbC906gZnzo5zNb
         o4oNeCX2wcMa37+E3BYgwsSSuBuoZ+R1V/ZA/dhV27AkRSsOXlNNwlKkjX/Ja2WERhpK
         uaNb8sVIxCH1ZpFqogNMcj/18sUgfF5PtIoZgyjjgNFlUEauGbAKN0q3ai5e1CtUyGe5
         J52Fhi9Ls4xHS6q3Hs0hqRZJRsHysUynyALUlhQpxJKdZxjPPbS/TKKJ+eI+ojxmle5J
         L2oNSgpsSrBxDybLuUmTXU8ErPLItWZK/xcEgTAknhuVVTTRScUc36xVQt6/c+g9E4Np
         ps2w==
X-Gm-Message-State: ACgBeo2mmoB5mEJvTkDtKTReZEfBl0h1IXC0DtCJn1tBLbtlAN1WDDfH
        7qC0Yo86fIaoNP/Kvn3piD2EWD65Vk1CoBRbSC2HO6GFE/tr
X-Google-Smtp-Source: AA6agR6xVVuoLZ6/rTXKMNjxQX7n3CTsaH4W4fuQFpeteUbda0GnuX//1nO3ExzfAKYk4br6zsttFv8iij72pEhhc3oQfbYm8Ggm
MIME-Version: 1.0
X-Received: by 2002:a05:6638:371f:b0:349:cfb0:89a9 with SMTP id
 k31-20020a056638371f00b00349cfb089a9mr11317806jav.151.1661815819682; Mon, 29
 Aug 2022 16:30:19 -0700 (PDT)
Date:   Mon, 29 Aug 2022 16:30:19 -0700
In-Reply-To: <0000000000009a318805e6ff48a4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d4ad705e769a5c3@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference in ni_find_attr
From:   syzbot <syzbot+69d15cab6309bffae739@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1458787d080000
start commit:   8379c0b31fbc Merge tag 'for-6.0-rc3-tag' of git://git.kern..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1658787d080000
console output: https://syzkaller.appspot.com/x/log.txt?x=1258787d080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=911efaff115942bb
dashboard link: https://syzkaller.appspot.com/bug?extid=69d15cab6309bffae739
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110d306d080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17409333080000

Reported-by: syzbot+69d15cab6309bffae739@syzkaller.appspotmail.com
Fixes: 6e5be40d32fb ("fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
