Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90AF299F0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 20:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390222AbfHVSkZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 14:40:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45888 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390889AbfHVSkZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 14:40:25 -0400
Received: by mail-pl1-f196.google.com with SMTP id y8so3939027plr.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2019 11:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lYGkVfgdG8WRzMSOSXUmf210tXXkOroI8nnPLd8JCQ0=;
        b=Csn2107hyha4ovBxdi2LyqceP7uLoem1wsnEA+3piaO8X19bZNx4C08VXdTuEm0SYo
         uBQfFmHDxb82QakDPYJlN3IjPWjGcWRJRC2NDKhyKSDXDxBOAbJYsSEFhiEBUXZ0ac2h
         n8i6fI5lMb+Qyk09wgnifo785dbIIoIgbXwJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lYGkVfgdG8WRzMSOSXUmf210tXXkOroI8nnPLd8JCQ0=;
        b=XMS0sAvKfQPdtsi8Blnmv+uApXVSSexVpuHMDvLsjfuRTWLeyQFCMxnFaHH2Eonry3
         aLnUlxaNFxDdCtFVzwJDigQAxsrc8tgelIHMxDWCvYaZX9ulJFRP6iZk9Q+7vfdShJ4O
         lr/YnoWjb4SZjcBhmyh3T0EDVwLSiJsAzx7lxdWjhjjx3RDyKKuJlPJ+9Zj8/QJKM0xy
         SKzlx+cDdhb7lWz+wTMw/7/JFohsxAP26Q5yTfXO0zoec5O15gqN4DojYvO2uRC+bsmU
         FeHMEaMnCaMWD8KrZnhM1EXpfCyW1r42h2HyqCtfH71G9Oq256OkcA79cB1U5ltVWCt+
         NF4w==
X-Gm-Message-State: APjAAAVW1N+9uVMaiUeU7NmRXHO2g6EriO40P69QhCeODhkjxMySsXSQ
        M11k07pQ+6yPRO8MT+VFNIEGbg==
X-Google-Smtp-Source: APXvYqyWaujh3qVQxjy/+0B1mF00KjxVRj0dvRQ2YXKDUO/+piE/HhL5BpRlp+WbkIAfEd/oMhd7sg==
X-Received: by 2002:a17:902:b593:: with SMTP id a19mr254399pls.110.1566499223688;
        Thu, 22 Aug 2019 11:40:23 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id z19sm51056pgv.35.2019.08.22.11.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 11:40:23 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org
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
Subject: [PATCH v2 1/2] test_firmware: add support for request_firmware_into_buf
Date:   Thu, 22 Aug 2019 11:40:04 -0700
Message-Id: <20190822184005.901-2-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190822184005.901-1-scott.branden@broadcom.com>
References: <20190822184005.901-1-scott.branden@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add test config into_buf to allow request_firmware_into_buf to be
called instead of request_firmware/request_firmware_direct.  The number
of parameters differ calling request_firmware_into_buf and support
has not been added to test such api in test_firmware until now.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
---
 lib/test_firmware.c | 50 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 6ca97a63b3d6..251213c872b5 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -18,6 +18,7 @@
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/delay.h>
@@ -26,6 +27,7 @@
 
 #define TEST_FIRMWARE_NAME	"test-firmware.bin"
 #define TEST_FIRMWARE_NUM_REQS	4
+#define TEST_FIRMWARE_BUF_SIZE	SZ_1K
 
 static DEFINE_MUTEX(test_fw_mutex);
 static const struct firmware *test_firmware;
@@ -45,6 +47,8 @@ struct test_batched_req {
  * test_config - represents configuration for the test for different triggers
  *
  * @name: the name of the firmware file to look for
+ * @into_buf: when the into_buf is used if this is true
+ *	request_firmware_into_buf() will be used instead.
  * @sync_direct: when the sync trigger is used if this is true
  *	request_firmware_direct() will be used instead.
  * @send_uevent: whether or not to send a uevent for async requests
@@ -83,6 +87,7 @@ struct test_batched_req {
  */
 struct test_config {
 	char *name;
+	bool into_buf;
 	bool sync_direct;
 	bool send_uevent;
 	u8 num_requests;
@@ -176,6 +181,7 @@ static int __test_firmware_config_init(void)
 
 	test_fw_config->num_requests = TEST_FIRMWARE_NUM_REQS;
 	test_fw_config->send_uevent = true;
+	test_fw_config->into_buf = false;
 	test_fw_config->sync_direct = false;
 	test_fw_config->req_firmware = request_firmware;
 	test_fw_config->test_result = 0;
@@ -244,6 +250,9 @@ static ssize_t config_show(struct device *dev,
 			test_fw_config->send_uevent ?
 			"FW_ACTION_HOTPLUG" :
 			"FW_ACTION_NOHOTPLUG");
+	len += scnprintf(buf+len, PAGE_SIZE - len,
+			"into_buf:\t\t%s\n",
+			test_fw_config->into_buf ? "true" : "false");
 	len += scnprintf(buf+len, PAGE_SIZE - len,
 			"sync_direct:\t\t%s\n",
 			test_fw_config->sync_direct ? "true" : "false");
@@ -393,6 +402,23 @@ static ssize_t config_num_requests_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(config_num_requests);
 
+static ssize_t config_into_buf_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	return test_dev_config_update_bool(buf,
+					   count,
+					   &test_fw_config->into_buf);
+}
+
+static ssize_t config_into_buf_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	return test_dev_config_show_bool(buf, test_fw_config->into_buf);
+}
+static DEVICE_ATTR_RW(config_into_buf);
+
 static ssize_t config_sync_direct_store(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t count)
@@ -522,7 +548,7 @@ static ssize_t trigger_async_request_store(struct device *dev,
 		rc = count;
 	} else {
 		pr_err("failed to async load firmware\n");
-		rc = -ENODEV;
+		rc = -ENOMEM;
 	}
 
 out:
@@ -585,7 +611,26 @@ static int test_fw_run_batch_request(void *data)
 		return -EINVAL;
 	}
 
-	req->rc = test_fw_config->req_firmware(&req->fw, req->name, req->dev);
+	if (test_fw_config->into_buf) {
+		void *test_buf;
+
+		test_buf = kzalloc(TEST_FIRMWARE_BUF_SIZE, GFP_KERNEL);
+		if (!test_buf)
+			return -ENOSPC;
+
+		req->rc = request_firmware_into_buf(&req->fw,
+						    req->name,
+						    req->dev,
+						    test_buf,
+						    TEST_FIRMWARE_BUF_SIZE);
+		if (!req->fw)
+			kfree(test_buf);
+	} else {
+		req->rc = test_fw_config->req_firmware(&req->fw,
+						       req->name,
+						       req->dev);
+	}
+
 	if (req->rc) {
 		pr_info("#%u: batched sync load failed: %d\n",
 			req->idx, req->rc);
@@ -849,6 +894,7 @@ static struct attribute *test_dev_attrs[] = {
 	TEST_FW_DEV_ATTR(config),
 	TEST_FW_DEV_ATTR(config_name),
 	TEST_FW_DEV_ATTR(config_num_requests),
+	TEST_FW_DEV_ATTR(config_into_buf),
 	TEST_FW_DEV_ATTR(config_sync_direct),
 	TEST_FW_DEV_ATTR(config_send_uevent),
 	TEST_FW_DEV_ATTR(config_read_fw_idx),
-- 
2.17.1

