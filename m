Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5FF99FEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 21:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404286AbfHVTZQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 15:25:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43272 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404261AbfHVTZP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 15:25:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id v12so4610868pfn.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2019 12:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1vZUwbK1p/l0BmkVh8fQjfkP2CW4vgl3dyidM1dNgAg=;
        b=ZOIIJ0y9REQAJT1q4wDEhcRSQTPUidlY3yYsT9ZcOnSly/TsBLV6lLrUmdMNqlGPWd
         ltDZPQxz2h0UIlwx2cbtggNYGI0PY9L3zj9juZ0/th0CHpIjUPWTzCN3iL8nt4rcV46v
         jnaCG+iRz0nZRHF66qgyUKt3M/Js8ii62UmtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1vZUwbK1p/l0BmkVh8fQjfkP2CW4vgl3dyidM1dNgAg=;
        b=jm0ojKOZRUm/PEbyPSUVZgEj35L8ffVQY18O5tBElE6wni/lcsfifhbh/+esgFHWUP
         tmcRwwf/hdSxs9oAv8ex041JPI5jj/kXLd80C1+mF5a0WFSG+jPRuRzHQgC3hiolAENu
         wB12UXir8x1+wYbZphPkog8la1rFv7BNNRz4wc/elsG9vmFwfo+dCVkdcSGx4WXnaR62
         TgfKBNicFLU4cPEaJaDKOO5F1TTpN1PdqED/+Ku5M/1rJTLWhtNMzgmOSw1j0E+dP9eN
         4UH6tzpEKiktRZFfup8tUrEry19m+k+88hpEUv6ON+VOiZTCues9Y0cU1eilrs8Bk9WH
         YuCg==
X-Gm-Message-State: APjAAAXoLaGqZLbywzlSpgTRQ7zrFUOMMZ7dSjH/eIup5OmQtC1pkcwB
        R21obhtJlnTW8OrkL956r1VsBQ==
X-Google-Smtp-Source: APXvYqxKqhgaiqhftuF5cEJJ8r/ssCXG+DkVNRk17eAnS6PXw71jK6LI75gOi1xpL8jIOLZ6wfkPbA==
X-Received: by 2002:a63:c442:: with SMTP id m2mr741672pgg.286.1566501913765;
        Thu, 22 Aug 2019 12:25:13 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c12sm198018pfc.22.2019.08.22.12.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 12:25:13 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH 3/7] test_firmware: add partial read support for request_firmware_into_buf
Date:   Thu, 22 Aug 2019 12:24:47 -0700
Message-Id: <20190822192451.5983-4-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190822192451.5983-1-scott.branden@broadcom.com>
References: <20190822192451.5983-1-scott.branden@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add additional hooks to test_firmware to pass in support
for partial file read using request_firmware_into_buf.
buf_size: size of buffer to request firmware into
partial: indicates that a partial file request is being made
file_offset: to indicate offset into file to request

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 lib/test_firmware.c | 141 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 138 insertions(+), 3 deletions(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 7d1d97fa9a23..6050d3113f92 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -49,6 +49,9 @@ struct test_batched_req {
  * @name: the name of the firmware file to look for
  * @into_buf: when the into_buf is used if this is true
  *	request_firmware_into_buf() will be used instead.
+ * @buf_size: size of buf to allocate when into_buf is true
+ * @file_offset: file offset to request when calling request_firmware_into_buf
+ * @partial: partial read flag value when calling request_firmware_into_buf
  * @sync_direct: when the sync trigger is used if this is true
  *	request_firmware_direct() will be used instead.
  * @send_uevent: whether or not to send a uevent for async requests
@@ -88,6 +91,9 @@ struct test_batched_req {
 struct test_config {
 	char *name;
 	bool into_buf;
+	size_t buf_size;
+	size_t file_offset;
+	bool partial;
 	bool sync_direct;
 	bool send_uevent;
 	u8 num_requests;
@@ -182,6 +188,9 @@ static int __test_firmware_config_init(void)
 	test_fw_config->num_requests = TEST_FIRMWARE_NUM_REQS;
 	test_fw_config->send_uevent = true;
 	test_fw_config->into_buf = false;
+	test_fw_config->buf_size = TEST_FIRMWARE_BUF_SIZE;
+	test_fw_config->file_offset = 0;
+	test_fw_config->partial = false;
 	test_fw_config->sync_direct = false;
 	test_fw_config->req_firmware = request_firmware;
 	test_fw_config->test_result = 0;
@@ -253,6 +262,13 @@ static ssize_t config_show(struct device *dev,
 	len += scnprintf(buf+len, PAGE_SIZE - len,
 			"into_buf:\t\t%s\n",
 			test_fw_config->into_buf ? "true" : "false");
+	len += scnprintf(buf+len, PAGE_SIZE - len,
+			"buf_size:\t%zu\n", test_fw_config->buf_size);
+	len += scnprintf(buf+len, PAGE_SIZE - len,
+			"file_offset:\t%zu\n", test_fw_config->file_offset);
+	len += scnprintf(buf+len, PAGE_SIZE - len,
+			"partial:\t\t%s\n",
+			test_fw_config->partial ? "true" : "false");
 	len += scnprintf(buf+len, PAGE_SIZE - len,
 			"sync_direct:\t\t%s\n",
 			test_fw_config->sync_direct ? "true" : "false");
@@ -322,6 +338,39 @@ test_dev_config_show_bool(char *buf,
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 
+static int test_dev_config_update_size_t(const char *buf,
+					 size_t size,
+					 size_t *cfg)
+{
+	int ret;
+	long new;
+
+	ret = kstrtol(buf, 10, &new);
+	if (ret)
+		return ret;
+
+	if (new > SIZE_MAX)
+		return -EINVAL;
+
+	mutex_lock(&test_fw_mutex);
+	*(size_t *)cfg = new;
+	mutex_unlock(&test_fw_mutex);
+
+	/* Always return full write size even if we didn't consume all */
+	return size;
+}
+
+static ssize_t test_dev_config_show_size_t(char *buf, int cfg)
+{
+	size_t val;
+
+	mutex_lock(&test_fw_mutex);
+	val = cfg;
+	mutex_unlock(&test_fw_mutex);
+
+	return snprintf(buf, PAGE_SIZE, "%zu\n", val);
+}
+
 static ssize_t test_dev_config_show_int(char *buf, int cfg)
 {
 	int val;
@@ -419,6 +468,83 @@ static ssize_t config_into_buf_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(config_into_buf);
 
+static ssize_t config_buf_size_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	int rc;
+
+	mutex_lock(&test_fw_mutex);
+	if (test_fw_config->reqs) {
+		pr_err("Must call release_all_firmware prior to changing config\n");
+		rc = -EINVAL;
+		mutex_unlock(&test_fw_mutex);
+		goto out;
+	}
+	mutex_unlock(&test_fw_mutex);
+
+	rc = test_dev_config_update_size_t(buf, count,
+					   &test_fw_config->buf_size);
+
+out:
+	return rc;
+}
+
+static ssize_t config_buf_size_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	return test_dev_config_show_size_t(buf, test_fw_config->buf_size);
+}
+static DEVICE_ATTR_RW(config_buf_size);
+
+static ssize_t config_file_offset_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	int rc;
+
+	mutex_lock(&test_fw_mutex);
+	if (test_fw_config->reqs) {
+		pr_err("Must call release_all_firmware prior to changing config\n");
+		rc = -EINVAL;
+		mutex_unlock(&test_fw_mutex);
+		goto out;
+	}
+	mutex_unlock(&test_fw_mutex);
+
+	rc = test_dev_config_update_size_t(buf, count,
+					   &test_fw_config->file_offset);
+
+out:
+	return rc;
+}
+
+static ssize_t config_file_offset_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	return test_dev_config_show_size_t(buf, test_fw_config->file_offset);
+}
+static DEVICE_ATTR_RW(config_file_offset);
+
+static ssize_t config_partial_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	return test_dev_config_update_bool(buf,
+					   count,
+					   &test_fw_config->partial);
+}
+
+static ssize_t config_partial_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	return test_dev_config_show_bool(buf, test_fw_config->partial);
+}
+static DEVICE_ATTR_RW(config_partial);
+
 static ssize_t config_sync_direct_store(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t count)
@@ -613,18 +739,24 @@ static int test_fw_run_batch_request(void *data)
 
 	if (test_fw_config->into_buf) {
 		void *test_buf;
+		unsigned int pread_flags;
 
 		test_buf = kzalloc(TEST_FIRMWARE_BUF_SIZE, GFP_KERNEL);
 		if (!test_buf)
 			return -ENOSPC;
 
+		if (test_fw_config->partial)
+			pread_flags = KERNEL_PREAD_FLAG_PART;
+		else
+			pread_flags = KERNEL_PREAD_FLAG_WHOLE;
+
 		req->rc = request_firmware_into_buf(&req->fw,
 						    req->name,
 						    req->dev,
 						    test_buf,
-						    TEST_FIRMWARE_BUF_SIZE,
-						    0,
-						    KERNEL_PREAD_FLAG_WHOLE);
+						    test_fw_config->buf_size,
+						    test_fw_config->file_offset,
+						    pread_flags);
 		if (!req->fw)
 			kfree(test_buf);
 	} else {
@@ -897,6 +1029,9 @@ static struct attribute *test_dev_attrs[] = {
 	TEST_FW_DEV_ATTR(config_name),
 	TEST_FW_DEV_ATTR(config_num_requests),
 	TEST_FW_DEV_ATTR(config_into_buf),
+	TEST_FW_DEV_ATTR(config_buf_size),
+	TEST_FW_DEV_ATTR(config_file_offset),
+	TEST_FW_DEV_ATTR(config_partial),
 	TEST_FW_DEV_ATTR(config_sync_direct),
 	TEST_FW_DEV_ATTR(config_send_uevent),
 	TEST_FW_DEV_ATTR(config_read_fw_idx),
-- 
2.17.1

