Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AB27BD1DB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 04:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344949AbjJICFg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Sun, 8 Oct 2023 22:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjJICFe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Oct 2023 22:05:34 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F89AC
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Oct 2023 19:05:33 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3ae5a4f9954so6947597b6e.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Oct 2023 19:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696817132; x=1697421932;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cb8BJFOfJt/1KSmkcKeu7s/bXsY2CA0V26Ucc8VKgjw=;
        b=tOJ+34G6Ap7BldlpRivTLhZMyspgWpor8x+J3dlHEhDBFORythxwYyewBYxu44V9QV
         aboLN3R15i6Gx4EeAEu1p/v6+PM/0y10y6AXl0BqT7HDW5k9ZJDlynHkJck0WnNxunEc
         rL1r+riAJ07IzdFLTp9ASvyTQovyOrpxN2uSFxlUa4uXOh3A8sL7vq9xGtYVZq1a2Y29
         NY/y/Sma+X0z8TAT67elovCRe3wA1ak+QXc1O8npMtTxTB3+jW9lFNpRdPWC/Zg2tkcb
         ZIdzxwsalJ72SoQrqKxd0ZW0lskT+q+GEjbQeaMFw/mWhoFXffmiDtcYVcj3vPPhFeq7
         RFNA==
X-Gm-Message-State: AOJu0YwSol1/IWNDrwwS5HZ4jOsi7UwzMWw8egdIeYGwC8YKgdVzpuru
        2VQnSnSLgGN0LItCM3ASDZ/JC0/sUu+4BW6ih67ml+9ultZa
X-Google-Smtp-Source: AGHT+IELFqFN7QoMVYfsIY7r0QeAGPzrcev1WXJ9FLIcjCL1sovTwvIQxukZvcnCCdk9WKGEwgiUlAPYacJT+fS5YBjM7tUk1k16
MIME-Version: 1.0
X-Received: by 2002:a05:6871:3208:b0:1d5:a24a:c33 with SMTP id
 mo8-20020a056871320800b001d5a24a0c33mr5413341oac.8.1696817132668; Sun, 08 Oct
 2023 19:05:32 -0700 (PDT)
Date:   Sun, 08 Oct 2023 19:05:32 -0700
In-Reply-To: <0000000000001825ce06047bf2a6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071133306073f06ca@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in super_lock
From:   syzbot <syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, brauner@kernel.org, chao@kernel.org,
        daniel.vetter@ffwll.ch, hdanton@sina.com, jack@suse.cz,
        jaegeuk@kernel.org, jinpu.wang@ionos.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mairacanal@riseup.net, mcanal@igalia.com,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        terrelln@fb.com, willy@infradead.org, yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 7908632f2927b65f7486ae6b67c24071666ba43f
Author: Maíra Canal <mcanal@igalia.com>
Date:   Thu Sep 14 10:19:02 2023 +0000

    Revert "drm/vkms: Fix race-condition between the hrtimer and the atomic commit"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17fc0565680000
start commit:   2cf0f7156238 Merge tag 'nfs-for-6.6-2' of git://git.linux-..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14020565680000
console output: https://syzkaller.appspot.com/x/log.txt?x=10020565680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=710dc49bece494df
dashboard link: https://syzkaller.appspot.com/bug?extid=062317ea1d0a6d5e29e7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107e9518680000

Reported-by: syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com
Fixes: 7908632f2927 ("Revert "drm/vkms: Fix race-condition between the hrtimer and the atomic commit"")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
