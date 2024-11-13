Return-Path: <linux-fsdevel+bounces-34703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBF49C7E4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 23:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20E22B268CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 22:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA80618EFC6;
	Wed, 13 Nov 2024 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BJlXraoU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBCC18C01A;
	Wed, 13 Nov 2024 22:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731537296; cv=none; b=osQdJOMMUleKRuuPUqnG0LfYj7GpxmymJ5xzIDaJ/K/PPsKYyNoKLAJp5zZYIvjOQ+FQp57jJ16LucmrvrSCbNmQws68xFMqOCHUvwbJCcJVfbL3wZmGCE2cd7utpV0SO3AZglVya//Tg8h0U8ngooClCbWcymGO3ecvGuDcs20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731537296; c=relaxed/simple;
	bh=RPpMfexV9iikG/XvDmc1I1KqVGHHBbdxI6bmCuFIFRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RjJXkEc0DvmgKW+T6secrbyJ/yci96Ibenjj3jN42QMTje9BO1YaJSeIDfnqvXTN6Cc1JXoX+IrLOCTkJSHLejudwfkn1Es1jeiMOrI0309nCPgMY9sH3b7dUOJw4pZvtYpd2/YmZtD1Ri8Xb76zPDwQIDNTLBS5khTFCXHIMxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BJlXraoU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADH1YhQ027002;
	Wed, 13 Nov 2024 22:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MZbmA6zd24owO/IYSWGVR2iZqwWNUcfCO1PpGSWKLAs=; b=BJlXraoU8ROVE7eE
	AzZUBaifqDMCykbzSJv4ULRhwAorucN+u2PLnabvVNIfyXQB+/Gz4QOvROZDYAD/
	w5FS/oaMUERl10llD+23utbqv7iImdRGSU8jlM7ryCjXFCiVG1KosXA+tb2nH6lI
	nRmSgnq0q9RauAwXzH4G22OUoq+6C3+58moO22E+/oPW1+Bo4LkKDJczUEjl5D1f
	ANM7g1S8BVmwjfT/l05SXHXkDu2yiI/q1P319JFs1GWP27kuc93QvM5iher+m4v6
	Ii3WCi6FtKa91Rjsr8mBdPYqiSq9PRDhgbXVQCL1YqmDJFIg5l80xpIR2mrvhBXI
	WtWsIQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42vt731w71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 22:34:41 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ADMYe2d024008
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 22:34:40 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 13 Nov 2024 14:34:39 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Wed, 13 Nov 2024 14:34:37 -0800
Subject: [PATCH RFC v3 2/2] mm: guestmem: Convert address_space operations
 to guestmem library
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241113-guestmem-library-v3-2-71fdee85676b@quicinc.com>
References: <20241113-guestmem-library-v3-0-71fdee85676b@quicinc.com>
In-Reply-To: <20241113-guestmem-library-v3-0-71fdee85676b@quicinc.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        Sean Christopherson <seanjc@google.com>,
        "Fuad
 Tabba" <tabba@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        "Mike
 Rapoport" <rppt@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
CC: James Gowans <jgowans@amazon.com>, <linux-fsdevel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Elliot Berman <quic_eberman@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _sD27azoIiyYFOMaLs019HpucSqSDOQn
X-Proofpoint-GUID: _sD27azoIiyYFOMaLs019HpucSqSDOQn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411130185

A few near-term features are coming to guest_memfd which make sense to
create a built-in library.
 - pKVM will introduce MMU-based protection for guests and allow guest
   memory to be switched between "guest-private" and "accessible to
   host". Additional tracking is needed to manage the state of pages as
   accessing "guest-private" pages crashes the host.
 - Introduction of large folios requires tracking since guests will not
   have awareness whether the memory backing a page is huge or not.
   Guests may wish to share only a partial page.
 - Gunyah hypervisor support will be added and also make use of guestmem
   for its MMU-based protection.

The address_space is targeted for the guestmem library.  KVM still
"owns" the inode and file.

MAINTAINERS is updated with explicit references to guestmem files
else the stm maintainers are automatically added.

Tested with:
run_kselftest.sh -t kvm:guest_memfd_test -t kvm:set_memory_region_test

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 MAINTAINERS              |   2 +
 include/linux/guestmem.h |  33 +++++++
 mm/Kconfig               |   3 +
 mm/Makefile              |   1 +
 mm/guestmem.c            | 232 +++++++++++++++++++++++++++++++++++++++++++++++
 virt/kvm/Kconfig         |   1 +
 virt/kvm/guest_memfd.c   | 112 ++++++-----------------
 7 files changed, 301 insertions(+), 83 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 391fe4b106f8cb7e1cc0b4184dc121ac74d8e00a..c684248ce65d99d62dc616c8bc6c1a7419bd6f4d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14888,6 +14888,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
 T:	quilt git://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new
 F:	include/linux/gfp.h
 F:	include/linux/gfp_types.h
+F:	include/linux/guestmem.h
 F:	include/linux/memfd.h
 F:	include/linux/memory.h
 F:	include/linux/memory_hotplug.h
@@ -14903,6 +14904,7 @@ F:	include/linux/pagewalk.h
 F:	include/linux/rmap.h
 F:	include/trace/events/ksm.h
 F:	mm/
+F:	mm/guestmem.c
 F:	tools/mm/
 F:	tools/testing/selftests/mm/
 N:	include/linux/page[-_]*
diff --git a/include/linux/guestmem.h b/include/linux/guestmem.h
new file mode 100644
index 0000000000000000000000000000000000000000..4beb37adb5e541015fcc12a45930613c686c5580
--- /dev/null
+++ b/include/linux/guestmem.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_GUESTMEM_H
+#define _LINUX_GUESTMEM_H
+
+struct address_space;
+struct list_head;
+
+/**
+ * struct guestmem_ops - Hypervisor-specific maintenance operations to perform on folios
+ * @release_folio - Try to bring the folio back to fully owned by Linux
+ *		    for instance: about to free the folio [optional]
+ * @invalidate_begin - start invalidating mappings between start and end offsets
+ * @invalidate_end - paired with ->invalidate_begin() [optional]
+ */
+struct guestmem_ops {
+	bool (*release_folio)(struct list_head *entry, struct folio *folio);
+	int (*invalidate_begin)(struct list_head *entry, pgoff_t start,
+				pgoff_t end);
+	void (*invalidate_end)(struct list_head *entry, pgoff_t start,
+			       pgoff_t end);
+};
+
+int guestmem_attach_mapping(struct address_space *mapping,
+			    const struct guestmem_ops *const ops,
+			    struct list_head *data);
+void guestmem_detach_mapping(struct address_space *mapping,
+			     struct list_head *data);
+
+struct folio *guestmem_grab_folio(struct address_space *mapping, pgoff_t index);
+int guestmem_punch_hole(struct address_space *mapping, loff_t offset,
+			loff_t len);
+
+#endif
diff --git a/mm/Kconfig b/mm/Kconfig
index 4c9f5ea13271d1f90163e75a35adf619ada3a5cd..48c911d3dbc1645b478d0626a5d86f5fec154b15 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1190,6 +1190,9 @@ config SECRETMEM
 	  memory areas visible only in the context of the owning process and
 	  not mapped to other processes and other kernel page tables.
 
+config GUESTMEM
+	bool
+
 config ANON_VMA_NAME
 	bool "Anonymous VMA name support"
 	depends on PROC_FS && ADVISE_SYSCALLS && MMU
diff --git a/mm/Makefile b/mm/Makefile
index d5639b03616636e4d49913f76865e24edb270f73..4d5f003d69c8969aaae0615106b90600ef638719 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -136,6 +136,7 @@ obj-$(CONFIG_PERCPU_STATS) += percpu-stats.o
 obj-$(CONFIG_ZONE_DEVICE) += memremap.o
 obj-$(CONFIG_HMM_MIRROR) += hmm.o
 obj-$(CONFIG_MEMFD_CREATE) += memfd.o
+obj-$(CONFIG_GUESTMEM) += guestmem.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
diff --git a/mm/guestmem.c b/mm/guestmem.c
new file mode 100644
index 0000000000000000000000000000000000000000..21e93b2b6b18036c733e1afbccff3392ff6a6604
--- /dev/null
+++ b/mm/guestmem.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * guestmem library
+ *
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/fs.h>
+#include <linux/guestmem.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+
+struct guestmem {
+	const struct guestmem_ops *ops;
+};
+
+static inline struct guestmem *folio_to_guestmem(struct folio *folio)
+{
+	struct address_space *const mapping = folio->mapping;
+
+	return mapping->i_private_data;
+}
+
+static inline bool __guestmem_release_folio(struct address_space *const mapping,
+					    struct folio *folio)
+{
+	struct guestmem *gmem = mapping->i_private_data;
+	struct list_head *entry;
+
+	if (gmem->ops->release_folio) {
+		list_for_each(entry, &mapping->i_private_list) {
+			if (!gmem->ops->release_folio(entry, folio))
+				return false;
+		}
+	}
+
+	return true;
+}
+
+static inline int
+__guestmem_invalidate_begin(struct address_space *const mapping, pgoff_t start,
+			    pgoff_t end)
+{
+	struct guestmem *gmem = mapping->i_private_data;
+	struct list_head *entry;
+	int ret = 0;
+
+	list_for_each(entry, &mapping->i_private_list) {
+		ret = gmem->ops->invalidate_begin(entry, start, end);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static inline void
+__guestmem_invalidate_end(struct address_space *const mapping, pgoff_t start,
+			  pgoff_t end)
+{
+	struct guestmem *gmem = mapping->i_private_data;
+	struct list_head *entry;
+
+	if (gmem->ops->invalidate_end) {
+		list_for_each(entry, &mapping->i_private_list)
+			gmem->ops->invalidate_end(entry, start, end);
+	}
+}
+
+static bool guestmem_release_folio(struct folio *folio, gfp_t gfp)
+{
+	return __guestmem_release_folio(folio->mapping, folio);
+}
+
+static void guestmem_invalidate_folio(struct folio *folio, size_t offset,
+				      size_t len)
+{
+	WARN_ON_ONCE(offset != 0);
+	WARN_ON_ONCE(len != folio_size(folio));
+
+	if (offset == 0 && len == folio_size(folio))
+		WARN_ON_ONCE(filemap_release_folio(folio, 0));
+}
+
+static int guestmem_error_folio(struct address_space *mapping,
+				struct folio *folio)
+{
+	pgoff_t start, end;
+	int ret;
+
+	filemap_invalidate_lock_shared(mapping);
+
+	start = folio->index;
+	end = start + folio_nr_pages(folio);
+
+	ret = __guestmem_invalidate_begin(mapping, start, end);
+	if (ret)
+		goto out;
+
+	/*
+	 * Do not truncate the range, what action is taken in response to the
+	 * error is userspace's decision (assuming the architecture supports
+	 * gracefully handling memory errors).  If/when the guest attempts to
+	 * access a poisoned page, kvm_gmem_get_pfn() will return -EHWPOISON,
+	 * at which point KVM can either terminate the VM or propagate the
+	 * error to userspace.
+	 */
+
+	__guestmem_invalidate_end(mapping, start, end);
+
+out:
+	filemap_invalidate_unlock_shared(mapping);
+	return ret ? MF_DELAYED : MF_FAILED;
+}
+
+static int guestmem_migrate_folio(struct address_space *mapping,
+				  struct folio *dst, struct folio *src,
+				  enum migrate_mode mode)
+{
+	WARN_ON_ONCE(1);
+	return -EINVAL;
+}
+
+static const struct address_space_operations guestmem_aops = {
+	.dirty_folio = noop_dirty_folio,
+	.release_folio = guestmem_release_folio,
+	.invalidate_folio = guestmem_invalidate_folio,
+	.error_remove_folio = guestmem_error_folio,
+	.migrate_folio = guestmem_migrate_folio,
+};
+
+/**
+ * guestmem_attach_mapping() - Attach/create a guestmem mapping
+ * @mapping: The address space to attach to
+ * @ops: The guestmem operations to use
+ * @data: Private data to pass to the ops functions
+ */
+int guestmem_attach_mapping(struct address_space *mapping,
+			    const struct guestmem_ops *const ops,
+			    struct list_head *data)
+{
+	struct guestmem *gmem;
+
+	if (mapping->a_ops == &guestmem_aops) {
+		gmem = mapping->i_private_data;
+		if (gmem->ops != ops)
+			return -EINVAL;
+
+		goto add;
+	}
+
+	gmem = kzalloc(sizeof(*gmem), GFP_KERNEL);
+	if (!gmem)
+		return -ENOMEM;
+
+	gmem->ops = ops;
+
+	mapping->a_ops = &guestmem_aops;
+	mapping->i_private_data = gmem;
+
+	mapping_set_gfp_mask(mapping, GFP_HIGHUSER);
+	mapping_set_inaccessible(mapping);
+	/* Unmovable mappings are supposed to be marked unevictable as well. */
+	WARN_ON_ONCE(!mapping_unevictable(mapping));
+
+add:
+	list_add(data, &mapping->i_private_list);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(guestmem_attach_mapping);
+
+/**
+ * guestmem_detach_mapping() - Detach a guestmem mapping
+ * @mapping: The address space to detach
+ * @data: Private data to detach
+ */
+void guestmem_detach_mapping(struct address_space *mapping,
+			     struct list_head *data)
+{
+	list_del(data);
+
+	if (list_empty(&mapping->i_private_list)) {
+		kfree(mapping->i_private_data);
+		mapping->i_private_data = NULL;
+		mapping->a_ops = &empty_aops;
+	}
+}
+EXPORT_SYMBOL_GPL(guestmem_detach_mapping);
+
+/**
+ * guestmem_grab_folio() - Grab a folio from a guestmem mapping
+ * @mapping: The address space to grab from
+ * @index: The index of the folio to grab
+ *
+ * Return: The grabbed folio, or ERR_PTR() on failure.
+ */
+struct folio *guestmem_grab_folio(struct address_space *mapping, pgoff_t index)
+{
+	/* TODO: Support huge pages. */
+	return filemap_grab_folio(mapping, index);
+}
+EXPORT_SYMBOL_GPL(guestmem_grab_folio);
+
+/**
+ * guestmem_put_folio() - Helper to punch a hole in a guestmem mapping
+ * @mapping: The address space to punch a hole in
+ * @offset: The offset to punch a hole at
+ * @len: The length of the hole to punch
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int guestmem_punch_hole(struct address_space *mapping, loff_t offset,
+			loff_t len)
+{
+	pgoff_t start = offset >> PAGE_SHIFT;
+	pgoff_t end = (offset + len) >> PAGE_SHIFT;
+	int ret;
+
+	filemap_invalidate_lock(mapping);
+	ret = __guestmem_invalidate_begin(mapping, start, end);
+	if (ret)
+		goto out;
+
+	truncate_inode_pages_range(mapping, offset, offset + len - 1);
+
+	__guestmem_invalidate_end(mapping, start, end);
+
+out:
+	filemap_invalidate_unlock(mapping);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(guestmem_punch_hole);
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index fd6a3010afa833e077623065b80bdbb5b1012250..1339098795d2e859b2ee0ef419b29045aedc8487 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -106,6 +106,7 @@ config KVM_GENERIC_MEMORY_ATTRIBUTES
 
 config KVM_PRIVATE_MEM
        select XARRAY_MULTI
+       select GUESTMEM
        bool
 
 config KVM_GENERIC_PRIVATE_MEM
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 13f83ad8a4c26ba82aca4f2684f22044abb4bc19..a56a50a89bab42690c7acd9f0ea5fe70d41e3777 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/backing-dev.h>
 #include <linux/falloc.h>
+#include <linux/guestmem.h>
 #include <linux/kvm_host.h>
 #include <linux/pagemap.h>
 #include <linux/anon_inodes.h>
@@ -98,8 +99,7 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
  */
 static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 {
-	/* TODO: Support huge pages. */
-	return filemap_grab_folio(inode->i_mapping, index);
+	return guestmem_grab_folio(inode->i_mapping, index);
 }
 
 static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
@@ -151,28 +151,7 @@ static void kvm_gmem_invalidate_end(struct kvm_gmem *gmem, pgoff_t start,
 
 static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 {
-	struct list_head *gmem_list = &inode->i_mapping->i_private_list;
-	pgoff_t start = offset >> PAGE_SHIFT;
-	pgoff_t end = (offset + len) >> PAGE_SHIFT;
-	struct kvm_gmem *gmem;
-
-	/*
-	 * Bindings must be stable across invalidation to ensure the start+end
-	 * are balanced.
-	 */
-	filemap_invalidate_lock(inode->i_mapping);
-
-	list_for_each_entry(gmem, gmem_list, entry)
-		kvm_gmem_invalidate_begin(gmem, start, end);
-
-	truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
-
-	list_for_each_entry(gmem, gmem_list, entry)
-		kvm_gmem_invalidate_end(gmem, start, end);
-
-	filemap_invalidate_unlock(inode->i_mapping);
-
-	return 0;
+	return guestmem_punch_hole(inode->i_mapping, offset, len);
 }
 
 static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
@@ -277,7 +256,7 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
 	kvm_gmem_invalidate_begin(gmem, 0, -1ul);
 	kvm_gmem_invalidate_end(gmem, 0, -1ul);
 
-	list_del(&gmem->entry);
+	guestmem_detach_mapping(inode->i_mapping, &gmem->entry);
 
 	filemap_invalidate_unlock(inode->i_mapping);
 
@@ -318,47 +297,8 @@ void kvm_gmem_init(struct module *module)
 	kvm_gmem_fops.owner = module;
 }
 
-static int kvm_gmem_migrate_folio(struct address_space *mapping,
-				  struct folio *dst, struct folio *src,
-				  enum migrate_mode mode)
-{
-	WARN_ON_ONCE(1);
-	return -EINVAL;
-}
-
-static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *folio)
-{
-	struct list_head *gmem_list = &mapping->i_private_list;
-	struct kvm_gmem *gmem;
-	pgoff_t start, end;
-
-	filemap_invalidate_lock_shared(mapping);
-
-	start = folio->index;
-	end = start + folio_nr_pages(folio);
-
-	list_for_each_entry(gmem, gmem_list, entry)
-		kvm_gmem_invalidate_begin(gmem, start, end);
-
-	/*
-	 * Do not truncate the range, what action is taken in response to the
-	 * error is userspace's decision (assuming the architecture supports
-	 * gracefully handling memory errors).  If/when the guest attempts to
-	 * access a poisoned page, kvm_gmem_get_pfn() will return -EHWPOISON,
-	 * at which point KVM can either terminate the VM or propagate the
-	 * error to userspace.
-	 */
-
-	list_for_each_entry(gmem, gmem_list, entry)
-		kvm_gmem_invalidate_end(gmem, start, end);
-
-	filemap_invalidate_unlock_shared(mapping);
-
-	return MF_DELAYED;
-}
-
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
-static bool kvm_gmem_release_folio(struct folio *folio, gfp_t gfp)
+static bool kvm_gmem_release_folio(struct list_head *entry, struct folio *folio)
 {
 	struct page *page = folio_page(folio, 0);
 	kvm_pfn_t pfn = page_to_pfn(page);
@@ -368,25 +308,31 @@ static bool kvm_gmem_release_folio(struct folio *folio, gfp_t gfp)
 
 	return true;
 }
+#endif
 
-static void kvm_gmem_invalidate_folio(struct folio *folio, size_t offset,
-				      size_t len)
+static int kvm_guestmem_invalidate_begin(struct list_head *entry, pgoff_t start,
+					 pgoff_t end)
 {
-	WARN_ON_ONCE(offset != 0);
-	WARN_ON_ONCE(len != folio_size(folio));
+	struct kvm_gmem *gmem = container_of(entry, struct kvm_gmem, entry);
+
+	kvm_gmem_invalidate_begin(gmem, start, end);
 
-	if (offset == 0 && len == folio_size(folio))
-		filemap_release_folio(folio, 0);
+	return 0;
 }
-#endif
 
-static const struct address_space_operations kvm_gmem_aops = {
-	.dirty_folio = noop_dirty_folio,
-	.migrate_folio = kvm_gmem_migrate_folio,
-	.error_remove_folio = kvm_gmem_error_folio,
+static void kvm_guestmem_invalidate_end(struct list_head *entry, pgoff_t start,
+					pgoff_t end)
+{
+	struct kvm_gmem *gmem = container_of(entry, struct kvm_gmem, entry);
+
+	kvm_gmem_invalidate_end(gmem, start, end);
+}
+
+static const struct guestmem_ops kvm_guestmem_ops = {
+	.invalidate_begin = kvm_guestmem_invalidate_begin,
+	.invalidate_end = kvm_guestmem_invalidate_end,
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 	.release_folio = kvm_gmem_release_folio,
-	.invalidate_folio = kvm_gmem_invalidate_folio,
 #endif
 };
 
@@ -442,22 +388,22 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 
 	inode->i_private = (void *)(unsigned long)flags;
 	inode->i_op = &kvm_gmem_iops;
-	inode->i_mapping->a_ops = &kvm_gmem_aops;
 	inode->i_mode |= S_IFREG;
 	inode->i_size = size;
-	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
-	mapping_set_inaccessible(inode->i_mapping);
-	/* Unmovable mappings are supposed to be marked unevictable as well. */
-	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
+	err = guestmem_attach_mapping(inode->i_mapping, &kvm_guestmem_ops,
+				      &gmem->entry);
+	if (err)
+		goto err_putfile;
 
 	kvm_get_kvm(kvm);
 	gmem->kvm = kvm;
 	xa_init(&gmem->bindings);
-	list_add(&gmem->entry, &inode->i_mapping->i_private_list);
 
 	fd_install(fd, file);
 	return fd;
 
+err_putfile:
+	fput(file);
 err_gmem:
 	kfree(gmem);
 err_fd:

-- 
2.34.1


