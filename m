Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2E840FF42
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 20:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344540AbhIQSYs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 14:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344414AbhIQSYM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 14:24:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD25C061764;
        Fri, 17 Sep 2021 11:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Go1/KDXYjjqeM5NYs2EPZoks5Gkw4uiCOQWYdQBV8sM=; b=Fb5IllX9BA7pj1gVTNIw6W5co/
        OQd2O0dAt7UCsm62uQAc9xNWgZeJQ/28xEBQXfRe/SgtfVBErvF4tG08UL7X+GiE89EXbrV1ABUA9
        BzuDymOIrVCQDBOTzth+/kOTEfKqfOuC2JQ8LeDs/rf4oG4v2DQh/ryEfZ2Fd62KpGrmph4eGDDCb
        2N3TNzro0xMTYeiNNC3DDs3QMC34zq1IYoPDKFWsi84x04eMx4nft8r/IYUWG5evj9Ck8UW91afly
        DvD2eFLNd5aZNvSE3zNsUlYLXGtorwWT3vxj1mfBuZRV1ZZNsLZG5kirob4ELhbdpfN6i57TEaYIw
        CJFvDtDA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRIVI-00Ep5i-Ff; Fri, 17 Sep 2021 18:22:28 +0000
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
Subject: [PATCH 08/14] firmware_loader: move struct builtin_fw to the only place used
Date:   Fri, 17 Sep 2021 11:22:20 -0700
Message-Id: <20210917182226.3532898-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210917182226.3532898-1-mcgrof@kernel.org>
References: <20210917182226.3532898-1-mcgrof@kernel.org>
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
index 2af0e58f3f9f..0c78adb39110 100644
--- a/drivers/base/firmware_loader/builtin/main.c
+++ b/drivers/base/firmware_loader/builtin/main.c
@@ -4,6 +4,12 @@
 #include <linux/firmware.h>
 #include "../firmware.h"
 
+struct builtin_fw {
+	char *name;
+	void *data;
+	unsigned long size;
+};
+
 extern struct builtin_fw __start_builtin_fw[];
 extern struct builtin_fw __end_builtin_fw[];
 
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index 9f21a0db715f..7a948739decd 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -21,12 +21,6 @@ struct module;
 struct device;
 
 #ifdef CONFIG_FW_LOADER_BUILTIN
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

