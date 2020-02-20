Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABF011653C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 01:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgBTAst (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 19:48:49 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54118 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbgBTAss (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 19:48:48 -0500
Received: by mail-pj1-f68.google.com with SMTP id n96so123474pjc.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2020 16:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1vZUwbK1p/l0BmkVh8fQjfkP2CW4vgl3dyidM1dNgAg=;
        b=Zd6c6RWz61quAyM09lFToG+rLQNQkLxsbwInvxizF6zUY0AY3qjs9ePf+NAJ7R1LE9
         uaNhVPMqMU8o9k/xgTvraAbid7xE80LEPk/VLSDxpKS/Swdn9oAXPo/wdg+GS5qyu3bw
         C00Es6h+BsEcgtjvkV4/JdTkO7oVwLCjzujfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1vZUwbK1p/l0BmkVh8fQjfkP2CW4vgl3dyidM1dNgAg=;
        b=e7UUVuQtZCBDcAtPNDso0eGeKbwCoq77sL4ZFsZ+I8fHXn4+exSfJGF2gbN4c4SR2D
         5cKrLb/Waw/Zlepo1p6SWerGi+5+tLQdRl26f15MPdCaJN7M1OeodIR7HUtR1plB2QAt
         +osX1nWijddEljie3VgfWCyQ6qOqnZf3MIRthbH/TVpzHDZZRxn5/aPTgK72aR68wPsx
         ZPKpEBWwkFVlP+ZjlAG/0xq/MJaVte4HS0lYDslnRwBYU3ninfssl42SWBuC7+9CR9fB
         uIB4B7kIE5uoYCszMYB76B7OeZ+D1KZNY1SceqgavlOEMG4Kf7sQPxcU0RnvFiLTk4s9
         297w==
X-Gm-Message-State: APjAAAWpJPjDO39sywW0B+rkbqc/G8i+GOakuRtFt92wyouGajlgTdnR
        asBlN2lEB0nih99jVL4VzJ4+7w==
X-Google-Smtp-Source: APXvYqwlXs0/Vy87G6Z0QVBAFYMleqQm7wAipCZQyNLE3Qlivl2QulbcDPKr2GPIkQ8ytGKqO5W15A==
X-Received: by 2002:a17:902:8647:: with SMTP id y7mr28627552plt.224.1582159727648;
        Wed, 19 Feb 2020 16:48:47 -0800 (PST)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 64sm816323pfd.48.2020.02.19.16.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 16:48:47 -0800 (PST)
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
        Andy Gross <agross@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v2 3/7] test_firmware: add partial read support for request_firmware_into_buf
Date:   Wed, 19 Feb 2020 16:48:21 -0800
Message-Id: <20200220004825.23372-4-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220004825.23372-1-scott.branden@broadcom.com>
References: <20200220004825.23372-1-scott.branden@broadcom.com>
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

