Return-Path: <linux-fsdevel+bounces-36438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 583839E3A72
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 13:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15BF6166232
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A081BD51B;
	Wed,  4 Dec 2024 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQo4ssTx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910091B414D
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 12:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316893; cv=none; b=hfenpM3Dn8LkDE4bdmi8orFuErgQN81e1VPYu7TCYK2xWXSVTYL3zEs768b2ZM81G+YSGq5ip/k7hJ8yzmkiU3sWP/i8W+T/dDrAD76t0vhdvzhRY0MGAxqf3jdFfuWfcxviohcPJePd6xGD3Air2tXl+TIbWhNmDD3WBT3MrOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316893; c=relaxed/simple;
	bh=0zbsmpMAssyLsVVURUESxkxvV3Okxt9izdw3A4a2nWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rftq/KnSEil6OdJyXA/Jn4Q450JOTGqr4g84eJcJMFUTyTejmmJdvnVp6HWdwsFCmnMyS1jIX0Jhc9/8SDSD2+kt9zJoQMputO/a1/hJNxD33G7dkJ6c5MiNG9ffrsVenUBkKQmtGYRDm/UJECg9aK0sTJRVCruL3ytvpRHoDEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dQo4ssTx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MB2MAmGSlUi5YLf0fUp0VNgn+MFysC4aDDm3o00zI78=;
	b=dQo4ssTxIMyeopv1YcD3KVbQGNNDW3P4KZYdCNxbig923f15xWFwztyquizyZ94zgoSqIa
	3S+SdmXIZpkbLPOHz27GUV8fnaK36y+NfMpPtyQuHZHl0A6JpD90TzuCx4uQt9L7owuZhY
	lT68kMjUzHBw4OpyoQo7wQjLBePg3Z8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-RTWBqmkrOLuSwFartKJjkA-1; Wed, 04 Dec 2024 07:54:49 -0500
X-MC-Unique: RTWBqmkrOLuSwFartKJjkA-1
X-Mimecast-MFC-AGG-ID: RTWBqmkrOLuSwFartKJjkA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-434ad71268dso4903495e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2024 04:54:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316888; x=1733921688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MB2MAmGSlUi5YLf0fUp0VNgn+MFysC4aDDm3o00zI78=;
        b=ZY5n5UKKqX0BcKsAErpGrIofzTuRKbA2D3PV7kiMVOC5a9JQDRqy1+mm4AaOIRJHpB
         OTw90uDPA4dTyq+63WPCOaF/MIvpDcF8DTauOkRw9DG82sgN85JC/fP8U+cmJJiCz4Om
         AFmh1Sa/luQ75hPB5i+p88Z1I3iL2FwxuJyteJfTuLE7Ubc2U1QLUromWC4qSu/pf1gr
         ooOtSrvMft510KNYM+a3q13LqAgfYWJ8CC58JI4fzQOJR9K8z7ChfQiDxzMR0WFpByf1
         /f4lDk0JXtPliiF3Hh9XK4q9Xq8m4KHMKxa2AHXamqyy0cPlh65V7pnFsNMuoOymKxwK
         nMrg==
X-Forwarded-Encrypted: i=1; AJvYcCXi0fpRVd8lIv4SIBJkpruVUAYSeC7LACIi0GK4oLV9dDImtIU+FGTICYo9nzYF9I9LXz1OSQmrDo2mTxMJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzXRtXwnaSYhSZjFLxiFJu8VPZ+nUIy/xIJrLsHTLD3SmWuaYE6
	99Qc91DTf/1YsaD37gK367wm45iLkQNmL4IEoNcqiWut3aLdGN25sD7qW6UFtVNWPhlhnfmzlnb
	31I1JSfWQkmL5diZyUjhf2Q3oIhaAnvRhxHQ5juREb6t5uaDKaxACVW2PaJqH/S0=
X-Gm-Gg: ASbGncuMLkuOLV6FQrJEyfKwERU5IOkK6v4Uchxqz5GnCxgifT8/IGiTNUDcoRXIjk9
	wRkb1gSmbYOHRjhCr61QB4KYi99YcBwrKK5hAaGuP3uADklMlModkEhUMcXT28xUduYZI8QOhU3
	6AniQ6Xv5RYttTQzBDzxOnz+AoGczbk0M/QmUJC/bKzVzt7XpxVFzYsQJuwGyLY1aLFy4oarP4n
	HxXdWQXxlAqbGNzeCofKtKDfpngGuH4ywN9hm1BjvLSMsansNoLssSst9IUXWajumFX4V2e+A4h
	prDxmhRb4ngNIR00tg71zJvZ+fvWSqeyWE8=
X-Received: by 2002:a05:600c:6c8a:b0:434:8e8a:d4ec with SMTP id 5b1f17b1804b1-434afc3b6e1mr245982105e9.13.1733316888158;
        Wed, 04 Dec 2024 04:54:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjMr0hScnPOMMpphAyax2V0MFBHZqym1YHIjea01hMzMXczx6opOHdnARaXNIvDZGqHVvbtg==
X-Received: by 2002:a05:600c:6c8a:b0:434:8e8a:d4ec with SMTP id 5b1f17b1804b1-434afc3b6e1mr245981785e9.13.1733316887744;
        Wed, 04 Dec 2024 04:54:47 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-434d52c0bc7sm23514855e9.35.2024.12.04.04.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:54:46 -0800 (PST)
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
Subject: [PATCH v2 00/12] fs/proc/vmcore: kdump support for virtio-mem on s390
Date: Wed,  4 Dec 2024 13:54:31 +0100
Message-ID: <20241204125444.1734652-1-david@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The only "different than everything else" thing about virtio-mem on s390
is kdump: The crash (2nd) kernel allocates+prepares the elfcore hdr
during fs_init()->vmcore_init()->elfcorehdr_alloc(). Consequently, the
kdump kernel must detect memory ranges of the crashed kernel to
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

My testing when creating+analyzing crash dumps with hotplugged virtio-mem
memory (incl. holes) did not reveal any surprises.

Patch #1 -- #7 are vmcore preparations and cleanups
Patch #8 adds the infrastructure for drivers to report device RAM
Patch #9 + #10 are virtio-mem preparations
Patch #11 implements virtio-mem support to report device RAM
Patch #12 activates it for s390, implementing a new function to fill
          PT_LOAD entry for device RAM

v1 -> v2:
* "fs/proc/vmcore: convert vmcore_cb_lock into vmcore_mutex"
 -> Extend patch description
* "fs/proc/vmcore: replace vmcoredd_mutex by vmcore_mutex"
 -> Extend patch description
* "fs/proc/vmcore: disallow vmcore modifications while the vmcore is open"
 -> Disallow modifications only if it is currently open, but warn if it
    was already open and got closed again.
 -> Track vmcore_open vs. vmcore_opened
 -> Extend patch description
* "fs/proc/vmcore: prefix all pr_* with "vmcore:""
 -> Added
* "fs/proc/vmcore: move vmcore definitions out if kcore.h"
 -> Call it "vmcore_range"
 -> Place vmcoredd_node into vmcore.c
 -> Adjust patch subject + description
* "fs/proc/vmcore: factor out allocating a vmcore range and adding it to a
   list"
 -> Adjust to "vmcore_range"
* "fs/proc/vmcore: factor out freeing a list of vmcore ranges"
 -> Adjust to "vmcore_range"
* "fs/proc/vmcore: introduce PROC_VMCORE_DEVICE_RAM to detect device RAM
   ranges in 2nd kernel"
 -> Drop PROVIDE_PROC_VMCORE_DEVICE_RAM for now
 -> Simplify Kconfig a bit
 -> Drop "Kdump:" from warnings/errors
 -> Perform Elf64 check first
 -> Add regions also if the vmcore was opened, but got closed again. But
    warn in any case, because it is unexpected.
 -> Adjust patch description
* "virtio-mem: support CONFIG_PROC_VMCORE_DEVICE_RAM"
 -> "depends on VIRTIO_MEM" for PROC_VMCORE_DEVICE_RAM


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

David Hildenbrand (12):
  fs/proc/vmcore: convert vmcore_cb_lock into vmcore_mutex
  fs/proc/vmcore: replace vmcoredd_mutex by vmcore_mutex
  fs/proc/vmcore: disallow vmcore modifications while the vmcore is open
  fs/proc/vmcore: prefix all pr_* with "vmcore:"
  fs/proc/vmcore: move vmcore definitions out of kcore.h
  fs/proc/vmcore: factor out allocating a vmcore range and adding it to
    a list
  fs/proc/vmcore: factor out freeing a list of vmcore ranges
  fs/proc/vmcore: introduce PROC_VMCORE_DEVICE_RAM to detect device RAM
    ranges in 2nd kernel
  virtio-mem: mark device ready before registering callbacks in kdump
    mode
  virtio-mem: remember usable region size
  virtio-mem: support CONFIG_PROC_VMCORE_DEVICE_RAM
  s390/kdump: virtio-mem kdump support (CONFIG_PROC_VMCORE_DEVICE_RAM)

 arch/s390/Kconfig             |   1 +
 arch/s390/kernel/crash_dump.c |  39 ++++-
 drivers/virtio/virtio_mem.c   | 103 ++++++++++++-
 fs/proc/Kconfig               |  19 +++
 fs/proc/vmcore.c              | 283 ++++++++++++++++++++++++++--------
 include/linux/crash_dump.h    |  41 +++++
 include/linux/kcore.h         |  13 --
 7 files changed, 407 insertions(+), 92 deletions(-)


base-commit: feffde684ac29a3b7aec82d2df850fbdbdee55e4
-- 
2.47.1


