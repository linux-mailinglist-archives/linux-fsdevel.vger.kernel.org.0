Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2C275A4AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 05:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjGTDOo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 23:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjGTDOd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 23:14:33 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926542110
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 20:14:27 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3a359611a98so686339b6e.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 20:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689822867; x=1690427667;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3dLS1fkmLNfQarBUbxDLjlgSZFQxrkiWfFAKGUoVwgg=;
        b=chH6PnICndgBxPN9SQRqvvleGsYixAv10eONfktOqGtj4siTV+Ve790WJrytVQuiBS
         QbRY/tKXPJ6SrgqiPOLHWFyOB8NtseJ4CX/BkO5wn/2MmDE0QljumF0nHTMec7nqMrrB
         b0x+FDin9v0ujWaL+BzNXSjlJ7M2UnPIHjCQmIju+ZJqN3++o4uhMoq4BnUp5GzSu4Tt
         fxo7ftqqekJvzxoz6+RdE2Hebv7XiPjmOIoQGZw8YAbUDR2OSIrUxFVH8F/KaWt0CYe+
         3tDww86zXWTLvKrah+i5FEjKEBySb1CrwK2pq/5FPf+f4plb+cnfRmkU5Sh1MRLBjoDr
         sS3g==
X-Gm-Message-State: ABy/qLbv0C7lEVNoZb4cM2PPg0KpKTuktHH3TLXmbcJVaxE7ITeJUrDu
        5sqKvv49wlGo2ldtsuMxod62IChN93vriUbEJK9d+u/Nw+/h
X-Google-Smtp-Source: APBJJlFnA8rvYk9d/lGUaDr/IfIskxW4K8tYC6PqQDXp5UAdWWBsS51r9xWXOWnTExCP8AKfzol60XBIwVv36pGSqoDsUx8WPCbZ
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1149:b0:3a0:3d3c:1f03 with SMTP id
 u9-20020a056808114900b003a03d3c1f03mr763746oiu.11.1689822866925; Wed, 19 Jul
 2023 20:14:26 -0700 (PDT)
Date:   Wed, 19 Jul 2023 20:14:26 -0700
In-Reply-To: <00000000000029729c05fe5c6f5c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b76f3a0600e28b22@google.com>
Subject: Re: [syzbot] [xfs?] KASAN: slab-out-of-bounds Read in xlog_pack_data
From:   syzbot <syzbot+b7854dc75e15ffc8c2ae@syzkaller.appspotmail.com>
To:     david@fromorbit.com, dchinner@redhat.com, djwong@kernel.org,
        hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

commit f1e1765aad7de7a8b8102044fc6a44684bc36180
Author: Dave Chinner <dchinner@redhat.com>
Date:   Wed Jun 28 18:04:33 2023 +0000

    xfs: journal geometry is not properly bounds checked

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13d43cc6a80000
start commit:   fb054096aea0 Merge tag 'mm-hotfixes-stable-2023-06-12-12-2..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=5bcee04c3b2a8237
dashboard link: https://syzkaller.appspot.com/bug?extid=b7854dc75e15ffc8c2ae
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1482afc7280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1429c5e7280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: xfs: journal geometry is not properly bounds checked

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
