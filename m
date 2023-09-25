Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E0C7ACD85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 03:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjIYBPj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Sep 2023 21:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjIYBPg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Sep 2023 21:15:36 -0400
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7EFDF
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Sep 2023 18:15:30 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1d711697ae1so12879534fac.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Sep 2023 18:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695604529; x=1696209329;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4mXWJ2scKUEqPcEEGulmmGomgjLYP4kOCRMwILx6WjM=;
        b=wUKjqUUY2PnUaIjzm2xFlwcAYWkPQ7qXcRbE+q5MAib6kaaZ8zoBODDcdgLv+dvf/M
         XUR2riiHux9twGUai+X8s0BM8iL34rEbr+UnaKhWwdOcDi+KqAPppOm73NNCMoWn4mBV
         uwgQ0RuP1If4WO+YwdKWcQiWfWjUzvluzbzvoemm2folzJomAzbV4QIEWzUILoNmeZZf
         ZZ0oZgcoEvz6uaRgHKp/V3g/SxFgGD/xFjiwz2uOiZGnwysAZ0tRp/6L61bXdfBhFzq0
         hTZXn5i1ORC3kPGJVo5Nn/pW+FrDrb8GC45crhUjlgq/AZsSeJ7geOFIHwXr4yvqe/oD
         momg==
X-Gm-Message-State: AOJu0YzGlxNziElchWuqZ3HV3O60k7Zmx9NiqMyBzJv9ty9WiVS5zwFJ
        WIKb5JUm2U3yq1TfuIw4iUG9hhoIYr0pSd+Svso/kkEc3pxL
X-Google-Smtp-Source: AGHT+IF6nxODDAWNMD07YfAui7+hnaCMUlIRnLJLybEVpTbxyqHjKCZhNlNu46gm9+8ZaK3c7DNMoMAxqe1/vdlWNrzEyOcoatqc
MIME-Version: 1.0
X-Received: by 2002:a05:6870:64a1:b0:1dd:69a:665d with SMTP id
 cz33-20020a05687064a100b001dd069a665dmr1574583oab.3.1695604529067; Sun, 24
 Sep 2023 18:15:29 -0700 (PDT)
Date:   Sun, 24 Sep 2023 18:15:29 -0700
In-Reply-To: <000000000000b782b505c2847180@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a27dcc060624b16e@google.com>
Subject: Re: [syzbot] [ntfs?] KASAN: use-after-free Read in ntfs_test_inode
From:   syzbot <syzbot+2751da923b5eb8307b0b@syzkaller.appspotmail.com>
To:     anton@tuxera.com, brauner@kernel.org, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux@roeck-us.net,
        phil@philpotter.co.uk, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 78a06688a4d40d9bb6138e2b9ad3353d7bf0157a
Author: Christian Brauner <brauner@kernel.org>
Date:   Thu Sep 7 16:03:40 2023 +0000

    ntfs3: drop inode references in ntfs_put_super()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1674a5c1680000
start commit:   3aba70aed91f Merge tag 'gpio-fixes-for-v6.6-rc3' of git://..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1574a5c1680000
console output: https://syzkaller.appspot.com/x/log.txt?x=1174a5c1680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4ca82a1bedd37e4
dashboard link: https://syzkaller.appspot.com/bug?extid=2751da923b5eb8307b0b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136b4412680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11aec0dc680000

Reported-by: syzbot+2751da923b5eb8307b0b@syzkaller.appspotmail.com
Fixes: 78a06688a4d4 ("ntfs3: drop inode references in ntfs_put_super()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
