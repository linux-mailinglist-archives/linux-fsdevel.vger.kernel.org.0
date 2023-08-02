Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A5176C190
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 02:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjHBAlb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 20:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjHBAla (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 20:41:30 -0400
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807C826BD
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 17:41:29 -0700 (PDT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-56d0d5cc3c1so534304eaf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Aug 2023 17:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690936889; x=1691541689;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WABMdNDsk2eKFUUAkeI7Ocof8Yl4v6UX9gv6D1RsRaw=;
        b=FF1KAbaJTwfuyv/fev7Yy+5b9ACyhw7MRhZ4ZY6oMjc3ZliJR3MKyuow6oYr8++Ovo
         M3nttqSUk37PLR5vyMuq+0stSFLY8resyYZt2fKC9zhZPzzZbGIM/4gxu96F6yfWpdrv
         tRUmiJQqO6vxt8HMPS/h4IPj3dy2JFUibf/6rUYpwmClRCzDkkizra38IkHH0QKQxEG5
         5cZl1MOEX8cklEgVrpLnH+7U5h8klKdebE0PeLpdfD+ltgoREokZiboXKeM7wdyu3QWu
         34dpoDmNXUZI9aJRg/IZTwFaXcaAM3kMMKP5sRSMsIh9VAxV59q/b3gopjdlLcqCFRUA
         XUdw==
X-Gm-Message-State: ABy/qLbK5ROMifhTh28wzFsnb+Zn4YtS+E/hlpktPEo9bzhO4Ir3HAkP
        I6Qt1uDIS/+2PobA4o3XiibazykRSlvyiVsXzmsgKWLdTuzI
X-Google-Smtp-Source: APBJJlFQW+TRmXKLL5dj1QeoJGESZy5rKFukawpB/6nElzZkSNSLCrJdElPKM37Io0fUi+qlPCAjHnqQvn862R2jq/ZKOXXa4643
MIME-Version: 1.0
X-Received: by 2002:a4a:ddcb:0:b0:563:3a11:7c9a with SMTP id
 i11-20020a4addcb000000b005633a117c9amr16940166oov.1.1690936888877; Tue, 01
 Aug 2023 17:41:28 -0700 (PDT)
Date:   Tue, 01 Aug 2023 17:41:28 -0700
In-Reply-To: <000000000000af3d3105ff38ee3c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000099695a0601e5ecfb@google.com>
Subject: Re: [syzbot] [f2fs?] general protection fault in f2fs_drop_extent_tree
From:   syzbot <syzbot+f4649be1be739e030111@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 458c15dfbce62c35fefd9ca637b20a051309c9f1
Author: Chao Yu <chao@kernel.org>
Date:   Tue May 23 03:58:22 2023 +0000

    f2fs: don't reset unchangable mount option in f2fs_remount()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12461d31a80000
start commit:   a92b7d26c743 Merge tag 'drm-fixes-2023-06-23' of git://ano..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cbd298d0aff1140
dashboard link: https://syzkaller.appspot.com/bug?extid=f4649be1be739e030111
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1564afb0a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=166928c7280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: f2fs: don't reset unchangable mount option in f2fs_remount()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
