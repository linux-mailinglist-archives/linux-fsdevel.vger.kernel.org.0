Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B84767C9E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jul 2023 08:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbjG2Gpm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jul 2023 02:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjG2Gpl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jul 2023 02:45:41 -0400
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1B649C6
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 23:45:40 -0700 (PDT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-56c8ddbef94so280247eaf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 23:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690613140; x=1691217940;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qGOhGAeloc0ER8DTdip8+6IYfd63nwLytJCLHZfTBZM=;
        b=XGGCpRJw3gJIZwSvFG7+pPLpnRK47aIhIaQCOl9QsQwFnQ8P8ApziEhDRY7QXUEWhK
         SyNzVAJ1ueFjXOdHYZbAhEWFxE/kJutDfU3qZGLO40BXiY+GYCUGCQu4J9F4IW8SbmwY
         MBmCuOjPYvKhxs6+Y8MRvdLeXQ7Bjj5V2cN0ekXtSqIVN/3vkQZBUzck9Hpb9aqzrkyN
         55J8jDp6DjH78JHBdZRSJuBN1NAPVb+HwqNAbN0FokgSu0SwuFaxJ8M6mAYksmHoGA9G
         SRmPxA4aatpUgJjDhechCn+dZ2mi+dEbLdGcVPhXZtCeFStdM54PWPUymZN3rFT5UDss
         20AQ==
X-Gm-Message-State: ABy/qLYa1q6v1Il52Ir022Z7ulx/uW6JO3+Rl6DfnMZ33urCigGv9bT+
        egku7XlDGz71B47BRWgy20EqmJrPXkjfuNNoPFvGOP0VYpGE
X-Google-Smtp-Source: APBJJlHwLTxpTJNSenB84vLVZ9OaJaEUnFnE9thy0ErKec7kAFIgkLUe1lyCMQodE27Qm2+Jj+oY4fu1hQc9HW4pI0ZXAEmepcYX
MIME-Version: 1.0
X-Received: by 2002:a05:6808:bd1:b0:3a3:df1d:4369 with SMTP id
 o17-20020a0568080bd100b003a3df1d4369mr8654851oik.7.1690613140148; Fri, 28 Jul
 2023 23:45:40 -0700 (PDT)
Date:   Fri, 28 Jul 2023 23:45:40 -0700
In-Reply-To: <0000000000003ba9f506013b0aed@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000abd72906019a8b04@google.com>
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in ntfs_read_folio (2)
From:   syzbot <syzbot+913093197c71922e8375@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        clang-built-linux@googlegroups.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
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

commit 6e5be40d32fb1907285277c02e74493ed43d77fe
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Aug 13 14:21:30 2021 +0000

    fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17a1cbd9a80000
start commit:   bfa3037d8280 Merge tag 'fuse-update-6.5' of git://git.kern..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1461cbd9a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1061cbd9a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4507c291b5ab5d4
dashboard link: https://syzkaller.appspot.com/bug?extid=913093197c71922e8375
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b8869ea80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149e6072a80000

Reported-by: syzbot+913093197c71922e8375@syzkaller.appspotmail.com
Fixes: 6e5be40d32fb ("fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
