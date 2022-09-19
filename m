Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE775BD395
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 19:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiISRY7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 13:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiISRY4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:24:56 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033C912741;
        Mon, 19 Sep 2022 10:24:55 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id q9so18235389pgq.8;
        Mon, 19 Sep 2022 10:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=dm/xj3UCM5GDvqsqEmDruuZjxjQYqmvO/RJqSynJbxs=;
        b=Gl7e0Yg8ZgFENkMxqlZEodWfUspPOUzXA6vlgpyAT3PfrxXQj5hHyjBXcOEztaOxX4
         Cit0Qg+NsaiJdZzLZeDbyx+dco7v0P1bMKAkFi7i5QYrOPC60VSzMUSJ0blRa5Y7I333
         BgCxp/EKma8OPzoa0oz/JFpLSbSggbELy21Kzyg8/PabTrvZ2SXGuWb8vpHEbZMSOswd
         DkmGSS+NjD9cVPrK/i2CnS1/MOoI8DigrnVgC6EFYnR1Yi8MTEsNZN7DqGmH5OibfzW+
         EOIO7EPrnROJDtqPZvzmqKnXDdC18pi31j2HFmF499FCJTH/eEspslCg7QWyejU6JmZH
         gbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dm/xj3UCM5GDvqsqEmDruuZjxjQYqmvO/RJqSynJbxs=;
        b=ooqGRp+q5IkCEcTu0FvpPiSW40RlUo/7oIwKGFKLqQoAq0u0BZwD/5ZlS3CJfLXdJi
         mmhTJWq2LelQTr088JHclsMCATe+jHzSM7PnN9NdShlNC4tokY01FNcmPwn+xvGU+fCL
         Rc6n2hucBL0RbzLdu11JUvZmW3udSrUQVH6xagTZZg1bbDrGLAbM5K04WNC34QXq3y/M
         Ve01PRxEgPEMZjssm8yJK6HdAURbX+mIquFwXk8/V0ZqtwfLdV/O1mrUmsCiz92he6Yi
         KAfQ7QIMwMMvqxza7nWrXVMhZMX6dCF1mjbLjRx3T4SVGOArbY5MrC5pS+q4fYeYSqS6
         nXpQ==
X-Gm-Message-State: ACrzQf3FiqLvFKFJR5a+Dtq3E9+QUkoXR/fNTQy6kEo3TGZTw0lX80Eb
        kmGHG4bLA6qoWbi6BtfX14hZsJsMHLA=
X-Google-Smtp-Source: AMsMyM77MWJIoSfL+bJOQIrJOo1UxqGAj8MBR0N1o9UjBpDSOUGMPeEtRSXnUeklW0hsy/M0CYwu2A==
X-Received: by 2002:a63:c3:0:b0:439:72d7:7e1f with SMTP id 186-20020a6300c3000000b0043972d77e1fmr16248074pga.524.1663608294102;
        Mon, 19 Sep 2022 10:24:54 -0700 (PDT)
Received: from localhost.localdomain (KD027092233113.ppp-bb.dion.ne.jp. [27.92.233.113])
        by smtp.gmail.com with ESMTPSA id h7-20020aa796c7000000b0053f2505318asm21226480pfq.142.2022.09.19.10.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 10:24:53 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, corbet@lwn.net, david@redhat.com,
        osalvador@suse.de, shuah@kernel.org,
        Zhao Gongyi <zhaogongyi@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        akpm@linux-foundation.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 1/3] libfs: add DEFINE_SIMPLE_ATTRIBUTE_SIGNED for signed value
Date:   Tue, 20 Sep 2022 02:24:16 +0900
Message-Id: <20220919172418.45257-2-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220919172418.45257-1-akinobu.mita@gmail.com>
References: <20220919172418.45257-1-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The simple attribute files do not accept a negative value since the
commit 488dac0c9237 ("libfs: fix error cast of negative value in
simple_attr_write()"), so we have to use a 64-bit value to write a
negative value.

This adds DEFINE_SIMPLE_ATTRIBUTE_SIGNED for a signed value.

Fixes: 488dac0c9237 ("libfs: fix error cast of negative value in simple_attr_write()")
Reported-by: Zhao Gongyi <zhaogongyi@huawei.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 fs/libfs.c         | 22 +++++++++++++++++++---
 include/linux/fs.h | 12 ++++++++++--
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 31b0ddf01c31..76fb29a103a2 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -994,8 +994,8 @@ ssize_t simple_attr_read(struct file *file, char __user *buf,
 EXPORT_SYMBOL_GPL(simple_attr_read);
 
 /* interpret the buffer as a number to call the set function with */
-ssize_t simple_attr_write(struct file *file, const char __user *buf,
-			  size_t len, loff_t *ppos)
+static ssize_t simple_attr_write_xsigned(struct file *file, const char __user *buf,
+			  size_t len, loff_t *ppos, bool is_signed)
 {
 	struct simple_attr *attr;
 	unsigned long long val;
@@ -1016,7 +1016,10 @@ ssize_t simple_attr_write(struct file *file, const char __user *buf,
 		goto out;
 
 	attr->set_buf[size] = '\0';
-	ret = kstrtoull(attr->set_buf, 0, &val);
+	if (is_signed)
+		ret = kstrtoll(attr->set_buf, 0, &val);
+	else
+		ret = kstrtoull(attr->set_buf, 0, &val);
 	if (ret)
 		goto out;
 	ret = attr->set(attr->data, val);
@@ -1026,8 +1029,21 @@ ssize_t simple_attr_write(struct file *file, const char __user *buf,
 	mutex_unlock(&attr->mutex);
 	return ret;
 }
+
+ssize_t simple_attr_write(struct file *file, const char __user *buf,
+			  size_t len, loff_t *ppos)
+{
+	return simple_attr_write_xsigned(file, buf, len, ppos, false);
+}
 EXPORT_SYMBOL_GPL(simple_attr_write);
 
+ssize_t simple_attr_write_signed(struct file *file, const char __user *buf,
+			  size_t len, loff_t *ppos)
+{
+	return simple_attr_write_xsigned(file, buf, len, ppos, true);
+}
+EXPORT_SYMBOL_GPL(simple_attr_write_signed);
+
 /**
  * generic_fh_to_dentry - generic helper for the fh_to_dentry export operation
  * @sb:		filesystem to do the file handle conversion on
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9eced4cc286e..c79138818922 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3471,7 +3471,7 @@ void simple_transaction_set(struct file *file, size_t n);
  * All attributes contain a text representation of a numeric value
  * that are accessed with the get() and set() functions.
  */
-#define DEFINE_SIMPLE_ATTRIBUTE(__fops, __get, __set, __fmt)		\
+#define DEFINE_SIMPLE_ATTRIBUTE_XSIGNED(__fops, __get, __set, __fmt, __is_signed)	\
 static int __fops ## _open(struct inode *inode, struct file *file)	\
 {									\
 	__simple_attr_check_format(__fmt, 0ull);			\
@@ -3482,10 +3482,16 @@ static const struct file_operations __fops = {				\
 	.open	 = __fops ## _open,					\
 	.release = simple_attr_release,					\
 	.read	 = simple_attr_read,					\
-	.write	 = simple_attr_write,					\
+	.write	 = (__is_signed) ? simple_attr_write_signed : simple_attr_write,	\
 	.llseek	 = generic_file_llseek,					\
 }
 
+#define DEFINE_SIMPLE_ATTRIBUTE(__fops, __get, __set, __fmt)		\
+	DEFINE_SIMPLE_ATTRIBUTE_XSIGNED(__fops, __get, __set, __fmt, false)
+
+#define DEFINE_SIMPLE_ATTRIBUTE_SIGNED(__fops, __get, __set, __fmt)	\
+	DEFINE_SIMPLE_ATTRIBUTE_XSIGNED(__fops, __get, __set, __fmt, true)
+
 static inline __printf(1, 2)
 void __simple_attr_check_format(const char *fmt, ...)
 {
@@ -3500,6 +3506,8 @@ ssize_t simple_attr_read(struct file *file, char __user *buf,
 			 size_t len, loff_t *ppos);
 ssize_t simple_attr_write(struct file *file, const char __user *buf,
 			  size_t len, loff_t *ppos);
+ssize_t simple_attr_write_signed(struct file *file, const char __user *buf,
+				 size_t len, loff_t *ppos);
 
 struct ctl_table;
 int __init list_bdev_fs_names(char *buf, size_t size);
-- 
2.34.1

