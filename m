Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B176C4D56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 15:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjCVOTT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 10:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjCVOTE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:19:04 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453E55650C;
        Wed, 22 Mar 2023 07:19:03 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id az3-20020a05600c600300b003ed2920d585so13133788wmb.2;
        Wed, 22 Mar 2023 07:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679494741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wm1gEgpO8Vn1aWhx1/jlEqhlPh3aI7HtjbvGUfjefuk=;
        b=i3nVVRWTQgwdnWITBu23k290kSnKMj2TNEvKayCNgzRqcYLCOV+kv5QmGILNg6F9wt
         8MGrp6lEsoDvw0/jIE69h6gIoSIF+YW8euwTyCv2SNHTwhupcF+NpTYyf7PgBzeob+yG
         wEORqQux6xOH3P0XhS8enz9P3G9JGlxR33Mird5TOtdfBgHNKdlg0G2Gerj69B0zlZyl
         qOvTNaDdN/iXF8Xem6nLBbpL9jdnRebSUiHNohdQFyJWQHYXyxWdGJYW8RC0tkJfWaAM
         0WzpURlIslSn9NMtjaO4+qskq0m7E8qmUxcaqBRwRtq1UG2knl2cqNc1qmMg64jp2WmW
         gQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679494741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wm1gEgpO8Vn1aWhx1/jlEqhlPh3aI7HtjbvGUfjefuk=;
        b=4NsWt57dapBVn/xuU0wajJkHrLOYzTK5gpbb4pwniGalHprRoE9N5SyTRJUJGm3Ajm
         Wyq2fXiKhobBxhGuMWj53L0qedGwissr15VtNA0FvXsshDd5OgvdJVJrqfXqvNSupM8t
         FrndEckicyyQIlY1sCC4DKiidc7ZrRx4101lcDcghBQZoK1vuNHUyRtQ+lbXcUvGYSOq
         zA2w2TCNQDNtOHWFq4ptQiri2QyPVbmAbcZb75yvJZfCuOO3lABzfKLkN1YgIz2gTGCC
         IKoXtKsVCB5HaWaFdhwYEJ6umL06BEtwtrmTCG/nLXpsqJgsBdCSJFLYxmMCLCtYZa2Z
         C5qA==
X-Gm-Message-State: AO0yUKUGmn9FH/hDYUXd69LKv3LifMy5oye2Btno4UXCA5wIPyQN5uAh
        1j6CACMV4IorLVIEpvU3TdI=
X-Google-Smtp-Source: AK7set9BcKX3Nn/5N8OPLr+LJi+LLJpc9u92dW88s8ljGSaW+vyt1D3Yte6/zwyAfZ/OlLoz1moRJA==
X-Received: by 2002:a05:600c:218f:b0:3e9:f15b:935b with SMTP id e15-20020a05600c218f00b003e9f15b935bmr5187896wme.32.1679494741327;
        Wed, 22 Mar 2023 07:19:01 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id f20-20020a7bcd14000000b003e203681b26sm16872855wmj.29.2023.03.22.07.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:19:00 -0700 (PDT)
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
Subject: [PATCH v5 0/4] convert read_kcore(), vread() to use iterators
Date:   Wed, 22 Mar 2023 14:18:47 +0000
Message-Id: <cover.1679494218.git.lstoakes@gmail.com>
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
 lib/iov_iter.c          |  36 +++++++
 mm/nommu.c              |  10 +-
 mm/vmalloc.c            | 234 +++++++++++++++++++++++++---------------
 6 files changed, 224 insertions(+), 139 deletions(-)

--
2.39.2
