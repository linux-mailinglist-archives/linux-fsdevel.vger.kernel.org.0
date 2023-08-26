Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF6D78986B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Aug 2023 19:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjHZRds (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Aug 2023 13:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjHZRdp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Aug 2023 13:33:45 -0400
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8685AB
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Aug 2023 10:33:42 -0700 (PDT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-68a4075f42fso1853974b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Aug 2023 10:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693071221; x=1693676021;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tjVLdoMeoNBHxjD3Hv96x2He0s6aP5eRpCyA9UAuyOA=;
        b=IiV6envFs29y2y/JlWUaC9ZvfGjPcy7Xegopon38uhFOIoIZC7L2xwdrTDJdAI+reZ
         D3JYdMTl5AoU8J21CxrBiRgBkIc9GBFGVfnQ1iCbFYflF1BkysCakbwSAakZ+Tuh3tP+
         aq7hUcuQWhqnn4AtnxDKhQKVcWnt5g6Mm9vnbsoMNunz2qgbUHukq9Jc0DCiNMyOZWPh
         5FSXie8gQvarEgMEjca62tEjkbbrC0T16i5EmRdNBbMBSEDosN0QaZb1e4+6dO1cCCnu
         7bf7UNbcvxMRPlu+vdjXNB5SfTcHphaAklzuj3cIh0kZUjUmoHo3Y5u6ZUQdJyW+/Dti
         tRMQ==
X-Gm-Message-State: AOJu0YxPzsk11W/h9+SqO8xP6PYXjY9W5u1hwxu6oleX9pUV6jjCvgI1
        NaY5sKkZxvzcFwj4bNNbjEZ3bhBQsvHTJlfk4DwQwjxONHZ+
X-Google-Smtp-Source: AGHT+IFbNWDB+fYq/8p8IgoA/y3rlCahJG5okiucNxPC45l2dX3idUNq0eHY5+396R3r6YwmxazDDn3aFXq4W//XIGNxCTUnI1nt
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:178f:b0:68a:ce39:32b4 with SMTP id
 s15-20020a056a00178f00b0068ace3932b4mr4343740pfg.0.1693071221348; Sat, 26 Aug
 2023 10:33:41 -0700 (PDT)
Date:   Sat, 26 Aug 2023 10:33:41 -0700
In-Reply-To: <000000000000de4c2c0600c02b28@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba5da70603d6dc04@google.com>
Subject: Re: [syzbot] [hfs?] kernel BUG in hfs_show_options
From:   syzbot <syzbot+155274e882dcbf9885df@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sel4@disroot.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit c30417b20f4993e49406f3f6d986355c6e943aa2
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Mon Jul 17 09:33:32 2023 +0000

    seq_file: Replace strncpy()+nul by strscpy()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1009eda7a80000
start commit:   aeba456828b4 Add linux-next specific files for 20230718
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1209eda7a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1409eda7a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e7ec534f91cfce6c
dashboard link: https://syzkaller.appspot.com/bug?extid=155274e882dcbf9885df
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136fa2aaa80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16629fe4a80000

Reported-by: syzbot+155274e882dcbf9885df@syzkaller.appspotmail.com
Fixes: c30417b20f49 ("seq_file: Replace strncpy()+nul by strscpy()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
