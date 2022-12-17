Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80C464FB9A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Dec 2022 19:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiLQSsH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Dec 2022 13:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLQSsG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Dec 2022 13:48:06 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FBD21B9;
        Sat, 17 Dec 2022 10:48:04 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id i187-20020a1c3bc4000000b003d1e906ca23so3311514wma.3;
        Sat, 17 Dec 2022 10:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zv6qufaVUoOKfgWnxcMfihvxlvMbtBzB/0Zji8Jvd9U=;
        b=OxAxAwo+0UFsBIJ7A6ZP/ZIO/Cn8n80KW4Lu8rlxmkIjTAmsYQLU95geuwo6IAzg70
         4XXNB9yq+wzCq8mfEZ2kxmBdJCjOUf5t2K2Bd8DowN5s/Ch1lS7GeSi2jyFJJ9Xv6FRk
         hdcfMOzclYgjcWL2owWQjBDf4FwlBB2NCcUy0idKi3sEG3N8d1o33A/WYYoZ/8AjuzIx
         A2FaZIHyM8dWBYifcma2YpBtbR55+2jtNrw/dCjl9gKinYMdNCfD0a0BUGhVIGPvPvpM
         7XgqeExVeiUqCH4xSRTzIl+RDHDo5Fys/oDCbYP7taz72g0UFYIsxQVqG0zB9Mpe9g70
         KN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zv6qufaVUoOKfgWnxcMfihvxlvMbtBzB/0Zji8Jvd9U=;
        b=u88/ZzYrKuTvuTJTS5wHxlBe6cpirITeaylrcW16xrbIYPctmb0MfEcDP0E+stRbMJ
         lFnF85uBaK7/pHRRCvquzh0thAypFBoL6xKQHp1NYOYgw3rqt7+SrFWSFaTrOR3eDGo4
         llRB7I/3Tz/vpltR68tOj+y2HPLvvGAh5RdsKEvCe5svzHzFOXK2B9Aq2E+3d1gv6Ucg
         BcpdNh2PFhZCNmJqT/P/cuYprzXDM1+PBgmDUHzz2KDFNrMMrXoliEYPoj4I+byuW3xT
         jXwUNXb+vJkXBEUJO0x8FM51VcapHMbY7pp0WYMOsWeIOqymMhrNTuiUN2jbdk5tsNlX
         QcVA==
X-Gm-Message-State: AFqh2kr4zSvpnOLV+nSDSv7b1czcCvQEp/sjvz2187tf7QhDh+GX5l72
        3I5L4mu4v2yg7DPPHAfl8co=
X-Google-Smtp-Source: AMrXdXs3BDIg4LnDtAmemWahTuYj9ru4xDu+WEeHRgj2mjhYniL+weQdCkXRx/iZVNorpbMTzszV+w==
X-Received: by 2002:a05:600c:1c28:b0:3d3:50b9:b192 with SMTP id j40-20020a05600c1c2800b003d350b9b192mr1077352wms.18.1671302882986;
        Sat, 17 Dec 2022 10:48:02 -0800 (PST)
Received: from localhost.localdomain (host-79-17-30-229.retail.telecomitalia.it. [79.17.30.229])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c020800b003b4935f04a4sm7726062wmi.5.2022.12.17.10.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 10:48:02 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3 0/3] fs/ufs: replace kmap() with kmap_local_page 
Date:   Sat, 17 Dec 2022 19:47:46 +0100
Message-Id: <20221217184749.968-1-fmdefrancesco@gmail.com>
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

Fabio M. De Francesco (3):
  fs/ufs: Use the offset_in_page() helper
  fs/ufs: Change the signature of ufs_get_page()
  fs/ufs: Replace kmap() with kmap_local_page()

 fs/ufs/dir.c | 134 +++++++++++++++++++++++++++------------------------
 1 file changed, 71 insertions(+), 63 deletions(-)

-- 
2.39.0
