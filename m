Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C59850C451
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 01:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbiDVWif (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 18:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbiDVWh7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:37:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97239288ED2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 14:30:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f14-20020a5b0c0e000000b00641d371d9c8so8262071ybq.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 14:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SZmluZmQNNsXve64J622YTKh8VersM5cFsD6n/swy/o=;
        b=CwnEIUaF3mjN6791/zZx82W3m8Exz8sNaQFrvncFQdFNqY6vXWH9txSyPZcUa6s7zU
         FquAT5n+wNVDvxWTlzo/RUKpWYw1yMbTjAi8NIpj3NafWQdtSPuuty+uwNLUlt3AAtCw
         jtKplPIzTy3XtR5yJLijXD/YaGEGMs/5YGMxvcQ693F7IcnH/6dvsTUROAOwAkt1zWPU
         F9o0CFhL2LLdc0Ux7YGm7rSheRQi84Z9fILU+CiARmFTzIMZxSnIL/U4i78zi2Y05eOt
         a8PrneNMF+e6r6JMUvT7IhY1+7LEt4a/J2MV0mLR6CN+mSjFjG2HxzZKsOT0hNGpM/Iq
         M/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SZmluZmQNNsXve64J622YTKh8VersM5cFsD6n/swy/o=;
        b=zGpER0TFYuAuSHD9KE5ySKwiv2CVxLqrcVX41efKZDb9DAe/Bf+rBisR18azqpyPuC
         000JIKDYXcERg+MU0HrjN0ZaFb270PyLU843ssGOp/nDvzjemDuDj3N0yTW/R7VvUtuW
         g1kK74EyqRMN+izqrAXVAuuobvWsl3ezAIEm3lykY6whiuQRFeVfkLbGwVF/0kosnQ1+
         MbSMa7AHrjcxfm+VLhRqtJv/pg954xn52l7l+ZVSfEijtMtVlPD9j6KrWNvJwUfHRddi
         e7gcoofaM2BHWe3fsz996PgmHnLMtAtzUY4+G+gc+El6AxYZDg8DX3m0hL9FFF5KJLc0
         PQdw==
X-Gm-Message-State: AOAM531tMYsDGlaCQDMqosDiF/QPUN61fVDsKGk2b0YhrUoDA0umqjRh
        wJP6lFyd7t2hQS7TIfzLYzSjw2ugva385V2/Ly2A
X-Google-Smtp-Source: ABdhPJyQekwJggjgopvUAQj4NzrkTcMUe5kxTBnnnRYDiIgpf9GP2ohyRZR4/MzEbrDU4XLJ7n4OkBFO7wDmylaZWt9p
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:7ba6:20ac:a8f7:1dbd])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6902:84:b0:63d:4a3d:eb5 with
 SMTP id h4-20020a056902008400b0063d4a3d0eb5mr6809723ybs.145.1650663004873;
 Fri, 22 Apr 2022 14:30:04 -0700 (PDT)
Date:   Fri, 22 Apr 2022 14:29:45 -0700
In-Reply-To: <20220422212945.2227722-1-axelrasmussen@google.com>
Message-Id: <20220422212945.2227722-7-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220422212945.2227722-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v2 6/6] selftests: vm: add /dev/userfaultfd test cases to run_vmtests.sh
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, zhangyi <yi.zhang@huawei.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This new mode was recently added to the userfaultfd selftest. We want to
exercise both userfaultfd(2) as well as /dev/userfaultfd, so add both
test cases to the script.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/run_vmtests.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index 5065dbd89bdb..57f01505c719 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -121,12 +121,17 @@ run_test ./gup_test -a
 run_test ./gup_test -ct -F 0x1 0 19 0x1000
 
 run_test ./userfaultfd anon 20 16
+run_test ./userfaultfd anon:dev 20 16
 # Hugetlb tests require source and destination huge pages. Pass in half the
 # size ($half_ufd_size_MB), which is used for *each*.
 run_test ./userfaultfd hugetlb "$half_ufd_size_MB" 32
+run_test ./userfaultfd hugetlb:dev "$half_ufd_size_MB" 32
 run_test ./userfaultfd hugetlb_shared "$half_ufd_size_MB" 32 "$mnt"/uffd-test
 rm -f "$mnt"/uffd-test
+run_test ./userfaultfd hugetlb_shared:dev "$half_ufd_size_MB" 32 "$mnt"/uffd-test
+rm -f "$mnt"/uffd-test
 run_test ./userfaultfd shmem 20 16
+run_test ./userfaultfd shmem:dev 20 16
 
 #cleanup
 umount "$mnt"
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

