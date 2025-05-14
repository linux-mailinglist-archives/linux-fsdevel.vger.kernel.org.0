Return-Path: <linux-fsdevel+bounces-49038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC573AB79C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C80C7B9F27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CDC23ED56;
	Wed, 14 May 2025 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Gv2gOpJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E883C239082
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266199; cv=none; b=oiz7gtxqWikNTnMBy/iK3IQgYfFxUi9vrl6HeRd3sI8yi9dMvEzPpMeEmJry23ZpIK13WsXb9r/WRXZr03mU1ugCcZ/wDgqfjkyV+s290m1viTFBVpZdcRAq1qe0CmIyUksOzaIylaUNmSl/85+L6PlSpv7V6rVVzMJp7zXmLjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266199; c=relaxed/simple;
	bh=W3kQvVjiVRdrC872LeW4B4Hq/K4Vu3vda0e9Fhub7Es=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yy16+3CFlAbSQgESf0oJgTfNJYgSSzZ60Aos9LKwze5Ry7ty6uAt/tXux71Y7YLDJ3tzzbtkQ/o/r6QBa/j3pVfjnMUkHNI+n7UmB6gLxtnSVXJjhp/13cRaOiyz7lzz257kR1vqfVZvwhd9C3OjPJ4ncunhBBYYigXh1uDs8Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Gv2gOpJ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30c1a269a12so599112a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266197; x=1747870997; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PRU0ZRfLQjg4VVDgrWE7a1sC3dOKBaDUonPKqBXfZi4=;
        b=0Gv2gOpJPpQAk4AzrJ/7XJAFcnJMsEPsie8bZF9fQzpwfUJc4L8dyq/RwUSF08BEg/
         sjqtYSRHBaLPNT/wK+6mtuLxpQ/gEXFiXwBYoM/QbDzLdVrPMjBzKdPBxuiQsb7eXvQn
         8BHUCOb2v9seDLHOZmERG4YbzDSS+tMZ2Dx+oVkaqtNHGdQY4x2XxOCDlasr4QNJVlc2
         /sH1Jz5COfNm58JtYrXqp1NGwnHVFW46HzSyghHBIUwOsfHw8WWYyr/qV6MemPsSMoRJ
         ZTsv62ECrG5JOProNxaN6x/U9M/QyPOHlTvW3VasklLm3UD7KoJ8p+wDWfWXfEJ83o5m
         TjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266197; x=1747870997;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRU0ZRfLQjg4VVDgrWE7a1sC3dOKBaDUonPKqBXfZi4=;
        b=iR1uZj7UdBUS0KAOOGo2lFvcVTli5rxp+Aoq1W5JTFCEdsRQAN8vXfKPK5Iq5k3DHW
         jPmMOZnRKeazG7toLK83H1laQPhjoYcMfo+M4ZX5wSFk7hTx6FAJmIi7GXmkP/invlLU
         fnqrDoC3/Cj93P54Qk876coU7pLaHKP9aunHsueJMbxpvLDrGgNKKywHik3Pr2GH2s5z
         sSIXtG79gsxKWk6/9e20VaC037p7wAmf5CZey/b3WZqTc8EWrlfbeSopufxO3IJYX/fP
         Eh6iA3uVW3jDxoNvdt/74VVarWHy4hBNbpWOvjVkFFbPDdrLpb2Neli4N/xJEfiHgaKx
         ENjA==
X-Forwarded-Encrypted: i=1; AJvYcCU2Zp0Bgezj7KJ/c8KDjI0ZLE+0BJLziS6QQPvmaqLg+kMAzdtVsO8cONbZzrvhLjd8rOlT53Au6mOZ/AuK@vger.kernel.org
X-Gm-Message-State: AOJu0YyVxQ/49axpplPEN5oq6sENDo8v3FO5slS5qBENcV6LTBFsAQW4
	CBn6gTnQflrome3dFuFYYAL/ImQVbYbosJmKwN0Py2NyC7cL0XisXRGh9CFUDVaRyBhqj5ScN78
	+WcFKs33guSM+bCg/Oh4A8w==
X-Google-Smtp-Source: AGHT+IHb7GIqu695NGHdx8kULM1l9ge1FyZ0eSB2cW4x76FAmN4jqpBALaAAXGXP8pOhY4vxYo06cCKYxIVDFuivmw==
X-Received: from pjbsv3.prod.google.com ([2002:a17:90b:5383:b0:305:2d2a:dfaa])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:288b:b0:2ff:693a:7590 with SMTP id 98e67ed59e1d1-30e2e62ff9emr9683927a91.33.1747266197415;
 Wed, 14 May 2025 16:43:17 -0700 (PDT)
Date: Wed, 14 May 2025 16:41:52 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <c4d4dcd297dea1eeded3f0c195f4a9767fe9c120.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 13/51] KVM: selftests: Add script to exercise private_mem_conversions_test
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

Makes testing different combinations of private_mem_conversions_test
flags easier.

Change-Id: I7647e92524baf09eb97e09bdbd95ad57ada44f4b
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../kvm/x86/private_mem_conversions_test.sh   | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100755 tools/testing/selftests/kvm/x86/private_mem_conversions_test.sh

diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.sh b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.sh
new file mode 100755
index 000000000000..76efa81114d2
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.sh
@@ -0,0 +1,82 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only */
+#
+# Wrapper script which runs different test setups of
+# private_mem_conversions_test.
+#
+# Copyright (C) 2024, Google LLC.
+
+set -e
+
+num_vcpus_to_test=4
+num_memslots_to_test=$num_vcpus_to_test
+
+get_default_hugepage_size_in_kB() {
+	grep "Hugepagesize:" /proc/meminfo | grep -o '[[:digit:]]\+'
+}
+
+# Required pages are based on the test setup (see computation for memfd_size) in
+# test_mem_conversions() in private_mem_migrate_tests.c)
+
+# These static requirements are set to the maximum required for
+# num_vcpus_to_test, over all the hugetlb-related tests
+required_num_2m_hugepages=$(( 1024 * num_vcpus_to_test ))
+required_num_1g_hugepages=$(( 2 * num_vcpus_to_test ))
+
+# The other hugetlb sizes are not supported on x86_64
+[ "$(cat /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages 2>/dev/null || echo 0)" \
+  -ge "$required_num_2m_hugepages" ] && hugepage_2mb_enabled=1
+[ "$(cat /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages 2>/dev/null || echo 0)" \
+  -ge "$required_num_1g_hugepages" ] && hugepage_1gb_enabled=1
+
+case $(get_default_hugepage_size_in_kB) in
+	2048)
+		hugepage_default_enabled=$hugepage_2mb_enabled
+		;;
+	1048576)
+		hugepage_default_enabled=$hugepage_1gb_enabled
+		;;
+	*)
+		hugepage_default_enabled=0
+		;;
+esac
+
+backing_src_types=( anonymous )
+backing_src_types+=( anonymous_thp )
+[ -n "$hugepage_default_enabled" ] && \
+	backing_src_types+=( anonymous_hugetlb ) || \
+	echo "skipping anonymous_hugetlb backing source type"
+[ -n "$hugepage_2mb_enabled" ] && \
+	backing_src_types+=( anonymous_hugetlb_2mb ) || \
+	echo "skipping anonymous_hugetlb_2mb backing source type"
+[ -n "$hugepage_1gb_enabled" ] && \
+	backing_src_types+=( anonymous_hugetlb_1gb ) || \
+	echo "skipping anonymous_hugetlb_1gb backing source type"
+backing_src_types+=( shmem )
+[ -n "$hugepage_default_enabled" ] && \
+	backing_src_types+=( shared_hugetlb ) || \
+	echo "skipping shared_hugetlb backing source type"
+
+set +e
+
+TEST_EXECUTABLE="$(dirname "$0")/private_mem_conversions_test"
+
+(
+	set -e
+
+	for src_type in "${backing_src_types[@]}"; do
+
+		set -x
+
+                $TEST_EXECUTABLE -s "$src_type" -n $num_vcpus_to_test
+		$TEST_EXECUTABLE -s "$src_type" -n $num_vcpus_to_test -m $num_memslots_to_test
+
+		{ set +x; } 2>/dev/null
+
+		echo
+
+	done
+)
+RET=$?
+
+exit $RET
-- 
2.49.0.1045.g170613ef41-goog


