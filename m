Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FC07A0912
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 17:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240877AbjINP0a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 11:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240806AbjINP03 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:26:29 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4E01FD0
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 08:26:25 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59224c40275so15498867b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 08:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694705184; x=1695309984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RQOs579jB3ePn++NtGKTs4Zt+LBBSKWi+6qtOEbCDCw=;
        b=qLSntHFHJgkuaqAF14uUzxxSI5eNukbTiepT8NtNKvByHuac2MbXf3fx/KSBWgxwoe
         ZojTQiw6bBaKi2W4YsCHTro5vVFMlj6YrjXxnw380eC9BxvTfkPpsDs5ra0T2b2NXugJ
         In68splWFzUGda1jichikhJ+ufv23dLckDVTi4S9rOdf15FiWM9CxtTrWMJam442bJY9
         /KwlecHFrLSS986oee/on0BbNASaKah3yN0iRt2OPwz17v5KOvDtwtGWodArXI1phrL4
         dLR1/mqujwbxCacdx+1ji2kWskakFNM+CFDoX8J4QmxPvf0aFXkem4opW5Y38HONe35V
         6/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694705184; x=1695309984;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQOs579jB3ePn++NtGKTs4Zt+LBBSKWi+6qtOEbCDCw=;
        b=nkp+NJJ2oxorICnFwFLrzpvOuJ3GwEfOrZOCjPxq6dOQBh1zyhwdGLQZeMc08Z+fbJ
         0PRIUPL8qgDuOxK6PAm2e6xeWD9jUF3GQA2tXUsBYO953vj9C7xn5Nn7wRBw+2y7WhKM
         tlnPp/oWvtj4s2m/lQV1Bjv4ivPbXBgPXii6rIv/78hjjNcADELSCymtG9bn90DuT8ek
         gxI8z5MPMvK19O58HU+nNaSL8FKHUUYE9mW6eRFp1Uh/gjBTB6/2TRVXj7GtvQ2eFRi/
         CNBrwAQHoraxI1zlYz08mpDQtXluP0+lmMk0OZkvguhYj0Tp/1T3AH8PoQuOsFBTCmnG
         /Xiw==
X-Gm-Message-State: AOJu0YzE/th8ZQWx0NzgAlH2ZaZjUxRrv1aSmnYatN1KvNppASoB8wn/
        VeVMytQ1Um1Nd09dUncwEnWN1cBSBEI=
X-Google-Smtp-Source: AGHT+IHpgG/2V5r0nUrZtDSSc5XIPL/tp2CusRPSGOiITv48aOuJ2ChFrY99OLcqYNplN5whp/meeAEFRXw=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:405c:ba64:810f:5fee])
 (user=surenb job=sendgmr) by 2002:a81:fe07:0:b0:59b:e684:3c7a with SMTP id
 j7-20020a81fe07000000b0059be6843c7amr79006ywn.4.1694705184355; Thu, 14 Sep
 2023 08:26:24 -0700 (PDT)
Date:   Thu, 14 Sep 2023 08:26:10 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230914152620.2743033-1-surenb@google.com>
Subject: [PATCH 0/3] userfaultfd remap option
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
        david@redhat.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, surenb@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series introduces UFFDIO_REMAP feature to userfaultfd, which
has long been implemented and maintained by Andrea in his local tree [1],
but was not upstreamed due to lack of use cases where this approach would
be better than allocating a new page and copying the contents.

UFFDIO_COPY performs ~20% better than UFFDIO_REMAP when the application
needs pages to be allocated [2]. However, with UFFDIO_REMAP, if pages are
available (in userspace) for recycling, as is usually the case in heap
compaction algorithms, then we can avoid the page allocation and memcpy
(done by UFFDIO_COPY). Also, since the pages are recycled in the
userspace, we avoid the need to release (via madvise) the pages back to
the kernel [3].
We see over 40% reduction (on a Google pixel 6 device) in the compacting
thread=E2=80=99s completion time by using UFFDIO_REMAP vs. UFFDIO_COPY. Thi=
s was
measured using a benchmark that emulates a heap compaction implementation
using userfaultfd (to allow concurrent accesses by application threads).
More details of the usecase are explained in [3].

Furthermore, UFFDIO_REMAP enables remapping swapped-out pages without
touching them within the same vma. Today, it can only be done by mremap,
however it forces splitting the vma.

Main changes since Andrea's last version [1]:
1. Trivial translations from page to folio, mmap_sem to mmap_lock
2. Replace pmd_trans_unstable() with pte_offset_map_nolock() and handle its
possible failure
3. Move pte mapping into remap_pages_pte to allow for retries when source
page or anon_vma is contended. Since pte_offset_map_nolock() start RCU
read section, we can't block anymore after mapping a pte, so have to unmap
the ptesm do the locking and retry.
4. Add and use anon_vma_trylock_write()  to avoid blocking while in RCU
read section.
5. Accommodate changes in mmu_notifier_range_init() API, switch to
mmu_notifier_invalidate_range_start_nonblock() to avoid blocking while in
RCU read section.
6. Open-code now removed __swp_swapcount()
7. Replace pmd_read_atomic() with pmdp_get_lockless()
8. Add new selftest for UFFDIO_REMAP

[1] https://gitlab.com/aarcange/aa/-/commit/2aec7aea56b10438a3881a20a411aa4=
b1fc19e92
[2] https://lore.kernel.org/all/1425575884-2574-1-git-send-email-aarcange@r=
edhat.com/
[3] https://lore.kernel.org/linux-mm/CA+EESO4uO84SSnBhArH4HvLNhaUQ5nZKNKXqx=
RCyjniNVjp0Aw@mail.gmail.com/

Andrea Arcangeli (2):
  userfaultfd: UFFDIO_REMAP: rmap preparation
  userfaultfd: UFFDIO_REMAP uABI

Suren Baghdasaryan (1):
  selftests/mm: add UFFDIO_REMAP ioctl test

 fs/userfaultfd.c                             |  49 ++
 include/linux/rmap.h                         |   5 +
 include/linux/userfaultfd_k.h                |  17 +
 include/uapi/linux/userfaultfd.h             |  22 +
 mm/huge_memory.c                             | 118 ++++
 mm/khugepaged.c                              |   3 +
 mm/rmap.c                                    |  13 +
 mm/userfaultfd.c                             | 586 +++++++++++++++++++
 tools/testing/selftests/mm/uffd-common.c     |  34 +-
 tools/testing/selftests/mm/uffd-common.h     |   1 +
 tools/testing/selftests/mm/uffd-unit-tests.c |  62 ++
 11 files changed, 908 insertions(+), 2 deletions(-)

--=20
2.42.0.283.g2d96d420d3-goog

