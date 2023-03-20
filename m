Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B272C6C25EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 00:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCTXoX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 19:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCTXoU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:44:20 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900E21CAFB;
        Mon, 20 Mar 2023 16:43:43 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o40-20020a05600c512800b003eddedc47aeso3053087wms.3;
        Mon, 20 Mar 2023 16:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679355775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aPQG/I/mhAvQC4xeeznjLyrdZONKek1qCY1BYNNuVGw=;
        b=hBKYIOkkfobPOor7ReMCrt7R/APu69Pn4BJpGo/9oflmlHdVtXJGb8EauDM+ueIWcE
         aEJW9pLLVIjPs70C6QZEsvrpd/dsWjCMQ/QSAWBQ4H0S4o6EzOK1zMscFf+JRpD+1WTM
         rgbvF//M5D17ecnc/LVfbJhoEShmR2UfaGs55FqvuZCFnrKfsZCYsnyNPnVRJYZKhdNl
         CQd5EL2C2rm5i4ZdVKKfvBGTWcN4vByDq/hyypqkGcNx30MMQUhnce51iOHJ7RL9gTN2
         ZnjNd+OlZBCZbleglq+pfsAlG/V8ms9WrUuo22u9hBE60uA3s8VDThehSXKqXBK2qXTe
         XWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679355775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aPQG/I/mhAvQC4xeeznjLyrdZONKek1qCY1BYNNuVGw=;
        b=QOP8yaVu3d4az6uqsTlbv13OzY9M9VSWQP2D6rfr98bXAqivpeC1tViFUZAVeEFoHp
         ndq6zK/oARseff4JHu9odjRxToiJricbZdp/9dt6AHAWC3o94sj0U+9xw/aqgREL9CTe
         gmujtiv8qqw0BHJ+2TaoSySZrpZNv6B3U3BiY4fpdb2No6+OOLX2TiaAflaxutLARm+t
         hx7An8VOvT623yY8BI7rMVd29JzSh+ku1kBEbXpRNuBsOPDAs/UG9yRXuertSkkKXhye
         U3lvekz7o16dZrBSQsj2Z+ow3kpBODGphQ7Pl6WCKU/ibRNrjhs36arONOtpr+lqIK8h
         I6jw==
X-Gm-Message-State: AO0yUKXPFgzYjcCcOgPShM+a50OmBn1vXjZXlp1qbmkYkM5GCU/W3GHS
        xVDa3NJZNkoAHjztow/fUzM=
X-Google-Smtp-Source: AK7set8uPDcbvle2xiXNDQ1TbFeBZlmpL7r2uUyucIn52DSXIFQckL3tCLQSdqrhjoQy+ZIwrJE6WA==
X-Received: by 2002:a1c:6a08:0:b0:3ea:ed4d:38eb with SMTP id f8-20020a1c6a08000000b003eaed4d38ebmr869636wmc.24.1679355774582;
        Mon, 20 Mar 2023 16:42:54 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id u1-20020a05600c440100b003e209186c07sm17504541wmn.19.2023.03.20.16.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 16:42:52 -0700 (PDT)
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
Subject: [PATCH v3 0/4] convert read_kcore(), vread() to use iterators
Date:   Mon, 20 Mar 2023 23:42:41 +0000
Message-Id: <cover.1679354384.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

v2:
- Fix ordering of vread_iter() parameters
- Fix nommu vread() -> vread_iter()
https://lore.kernel.org/all/cover.1679209395.git.lstoakes@gmail.com/

v1:
https://lore.kernel.org/all/cover.1679183626.git.lstoakes@gmail.com/

Lorenzo Stoakes (4):
  fs/proc/kcore: Avoid bounce buffer for ktext data
  fs/proc/kcore: convert read_kcore() to read_kcore_iter()
  iov_iter: add copy_page_to_iter_atomic()
  mm: vmalloc: convert vread() to vread_iter()

 fs/proc/kcore.c         |  89 ++++++---------
 include/linux/uio.h     |   2 +
 include/linux/vmalloc.h |   3 +-
 lib/iov_iter.c          |  28 +++++
 mm/nommu.c              |  10 +-
 mm/vmalloc.c            | 234 +++++++++++++++++++++++++---------------
 6 files changed, 218 insertions(+), 148 deletions(-)

--
2.39.2
