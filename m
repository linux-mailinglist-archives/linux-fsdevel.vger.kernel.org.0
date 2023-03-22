Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0F96C4EA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 15:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjCVO4R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 10:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjCVOzz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:55:55 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6510476B8;
        Wed, 22 Mar 2023 07:55:34 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m35so11725440wms.4;
        Wed, 22 Mar 2023 07:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679496933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S0jzfl8zYgnt4u77SA/RKleSL52i8/7auCWoYemv5LQ=;
        b=QGIdPC+aai08tzMB75tJBk5h5rw0YfB4Hu59Nebsl30NRcDrEE2RPuoU4Z0qQxaiGg
         63eso4kAHq7v5w/8B+nWXbQiCrusXBTaO/S8rFVW1gLebge4EeTreG17HinOYDWCFdRA
         b58oceYeN5p4Yau4AOSaF7lVoIpyortoEulOJ4C8e2MesjuAPGSxY2uqZ7Uh+YqmQfq5
         CVzECfeNq5yU/+xfM/BmreN46P7Y3Z+7X1z0DKHUfCJI+RIe6z75rQCs3qkB9dzgwJ8g
         f4YmrjScouZT3ypPFhw7HMX6dUvmC1kHUXwacOFz1LdbC8ob1MzZluIv9kfTFrCiqMLi
         R6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679496933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0jzfl8zYgnt4u77SA/RKleSL52i8/7auCWoYemv5LQ=;
        b=bRF7PwFOy6OtgG4PN8Bxxv7QkU0sjyl2zk2Yn8BDBxapG53qC/Omcbqhffuc+lCWb0
         dyMpsdn+UhMyUlmdZ9UB8RuoGK1cUFPclLMKyqLsBOwiEzjtKo7Yx/6X17Gck0JA54ZN
         DccF1xhHm2Uj07fyQYozFwbUvzbuE0QdMc+9235l4OUa7XePVKwHvFnvpQi2NZlmVSzu
         tYUmsY33YsM3ln8i6XrjAhi+q+y/RIEZyQ/53xRUgjmr0eS0LeGOjYmCQ9PkdyZ179gL
         mIPzQQ2iDlnEN5ioz1zJiSVkeVjZ5jidOHAQ52NtarbppMREWxi1KKCZIJ7F0H55buBB
         /L3Q==
X-Gm-Message-State: AO0yUKWvR8N3q6C6W7UTYjBfCVK3SPujd4MkK3AZXzZePZtWy/aFuVtQ
        sM6HAEwyfDAKEyKyFyrFR4k=
X-Google-Smtp-Source: AK7set+BvPRQcF2S+lEhoUuE5DF64BfRAwgDpCTEMyODUlMPjxVuKCtt+SKVaYDDMUYFQYqc4IldDA==
X-Received: by 2002:a05:600c:35cd:b0:3ee:534:9eba with SMTP id r13-20020a05600c35cd00b003ee05349ebamr1909798wmq.6.1679496932905;
        Wed, 22 Mar 2023 07:55:32 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id n23-20020a7bcbd7000000b003ed243222adsm16812246wmi.42.2023.03.22.07.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:55:31 -0700 (PDT)
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
Subject: [PATCH v6 0/4] convert read_kcore(), vread() to use iterators
Date:   Wed, 22 Mar 2023 14:55:24 +0000
Message-Id: <cover.1679496827.git.lstoakes@gmail.com>
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

v6:
- Correct copy_page_to_iter_nofault() to handle -EFAULT case correctly.

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

 fs/proc/kcore.c         |  78 ++++++--------
 include/linux/uio.h     |   2 +
 include/linux/vmalloc.h |   3 +-
 lib/iov_iter.c          |  48 +++++++++
 mm/nommu.c              |  10 +-
 mm/vmalloc.c            | 234 +++++++++++++++++++++++++---------------
 6 files changed, 236 insertions(+), 139 deletions(-)

--
2.39.2
