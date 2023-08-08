Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECBF77417C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 19:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbjHHRWX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 13:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbjHHRWD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:22:03 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9B01F438
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Aug 2023 09:09:04 -0700 (PDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-40fccbf38baso71357421cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Aug 2023 09:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510880; x=1692115680;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3cVzil68L2nUakgAvD6EqtGzj4TTi2Pa4HJPh3POMA=;
        b=RCBxhGKi4PhLDPd8NxNX6zTg99a8EsmFKnoUibGPDW4AnIOuy90sv6BSoW1T7c/zGH
         N1IxBkHEnwbsfXLvXKtN9fgZ+kBilfZZhzLHqbyz3nuCxK3qQNNE/fs5A2Dnx9DMp0Bb
         bkOiVjL6jpJutUsScerwaUypfJWRWy/f9lkbl2HQdCN/1U6nwbT1eS2vEEOThohx19RT
         znfJtBd7qNT96AJL4HiVAS8DAUG8TwETEXdAbtDw/AWoDTbjKElxe1dXSfrf0l6nBTW2
         D0NVcwkOAk+QZPgv2bgkTzueq/4frigl3zCjPExMIQwfn43gqOurptRtiS6LLpVcLjGz
         ucrA==
X-Gm-Message-State: AOJu0Yxl6GX0RsNwrXbJfmjGS6aKbJQX/ZsDGv7rlBpz9+9Xro1PrzmU
        xPB8ASbe5KeLX1r4jew4c+sMAsxcnW+6S/VMDWUqeqJMFory
X-Google-Smtp-Source: AGHT+IHHizOZQm04U255n2hskY4NzQJLWNVkNdZ3CVU7HVRYIsH/eL3hypvqAMtLgWUmWGbb1KdMh1uL7BoNkVqiAL+X1zgpxGCT
MIME-Version: 1.0
X-Received: by 2002:a05:6830:3b07:b0:6b9:1768:b318 with SMTP id
 dk7-20020a0568303b0700b006b91768b318mr13764104otb.5.1691491360159; Tue, 08
 Aug 2023 03:42:40 -0700 (PDT)
Date:   Tue, 08 Aug 2023 03:42:40 -0700
In-Reply-To: <00000000000069948205f7fb357f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a9bf5106026705ec@google.com>
Subject: Re: [syzbot] [fat?] possible deadlock in do_user_addr_fault
From:   syzbot <syzbot+278098b0faaf0595072b@syzkaller.appspotmail.com>
To:     linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit ff84772fd45d486e4fc78c82e2f70ce5333543e6
Author: Sungjong Seo <sj1557.seo@samsung.com>
Date:   Fri Jul 14 08:43:54 2023 +0000

    exfat: release s_lock before calling dir_emit()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16623aa9a80000
start commit:   f8dba31b0a82 Merge tag 'asym-keys-fix-for-linus-v6.4-rc5' ..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c980bfe8b399968
dashboard link: https://syzkaller.appspot.com/bug?extid=278098b0faaf0595072b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144ccf79280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=135fab79280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: exfat: release s_lock before calling dir_emit()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
