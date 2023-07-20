Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E60275AB41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 11:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjGTJrT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 05:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjGTJrA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:47:00 -0400
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FF746B1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 02:43:32 -0700 (PDT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1ba5121da9eso1066018fac.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 02:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689846212; x=1690451012;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AtuOdSqNbgGRrQ4RyX6Oh0ojmgLRz9ibZzyYyyxuS7Y=;
        b=N/Zd4gAlagQLPovLj1bF/uWADM0PWt+/IZuImujtloL6mi5hnej+p7OFUPyR46Qz/8
         ZNd81sJdv+f3zW4CtUZrXDqRu44Kx8WwqMOJJYEBAIwxN0jMXxV3d6qfNJYetypzhb3n
         lsQeyJ7brJvjBUloPGcFgaJIYAs9b3ezZN9do+3/p8BMmXVhLjDOvG1Ob3w4XzM8qJ69
         s0BVfkd5nPYYE23wN4Dh3lI2is6x6wlreTcq41SYt3tp0ERMwfPncM4rhYAbywMWAMG5
         B44HRRQP3OPKq7HQxxuUGZk1nW8/rDxI6ySF8k3hPC1Slu27tfv1UFGGIbzplIKv2Aom
         1flw==
X-Gm-Message-State: ABy/qLZABLhA1tMEEQ9u8FA6aBpDUc688INMH2AtDXvQWs0HsKYT0PAb
        SYJw30Os8Tl9HJVCUgwTMHetnqlZt/JCBPKDdHkpzZNX5nYr
X-Google-Smtp-Source: APBJJlHj+sm+RhGxiKBgueO9NtIcAmz/WBnUqihTIl5YnPT7STYwDvugY6ku9PGuCiOOSMlHo92mYsUYUkT5ZZ5Oxz3KNtmkclid
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5ab4:b0:1b0:4408:84a2 with SMTP id
 dt52-20020a0568705ab400b001b0440884a2mr1486020oab.4.1689846211877; Thu, 20
 Jul 2023 02:43:31 -0700 (PDT)
Date:   Thu, 20 Jul 2023 02:43:31 -0700
In-Reply-To: <000000000000f7b82505e9982685@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002f22130600e7fb01@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in assertfail (2)
From:   syzbot <syzbot+c4614eae20a166c25bf0@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        wqu@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 745806fb4554f334e6406fa82b328562aa48f08f
Author: Qu Wenruo <wqu@suse.com>
Date:   Sun Jun 11 00:09:13 2023 +0000

    btrfs: do not ASSERT() on duplicated global roots

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16d92676a80000
start commit:   830b3c68c1fb Linux 6.1
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=26d9ba6d9b746f4
dashboard link: https://syzkaller.appspot.com/bug?extid=c4614eae20a166c25bf0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14078087880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1403948f880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: do not ASSERT() on duplicated global roots

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
