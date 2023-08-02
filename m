Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B8276D1E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 17:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbjHBP1q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 11:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234336AbjHBP1b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:27:31 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9AF4C12
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 08:25:14 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3a5b891b4e8so12008291b6e.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Aug 2023 08:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690989868; x=1691594668;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/xHSfiG3E7HaC8jNHVxDotiCnXbEHNk8zmRylg8nEY=;
        b=eV8xIXQIosSsIYUMwTIfwDQ6dO6XVYJRZ4gQEk8BCPuDJETLA/UoNlVtScOr5+E2CP
         +/OiA3W05mbfIIYk1Vk0ZTet9lI0aiJWvVompCYkcgjhZvt9X3NZulKBq79YBH7ajbdk
         iDZGVD+cmGLaMrbIfL9tjRSPofx0R5mtLEJqHp0eQYgnT+ae0AnRuMFvZkSVmhhgk48O
         T4btSfokOs2+otdjQ7+819Q5rWT6HD02vWSjBhFrqFbAYEeRJASTTwI54LHcmXryzbW3
         rferzyxqlNjlX/fZmINbqb2knoahFwFlmgrWbmzBLuCKs5KyTuo/f8c/jR1sHLTfwoqt
         my9Q==
X-Gm-Message-State: ABy/qLbevlUKMOZpishMfyoEjxW8LiCj+KygbVf5LX01vBVYPWe/kXuh
        GArWSN0Z8gRR/NBfUFaHCocpsgGiomHCov+/XkQcYgHDrEHN
X-Google-Smtp-Source: APBJJlHU0WeUCbqnQs8zsRopuGrmVyWbNrSUF3np4ZkkweFSzWejKwIUs5LnnM7Oa9NOViGy8XUCpcAuAyrQpG9pi4TUeByF1XUT
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1511:b0:3a1:ed05:198 with SMTP id
 u17-20020a056808151100b003a1ed050198mr26676639oiw.2.1690989868016; Wed, 02
 Aug 2023 08:24:28 -0700 (PDT)
Date:   Wed, 02 Aug 2023 08:24:27 -0700
In-Reply-To: <000000000000117c7505e7927cb4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000066e89c0601f24249@google.com>
Subject: Re: [syzbot] [ntfs3?] UBSAN: array-index-out-of-bounds in truncate_inode_pages_range
From:   syzbot <syzbot+5867885efe39089b339b@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org,
        almaz.alexandrovich@paragon-software.com, davem@davemloft.net,
        dvyukov@google.com, jiri@nvidia.com, kuba@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, vishal.moola@gmail.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit d772781964415c63759572b917e21c4f7ec08d9f
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Fri Jan 6 06:33:54 2023 +0000

    devlink: bump the instance index directly when iterating

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=129893bea80000
start commit:   e8bc52cb8df8 Merge tag 'driver-core-6.1-rc1' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7579993da6496f03
dashboard link: https://syzkaller.appspot.com/bug?extid=5867885efe39089b339b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=153137b8880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123cae34880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: devlink: bump the instance index directly when iterating

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
