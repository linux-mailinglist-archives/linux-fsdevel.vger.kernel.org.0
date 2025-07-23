Return-Path: <linux-fsdevel+bounces-55846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B3FB0F5EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 16:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB05B3AB51A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 14:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C65E2F5472;
	Wed, 23 Jul 2025 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="xYKX0kz+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0312F9481
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282031; cv=none; b=hGHsM3XudEQ/fKQDGLfRCwDGDDMgzsa3x3w4T9b6kjEQONrs4whBTtHEE16654ArB+HmiQG2NDKYGtOUvWkdHiu1N5TjIVVfsFFzl7Tfop8J3H1x592XaEYZRepiGbF3kjlPNjqcfCRI/w7vLkEG7p0/7KeMuBgwnWL1WP+q3qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282031; c=relaxed/simple;
	bh=CFuLiKLJh8N2wBbybcS5k5e7t7gAErTPWCFvcc5WXGU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXLbEB98MyW5GNcPKhxxJB4Qt9fcllKjjDVXD7OyWCK4prR5iVSMVDSdA4t0VF/tkReqb1hyd883TxeZwLk7duyChIHFx6Te0gLPKA6dwfY+/rL1M1p2f0ZBSkcY5meHlAAco2kWALGm534ObEcT0E5HniwqSQx6TRyUqBnJ72U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=xYKX0kz+; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71841a48502so55767767b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 07:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753282026; x=1753886826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P16dMjG+eBIby4m6CV13FKaPKlPVREZrX2+cF3fbAz8=;
        b=xYKX0kz+/axYGEMwZyZ51u1LhgFfdDGGPsY7Jbjq/MHx3E+4jSFgMDzNrpPwsV+GZQ
         HkIcaOrr6gQ/L8G8e8Wq7zlQ8CxvN9JtNt4BnsSfqtfWowG+eRb0VKQUXcTn/Jz1CfI+
         z7oZVVtBsD6BNCudonB9ZlOpaPhqzP4wBBs4gN/8tm701XCI60sxbEc56B1rap1ch8z0
         B99EXG6mDpxmEDbSETI35aCTw88eaJerEFlumYflSMjmgu7UuOKtQQG/bwpXxKF9U2C9
         RxrMuI2jySWRBy5MwMShDH0c/TGmhyvC9sgcKJZxJWv0WpDFb0NyW3DoTRs5u0hzKIH7
         mBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282026; x=1753886826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P16dMjG+eBIby4m6CV13FKaPKlPVREZrX2+cF3fbAz8=;
        b=oOBBBV8qMCCYuVMlBQDZJpaDVmaUB36f7knO8VVZ+gLbm3yFkQikuTjh5XwjMsGvJ5
         3uXUB4Efl78HoWIYUDomnX/yZXQRmnSLeCwmNhwUA+4td3fKl/S+FFlfjO+xoPXRTBR7
         +Uyl0VvtMbX21mpFkDPT2BjQvAjREb8chqqn7fKu3D36qzJGhSedzaYidME4sK7PGDPG
         TWjBv9jAgEnn2mZ6iRuhlD3V+Sj5VHP3aykydJO2ocGObc/oGuUxhVRWMyqMGln0NUIc
         Pv5hzd7vOjzABjEjm7j+4P45R3pOZW9d0PStbgjFcffSUsgqK7oO4w4jZqjiRKbMnx+W
         wsEw==
X-Forwarded-Encrypted: i=1; AJvYcCUOL5H69T0K0zjnr9jhhVDIegYabWhtKliD8KVyYEVfyDezW9S4tmcA0eozC7H1Jv2BjwxRArkoRCm96QJD@vger.kernel.org
X-Gm-Message-State: AOJu0YxrKPJt9eIvlLbKMORnJdCCLMys8X3P4d7qSkWOUMY+9HXtiSCL
	NiCR6TyvGGsEOSFdAMLK3bJYAgAzer50EoHDQb+OTulpQRpbhMBrfxqUyfTzE3QGbUY=
X-Gm-Gg: ASbGncvW0roc0THRtjaqQqLVPgJX9vjeToBskDs8jumrQ5Z5WKNrACrCAL7lwkdG6Av
	yXAKtVNHAn1lHF++MkwX1tGd8pTtXFqjwoCDvfmOGYgDt4ii/L/JLcoLPGA3B1XpD3wwOk3zx6q
	e+YS20+Mn7qPnsO3x9TC1KPpueeeLFHs730RqTPumVPuBFFpMsXPR60FcXsnKY0x1fLBUH4wM0N
	xOinZHKYgnZ9X65ancez3Og+f1apc16JSFqv8L8VslK9W8gqgHpF2MNo55JlXpF3A0YzzypSanj
	WReCdpdJ6h65VIj71djk1Hfwl4PbjUraaMoWx3aA8Dn/ZWQndE/YiVMkAUDc0FaAKXWRFoGjejj
	HE9YN0p0OKIM0kKpO8hsXi0mOjRdD36C0emQkXHSFNS9XkNeuvNNoAOU31wCJ+UOxbgmSdM9vmX
	X1UbWeWFU5UBFMNA==
X-Google-Smtp-Source: AGHT+IHWatUs7Hs0KKZ14v/cggc4Ed333ZLRxX+YU0gH76DWBOv1E+jPUtUb0U/ZKTGi/fUUCRdxmw==
X-Received: by 2002:a05:690c:3809:b0:719:5664:87fd with SMTP id 00721157ae682-719b4256275mr41785577b3.37.1753282026373;
        Wed, 23 Jul 2025 07:47:06 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm30482117b3.72.2025.07.23.07.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:47:05 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com
Subject: [PATCH v2 06/32] kho: drop notifiers
Date: Wed, 23 Jul 2025 14:46:19 +0000
Message-ID: <20250723144649.1696299-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

The KHO framework uses a notifier chain as the mechanism for clients to
participate in the finalization process. While this works for a single,
central state machine, it is too restrictive for kernel-internal
components like pstore/reserve_mem or IMA. These components need a
simpler, direct way to register their state for preservation (e.g.,
during their initcall) without being part of a complex,
shutdown-time notifier sequence. The notifier model forces all
participants into a single finalization flow and makes direct
preservation from an arbitrary context difficult.
This patch refactors the client participation model by removing the
notifier chain and introducing a direct API for managing FDT subtrees.

The core kho_finalize() and kho_abort() state machine remains, but
clients now register their data with KHO beforehand.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/kexec_handover.h   |  28 +----
 kernel/kexec_handover.c          | 177 +++++++++++++++++--------------
 kernel/kexec_handover_debug.c    |  17 +--
 kernel/kexec_handover_internal.h |   5 +-
 mm/memblock.c                    |  56 ++--------
 5 files changed, 124 insertions(+), 159 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index f98565def593..cabdff5f50a2 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -10,14 +10,7 @@ struct kho_scratch {
 	phys_addr_t size;
 };
 
-/* KHO Notifier index */
-enum kho_event {
-	KEXEC_KHO_FINALIZE = 0,
-	KEXEC_KHO_ABORT = 1,
-};
-
 struct folio;
-struct notifier_block;
 
 #define DECLARE_KHOSER_PTR(name, type) \
 	union {                        \
@@ -36,20 +29,16 @@ struct notifier_block;
 		(typeof((s).ptr))((s).phys ? phys_to_virt((s).phys) : NULL); \
 	})
 
-struct kho_serialization;
-
 #ifdef CONFIG_KEXEC_HANDOVER
 bool kho_is_enabled(void);
 
 int kho_preserve_folio(struct folio *folio);
 int kho_preserve_phys(phys_addr_t phys, size_t size);
 struct folio *kho_restore_folio(phys_addr_t phys);
-int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt);
+int kho_add_subtree(const char *name, void *fdt);
+void kho_remove_subtree(void *fdt);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
 
-int register_kho_notifier(struct notifier_block *nb);
-int unregister_kho_notifier(struct notifier_block *nb);
-
 void kho_memory_init(void);
 
 void kho_populate(phys_addr_t fdt_phys, u64 fdt_len, phys_addr_t scratch_phys,
@@ -79,23 +68,16 @@ static inline struct folio *kho_restore_folio(phys_addr_t phys)
 	return NULL;
 }
 
-static inline int kho_add_subtree(struct kho_serialization *ser,
-				  const char *name, void *fdt)
+static inline int kho_add_subtree(const char *name, void *fdt)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
+static inline void kho_remove_subtree(void *fdt)
 {
-	return -EOPNOTSUPP;
 }
 
-static inline int register_kho_notifier(struct notifier_block *nb)
-{
-	return -EOPNOTSUPP;
-}
-
-static inline int unregister_kho_notifier(struct notifier_block *nb)
+static inline int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 32fdc388752b..30d673f7f68a 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -15,7 +15,6 @@
 #include <linux/libfdt.h>
 #include <linux/list.h>
 #include <linux/memblock.h>
-#include <linux/notifier.h>
 #include <linux/page-isolation.h>
 
 #include <asm/early_ioremap.h>
@@ -82,11 +81,35 @@ struct kho_mem_track {
 
 struct khoser_mem_chunk;
 
-struct kho_serialization {
-	struct page *fdt;
+struct kho_sub_fdt {
+	struct list_head l;
+	const char *name;
+	void *fdt;
+};
+
+struct kho_out {
+	void *fdt;
+	bool finalized;
+	struct mutex lock; /* protects KHO FDT finalization */
+
+	struct list_head sub_fdts;
+	struct mutex fdts_lock;
+
 	struct kho_mem_track track;
 	/* First chunk of serialized preserved memory map */
 	struct khoser_mem_chunk *preserved_mem_map;
+
+	struct kho_debugfs dbg;
+};
+
+static struct kho_out kho_out = {
+	.lock = __MUTEX_INITIALIZER(kho_out.lock),
+	.track = {
+		.orders = XARRAY_INIT(kho_out.track.orders, 0),
+	},
+	.sub_fdts = LIST_HEAD_INIT(kho_out.sub_fdts),
+	.fdts_lock = __MUTEX_INITIALIZER(kho_out.fdts_lock),
+	.finalized = false,
 };
 
 static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
@@ -285,14 +308,14 @@ static void kho_mem_ser_free(struct khoser_mem_chunk *first_chunk)
 	}
 }
 
-static int kho_mem_serialize(struct kho_serialization *ser)
+static int kho_mem_serialize(struct kho_out *kho_out)
 {
 	struct khoser_mem_chunk *first_chunk = NULL;
 	struct khoser_mem_chunk *chunk = NULL;
 	struct kho_mem_phys *physxa;
 	unsigned long order;
 
-	xa_for_each(&ser->track.orders, order, physxa) {
+	xa_for_each(&kho_out->track.orders, order, physxa) {
 		struct kho_mem_phys_bits *bits;
 		unsigned long phys;
 
@@ -320,7 +343,7 @@ static int kho_mem_serialize(struct kho_serialization *ser)
 		}
 	}
 
-	ser->preserved_mem_map = first_chunk;
+	kho_out->preserved_mem_map = first_chunk;
 
 	return 0;
 
@@ -567,28 +590,8 @@ static void __init kho_reserve_scratch(void)
 	kho_enable = false;
 }
 
-struct kho_out {
-	struct blocking_notifier_head chain_head;
-	struct mutex lock; /* protects KHO FDT finalization */
-	struct kho_serialization ser;
-	bool finalized;
-	struct kho_debugfs dbg;
-};
-
-static struct kho_out kho_out = {
-	.chain_head = BLOCKING_NOTIFIER_INIT(kho_out.chain_head),
-	.lock = __MUTEX_INITIALIZER(kho_out.lock),
-	.ser = {
-		.track = {
-			.orders = XARRAY_INIT(kho_out.ser.track.orders, 0),
-		},
-	},
-	.finalized = false,
-};
-
 /**
  * kho_add_subtree - record the physical address of a sub FDT in KHO root tree.
- * @ser: serialization control object passed by KHO notifiers.
  * @name: name of the sub tree.
  * @fdt: the sub tree blob.
  *
@@ -602,34 +605,45 @@ static struct kho_out kho_out = {
  *
  * Return: 0 on success, error code on failure
  */
-int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt)
+int kho_add_subtree(const char *name, void *fdt)
 {
-	int err = 0;
-	u64 phys = (u64)virt_to_phys(fdt);
-	void *root = page_to_virt(ser->fdt);
+	struct kho_sub_fdt *sub_fdt;
+	int err;
 
-	err |= fdt_begin_node(root, name);
-	err |= fdt_property(root, PROP_SUB_FDT, &phys, sizeof(phys));
-	err |= fdt_end_node(root);
+	sub_fdt = kmalloc(sizeof(*sub_fdt), GFP_KERNEL);
+	if (!sub_fdt)
+		return -ENOMEM;
 
-	if (err)
-		return err;
+	INIT_LIST_HEAD(&sub_fdt->l);
+	sub_fdt->name = name;
+	sub_fdt->fdt = fdt;
+
+	mutex_lock(&kho_out.fdts_lock);
+	list_add_tail(&sub_fdt->l, &kho_out.sub_fdts);
+	err = kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, false);
+	mutex_unlock(&kho_out.fdts_lock);
 
-	return kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, false);
+	return err;
 }
 EXPORT_SYMBOL_GPL(kho_add_subtree);
 
-int register_kho_notifier(struct notifier_block *nb)
+void kho_remove_subtree(void *fdt)
 {
-	return blocking_notifier_chain_register(&kho_out.chain_head, nb);
-}
-EXPORT_SYMBOL_GPL(register_kho_notifier);
+	struct kho_sub_fdt *sub_fdt;
+
+	mutex_lock(&kho_out.fdts_lock);
+	list_for_each_entry(sub_fdt, &kho_out.sub_fdts, l) {
+		if (sub_fdt->fdt == fdt) {
+			list_del(&sub_fdt->l);
+			kfree(sub_fdt);
+			kho_debugfs_fdt_remove(&kho_out.dbg, fdt);
+			break;
+		}
+	}
+	mutex_unlock(&kho_out.fdts_lock);
 
-int unregister_kho_notifier(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_unregister(&kho_out.chain_head, nb);
 }
-EXPORT_SYMBOL_GPL(unregister_kho_notifier);
+EXPORT_SYMBOL_GPL(kho_remove_subtree);
 
 /**
  * kho_preserve_folio - preserve a folio across kexec.
@@ -644,7 +658,7 @@ int kho_preserve_folio(struct folio *folio)
 {
 	const unsigned long pfn = folio_pfn(folio);
 	const unsigned int order = folio_order(folio);
-	struct kho_mem_track *track = &kho_out.ser.track;
+	struct kho_mem_track *track = &kho_out.track;
 
 	if (kho_out.finalized)
 		return -EBUSY;
@@ -670,7 +684,7 @@ int kho_preserve_phys(phys_addr_t phys, size_t size)
 	const unsigned long start_pfn = pfn;
 	const unsigned long end_pfn = PHYS_PFN(phys + size);
 	int err = 0;
-	struct kho_mem_track *track = &kho_out.ser.track;
+	struct kho_mem_track *track = &kho_out.track;
 
 	if (kho_out.finalized)
 		return -EBUSY;
@@ -700,11 +714,11 @@ EXPORT_SYMBOL_GPL(kho_preserve_phys);
 
 static int __kho_abort(void)
 {
-	int err;
+	int err = 0;
 	unsigned long order;
 	struct kho_mem_phys *physxa;
 
-	xa_for_each(&kho_out.ser.track.orders, order, physxa) {
+	xa_for_each(&kho_out.track.orders, order, physxa) {
 		struct kho_mem_phys_bits *bits;
 		unsigned long phys;
 
@@ -714,17 +728,13 @@ static int __kho_abort(void)
 		xa_destroy(&physxa->phys_bits);
 		kfree(physxa);
 	}
-	xa_destroy(&kho_out.ser.track.orders);
+	xa_destroy(&kho_out.track.orders);
 
-	if (kho_out.ser.preserved_mem_map) {
-		kho_mem_ser_free(kho_out.ser.preserved_mem_map);
-		kho_out.ser.preserved_mem_map = NULL;
+	if (kho_out.preserved_mem_map) {
+		kho_mem_ser_free(kho_out.preserved_mem_map);
+		kho_out.preserved_mem_map = NULL;
 	}
 
-	err = blocking_notifier_call_chain(&kho_out.chain_head, KEXEC_KHO_ABORT,
-					   NULL);
-	err = notifier_to_errno(err);
-
 	if (err)
 		pr_err("Failed to abort KHO finalization: %d\n", err);
 
@@ -751,7 +761,7 @@ int kho_abort(void)
 
 	kho_out.finalized = false;
 
-	kho_debugfs_cleanup(&kho_out.dbg);
+	kho_debugfs_fdt_remove(&kho_out.dbg, kho_out.fdt);
 
 unlock:
 	mutex_unlock(&kho_out.lock);
@@ -763,41 +773,46 @@ static int __kho_finalize(void)
 {
 	int err = 0;
 	u64 *preserved_mem_map;
-	void *fdt = page_to_virt(kho_out.ser.fdt);
+	void *root = kho_out.fdt;
+	struct kho_sub_fdt *fdt;
 
-	err |= fdt_create(fdt, PAGE_SIZE);
-	err |= fdt_finish_reservemap(fdt);
-	err |= fdt_begin_node(fdt, "");
-	err |= fdt_property_string(fdt, "compatible", KHO_FDT_COMPATIBLE);
+	err |= fdt_create(root, PAGE_SIZE);
+	err |= fdt_finish_reservemap(root);
+	err |= fdt_begin_node(root, "");
+	err |= fdt_property_string(root, "compatible", KHO_FDT_COMPATIBLE);
 	/**
 	 * Reserve the preserved-memory-map property in the root FDT, so
 	 * that all property definitions will precede subnodes created by
 	 * KHO callers.
 	 */
-	err |= fdt_property_placeholder(fdt, PROP_PRESERVED_MEMORY_MAP,
+	err |= fdt_property_placeholder(root, PROP_PRESERVED_MEMORY_MAP,
 					sizeof(*preserved_mem_map),
 					(void **)&preserved_mem_map);
 	if (err)
 		goto abort;
 
-	err = kho_preserve_folio(page_folio(kho_out.ser.fdt));
+	err = kho_preserve_folio(virt_to_folio(kho_out.fdt));
 	if (err)
 		goto abort;
 
-	err = blocking_notifier_call_chain(&kho_out.chain_head,
-					   KEXEC_KHO_FINALIZE, &kho_out.ser);
-	err = notifier_to_errno(err);
+	err = kho_mem_serialize(&kho_out);
 	if (err)
 		goto abort;
 
-	err = kho_mem_serialize(&kho_out.ser);
-	if (err)
-		goto abort;
+	*preserved_mem_map = (u64)virt_to_phys(kho_out.preserved_mem_map);
 
-	*preserved_mem_map = (u64)virt_to_phys(kho_out.ser.preserved_mem_map);
+	mutex_lock(&kho_out.fdts_lock);
+	list_for_each_entry(fdt, &kho_out.sub_fdts, l) {
+		phys_addr_t phys = virt_to_phys(fdt->fdt);
 
-	err |= fdt_end_node(fdt);
-	err |= fdt_finish(fdt);
+		err |= fdt_begin_node(root, fdt->name);
+		err |= fdt_property(root, PROP_SUB_FDT, &phys, sizeof(phys));
+		err |= fdt_end_node(root);
+	};
+	mutex_unlock(&kho_out.fdts_lock);
+
+	err |= fdt_end_node(root);
+	err |= fdt_finish(root);
 
 abort:
 	if (err) {
@@ -828,7 +843,7 @@ int kho_finalize(void)
 
 	kho_out.finalized = true;
 	ret = kho_debugfs_fdt_add(&kho_out.dbg, "fdt",
-				  page_to_virt(kho_out.ser.fdt), true);
+				  kho_out.fdt, true);
 
 unlock:
 	mutex_unlock(&kho_out.lock);
@@ -901,15 +916,17 @@ static __init int kho_init(void)
 {
 	int err = 0;
 	const void *fdt = kho_get_fdt();
+	struct page *fdt_page;
 
 	if (!kho_enable)
 		return 0;
 
-	kho_out.ser.fdt = alloc_page(GFP_KERNEL);
-	if (!kho_out.ser.fdt) {
+	fdt_page = alloc_page(GFP_KERNEL);
+	if (!fdt_page) {
 		err = -ENOMEM;
 		goto err_free_scratch;
 	}
+	kho_out.fdt = page_to_virt(fdt_page);
 
 	err = kho_debugfs_init();
 	if (err)
@@ -937,8 +954,8 @@ static __init int kho_init(void)
 	return 0;
 
 err_free_fdt:
-	put_page(kho_out.ser.fdt);
-	kho_out.ser.fdt = NULL;
+	put_page(fdt_page);
+	kho_out.fdt = NULL;
 err_free_scratch:
 	for (int i = 0; i < kho_scratch_cnt; i++) {
 		void *start = __va(kho_scratch[i].addr);
@@ -949,7 +966,7 @@ static __init int kho_init(void)
 	kho_enable = false;
 	return err;
 }
-late_initcall(kho_init);
+fs_initcall(kho_init);
 
 static void __init kho_release_scratch(void)
 {
@@ -1085,7 +1102,7 @@ int kho_fill_kimage(struct kimage *image)
 	if (!kho_enable)
 		return 0;
 
-	image->kho.fdt = page_to_phys(kho_out.ser.fdt);
+	image->kho.fdt = virt_to_phys(kho_out.fdt);
 
 	scratch_size = sizeof(*kho_scratch) * kho_scratch_cnt;
 	scratch = (struct kexec_buf){
diff --git a/kernel/kexec_handover_debug.c b/kernel/kexec_handover_debug.c
index b88d138a97be..af4bad225630 100644
--- a/kernel/kexec_handover_debug.c
+++ b/kernel/kexec_handover_debug.c
@@ -61,14 +61,17 @@ int kho_debugfs_fdt_add(struct kho_debugfs *dbg, const char *name,
 	return __kho_debugfs_fdt_add(&dbg->fdt_list, dir, name, fdt);
 }
 
-void kho_debugfs_cleanup(struct kho_debugfs *dbg)
+void kho_debugfs_fdt_remove(struct kho_debugfs *dbg, void *fdt)
 {
-	struct fdt_debugfs *ff, *tmp;
-
-	list_for_each_entry_safe(ff, tmp, &dbg->fdt_list, list) {
-		debugfs_remove(ff->file);
-		list_del(&ff->list);
-		kfree(ff);
+	struct fdt_debugfs *ff;
+
+	list_for_each_entry(ff, &dbg->fdt_list, list) {
+		if (ff->wrapper.data == fdt) {
+			debugfs_remove(ff->file);
+			list_del(&ff->list);
+			kfree(ff);
+			break;
+		}
 	}
 }
 
diff --git a/kernel/kexec_handover_internal.h b/kernel/kexec_handover_internal.h
index 41e9616fcdd0..240517596ea3 100644
--- a/kernel/kexec_handover_internal.h
+++ b/kernel/kexec_handover_internal.h
@@ -30,7 +30,7 @@ void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt);
 int kho_out_debugfs_init(struct kho_debugfs *dbg);
 int kho_debugfs_fdt_add(struct kho_debugfs *dbg, const char *name,
 			const void *fdt, bool root);
-void kho_debugfs_cleanup(struct kho_debugfs *dbg);
+void kho_debugfs_fdt_remove(struct kho_debugfs *dbg, void *fdt);
 #else
 static inline int kho_debugfs_init(void) { return 0; }
 static inline void kho_in_debugfs_init(struct kho_debugfs *dbg,
@@ -38,7 +38,8 @@ static inline void kho_in_debugfs_init(struct kho_debugfs *dbg,
 static inline int kho_out_debugfs_init(struct kho_debugfs *dbg) { return 0; }
 static inline int kho_debugfs_fdt_add(struct kho_debugfs *dbg, const char *name,
 				      const void *fdt, bool root) { return 0; }
-static inline void kho_debugfs_cleanup(struct kho_debugfs *dbg) {}
+static inline void kho_debugfs_fdt_remove(struct kho_debugfs *dbg,
+					  void *fdt) { }
 #endif /* CONFIG_KEXEC_HANDOVER_DEBUG */
 
 #endif /* LINUX_KEXEC_HANDOVER_INTERNAL_H */
diff --git a/mm/memblock.c b/mm/memblock.c
index 154f1d73b61f..6af0b51b1bb7 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2501,51 +2501,18 @@ int reserve_mem_release_by_name(const char *name)
 #define MEMBLOCK_KHO_FDT "memblock"
 #define MEMBLOCK_KHO_NODE_COMPATIBLE "memblock-v1"
 #define RESERVE_MEM_KHO_NODE_COMPATIBLE "reserve-mem-v1"
-static struct page *kho_fdt;
-
-static int reserve_mem_kho_finalize(struct kho_serialization *ser)
-{
-	int err = 0, i;
-
-	for (i = 0; i < reserved_mem_count; i++) {
-		struct reserve_mem_table *map = &reserved_mem_table[i];
-
-		err |= kho_preserve_phys(map->start, map->size);
-	}
-
-	err |= kho_preserve_folio(page_folio(kho_fdt));
-	err |= kho_add_subtree(ser, MEMBLOCK_KHO_FDT, page_to_virt(kho_fdt));
-
-	return notifier_from_errno(err);
-}
-
-static int reserve_mem_kho_notifier(struct notifier_block *self,
-				    unsigned long cmd, void *v)
-{
-	switch (cmd) {
-	case KEXEC_KHO_FINALIZE:
-		return reserve_mem_kho_finalize((struct kho_serialization *)v);
-	case KEXEC_KHO_ABORT:
-		return NOTIFY_DONE;
-	default:
-		return NOTIFY_BAD;
-	}
-}
-
-static struct notifier_block reserve_mem_kho_nb = {
-	.notifier_call = reserve_mem_kho_notifier,
-};
 
 static int __init prepare_kho_fdt(void)
 {
 	int err = 0, i;
+	struct page *fdt_page;
 	void *fdt;
 
-	kho_fdt = alloc_page(GFP_KERNEL);
-	if (!kho_fdt)
+	fdt_page = alloc_page(GFP_KERNEL);
+	if (!fdt_page)
 		return -ENOMEM;
 
-	fdt = page_to_virt(kho_fdt);
+	fdt = page_to_virt(fdt_page);
 
 	err |= fdt_create(fdt, PAGE_SIZE);
 	err |= fdt_finish_reservemap(fdt);
@@ -2555,6 +2522,7 @@ static int __init prepare_kho_fdt(void)
 	for (i = 0; i < reserved_mem_count; i++) {
 		struct reserve_mem_table *map = &reserved_mem_table[i];
 
+		err |= kho_preserve_phys(map->start, map->size);
 		err |= fdt_begin_node(fdt, map->name);
 		err |= fdt_property_string(fdt, "compatible", RESERVE_MEM_KHO_NODE_COMPATIBLE);
 		err |= fdt_property(fdt, "start", &map->start, sizeof(map->start));
@@ -2562,13 +2530,14 @@ static int __init prepare_kho_fdt(void)
 		err |= fdt_end_node(fdt);
 	}
 	err |= fdt_end_node(fdt);
-
 	err |= fdt_finish(fdt);
 
+	err |= kho_preserve_folio(page_folio(fdt_page));
+	err |= kho_add_subtree(MEMBLOCK_KHO_FDT, fdt);
+
 	if (err) {
 		pr_err("failed to prepare memblock FDT for KHO: %d\n", err);
-		put_page(kho_fdt);
-		kho_fdt = NULL;
+		put_page(fdt_page);
 	}
 
 	return err;
@@ -2584,13 +2553,6 @@ static int __init reserve_mem_init(void)
 	err = prepare_kho_fdt();
 	if (err)
 		return err;
-
-	err = register_kho_notifier(&reserve_mem_kho_nb);
-	if (err) {
-		put_page(kho_fdt);
-		kho_fdt = NULL;
-	}
-
 	return err;
 }
 late_initcall(reserve_mem_init);
-- 
2.50.0.727.gbf7dc18ff4-goog


