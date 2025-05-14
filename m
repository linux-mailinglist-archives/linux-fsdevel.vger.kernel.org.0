Return-Path: <linux-fsdevel+bounces-49075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7538FAB7A33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13D0F1897884
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C58026D4CA;
	Wed, 14 May 2025 23:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZIUZ4C7H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB23626A0DD
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266257; cv=none; b=Jget1ju2BUrZTXNyHSr/3S/+vN2Z2Pkyooy5rXm7WLxR6ZY7NpggKzwYzosAMM0JkMB2/kangisF4WhgXNzKCYPljMMlj9Qh6b1C+EwgIw3b4l+jUuIpboPs7DQNCz0/Kh6mJiAj5x5xf9gwORp7hN+b9998tGr7avkGoRIky9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266257; c=relaxed/simple;
	bh=eoNudGoVVrSmlzo9/8eda7elJKi5T0wlPjDob88hz8o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y1HFTT7RbdLZpyvl2q8Iqh5WHnVEO4VxNNJ6h5janI0Jr7XpSBfLiCk4U8SQgKqENzE9tg6+jlCNqdvwfmyrIddOrHQeRewW99/hLXCbK/2GRt09KWrONTeqr6uLw2VGBnCXQkeAjceAP/NF5MnBYAARuKPR219RUoczYr2Kpb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZIUZ4C7H; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30c371c34e7so404606a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266255; x=1747871055; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CiDwHat/uPl/OY4yi7AkHkDLS3qdk3FYn5t6iuFb10s=;
        b=ZIUZ4C7HoQGw2645aJtKvzMePKkDWg2YY3lBkVh8ZoBfWikppORePjvgMFRRc8CEGd
         Se5wGgpE+W9r1TW3HCFbVqmqPb+U5oq6HJip6HHYTJBX0ZTy129hxEM+oPB5zcg1oNCv
         k/ex2jFIrFF5isODx6layZZHkpDFGoUh5hROc80TDxdIt2+1IPA1tR2+dvwfV/5OQgXm
         K5M1T5p18C1k1AkmMjDGEYaIbZuJez88fyJbHqEfSuILs+ufG1fse2DSlCSY0RSGJGxi
         hAjLlU16jYEpYscnbRxs1GTXZ1g4wLEZ2xeMsKw3LTSbyFxKRd52YNd1zR1OL8yM8bbJ
         cNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266255; x=1747871055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CiDwHat/uPl/OY4yi7AkHkDLS3qdk3FYn5t6iuFb10s=;
        b=kqI1OeHFy0JMg9Lk2/Chp0hVlHFSpHDdInxf3ol1BtTJeBsoDbAtbPVoyhnnCfjZwO
         Ap3PPLYakg8ylLx5TA2K6OxRN3WoGpMxEDCMyHBWyUckh806GbNIyUj4AsK++LQpZyty
         JlsIicoCV8pNYQBhAHlv3Npg8tmSNxH+Z3JnTc2XGshuafUKq14uNXR1x7VWsx6WeStO
         4p0yWn4gDzPp9QIrNcQ9n48Goz5MZ0NQiSLBz0w1DTilX+MiJ5hwUq6xrdpQEAq7LeQu
         yZSwDQsTQH70eAOC3B3F769nxZsJnpph+4h2lFE9eEuispOo7B0mTexFrSMsMGGKyA7B
         SSEw==
X-Forwarded-Encrypted: i=1; AJvYcCXvpE6ekSNg9LU4NkwxLGxYi33m6pVlMrpQaoNNcweclrWkaa2RsWbUm7wMouvRpVm6Lgx2g3+lfsi9Lsz7@vger.kernel.org
X-Gm-Message-State: AOJu0YywHs+Co4cXnKIAA0Maz+nypNqanEsQME458K7Cmo/6wkW3Yuqf
	Q/oS4mg42fcRkR4lE8alKW881NX5Q2tCRH2MGGFStjS/ex6tb8DzT3K5Tdtpy2tdTxw1/D9GCZe
	RV80VAme85YjI/UWOdwtq4Q==
X-Google-Smtp-Source: AGHT+IFOAM9UVwj4ad58iQw+X7kCOsmk0nNgnZGussZhDVj2+jakXhlWEPGRVMVXx6qiGavsIkJ+Vleisd/CLOi4bA==
X-Received: from pjbsu3.prod.google.com ([2002:a17:90b:5343:b0:2fc:3022:36b8])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:56cd:b0:2ff:7ad4:77b1 with SMTP id 98e67ed59e1d1-30e5156ea2bmr771844a91.2.1747266255223;
 Wed, 14 May 2025 16:44:15 -0700 (PDT)
Date: Wed, 14 May 2025 16:42:29 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <9c38fdff026b84f8e4a3e1279d5ed4eed6dce0ba.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 50/51] KVM: selftests: Add script to test HugeTLB statistics
From: Ackerley Tng <ackerleytng@google.com>
To: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org
Cc: ackerleytng@google.com, aik@amd.com, ajones@ventanamicro.com, 
	akpm@linux-foundation.org, amoorthy@google.com, anthony.yznaga@oracle.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, bfoster@redhat.com, 
	binbin.wu@linux.intel.com, brauner@kernel.org, catalin.marinas@arm.com, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com, 
	david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk, 
	erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com, 
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk, 
	peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com, 
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

This script wraps other tests to check that HugeTLB statistics are
restored to what they were before the test was run.

Does not account HugeTLB statistics updated by other non-test
processes running in the background while the test is running.

Change-Id: I1d827656ef215fd85e368f4a3629f306e7f33f18
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 ...memfd_wrap_test_check_hugetlb_reporting.sh | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100755 tools/testing/selftests/kvm/guest_memfd_wrap_test_check_hugetlb_reporting.sh

diff --git a/tools/testing/selftests/kvm/guest_memfd_wrap_test_check_hugetlb_reporting.sh b/tools/testing/selftests/kvm/guest_memfd_wrap_test_check_hugetlb_reporting.sh
new file mode 100755
index 000000000000..475ec5c4ce1b
--- /dev/null
+++ b/tools/testing/selftests/kvm/guest_memfd_wrap_test_check_hugetlb_reporting.sh
@@ -0,0 +1,95 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Wrapper that runs test, checking that HugeTLB-related statistics have not
+# changed before and after test.
+#
+# Example:
+#   ./guest_memfd_wrap_test_check_hugetlb_reporting.sh ./guest_memfd_test
+#
+# Example of combining this with ./guest_memfd_provide_hugetlb_cgroup_mount.sh:
+#   ./guest_memfd_provide_hugetlb_cgroup_mount.sh \
+#     ./guest_memfd_wrap_test_check_hugetlb_reporting.sh \
+#     ./guest_memfd_hugetlb_reporting_test
+#
+# Copyright (C) 2025, Google LLC.
+
+declare -A baseline
+
+hugetlb_sizes=(
+  "2048kB"
+  "1048576kB"
+)
+
+statistics=(
+  "free_hugepages"
+  "nr_hugepages"
+  "nr_overcommit_hugepages"
+  "resv_hugepages"
+  "surplus_hugepages"
+)
+
+cgroup_hugetlb_sizes=(
+  "2MB"
+  "1GB"
+)
+
+cgroup_statistics=(
+  "limit_in_bytes"
+  "max_usage_in_bytes"
+  "usage_in_bytes"
+)
+
+establish_statistics_baseline() {
+  for size in "${hugetlb_sizes[@]}"; do
+
+    for statistic in "${statistics[@]}"; do
+
+      local path="/sys/kernel/mm/hugepages/hugepages-${size}/${statistic}"
+      baseline["$path"]=$(cat "$path")
+
+    done
+
+  done
+
+  if [ -n "$HUGETLB_CGROUP_PATH" ]; then
+
+    for size in "${cgroup_hugetlb_sizes[@]}"; do
+
+      for statistic in "${cgroup_statistics[@]}"; do
+
+        local rsvd_path="${HUGETLB_CGROUP_PATH}/hugetlb.${size}.rsvd.${statistic}"
+        local path="${HUGETLB_CGROUP_PATH}/hugetlb.${size}.${statistic}"
+
+        baseline["$rsvd_path"]=$(cat "$rsvd_path")
+        baseline["$path"]=$(cat "$path")
+
+      done
+
+    done
+
+  fi
+}
+
+assert_path_at_baseline() {
+  local path=$1
+
+  current=$(cat "$path")
+  expected=${baseline["$path"]}
+  if [ "$current" != "$expected"  ]; then
+    echo "$path was $current instead of $expected"
+  fi
+}
+
+assert_statistics_at_baseline() {
+  for path in "${!baseline[@]}"; do
+    assert_path_at_baseline $path
+  done
+}
+
+
+establish_statistics_baseline
+
+$@
+
+assert_statistics_at_baseline
-- 
2.49.0.1045.g170613ef41-goog


