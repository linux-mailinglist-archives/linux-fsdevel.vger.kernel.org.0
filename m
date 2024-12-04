Return-Path: <linux-fsdevel+bounces-36449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880AA9E3AAA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 13:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D36167ECA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC85120ADE4;
	Wed,  4 Dec 2024 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K06GoZ5r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA26A20B219
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316925; cv=none; b=SkolW8UcGHWbFNX8ipN2p5dX9g/aB8o0L3EJ4TEU5jTks/50H6oTYN2AVrOaD9sLTag8/ryN7SUi0y8PCiyvs/vojuDYEvSiuV7+AN/3VG+Xjb2Ce8XWQuul5lzNcOk2uffpcJmcvGGcyb+wwD2dS73qKyDYI5usscAqM7m64BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316925; c=relaxed/simple;
	bh=N+omNMBxmCIiBaT6aoDaJz2BLDTJK2NT8K0YRXJ+Was=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9KRPzyjKoj4KOysait6NMPlWUDFwAo4HpZKRzKbF3DD9bsWI4Fiq+fLFIkMXvzhlst/ANQSWjrGHspRk5Rv3owlL9zbKoSBjgPJrWEyZaKlHr/FDL0QBmaoeCo3LVxHz2axXE+DHim4i/h/ykZSblY3kj9WQgT0NFKRf0RdzC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K06GoZ5r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GxsrWUisM+4YkdsHUV4TP4AYDbO5CJkwL1nd2GKtk5k=;
	b=K06GoZ5rr3R/W2L2FHfsfoQiTojEtr86CwiQuqvyllogryALBF52oqIhMyc42BdokMdHwo
	/XyOI4FOE2e8DPx2J9thMVnNPkz//5jzXyRuyePXP5RYB0+n9BLuCbOp8ZhpfU/uIssfh6
	qmId0FsrRE+YyYqidld09CCGs6wfutc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-CPZlS3ixPmi4lbEZqN53eA-1; Wed, 04 Dec 2024 07:55:21 -0500
X-MC-Unique: CPZlS3ixPmi4lbEZqN53eA-1
X-Mimecast-MFC-AGG-ID: CPZlS3ixPmi4lbEZqN53eA
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385ded5e92aso2626988f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2024 04:55:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316921; x=1733921721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxsrWUisM+4YkdsHUV4TP4AYDbO5CJkwL1nd2GKtk5k=;
        b=rXATlMiCN7yYOOyOZ3WX3BMtvpkM8cyK6ILqjnCi0BaVto4wXHKH+ZQCTbp4kV3t5H
         xEkrohTNSZ+Zxqd9yf3ZAJSunZv6bEYXT0sHJqMU9U1j3TQTH49iDPif45PGwwpy+pgi
         CIkNSQFZjXmgEM4ddYV7TEPvStb/sPmg7aMgfrqpj189aIYTrKUOevsrO/uRvlP4Cgyz
         B/sib4EXS0USmfU56hTHIMHzDXLCnmVk7DJ/6zwBEj//Y26kKoyztmzk/98gnYv5ifb5
         Eu7TZpmdlY3cdZF55IKqlU4JJIAag8LuMJbayRShkKbxCffF+HL+joPNHrQ37GlFxiQn
         m/kA==
X-Forwarded-Encrypted: i=1; AJvYcCUsQjD5Q5WLIkVscCXGwCb5mxJ8t2XnZh2YI3c5R/xD5aMH9c3ZN3tcEzLrb+KfQmnkwhV/RBoMWOnd9q8t@vger.kernel.org
X-Gm-Message-State: AOJu0YymZqGeKqrEh1tIjzd7GPpNmVKmZdwLcgssC+K/ckMKGamVegs7
	DHXShD7PLTS8OOQxFTau27iXqayiDyUpTCTQ4KBkN3nVP0FuPJcCCGtMlEldFY5eWEZuCTUod0r
	Sx7POPzML/YLLPPVGaW7kJ09D49wD3OI6MjkUe/SlBgYWoRuXP+QwxBRqCi2OgF4=
X-Gm-Gg: ASbGnctrpqKJQOTSUExYatg/ROWepf7A6JhYYJHnRp10e43gcbjCRuOPnowe1WZhPbs
	jpnQvm18VpFM1Ohgb08sR8sSkZd9s5ndOvGYPDbvo84Ivq7Hk3iLoyv9PodFsgxQiFAuPJ+CjqD
	WajG02x0Jh/DckrtWrTLWZ4A8vr6xHYonJuXpA5TXQt/uyFpNvk6uX3Dfkt5gCB+2agxsj8zlS6
	m3//CsU7UG03TQDrAVUm6mb5UpcsSlZfHNgCdYAjVd23X3lvXXHfuZaVgwL9vGoEvIwwlfFb1NJ
	f72WZP+XLxX3sMA9uCpkvMwlOn30RTuXARQ=
X-Received: by 2002:a5d:5986:0:b0:382:4115:1ccb with SMTP id ffacd0b85a97d-385fd3cd078mr5363641f8f.7.1733316920743;
        Wed, 04 Dec 2024 04:55:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVrn7snw7RGTPCk/ImHOMtvIc2Zo//ldD8UcsohYWGwkye1iFqtEVkXPmZASBRCfdSRO6pnw==
X-Received: by 2002:a5d:5986:0:b0:382:4115:1ccb with SMTP id ffacd0b85a97d-385fd3cd078mr5363620f8f.7.1733316920347;
        Wed, 04 Dec 2024 04:55:20 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-434d52c0bc7sm23529155e9.35.2024.12.04.04.55.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:55:19 -0800 (PST)
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
Subject: [PATCH v2 11/12] virtio-mem: support CONFIG_PROC_VMCORE_DEVICE_RAM
Date: Wed,  4 Dec 2024 13:54:42 +0100
Message-ID: <20241204125444.1734652-12-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241204125444.1734652-1-david@redhat.com>
References: <20241204125444.1734652-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's implement the get_device_ram() vmcore callback, so
architectures that select NEED_PROC_VMCORE_NEED_DEVICE_RAM, like s390
soon, can include that memory in a crash dump.

Merge ranges, and process ranges that might contain a mixture of plugged
and unplugged, to reduce the total number of ranges.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 88 +++++++++++++++++++++++++++++++++++++
 fs/proc/Kconfig             |  1 +
 2 files changed, 89 insertions(+)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 73477d5b79cf..8a294b9cbcf6 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2728,6 +2728,91 @@ static bool virtio_mem_vmcore_pfn_is_ram(struct vmcore_cb *cb,
 	mutex_unlock(&vm->hotplug_mutex);
 	return is_ram;
 }
+
+#ifdef CONFIG_PROC_VMCORE_DEVICE_RAM
+static int virtio_mem_vmcore_add_device_ram(struct virtio_mem *vm,
+		struct list_head *list, uint64_t start, uint64_t end)
+{
+	int rc;
+
+	rc = vmcore_alloc_add_range(list, start, end - start);
+	if (rc)
+		dev_err(&vm->vdev->dev,
+			 "Error adding device RAM range: %d\n", rc);
+	return rc;
+}
+
+static int virtio_mem_vmcore_get_device_ram(struct vmcore_cb *cb,
+		struct list_head *list)
+{
+	struct virtio_mem *vm = container_of(cb, struct virtio_mem,
+					     vmcore_cb);
+	const uint64_t device_start = vm->addr;
+	const uint64_t device_end = vm->addr + vm->usable_region_size;
+	uint64_t chunk_size, cur_start, cur_end, plugged_range_start = 0;
+	LIST_HEAD(tmp_list);
+	int rc;
+
+	if (!vm->plugged_size)
+		return 0;
+
+	/* Process memory sections, unless the device block size is bigger. */
+	chunk_size = max_t(uint64_t, PFN_PHYS(PAGES_PER_SECTION),
+			   vm->device_block_size);
+
+	mutex_lock(&vm->hotplug_mutex);
+
+	/*
+	 * We process larger chunks and indicate the complete chunk if any
+	 * block in there is plugged. This reduces the number of pfn_is_ram()
+	 * callbacks and mimic what is effectively being done when the old
+	 * kernel would add complete memory sections/blocks to the elfcore hdr.
+	 */
+	cur_start = device_start;
+	for (cur_start = device_start; cur_start < device_end; cur_start = cur_end) {
+		cur_end = ALIGN_DOWN(cur_start + chunk_size, chunk_size);
+		cur_end = min_t(uint64_t, cur_end, device_end);
+
+		rc = virtio_mem_send_state_request(vm, cur_start,
+						   cur_end - cur_start);
+
+		if (rc < 0) {
+			dev_err(&vm->vdev->dev,
+				"Error querying block states: %d\n", rc);
+			goto out;
+		} else if (rc != VIRTIO_MEM_STATE_UNPLUGGED) {
+			/* Merge ranges with plugged memory. */
+			if (!plugged_range_start)
+				plugged_range_start = cur_start;
+			continue;
+		}
+
+		/* Flush any plugged range. */
+		if (plugged_range_start) {
+			rc = virtio_mem_vmcore_add_device_ram(vm, &tmp_list,
+							      plugged_range_start,
+							      cur_start);
+			if (rc)
+				goto out;
+			plugged_range_start = 0;
+		}
+	}
+
+	/* Flush any plugged range. */
+	if (plugged_range_start)
+		rc = virtio_mem_vmcore_add_device_ram(vm, &tmp_list,
+						      plugged_range_start,
+						      cur_start);
+out:
+	mutex_unlock(&vm->hotplug_mutex);
+	if (rc < 0) {
+		vmcore_free_ranges(&tmp_list);
+		return rc;
+	}
+	list_splice_tail(&tmp_list, list);
+	return 0;
+}
+#endif /* CONFIG_PROC_VMCORE_DEVICE_RAM */
 #endif /* CONFIG_PROC_VMCORE */
 
 static int virtio_mem_init_kdump(struct virtio_mem *vm)
@@ -2737,6 +2822,9 @@ static int virtio_mem_init_kdump(struct virtio_mem *vm)
 #ifdef CONFIG_PROC_VMCORE
 	dev_info(&vm->vdev->dev, "memory hot(un)plug disabled in kdump kernel\n");
 	vm->vmcore_cb.pfn_is_ram = virtio_mem_vmcore_pfn_is_ram;
+#ifdef CONFIG_PROC_VMCORE_DEVICE_RAM
+	vm->vmcore_cb.get_device_ram = virtio_mem_vmcore_get_device_ram;
+#endif /* CONFIG_PROC_VMCORE_DEVICE_RAM */
 	register_vmcore_cb(&vm->vmcore_cb);
 	return 0;
 #else /* CONFIG_PROC_VMCORE */
diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
index 5668620ab34d..6ae966c561e7 100644
--- a/fs/proc/Kconfig
+++ b/fs/proc/Kconfig
@@ -67,6 +67,7 @@ config NEED_PROC_VMCORE_DEVICE_RAM
 config PROC_VMCORE_DEVICE_RAM
 	def_bool y
 	depends on PROC_VMCORE && NEED_PROC_VMCORE_DEVICE_RAM
+	depends on VIRTIO_MEM
 	help
 	  If the elfcore hdr is allocated and prepared by the dump kernel
 	  ("2nd kernel") instead of the crashed kernel, RAM provided by memory
-- 
2.47.1


