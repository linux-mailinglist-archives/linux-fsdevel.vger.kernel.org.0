Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336DD62B889
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 11:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbiKPKcj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 05:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiKPKbn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:31:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A3C2EF1D
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 02:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668594452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/1/81f1bc3wgoHEbP5M1Zz0wSDu9jba91U8WGSjmQ70=;
        b=fYGj02cSbyLDknBriIwlpkOFe3POVgHog4PZhz8VpQFLiekpHMkXEGS1/s0Nqt2aAV7D/n
        g+1oznKBx0236P8xtRj/h5t/RvfS6N9fDskodCcT/S8UFs6/mSE2Bc/ApXDlxeeX+1T9Kt
        vyWK3PgEQ9dafk1D1c4vHIsbb5ec1X8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-ZOxGenHbOYKZhsRLkhfmqA-1; Wed, 16 Nov 2022 05:27:25 -0500
X-MC-Unique: ZOxGenHbOYKZhsRLkhfmqA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71CBB833AED;
        Wed, 16 Nov 2022 10:27:23 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6687D2024CCA;
        Wed, 16 Nov 2022 10:27:02 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Walls <awalls@md.metrocast.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Inki Dae <inki.dae@samsung.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        James Morris <jmorris@namei.org>, Jiri Olsa <jolsa@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kees Cook <keescook@chromium.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Leon Romanovsky <leon@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Nelson Escobar <neescoba@cisco.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tomasz Figa <tfiga@chromium.org>, Will Deacon <will@kernel.org>
Subject: [PATCH mm-unstable v1 00/20] mm/gup: remove FOLL_FORCE usage from drivers (reliable R/O long-term pinning)
Date:   Wed, 16 Nov 2022 11:26:39 +0100
Message-Id: <20221116102659.70287-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For now, we did not support reliable R/O long-term pinning in COW mappings.
That means, if we would trigger R/O long-term pinning in MAP_PRIVATE
mapping, we could end up pinning the (R/O-mapped) shared zeropage or a
pagecache page.

The next write access would trigger a write fault and replace the pinned
page by an exclusive anonymous page in the process page table; whatever the
process would write to that private page copy would not be visible by the
owner of the previous page pin: for example, RDMA could read stale data.
The end result is essentially an unexpected and hard-to-debug memory
corruption.

Some drivers tried working around that limitation by using
"FOLL_FORCE|FOLL_WRITE|FOLL_LONGTERM" for R/O long-term pinning for now.
FOLL_WRITE would trigger a write fault, if required, and break COW before
pinning the page. FOLL_FORCE is required because the VMA might lack write
permissions, and drivers wanted to make that working as well, just like
one would expect (no write access, but still triggering a write access to
break COW).

However, that is not a practical solution, because
(1) Drivers that don't stick to that undocumented and debatable pattern
    would still run into that issue. For example, VFIO only uses
    FOLL_LONGTERM for R/O long-term pinning.
(2) Using FOLL_WRITE just to work around a COW mapping + page pinning
    limitation is unintuitive. FOLL_WRITE would, for example, mark the
    page softdirty or trigger uffd-wp, even though, there actually isn't
    going to be any write access.
(3) The purpose of FOLL_FORCE is debug access, not access without lack of
    VMA permissions by arbitrarty drivers.

So instead, make R/O long-term pinning work as expected, by breaking COW
in a COW mapping early, such that we can remove any FOLL_FORCE usage from
drivers and make FOLL_FORCE ptrace-specific (renaming it to FOLL_PTRACE).
More details in patch #8.

Patches #1--#3 add COW tests for non-anonymous pages.
Patches #4--#7 prepare core MM for extended FAULT_FLAG_UNSHARE support in
COW mappings.
Patch #8 implements reliable R/O long-term pinning in COW mappings
Patches #9--#19 remove any FOLL_FORCE usage from drivers.
Patch #20 renames FOLL_FORCE to FOLL_PTRACE.

I'm refraining from CCing all driver/arch maintainers on the whole patch
set, but only CC them on the cover letter and the applicable patch
(I know, I know, someone is always unhappy ... sorry).

RFC -> v1:
* Use term "ptrace" instead of "debuggers" in patch descriptions
* Added ACK/Tested-by
* "mm/frame-vector: remove FOLL_FORCE usage"
 -> Adjust description
* "mm: rename FOLL_FORCE to FOLL_PTRACE"
 -> Added

David Hildenbrand (20):
  selftests/vm: anon_cow: prepare for non-anonymous COW tests
  selftests/vm: cow: basic COW tests for non-anonymous pages
  selftests/vm: cow: R/O long-term pinning reliability tests for
    non-anon pages
  mm: add early FAULT_FLAG_UNSHARE consistency checks
  mm: add early FAULT_FLAG_WRITE consistency checks
  mm: rework handling in do_wp_page() based on private vs. shared
    mappings
  mm: don't call vm_ops->huge_fault() in wp_huge_pmd()/wp_huge_pud() for
    private mappings
  mm: extend FAULT_FLAG_UNSHARE support to anything in a COW mapping
  mm/gup: reliable R/O long-term pinning in COW mappings
  RDMA/umem: remove FOLL_FORCE usage
  RDMA/usnic: remove FOLL_FORCE usage
  RDMA/siw: remove FOLL_FORCE usage
  media: videobuf-dma-sg: remove FOLL_FORCE usage
  drm/etnaviv: remove FOLL_FORCE usage
  media: pci/ivtv: remove FOLL_FORCE usage
  mm/frame-vector: remove FOLL_FORCE usage
  drm/exynos: remove FOLL_FORCE usage
  RDMA/hw/qib/qib_user_pages: remove FOLL_FORCE usage
  habanalabs: remove FOLL_FORCE usage
  mm: rename FOLL_FORCE to FOLL_PTRACE

 arch/alpha/kernel/ptrace.c                    |   6 +-
 arch/arm64/kernel/mte.c                       |   2 +-
 arch/ia64/kernel/ptrace.c                     |  10 +-
 arch/mips/kernel/ptrace32.c                   |   4 +-
 arch/mips/math-emu/dsemul.c                   |   2 +-
 arch/powerpc/kernel/ptrace/ptrace32.c         |   4 +-
 arch/sparc/kernel/ptrace_32.c                 |   4 +-
 arch/sparc/kernel/ptrace_64.c                 |   8 +-
 arch/x86/kernel/step.c                        |   2 +-
 arch/x86/um/ptrace_32.c                       |   2 +-
 arch/x86/um/ptrace_64.c                       |   2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.c         |   8 +-
 drivers/gpu/drm/exynos/exynos_drm_g2d.c       |   2 +-
 drivers/infiniband/core/umem.c                |   8 +-
 drivers/infiniband/hw/qib/qib_user_pages.c    |   2 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c      |   9 +-
 drivers/infiniband/sw/siw/siw_mem.c           |   9 +-
 drivers/media/common/videobuf2/frame_vector.c |   2 +-
 drivers/media/pci/ivtv/ivtv-udma.c            |   2 +-
 drivers/media/pci/ivtv/ivtv-yuv.c             |   5 +-
 drivers/media/v4l2-core/videobuf-dma-sg.c     |  14 +-
 drivers/misc/habanalabs/common/memory.c       |   3 +-
 fs/exec.c                                     |   2 +-
 fs/proc/base.c                                |   2 +-
 include/linux/mm.h                            |  35 +-
 include/linux/mm_types.h                      |   8 +-
 kernel/events/uprobes.c                       |   4 +-
 kernel/ptrace.c                               |  12 +-
 mm/gup.c                                      |  38 +-
 mm/huge_memory.c                              |  13 +-
 mm/hugetlb.c                                  |  14 +-
 mm/memory.c                                   |  97 +++--
 mm/util.c                                     |   4 +-
 security/tomoyo/domain.c                      |   2 +-
 tools/testing/selftests/vm/.gitignore         |   2 +-
 tools/testing/selftests/vm/Makefile           |  10 +-
 tools/testing/selftests/vm/check_config.sh    |   4 +-
 .../selftests/vm/{anon_cow.c => cow.c}        | 387 +++++++++++++++++-
 tools/testing/selftests/vm/run_vmtests.sh     |   8 +-
 39 files changed, 575 insertions(+), 177 deletions(-)
 rename tools/testing/selftests/vm/{anon_cow.c => cow.c} (75%)

-- 
2.38.1

