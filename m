Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6361C37AB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 13:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgEDLEp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 07:04:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47588 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728572AbgEDLEB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 07:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588590238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fSn3n1+VKSGdJaAakXEFfOuaSKKQn6CmMSoun+hZIb8=;
        b=fjfzFCSMrOVOo2/VRZxXGhR7ZuUU58ZL4xjH2FzJaU48IftF3BEvwbFriW5gtafocH1bgx
        jCtK1pRRBVA+9apuo+2q/Guor5Ap+vFuQgAd1DgHFhPuEJ6mUIUd0B5o2zwlAvHp3KbhIe
        CWog1iauv6nKyXlkIdUC/eDuEo3XhxA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-CaTPli1TMQKvQA1z_HVnJw-1; Mon, 04 May 2020 07:03:56 -0400
X-MC-Unique: CaTPli1TMQKvQA1z_HVnJw-1
Received: by mail-wm1-f69.google.com with SMTP id t62so4688702wma.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2020 04:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fSn3n1+VKSGdJaAakXEFfOuaSKKQn6CmMSoun+hZIb8=;
        b=uIrg9FGaUtrSsrOuyHmsmsy6d2lD2qYs+X5pXvTKvNF+7i0e2WkP+iEACWU010nvEV
         srIATlVwc1WbU8HLfnwL4Y0eUCqO7J9lhw2AyEGJY8yaNk6mgG8NQqApfr0x43UxFtqV
         TVANMyIi5cstucPpv9MGPYqh+ferub0Rn9/Nbu+Gl4c8X+WezzbN8e4qF2MvJLYheJMw
         vw37YIFza0lf2RMSRPpkB7r+eyz4KFrSGoTaCGa108Hs/nutY8WZqhlRoFd7L3EACZuG
         U7m5Ta6MT27dHG2imAxHOZafWN4EurAqTf1nwUffW0TcWBmPsoKi7d9/T/c5FUag8tY6
         zjow==
X-Gm-Message-State: AGi0PuZ/JBbQuUArsv9ZEsciq6HjCBKd5SOQjRqJalvgb9kGC4zFf5+f
        89gVRb+dZ15iB0mnYiEvblHO+Y2sNRmq7r8wma/MOx8hReqUp16yJWS0ODh5tlECiH2JEz7xjD0
        4Un6DJ0TDC9cmjwSdjDsjhFC3dQ==
X-Received: by 2002:a05:600c:2284:: with SMTP id 4mr13390257wmf.97.1588590235192;
        Mon, 04 May 2020 04:03:55 -0700 (PDT)
X-Google-Smtp-Source: APiQypLJqu3DOrztAyLE6v9HzeLihNpmYDouMJppNQ0dvBekcYyyFI3qXLea1b9RhQ4EcLdqXBNh8g==
X-Received: by 2002:a05:600c:2284:: with SMTP id 4mr13390197wmf.97.1588590234420;
        Mon, 04 May 2020 04:03:54 -0700 (PDT)
Received: from localhost.localdomain.com ([194.230.155.213])
        by smtp.gmail.com with ESMTPSA id a13sm10885750wrv.67.2020.05.04.04.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 04:03:53 -0700 (PDT)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PATCH v2 2/5] stats_fs API: create, add and remove stats_fs sources and values
Date:   Mon,  4 May 2020 13:03:41 +0200
Message-Id: <20200504110344.17560-3-eesposit@redhat.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200504110344.17560-1-eesposit@redhat.com>
References: <20200504110344.17560-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduction to the stats_fs API, that allows to easily create, add
and remove stats_fs sources and values. The API allows to easily building
the statistics directory tree to automatically gather them for the linux
kernel. The main functionalities are: create a source, add child
sources/values/aggregates, register it to the root source (that on
the virtual fs would be /sys/kernel/statsfs), ad perform a search for
a value/aggregate.

This allows creating any kind of source tree, making it more flexible
also to future readjustments.

The API representation is only logical and will be backed up
by a virtual file system in patch 4.
Its usage will be shared between the stats_fs file system
and the end-users like kvm, the former calling it when it needs to
display and clear statistics, the latter to add values and sources.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 MAINTAINERS              |   7 +
 fs/Kconfig               |   6 +
 fs/Makefile              |   1 +
 fs/stats_fs/Makefile     |   4 +
 fs/stats_fs/internal.h   |  20 ++
 fs/stats_fs/stats_fs.c   | 610 +++++++++++++++++++++++++++++++++++++++
 include/linux/stats_fs.h | 289 +++++++++++++++++++
 7 files changed, 937 insertions(+)
 create mode 100644 fs/stats_fs/Makefile
 create mode 100644 fs/stats_fs/internal.h
 create mode 100644 fs/stats_fs/stats_fs.c
 create mode 100644 include/linux/stats_fs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b816a453b10e..a8403d07cee5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5229,6 +5229,13 @@ F:	include/linux/debugfs.h
 F:	include/linux/kobj*
 F:	lib/kobj*
 
+STATS_FS
+M:	Paolo Bonzini <pbonzini@redhat.com>
+R:	Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
+S:	Supported
+F:	include/linux/stats_fs.h
+F:	fs/stats_fs
+
 DRIVERS FOR ADAPTIVE VOLTAGE SCALING (AVS)
 M:	Kevin Hilman <khilman@kernel.org>
 M:	Nishanth Menon <nm@ti.com>
diff --git a/fs/Kconfig b/fs/Kconfig
index f08fbbfafd9a..1b0de0f19e96 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -328,4 +328,10 @@ source "fs/unicode/Kconfig"
 config IO_WQ
 	bool
 
+config STATS_FS
+	bool "Statistics Filesystem"
+	help
+	  stats_fs is a virtual file system that provides counters and
+	  other statistics about the running kernel.
+
 endmenu
diff --git a/fs/Makefile b/fs/Makefile
index 2ce5112b02c8..91558eca0cf7 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -125,6 +125,7 @@ obj-$(CONFIG_BEFS_FS)		+= befs/
 obj-$(CONFIG_HOSTFS)		+= hostfs/
 obj-$(CONFIG_CACHEFILES)	+= cachefiles/
 obj-$(CONFIG_DEBUG_FS)		+= debugfs/
+obj-$(CONFIG_STATS_FS)		+= stats_fs/
 obj-$(CONFIG_TRACING)		+= tracefs/
 obj-$(CONFIG_OCFS2_FS)		+= ocfs2/
 obj-$(CONFIG_BTRFS_FS)		+= btrfs/
diff --git a/fs/stats_fs/Makefile b/fs/stats_fs/Makefile
new file mode 100644
index 000000000000..94fe52d590d5
--- /dev/null
+++ b/fs/stats_fs/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+stats_fs-objs	:= stats_fs.o
+
+obj-$(CONFIG_STATS_FS)	+= stats_fs.o
diff --git a/fs/stats_fs/internal.h b/fs/stats_fs/internal.h
new file mode 100644
index 000000000000..ddf262a60736
--- /dev/null
+++ b/fs/stats_fs/internal.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _STATS_FS_INTERNAL_H_
+#define _STATS_FS_INTERNAL_H_
+
+#include <linux/list.h>
+#include <linux/kref.h>
+#include <linux/rwsem.h>
+#include <linux/stats_fs.h>
+
+/* values, grouped by base */
+struct stats_fs_value_source {
+	void *base_addr;
+	bool files_created;
+	struct stats_fs_value *values;
+	struct list_head list_element;
+};
+
+int stats_fs_val_get_mode(struct stats_fs_value *val);
+
+#endif /* _STATS_FS_INTERNAL_H_ */
diff --git a/fs/stats_fs/stats_fs.c b/fs/stats_fs/stats_fs.c
new file mode 100644
index 000000000000..b63de12769e2
--- /dev/null
+++ b/fs/stats_fs/stats_fs.c
@@ -0,0 +1,610 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/rwsem.h>
+#include <linux/list.h>
+#include <linux/kref.h>
+#include <linux/limits.h>
+#include <linux/stats_fs.h>
+
+#include "internal.h"
+
+struct stats_fs_aggregate_value {
+	uint64_t sum, min, max;
+	uint32_t count, count_zero;
+};
+
+static int is_val_signed(struct stats_fs_value *val)
+{
+	return val->type & STATS_FS_SIGN;
+}
+
+int stats_fs_val_get_mode(struct stats_fs_value *val)
+{
+	return val->mode ? val->mode : 0644;
+}
+
+static struct stats_fs_value *find_value(struct stats_fs_value_source *src,
+					 struct stats_fs_value *val)
+{
+	struct stats_fs_value *entry;
+
+	for (entry = src->values; entry->name; entry++) {
+		if (entry == val)
+			return entry;
+	}
+	return NULL;
+}
+
+static struct stats_fs_value *
+search_value_in_source(struct stats_fs_source *src, struct stats_fs_value *arg,
+		       struct stats_fs_value_source **val_src)
+{
+	struct stats_fs_value *entry;
+	struct stats_fs_value_source *src_entry;
+
+	list_for_each_entry (src_entry, &src->values_head, list_element) {
+		entry = find_value(src_entry, arg);
+		if (entry) {
+			*val_src = src_entry;
+			return entry;
+		}
+	}
+
+	return NULL;
+}
+
+/* Called with rwsem held for writing */
+static struct stats_fs_value_source *create_value_source(void *base)
+{
+	struct stats_fs_value_source *val_src;
+
+	val_src = kzalloc(sizeof(struct stats_fs_value_source), GFP_KERNEL);
+	if (!val_src)
+		return ERR_PTR(-ENOMEM);
+
+	val_src->base_addr = base;
+	INIT_LIST_HEAD(&val_src->list_element);
+
+	return val_src;
+}
+
+int stats_fs_source_add_values(struct stats_fs_source *source,
+			       struct stats_fs_value *stat, void *ptr)
+{
+	struct stats_fs_value_source *val_src;
+	struct stats_fs_value_source *entry;
+
+	down_write(&source->rwsem);
+
+	list_for_each_entry (entry, &source->values_head, list_element) {
+		if (entry->base_addr == ptr && entry->values == stat) {
+			up_write(&source->rwsem);
+			return -EEXIST;
+		}
+	}
+
+	val_src = create_value_source(ptr);
+	val_src->values = (struct stats_fs_value *)stat;
+
+	/* add the val_src to the source list */
+	list_add(&val_src->list_element, &source->values_head);
+
+	up_write(&source->rwsem);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(stats_fs_source_add_values);
+
+void stats_fs_source_add_subordinate(struct stats_fs_source *source,
+				     struct stats_fs_source *sub)
+{
+	down_write(&source->rwsem);
+
+	stats_fs_source_get(sub);
+	list_add(&sub->list_element, &source->subordinates_head);
+
+	up_write(&source->rwsem);
+}
+EXPORT_SYMBOL_GPL(stats_fs_source_add_subordinate);
+
+/* Called with rwsem held for writing */
+static void
+stats_fs_source_remove_subordinate_locked(struct stats_fs_source *source,
+					  struct stats_fs_source *sub)
+{
+	struct stats_fs_source *src_entry;
+
+	list_for_each_entry (src_entry, &source->subordinates_head,
+			     list_element) {
+		if (src_entry == sub) {
+			list_del_init(&src_entry->list_element);
+			stats_fs_source_put(src_entry);
+			return;
+		}
+	}
+}
+
+void stats_fs_source_remove_subordinate(struct stats_fs_source *source,
+					struct stats_fs_source *sub)
+{
+	down_write(&source->rwsem);
+	stats_fs_source_remove_subordinate_locked(source, sub);
+	up_write(&source->rwsem);
+}
+EXPORT_SYMBOL_GPL(stats_fs_source_remove_subordinate);
+
+/* Called with rwsem held for reading */
+static uint64_t get_simple_value(struct stats_fs_value_source *src,
+				 struct stats_fs_value *val)
+{
+	uint64_t value_found;
+	void *address;
+
+	address = src->base_addr + val->offset;
+
+	switch (val->type) {
+	case STATS_FS_U8:
+		value_found = *((uint8_t *)address);
+		break;
+	case STATS_FS_U8 | STATS_FS_SIGN:
+		value_found = *((int8_t *)address);
+		break;
+	case STATS_FS_U16:
+		value_found = *((uint16_t *)address);
+		break;
+	case STATS_FS_U16 | STATS_FS_SIGN:
+		value_found = *((int16_t *)address);
+		break;
+	case STATS_FS_U32:
+		value_found = *((uint32_t *)address);
+		break;
+	case STATS_FS_U32 | STATS_FS_SIGN:
+		value_found = *((int32_t *)address);
+		break;
+	case STATS_FS_U64:
+		value_found = *((uint64_t *)address);
+		break;
+	case STATS_FS_U64 | STATS_FS_SIGN:
+		value_found = *((int64_t *)address);
+		break;
+	case STATS_FS_BOOL:
+		value_found = *((uint8_t *)address);
+		break;
+	default:
+		value_found = 0;
+		break;
+	}
+
+	return value_found;
+}
+
+/* Called with rwsem held for reading */
+static void clear_simple_value(struct stats_fs_value_source *src,
+			       struct stats_fs_value *val)
+{
+	void *address;
+
+	address = src->base_addr + val->offset;
+
+	switch (val->type) {
+	case STATS_FS_U8:
+		*((uint8_t *)address) = 0;
+		break;
+	case STATS_FS_U8 | STATS_FS_SIGN:
+		*((int8_t *)address) = 0;
+		break;
+	case STATS_FS_U16:
+		*((uint16_t *)address) = 0;
+		break;
+	case STATS_FS_U16 | STATS_FS_SIGN:
+		*((int16_t *)address) = 0;
+		break;
+	case STATS_FS_U32:
+		*((uint32_t *)address) = 0;
+		break;
+	case STATS_FS_U32 | STATS_FS_SIGN:
+		*((int32_t *)address) = 0;
+		break;
+	case STATS_FS_U64:
+		*((uint64_t *)address) = 0;
+		break;
+	case STATS_FS_U64 | STATS_FS_SIGN:
+		*((int64_t *)address) = 0;
+		break;
+	case STATS_FS_BOOL:
+		*((uint8_t *)address) = 0;
+		break;
+	default:
+		break;
+	}
+}
+
+/* Called with rwsem held for reading */
+static void
+search_all_simple_values(struct stats_fs_source *src,
+			 struct stats_fs_value_source *ref_src_entry,
+			 struct stats_fs_value *val,
+			 struct stats_fs_aggregate_value *agg)
+{
+	struct stats_fs_value_source *src_entry;
+	uint64_t value_found;
+
+	list_for_each_entry (src_entry, &src->values_head, list_element) {
+		/* skip aggregates */
+		if (src_entry->base_addr == NULL)
+			continue;
+
+		/* useless to search here */
+		if (src_entry->values != ref_src_entry->values)
+			continue;
+
+		/* must be here */
+		value_found = get_simple_value(src_entry, val);
+		agg->sum += value_found;
+		agg->count++;
+		agg->count_zero += (value_found == 0);
+
+		if (is_val_signed(val)) {
+			agg->max = (((int64_t)value_found) >=
+				    ((int64_t)agg->max)) ?
+					   value_found :
+					   agg->max;
+			agg->min = (((int64_t)value_found) <=
+				    ((int64_t)agg->min)) ?
+					   value_found :
+					   agg->min;
+		} else {
+			agg->max = (value_found >= agg->max) ? value_found :
+							       agg->max;
+			agg->min = (value_found <= agg->min) ? value_found :
+							       agg->min;
+		}
+	}
+}
+
+/* Called with rwsem held for reading */
+static void
+do_recursive_aggregation(struct stats_fs_source *root,
+			 struct stats_fs_value_source *ref_src_entry,
+			 struct stats_fs_value *val,
+			 struct stats_fs_aggregate_value *agg)
+{
+	struct stats_fs_source *subordinate;
+
+	/* search all simple values in this folder */
+	search_all_simple_values(root, ref_src_entry, val, agg);
+
+	/* recursively search in all subfolders */
+	list_for_each_entry (subordinate, &root->subordinates_head,
+			     list_element) {
+		down_read(&subordinate->rwsem);
+		do_recursive_aggregation(subordinate, ref_src_entry, val, agg);
+		up_read(&subordinate->rwsem);
+	}
+}
+
+/* Called with rwsem held for reading */
+static void init_aggregate_value(struct stats_fs_aggregate_value *agg,
+				 struct stats_fs_value *val)
+{
+	agg->count = agg->count_zero = agg->sum = 0;
+	if (is_val_signed(val)) {
+		agg->max = S64_MIN;
+		agg->min = S64_MAX;
+	} else {
+		agg->max = 0;
+		agg->min = U64_MAX;
+	}
+}
+
+/* Called with rwsem held for reading */
+static void store_final_value(struct stats_fs_aggregate_value *agg,
+			      struct stats_fs_value *val, uint64_t *ret)
+{
+	int operation;
+
+	operation = val->aggr_kind | is_val_signed(val);
+
+	switch (operation) {
+	case STATS_FS_AVG:
+		*ret = agg->count ? agg->sum / agg->count : 0;
+		break;
+	case STATS_FS_AVG | STATS_FS_SIGN:
+		*ret = agg->count ? ((int64_t)agg->sum) / agg->count : 0;
+		break;
+	case STATS_FS_SUM:
+	case STATS_FS_SUM | STATS_FS_SIGN:
+		*ret = agg->sum;
+		break;
+	case STATS_FS_MIN:
+	case STATS_FS_MIN | STATS_FS_SIGN:
+		*ret = agg->min;
+		break;
+	case STATS_FS_MAX:
+	case STATS_FS_MAX | STATS_FS_SIGN:
+		*ret = agg->max;
+		break;
+	case STATS_FS_COUNT_ZERO:
+	case STATS_FS_COUNT_ZERO | STATS_FS_SIGN:
+		*ret = agg->count_zero;
+		break;
+	default:
+		break;
+	}
+}
+
+/* Called with rwsem held for reading */
+static int stats_fs_source_get_value_locked(struct stats_fs_source *source,
+					    struct stats_fs_value *arg,
+					    uint64_t *ret)
+{
+	struct stats_fs_value_source *src_entry;
+	struct stats_fs_value *found;
+	struct stats_fs_aggregate_value aggr;
+
+	*ret = 0;
+
+	if (!arg)
+		return -ENOENT;
+
+	/* look in simple values */
+	found = search_value_in_source(source, arg, &src_entry);
+
+	if (!found) {
+		printk(KERN_ERR "Stats_fs: Value in source \"%s\" not found!\n",
+		       source->name);
+		return -ENOENT;
+	}
+
+	if (src_entry->base_addr != NULL) {
+		*ret = get_simple_value(src_entry, found);
+		return 0;
+	}
+
+	/* look in aggregates */
+	init_aggregate_value(&aggr, found);
+	do_recursive_aggregation(source, src_entry, found, &aggr);
+	store_final_value(&aggr, found, ret);
+
+	return 0;
+}
+
+int stats_fs_source_get_value(struct stats_fs_source *source,
+			      struct stats_fs_value *arg, uint64_t *ret)
+{
+	int retval;
+
+	down_read(&source->rwsem);
+	retval = stats_fs_source_get_value_locked(source, arg, ret);
+	up_read(&source->rwsem);
+
+	return retval;
+}
+EXPORT_SYMBOL_GPL(stats_fs_source_get_value);
+
+/* Called with rwsem held for reading */
+static void set_all_simple_values(struct stats_fs_source *src,
+				  struct stats_fs_value_source *ref_src_entry,
+				  struct stats_fs_value *val)
+{
+	struct stats_fs_value_source *src_entry;
+
+	list_for_each_entry (src_entry, &src->values_head, list_element) {
+		/* skip aggregates */
+		if (src_entry->base_addr == NULL)
+			continue;
+
+		/* wrong to search here */
+		if (src_entry->values != ref_src_entry->values)
+			continue;
+
+		if (src_entry->base_addr &&
+		    src_entry->values == ref_src_entry->values)
+			clear_simple_value(src_entry, val);
+	}
+}
+
+/* Called with rwsem held for reading */
+static void do_recursive_clean(struct stats_fs_source *root,
+			       struct stats_fs_value_source *ref_src_entry,
+			       struct stats_fs_value *val)
+{
+	struct stats_fs_source *subordinate;
+
+	/* search all simple values in this folder */
+	set_all_simple_values(root, ref_src_entry, val);
+
+	/* recursively search in all subfolders */
+	list_for_each_entry (subordinate, &root->subordinates_head,
+			     list_element) {
+		down_read(&subordinate->rwsem);
+		do_recursive_clean(subordinate, ref_src_entry, val);
+		up_read(&subordinate->rwsem);
+	}
+}
+
+/* Called with rwsem held for reading */
+static int stats_fs_source_clear_locked(struct stats_fs_source *source,
+					struct stats_fs_value *val)
+{
+	struct stats_fs_value_source *src_entry;
+	struct stats_fs_value *found;
+
+	if (!val)
+		return -ENOENT;
+
+	/* look in simple values */
+	found = search_value_in_source(source, val, &src_entry);
+
+	if (!found) {
+		printk(KERN_ERR "Stats_fs: Value in source \"%s\" not found!\n",
+		       source->name);
+		return -ENOENT;
+	}
+
+	if (src_entry->base_addr != NULL) {
+		clear_simple_value(src_entry, found);
+		return 0;
+	}
+
+	/* look in aggregates */
+	do_recursive_clean(source, src_entry, found);
+
+	return 0;
+}
+
+int stats_fs_source_clear(struct stats_fs_source *source,
+			  struct stats_fs_value *val)
+{
+	int retval;
+
+	down_read(&source->rwsem);
+	retval = stats_fs_source_clear_locked(source, val);
+	up_read(&source->rwsem);
+
+	return retval;
+}
+
+/* Called with rwsem held for reading */
+static struct stats_fs_value *
+find_value_by_name(struct stats_fs_value_source *src, char *val)
+{
+	struct stats_fs_value *entry;
+
+	for (entry = src->values; entry->name; entry++)
+		if (!strcmp(entry->name, val))
+			return entry;
+
+	return NULL;
+}
+
+/* Called with rwsem held for reading */
+static struct stats_fs_value *
+search_in_source_by_name(struct stats_fs_source *src, char *name)
+{
+	struct stats_fs_value *entry;
+	struct stats_fs_value_source *src_entry;
+
+	list_for_each_entry (src_entry, &src->values_head, list_element) {
+		entry = find_value_by_name(src_entry, name);
+		if (entry)
+			return entry;
+	}
+
+	return NULL;
+}
+
+int stats_fs_source_get_value_by_name(struct stats_fs_source *source,
+				      char *name, uint64_t *ret)
+{
+	struct stats_fs_value *val;
+	int retval;
+
+	down_read(&source->rwsem);
+	val = search_in_source_by_name(source, name);
+
+	if (!val) {
+		*ret = 0;
+		up_read(&source->rwsem);
+		return -ENOENT;
+	}
+
+	retval = stats_fs_source_get_value_locked(source, val, ret);
+	up_read(&source->rwsem);
+
+	return retval;
+}
+EXPORT_SYMBOL_GPL(stats_fs_source_get_value_by_name);
+
+void stats_fs_source_get(struct stats_fs_source *source)
+{
+	kref_get(&source->refcount);
+}
+EXPORT_SYMBOL_GPL(stats_fs_source_get);
+
+void stats_fs_source_revoke(struct stats_fs_source *source)
+{
+	struct stats_fs_value_source *val_src_entry;
+
+	down_write(&source->rwsem);
+
+	list_for_each_entry (val_src_entry, &source->values_head, list_element)
+		val_src_entry->base_addr = NULL;
+
+	up_write(&source->rwsem);
+}
+EXPORT_SYMBOL_GPL(stats_fs_source_revoke);
+
+/* Called with rwsem held for writing
+ *
+ * The refcount is 0 and the lock was taken before refcount
+ * went from 1 to 0
+ */
+static void stats_fs_source_destroy(struct kref *kref_source)
+{
+	struct stats_fs_value_source *val_src_entry;
+	struct list_head *it, *safe;
+	struct stats_fs_source *child, *source;
+
+	source = container_of(kref_source, struct stats_fs_source, refcount);
+
+	/* iterate through the values and delete them */
+	list_for_each_safe (it, safe, &source->values_head) {
+		val_src_entry = list_entry(it, struct stats_fs_value_source,
+					   list_element);
+		kfree(val_src_entry);
+	}
+
+	/* iterate through the subordinates and delete them */
+	list_for_each_safe (it, safe, &source->subordinates_head) {
+		child = list_entry(it, struct stats_fs_source, list_element);
+		stats_fs_source_remove_subordinate_locked(source, child);
+	}
+
+	up_write(&source->rwsem);
+	kfree(source->name);
+	kfree(source);
+}
+
+void stats_fs_source_put(struct stats_fs_source *source)
+{
+	kref_put_rwsem(&source->refcount, stats_fs_source_destroy,
+		       &source->rwsem);
+}
+EXPORT_SYMBOL_GPL(stats_fs_source_put);
+
+struct stats_fs_source *stats_fs_source_create(const char *fmt, ...)
+{
+	va_list ap;
+	char buf[100];
+	struct stats_fs_source *ret;
+	int char_needed;
+
+	va_start(ap, fmt);
+	char_needed = vsnprintf(buf, 100, fmt, ap);
+	va_end(ap);
+
+	ret = kzalloc(sizeof(struct stats_fs_source), GFP_KERNEL);
+	if (!ret)
+		return ERR_PTR(-ENOMEM);
+
+	ret->name = kstrdup(buf, GFP_KERNEL);
+	if (!ret->name) {
+		kfree(ret);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	kref_init(&ret->refcount);
+	init_rwsem(&ret->rwsem);
+
+	INIT_LIST_HEAD(&ret->values_head);
+	INIT_LIST_HEAD(&ret->subordinates_head);
+	INIT_LIST_HEAD(&ret->list_element);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(stats_fs_source_create);
diff --git a/include/linux/stats_fs.h b/include/linux/stats_fs.h
new file mode 100644
index 000000000000..dc2d2e11f5ea
--- /dev/null
+++ b/include/linux/stats_fs.h
@@ -0,0 +1,289 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ *  stats_fs.h - a tiny little statistics file system
+ *
+ *  Copyright (C) 2020 Emanuele Giuseppe Esposito
+ *  Copyright (C) 2020 Redhat.
+ *
+ */
+
+#ifndef _STATS_FS_H_
+#define _STATS_FS_H_
+
+#include <linux/list.h>
+
+/* Used to distinguish signed types */
+#define STATS_FS_SIGN 0x8000
+
+enum stat_type {
+	STATS_FS_U8 = 0,
+	STATS_FS_U16 = 1,
+	STATS_FS_U32 = 2,
+	STATS_FS_U64 = 3,
+	STATS_FS_BOOL = 4,
+	STATS_FS_S8 = STATS_FS_U8 | STATS_FS_SIGN,
+	STATS_FS_S16 = STATS_FS_U16 | STATS_FS_SIGN,
+	STATS_FS_S32 = STATS_FS_U32 | STATS_FS_SIGN,
+	STATS_FS_S64 = STATS_FS_U64 | STATS_FS_SIGN,
+};
+
+enum stat_aggr {
+	STATS_FS_NONE = 0,
+	STATS_FS_SUM,
+	STATS_FS_MIN,
+	STATS_FS_MAX,
+	STATS_FS_COUNT_ZERO,
+	STATS_FS_AVG,
+};
+
+struct stats_fs_value {
+	/* Name of the stat */
+	char *name;
+
+	/* Offset from base address to field containing the value */
+	int offset;
+
+	/* Type of the stat BOOL,U64,... */
+	enum stat_type type;
+
+	/* Aggregate type: MIN, MAX, SUM,... */
+	enum stat_aggr aggr_kind;
+
+	/* File mode */
+	uint16_t mode;
+};
+
+struct stats_fs_source {
+	struct kref refcount;
+
+	char *name;
+
+	/* list of source stats_fs_value_source*/
+	struct list_head values_head;
+
+	/* list of struct stats_fs_source for subordinate sources */
+	struct list_head subordinates_head;
+
+	struct list_head list_element;
+
+	struct rw_semaphore rwsem;
+
+	struct dentry *source_dentry;
+};
+
+#if defined(CONFIG_STATS_FS)
+
+/**
+ * stats_fs_source_create - create a stats_fs_source
+ * Creates a stats_fs_source with the given name. This
+ * does not mean it will be backed by the filesystem yet, it will only
+ * be visible to the user once one of its parents (or itself) are
+ * registered in stats_fs.
+ *
+ * Returns a pointer to a stats_fs_source if it succeeds.
+ * This or one of the parents' pointer must be passed to the stats_fs_put()
+ * function when the file is to be removed.  If an error occurs,
+ * ERR_PTR(-ERROR) will be returned.
+ */
+struct stats_fs_source *stats_fs_source_create(const char *fmt, ...);
+
+/**
+ * stats_fs_source_add_values - adds values to the given source
+ * @source: a pointer to the source that will receive the values
+ * @val: a pointer to the NULL terminated stats_fs_value array to add
+ * @base_ptr: a pointer to the base pointer used by these values
+ *
+ * In addition to adding values to the source, also create the
+ * files in the filesystem if the source already is backed up by a directory.
+ *
+ * Returns 0 it succeeds. If the value are already in the
+ * source and have the same base_ptr, -EEXIST is returned.
+ */
+int stats_fs_source_add_values(struct stats_fs_source *source,
+			       struct stats_fs_value *val, void *base_ptr);
+
+/**
+ * stats_fs_source_add_subordinate - adds a child to the given source
+ * @parent: a pointer to the parent source
+ * @child: a pointer to child source to add
+ *
+ * Recursively create all files in the stats_fs filesystem
+ * only if the parent has already a dentry (created with
+ * stats_fs_source_register).
+ * This avoids the case where this function is called before register.
+ */
+void stats_fs_source_add_subordinate(struct stats_fs_source *parent,
+				     struct stats_fs_source *child);
+
+/**
+ * stats_fs_source_remove_subordinate - removes a child from the given source
+ * @parent: a pointer to the parent source
+ * @child: a pointer to child source to remove
+ *
+ * Look if there is such child in the parent. If so,
+ * it will remove all its files and call stats_fs_put on the child.
+ */
+void stats_fs_source_remove_subordinate(struct stats_fs_source *parent,
+					struct stats_fs_source *child);
+
+/**
+ * stats_fs_source_get_value - search a value in the source (and
+ * subordinates)
+ * @source: a pointer to the source that will be searched
+ * @val: a pointer to the stats_fs_value to search
+ * @ret: a pointer to the uint64_t that will hold the found value
+ *
+ * Look up in the source if a value with same value pointer
+ * exists.
+ * If not, it will return -ENOENT. If it exists and it's a simple value
+ * (not an aggregate), the value that it points to will be returned.
+ * If it exists and it's an aggregate (aggr_type != STATS_FS_NONE), all
+ * subordinates will be recursively searched and every simple value match
+ * will be used to aggregate the final result. For example if it's a sum,
+ * all suboordinates having the same value will be sum together.
+ *
+ * This function will return 0 it succeeds.
+ */
+int stats_fs_source_get_value(struct stats_fs_source *source,
+			      struct stats_fs_value *val, uint64_t *ret);
+
+/**
+ * stats_fs_source_get_value_by_name - search a value in the source (and
+ * subordinates)
+ * @source: a pointer to the source that will be searched
+ * @name: a pointer to the string representing the value to search
+ *        (for example "exits")
+ * @ret: a pointer to the uint64_t that will hold the found value
+ *
+ * Same as stats_fs_source_get_value, but initially the name is used
+ * to search in the given source if there is a value with a matching
+ * name. If so, stats_fs_source_get_value will be called with the found
+ * value, otherwise -ENOENT will be returned.
+ */
+int stats_fs_source_get_value_by_name(struct stats_fs_source *source,
+				      char *name, uint64_t *ret);
+
+/**
+ * stats_fs_source_clear - search and clears a value in the source (and
+ * subordinates)
+ * @source: a pointer to the source that will be searched
+ * @val: a pointer to the stats_fs_value to search
+ *
+ * Look up in the source if a value with same value pointer
+ * exists.
+ * If not, it will return -ENOENT. If it exists and it's a simple value
+ * (not an aggregate), the value that it points to will be set to 0.
+ * If it exists and it's an aggregate (aggr_type != STATS_FS_NONE), all
+ * subordinates will be recursively searched and every simple value match
+ * will be set to 0.
+ *
+ * This function will return 0 it succeeds.
+ */
+int stats_fs_source_clear(struct stats_fs_source *source,
+			  struct stats_fs_value *val);
+
+/**
+ * stats_fs_source_revoke - disconnect the source from its backing data
+ * @source: a pointer to the source that will be revoked
+ *
+ * Ensure that stats_fs will not access the data that were passed to
+ * stats_fs_source_add_value for this source.
+ *
+ * Because open files increase the reference count for a stats_fs_source,
+ * the source can end up living longer than the data that provides the
+ * values for the source.  Calling stats_fs_source_revoke just before the
+ * backing data is freed avoids accesses to freed data structures.  The
+ * sources will return 0.
+ */
+void stats_fs_source_revoke(struct stats_fs_source *source);
+
+/**
+ * stats_fs_source_get - increases refcount of source
+ * @source: a pointer to the source whose refcount will be increased
+ */
+void stats_fs_source_get(struct stats_fs_source *source);
+
+/**
+ * stats_fs_source_put - decreases refcount of source and deletes if needed
+ * @source: a pointer to the source whose refcount will be decreased
+ *
+ * If refcount arrives to zero, take care of deleting
+ * and free the source resources and files, by firstly recursively calling
+ * stats_fs_source_remove_subordinate to the child and then deleting
+ * its own files and allocations.
+ */
+void stats_fs_source_put(struct stats_fs_source *source);
+
+/**
+ * stats_fs_initialized - returns true if stats_fs fs has been registered
+ */
+bool stats_fs_initialized(void);
+
+#else
+
+#include <linux/err.h>
+
+/*
+ * We do not return NULL from these functions if CONFIG_STATS_FS is not enabled
+ * so users have a chance to detect if there was a real error or not.  We don't
+ * want to duplicate the design decision mistakes of procfs and devfs again.
+ */
+
+static inline struct stats_fs_source *stats_fs_source_create(const char *fmt,
+							     ...)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline int stats_fs_source_add_values(struct stats_fs_source *source,
+					     struct stats_fs_value *val,
+					     void *base_ptr)
+{
+	return -ENODEV;
+}
+
+static inline void
+stats_fs_source_add_subordinate(struct stats_fs_source *parent,
+				struct stats_fs_source *child)
+{ }
+
+static inline void
+stats_fs_source_remove_subordinate(struct stats_fs_source *parent,
+				   struct stats_fs_source *child)
+{ }
+
+static inline int stats_fs_source_get_value(struct stats_fs_source *source,
+					    struct stats_fs_value *val,
+					    uint64_t *ret)
+{
+	return -ENODEV;
+}
+
+static inline int
+stats_fs_source_get_value_by_name(struct stats_fs_source *source, char *name,
+				  uint64_t *ret)
+{
+	return -ENODEV;
+}
+
+static inline int stats_fs_source_clear(struct stats_fs_source *source,
+					struct stats_fs_value *val)
+{
+	return -ENODEV;
+}
+
+static inline void stats_fs_source_revoke(struct stats_fs_source *source)
+{ }
+
+static inline void stats_fs_source_get(struct stats_fs_source *source)
+{ }
+
+static inline void stats_fs_source_put(struct stats_fs_source *source)
+{ }
+
+static inline bool stats_fs_initialized(void)
+{ }
+
+#endif
+
+#endif
-- 
2.25.2

