Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375F61A8FB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 02:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634586AbgDOAZj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 20:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634579AbgDOAZf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 20:25:35 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2563C061A0F
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2020 17:25:35 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t16so591213plo.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2020 17:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Y4P8rWiotzQvb4JxyUfpgXR3sblXTGBUlf8HwRLY7Kc=;
        b=AsYJABa9hWEbNsCLZkMt/OCoNzfNwn/PFH5DvXWcOFmj0zSxjoT9Xj7gjW0EwgQqeg
         2YtAplcWXxOBgTdg1AhsL1QHgA7fYSSgofdbx395pC9kP74ENeJrHlA2WZsiqsvt3lQt
         KQSry7u4otle1WPyN5l08+Ebf6aMQ1NA1mC/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y4P8rWiotzQvb4JxyUfpgXR3sblXTGBUlf8HwRLY7Kc=;
        b=HUS8Jdpo0w9qfhJ32ERdWJFmxQBIObvnB+3+tJvK7mcdE8ddkFSNZ2hzmoykjmfbiE
         yFvFhJhn4qoYrICm5an9kNs3DBsGrQ0MIbJ2UaxQNZJRMmXQMlHH7DrQlydGvRXarSBp
         YPiSfQvI4zK29VATvTfBwrysc/EGWRYAbnl/4SnNwK7ewVNR0JPOzCe10znMEM8anBCy
         Kxn1fWU9pjIJBE6JdFngnbDa7Rotb9hQ8XGXTwicqntnDEkwHsEb6RYRag8O3K0Jldlz
         v0fsVVs2xi2qG4eJpcPajZ7NsoFw/rwa8AwLt+dEm+GebBITqMLHy3I9aOeIZjT/Lpj9
         tiow==
X-Gm-Message-State: AGi0PuZGnXGRWqls5KUEe72HK/b1OAeL7YhKzfDL6R+R/BuIrAxiGj00
        xzpvrGYD9IS+76aXgi4ssDCTvw==
X-Google-Smtp-Source: APiQypKGHCKpDkSFeTfwGA6QewjHHXSq+/zD/8rw7FSMGD7U7vonI+gEQq9MYBJNXyMNe4BdWpsLtg==
X-Received: by 2002:a17:90a:c304:: with SMTP id g4mr3029358pjt.157.1586910334896;
        Tue, 14 Apr 2020 17:25:34 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id z7sm2878341pff.47.2020.04.14.17.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 17:25:34 -0700 (PDT)
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
Subject: [PATCH] test_firmware: remove unnecessary test_fw_mutex in test_dev_config_show_xxx
Date:   Tue, 14 Apr 2020 17:25:17 -0700
Message-Id: <20200415002517.4328-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove unnecessary use of test_fw_mutex in test_dev_config_show_xxx
functions that show simple bool, int, and u8.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 lib/test_firmware.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 0c7fbcf07ac5..9fee2b93a8d1 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -310,27 +310,13 @@ static int test_dev_config_update_bool(const char *buf, size_t size,
 	return ret;
 }
 
-static ssize_t
-test_dev_config_show_bool(char *buf,
-			  bool config)
+static ssize_t test_dev_config_show_bool(char *buf, bool val)
 {
-	bool val;
-
-	mutex_lock(&test_fw_mutex);
-	val = config;
-	mutex_unlock(&test_fw_mutex);
-
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 
-static ssize_t test_dev_config_show_int(char *buf, int cfg)
+static ssize_t test_dev_config_show_int(char *buf, int val)
 {
-	int val;
-
-	mutex_lock(&test_fw_mutex);
-	val = cfg;
-	mutex_unlock(&test_fw_mutex);
-
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 
@@ -354,14 +340,8 @@ static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
 	return size;
 }
 
-static ssize_t test_dev_config_show_u8(char *buf, u8 cfg)
+static ssize_t test_dev_config_show_u8(char *buf, u8 val)
 {
-	u8 val;
-
-	mutex_lock(&test_fw_mutex);
-	val = cfg;
-	mutex_unlock(&test_fw_mutex);
-
 	return snprintf(buf, PAGE_SIZE, "%u\n", val);
 }
 
-- 
2.17.1

