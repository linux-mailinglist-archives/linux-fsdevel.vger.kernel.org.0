Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE507B7763
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 07:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241298AbjJDFQj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 01:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241336AbjJDFQi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 01:16:38 -0400
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F94A9
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Oct 2023 22:16:34 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6c4f91d2f55so2128168a34.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Oct 2023 22:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696396593; x=1697001393;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xsl5iHyLS4qMdG5lx1KkFmQgiDnWMJRcCrl39PiOj5A=;
        b=rktmdY3SlFVSVEHF3HDR98Pf8yYPEr+iENclUxQLCJ0uVGK9Nd53fC99BP38ozfxkb
         zyAtjNOq72j/DWjiNH9PD2gk4jIagACdw5Rb0h8dwM7hWRHWwG83l87l/5N9BXHcuTO0
         PTbO5+NOrEmIPM5ygymA3e9K7FS5ezOFZVJYXF2paKz4R4gdflvpkjhEQ/1PuG6kZtOL
         UuwMVvX5Ar3YmC+IEDGyE51WtX/w9UXU0K3rPMmeMYxnoCNo3DhMHVIjrhBrrMpyJrvG
         +elhrRLr77K8UUSllHNcJ/Rrv56cdq3I2h4j+oB++XxkiYWptBGGgps25ZoDlNSC27by
         uDfg==
X-Gm-Message-State: AOJu0YxISeMPeVlt72SvXBALctDH0a+yjPIPqek2TDqXk4zr/6grn/qx
        BpTw1NNw7NgukMLU5z/qSDStK4DyVBj6sOjWPOf3mjN4TV4P
X-Google-Smtp-Source: AGHT+IEKE85r/QEez3XukduZdd3MAgJKkU9MpperzIgUDEZvttkFcTjPSnSs4p4EZHI6RoodSszwHEXjUKhOqgbh5Qh/4uyth7px
MIME-Version: 1.0
X-Received: by 2002:a05:6830:1154:b0:6bd:58f:d8c1 with SMTP id
 x20-20020a056830115400b006bd058fd8c1mr370654otq.1.1696396593664; Tue, 03 Oct
 2023 22:16:33 -0700 (PDT)
Date:   Tue, 03 Oct 2023 22:16:33 -0700
In-Reply-To: <0000000000005f05820606a0838a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d185b0606dd1cbf@google.com>
Subject: Re: [syzbot] [mm?] WARNING in copy_hugetlb_page_range
From:   syzbot <syzbot+ec78016e3d67860eec28@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, brauner@kernel.org, hdanton@sina.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, mike.kravetz@oracle.com,
        muchun.song@linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        riel@surriel.com, syzkaller-bugs@googlegroups.com, trix@redhat.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 446503572dc452fc544d6898113feb0f3801477b
Author: Rik van Riel <riel@surriel.com>
Date:   Sun Oct 1 00:55:50 2023 +0000

    hugetlbfs: replace hugetlb_vma_lock with invalidate_lock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=146c879e680000
start commit:   c9f2baaa18b5 Add linux-next specific files for 20231003
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=166c879e680000
console output: https://syzkaller.appspot.com/x/log.txt?x=126c879e680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3fe9c462fee1649f
dashboard link: https://syzkaller.appspot.com/bug?extid=ec78016e3d67860eec28
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e4b011680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11772062680000

Reported-by: syzbot+ec78016e3d67860eec28@syzkaller.appspotmail.com
Fixes: 446503572dc4 ("hugetlbfs: replace hugetlb_vma_lock with invalidate_lock")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
