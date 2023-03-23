Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F786C6490
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 11:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjCWKP1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 06:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjCWKPZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:15:25 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F2C1ADC5;
        Thu, 23 Mar 2023 03:15:24 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so718984wmq.3;
        Thu, 23 Mar 2023 03:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679566522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FYs0HNDKIjrbcHM960jzzYGdPLX0yWmJ512l9ylAAsA=;
        b=LKYKTn/mAihd2Bc4LkHcL7PhZ42dOCwu8amQKMAtuqOVRW3CRd/8Z0qV1wzmwhVchw
         4r9oaTWN6QA2gdI2/NID/KnImI2llCWGPHflnXNwo8UHDquvblu9Pq+gOOof7x+Thy2f
         BMAFndZctNaBWfo/pst6Kcl7aoJsRdM10aS6hUCzqdb41tPABOljDMbnj4kh2WYwtHhs
         VMEkmOGSy5PcykxTMW1tfW6lPFjJcrs6JtZBZRiO+iKfrKBvlE31K14xQp0qLTCnfTMP
         dfybgCDKTkDlk5oV4k45WWo4YsSYuRgJ0FdLeNDUBuOwl85n2av62ISun5IGNNgnJSmk
         Sixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679566522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYs0HNDKIjrbcHM960jzzYGdPLX0yWmJ512l9ylAAsA=;
        b=R3QDX7LKE8nN8QlEDYYbTmbMXrE2o6ir4MP7/qW8wWiu2Z1xVoYdNznkRn2GUKNdwX
         9ZISU6gIXWLeH+0mQvBAxqipbpcRatUBrCSrbyGr9bX6qDEBvT3ACMasMn2RXMpO2ebi
         cxO0EM4f1EptStJPNwjAxbIbOuXBPiLTe8SxUGwVydICW22dVVHLid7EAv7VK1hQF4Pf
         kO5D7/OggMK5MSEfoleFs59HQSUBsJvojVzumrQrUgFJexrEIxDl6J/a5IA0ULCm5ItC
         eknZhVP3U7MgYBUZBUR61KGXVeOargtgNpaMIVYVDkI3tIgDQnMLUhiVu9qX9d+oMfiE
         s1wg==
X-Gm-Message-State: AO0yUKWKzbhJyTlSMtte3WyAIyATD67lwsZF1XoxKOKI4yoCrd6znwUL
        6omSvw96KWTs4ALToB1Y95w=
X-Google-Smtp-Source: AK7set+u3N9pK0uVUfLJoYX7FdNxrz5SxQIAIYF5d0P5xpI2bb78fwkUwtAVU91EarVqyF4a083v+w==
X-Received: by 2002:a05:600c:3781:b0:3ee:5d1d:6c2d with SMTP id o1-20020a05600c378100b003ee5d1d6c2dmr1834876wmr.35.1679566522345;
        Thu, 23 Mar 2023 03:15:22 -0700 (PDT)
Received: from lucifer.home (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.googlemail.com with ESMTPSA id f18-20020a05600c155200b003ede2c59a54sm1416952wmg.37.2023.03.23.03.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:15:21 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v8 0/4] convert read_kcore(), vread() to use iterators
Date:   Thu, 23 Mar 2023 10:15:15 +0000
Message-Id: <cover.1679566220.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While reviewing Baoquan's recent changes to permit vread() access to
vm_map_ram regions of vmalloc allocations, Willy pointed out [1] that it
would be nice to refactor vread() as a whole, since its only user is
read_kcore() and the existing form of vread() necessitates the use of a
bounce buffer.

This patch series does exactly that, as well as adjusting how we read the
kernel text section to avoid the use of a bounce buffer in this case as
well.

This has been tested against the test case which motivated Baoquan's
changes in the first place [2] which continues to function correctly, as do
the vmalloc self tests.

[1] https://lore.kernel.org/all/Y8WfDSRkc%2FOHP3oD@casper.infradead.org/
[2] https://lore.kernel.org/all/87ilk6gos2.fsf@oracle.com/T/#u

v8:
- Make zero_iter() static.

v7:
- Keep trying to fault in memory until the vmalloc read operation
  completes.
https://lore.kernel.org/all/cover.1679511146.git.lstoakes@gmail.com/

v6:
- Correct copy_page_to_iter_nofault() to handle -EFAULT case correctly.
https://lore.kernel.org/all/cover.1679496827.git.lstoakes@gmail.com/

v5:
- Do not rename fpos to ppos in read_kcore_iter() to avoid churn.
- Fix incorrect commit messages after prior revisions altered the approach.
- Replace copy_page_to_iter_atomic() with copy_page_to_iter_nofault() and
  adjust it to be able to handle compound pages. This uses
  copy_to_user_nofault() which ensures page faults are disabled during copy
  which kmap_local_page() was not doing.
- Only try to fault in pages if we are unable to copy in the first place
  and try only once to avoid any risk of spinning.
- Do not zero memory in aligned_vread_iter() if we couldn't copy it.
- Fix mistake in zeroing missing or unpopulated blocks in
  vmap_ram_vread_iter().
https://lore.kernel.org/linux-mm/cover.1679494218.git.lstoakes@gmail.com/

v4:
- Fixup mistake in email client which orphaned patch emails from the
  cover letter.
https://lore.kernel.org/all/cover.1679431886.git.lstoakes@gmail.com

v3:
- Revert introduction of mutex/rwsem in vmalloc
- Introduce copy_page_to_iter_atomic() iovec function
- Update vread_iter() and descendent functions to use only this
- Fault in user pages before calling vread_iter()
- Use const char* in vread_iter() and descendent functions
- Updated commit messages based on feedback
- Extend vread functions to always check how many bytes we could copy. If
  at any stage we are unable to copy/zero, abort and return the number of
  bytes we did copy.
https://lore.kernel.org/all/cover.1679354384.git.lstoakes@gmail.com/

v2:
- Fix ordering of vread_iter() parameters
- Fix nommu vread() -> vread_iter()
https://lore.kernel.org/all/cover.1679209395.git.lstoakes@gmail.com/

v1:
https://lore.kernel.org/all/cover.1679183626.git.lstoakes@gmail.com/

Lorenzo Stoakes (4):
  fs/proc/kcore: avoid bounce buffer for ktext data
  fs/proc/kcore: convert read_kcore() to read_kcore_iter()
  iov_iter: add copy_page_to_iter_nofault()
  mm: vmalloc: convert vread() to vread_iter()

 fs/proc/kcore.c         |  85 +++++++--------
 include/linux/uio.h     |   2 +
 include/linux/vmalloc.h |   3 +-
 lib/iov_iter.c          |  48 +++++++++
 mm/nommu.c              |  10 +-
 mm/vmalloc.c            | 234 +++++++++++++++++++++++++---------------
 6 files changed, 243 insertions(+), 139 deletions(-)

--
2.39.2
