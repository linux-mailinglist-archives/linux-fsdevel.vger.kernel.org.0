Return-Path: <linux-fsdevel+bounces-40005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B62A1AB55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 21:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAAFD3AF0D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 20:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891971F9A89;
	Thu, 23 Jan 2025 20:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="ioFMBtO+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566DD1F8F0B
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 20:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663945; cv=none; b=barzX8gFX8UGHURNiZyMImBLa1x/C8yF9YxCYQ2I51avqrT7xcwoO+bDeIRNrPhyurj9edFB9OQAXzo78QZVVdLnTUoB5Bg9ku1+4nPw0eWXvdN4yIP9aQM+15L5gIUW6I3GLQz+MRTa100fZnJNE/dtno2uSBF/tRPNnhXbi5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663945; c=relaxed/simple;
	bh=p1dCFFJ9fVEojUUVrrtO+Hu0An4dKFcNmsDIB0IlhUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YRPABAGD9zzsHYpkpmOrvtHZPtKlDKEFFoEVosotzQsTQgiQjBK6iDT8wnpNvRHLt6V5TdErjwEOIOuTXRWtYIgJKCxTw+Bi9CwasRP+Z14S2HxeesFjsL+n28q2AMUtsXmmF0ldJ0cogWftUNCkh4o3JN5W9b4MxSdOZIziH9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=ioFMBtO+; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3eb9101419cso832004b6e.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 12:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1737663941; x=1738268741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Doo6OpKUKSeJFdcqNGn9ZvydOTnZMVGPBEGCdkAtdjQ=;
        b=ioFMBtO+Yw9PTrvuNk51JpfreQRHNH+uzVDmhuuh3a/0vWF71h5if+UdVGtfierGDJ
         vSKNxR27kP8Cmb+bG0Jr94Xtu+QZm4GWhjbr2ootNgU2TxG3K3iGQlua0mMCDjxInglF
         BRYtoQnbKz8/9RBoQTHJLq0doLBH55ZKIrFcl7zb2lzytEyb1HyqH2/E2qwHVWrTLSMU
         a2XmhJuJVU3JZpSy+pX+D+wWQltsQRVMsGqZqXiIgL+eDmR42idJGhY8cuTKF9CVB49w
         Cme/WGrKEGHOa28Mo7yX5rIoL7WUQZTV49UhS7tTWm1RXjsg1gFngSK1JOzy6+cTppZF
         tUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737663941; x=1738268741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Doo6OpKUKSeJFdcqNGn9ZvydOTnZMVGPBEGCdkAtdjQ=;
        b=hdYTyn1CeRgUDi7CjQfz/0Ua23lWa+eqtTrFQxT0NCj2kfk/k78SN/hNJZYXPsj/C/
         qbh/D8vkx+9TIytZ+L8Q9XFyXQL0gczGdwZTYaD5BqiN5+U4l5ABYWBY1J9vIU2maUJD
         9/wxYcGruX4F/EHNdNa/UKEKM6n8Ob7k3eUbOmbZmi2nPZdITFPokUgqizde2bqzBOMC
         bZUt7t4b+DjS+jRhuHwffpFmL4nNzWDtbsudt+hz6Kay8cDsRhWzUkcItvlURnGG7RdL
         EfE19FgqqgvphE36P5xUNrKTeJA/xqlCCRLhk1CRZtWqMYPkzyMEUXbpptA2eUz788ef
         2BWA==
X-Gm-Message-State: AOJu0Yw2t9if+GMMKDoXKaJaIY5sSzIigc9NH8pk8e/a3u+LoNPPB0fV
	OnzR/1B/DXkku/JV/fEU+b1ysV5+2XjLjb6rwSIYrW9cLA/cL9hyNM9JCrMCW6xAEylf4xuKbdw
	uQSY7zA==
X-Gm-Gg: ASbGncuS8aysX5cdteHdhKLV+F+feftDjl+f76RMH5oo5nJD0O8ZzCeKHxRB1Cp56cg
	6jpryGQLQXEp8Xou30v+KICopmTUWsGEcyddp8Z0hkfHhKwTtmcQS8dlhmHaJ96PuEgXB3SA8Yf
	kCUeF0/KYBJQS1GIRCVA3s+q7Pl9NWMgb8bkHTAMKwKIriE/doYowkACR+uM/JaaUw7Db3TUHPy
	etoBeufcrPdb1Fif2C8+kfbCXECh+hov8ZhgTPuyfO/GGHzgvWlL64aQfwQB+rP3LZ4L7ZESrnV
	afAnFRtpbzeMMW57S78=
X-Google-Smtp-Source: AGHT+IHOjPIRebFFC7+1EL6dzjviI8d8fvr3PDtB1yuZkcEmjhVfWt4akGRmKow35r+X+I2ee+ZkMg==
X-Received: by 2002:a05:6808:2286:b0:3eb:695f:5382 with SMTP id 5614622812f47-3f19fc1a025mr19102254b6e.13.1737663940554;
        Thu, 23 Jan 2025 12:25:40 -0800 (PST)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:3505:6c:7825:7b9])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f1f09810f7sm53856b6e.37.2025.01.23.12.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 12:25:39 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: linux-mm@kvack.org,
	javier.gonz@samsung.com,
	Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH] Introduce generalized data temperature estimation framework
Date: Thu, 23 Jan 2025 12:24:55 -0800
Message-ID: <20250123202455.11338-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[PROBLEM DECLARATION]
Efficient data placement policy is a Holy Grail for data
storage and file system engineers. Achieving this goal is
equally important and really hard. Multiple data storage
and file system technologies have been invented to manage
the data placement policy (for example, COW, ZNS, FDP, etc).
But these technologies still require the hints related to
nature of data from application side.

[DATA "TEMPERATURE" CONCEPT]
One of the widely used and intuitively clear idea of data
nature definition is data "temperature" (cold, warm,
hot data). However, data "temperature" is as intuitively
sound as illusive definition of data nature. Generally
speaking, thermodynamics defines temperature as a way
to estimate the average kinetic energy of vibrating
atoms in a substance. But we cannot see a direct analogy
between data "temperature" and temperature in physics
because data is not something that has kinetic energy.

[WHAT IS GENERALIZED DATA "TEMPERATURE" ESTIMATION]
We usually imply that if some data is updated more
frequently, then such data is more hot than other one.
But, it is possible to see several problems here:
(1) How can we estimate the data "hotness" in
quantitative way? (2) We can state that data is "hot"
after some number of updates. It means that this
definition implies state of the data in the past.
Will this data continue to be "hot" in the future?
Generally speaking, the crucial problem is how to define
the data nature or data "temperature" in the future.
Because, this knowledge is the fundamental basis for
elaboration an efficient data placement policy.
Generalized data "temperature" estimation framework
suggests the way to define a future state of the data
and the basis for quantitative measurement of data
"temperature".

[ARCHITECTURE OF FRAMEWORK]
Usually, file system has a page cache for every inode. And
initially memory pages become dirty in page cache. Finally,
dirty pages will be sent to storage device. Technically
speaking, the number of dirty pages in a particular page
cache is the quantitative measurement of current "hotness"
of a file. But number of dirty pages is still not stable
basis for quantitative measurement of data "temperature".
It is possible to suggest of using the total number of
logical blocks in a file as a unit of one degree of data
"temperature". As a result, if the whole file was updated
several times, then "temperature" of the file has been
increased for several degrees. And if the file is under
continous updates, then the file "temperature" is growing.

We need to keep not only current number of dirty pages,
but also the number of updated pages in the near past
for accumulating the total "temperature" of a file.
Generally speaking, total number of updated pages in the
nearest past defines the aggregated "temperature" of file.
And number of dirty pages defines the delta of
"temperature" growth for current update operation.
This approach defines the mechanism of "temperature" growth.

But if we have no more updates for the file, then
"temperature" needs to decrease. Starting and ending
timestamps of update operation can work as a basis for
decreasing "temperature" of a file. If we know the number
of updated logical blocks of the file, then we can divide
the duration of update operation on number of updated
logical blocks. As a result, this is the way to define
a time duration per one logical block. By means of
multiplying this value (time duration per one logical
block) on total number of logical blocks in file, we
can calculate the time duration of "temperature"
decreasing for one degree. Finally, the operation of
division the time range (between end of last update
operation and begin of new update operation) on
the time duration of "temperature" decreasing for
one degree provides the way to define how many
degrees should be subtracted from current "temperature"
of the file.

[HOW TO USE THE APPROACH]
The lifetime of data "temperature" value for a file
can be explained by steps: (1) iget() method sets
the data "temperature" object; (2) folio_account_dirtied()
method accounts the number of dirty memory pages and
tries to estimate the current temperature of the file;
(3) folio_clear_dirty_for_io() decrease number of dirty
memory pages and increases number of updated pages;
(4) folio_account_dirtied() also decreases file's
"temperature" if updates hasn't happened some time;
(5) file system can get file's temperature and
to share the hint with block layer; (6) inode
eviction method removes and free the data "temperature"
object.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/Kconfig                             |   2 +
 fs/Makefile                            |   1 +
 fs/data-temperature/Kconfig            |  11 +
 fs/data-temperature/Makefile           |   3 +
 fs/data-temperature/data_temperature.c | 347 +++++++++++++++++++++++++
 include/linux/data_temperature.h       | 124 +++++++++
 include/linux/fs.h                     |   4 +
 mm/page-writeback.c                    |   9 +
 8 files changed, 501 insertions(+)
 create mode 100644 fs/data-temperature/Kconfig
 create mode 100644 fs/data-temperature/Makefile
 create mode 100644 fs/data-temperature/data_temperature.c
 create mode 100644 include/linux/data_temperature.h

diff --git a/fs/Kconfig b/fs/Kconfig
index 64d420e3c475..ae117c2e3ce2 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -139,6 +139,8 @@ source "fs/autofs/Kconfig"
 source "fs/fuse/Kconfig"
 source "fs/overlayfs/Kconfig"
 
+source "fs/data-temperature/Kconfig"
+
 menu "Caches"
 
 source "fs/netfs/Kconfig"
diff --git a/fs/Makefile b/fs/Makefile
index 15df0a923d3a..c7e6ccac633d 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -129,3 +129,4 @@ obj-$(CONFIG_EROFS_FS)		+= erofs/
 obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
 obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
 obj-$(CONFIG_BPF_LSM)		+= bpf_fs_kfuncs.o
+obj-$(CONFIG_DATA_TEMPERATURE)	+= data-temperature/
diff --git a/fs/data-temperature/Kconfig b/fs/data-temperature/Kconfig
new file mode 100644
index 000000000000..1cade2741982
--- /dev/null
+++ b/fs/data-temperature/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config DATA_TEMPERATURE
+	bool "Data temperature approach for efficient data placement"
+	help
+	  Enable data "temperature" estimation for efficient data
+	  placement policy. This approach is file based and
+	  it estimates "temperature" for every file independently.
+	  The goal of the approach is to provide valuable hints
+	  to file system or/and SSD for isolation and proper
+	  managament of data with different temperatures.
diff --git a/fs/data-temperature/Makefile b/fs/data-temperature/Makefile
new file mode 100644
index 000000000000..8e089a681360
--- /dev/null
+++ b/fs/data-temperature/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_DATA_TEMPERATURE) += data_temperature.o
diff --git a/fs/data-temperature/data_temperature.c b/fs/data-temperature/data_temperature.c
new file mode 100644
index 000000000000..ea43fbfc3976
--- /dev/null
+++ b/fs/data-temperature/data_temperature.c
@@ -0,0 +1,347 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Data "temperature" paradigm implementation
+ *
+ * Copyright (c) 2024-2025 Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pagemap.h>
+#include <linux/data_temperature.h>
+#include <linux/fs.h>
+
+#define TIME_IS_UNKNOWN		(U64_MAX)
+
+struct kmem_cache *data_temperature_info_cachep;
+
+static inline
+void create_data_temperature_info(struct data_temperature *dt_info)
+{
+	if (!dt_info)
+		return;
+
+	atomic_set(&dt_info->temperature, 0);
+	dt_info->updated_blocks = 0;
+	dt_info->dirty_blocks = 0;
+	dt_info->start_timestamp = TIME_IS_UNKNOWN;
+	dt_info->end_timestamp = TIME_IS_UNKNOWN;
+	dt_info->state = DATA_TEMPERATURE_CREATED;
+}
+
+static inline
+void free_data_temperature_info(struct data_temperature *dt_info)
+{
+	if (!dt_info)
+		return;
+
+	kmem_cache_free(data_temperature_info_cachep, dt_info);
+}
+
+int __set_data_temperature_info(struct inode *inode)
+{
+	struct data_temperature *dt_info;
+
+	dt_info = kmem_cache_zalloc(data_temperature_info_cachep, GFP_KERNEL);
+	if (!dt_info)
+		return -ENOMEM;
+
+	spin_lock_init(&dt_info->change_lock);
+	create_data_temperature_info(dt_info);
+
+	if (cmpxchg_release(&inode->i_data_temperature_info,
+					NULL, dt_info) != NULL) {
+		free_data_temperature_info(dt_info);
+		get_data_temperature_info(inode);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__set_data_temperature_info);
+
+void __remove_data_temperature_info(struct inode *inode)
+{
+	free_data_temperature_info(inode->i_data_temperature_info);
+	inode->i_data_temperature_info = NULL;
+}
+EXPORT_SYMBOL_GPL(__remove_data_temperature_info);
+
+int __get_data_temperature(const struct inode *inode)
+{
+	struct data_temperature *dt_info;
+
+	if (!S_ISREG(inode->i_mode))
+		return 0;
+
+	dt_info = get_data_temperature_info(inode);
+	if (IS_ERR_OR_NULL(dt_info))
+		return 0;
+
+	return atomic_read(&dt_info->temperature);
+}
+EXPORT_SYMBOL_GPL(__get_data_temperature);
+
+static inline
+bool is_timestamp_invalid(struct data_temperature *dt_info)
+{
+	if (!dt_info)
+		return false;
+
+	if (dt_info->start_timestamp == TIME_IS_UNKNOWN ||
+	    dt_info->end_timestamp == TIME_IS_UNKNOWN)
+		return true;
+
+	if (dt_info->start_timestamp > dt_info->end_timestamp)
+		return true;
+
+	return false;
+}
+
+static inline
+u64 get_current_timestamp(void)
+{
+	return ktime_get_boottime_ns();
+}
+
+static inline
+void start_account_data_temperature_info(struct data_temperature *dt_info)
+{
+	if (!dt_info)
+		return;
+
+	dt_info->dirty_blocks = 1;
+	dt_info->start_timestamp = get_current_timestamp();
+	dt_info->end_timestamp = TIME_IS_UNKNOWN;
+	dt_info->state = DATA_TEMPERATURE_UPDATE_STARTED;
+}
+
+static inline
+void __increase_data_temperature(struct inode *inode,
+				 struct data_temperature *dt_info)
+{
+	u64 bytes_count;
+	u64 file_blocks;
+	u32 block_bytes;
+	int dirty_blocks_ratio;
+	int updated_blocks_ratio;
+	int old_temperature;
+	int calculated;
+
+	if (!inode || !dt_info)
+		return;
+
+	block_bytes = 1 << inode->i_blkbits;
+	bytes_count = i_size_read(inode) + block_bytes - 1;
+	file_blocks = bytes_count >> inode->i_blkbits;
+
+	dt_info->dirty_blocks++;
+
+	if (file_blocks > 0) {
+		old_temperature = atomic_read(&dt_info->temperature);
+
+		dirty_blocks_ratio = div_u64(dt_info->dirty_blocks,
+						file_blocks);
+		updated_blocks_ratio = div_u64(dt_info->updated_blocks,
+						file_blocks);
+		calculated = max_t(int, dirty_blocks_ratio,
+					updated_blocks_ratio);
+
+		if (calculated > 0 && old_temperature < calculated)
+			atomic_set(&dt_info->temperature, calculated);
+	}
+}
+
+static inline
+void __decrease_data_temperature(struct inode *inode,
+				 struct data_temperature *dt_info)
+{
+	u64 timestamp;
+	u64 time_range;
+	u64 time_diff;
+	u64 bytes_count;
+	u64 file_blocks;
+	u32 block_bytes;
+	u64 blks_per_temperature_degree;
+	u64 ns_per_block;
+	u64 temperature_diff;
+
+	if (!inode || !dt_info)
+		return;
+
+	if (is_timestamp_invalid(dt_info)) {
+		create_data_temperature_info(dt_info);
+		return;
+	}
+
+	timestamp = get_current_timestamp();
+
+	if (dt_info->end_timestamp > timestamp) {
+		create_data_temperature_info(dt_info);
+		return;
+	}
+
+	time_range = dt_info->end_timestamp - dt_info->start_timestamp;
+	time_diff = timestamp - dt_info->end_timestamp;
+
+	block_bytes = 1 << inode->i_blkbits;
+	bytes_count = i_size_read(inode) + block_bytes - 1;
+	file_blocks = bytes_count >> inode->i_blkbits;
+
+	blks_per_temperature_degree = file_blocks;
+	if (blks_per_temperature_degree == 0) {
+		start_account_data_temperature_info(dt_info);
+		return;
+	}
+
+	if (dt_info->updated_blocks == 0 || time_range == 0) {
+		start_account_data_temperature_info(dt_info);
+		return;
+	}
+
+	ns_per_block = div_u64(time_range, dt_info->updated_blocks);
+	if (ns_per_block == 0)
+		ns_per_block = 1;
+
+	if (time_diff == 0) {
+		start_account_data_temperature_info(dt_info);
+		return;
+	}
+
+	temperature_diff = div_u64(time_diff, ns_per_block);
+	temperature_diff = div_u64(temperature_diff,
+					blks_per_temperature_degree);
+
+	if (temperature_diff == 0)
+		return;
+
+	if (temperature_diff <= atomic_read(&dt_info->temperature)) {
+		atomic_sub(temperature_diff, &dt_info->temperature);
+		dt_info->updated_blocks -=
+			temperature_diff * blks_per_temperature_degree;
+	} else {
+		atomic_set(&dt_info->temperature, 0);
+		dt_info->updated_blocks = 0;
+	}
+}
+
+int __increase_data_temperature_by_dirty_folio(struct folio *folio)
+{
+	struct inode *inode;
+	struct data_temperature *dt_info;
+
+	if (!folio || !folio->mapping)
+		return 0;
+
+	inode = folio_inode(folio);
+
+	if (!S_ISREG(inode->i_mode))
+		return 0;
+
+	dt_info = get_data_temperature_info(inode);
+	if (IS_ERR_OR_NULL(dt_info))
+		return 0;
+
+	spin_lock(&dt_info->change_lock);
+	switch (dt_info->state) {
+	case DATA_TEMPERATURE_CREATED:
+		atomic_set(&dt_info->temperature, 0);
+		start_account_data_temperature_info(dt_info);
+		break;
+
+	case DATA_TEMPERATURE_UPDATE_STARTED:
+		__increase_data_temperature(inode, dt_info);
+		break;
+
+	case DATA_TEMPERATURE_UPDATE_FINISHED:
+		__decrease_data_temperature(inode, dt_info);
+		start_account_data_temperature_info(dt_info);
+		break;
+
+	default:
+		/* do nothing */
+		break;
+	}
+	spin_unlock(&dt_info->change_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__increase_data_temperature_by_dirty_folio);
+
+static inline
+void decrement_dirty_blocks(struct data_temperature *dt_info)
+{
+	if (!dt_info)
+		return;
+
+	if (dt_info->dirty_blocks > 0) {
+		dt_info->dirty_blocks--;
+		dt_info->updated_blocks++;
+	}
+}
+
+static inline
+void finish_increasing_data_temperature(struct data_temperature *dt_info)
+{
+	if (!dt_info)
+		return;
+
+	if (dt_info->dirty_blocks == 0) {
+		dt_info->end_timestamp = get_current_timestamp();
+		dt_info->state = DATA_TEMPERATURE_UPDATE_FINISHED;
+	}
+}
+
+int __account_flushed_folio_by_data_temperature(struct folio *folio)
+{
+	struct inode *inode;
+	struct data_temperature *dt_info;
+
+	if (!folio || !folio->mapping)
+		return 0;
+
+	inode = folio_inode(folio);
+
+	if (!S_ISREG(inode->i_mode))
+		return 0;
+
+	dt_info = get_data_temperature_info(inode);
+	if (IS_ERR_OR_NULL(dt_info))
+		return 0;
+
+	spin_lock(&dt_info->change_lock);
+	switch (dt_info->state) {
+	case DATA_TEMPERATURE_CREATED:
+		create_data_temperature_info(dt_info);
+		break;
+
+	case DATA_TEMPERATURE_UPDATE_STARTED:
+		if (dt_info->dirty_blocks > 0)
+			decrement_dirty_blocks(dt_info);
+		if (dt_info->dirty_blocks == 0)
+			finish_increasing_data_temperature(dt_info);
+		break;
+
+	case DATA_TEMPERATURE_UPDATE_FINISHED:
+		/* do nothing */
+		break;
+
+	default:
+		/* do nothing */
+		break;
+	}
+	spin_unlock(&dt_info->change_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__account_flushed_folio_by_data_temperature);
+
+static int __init data_temperature_init(void)
+{
+	data_temperature_info_cachep = KMEM_CACHE(data_temperature,
+						  SLAB_RECLAIM_ACCOUNT);
+	if (!data_temperature_info_cachep)
+		return -ENOMEM;
+
+	return 0;
+}
+late_initcall(data_temperature_init)
diff --git a/include/linux/data_temperature.h b/include/linux/data_temperature.h
new file mode 100644
index 000000000000..40abf6322385
--- /dev/null
+++ b/include/linux/data_temperature.h
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Data "temperature" paradigm declarations
+ *
+ * Copyright (c) 2024-2025 Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#ifndef _LINUX_DATA_TEMPERATURE_H
+#define _LINUX_DATA_TEMPERATURE_H
+
+/*
+ * struct data_temperature - data temperature definition
+ * @temperature: current temperature of a file
+ * @change_lock: modification lock
+ * @state: current state of data temperature object
+ * @dirty_blocks: current number of dirty blocks in page cache
+ * @updated_blocks: number of updated blocks [start_timestamp, end_timestamp]
+ * @start_timestamp: starting timestamp of update operations
+ * @end_timestamp: finishing timestamp of update operations
+ */
+struct data_temperature {
+	atomic_t temperature;
+
+	spinlock_t change_lock;
+	int state;
+	u64 dirty_blocks;
+	u64 updated_blocks;
+	u64 start_timestamp;
+	u64 end_timestamp;
+};
+
+enum data_temperature_state {
+	DATA_TEMPERATURE_UNKNOWN_STATE,
+	DATA_TEMPERATURE_CREATED,
+	DATA_TEMPERATURE_UPDATE_STARTED,
+	DATA_TEMPERATURE_UPDATE_FINISHED,
+	DATA_TEMPERATURE_STATE_MAX
+};
+
+#ifdef CONFIG_DATA_TEMPERATURE
+
+int __set_data_temperature_info(struct inode *inode);
+void __remove_data_temperature_info(struct inode *inode);
+int __get_data_temperature(const struct inode *inode);
+int __increase_data_temperature_by_dirty_folio(struct folio *folio);
+int __account_flushed_folio_by_data_temperature(struct folio *folio);
+
+static inline
+struct data_temperature *get_data_temperature_info(const struct inode *inode)
+{
+	return smp_load_acquire(&inode->i_data_temperature_info);
+}
+
+static inline
+int set_data_temperature_info(struct inode *inode)
+{
+	return __set_data_temperature_info(inode);
+}
+
+static inline
+void remove_data_temperature_info(struct inode *inode)
+{
+	__remove_data_temperature_info(inode);
+}
+
+static inline
+int get_data_temperature(const struct inode *inode)
+{
+	return __get_data_temperature(inode);
+}
+
+static inline
+int increase_data_temperature_by_dirty_folio(struct folio *folio)
+{
+	return __increase_data_temperature_by_dirty_folio(folio);
+}
+
+static inline
+int account_flushed_folio_by_data_temperature(struct folio *folio)
+{
+	return __account_flushed_folio_by_data_temperature(folio);
+}
+
+#else  /* !CONFIG_DATA_TEMPERATURE */
+
+static inline
+int set_data_temperature_info(struct inode *inode)
+{
+	return 0;
+}
+
+static inline
+void remove_data_temperature_info(struct inode *inode)
+{
+	return;
+}
+
+static inline
+struct data_temperature *get_data_temperature_info(const struct inode *inode)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline
+int get_data_temperature(const struct inode *inode)
+{
+	return 0;
+}
+
+static inline
+int increase_data_temperature_by_dirty_folio(struct folio *folio)
+{
+	return 0;
+}
+
+static inline
+int account_flushed_folio_by_data_temperature(struct folio *folio)
+{
+	return 0;
+}
+
+#endif	/* CONFIG_DATA_TEMPERATURE */
+
+#endif	/* _LINUX_DATA_TEMPERATURE_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a4af70367f8a..57c4810a28a0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -753,6 +753,10 @@ struct inode {
 	struct fsverity_info	*i_verity_info;
 #endif
 
+#ifdef CONFIG_DATA_TEMPERATURE
+	struct data_temperature		*i_data_temperature_info;
+#endif
+
 	void			*i_private; /* fs or device private pointer */
 } __randomize_layout;
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index d9861e42b2bd..5de458b7fefc 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -38,6 +38,7 @@
 #include <linux/sched/rt.h>
 #include <linux/sched/signal.h>
 #include <linux/mm_inline.h>
+#include <linux/data_temperature.h>
 #include <trace/events/writeback.h>
 
 #include "internal.h"
@@ -2775,6 +2776,10 @@ static void folio_account_dirtied(struct folio *folio,
 		__this_cpu_add(bdp_ratelimits, nr);
 
 		mem_cgroup_track_foreign_dirty(folio, wb);
+
+#ifdef CONFIG_DATA_TEMPERATURE
+		increase_data_temperature_by_dirty_folio(folio);
+#endif	/* CONFIG_DATA_TEMPERATURE */
 	}
 }
 
@@ -3006,6 +3011,10 @@ bool folio_clear_dirty_for_io(struct folio *folio)
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
+#ifdef CONFIG_DATA_TEMPERATURE
+	account_flushed_folio_by_data_temperature(folio);
+#endif	/* CONFIG_DATA_TEMPERATURE */
+
 	if (mapping && mapping_can_writeback(mapping)) {
 		struct inode *inode = mapping->host;
 		struct bdi_writeback *wb;
-- 
2.34.1


