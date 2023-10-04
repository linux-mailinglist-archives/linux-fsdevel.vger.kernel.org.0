Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983AF7B970D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 00:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjJDWAo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 18:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjJDWAk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:00:40 -0400
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E71BDD
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Oct 2023 15:00:34 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6c660a0f0e8so343497a34.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Oct 2023 15:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696456833; x=1697061633;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Do7+F9fO3x+lsCYOh7EOzYRi6lB71j6CuWihNSq8Bac=;
        b=V+B2wb6VwkRrk90NUbaif0a9fbqM2Qo4F8f+glCBHPx/KJGN0ZHGxp+Rb0o8qnCDTr
         ypTe8RxHBj8wTOA3iqDiWMsoO1g/uHYrayYjFDDqjd5MgxlH5GIZjtzn8ELww9Kp8vaH
         Scj1NacaOTpcxjXdOdyIh5FVWupPSrB14UzdjvCD5auxuxeOvsVk2T0c/HgxwU0pRYIH
         fepv7dUfKrpl/l9t35knyUVgA9WvdNy5bdMF3TA5dKYi8cVkg69hkADeCDeeDp79rUwY
         dXom1eBiAvOd049DSFR61VHRp33IxidH2Bng379DaBMlybmBv3uVePOJIC8rl7UrF6qc
         0A/A==
X-Gm-Message-State: AOJu0YztyGzqm0A1xr1x+g6280a2oDuM8UjeOcsOBoS1RMrzcNYZ2FaH
        1ph5y21Ri7nxEHsZOh1brJon+17qJcaUXoqrv1IMntkjelnB
X-Google-Smtp-Source: AGHT+IFljSUnZaB98y+EUGkkmDfNvILblhzIsjCcZS1OfNOE5ApenUwMjZxN97zCom5TytS+A8/pYbzj5IOGuCBotqKYn4RHZQID
MIME-Version: 1.0
X-Received: by 2002:a9d:69ce:0:b0:6c6:3ea5:cdc1 with SMTP id
 v14-20020a9d69ce000000b006c63ea5cdc1mr1052391oto.3.1696456833197; Wed, 04 Oct
 2023 15:00:33 -0700 (PDT)
Date:   Wed, 04 Oct 2023 15:00:33 -0700
In-Reply-To: <0000000000001dd5e20606a0d265@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb6d0b0606eb2201@google.com>
Subject: Re: [syzbot] [mm?] WARNING in page_vma_mapped_walk
From:   syzbot <syzbot+dcf3f48f4bfe47a2f80a@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, brauner@kernel.org, hdanton@sina.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mike.kravetz@oracle.com, muchun.song@linux.dev,
        riel@surriel.com, syzkaller-bugs@googlegroups.com,
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12c93c16680000
start commit:   c9f2baaa18b5 Add linux-next specific files for 20231003
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11c93c16680000
console output: https://syzkaller.appspot.com/x/log.txt?x=16c93c16680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3fe9c462fee1649f
dashboard link: https://syzkaller.appspot.com/bug?extid=dcf3f48f4bfe47a2f80a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1421389a680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12860a7c680000

Reported-by: syzbot+dcf3f48f4bfe47a2f80a@syzkaller.appspotmail.com
Fixes: 446503572dc4 ("hugetlbfs: replace hugetlb_vma_lock with invalidate_lock")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
