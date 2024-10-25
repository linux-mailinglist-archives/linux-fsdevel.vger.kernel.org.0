Return-Path: <linux-fsdevel+bounces-32892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 759A49B0782
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 17:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992321C25C45
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 15:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1BD21A4C8;
	Fri, 25 Oct 2024 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dewpe2RA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F80521A4A2
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 15:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869113; cv=none; b=BHbmEgI/0+Y4vABtBg2ThdnqW6qznB5fWNMV5YmtDtu5vRZgf5Y+2F5sYBxXcxgSL4VEldBe47lFfSZRhQBhQkLYr+5p4pac9wrjfEV6onvMHXf9cICzDniW7p2rdVocN7xZCgQx50uK+VJJycJbg45JtRBVzOVAju1j8DsaTM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869113; c=relaxed/simple;
	bh=yV6pVwQ11uis4mpoclJ57UcmuD0CDcfn0XwosB2EEH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NHmQOSkCxBPBtA745zR5KEg6oU7S4dY/aMnjXfwFZGjxc8oMj7nIgSrWrIAIdJ1kpXL0sr5X+TZoJ8YYIEYe0EDELcF4OGlgElxdZNqcNo4a/SLndW3TKSnzgAjm8zJWFXMJb2t7UaR0D5pGBIqH/HYWzBGdEB6w5IIbUQNz8Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dewpe2RA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729869110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QjXxCmbGyjt3cTdnXge0Xs0ObzNL+3C4WmSnlfC/eHc=;
	b=dewpe2RAQYnz0Mr+DRx61PXHf+8uJAnef7yw5VteXzzMT84JiQf6i5j4xkbuVhSqPfwVjk
	CSGRcnqKgBV7dO+3CNn+c5ZMePMnKN3kQhGjGgFCTg+XzYRm6blCgZOA2/6flCb6LMvvbW
	uvk89y0Hxk+B/J1ViCm2yB9p9VVgVu0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-ADxDlDjTM6qViV2-qHlzTA-1; Fri,
 25 Oct 2024 11:11:47 -0400
X-MC-Unique: ADxDlDjTM6qViV2-qHlzTA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF56C1955E85;
	Fri, 25 Oct 2024 15:11:44 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.65.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 45618300018D;
	Fri, 25 Oct 2024 15:11:35 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 00/11] fs/proc/vmcore: kdump support for virtio-mem on s390
Date: Fri, 25 Oct 2024 17:11:22 +0200
Message-ID: <20241025151134.1275575-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This is based on "[PATCH v3 0/7] virtio-mem: s390 support" [1], which adds
virtio-mem support on s390.

The only "different than everything else" thing about virtio-mem on s390
is kdump: The crash (2nd) kernel allocates+prepares the elfcore hdr
during fs_init()->vmcore_init()->elfcorehdr_alloc(). Consequently, the
crash kernel must detect memory ranges of the crashed/panicked kernel to
include via PT_LOAD in the vmcore.

On other architectures, all RAM regions (boot + hotplugged) can easily be
observed on the old (to crash) kernel (e.g., using /proc/iomem) to create
the elfcore hdr.

On s390, information about "ordinary" memory (heh, "storage") can be
obtained by querying the hypervisor/ultravisor via SCLP/diag260, and
that information is stored early during boot in the "physmem" memblock
data structure.

But virtio-mem memory is always detected by as device driver, which is
usually build as a module. So in the crash kernel, this memory can only be
properly detected once the virtio-mem driver started up.

The virtio-mem driver already supports the "kdump mode", where it won't
hotplug any memory but instead queries the device to implement the
pfn_is_ram() callback, to avoid reading unplugged memory holes when reading
the vmcore.

With this series, if the virtio-mem driver is included in the kdump
initrd -- which dracut already takes care of under Fedora/RHEL -- it will
now detect the device RAM ranges on s390 once it probes the devices, to add
them to the vmcore using the same callback mechanism we already have for
pfn_is_ram().

To add these device RAM ranges to the vmcore ("patch the vmcore"), we will
add new PT_LOAD entries that describe these memory ranges, and update
all offsets vmcore size so it is all consistent.

Note that makedumfile is shaky with v6.12-rcX, I made the "obvious" things
(e.g., free page detection) work again while testing as documented in [2].

Creating the dumps using makedumpfile seems to work fine, and the
dump regions (PT_LOAD) are as expected. I yet have to check in more detail
if the created dumps are good (IOW, the right memory was dumped, but it
looks like makedumpfile reads the right memory when interpreting the
kernel data structures, which is promising).

Patch #1 -- #6 are vmcore preparations and cleanups
Patch #7 adds the infrastructure for drivers to report device RAM
Patch #8 + #9 are virtio-mem preparations
Patch #10 implements virtio-mem support to report device RAM
Patch #11 activates it for s390, implementing a new function to fill
          PT_LOAD entry for device RAM

[1] https://lkml.kernel.org/r/20241025141453.1210600-1-david@redhat.com
[2] https://github.com/makedumpfile/makedumpfile/issues/16

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Eugenio Pérez" <eperezma@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>

David Hildenbrand (11):
  fs/proc/vmcore: convert vmcore_cb_lock into vmcore_mutex
  fs/proc/vmcore: replace vmcoredd_mutex by vmcore_mutex
  fs/proc/vmcore: disallow vmcore modifications after the vmcore was
    opened
  fs/proc/vmcore: move vmcore definitions from kcore.h to crash_dump.h
  fs/proc/vmcore: factor out allocating a vmcore memory node
  fs/proc/vmcore: factor out freeing a list of vmcore ranges
  fs/proc/vmcore: introduce PROC_VMCORE_DEVICE_RAM to detect device RAM
    ranges in 2nd kernel
  virtio-mem: mark device ready before registering callbacks in kdump
    mode
  virtio-mem: remember usable region size
  virtio-mem: support CONFIG_PROC_VMCORE_DEVICE_RAM
  s390/kdump: virtio-mem kdump support (CONFIG_PROC_VMCORE_DEVICE_RAM)

 arch/s390/Kconfig             |   1 +
 arch/s390/kernel/crash_dump.c |  39 +++--
 drivers/virtio/Kconfig        |   1 +
 drivers/virtio/virtio_mem.c   | 103 +++++++++++++-
 fs/proc/Kconfig               |  25 ++++
 fs/proc/vmcore.c              | 258 +++++++++++++++++++++++++---------
 include/linux/crash_dump.h    |  47 +++++++
 include/linux/kcore.h         |  13 --
 8 files changed, 396 insertions(+), 91 deletions(-)

-- 
2.46.1


