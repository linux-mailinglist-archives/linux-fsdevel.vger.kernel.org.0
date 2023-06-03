Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99596721160
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jun 2023 19:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjFCRfc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Jun 2023 13:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjFCRfb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Jun 2023 13:35:31 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A39C180
        for <linux-fsdevel@vger.kernel.org>; Sat,  3 Jun 2023 10:35:30 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-772d796bbe5so193329139f.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Jun 2023 10:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685813729; x=1688405729;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n1SeEqkLJd2frZFJDII6RbpgUseFm/YFNnAbddZInMM=;
        b=kE6VfQgkxD/wKkhaqF3O2Zi/XK4Vku/oB65MRPU5tJIkEpXoPVtvbTXP6ApdUTHNYw
         DX6MzSSvxtfulWihzUfmgCKk/x3tEe6dCWoV6JBLkQb5izZM+DLAEg3BCpd9RrZk2w1u
         P4nAIsXM2smA1QPlUgxHIN7zha6gtrdm9yAhmWuFoksIIeJ/+BzuFarfdAUf7tOsWkl+
         7WQSzG3SlvuLzFwBC25iD1J+5NIbVGjmKvY/l2Kw5PzArU0CwWtKMgsGMpeCCZLhI3fr
         GYGFelzQjiRKhkIsek8q1QnH1xGUZiBHSt+m69aICnMu1M7T+2Bz1rxdtDbkfFMR47WV
         biqw==
X-Gm-Message-State: AC+VfDy6fuHmUBu0cgaPpO3qs+oJ8skm52fCGKCtNl3QRMGdXf8knaN3
        1PYwSDdVMRmns+utDTxUuBWVGt6wvxID6euTLAZvGSv6Rshe
X-Google-Smtp-Source: ACHHUZ6PNRvZf4egyXcxaFKUR1h4B17KMjEgcTa+XrD1cnuMT+zQb+7Ml3iHK9opb9E2/04Wa5dQuukbfkq8mgbBCabRKXfYrl2T
MIME-Version: 1.0
X-Received: by 2002:a02:9641:0:b0:41d:72e0:ba18 with SMTP id
 c59-20020a029641000000b0041d72e0ba18mr2202217jai.0.1685813729544; Sat, 03 Jun
 2023 10:35:29 -0700 (PDT)
Date:   Sat, 03 Jun 2023 10:35:29 -0700
In-Reply-To: <000000000000eccdc505f061d47f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081d40a05fd3d18ed@google.com>
Subject: Re: [syzbot] [udf] WARNING in invalidate_bh_lru
From:   syzbot <syzbot+9743a41f74f00e50fc77@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, brauner@kernel.org, hch@infradead.org,
        hch@lst.de, jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, liushixin2@huawei.com,
        nogikh@google.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit f6e2c20ca7604e6a267c93a511d19dda72573be1
Author: Liu Shixin <liushixin2@huawei.com>
Date:   Fri Apr 29 21:38:04 2022 +0000

    fs: sysv: check sbi->s_firstdatazone in complete_read_super

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13eed371280000
start commit:   4ecd704a4c51 tpm, tpm_tis: correct tpm_tis_flags enumerati..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=101ed371280000
console output: https://syzkaller.appspot.com/x/log.txt?x=17eed371280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=162cf2103e4a7453
dashboard link: https://syzkaller.appspot.com/bug?extid=9743a41f74f00e50fc77
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ebf8c9280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12df6ab6280000

Reported-by: syzbot+9743a41f74f00e50fc77@syzkaller.appspotmail.com
Fixes: f6e2c20ca760 ("fs: sysv: check sbi->s_firstdatazone in complete_read_super")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
