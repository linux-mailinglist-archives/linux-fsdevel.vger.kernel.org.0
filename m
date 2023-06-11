Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8D672B492
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 00:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjFKWR3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 18:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFKWR2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 18:17:28 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209A6E4E
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jun 2023 15:17:28 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-77760439873so477431039f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jun 2023 15:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686521847; x=1689113847;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tb0ZpKp5Xcf7c2M/6Lg/dqUujad/vr5X4auVnTDjdJ0=;
        b=iVZCxcsYHpP8B0pmgklOU3NTfblydWVA1CviQMMEGQxAnMdZq/DZFSs5rpbg96bmEH
         Bj/cHRtABpNE22mWViyQCXv9JY0oc4bJe+ZkQPTRHs/H1tIEfyzUjN05KImMDn7m9+KA
         9pTIc2VmGq0OFnkbbwZ8qPCyoqsjTfjpSex4HhScHgAJYuz1xuZRoKZUdb4v7bI0cYl/
         kMCleC3S7mfdi9w0Yht8uz6qyjqgQxddnS8G6bvS9t97HfEOk6q6d0JwSXkObONrG4+y
         bu6VaFfGfhtDR/VcwfWfxnHPHb6U/AApQzWugCJIIlqHwgCXXBDO+etK7gC3SapyufG3
         sLyA==
X-Gm-Message-State: AC+VfDysi7GrPKyxieEdHKR80BJrLxcOjXfOrGA9kb++TInk50+KceLa
        KMmVMFEDF6EOykRr7MYNVYzQGTLtv0cLJnnYXZkBrKCg5lZa
X-Google-Smtp-Source: ACHHUZ76jxhpMkdSOWymiIXSmAP6nlbvMNMejA6KYO29dhEW02hKZhueWLXvaOgfjmygw/0Wl9A7WAYJqR30bFmRG9ZnFevqGqT/
MIME-Version: 1.0
X-Received: by 2002:a02:735d:0:b0:420:cbe4:af62 with SMTP id
 a29-20020a02735d000000b00420cbe4af62mr2890400jae.5.1686521847528; Sun, 11 Jun
 2023 15:17:27 -0700 (PDT)
Date:   Sun, 11 Jun 2023 15:17:27 -0700
In-Reply-To: <000000000000b0cabf05f90bcb15@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a0c29605fde1f706@google.com>
Subject: Re: [syzbot] [ntfs3?] general protection fault in ni_readpage_cmpr
From:   syzbot <syzbot+af224b63e76b2d869bc3@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org,
        almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        neilb@suse.de, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 9fd472af84abd6da15376353c2283b3df9497646
Author: NeilBrown <neilb@suse.de>
Date:   Tue Mar 22 21:38:54 2022 +0000

    mm: improve cleanup when ->readpages doesn't process all pages

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1285d453280000
start commit:   64569520920a Merge tag 'block-6.4-2023-06-09' of git://git..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1185d453280000
console output: https://syzkaller.appspot.com/x/log.txt?x=1685d453280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c980bfe8b399968
dashboard link: https://syzkaller.appspot.com/bug?extid=af224b63e76b2d869bc3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15835795280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16966d43280000

Reported-by: syzbot+af224b63e76b2d869bc3@syzkaller.appspotmail.com
Fixes: 9fd472af84ab ("mm: improve cleanup when ->readpages doesn't process all pages")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
