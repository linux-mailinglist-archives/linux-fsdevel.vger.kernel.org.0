Return-Path: <linux-fsdevel+bounces-76637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFvKAmQ/hmnzLAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 20:22:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 971BC102A78
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 20:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DDC530396A0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 19:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A8943E48B;
	Fri,  6 Feb 2026 19:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="qMUZ3y7v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3FB42E001
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 19:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770405193; cv=none; b=P3+JZIbw7A1qEmzmQ0XtyJKbKIVXCuBx4PokxZyZVw9Pt1lPGChZKUMunKpWh5PI8+MZ9/nt994GytZhyoY2xTQtc0mvgHjfwh0AyAvFO8sUFO/gGXuAitUwv0qyNL7kdGlQaQ2TCYKnPNrDPfgby9QfOa6zLKjJd6sghr58w5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770405193; c=relaxed/simple;
	bh=8DOELj3d1YF5vnkKTf0ls4Z7dKSAOmVY1KhPtSJlYno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G//phFgPa2Th5Vr4WzjKmdBQk0OD72GLjx/wFWOYIQWgkVXsNaTYpcgjrzpAVzlJWQKaMLqeB7AbWSRONu5rHEDXcRgK3jZQnoqbPS8RvrhvGOHn9uTc5h96xS916aukKLQkf2xQ+k0a5VZr4aSFoeqxjmLHI6yIRH9nPqfq9Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=qMUZ3y7v; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-649e456e8a2so2539221d50.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Feb 2026 11:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1770405192; x=1771009992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEXgdq0izXJsGpGxsVLN8S/Y6PSgZJ5yVJf6Tpti494=;
        b=qMUZ3y7v4CUyHnCq9dui3zjSqmd7Vbk3gInTWAmUREBPnJnHU+Uugjs6XhxEbztUJY
         6MIAuVy7i4q17GZzyT3vqqUbzI0iZbrPR11PXUvNUqkUgSZaQmoL3dQJxn7ON80uRcCB
         0MdK7XDrS0SvPeodUezrKPUZAknAXJ2383hc+mACzyvortOxi+JlfE6qcv50cH/qeGho
         T7WRppCGoFPndU7EJTf65pl9ipgGgsXFcIJ/XbfLbplNKBuS3zpJWq9Oj+DORvN4gUTM
         ABKB4YRV+55SHIx4WiiiCLtC8DkzZAIucRHCjxkTx+AH5gW3EFE+GodfGEj+IwWc30qr
         rCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770405192; x=1771009992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YEXgdq0izXJsGpGxsVLN8S/Y6PSgZJ5yVJf6Tpti494=;
        b=JYJVYGE/yI/qEY7+hC3OSaORWq81Rtv90xEYkaulc8OmJdEhmVB1P8bIUd9NhimnAJ
         lf6OpfPaCYp+fyY0FnpXaC3FMyBMQB48P6acP673uL5WYowOZuZPWNmT2jpzVv2sq4cc
         f6xS86rNNFt7s9Rky+9aPnX/xHdvEd+IC1V8U8ueMd1gOxKVfbc9C+osNVMCiNvJn38u
         RcD4OJoL6yu13IqBAuDeVHlt5v06//l6xG5vGp2YNruBFrIkvR8LYcuRBiY+JsHFKbRU
         njjEkYYWrdGB1T+MbvmRY6SKZ3gfKvpVS5RipAmhLEtvMGxya014Od7hkZF/SWbGGoZ7
         edsQ==
X-Gm-Message-State: AOJu0YwBIM+uslx2DsWTCIMYPKYz8I7MYy0yLXOyhKeY0/3y6njjkqVF
	ehlYdiXIaw27aes2BHDrQFm1UcF2QUmeXxlC0I2YM913Lg5gEZl1sYV5St00YTpWqjd8XhE0KkC
	uA149qck=
X-Gm-Gg: AZuq6aK0FrMKpgxiWit8Zca9kHU6ojqTcN+bVPXj0LpUsBNVIwNSJvsNjPIltsSaC4f
	+qajRx8xQ8jth+0E2Q7l6VgXChHrBEBs1hqfN7oCr/BDENnsH0AywZRDMsJFDQGiS6Du63HFMcQ
	ou45P9xFqI6G+H4ch4VLi1DdjzCxao711b+4Gwu3HzBByUP83va7WmSIZVq6GvXOWwZCmRgqnDn
	cVTPD2RJ+JNsG76O2rSlQjtM8a7Kihicja+0k4SU+dmtddl8MJ8knYZsUPnbaa28BlInrIPwYgC
	e9Av4m0cMKR8kcHv+hX2ez4dMYJDjgj+Y9fUxO9bVKgaY5NBdtWsTx55fDxPVAS8omROrE1Q1fi
	yypblxDGyeoPwSlWeEy96L3U227NL0IsjmPFEqFENi7hBrp4uQY3QdqfGxJ410CzuPdKO+aWUqk
	S/mHURQqoDul5E+EVsvgtHhrnxbnfjomfxSSUy8JCtlU2Hm+aTNg7GSKXU5yhbffx+BeM3DGfQG
	JznBxROSKG3
X-Received: by 2002:a05:690c:9c04:b0:796:1eee:b8f7 with SMTP id 00721157ae682-7961eeebef9mr45307667b3.58.1770405191900;
        Fri, 06 Feb 2026 11:13:11 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:9fc0:ed7d:72bd:ecd1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7952a28697fsm29051277b3.50.2026.02.06.11.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 11:13:11 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org
Cc: Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 3/4] ml-lib: Implement simple testing character device driver
Date: Fri,  6 Feb 2026 11:11:35 -0800
Message-Id: <20260206191136.2609767-4-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260206191136.2609767-1-slava@dubeyko.com>
References: <20260206191136.2609767-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[dubeyko-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dubeyko-com.20230601.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dubeyko.com];
	TAGGED_FROM(0.00)[bounces-76637-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slava@dubeyko.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dubeyko.com:mid,dubeyko.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dubeyko-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 971BC102A78
X-Rspamd-Action: no action

Implement simple testing character device driver

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 lib/ml-lib/test_driver/Kconfig           |  22 +
 lib/ml-lib/test_driver/Makefile          |   5 +
 lib/ml-lib/test_driver/README.md         | 233 ++++++++++
 lib/ml-lib/test_driver/ml_lib_char_dev.c | 530 +++++++++++++++++++++++
 4 files changed, 790 insertions(+)
 create mode 100644 lib/ml-lib/test_driver/Kconfig
 create mode 100644 lib/ml-lib/test_driver/Makefile
 create mode 100644 lib/ml-lib/test_driver/README.md
 create mode 100644 lib/ml-lib/test_driver/ml_lib_char_dev.c

diff --git a/lib/ml-lib/test_driver/Kconfig b/lib/ml-lib/test_driver/Kconfig
new file mode 100644
index 000000000000..183fc1de57a8
--- /dev/null
+++ b/lib/ml-lib/test_driver/Kconfig
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config ML_LIB_TEST_DRIVER
+	tristate "ML library testing character device driver"
+	depends on ML_LIB
+	default n
+	help
+	  This is a ML library testing character device driver for
+	  testing generic ML library functionality. It provides:
+
+	  - Basic read/write operations
+	  - IOCTL interface for device control
+	  - Sysfs attributes for runtime information
+	  - Procfs entry for debugging
+
+	  The driver creates a /dev/mllibdev device node that can be
+	  used to read and write data to a kernel buffer.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called mllibdev.
diff --git a/lib/ml-lib/test_driver/Makefile b/lib/ml-lib/test_driver/Makefile
new file mode 100644
index 000000000000..6444bcf8985b
--- /dev/null
+++ b/lib/ml-lib/test_driver/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_ML_LIB_TEST_DRIVER) += ml_lib_test_dev.o
+
+ml_lib_test_dev-y := ml_lib_char_dev.o
diff --git a/lib/ml-lib/test_driver/README.md b/lib/ml-lib/test_driver/README.md
new file mode 100644
index 000000000000..0bb4105c8aa4
--- /dev/null
+++ b/lib/ml-lib/test_driver/README.md
@@ -0,0 +1,233 @@
+# ML Library Testing Device Driver (mllibdev)
+
+ML library testing character device driver for the Linux kernel:
+- Basic read/write operations
+- IOCTL interface for device control
+- Sysfs attributes for runtime information
+- Procfs entry for debugging
+
+## Features
+
+### Character Device Operations
+- **Open/Close**: Device can be opened and closed multiple times
+- **Read**: Read data from a kernel buffer
+- **Write**: Write data to a kernel buffer (1KB capacity)
+- **Seek**: Support for lseek() operations
+
+### IOCTL Commands
+- `ML_LIB_TEST_DEV_IOCRESET`: Clear the device buffer
+- `ML_LIB_TEST_DEV_IOCGETSIZE`: Get current data size
+- `ML_LIB_TEST_DEV_IOCSETSIZE`: Set data size
+
+### Sysfs Attributes
+Located at `/sys/class/ml_lib_test/mllibdev`:
+- `buffer_size`: Maximum buffer capacity (read-only)
+- `data_size`: Current amount of data in buffer (read-only)
+- `access_count`: Number of times device has been opened (read-only)
+- `stats`: Comprehensive statistics (opens, reads, writes)
+
+### Procfs Entry
+Located at `/proc/mllibdev`: Provides formatted driver information
+
+## Building the Driver
+
+### Option 1: Build as a Module
+
+1. Configure the kernel to build mllibdev as a module:
+   ```bash
+   make menuconfig
+   # Navigate to: Library routines -> ML library testing character device driver
+   # Select: <M> ML library testing character device driver
+   ```
+
+2. Build the module:
+   ```bash
+   make -j$(nproc) M=lib/ml-lib/test_driver
+   ```
+
+### Option 2: Build into Kernel
+
+1. Configure the kernel:
+   ```bash
+   make menuconfig
+   # Navigate to: Library routines -> ML library testing character device driver
+   # Select: <*> ML library testing character device driver
+   ```
+
+2. Build the kernel:
+   ```bash
+   make -j$(nproc)
+   ```
+
+### Option 3: Quick Module Build (Out-of-Tree)
+
+For quick testing, you can build just the module:
+
+```bash
+cd lib/ml-lib/test_driver
+make -C /lib/modules/$(uname -r)/build M=$(pwd) modules
+```
+
+## Loading the Driver
+
+If built as a module:
+
+```bash
+# Load the module
+sudo insmod /lib/modules/$(uname -r)/build/lib/ml-lib/test_driver/ml_lib_test_dev.ko
+
+# Verify it's loaded
+sudo lsmod | grep ml_lib_test_dev
+
+# Check kernel messages
+sudo dmesg | tail -20
+```
+
+You should see messages like:
+```
+ml_lib_test_dev: Initializing driver
+ml_lib_test_dev: Device number allocated: XXX:0
+ml_lib_test_dev: Driver initialized successfully
+ml_lib_test_dev: Device created at /dev/mllibdev
+ml_lib_test_dev: Proc entry created at /proc/mllibdev
+```
+
+## Testing the Driver
+
+### Quick Manual Test
+
+```bash
+# Write data to the device
+sudo su
+echo "Hello, kernel!" > /dev/mllibdev
+
+# Read data back
+sudo su
+cat /dev/mllibdev
+
+# Check sysfs attributes
+cat /sys/class/ml_lib_test/mllibdev/stats
+
+# Check proc entry
+cat /proc/mllibdev
+```
+
+### Using the Test Program
+
+1. Compile the test program:
+   ```bash
+   cd lib/ml-lib/test_driver/test_application
+   gcc -o ml_lib_test_dev test_ml_lib_char_dev.c
+   ```
+
+2. Run the test program:
+   ```bash
+   sudo ./ml_lib_test_dev
+   ```
+
+The test program will:
+- Open the device
+- Write test data
+- Read the data back
+- Test all IOCTL commands
+- Display sysfs attributes
+- Show procfs information
+
+### Example Test Output
+
+```
+ML Library Testing Device Driver Test Program
+==================================
+Device opened successfully: /dev/mllibdev
+
+========== Write Test ==========
+Successfully wrote 62 bytes
+Data: "Hello from userspace! This is a test of the mllibdev driver."
+
+========== Read Test ==========
+Successfully read 62 bytes
+Data: "Hello from userspace! This is a test of the mllibdev driver."
+
+========== IOCTL Tests ==========
+Current data size: 62 bytes
+Set data size to: 50 bytes
+Verified new size: 50 bytes
+Buffer reset successfully
+Size after reset: 0 bytes
+
+========== Sysfs Attributes ==========
+buffer_size: 1024
+data_size: 0
+access_count: 1
+
+stats: Opens: 1
+Reads: 1
+Writes: 1
+
+========== Procfs Information ==========
+ML Library Testing Device Driver Information
+=================================
+Device name:     mllibdev
+Buffer size:     1024 bytes
+Data size:       0 bytes
+Access count:    1
+Read count:      1
+Write count:     1
+
+========== Final Test ==========
+All tests completed successfully!
+```
+
+## Unloading the Driver
+
+```bash
+# Remove the module
+sudo rmmod ml_lib_test_dev
+
+# Verify it's unloaded
+sudo lsmod | grep ml_lib_test_dev
+
+# Check cleanup messages
+sudo dmesg | tail -10
+```
+
+## Troubleshooting
+
+### Device node doesn't exist
+```bash
+# Check if udev created the device
+ls -l /dev/mllibdev
+
+# Manually create if needed (shouldn't be necessary)
+sudo mknod /dev/mllibdev c MAJOR MINOR
+```
+
+### Permission denied
+```bash
+# Run commands with sudo
+sudo cat /dev/mllibdev
+
+# Or change permissions
+sudo chmod 666 /dev/mllibdev
+```
+
+### Module won't load
+```bash
+# Check kernel messages for errors
+dmesg | tail -20
+
+# Verify module dependencies
+modinfo lib/ml-lib/test_driver/ml_lib_test_dev.ko
+```
+
+## License
+
+This driver is licensed under GPL-2.0.
+
+## Author
+
+Viacheslav Dubeyko <slava@dubeyko.com>
+
+## Version
+
+1.0
diff --git a/lib/ml-lib/test_driver/ml_lib_char_dev.c b/lib/ml-lib/test_driver/ml_lib_char_dev.c
new file mode 100644
index 000000000000..b2d6e27ece28
--- /dev/null
+++ b/lib/ml-lib/test_driver/ml_lib_char_dev.c
@@ -0,0 +1,530 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Machine Learning (ML) library
+ * Testing Character Device Driver
+ *
+ * Copyright (C) 2025-2026 Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/mutex.h>
+#include <linux/ml-lib/ml_lib.h>
+
+#define DEVICE_NAME "mllibdev"
+#define CLASS_NAME "ml_lib_test"
+#define BUFFER_SIZE 1024
+
+/* IOCTL commands */
+#define ML_LIB_TEST_DEV_IOC_MAGIC   'M'
+#define ML_LIB_TEST_DEV_IOCRESET    _IO(ML_LIB_TEST_DEV_IOC_MAGIC, 0)
+#define ML_LIB_TEST_DEV_IOCGETSIZE  _IOR(ML_LIB_TEST_DEV_IOC_MAGIC, 1, int)
+#define ML_LIB_TEST_DEV_IOCSETSIZE  _IOW(ML_LIB_TEST_DEV_IOC_MAGIC, 2, int)
+
+/* Device data structure */
+struct ml_lib_test_dev_data {
+	struct cdev cdev;
+	struct device *device;
+	char *dataset_buf;
+	size_t dataset_buf_size;
+	size_t dataset_size;
+	char *recommendations_buf;
+	size_t recommendations_buf_size;
+	size_t recommendations_size;
+	struct mutex lock;
+	unsigned long access_count;
+	unsigned long read_count;
+	unsigned long write_count;
+
+	struct ml_lib_model *ml_model1;
+};
+
+#define ML_MODEL_1_NAME "ml_model1"
+
+static
+int ml_lib_test_dev_extract_dataset(struct ml_lib_model *ml_model,
+				    struct ml_lib_dataset *dataset);
+
+static struct ml_lib_dataset_operations ml_lib_test_dev_dataset_ops = {
+	.extract = ml_lib_test_dev_extract_dataset,
+};
+
+static dev_t dev_number;
+static struct class *ml_lib_test_dev_class;
+static struct ml_lib_test_dev_data *dev_data;
+static struct proc_dir_entry *proc_entry;
+
+/* ML model operations */
+static
+int ml_lib_test_dev_extract_dataset(struct ml_lib_model *ml_model,
+				    struct ml_lib_dataset *dataset)
+{
+	struct ml_lib_test_dev_data *data =
+		(struct ml_lib_test_dev_data *)ml_model->parent->private;
+	u8 pattern;
+
+	mutex_lock(&data->lock);
+	get_random_bytes(&pattern, 1);
+	memset(data->dataset_buf, pattern, data->dataset_buf_size);
+	data->dataset_size = data->dataset_buf_size;
+	atomic_set(&dataset->type, ML_LIB_MEMORY_STREAM_DATASET);
+	atomic_set(&dataset->state, ML_LIB_DATASET_CLEAN);
+	dataset->allocated_size = data->dataset_buf_size;
+	dataset->portion_offset = 0;
+	dataset->portion_size = data->dataset_buf_size;
+	mutex_unlock(&data->lock);
+
+	return 0;
+}
+
+/* File operations */
+static int ml_lib_test_dev_open(struct inode *inode, struct file *file)
+{
+	struct ml_lib_test_dev_data *data = container_of(inode->i_cdev,
+						struct ml_lib_test_dev_data,
+						cdev);
+
+	file->private_data = data;
+
+	mutex_lock(&data->lock);
+	data->access_count++;
+	mutex_unlock(&data->lock);
+
+	pr_info("ml_lib_test_dev: Device opened (total opens: %lu)\n",
+		data->access_count);
+
+	return 0;
+}
+
+static int ml_lib_test_dev_release(struct inode *inode, struct file *file)
+{
+	pr_info("ml_lib_test_dev: Device closed\n");
+	return 0;
+}
+
+static ssize_t ml_lib_test_dev_read(struct file *file, char __user *buf,
+				    size_t count, loff_t *ppos)
+{
+	struct ml_lib_test_dev_data *data = file->private_data;
+	size_t to_read;
+	int ret;
+
+	mutex_lock(&data->lock);
+
+	if (*ppos >= data->dataset_size) {
+		mutex_unlock(&data->lock);
+		return 0;
+	}
+
+	to_read = min(count, data->dataset_size - (size_t)*ppos);
+
+	ret = copy_to_user(buf, data->dataset_buf + *ppos, to_read);
+	if (ret) {
+		mutex_unlock(&data->lock);
+		return -EFAULT;
+	}
+
+	*ppos += to_read;
+	data->read_count++;
+
+	mutex_unlock(&data->lock);
+
+	pr_info("ml_lib_test_dev: Read %zu bytes\n", to_read);
+
+	return to_read;
+}
+
+static ssize_t ml_lib_test_dev_write(struct file *file, const char __user *buf,
+				     size_t count, loff_t *ppos)
+{
+	struct ml_lib_test_dev_data *data = file->private_data;
+	size_t to_write;
+	int ret;
+
+	mutex_lock(&data->lock);
+
+	if (*ppos >= data->recommendations_buf_size) {
+		mutex_unlock(&data->lock);
+		return -ENOSPC;
+	}
+
+	to_write = min(count, data->recommendations_buf_size - (size_t)*ppos);
+
+	ret = copy_from_user(data->recommendations_buf + *ppos, buf, to_write);
+	if (ret) {
+		mutex_unlock(&data->lock);
+		return -EFAULT;
+	}
+
+	*ppos += to_write;
+	if (*ppos > data->recommendations_size)
+		data->recommendations_size = *ppos;
+
+	data->write_count++;
+
+	mutex_unlock(&data->lock);
+
+	pr_info("ml_lib_test_dev: Wrote %zu bytes\n", to_write);
+
+	return to_write;
+}
+
+static long ml_lib_test_dev_ioctl(struct file *file, unsigned int cmd,
+				  unsigned long arg)
+{
+	struct ml_lib_test_dev_data *data = file->private_data;
+	int size;
+
+	switch (cmd) {
+	case ML_LIB_TEST_DEV_IOCRESET:
+		mutex_lock(&data->lock);
+		memset(data->dataset_buf,
+			0, data->dataset_buf_size);
+		data->dataset_size = 0;
+		memset(data->recommendations_buf,
+			0, data->recommendations_buf_size);
+		data->recommendations_size = 0;
+		mutex_unlock(&data->lock);
+		pr_info("ml_lib_test_dev: Buffer reset via IOCTL\n");
+		break;
+
+	case ML_LIB_TEST_DEV_IOCGETSIZE:
+		mutex_lock(&data->lock);
+		size = data->dataset_size;
+		mutex_unlock(&data->lock);
+		if (copy_to_user((int __user *)arg, &size, sizeof(size)))
+			return -EFAULT;
+		break;
+
+	case ML_LIB_TEST_DEV_IOCSETSIZE:
+		if (copy_from_user(&size, (int __user *)arg, sizeof(size)))
+			return -EFAULT;
+		if (size < 0 || size > data->recommendations_buf_size)
+			return -EINVAL;
+		mutex_lock(&data->lock);
+		data->recommendations_size = size;
+		mutex_unlock(&data->lock);
+		pr_info("ml_lib_test_dev: Data size set to %d via IOCTL\n", size);
+		break;
+
+	default:
+		return -ENOTTY;
+	}
+
+	return 0;
+}
+
+static const struct file_operations ml_lib_test_dev_fops = {
+	.owner = THIS_MODULE,
+	.open = ml_lib_test_dev_open,
+	.release = ml_lib_test_dev_release,
+	.read = ml_lib_test_dev_read,
+	.write = ml_lib_test_dev_write,
+	.unlocked_ioctl = ml_lib_test_dev_ioctl,
+	.llseek = default_llseek,
+};
+
+/* Sysfs attributes */
+static ssize_t buffer_size_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct ml_lib_test_dev_data *data = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%zu\n", data->dataset_buf_size);
+}
+
+static ssize_t data_size_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct ml_lib_test_dev_data *data = dev_get_drvdata(dev);
+	size_t size;
+
+	mutex_lock(&data->lock);
+	size = data->dataset_size;
+	mutex_unlock(&data->lock);
+
+	return sprintf(buf, "%zu\n", size);
+}
+
+static ssize_t access_count_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct ml_lib_test_dev_data *data = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%lu\n", data->access_count);
+}
+
+static ssize_t stats_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	struct ml_lib_test_dev_data *data = dev_get_drvdata(dev);
+
+	return sprintf(buf, "Opens: %lu\nReads: %lu\nWrites: %lu\n",
+		       data->access_count, data->read_count,
+		       data->write_count);
+}
+
+static DEVICE_ATTR_RO(buffer_size);
+static DEVICE_ATTR_RO(data_size);
+static DEVICE_ATTR_RO(access_count);
+static DEVICE_ATTR_RO(stats);
+
+static struct attribute *ml_lib_test_dev_attrs[] = {
+	&dev_attr_buffer_size.attr,
+	&dev_attr_data_size.attr,
+	&dev_attr_access_count.attr,
+	&dev_attr_stats.attr,
+	NULL,
+};
+
+static const struct attribute_group ml_lib_test_dev_attr_group = {
+	.attrs = ml_lib_test_dev_attrs,
+};
+
+/* Procfs operations */
+static int ml_lib_test_dev_proc_show(struct seq_file *m, void *v)
+{
+	struct ml_lib_test_dev_data *data = dev_data;
+
+	seq_printf(m, "ML Library Testing Device Driver Information\n");
+	seq_printf(m, "=================================\n");
+	seq_printf(m, "Device name:     %s\n", DEVICE_NAME);
+	seq_printf(m, "Buffer size:     %zu bytes\n", data->dataset_buf_size);
+	seq_printf(m, "Data size:       %zu bytes\n", data->dataset_size);
+	seq_printf(m, "Access count:    %lu\n", data->access_count);
+	seq_printf(m, "Read count:      %lu\n", data->read_count);
+	seq_printf(m, "Write count:     %lu\n", data->write_count);
+
+	return 0;
+}
+
+static int ml_lib_test_dev_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ml_lib_test_dev_proc_show, NULL);
+}
+
+static const struct proc_ops ml_lib_test_dev_proc_ops = {
+	.proc_open = ml_lib_test_dev_proc_open,
+	.proc_read = seq_read,
+	.proc_lseek = seq_lseek,
+	.proc_release = single_release,
+};
+
+/* Module initialization */
+static int __init ml_lib_test_dev_init(void)
+{
+	struct ml_lib_model_options *options;
+	int ret;
+
+	pr_info("ml_lib_test_dev: Initializing driver\n");
+
+	/* Allocate device data */
+	dev_data = kzalloc(sizeof(struct ml_lib_test_dev_data), GFP_KERNEL);
+	if (!dev_data)
+		return -ENOMEM;
+
+	/* Allocate dataset buffer */
+	dev_data->dataset_buf = kzalloc(BUFFER_SIZE, GFP_KERNEL);
+	if (!dev_data->dataset_buf) {
+		ret = -ENOMEM;
+		goto err_free_data;
+	}
+
+	dev_data->dataset_buf_size = BUFFER_SIZE;
+	dev_data->dataset_size = 0;
+
+	/* Allocate recomendations buffer */
+	dev_data->recommendations_buf = kzalloc(BUFFER_SIZE, GFP_KERNEL);
+	if (!dev_data->recommendations_buf) {
+		ret = -ENOMEM;
+		goto err_free_dataset_buffer;
+	}
+
+	dev_data->recommendations_buf_size = BUFFER_SIZE;
+	dev_data->recommendations_size = 0;
+
+	mutex_init(&dev_data->lock);
+
+	/* Allocate device number */
+	ret = alloc_chrdev_region(&dev_number, 0, 1, DEVICE_NAME);
+	if (ret < 0) {
+		pr_err("ml_lib_test_dev: Failed to allocate device number\n");
+		goto err_free_recommendations_buffer;
+	}
+
+	pr_info("ml_lib_test_dev: Device number allocated: %d:%d\n",
+		MAJOR(dev_number), MINOR(dev_number));
+
+	/* Create device class */
+	ml_lib_test_dev_class = class_create(CLASS_NAME);
+	if (IS_ERR(ml_lib_test_dev_class)) {
+		ret = PTR_ERR(ml_lib_test_dev_class);
+		pr_err("ml_lib_test_dev: Failed to create class\n");
+		goto err_unregister_chrdev;
+	}
+
+	/* Initialize and add cdev */
+	cdev_init(&dev_data->cdev, &ml_lib_test_dev_fops);
+	dev_data->cdev.owner = THIS_MODULE;
+
+	ret = cdev_add(&dev_data->cdev, dev_number, 1);
+	if (ret < 0) {
+		pr_err("ml_lib_test_dev: Failed to add cdev\n");
+		goto err_class_destroy;
+	}
+
+	/* Create device */
+	dev_data->device = device_create(ml_lib_test_dev_class,
+					 NULL, dev_number,
+					 dev_data, DEVICE_NAME);
+	if (IS_ERR(dev_data->device)) {
+		ret = PTR_ERR(dev_data->device);
+		pr_err("ml_lib_test_dev: Failed to create device\n");
+		goto err_cdev_del;
+	}
+
+	/* Create sysfs attributes */
+	ret = sysfs_create_group(&dev_data->device->kobj,
+				 &ml_lib_test_dev_attr_group);
+	if (ret < 0) {
+		pr_err("ml_lib_test_dev: Failed to create sysfs group\n");
+		goto err_device_destroy;
+	}
+
+	/* Create procfs entry */
+	proc_entry = proc_create(DEVICE_NAME, 0444, NULL,
+				 &ml_lib_test_dev_proc_ops);
+	if (!proc_entry) {
+		pr_err("ml_lib_test_dev: Failed to create proc entry\n");
+		ret = -ENOMEM;
+		goto err_sysfs_remove;
+	}
+
+	dev_data->ml_model1 = allocate_ml_model(sizeof(struct ml_lib_model),
+						GFP_KERNEL);
+	if (IS_ERR(dev_data->ml_model1)) {
+		ret = PTR_ERR(dev_data->ml_model1);
+		pr_err("ml_lib_test_dev: Failed to allocate ML model\n");
+		goto err_procfs_remove;
+	} else if (!dev_data->ml_model1) {
+		ret = -ENOMEM;
+		pr_err("ml_lib_test_dev: Failed to allocate ML model\n");
+		goto err_procfs_remove;
+	}
+
+	ret = ml_model_create(dev_data->ml_model1, CLASS_NAME,
+			      ML_MODEL_1_NAME, &dev_data->device->kobj);
+	if (ret < 0) {
+		pr_err("ml_lib_test_dev: Failed to create ML model\n");
+		goto err_ml_model_free;
+	}
+
+	dev_data->ml_model1->parent->private = dev_data;
+	dev_data->ml_model1->model_ops = NULL;
+	dev_data->ml_model1->dataset_ops = &ml_lib_test_dev_dataset_ops;
+
+	options = allocate_ml_model_options(sizeof(struct ml_lib_model_options),
+					    GFP_KERNEL);
+	if (IS_ERR(options)) {
+		ret = PTR_ERR(options);
+		pr_err("ml_lib_test_dev: Failed to allocate ML model options\n");
+		goto err_ml_model_destroy;
+	} else if (!options) {
+		ret = -ENOMEM;
+		pr_err("ml_lib_test_dev: Failed to allocate ML model options\n");
+		goto err_ml_model_destroy;
+	}
+
+	ret = ml_model_init(dev_data->ml_model1, options);
+	if (ret < 0) {
+		pr_err("ml_lib_test_dev: Failed to init ML model\n");
+		goto err_ml_model_options_free;
+	}
+
+	pr_info("ml_lib_test_dev: Driver initialized successfully\n");
+	pr_info("ml_lib_test_dev: Device created at /dev/%s\n",
+		DEVICE_NAME);
+	pr_info("ml_lib_test_dev: Proc entry created at /proc/%s\n",
+		DEVICE_NAME);
+
+	return 0;
+
+err_ml_model_options_free:
+	free_ml_model_options(options);
+err_ml_model_destroy:
+	ml_model_destroy(dev_data->ml_model1);
+err_ml_model_free:
+	free_ml_model(dev_data->ml_model1);
+err_procfs_remove:
+	proc_remove(proc_entry);
+err_sysfs_remove:
+	sysfs_remove_group(&dev_data->device->kobj,
+			   &ml_lib_test_dev_attr_group);
+err_device_destroy:
+	device_destroy(ml_lib_test_dev_class, dev_number);
+err_cdev_del:
+	cdev_del(&dev_data->cdev);
+err_class_destroy:
+	class_destroy(ml_lib_test_dev_class);
+err_unregister_chrdev:
+	unregister_chrdev_region(dev_number, 1);
+err_free_recommendations_buffer:
+	kfree(dev_data->recommendations_buf);
+err_free_dataset_buffer:
+	kfree(dev_data->dataset_buf);
+err_free_data:
+	kfree(dev_data);
+	return ret;
+}
+
+/* Module cleanup */
+static void __exit ml_lib_test_dev_exit(void)
+{
+	pr_info("ml_lib_test_dev: Cleaning up driver\n");
+
+	/* Destroy ML model */
+	ml_model_destroy(dev_data->ml_model1);
+	free_ml_model(dev_data->ml_model1);
+
+	/* Remove procfs entry */
+	proc_remove(proc_entry);
+
+	/* Remove sysfs attributes */
+	sysfs_remove_group(&dev_data->device->kobj,
+			   &ml_lib_test_dev_attr_group);
+
+	/* Destroy device */
+	device_destroy(ml_lib_test_dev_class, dev_number);
+
+	/* Delete cdev */
+	cdev_del(&dev_data->cdev);
+
+	/* Destroy class */
+	class_destroy(ml_lib_test_dev_class);
+
+	/* Unregister device number */
+	unregister_chrdev_region(dev_number, 1);
+
+	/* Free buffers */
+	kfree(dev_data->recommendations_buf);
+	kfree(dev_data->dataset_buf);
+	kfree(dev_data);
+
+	pr_info("ml_lib_test_dev: Driver removed successfully\n");
+}
+
+module_init(ml_lib_test_dev_init);
+module_exit(ml_lib_test_dev_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Viacheslav Dubeyko <slava@dubeyko.com>");
+MODULE_DESCRIPTION("ML libraray testing character device driver");
+MODULE_VERSION("1.0");
-- 
2.34.1


