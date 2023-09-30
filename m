Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93D27B3DAD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 04:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbjI3Cmf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 22:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjI3Cme (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 22:42:34 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10D61B2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 19:42:31 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3af5a2a0c8fso9442799b6e.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 19:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696041751; x=1696646551;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4maoRvrljkflRYnHXhzRQpivRGA7ZdeJoiXO51Iskc=;
        b=Esu3pOh42l3mKLLdCDxydRSLAWlj/FxU1OVJZKTodXM7MRl6wNj/2bnwAP/FrHabIf
         QCW2Sr+mAcag85H7+Z63CPSzaQdMoVok2Bz78HlMUyge/w9k5vJPNGC3T+PE60znaJOD
         UWgkfDxnhyXuFDvBL+hOr5/530v1vwm9HeoPZTC6RDfhnBYb79oz1uWfPd71ctXRFQ1g
         sQdYvelluXNXVRkzEqaqWxOVBCWSjMaZi4DLIWvTZMynEgO6LoZO0M4L56tS0qTjEK+m
         UbXMEjYOhp0BzZC+c0EpNbuQelHfFUR36Q9PkX1Siy8fGxnqfOUB1ferUomV+D/IoEw+
         2KIQ==
X-Gm-Message-State: AOJu0YweIzEaXd2G8acOXq3iFe771utNGPNHqZG000qmOpBmsimO5WeH
        D6qmSQxJGyzOPsS+SqXFK3iX4mc8Q6aK0jhWlYnsJCH0H47F
X-Google-Smtp-Source: AGHT+IF4LOEf8UnC0bUMlXsWXtdrWrJuwcTECRkOJxtPiY8VffpH6W8eLeF9FeZFZVR+o79oABrtMjg0oD2csieJZ5mk3ZsumjzV
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1909:b0:3ae:1ae1:df4b with SMTP id
 bf9-20020a056808190900b003ae1ae1df4bmr2980892oib.8.1696041750988; Fri, 29 Sep
 2023 19:42:30 -0700 (PDT)
Date:   Fri, 29 Sep 2023 19:42:30 -0700
In-Reply-To: <000000000000cbb5f505faa4d920@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000178f6f06068a7e9a@google.com>
Subject: Re: [syzbot] [f2fs?] possible deadlock in f2fs_release_file
From:   syzbot <syzbot+e5b81eaab292e00e7d98@syzkaller.appspotmail.com>
To:     chao@kernel.org, hdanton@sina.com, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 5079e1c0c879311668b77075de3e701869804adf
Author: Chao Yu <chao@kernel.org>
Date:   Fri Jun 2 08:36:05 2023 +0000

    f2fs: avoid dead loop in f2fs_issue_checkpoint()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15f18a92680000
start commit:   b6dad5178cea Merge tag 'nios2_fix_v6.4' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac246111fb601aec
dashboard link: https://syzkaller.appspot.com/bug?extid=e5b81eaab292e00e7d98
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c50e17280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a9558b280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: f2fs: avoid dead loop in f2fs_issue_checkpoint()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
