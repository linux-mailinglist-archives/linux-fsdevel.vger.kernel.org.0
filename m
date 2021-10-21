Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C670E436708
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 17:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbhJUQBZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 12:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbhJUQBP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:01:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE4FC061224;
        Thu, 21 Oct 2021 08:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7YiB+SuUpWzxbgSIvfSKGbMNmP/IbBzCqpExhHLl7ZY=; b=rV6io0GkGTtXt7UbUYYeVsV3Zk
        sLPIKUcI3VVXoiB4nP9y/cJLhYSt6Wce28XpSA52rUxLopFx9zWQndwC4mYRCamShxx/Ut1HBPMXr
        fIe8pSvlQonN499a76/KW1/bSmb4KycyLcv2hzxaCvzIiVONNwUpAJmAGhj+mU5ccAh3jAS1ji9iP
        w395jKDB57wWX4H4FEs0hZ/Ma3mRfCGtupwmc3qIzOQVP2AadAL9VhIU5XxnE00QpmiRZxuD7ka+p
        7DCa82/3xXuKy7WosiEoFMTebGR2dLyfFd/ZEn6n+7hjdn384Vu87Kry17fyw8rJEkeMgcX222pTl
        k7UsCrXw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdaSq-008GM4-GP; Thu, 21 Oct 2021 15:58:44 +0000
From:   "Luis R. Rodriguez" <mcgrof@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     bp@suse.de, akpm@linux-foundation.org, josh@joshtriplett.org,
        rishabhb@codeaurora.org, kubakici@wp.pl, maco@android.com,
        david.brown@linaro.org, bjorn.andersson@linaro.org,
        linux-wireless@vger.kernel.org, keescook@chromium.org,
        shuah@kernel.org, mfuzzey@parkeon.com, zohar@linux.vnet.ibm.com,
        dhowells@redhat.com, pali.rohar@gmail.com, tiwai@suse.de,
        arend.vanspriel@broadcom.com, zajec5@gmail.com, nbroeking@me.com,
        broonie@kernel.org, dmitry.torokhov@gmail.com, dwmw2@infradead.org,
        torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
        jewalt@lgsinnovations.com, cantabile.desu@gmail.com, ast@fb.com,
        andresx7@gmail.com, dan.rue@linaro.org, brendanhiggins@google.com,
        yzaikin@google.com, sfr@canb.auug.org.au, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 04/10] firmware_loader: move struct builtin_fw to the only place used
Date:   Thu, 21 Oct 2021 08:58:37 -0700
Message-Id: <20211021155843.1969401-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211021155843.1969401-1-mcgrof@kernel.org>
References: <20211021155843.1969401-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

Now that x86 doesn't abuse picking at internals to the firmware
loader move out the built-in firmware struct to its only user.

Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/base/firmware_loader/builtin/main.c | 6 ++++++
 include/linux/firmware.h                    | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/firmware_loader/builtin/main.c b/drivers/base/firmware_loader/builtin/main.c
index d85626b2fdf5..a065c3150897 100644
--- a/drivers/base/firmware_loader/builtin/main.c
+++ b/drivers/base/firmware_loader/builtin/main.c
@@ -7,6 +7,12 @@
 /* Only if FW_LOADER=y */
 #ifdef CONFIG_FW_LOADER
 
+struct builtin_fw {
+	char *name;
+	void *data;
+	unsigned long size;
+};
+
 extern struct builtin_fw __start_builtin_fw[];
 extern struct builtin_fw __end_builtin_fw[];
 
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index 34e8d5844fa0..3b057dfc8284 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -25,12 +25,6 @@ struct device;
  * FW_LOADER=m
  */
 #ifdef CONFIG_FW_LOADER
-struct builtin_fw {
-	char *name;
-	void *data;
-	unsigned long size;
-};
-
 bool firmware_request_builtin(struct firmware *fw, const char *name);
 #else
 static inline bool firmware_request_builtin(struct firmware *fw,
-- 
2.30.2

