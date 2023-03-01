Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95416A6A7E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 11:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCAKIr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 05:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjCAKIU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 05:08:20 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A7E1A648
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Mar 2023 02:08:19 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id c13-20020a0566022d0d00b0074cc4ed52d9so7929507iow.18
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Mar 2023 02:08:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TTSQYNOg9OZQxBXRQdwYpLcJKsFubqAo72NPGlg9CpM=;
        b=O9wUYY/TzzcsviwB5BDW46x36XQs+O9J8MGd2CYPYGhyqK0eisZlKbEdqdJg1ey8lA
         5q4A22/LwkJPbtBjOt/QPOAoZJFbCwrhZ6X14UqF3XI54HxhCgWCS5jrIxhs0ANZr0nO
         kENWoEFNcDFCFdzj00Ws1eOZF/MH8iHn/BySJUWadq09EXrGgfqQaJn7L+UlXrkpR50j
         3UcM03NUJ9y6lfbUIM2HUoPTOwRL03C5AiZtI34sNepzK4AKWZhOv0WbRkqaaBJn3PVZ
         NEQ0c/0N0PzzHgqf7YyIwLKGIQ+gKRCo3xxkJQuASuuBr9vFbCTVW8PJata7NCwesvsm
         UHgA==
X-Gm-Message-State: AO0yUKVqiY8C8Y/QTwVrZv3dAGOAHDHuPfrhDCTIyQA2uJ4M6HhCC/hz
        ObwTc73B3zGXbTpr4Dj4QfKsGmSaoO7VwZ3le/u4BIB0iGZL
X-Google-Smtp-Source: AK7set+9+5X/rmiwzS5y9zd/polCDgC1mf5cojHMVCq+fi5kymlSfbpp3XXnKUbMuUR5F04OX2n/O6uA1Abba2gonsivBHeDDaEE
MIME-Version: 1.0
X-Received: by 2002:a05:6602:151:b0:745:c41a:8f0f with SMTP id
 v17-20020a056602015100b00745c41a8f0fmr2577531iot.2.1677665299348; Wed, 01 Mar
 2023 02:08:19 -0800 (PST)
Date:   Wed, 01 Mar 2023 02:08:19 -0800
In-Reply-To: <00000000000052865105f5c8f2c8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003845ba05f5d3e416@google.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in jbd2_log_wait_commit
From:   syzbot <syzbot+9d16c39efb5fade84574@syzkaller.appspotmail.com>
To:     hdanton@sina.com, jack@suse.com, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
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

commit 0813299c586b175d7edb25f56412c54b812d0379
Author: Jan Kara <jack@suse.cz>
Date:   Thu Jan 26 11:22:21 2023 +0000

    ext4: Fix possible corruption when moving a directory

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14845d50c80000
start commit:   e492250d5252 Merge tag 'pwm/for-6.3-rc1' of git://git.kern..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16845d50c80000
console output: https://syzkaller.appspot.com/x/log.txt?x=12845d50c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f763d89e26d3d4c4
dashboard link: https://syzkaller.appspot.com/bug?extid=9d16c39efb5fade84574
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d96208c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176d917f480000

Reported-by: syzbot+9d16c39efb5fade84574@syzkaller.appspotmail.com
Fixes: 0813299c586b ("ext4: Fix possible corruption when moving a directory")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
