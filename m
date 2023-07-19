Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CF8759472
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 13:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjGSLkX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 07:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjGSLkW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:40:22 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003D81FC1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 04:40:00 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3a41b765478so985362b6e.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 04:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689766770; x=1692358770;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vGmZ9/fDb9epDvOedOBs7HeR46EwNPEEK7sk+j6Kio=;
        b=CUW5pFaByBlVInKCAvmdMyEQoBjROwSOW5Gn/rgXxLvP9lKmvUh3qYaQjYcN3Wbi91
         Pv7JO2WKb81DeuzckQi8ivoDYXpKACOlwHrihhC6GSMH3c5RvzGm32+5cyeP2/Hd8DzR
         s7+EJJ53rjsPexZUUUf2nnZEEHc5Dsih0BpLlkqaxGXsO9g5h5FDY12vj4pEEx/Bzrgc
         g/mLXcdZ/XbX+ZRVvhVw1+kQSdRrJBy3PrFRFdMFbFpZdtpaYzzo6t0IK6ePzyrVtFxb
         fuzQ0RGjbqNqyF3+wMpiV55wZJrvFClzVvorOh8SRgV4sslvWn411PZNxjpd+Vwa81JI
         9Miw==
X-Gm-Message-State: ABy/qLYnTrcNr7JSDRJy6jeMbLKC1JJkS7wb5ULQcLV7UDJnh2rc6sHk
        nQZZBci5TE7YljAhI1MhXkljR2cDmj9mOqKufW2QbhHYrDfX
X-Google-Smtp-Source: APBJJlHVcNkxZiOgTQ8esKMapxANI5L22BOi8in+N+miz/kb77z2U5OyIOT1jLZTT/rIepP8GTCXchunn8fJhay0LPEwt6P5G282
MIME-Version: 1.0
X-Received: by 2002:a05:6808:190f:b0:3a1:ee4f:77ce with SMTP id
 bf15-20020a056808190f00b003a1ee4f77cemr3849967oib.1.1689766770301; Wed, 19
 Jul 2023 04:39:30 -0700 (PDT)
Date:   Wed, 19 Jul 2023 04:39:30 -0700
In-Reply-To: <0000000000007cfb2405febf9023@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000018e0570600d57cdb@google.com>
Subject: Re: [syzbot] [ntfs3?] BUG: unable to handle kernel paging request in attr_data_read_resident
From:   syzbot <syzbot+33a67f9990381cc8951c@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit ad26a9c84510af7252e582e811de970433a9758f
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Oct 7 17:08:06 2022 +0000

    fs/ntfs3: Fixing wrong logic in attr_set_size and ntfs_fallocate

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=143dfc66a80000
start commit:   74f1456c4a5f Merge tag 'linux-kselftest-fixes-6.5-rc3' of ..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=163dfc66a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=123dfc66a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=77b9a3cf8f44c6da
dashboard link: https://syzkaller.appspot.com/bug?extid=33a67f9990381cc8951c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15619a3aa80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12288c1aa80000

Reported-by: syzbot+33a67f9990381cc8951c@syzkaller.appspotmail.com
Fixes: ad26a9c84510 ("fs/ntfs3: Fixing wrong logic in attr_set_size and ntfs_fallocate")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
