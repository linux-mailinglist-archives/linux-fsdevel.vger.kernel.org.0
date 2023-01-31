Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F20B6828CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 10:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjAaJ11 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 04:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjAaJ1U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:27:20 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6FFB457
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 01:27:18 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id 9-20020a056e0220c900b0030f1b0dfa9dso8989110ilq.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 01:27:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=baRMDYfh/xlZwZGAG0yWHlpzuwaFuMZN9hC0V7iVjuc=;
        b=bVxvO2V7/vy0odHHGYkATViLP8lRK3s8XYCYQ9DoOnXwPtGCgy93M/Fm2ujKBhCVqv
         /WrEV8jldb5grAaecro5Wngjjse1dTM5aOPuPTuER/GY4VzuWc/tRM1NIyl7OIH7fYJ/
         RmXFWqSSXCEK5CnnWvKILXv9kYwyCKPaY1MfLJCz+MexH6mHoZtIiTywmQWHp7/1mHmf
         Wty0hcodXMA+H8ctSYgTaUNjUMw9Jd5rltYN5IdCNs1Gs7bj9NkzjRoV5vxqF/Y/ogEe
         /avwTFBIS5dw8oot0qKHnN5Yet1H/S97oV9mynoVhCmBGG/285mcybbGw7QjE5QGgc9x
         xTWw==
X-Gm-Message-State: AO0yUKUtGTGEeBauGTKA+pGNl28A5VIq7imMnqbtOZrk1p0rgaAEuFaq
        BSBoL8hPoao6MU9HJEDYsIJZTTgmsQon61gAERNTWYB4UAF3
X-Google-Smtp-Source: AK7set8u4spgzHnLNJ4gN0tBiiWYVG3rnp0zIzeRaLeYX+acTnMe57OUFWUYS0D9NU/MPHWLIEUKjPHw+7whQBTcaEL3mtKntMHa
MIME-Version: 1.0
X-Received: by 2002:a92:3f04:0:b0:310:d43c:edf1 with SMTP id
 m4-20020a923f04000000b00310d43cedf1mr1923200ila.34.1675157237600; Tue, 31 Jan
 2023 01:27:17 -0800 (PST)
Date:   Tue, 31 Jan 2023 01:27:17 -0800
In-Reply-To: <000000000000d7eced05f01fa8d0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000171a2805f38bf07a@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in mi_find_attr
From:   syzbot <syzbot+8ebb469b64740648f1c3@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com, edward.lo@ambergroup.io,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12e74535480000
start commit:   e2ca6ba6ba01 Merge tag 'mm-stable-2022-12-13' of git://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6133b41a9a0f500
dashboard link: https://syzkaller.appspot.com/bug?extid=8ebb469b64740648f1c3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fb2ad0480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164513e0480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Validate attribute name offset

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
