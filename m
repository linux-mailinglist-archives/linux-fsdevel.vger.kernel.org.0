Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D601BA61E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 16:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgD0OSe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 10:18:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39663 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727006AbgD0OSd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587997110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ADbABVQ6NkgSW3Qm/9F481t42pICaqp8Lhwzs/N0pE=;
        b=Yp72G7n7I+xRAqmhKW/j8f1fFflg+WrMcTwTboHHCBfbBnyWabpJWo/ePHlk9B+cHX/s93
        o3JInwjb5M053xkY6Tv9CDS0qv8XMKI3/lfxK2VvRE8C0OtSrgj8mZrK0Qk/djjHrkoEhi
        h1x+FY9COoKjqjVh9I59GK7KZiEylao=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-OQEKuLh8OZeMDO-wTtOjcA-1; Mon, 27 Apr 2020 10:18:29 -0400
X-MC-Unique: OQEKuLh8OZeMDO-wTtOjcA-1
Received: by mail-wr1-f70.google.com with SMTP id f2so10598924wrm.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 07:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ADbABVQ6NkgSW3Qm/9F481t42pICaqp8Lhwzs/N0pE=;
        b=QOeQMl3WI5385bG/nhUyZKhBDxpvgcn7SvLwCsLkyct7Dxr2Z/AopAtiFQItuQcOqQ
         7RJx5JV8Y/A0tMR7ZUwdk83qzoPV96F0xzU+flimgGlxdjT1ghB5wz8LQStsgyR5Vsnz
         +/bnunlzpXwbZJor7pWA1J+9MSrRsyayyLnvOUnhp44ZmMcGLrOOn3KKnEuV0tnaBeZW
         KKue0jUT8YkkGWIFQMP78NEUrHi586R0i/3Z6kCMhcO0TrwQGv19Eycfc7Sk67sVrJmI
         +v7SH6l4wfIGH6sPF3y6sSEvy+KD/YZEWAITiJy9TtdlODEKCatJV7Asflk9p0cqxVd2
         VJqw==
X-Gm-Message-State: AGi0PuaTPlgIJYgMxNTwqvFIhgr+SRO+XNOzou5l91K8BTUP8leWf1QZ
        70nxVpB/BbAjvaWN4PybbkgkXcTdQYpd+1spvoggLOX3UOckT8wx86eGyjnEXIttFUCMV/puUkD
        O5taIQpzv21MxrMpwpZOCly5vVQ==
X-Received: by 2002:adf:f74f:: with SMTP id z15mr27283738wrp.297.1587997107561;
        Mon, 27 Apr 2020 07:18:27 -0700 (PDT)
X-Google-Smtp-Source: APiQypJhKjN8aWnMoWoEUewsk5SFCW6MKEAFKH7gfozQnbN2gR42OgHiKm5Ba0RD2oJo1BRMP/1wHw==
X-Received: by 2002:adf:f74f:: with SMTP id z15mr27283677wrp.297.1587997106922;
        Mon, 27 Apr 2020 07:18:26 -0700 (PDT)
Received: from localhost.localdomain.com ([194.230.155.207])
        by smtp.gmail.com with ESMTPSA id 1sm15914570wmz.13.2020.04.27.07.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 07:18:26 -0700 (PDT)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, mst@redhat.com,
        borntraeger@de.ibm.com, Paolo Bonzini <pbonzini@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [RFC PATCH 2/5] statsfs API: create, add and remove statsfs sources and values
Date:   Mon, 27 Apr 2020 16:18:13 +0200
Message-Id: <20200427141816.16703-3-eesposit@redhat.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200427141816.16703-1-eesposit@redhat.com>
References: <20200427141816.16703-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduction to the statsfs API, that allows to easily create, add
and remove statsfs sources and values. The API allows to easily building
the statistics directory tree to automatically gather them for the linux
kernel. The main functionalities are: create a source, add child
sources/values/aggregates, register it to the root source (that on
the virtual fs would be /sys/kernel/statsfs), ad perform a search for
a value/aggregate.

This allows creating any kind of source tree, making it more flexible
also to future readjustments.

The API representation is only logical and will be backed up
by a virtual file system in patch 4.
Its usage will be shared between the statsfs file system
and the end-users like kvm, the former calling it when it needs to
display and clear statistics, the latter to add values and sources.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 fs/Kconfig              |   7 +
 fs/Makefile             |   1 +
 fs/statsfs/Makefile     |   4 +
 fs/statsfs/internal.h   |  20 ++
 fs/statsfs/statsfs.c    | 618 ++++++++++++++++++++++++++++++++++++++++
 include/linux/statsfs.h | 222 +++++++++++++++
 6 files changed, 872 insertions(+)
 create mode 100644 fs/statsfs/Makefile
 create mode 100644 fs/statsfs/internal.h
 create mode 100644 fs/statsfs/statsfs.c
 create mode 100644 include/linux/statsfs.h

diff --git a/fs/Kconfig b/fs/Kconfig
index f08fbbfafd9a..824fcf86d12b 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -328,4 +328,11 @@ source "fs/unicode/Kconfig"
 config IO_WQ
 	bool
 
+config STATS_FS
+	bool "Statistics Filesystem"
+	default y
+	help
+	  statsfs is a virtual file system that provides counters and other
+	  statistics about the running kernel.
+
 endmenu
diff --git a/fs/Makefile b/fs/Makefile
index 2ce5112b02c8..6942070f54b2 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -125,6 +125,7 @@ obj-$(CONFIG_BEFS_FS)		+= befs/
 obj-$(CONFIG_HOSTFS)		+= hostfs/
 obj-$(CONFIG_CACHEFILES)	+= cachefiles/
 obj-$(CONFIG_DEBUG_FS)		+= debugfs/
+obj-$(CONFIG_STATS_FS)		+= statsfs/
 obj-$(CONFIG_TRACING)		+= tracefs/
 obj-$(CONFIG_OCFS2_FS)		+= ocfs2/
 obj-$(CONFIG_BTRFS_FS)		+= btrfs/
diff --git a/fs/statsfs/Makefile b/fs/statsfs/Makefile
new file mode 100644
index 000000000000..d494a3f30ba5
--- /dev/null
+++ b/fs/statsfs/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+statsfs-objs	:= statsfs.o
+
+obj-$(CONFIG_STATS_FS)	+= statsfs.o
diff --git a/fs/statsfs/internal.h b/fs/statsfs/internal.h
new file mode 100644
index 000000000000..f124683a2ded
--- /dev/null
+++ b/fs/statsfs/internal.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _STATSFS_INTERNAL_H_
+#define _STATSFS_INTERNAL_H_
+
+#include <linux/list.h>
+#include <linux/kref.h>
+#include <linux/rwsem.h>
+#include <linux/statsfs.h>
+
+/* values, grouped by base */
+struct statsfs_value_source {
+	void *base_addr;
+	bool files_created;
+	struct statsfs_value *values;
+	struct list_head list_element;
+};
+
+int statsfs_val_get_mode(struct statsfs_value *val);
+
+#endif /* _STATSFS_INTERNAL_H_ */
diff --git a/fs/statsfs/statsfs.c b/fs/statsfs/statsfs.c
new file mode 100644
index 000000000000..0ad1d985be46
--- /dev/null
+++ b/fs/statsfs/statsfs.c
@@ -0,0 +1,618 @@
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
+#include <linux/statsfs.h>
+
+#include "internal.h"
+
+struct statsfs_aggregate_value {
+	uint64_t sum, min, max;
+	uint32_t count, count_zero;
+};
+
+static int is_val_signed(struct statsfs_value *val)
+{
+	return val->type & STATSFS_SIGN;
+}
+
+int statsfs_val_get_mode(struct statsfs_value *val)
+{
+	return val->mode ? val->mode : 0644;
+}
+
+static struct statsfs_value *find_value(struct statsfs_value_source *src,
+					struct statsfs_value *val)
+{
+	struct statsfs_value *entry;
+
+	for (entry = src->values; entry->name; entry++) {
+		if (entry == val) {
+			WARN_ON(strcmp(entry->name, val->name) != 0);
+			return entry;
+		}
+	}
+	return NULL;
+}
+
+static struct statsfs_value *
+search_value_in_source(struct statsfs_source *src, struct statsfs_value *arg,
+		       struct statsfs_value_source **val_src)
+{
+	struct statsfs_value *entry;
+	struct statsfs_value_source *src_entry;
+
+	list_for_each_entry(src_entry, &src->values_head, list_element) {
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
+static struct statsfs_value_source *create_value_source(void *base)
+{
+	struct statsfs_value_source *val_src;
+
+	val_src = kzalloc(sizeof(struct statsfs_value_source), GFP_KERNEL);
+	if (!val_src)
+		return ERR_PTR(-ENOMEM);
+
+	val_src->base_addr = base;
+	val_src->list_element =
+		(struct list_head)LIST_HEAD_INIT(val_src->list_element);
+
+	return val_src;
+}
+
+int statsfs_source_add_values(struct statsfs_source *source,
+			      struct statsfs_value *stat, void *ptr)
+{
+	struct statsfs_value_source *val_src;
+	struct statsfs_value_source *entry;
+
+	down_write(&source->rwsem);
+
+	list_for_each_entry(entry, &source->values_head, list_element) {
+		if (entry->base_addr == ptr && entry->values == stat) {
+			up_write(&source->rwsem);
+			return -EEXIST;
+		}
+	}
+
+	val_src = create_value_source(ptr);
+	val_src->values = (struct statsfs_value *)stat;
+
+	/* add the val_src to the source list */
+	list_add(&val_src->list_element, &source->values_head);
+
+	up_write(&source->rwsem);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(statsfs_source_add_values);
+
+void statsfs_source_add_subordinate(struct statsfs_source *source,
+				    struct statsfs_source *sub)
+{
+	down_write(&source->rwsem);
+
+	statsfs_source_get(sub);
+	list_add(&sub->list_element, &source->subordinates_head);
+
+	up_write(&source->rwsem);
+}
+EXPORT_SYMBOL_GPL(statsfs_source_add_subordinate);
+
+/* Called with rwsem held for writing */
+static void
+statsfs_source_remove_subordinate_locked(struct statsfs_source *source,
+					 struct statsfs_source *sub)
+{
+	struct list_head *it, *safe;
+	struct statsfs_source *src_entry;
+
+	list_for_each_safe(it, safe, &source->subordinates_head) {
+		src_entry = list_entry(it, struct statsfs_source, list_element);
+		if (src_entry == sub) {
+			WARN_ON(strcmp(src_entry->name, sub->name) != 0);
+			list_del_init(&src_entry->list_element);
+			statsfs_source_put(src_entry);
+			return;
+		}
+	}
+}
+
+void statsfs_source_remove_subordinate(struct statsfs_source *source,
+				       struct statsfs_source *sub)
+{
+	down_write(&source->rwsem);
+	statsfs_source_remove_subordinate_locked(source, sub);
+	up_write(&source->rwsem);
+}
+EXPORT_SYMBOL_GPL(statsfs_source_remove_subordinate);
+
+/* Called with rwsem held for reading */
+static uint64_t get_simple_value(struct statsfs_value_source *src,
+				 struct statsfs_value *val)
+{
+	uint64_t value_found;
+	void *address;
+
+	address = src->base_addr + val->offset;
+
+	switch (val->type) {
+	case STATSFS_U8:
+		value_found = *((uint8_t *)address);
+		break;
+	case STATSFS_U8 | STATSFS_SIGN:
+		value_found = *((int8_t *)address);
+		break;
+	case STATSFS_U16:
+		value_found = *((uint16_t *)address);
+		break;
+	case STATSFS_U16 | STATSFS_SIGN:
+		value_found = *((int16_t *)address);
+		break;
+	case STATSFS_U32:
+		value_found = *((uint32_t *)address);
+		break;
+	case STATSFS_U32 | STATSFS_SIGN:
+		value_found = *((int32_t *)address);
+		break;
+	case STATSFS_U64:
+		value_found = *((uint64_t *)address);
+		break;
+	case STATSFS_U64 | STATSFS_SIGN:
+		value_found = *((int64_t *)address);
+		break;
+	case STATSFS_BOOL:
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
+static void clear_simple_value(struct statsfs_value_source *src,
+			       struct statsfs_value *val)
+{
+	void *address;
+
+	address = src->base_addr + val->offset;
+
+	switch (val->type) {
+	case STATSFS_U8:
+		*((uint8_t *)address) = 0;
+		break;
+	case STATSFS_U8 | STATSFS_SIGN:
+		*((int8_t *)address) = 0;
+		break;
+	case STATSFS_U16:
+		*((uint16_t *)address) = 0;
+		break;
+	case STATSFS_U16 | STATSFS_SIGN:
+		*((int16_t *)address) = 0;
+		break;
+	case STATSFS_U32:
+		*((uint32_t *)address) = 0;
+		break;
+	case STATSFS_U32 | STATSFS_SIGN:
+		*((int32_t *)address) = 0;
+		break;
+	case STATSFS_U64:
+		*((uint64_t *)address) = 0;
+		break;
+	case STATSFS_U64 | STATSFS_SIGN:
+		*((int64_t *)address) = 0;
+		break;
+	case STATSFS_BOOL:
+		*((uint8_t *)address) = 0;
+		break;
+	default:
+		break;
+	}
+}
+
+/* Called with rwsem held for reading */
+static void search_all_simple_values(struct statsfs_source *src,
+				     struct statsfs_value_source *ref_src_entry,
+				     struct statsfs_value *val,
+				     struct statsfs_aggregate_value *agg)
+{
+	struct statsfs_value_source *src_entry;
+	uint64_t value_found;
+
+	list_for_each_entry(src_entry, &src->values_head, list_element) {
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
+static void do_recursive_aggregation(struct statsfs_source *root,
+				     struct statsfs_value_source *ref_src_entry,
+				     struct statsfs_value *val,
+				     struct statsfs_aggregate_value *agg)
+{
+	struct statsfs_source *subordinate;
+
+	/* search all simple values in this folder */
+	search_all_simple_values(root, ref_src_entry, val, agg);
+
+	/* recursively search in all subfolders */
+	list_for_each_entry(subordinate, &root->subordinates_head,
+			     list_element) {
+		down_read(&subordinate->rwsem);
+		do_recursive_aggregation(subordinate, ref_src_entry, val, agg);
+		up_read(&subordinate->rwsem);
+	}
+}
+
+/* Called with rwsem held for reading */
+static void init_aggregate_value(struct statsfs_aggregate_value *agg,
+				 struct statsfs_value *val)
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
+static void store_final_value(struct statsfs_aggregate_value *agg,
+			    struct statsfs_value *val, uint64_t *ret)
+{
+	int operation;
+
+	operation = val->aggr_kind | is_val_signed(val);
+
+	switch (operation) {
+	case STATSFS_AVG:
+		*ret = agg->count ? agg->sum / agg->count : 0;
+		break;
+	case STATSFS_AVG | STATSFS_SIGN:
+		*ret = agg->count ? ((int64_t)agg->sum) / agg->count : 0;
+		break;
+	case STATSFS_SUM:
+	case STATSFS_SUM | STATSFS_SIGN:
+		*ret = agg->sum;
+		break;
+	case STATSFS_MIN:
+	case STATSFS_MIN | STATSFS_SIGN:
+		*ret = agg->min;
+		break;
+	case STATSFS_MAX:
+	case STATSFS_MAX | STATSFS_SIGN:
+		*ret = agg->max;
+		break;
+	case STATSFS_COUNT_ZERO:
+	case STATSFS_COUNT_ZERO | STATSFS_SIGN:
+		*ret = agg->count_zero;
+		break;
+	default:
+		break;
+	}
+}
+
+/* Called with rwsem held for reading */
+static int statsfs_source_get_value_locked(struct statsfs_source *source,
+					   struct statsfs_value *arg,
+					   uint64_t *ret)
+{
+	struct statsfs_value_source *src_entry;
+	struct statsfs_value *found;
+	struct statsfs_aggregate_value aggr;
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
+		printk(KERN_ERR "Statsfs: Value in source \"%s\" not found!\n",
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
+int statsfs_source_get_value(struct statsfs_source *source,
+			     struct statsfs_value *arg, uint64_t *ret)
+{
+	int retval;
+
+	down_read(&source->rwsem);
+	retval = statsfs_source_get_value_locked(source, arg, ret);
+	up_read(&source->rwsem);
+
+	return retval;
+}
+EXPORT_SYMBOL_GPL(statsfs_source_get_value);
+
+/* Called with rwsem held for reading */
+static void set_all_simple_values(struct statsfs_source *src,
+				  struct statsfs_value_source *ref_src_entry,
+				  struct statsfs_value *val)
+{
+	struct statsfs_value_source *src_entry;
+
+	list_for_each_entry(src_entry, &src->values_head, list_element) {
+		/* skip aggregates */
+		if (src_entry->base_addr == NULL)
+			continue;
+
+		/* wrong to search here */
+		if (src_entry->values != ref_src_entry->values)
+			continue;
+
+		if (src_entry->base_addr &&
+			src_entry->values == ref_src_entry->values)
+			clear_simple_value(src_entry, val);
+	}
+}
+
+/* Called with rwsem held for reading */
+static void do_recursive_clean(struct statsfs_source *root,
+			       struct statsfs_value_source *ref_src_entry,
+			       struct statsfs_value *val)
+{
+	struct statsfs_source *subordinate;
+
+	/* search all simple values in this folder */
+	set_all_simple_values(root, ref_src_entry, val);
+
+	/* recursively search in all subfolders */
+	list_for_each_entry(subordinate, &root->subordinates_head,
+			     list_element) {
+		down_read(&subordinate->rwsem);
+		do_recursive_clean(subordinate, ref_src_entry, val);
+		up_read(&subordinate->rwsem);
+	}
+}
+
+/* Called with rwsem held for reading */
+static int statsfs_source_clear_locked(struct statsfs_source *source,
+				       struct statsfs_value *val)
+{
+	struct statsfs_value_source *src_entry;
+	struct statsfs_value *found;
+
+	if (!val)
+		return -ENOENT;
+
+	/* look in simple values */
+	found = search_value_in_source(source, val, &src_entry);
+
+	if (!found) {
+		printk(KERN_ERR "Statsfs: Value in source \"%s\" not found!\n",
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
+int statsfs_source_clear(struct statsfs_source *source,
+			 struct statsfs_value *val)
+{
+	int retval;
+
+	down_read(&source->rwsem);
+	retval = statsfs_source_clear_locked(source, val);
+	up_read(&source->rwsem);
+
+	return retval;
+}
+
+/* Called with rwsem held for reading */
+static struct statsfs_value *
+find_value_by_name(struct statsfs_value_source *src, char *val)
+{
+	struct statsfs_value *entry;
+
+	for (entry = src->values; entry->name; entry++)
+		if (!strcmp(entry->name, val))
+			return entry;
+
+	return NULL;
+}
+
+/* Called with rwsem held for reading */
+static struct statsfs_value *
+search_in_source_by_name(struct statsfs_source *src, char *name)
+{
+	struct statsfs_value *entry;
+	struct statsfs_value_source *src_entry;
+
+	list_for_each_entry(src_entry, &src->values_head, list_element) {
+		entry = find_value_by_name(src_entry, name);
+		if (entry)
+			return entry;
+	}
+
+	return NULL;
+}
+
+int statsfs_source_get_value_by_name(struct statsfs_source *source, char *name,
+				     uint64_t *ret)
+{
+	struct statsfs_value *val;
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
+	retval = statsfs_source_get_value_locked(source, val, ret);
+	up_read(&source->rwsem);
+
+	return retval;
+}
+EXPORT_SYMBOL_GPL(statsfs_source_get_value_by_name);
+
+void statsfs_source_get(struct statsfs_source *source)
+{
+	kref_get(&source->refcount);
+}
+EXPORT_SYMBOL_GPL(statsfs_source_get);
+
+void statsfs_source_revoke(struct statsfs_source *source)
+{
+	struct list_head *it, *safe;
+	struct statsfs_value_source *val_src_entry;
+
+	down_write(&source->rwsem);
+
+	list_for_each_safe(it, safe, &source->values_head) {
+		val_src_entry = list_entry(it, struct statsfs_value_source,
+					   list_element);
+		val_src_entry->base_addr = NULL;
+	}
+
+	up_write(&source->rwsem);
+}
+EXPORT_SYMBOL_GPL(statsfs_source_revoke);
+
+/* Called with rwsem held for writing
+ *
+ * The refcount is 0 and the lock was taken before refcount
+ * went from 1 to 0
+ */
+static void statsfs_source_destroy(struct kref *kref_source)
+{
+	struct statsfs_value_source *val_src_entry;
+	struct list_head *it, *safe;
+	struct statsfs_source *child, *source;
+
+	source = container_of(kref_source, struct statsfs_source, refcount);
+
+	/* iterate through the values and delete them */
+	list_for_each_safe(it, safe, &source->values_head) {
+		val_src_entry = list_entry(it, struct statsfs_value_source,
+					   list_element);
+		kfree(val_src_entry);
+	}
+
+	/* iterate through the subordinates and delete them */
+	list_for_each_safe(it, safe, &source->subordinates_head) {
+		child = list_entry(it, struct statsfs_source, list_element);
+		statsfs_source_remove_subordinate_locked(source, child);
+	}
+
+
+	up_write(&source->rwsem);
+	kfree(source->name);
+	kfree(source);
+}
+
+void statsfs_source_put(struct statsfs_source *source)
+{
+	kref_put_rwsem(&source->refcount, statsfs_source_destroy,
+		       &source->rwsem);
+}
+EXPORT_SYMBOL_GPL(statsfs_source_put);
+
+struct statsfs_source *statsfs_source_create(const char *fmt, ...)
+{
+	va_list ap;
+	char buf[100];
+	struct statsfs_source *ret;
+	int char_needed;
+
+	va_start(ap, fmt);
+	char_needed = vsnprintf(buf, 100, fmt, ap);
+	va_end(ap);
+
+	ret = kzalloc(sizeof(struct statsfs_source), GFP_KERNEL);
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
+EXPORT_SYMBOL_GPL(statsfs_source_create);
diff --git a/include/linux/statsfs.h b/include/linux/statsfs.h
new file mode 100644
index 000000000000..3f01f094946d
--- /dev/null
+++ b/include/linux/statsfs.h
@@ -0,0 +1,222 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ *  statsfs.h - a tiny little statistics file system
+ *
+ *  Copyright (C) 2020 Emanuele Giuseppe Esposito
+ *  Copyright (C) 2020 Redhat.
+ *
+ */
+
+#ifndef _STATSFS_H_
+#define _STATSFS_H_
+
+#include <linux/list.h>
+
+/* Used to distinguish signed types */
+#define STATSFS_SIGN 0x8000
+
+struct statsfs_source;
+
+enum stat_type {
+	STATSFS_U8 = 0,
+	STATSFS_U16 = 1,
+	STATSFS_U32 = 2,
+	STATSFS_U64 = 3,
+	STATSFS_BOOL = 4,
+	STATSFS_S8 = STATSFS_U8 | STATSFS_SIGN,
+	STATSFS_S16 = STATSFS_U16 | STATSFS_SIGN,
+	STATSFS_S32 = STATSFS_U32 | STATSFS_SIGN,
+	STATSFS_S64 = STATSFS_U64 | STATSFS_SIGN,
+};
+
+enum stat_aggr {
+	STATSFS_NONE = 0,
+	STATSFS_SUM,
+	STATSFS_MIN,
+	STATSFS_MAX,
+	STATSFS_COUNT_ZERO,
+	STATSFS_AVG,
+};
+
+struct statsfs_value {
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
+struct statsfs_source {
+	struct kref refcount;
+
+	char *name;
+
+	/* list of source statsfs_value_source*/
+	struct list_head values_head;
+
+	/* list of struct statsfs_source for subordinate sources */
+	struct list_head subordinates_head;
+
+	struct list_head list_element;
+
+	struct rw_semaphore rwsem;
+
+	struct dentry *source_dentry;
+};
+
+/**
+ * statsfs_source_create - create a statsfs_source
+ * Creates a statsfs_source with the given name. This
+ * does not mean it will be backed by the filesystem yet, it will only
+ * be visible to the user once one of its parents (or itself) are
+ * registered in statsfs.
+ *
+ * Returns a pointer to a statsfs_source if it succeeds.
+ * This or one of the parents' pointer must be passed to the statsfs_put()
+ * function when the file is to be removed.  If an error occurs,
+ * ERR_PTR(-ERROR) will be returned.
+ */
+struct statsfs_source *statsfs_source_create(const char *fmt, ...);
+
+/**
+ * statsfs_source_add_values - adds values to the given source
+ * @source: a pointer to the source that will receive the values
+ * @val: a pointer to the NULL terminated statsfs_value array to add
+ * @base_ptr: a pointer to the base pointer used by these values
+ *
+ * In addition to adding values to the source, also create the
+ * files in the filesystem if the source already is backed up by a directory.
+ *
+ * Returns 0 it succeeds. If the value are already in the
+ * source and have the same base_ptr, -EEXIST is returned.
+ */
+int statsfs_source_add_values(struct statsfs_source *source,
+			      struct statsfs_value *val, void *base_ptr);
+
+/**
+ * statsfs_source_add_subordinate - adds a child to the given source
+ * @parent: a pointer to the parent source
+ * @child: a pointer to child source to add
+ *
+ * Recursively create all files in the statsfs filesystem
+ * only if the parent has already a dentry (created with
+ * statsfs_source_register).
+ * This avoids the case where this function is called before register.
+ */
+void statsfs_source_add_subordinate(struct statsfs_source *parent,
+				    struct statsfs_source *child);
+
+/**
+ * statsfs_source_remove_subordinate - removes a child from the given source
+ * @parent: a pointer to the parent source
+ * @child: a pointer to child source to remove
+ *
+ * Look if there is such child in the parent. If so,
+ * it will remove all its files and call statsfs_put on the child.
+ */
+void statsfs_source_remove_subordinate(struct statsfs_source *parent,
+				       struct statsfs_source *child);
+
+/**
+ * statsfs_source_get_value - search a value in the source (and
+ * subordinates)
+ * @source: a pointer to the source that will be searched
+ * @val: a pointer to the statsfs_value to search
+ * @ret: a pointer to the uint64_t that will hold the found value
+ *
+ * Look up in the source if a value with same value pointer
+ * exists.
+ * If not, it will return -ENOENT. If it exists and it's a simple value
+ * (not an aggregate), the value that it points to will be returned.
+ * If it exists and it's an aggregate (aggr_type != STATSFS_NONE), all
+ * subordinates will be recursively searched and every simple value match
+ * will be used to aggregate the final result. For example if it's a sum,
+ * all suboordinates having the same value will be sum together.
+ *
+ * This function will return 0 it succeeds.
+ */
+int statsfs_source_get_value(struct statsfs_source *source,
+			     struct statsfs_value *val, uint64_t *ret);
+
+/**
+ * statsfs_source_get_value_by_name - search a value in the source (and
+ * subordinates)
+ * @source: a pointer to the source that will be searched
+ * @name: a pointer to the string representing the value to search
+ *        (for example "exits")
+ * @ret: a pointer to the uint64_t that will hold the found value
+ *
+ * Same as statsfs_source_get_value, but initially the name is used
+ * to search in the given source if there is a value with a matching
+ * name. If so, statsfs_source_get_value will be called with the found
+ * value, otherwise -ENOENT will be returned.
+ */
+int statsfs_source_get_value_by_name(struct statsfs_source *source, char *name,
+				     uint64_t *ret);
+
+/**
+ * statsfs_source_clear - search and clears a value in the source (and
+ * subordinates)
+ * @source: a pointer to the source that will be searched
+ * @val: a pointer to the statsfs_value to search
+ *
+ * Look up in the source if a value with same value pointer
+ * exists.
+ * If not, it will return -ENOENT. If it exists and it's a simple value
+ * (not an aggregate), the value that it points to will be set to 0.
+ * If it exists and it's an aggregate (aggr_type != STATSFS_NONE), all
+ * subordinates will be recursively searched and every simple value match
+ * will be set to 0.
+ *
+ * This function will return 0 it succeeds.
+ */
+int statsfs_source_clear(struct statsfs_source *source,
+			 struct statsfs_value *val);
+
+/**
+ * statsfs_source_revoke - disconnect the source from its backing data
+ * @source: a pointer to the source that will be revoked
+ *
+ * Ensure that statsfs will not access the data that were passed to
+ * statsfs_source_add_value for this source.
+ *
+ * Because open files increase the reference count for a statsfs_source,
+ * the source can end up living longer than the data that provides the
+ * values for the source.  Calling statsfs_source_revoke just before the
+ * backing data is freed avoids accesses to freed data structures.  The
+ * sources will return 0.
+ */
+void statsfs_source_revoke(struct statsfs_source *source);
+
+/**
+ * statsfs_source_get - increases refcount of source
+ * @source: a pointer to the source whose refcount will be increased
+ */
+void statsfs_source_get(struct statsfs_source *source);
+
+/**
+ * statsfs_source_put - decreases refcount of source and deletes if needed
+ * @source: a pointer to the source whose refcount will be decreased
+ *
+ * If refcount arrives to zero, take care of deleting
+ * and free the source resources and files, by firstly recursively calling
+ * statsfs_source_remove_subordinate to the child and then deleting
+ * its own files and allocations.
+ */
+void statsfs_source_put(struct statsfs_source *source);
+
+/**
+ * statsfs_initialized - returns true if statsfs fs has been registered
+ */
+bool statsfs_initialized(void);
+
+#endif
-- 
2.25.2

