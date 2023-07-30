Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBCF76860E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jul 2023 16:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjG3Oem (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jul 2023 10:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjG3Oek (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jul 2023 10:34:40 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D0810B
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Jul 2023 07:34:39 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a5ab2d29bbso7591355b6e.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Jul 2023 07:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690727678; x=1691332478;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWEs9tBxQ1qd6Nv15hqv+sQ9Wsq7wE6UQ0dhzWGDEw0=;
        b=kYBvw1AirRsVzZO2ZpwV5+UenVJqVTrxxffdc1xKNZdkq1iOOHHvQuBFP0INwgqdBT
         zHZhpN71UkmKsiqRR3UCdMWirKOr6k2IbfhvGHn4mSl1rBbI5Cl6sfj5BskSAS0zf6mB
         K61s3aVEWJTSbWG4IBE13JtfcwAYoouGj0zzs0vNYUiFhiXvtdYGWOIFqq3hovdcD1Fm
         bRoetLAXIVFk8ZjxuLIXeUlWC3Cbzb+g0/9vtLSsw88LadQDOsEM6pG6MXXOuqYmcMcV
         jk/2khiev5gtA1NIcRXDzv4vR35W7OUwm6hQEIVaDtLhhkXtKxl0EkaYd7oV1j5xwRlf
         ctYg==
X-Gm-Message-State: ABy/qLa9KSUsTJfz+zuYH+iHEaU9T+w/myvATz1YHpHq0g4lHFoqI6vF
        0PYlY6g6FS+j2E6Z6pjrwvNYic1vZTU7V73Vgm/uHPiShELX
X-Google-Smtp-Source: APBJJlHlZeRsJhA1JwC+Vdmu+N9LIUtZDdY44VIw8JRBKBvwAYj1K34PoqnTCgPrj4fdOUK92lFjeE0YyPKsMBKChX5FPGXNgJdc
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a18:b0:3a7:2d4c:5d34 with SMTP id
 bk24-20020a0568081a1800b003a72d4c5d34mr1839695oib.8.1690727677890; Sun, 30
 Jul 2023 07:34:37 -0700 (PDT)
Date:   Sun, 30 Jul 2023 07:34:37 -0700
In-Reply-To: <0000000000003b7fee05eec392a8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7178a0601b5366f@google.com>
Subject: Re: [syzbot] [reiserfs?] [overlayfs?] BUG: unable to handle kernel
 paging request in take_dentry_name_snapshot
From:   syzbot <syzbot+90392eaed540afcc8fc3@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 1784fbc2ed9c888ea4e895f30a53207ed7ee8208
Author: Christian Brauner <brauner@kernel.org>
Date:   Fri Jun 16 12:53:58 2023 +0000

    ovl: port to new mount api

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12561bd9a80000
start commit:   8395ae05cb5a Merge tag 'scsi-misc' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=85327a149d5f50f
dashboard link: https://syzkaller.appspot.com/bug?extid=90392eaed540afcc8fc3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16199460480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1797f274480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ovl: port to new mount api

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
