Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A421A7B42DA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 19:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbjI3R5e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 13:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbjI3R5d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 13:57:33 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12151D3
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Sep 2023 10:57:29 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3ae5a4f9954so16889127b6e.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Sep 2023 10:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696096648; x=1696701448;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3Gp6kmS+fykC4M2bQvmNXWwpBIaXxl++sWiM3iH1lM=;
        b=lspqtlvnPkMUJsRzknFASgVwU5NpUln8Q7WWPf0P4keikDdgdm9Rfl3yXNbsqYa5Py
         +Gzx2z/IRdiFIbCmaY5nq+09+B+nXHrwp6fRKyYu2kdOKz/V6/64LiQfLN06xX6EWxd4
         2djqgiEc5B9mOnNrLrMCEHSNM0NmSFS+Jm9XnXECnj2UhE51mCOhWoT5GowiRkbLmKXq
         F3i8/v4x6C8lg/NUJm+a2doljydx7q5PBZdng11JEk82u2mflhS2FHgrFxOzGfOkcR9P
         t7VlpLalh5R3kOw8Oqqp1bTYNKW05saJLo7LbEeZXge1O21mlmuvwj/5JA/sJ9lB061l
         azWg==
X-Gm-Message-State: AOJu0YwtK5pk/ZzxMrB4/nnsvH4tWyMj7okZ5LXI/22PEWL8/w0sCwFT
        +2Q8U50mWb5fiy+oqSrfEkQUTq5r27UkLiYRPUWyXpKD4nVx
X-Google-Smtp-Source: AGHT+IE18cqh4JXNl6uQxBP/a23swgy+FwpamgscMAObJ9M7l5hmBxY2Rxui2X8zH1T9Z/3YkdWmpxVHSllM5OftvTuZR+eXBiKI
MIME-Version: 1.0
X-Received: by 2002:a05:6870:c342:b0:1d5:a24a:c33 with SMTP id
 e2-20020a056870c34200b001d5a24a0c33mr2785411oak.8.1696096648433; Sat, 30 Sep
 2023 10:57:28 -0700 (PDT)
Date:   Sat, 30 Sep 2023 10:57:28 -0700
In-Reply-To: <0000000000001c8edb05fe518644@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003c16100606974653@google.com>
Subject: Re: [syzbot] [xfs?] UBSAN: array-index-out-of-bounds in xfs_attr3_leaf_add_work
From:   syzbot <syzbot+510dcbdc6befa1e6b2f6@syzkaller.appspotmail.com>
To:     chandan.babu@oracle.com, david@fromorbit.com, djwong@kernel.org,
        ebiggers@kernel.org, hch@lst.de, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, mukattreyee@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit a49bbce58ea90b14d4cb1d00681023a8606955f2
Author: Darrick J. Wong <djwong@kernel.org>
Date:   Mon Jul 10 16:12:20 2023 +0000

    xfs: convert flex-array declarations in xfs attr leaf blocks

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12eef28a680000
start commit:   f8566aa4f176 Merge tag 'x86-urgent-2023-07-01' of git://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f27fb02fc20d955
dashboard link: https://syzkaller.appspot.com/bug?extid=510dcbdc6befa1e6b2f6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1652938f280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c10c40a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: xfs: convert flex-array declarations in xfs attr leaf blocks

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
