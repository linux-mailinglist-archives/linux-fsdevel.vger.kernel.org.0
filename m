Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72F978BC3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 02:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbjH2Aqp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 20:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbjH2Aqg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 20:46:36 -0400
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5299611C
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 17:46:33 -0700 (PDT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1bf525c269cso35554465ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 17:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693269993; x=1693874793;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1TELWkyWGLVi5ounuTr86ov170s+tD6p0uOdCZdYqIw=;
        b=j+EEcoHRf54ycuvdI7nSR2CV01qT4siy6DbVOAFQ9yqAWBGsIOe9b7jPfTqjeGKSg/
         HES3rs5TNiZEI0HBITzR+aFI44qmOJ8WypOw00sBIoyhpKOncg4D4nCUrgvMmPS6QAdr
         YEVjMkfXOjJy8xz2ep5NP2Ufsj9f06tQ/ycKm7yX12VD7T0o4sa5LjHkmBc67Xca3gzd
         w8AWzB+RjZbHwOgPL+0pT/72qCjKme5g/3QRN4wNIHE2M3ku8TELsTKus8nunPuddg5x
         qI94z5mY+guOWKwLdRpUiGTrQbqyHDaI7g2fSKnAE1GLcLqtAPWGpk1RoWPS+2sXKLkx
         3e4g==
X-Gm-Message-State: AOJu0YwDhDHWcMSLUL1R+ATY39uTPPvbqu1iFRZNgPGFucgB+S6iXtp/
        dMJqJfBSbAMYjcUnDo8tHYlxMjgj1w+cOlhhNwNoSWzIyxad
X-Google-Smtp-Source: AGHT+IF0JqiW6n0JfvqO2k1I/9t1jQO8AG2MUpQEzvKAMNeahZVregfHFtJaSp9GCQxOa4QV8OAF+1E4K+uL66L95sGp4DDSIsgt
MIME-Version: 1.0
X-Received: by 2002:a17:902:f353:b0:1bc:a3b:e902 with SMTP id
 q19-20020a170902f35300b001bc0a3be902mr7730501ple.3.1693269992834; Mon, 28 Aug
 2023 17:46:32 -0700 (PDT)
Date:   Mon, 28 Aug 2023 17:46:32 -0700
In-Reply-To: <000000000000b37bea05f0c125be@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e8bd80604052481@google.com>
Subject: Re: [syzbot] [gfs2?] BUG: unable to handle kernel NULL pointer
 dereference in gfs2_rgrp_dump
From:   syzbot <syzbot+da0fc229cc1ff4bb2e6d@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rpeterso@redhat.com, swhiteho@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 72244b6bc752b5c496f09de9a13c18adc314a53c
Author: Bob Peterson <rpeterso@redhat.com>
Date:   Wed Aug 15 17:09:49 2018 +0000

    gfs2: improve debug information when lvb mismatches are found

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1593747ba80000
start commit:   0a924817d2ed Merge tag '6.2-rc-smb3-client-fixes-part2' of..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1793747ba80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1393747ba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e2d7bfa2d6d5a76
dashboard link: https://syzkaller.appspot.com/bug?extid=da0fc229cc1ff4bb2e6d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e5bf7f880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13952f5d880000

Reported-by: syzbot+da0fc229cc1ff4bb2e6d@syzkaller.appspotmail.com
Fixes: 72244b6bc752 ("gfs2: improve debug information when lvb mismatches are found")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
