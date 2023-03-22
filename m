Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0E76C4D4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 15:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjCVORp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 10:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCVORn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:17:43 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDBA3A870;
        Wed, 22 Mar 2023 07:17:40 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso1805110wms.1;
        Wed, 22 Mar 2023 07:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679494659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wm1gEgpO8Vn1aWhx1/jlEqhlPh3aI7HtjbvGUfjefuk=;
        b=I+TiJfxCnhMdPxfbKKNZAHPoiViehkAxhd3pdH+LbUn8Wf5uH2cVN2Rq/bJzSFN6Pd
         5iVwfwN22RqG1rHKv6w8wmvo0sCXnBDFOMdbl7pG0wx7P/R73ZX/daJgpQ3B8NTa7jhe
         Ts9qz4l88vSc0aCiBxC/8cJxk+b/1Yb1bsD14ly9rv2OwWsIw3Ra9H6lWxPOUiLvppwx
         1i+1W4lFGHybdMrndjzvvd3QBNU4ZfH8M/KK2IArxiDMhPTypO4EyzO1nhJdc5g9FFx4
         YRw9wD8sG3OyAZHBNUUWAhsX+8ujffRBfvDrZV7ydXa9wEplSb5qoBgiIuGFseLes/QF
         qK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679494659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wm1gEgpO8Vn1aWhx1/jlEqhlPh3aI7HtjbvGUfjefuk=;
        b=oXUfbIXokotRvU67EbJi+kUwwjotA3Tu2TdFOOykTyhckeqGizV8s56HBU4htlW9Ec
         FW/TDOJW8LgoJY/dCRiQURo0sUA2RzgyJjMWLRLYHv1taU0iR9Q9ksN68gPb2tDoRn+D
         ZzevkZVKVhnHsh86W2VgBRGyjJw2yEmiyRHXoCrOJbMzG1MYPo3h+a1iJXiiplWiS0m1
         xf715A658VmIOTlPeqYx4YH1Wt/D0G/FymXS+W9BMFwk7rfuUpjRTU6FUdy7NIvfjFeZ
         a5Bvb3/60nXTi0rcAUyrbRfsRYUoSwYPPWfdrGjgj/ZLLdiiwl+3LQ4rXtE6XxGSygHn
         r5iA==
X-Gm-Message-State: AO0yUKWArTpd+Pe4IiITvVWTYb7AWgFV45mf0QUj25zhN8CO9m/q/jSr
        kW2I/EgPbjBXOCd9nNVgZrHQlkFV6Hw=
X-Google-Smtp-Source: AK7set+ipKtD0Wir6g+M24jTGeJiII8+dCbOcCWZcovGSONqn+YXHXRjrEIKtv5GgV20uDY2+MmeGQ==
X-Received: by 2002:a05:600c:2293:b0:3ed:a80e:6dfa with SMTP id 19-20020a05600c229300b003eda80e6dfamr4843778wmf.40.1679494658754;
        Wed, 22 Mar 2023 07:17:38 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id h20-20020a1ccc14000000b003dc522dd25esm16824893wmb.30.2023.03.22.07.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:17:37 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v5 0/4] convert read_kcore(), vread() to use iterators
Date:   Wed, 22 Mar 2023 14:17:31 +0000
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
