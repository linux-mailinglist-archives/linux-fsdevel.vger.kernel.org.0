Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4B5751651
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 04:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbjGMCbj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 22:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbjGMCbi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 22:31:38 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AB4E70
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 19:31:37 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-39eab5800bdso332362b6e.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 19:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689215497; x=1691807497;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ULMbfN3/nTfJ+25ppVCP/v7aeJsW1OOHpSx1JvllrA=;
        b=JMO1uChfZPb7LetaoLbnugV4dgmDGT3546ItM/vGRV89cr05D+B/F0OpCT4pQ1fRkZ
         3T+6wgr9EiXyjw/iUO23IJQXieGyMhDYvH7HPQ9OQKfHcOlANAzCObhTIEDuLYQNIKM5
         xOlJfDmypbODBzQ2bJ2hKavfo6J2+arj/RKoEPS9BagkIdAsjBZ0yuD1f4wkaDGB1H2x
         dNHAqRl9LG79JtVgqQfnxuz5qEPUhctK/2NLs5vdFVHCS+HKo3z2Jj9b38G1P/scdyYh
         JyqVgHsXMpv361D50EE3n8lOltDFAqg4I7vPFvuqFmyyc88lm4Qxnysw5hx9uXs1ThH9
         e01A==
X-Gm-Message-State: ABy/qLbcvi7Czr+hDL3jvt5B5+HRufUdoxcHcqo/PuOAAGihIvAxWMvD
        w7x1LsN8un8Htsa2gSTcaKp/yrwTFYaVYOhQQCm1oS3oTgqC
X-Google-Smtp-Source: APBJJlH2K90jYu1C5y22SOZVw5Knm8A76T+Khq2Wzij5kK4T+YdlLIq/oPDVEuOx1Q49MiRQmeYaP51o6El+K48URannynX2pxY8
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2119:b0:3a4:1265:67e6 with SMTP id
 r25-20020a056808211900b003a4126567e6mr383381oiw.8.1689215496998; Wed, 12 Jul
 2023 19:31:36 -0700 (PDT)
Date:   Wed, 12 Jul 2023 19:31:36 -0700
In-Reply-To: <000000000000fd3bbe05efb0d1fd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5d5ab060055215c@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in walk_component
From:   syzbot <syzbot+eba014ac93ef29f83dc8@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org,
        almaz.alexandrovich@paragon-software.com, davem@davemloft.net,
        hughd@google.com, jiri@nvidia.com, kuba@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit d772781964415c63759572b917e21c4f7ec08d9f
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Fri Jan 6 06:33:54 2023 +0000

    devlink: bump the instance index directly when iterating

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12801432a80000
start commit:   f3e8416619ce Merge tag 'soc-fixes-6.1-5' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b83f3e90d74765ea
dashboard link: https://syzkaller.appspot.com/bug?extid=eba014ac93ef29f83dc8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117d216b880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: devlink: bump the instance index directly when iterating

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
