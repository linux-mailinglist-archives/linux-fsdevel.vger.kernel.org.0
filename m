Return-Path: <linux-fsdevel+bounces-43392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B305EA55C7F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 02:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 393713B3416
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 01:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CF817D346;
	Fri,  7 Mar 2025 00:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="B6BnT2tx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27814156C72;
	Fri,  7 Mar 2025 00:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309122; cv=none; b=CBbhoqnv0mQdE43aUpNRFJMkxJtPgqtLV1bgZihoKn0Od+nIZxTL2sndtxn+rILpJrV511QnPZxTQ/npAmE53v7m0cBK0UfB4cUGxfTJoVOVYo3oj4+0tkyqglzsxOqH0LnZKN3WjGoqqJbBVeW/sXiS/OjTnE/BRXUajMk3vyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309122; c=relaxed/simple;
	bh=CUemmUBXCoody8wnnAm1qD67Ji2foJlGPZcw3CxU16Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQgkTtnSm0PiKt3QoVYtjQQHUlKD2h2+9Aaefx1evK+U7p+swN/m2G2yptXQ+Q7ixq82bm+dF0APL7bWvwFO5fHEgsYIyqqr1M0H+cXGQf+BXaFGkoo1oSLNI2Ux/RhyNOZ3X+n0XmOQcaPD8y/8MryxHGIA4yrSZAOgFCWkDNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=B6BnT2tx; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1741309120; x=1772845120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sQqXLYiJ1VVGRN+jOJACYXz/EcfmdNuv7Pcm+0ImUEs=;
  b=B6BnT2txDN5b7FwxaN0IL5vQOMpcwU63wgr2Ucfhp4AbhdEytd6dsJ43
   GRjHZoPPwsTdbXhueWmjO/odEK9Ui9fKmll5e7yXYyI4Q4G/h472FFDmL
   AZ9wHdJDtW1pAAu/tGxr9J+fxd0BrEJBwsG/3tzS7l7RZnCnAmzri77Qu
   w=;
X-IronPort-AV: E=Sophos;i="6.14,227,1736812800"; 
   d="scan'208";a="472783393"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 00:58:35 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:32828]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.101:2525] with esmtp (Farcaster)
 id 6f9afba4-0449-4880-b8c4-e10c02a9ebe8; Fri, 7 Mar 2025 00:58:34 +0000 (UTC)
X-Farcaster-Flow-ID: 6f9afba4-0449-4880-b8c4-e10c02a9ebe8
Received: from EX19D020UWA003.ant.amazon.com (10.13.138.254) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Mar 2025 00:58:34 +0000
Received: from EX19MTAUWB002.ant.amazon.com (10.250.64.231) by
 EX19D020UWA003.ant.amazon.com (10.13.138.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Mar 2025 00:58:34 +0000
Received: from email-imr-corp-prod-pdx-all-2c-475d797d.us-west-2.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 00:58:34 +0000
Received: from dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com [172.19.91.144])
	by email-imr-corp-prod-pdx-all-2c-475d797d.us-west-2.amazon.com (Postfix) with ESMTP id DAA12A5F81;
	Fri,  7 Mar 2025 00:58:33 +0000 (UTC)
Received: by dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id 13BED4FF9; Fri,  7 Mar 2025 00:58:33 +0000 (UTC)
From: Pratyush Yadav <ptyadav@amazon.de>
To: <linux-kernel@vger.kernel.org>
CC: Pratyush Yadav <ptyadav@amazon.de>, Jonathan Corbet <corbet@lwn.net>,
	"Eric Biederman" <ebiederm@xmission.com>, Arnd Bergmann <arnd@arndb.de>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, Hugh Dickins <hughd@google.com>, Alexander Graf
	<graf@amazon.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David
 Woodhouse" <dwmw2@infradead.org>, James Gowans <jgowans@amazon.com>, "Mike
 Rapoport" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Pasha
 Tatashin" <tatashin@google.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
	Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Matthew Wilcox <willy@infradead.org>, "Wei
 Yang" <richard.weiyang@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-mm@kvack.org>, <kexec@lists.infradead.org>
Subject: [RFC PATCH 5/5] mm/memfd: allow preserving FD over FDBOX + KHO
Date: Fri, 7 Mar 2025 00:57:39 +0000
Message-ID: <20250307005830.65293-6-ptyadav@amazon.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307005830.65293-1-ptyadav@amazon.de>
References: <20250307005830.65293-1-ptyadav@amazon.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

For applications with a large amount of memory that takes time to
rebuild, reboots to consume kernel upgrades can be very expensive. FDBox
allows preserving file descriptors over kexec using KHO. Combining that
with memfd gives those applications reboot-persistent memory that they
can use to quickly save and reconstruct that state.

While memfd is backed by either hugetlbfs or shmem, currently only
support on shmem is added for this. Allow saving and restoring shmem FDs
over FDBOX + KHO.

The memfd FDT node itself does not contain much information. It just
creates a subnode and passes it over to shmem to do its thing. Similar
behaviour is followed on the restore side.

Since there are now two paths of getting a shmem file, refactor the file
setup into its own function called memfd_setup_file(). It sets up the
file flags, mode, etc., and sets fdbox ops if enabled.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
---
 mm/memfd.c | 128 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 116 insertions(+), 12 deletions(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index 37f7be57c2f50..1c32e66197f6d 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -7,6 +7,8 @@
  * This file is released under the GPL.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/fs.h>
 #include <linux/vfs.h>
 #include <linux/pagemap.h>
@@ -19,8 +21,12 @@
 #include <linux/shmem_fs.h>
 #include <linux/memfd.h>
 #include <linux/pid_namespace.h>
+#include <linux/fdbox.h>
+#include <linux/libfdt.h>
 #include <uapi/linux/memfd.h>
 
+static const struct fdbox_file_ops memfd_fdbox_fops;
+
 /*
  * We need a tag: a new tag would expand every xa_node by 8 bytes,
  * so reuse a tag which we firmly believe is never set or cleared on tmpfs
@@ -418,21 +424,10 @@ static char *alloc_name(const char __user *uname)
 	return ERR_PTR(error);
 }
 
-static struct file *alloc_file(const char *name, unsigned int flags)
+static void memfd_setup_file(struct file *file, unsigned int flags)
 {
 	unsigned int *file_seals;
-	struct file *file;
 
-	if (flags & MFD_HUGETLB) {
-		file = hugetlb_file_setup(name, 0, VM_NORESERVE,
-					HUGETLB_ANONHUGE_INODE,
-					(flags >> MFD_HUGE_SHIFT) &
-					MFD_HUGE_MASK);
-	} else {
-		file = shmem_file_setup(name, 0, VM_NORESERVE);
-	}
-	if (IS_ERR(file))
-		return file;
 	file->f_mode |= FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
 	file->f_flags |= O_LARGEFILE;
 
@@ -452,6 +447,27 @@ static struct file *alloc_file(const char *name, unsigned int flags)
 			*file_seals &= ~F_SEAL_SEAL;
 	}
 
+#if defined(CONFIG_FDBOX) && defined(CONFIG_KEXEC_HANDOVER)
+	file->f_fdbox_op = &memfd_fdbox_fops;
+#endif
+}
+
+static struct file *alloc_file(const char *name, unsigned int flags)
+{
+	struct file *file;
+
+	if (flags & MFD_HUGETLB) {
+		file = hugetlb_file_setup(name, 0, VM_NORESERVE,
+					  HUGETLB_ANONHUGE_INODE,
+					  (flags >> MFD_HUGE_SHIFT) &
+					  MFD_HUGE_MASK);
+	} else {
+		file = shmem_file_setup(name, 0, VM_NORESERVE);
+	}
+	if (IS_ERR(file))
+		return file;
+
+	memfd_setup_file(file, flags);
 	return file;
 }
 
@@ -493,3 +509,91 @@ SYSCALL_DEFINE2(memfd_create,
 	kfree(name);
 	return error;
 }
+
+#if defined(CONFIG_FDBOX) && defined(CONFIG_KEXEC_HANDOVER)
+static const char memfd_fdbox_compatible[] = "fdbox,memfd-v1";
+
+static struct file *memfd_fdbox_kho_recover(const void *fdt, int offset)
+{
+	struct file *file;
+	int ret, subnode;
+
+	ret = fdt_node_check_compatible(fdt, offset, memfd_fdbox_compatible);
+	if (ret) {
+		pr_err("kho: invalid compatible\n");
+		return NULL;
+	}
+
+	/* Make sure there is exactly one subnode. */
+	subnode = fdt_first_subnode(fdt, offset);
+	if (subnode < 0) {
+		pr_err("kho: no subnode for underlying storage found!\n");
+		return NULL;
+	}
+	if (fdt_next_subnode(fdt, subnode) >= 0) {
+		pr_err("kho: too many subnodes. Expected only 1.\n");
+		return NULL;
+	}
+
+	if (is_node_shmem(fdt, subnode)) {
+		file = shmem_fdbox_kho_recover(fdt, subnode);
+		if (!file)
+			return NULL;
+
+		memfd_setup_file(file, 0);
+		return file;
+	}
+
+	return NULL;
+}
+
+static int memfd_fdbox_kho_write(struct fdbox_fd *box_fd, void *fdt)
+{
+	int ret = 0;
+
+	ret |= fdt_property(fdt, "compatible", memfd_fdbox_compatible,
+			    sizeof(memfd_fdbox_compatible));
+
+	/* TODO: Track seals on the file as well. */
+
+	ret |= fdt_begin_node(fdt, "");
+	if (ret) {
+		pr_err("kho: failed to set up memfd node\n");
+		return -EINVAL;
+	}
+
+	if (shmem_file(box_fd->file))
+		ret = shmem_fdbox_kho_write(box_fd, fdt);
+	else
+		/* TODO: HugeTLB support. */
+		ret = -EOPNOTSUPP;
+
+	if (ret)
+		return ret;
+
+	ret = fdt_end_node(fdt);
+	if (ret) {
+		pr_err("kho: failed to end memfd node!\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct fdbox_file_ops memfd_fdbox_fops = {
+	.kho_write = memfd_fdbox_kho_write,
+};
+
+static int __init memfd_fdbox_init(void)
+{
+	int error;
+
+	error = fdbox_register_handler(memfd_fdbox_compatible,
+				       memfd_fdbox_kho_recover);
+	if (error)
+		pr_err("Could not register fdbox handler: %d\n", error);
+
+	return 0;
+}
+late_initcall(memfd_fdbox_init);
+#endif /* CONFIG_FDBOX && CONFIG_KEXEC_HANDOVER */
-- 
2.47.1


