Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DD4653524
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Dec 2022 18:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbiLUR2h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Dec 2022 12:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbiLUR2N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:28:13 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9729B21E1D;
        Wed, 21 Dec 2022 09:28:09 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id bi26-20020a05600c3d9a00b003d3404a89faso2771068wmb.1;
        Wed, 21 Dec 2022 09:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pv+f7Qaep3g1XcMnashW4dr0+STOgPcgnTmOuhDg7/E=;
        b=dx0flUNhrBgzVh2VnHyf7+ho7NV23dHAxQ9JeCm7Wk5bwY6vWZQO/jrt/BItgPQ7CA
         ulMNEQxUWhVyaoFaw2BaAqKIljM4Wyxv7c1HKTTSwqvzLgD6LXA21UTG9ytFNtX7czjC
         pignEoYpBvdsxurgG1jCJrY7Y5k6r2P7X+WCtyYuvlNJyAwIYiQFSF73HEqV7tGhsIFg
         SvMpotb+QLZ4GXbz426B7XcwmWM5Lr5pZOghGP3tc83QnT1fFGayUnRqEhkjPBoltooA
         FtAD4xfjCuxP4UP4sE4iAkgZTqkn8R97Jkifb6v3Y2J2tIIszAFDpqMqthYy6plJ/NLG
         1JjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pv+f7Qaep3g1XcMnashW4dr0+STOgPcgnTmOuhDg7/E=;
        b=PglZNZfH4Ne5zYNgthmrrOtrGRpESwCIMfWVsqvo4hwwQg8tCM65DM6rVXFg/dsIXd
         hQt6eeEseA4h9nPtYZR6119T+Z+7IBMtJ6B9UfgNyvoN5mFUfsB/IeAuaCflr524nUNQ
         IsEzYEoi3XTQqg1acmuXeNLWpJ6gWfg14ET6R4gvnyCaZjn7kiWYxMCtPpaYnJq7kGgx
         CEfbY0v7c867gR9vJpvQtBt2Wu8mPhPLEyP6DD7L23hdyxkD0aeR4FdEJ/NWapzDOLuK
         nb/9HARhDolgzsh+riVvbXslY+T8GXkctHCmctXOam6WwifCQ2gT22qhg0Y2yMP56fpi
         VBjw==
X-Gm-Message-State: AFqh2kppc/jZf5zkv0rfE798wV18/VLx5z5vDzYslcMHF/CAOC8gDf46
        zo7/YX3hnWcQ9OhpdB0bGjE=
X-Google-Smtp-Source: AMrXdXtFNIAw+skNPswTN0DXJvjAscuZylzUT3+8MdknsJzHZ94M5fRHNnyA713k0l3ohsN2xTLX8g==
X-Received: by 2002:a05:600c:4e46:b0:3d2:3761:b717 with SMTP id e6-20020a05600c4e4600b003d23761b717mr2263461wmq.37.1671643687983;
        Wed, 21 Dec 2022 09:28:07 -0800 (PST)
Received: from localhost.localdomain (host-95-251-45-63.retail.telecomitalia.it. [95.251.45.63])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c500f00b003cffd3c3d6csm3003260wmr.12.2022.12.21.09.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 09:28:07 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v4 0/3] fs/ufs: Replace kmap() with kmap_local_page 
Date:   Wed, 21 Dec 2022 18:27:59 +0100
Message-Id: <20221221172802.18743-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kmap() is being deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
the mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and still valid.

Since its use in fs/ufs is safe everywhere, it should be preferred.

Therefore, replace kmap() with kmap_local_page() in fs/ufs. kunmap_local()
requires the mapping address, so return that address from ufs_get_page()
to be used in ufs_put_page().

This series could have not been ever made because nothing prevented the
previous patch from working properly but Al Viro made a long series of
very appreciated comments about how many unnecessary and redundant lines
of code I could have removed. He could see things I was entirely unable
to notice. Furthermore, he also provided solutions and details about how
I could decompose a single patch into a small series of three
independent units.[1][2][3]

I want to thank him so much for the patience, kindness and the time he
decided to spend to provide those analysis and write three messages full
of interesting insights.[1][2][3]

Changes from v1:
	1/3: No changes.
	2/3: Restore the return of "err" that was mistakenly deleted
	     together with the removal of the "out" label in
	     ufs_add_link(). Thanks to Al Viro.[4]
	     Return the address of the kmap()'ed page instead of a
	     pointer to a pointer to the mapped page; a page_address()
	     had been overlooked in ufs_get_page(). Thanks to Al
	     Viro.[5]
	3/3: Return the kernel virtual address got from the call to
	     kmap_local_page() after conversion from kmap(). Again
	     thanks to Al Viro.[6]

Changes from v2:
	1/3: No changes.
	2/3: Rework ufs_get_page() because the previous version had two
	     errors: (1) It could return an invalid pages with the out
	     argument "page" and (2) it could return "page_address(page)"
	     also in cases where read_mapping_page() returned an error
	     and the page is never kmap()'ed. Thanks to Al Viro.[7]
	3/3: Rework ufs_get_page() after conversion to
	     kmap_local_page(), in accordance to the last changes in 2/3.

Changes from v3:
	1/3: No changes.
	2/3: No changes.
	3/3: Replace kunmap() with kunmap_local().

[1] https://lore.kernel.org/lkml/Y4E++JERgUMoqfjG@ZenIV/
[2] https://lore.kernel.org/lkml/Y4FG0O7VWTTng5yh@ZenIV/
[3] https://lore.kernel.org/lkml/Y4ONIFJatIGsVNpf@ZenIV/
[4] https://lore.kernel.org/lkml/Y5Zc0qZ3+zsI74OZ@ZenIV/
[5] https://lore.kernel.org/lkml/Y5ZZy23FFAnQDR3C@ZenIV/
[6] https://lore.kernel.org/lkml/Y5ZcMPzPG9h6C9eh@ZenIV/
[7] https://lore.kernel.org/lkml/Y5glgpD7fFifC4Fi@ZenIV/#t

The cover letter of the v1 series is at
https://lore.kernel.org/lkml/20221211213111.30085-1-fmdefrancesco@gmail.com/
The cover letter of the v2 series is at
https://lore.kernel.org/lkml/20221212231906.19424-1-fmdefrancesco@gmail.com/
The cover letter of the v3 series is at
https://lore.kernel.org/lkml/20221217184749.968-1-fmdefrancesco@gmail.com/

Fabio M. De Francesco (3):
  fs/ufs: Use the offset_in_page() helper
  fs/ufs: Change the signature of ufs_get_page()
  fs/ufs: Replace kmap() with kmap_local_page()

 fs/ufs/dir.c | 134 +++++++++++++++++++++++++++------------------------
 1 file changed, 71 insertions(+), 63 deletions(-)

-- 
2.39.0
