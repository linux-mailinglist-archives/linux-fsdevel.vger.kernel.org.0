Return-Path: <linux-fsdevel+bounces-24986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BFF94787F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 11:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C21F3B243E0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 09:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C661547E0;
	Mon,  5 Aug 2024 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="aur9+Bpu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC28D1547CA;
	Mon,  5 Aug 2024 09:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850572; cv=none; b=p/Pbom4hmJMF5WhR2siVd1dPHQXsaSzbknLTU9TCXwpzz8P16Jq+X3Th4ik+P4XLAsBj/rawDwqtYqiwu/KZsxJLKqLIWx+LVLFyMhspuRM+HQzP9hn6wqccuAfXVX5JobNnRxATe7IW2buVaMWsBTpkaedyZtyGHIdCWZ0xFaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850572; c=relaxed/simple;
	bh=xwSuldwE4yHRJC8JDggPK/sVRYuHgShOqIYd7zewYKs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lKuX6ulaDkXbGN0PL8R05nyTQywOysQKe8dIapjzWev6O0cFaPlcq9VOxcPfSlQzqHTex9+eZUcsmp9PwaNH45RrZj88Efyygxl0oYY8Ne7+KBwAzfSetfCl4xwVPjnyq+mVdV+77+Rqh1iCI/SL/K5k2a53oo5vBgWDDxdPK9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=aur9+Bpu; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722850572; x=1754386572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SYxgCtdC1svzDJcgLJLCz3gGK5To5Xu2NrqOWTnvUZY=;
  b=aur9+Bpuy0I6VRNLR1quWtNir4JC6/+tOrHP/zvkm3mxMDJ/Pv95JTVe
   sY2dPIj14tLylmshb+78F5E0XfLiz9t02YAcodpFGpz7HzF+GXlSFzZ5T
   Gx9QmVttKy/cgu3OkX6oaXEPyxpzTylln2shS/Plc+xfqRMBKoCvmxNKj
   A=;
X-IronPort-AV: E=Sophos;i="6.09,264,1716249600"; 
   d="scan'208";a="747199432"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 09:36:11 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.10.100:34899]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.4.201:2525] with esmtp (Farcaster)
 id 7ef1e7da-8235-4c57-b9f9-879b313d6daf; Mon, 5 Aug 2024 09:36:09 +0000 (UTC)
X-Farcaster-Flow-ID: 7ef1e7da-8235-4c57-b9f9-879b313d6daf
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 09:36:08 +0000
Received: from u5d18b891348c5b.ant.amazon.com (10.146.13.113) by
 EX19D014EUC004.ant.amazon.com (10.252.51.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 09:35:59 +0000
From: James Gowans <jgowans@amazon.com>
To: <linux-kernel@vger.kernel.org>
CC: James Gowans <jgowans@amazon.com>, Sean Christopherson
	<seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Steve Sistare <steven.sistare@oracle.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Anthony
 Yznaga" <anthony.yznaga@oracle.com>, Mike Rapoport <rppt@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, <linux-mm@kvack.org>, Jason Gunthorpe
	<jgg@ziepe.ca>, <linux-fsdevel@vger.kernel.org>, Usama Arif
	<usama.arif@bytedance.com>, <kvm@vger.kernel.org>, Alexander Graf
	<graf@amazon.com>, David Woodhouse <dwmw@amazon.co.uk>, Paul Durrant
	<pdurrant@amazon.co.uk>, Nicolas Saenz Julienne <nsaenz@amazon.es>
Subject: [PATCH 09/10] guestmemfs: Add documentation and usage instructions
Date: Mon, 5 Aug 2024 11:32:44 +0200
Message-ID: <20240805093245.889357-10-jgowans@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805093245.889357-1-jgowans@amazon.com>
References: <20240805093245.889357-1-jgowans@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)

Describe the motivation for guestmemfs, the functionality it provides,
how to compile it in, how to use it as a source of guest memory, how to
persist it across kexec and save/restore a VM.

Signed-off-by: James Gowans <jgowans@amazon.com>
---
 Documentation/filesystems/guestmemfs.rst | 87 ++++++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/filesystems/guestmemfs.rst

diff --git a/Documentation/filesystems/guestmemfs.rst b/Documentation/filesystems/guestmemfs.rst
new file mode 100644
index 000000000000..d6ce0d194cc8
--- /dev/null
+++ b/Documentation/filesystems/guestmemfs.rst
@@ -0,0 +1,87 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================================
+Guestmemfs - Persistent in-memory guest RAM filesystem
+======================================================
+
+Overview
+========
+
+Guestmemfs is an in-memory filesystem designed specifically for the purpose of
+live update of virtual machines by being a persistent across kexec source of
+guest VM memory.
+
+Live update of a hypervisor refers to act of pausing running VMs, serialising
+state, kexec-ing into a new hypervisor image, re-hydraing the KVM guests and
+resuming them. To achieve this guest memory must be preserved across kexec.
+
+Additionally, guestmemfs provides:
+- secret hiding for guest memory: the physical memory allocated for guestmemfs
+  is carved out of the direct map early in boot.
+- struct page overhead elimination: guestmemfs memory is not allocated by the
+  buddy allocator and does not have associated struct pages.
+- huge page mappings: allocations are done at PMD size and this improves TLB
+  performance (work in progress.)
+
+Compilation
+===========
+
+Guestmemfs is enabled via CONFIG_GUESTMEMFS_FS
+
+Persistence across kexec is enabled via CONFIG_KEXEC_KHO
+
+Usage
+=====
+
+On first boot (cold boot), allocate a large contiguous chunk of memory for
+guestmemfs via a kernel cmdline argument, eg:
+`guestmemfs=10G`.
+
+Mount guestmemfs:
+mount -t guestmemfs guestmemfs /mnt/guestmemfs/
+
+Create and truncate a file which will be used for guest RAM:
+
+touch /mnt/guesttmemfs/guest-ram
+truncate -s 500M /mnt/guestmemfs/guest-ram
+
+Boot a VM with this as the RAM source and the live update option enabled:
+
+qemu-system-x86_64 ... \
+  -object memory-backend-file,id=pc.ram,size=100M,mem-path=/mnt/guestmemfs/guest-ram,share=yes,prealloc=off \
+  -migrate-mode-enable cpr-reboot \
+  ...
+
+Suspect the guest and save the state via QEMU monitor:
+
+migrate_set_parameter mode cpr-reboot
+migrate file:/qemu.sav
+
+Activate KHO to serialise guestmemfs metadata and then kexec to the new
+hypervisor image:
+
+echo 1 > /sys/kernel/kho/active
+kexec -s -l --reuse-cmdline
+kexec -e
+
+After the kexec completes remount guestmemfs (or have it added to fstab)
+Re-start QEMU in live update restore mode:
+
+qemu-system-x86_64 ... \
+  -object memory-backend-file,id=pc.ram,size=100M,mem-path=/mnt/guestmemfs/guest-ram,share=yes,prealloc=off \
+  -migrate-mode-enable cpr-reboot \
+  -incoming defer
+  ...
+
+Finally restore the VM state and resume it via QEMU console:
+
+migrate_incoming file:/qemu.sav
+
+Future Work
+===========
+- NUMA awareness and multi-mount point support
+- Actually creating PMD-level mappings in page tables
+- guest_memfd style interface for confidential computing
+- supporting PUD-level allocations and mappings
+- MCE handling
+- Persisting IOMMU pgtables to allow DMA to guestmemfs during kexec
-- 
2.34.1


