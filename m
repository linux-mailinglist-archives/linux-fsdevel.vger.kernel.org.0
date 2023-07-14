Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437EC752ED6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 03:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbjGNBoE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 21:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjGNBoD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:44:03 -0400
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850F635A7
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 18:43:36 -0700 (PDT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5667dddaa5cso1751469eaf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 18:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689299004; x=1691891004;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZnknvALMXVtBPX6Ukkpz2YO8donkHl1pxBhmFLF1B8=;
        b=FfjLq5SLwLD6cFqC6773/uMfJbuRfYsQwt52b0oifDcK3UJHTu834HRPD+/nmUgjS0
         VHFmp7JwgfqmTseKTIa5JiMJqLEfL3jP47wm3lwri0qbssuvnuNp0UzzPGuVlvsEKmDO
         XJm+G7xVP+oubvfVT64D9QecQ6RaAC1mS0SRBzPGBwPJJ208O6KVqXtF4inVhCwftY3p
         KVCAXFYdgOcoEeop3nPMoQTwGNuv0yUN4XM2C+SN3p/03UiMquQ1knwaThV5GRQZPCRK
         eAp+jFE4aMhV8oxReOwTdGkaP4U1uCltioadjdMoS9ogDiRazoWKyTFGf2tYuqhr2m67
         S0CA==
X-Gm-Message-State: ABy/qLaie4tWTJAXJjSrP3xC6dRwC2HnHA2lFIL9GGKFwQ2zDEAOvvBd
        PKSAxTEhntunZs6gl2vRh5bwLkdqxJ6qokMroxsK1D404apZ
X-Google-Smtp-Source: APBJJlGd0eELYwyfN1ir0FVfQ1r8XO7T2Oqnv+pjSOFNSE8HMIz7hICE3gORb5V98Qrx8R+qp9PXum5hz1HF/XHIWmUmq950RZr6
MIME-Version: 1.0
X-Received: by 2002:a05:6870:a881:b0:1b3:99b4:3e46 with SMTP id
 eb1-20020a056870a88100b001b399b43e46mr3253987oab.8.1689299004333; Thu, 13 Jul
 2023 18:43:24 -0700 (PDT)
Date:   Thu, 13 Jul 2023 18:43:24 -0700
In-Reply-To: <0000000000003735c9060061384a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000012a70f0600689326@google.com>
Subject: Re: [syzbot] [btrfs?] general protection fault in btrfs_finish_ordered_extent
From:   syzbot <syzbot+5b82f0e951f8c2bcdb8f@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, hch@lst.de,
        johannes.thumshirn@wdc.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit b41b6f6937dc89e072b334e8d814487cb4692770
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed May 31 07:54:09 2023 +0000

    btrfs: use btrfs_finish_ordered_extent to complete direct writes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14761374a80000
start commit:   1c7873e33645 mm: lock newly mapped VMA with corrected orde..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16761374a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=12761374a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9831e2c2660aae77
dashboard link: https://syzkaller.appspot.com/bug?extid=5b82f0e951f8c2bcdb8f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109dcf08a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13dadfb4a80000

Reported-by: syzbot+5b82f0e951f8c2bcdb8f@syzkaller.appspotmail.com
Fixes: b41b6f6937dc ("btrfs: use btrfs_finish_ordered_extent to complete direct writes")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
