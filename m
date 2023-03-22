Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65916C5454
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 19:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjCVS6O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 14:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCVS5x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:57:53 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B1F6A1E1;
        Wed, 22 Mar 2023 11:57:09 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r11so1363205wrr.12;
        Wed, 22 Mar 2023 11:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679511428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O7cV1QbInTQjJtzeE/b3ZWPRCE1tzxKhXLPOk2iS96Y=;
        b=lwR1yAIxa+PJLZmURfTDCdjRJ8kb6RJ1/jC7Oz9od+xaLeRCZKoHP6gy6mNA4zwLte
         gp+SMf7KBZphiB4rQW54LAtZ9MfopJ6Gen52h3mQNduR8mHjASyqkfHJNfaioX4Se+Lh
         JkECL9YKOUvzDYUymyAxPoywIhrn0pNn+svKU7FJbBTRQBshpKsXKIzuPuuuRaTlxwB9
         DkR4PvzgPP/kcTZ0GP7QkUUixeP3iE3Bpizx7cRLZHVV7PzG2UFd5vG2b63OymmoIEn8
         7ZzdSL76FrlWoQx2QZJb2FAkQ4yXW2CnFYqWvwzRMOttda78sDsScgldq3zhmfq+nSl2
         Vk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679511428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7cV1QbInTQjJtzeE/b3ZWPRCE1tzxKhXLPOk2iS96Y=;
        b=iMlUdoU6a804qCC2peq0BIKbDUUIFPy6a0KS6ULsOhMsWaneOUGF/sjkCsnFA7Bs/G
         XZ+FxkxgI8byPW+bAkb3M7PF6YsUsaxqKNVlojwhQPLVnkrR2UVFuOZsVxrQdxrwwyZ5
         vwN9UMgCdWUGxJC1qT3xIHLfZpB2DPX85kB3RoL8HzNxvn8oQFl2p3DJn92tzEwMVjoI
         yx7VXqmqjy3dQaywVCD5UEtagDFL1bN/Wu4WOdKPNUZdA19eoCD8Tk7CVtW4Ngcfn/bF
         2jOZto8wcRShUHSJevg1WFWBUV5BkC1dUH463k3CKSv9V7GPU2T1mmMKSUhSoB0d6HMh
         FL1Q==
X-Gm-Message-State: AAQBX9c/j0kAw1FJ/uWne6dIuOwAfK0eC4Dk9tFtX2/09tQM/dCtdCaH
        zCCB96gJyPCg8dYFC884Xls=
X-Google-Smtp-Source: AKy350ZJCOcXJSzll3ASLGVbTyWiQmIo3Ow/9c+euL9xjyhgaXtDeadVnL0MpwA1euKK2o0hFh5ovA==
X-Received: by 2002:a5d:5502:0:b0:2cf:ed9c:afa with SMTP id b2-20020a5d5502000000b002cfed9c0afamr616420wrv.51.1679511427647;
        Wed, 22 Mar 2023 11:57:07 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id j21-20020a05600c42d500b003ee581f37a9sm3181241wme.10.2023.03.22.11.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 11:57:06 -0700 (PDT)
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
Subject: [PATCH v7 0/4] convert read_kcore(), vread() to use iterators
Date:   Wed, 22 Mar 2023 18:57:00 +0000
Message-Id: <cover.1679511146.git.lstoakes@gmail.com>
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

v7:
- Keep trying to fault in memory until the vmalloc read operation
  completes.

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
