Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A98E723E79
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 11:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236597AbjFFJzk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 05:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbjFFJzj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:55:39 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93F0E60
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 02:55:38 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-777097126abso316154839f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 02:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686045338; x=1688637338;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vHp7JhKpOLftA8ijBU5NEW0PH0Y4Ly54QRDLuuH98wQ=;
        b=cRCsKXaMqy9iAv1tnYoBkf51zITCuW6ut1EX/9c7eapDJF+9+7o+jdwNPJ8nnJleSa
         2naqud6lWTA/Q97adWC/g1F6Ats4pQ7kbi9ekexYiPCOJCrPV8wDuwkDupm+sXRtg16x
         XeV4ytntdcCTQKDtS1BY8ozxDzuU6XO5W3h4FTmTVDhbpdKPCvfdSri150sLl80R9eLU
         ulcS/QY6sQ0nL0bOMyvc+9keu9rGhHH3pk9RbBR9xdkcFVX/xqFXC+ZBI4Z7dwoEiOaK
         l3beL0DQ02K0CWG9fnoxNQH/I6CVa/46k4MSCVzechbhrE/+XUy69wzDvINMcoSFLvBw
         mSAg==
X-Gm-Message-State: AC+VfDyWCf9AZmUAKDL1itC0fO65GSvD/EY7Bq65KWIFc64FaQvGpmN1
        aFt3HUjAlklyWtAiSEj9fYVVdf/E68jAudf3OmfxBLPjyeSC
X-Google-Smtp-Source: ACHHUZ6WLTcSDIIq1Kv0DMf4wTAm/1RJtlgXs9qRg8KIjuul16D89Csl9JRYFik6L8c4tUMMHqhwzA7cfC+KOGAhKoYpVXcRG3M1
MIME-Version: 1.0
X-Received: by 2002:a02:620e:0:b0:41e:7fef:24ea with SMTP id
 d14-20020a02620e000000b0041e7fef24eamr799123jac.1.1686045338103; Tue, 06 Jun
 2023 02:55:38 -0700 (PDT)
Date:   Tue, 06 Jun 2023 02:55:38 -0700
In-Reply-To: <00000000000002eb8105f51cfa96@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073fb7305fd730525@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_ioctl_add_dev
From:   syzbot <syzbot+afdee14f9fd3d20448e7@syzkaller.appspotmail.com>
To:     chris@chrisdown.name, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiaoshoukui@gmail.com,
        xiaoshoukui@ruijie.com.cn
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit ac868bc9d136cde6e3eb5de77019a63d57a540ff
Author: xiaoshoukui <xiaoshoukui@gmail.com>
Date:   Thu Apr 13 09:55:07 2023 +0000

    btrfs: fix assertion of exclop condition when starting balance

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12bdc3a3280000
start commit:   04a357b1f6f0 Merge tag 'mips_6.3_1' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f763d89e26d3d4c4
dashboard link: https://syzkaller.appspot.com/bug?extid=afdee14f9fd3d20448e7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f043b0c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d2ea9cc80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: fix assertion of exclop condition when starting balance

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
