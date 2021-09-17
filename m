Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981F840FF23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 20:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344445AbhIQSYO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 14:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344382AbhIQSYJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 14:24:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28CAC061757;
        Fri, 17 Sep 2021 11:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mKzIRlwB1vttNdxDwilSgA4QCORfxzhGeRWQQTM2hHY=; b=Jqz9nxvGRM6kbFIYuCNUdRqhKM
        PWUbRkX+hRjiQ98/k5/NVzHov8XkBj9gkoDGMpntd1lYRAw8Hxgx/Pe8cm/zV+DyG/BUChfF7RvkY
        O5uft/Wpt6ytZMTZm2DQYT/Jd9fLcjb6/1JzGnPcgEBBgeWNheUn8aPhkDqlbUkEOzvpfclVa0Iby
        oQ2HE2jREcrQ3KrccbuvhjNo58wA9/pUOtMvlqQ/+14VJWd88e2PyC/MK/asPxt0jVETElr/jNQ8x
        i79GK+d0xZ7H8woZXhoVPxo9wxSbpQRiKxGP6qk5+qKnNiyR2HNaJxw+vWoBzljsWeNh5pA+lP/BO
        XvUeVXmg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRIVI-00Ep5S-2r; Fri, 17 Sep 2021 18:22:28 +0000
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
Subject: [PATCH 02/14] firmware_loader: split built-in firmware call
Date:   Fri, 17 Sep 2021 11:22:14 -0700
Message-Id: <20210917182226.3532898-3-mcgrof@kernel.org>
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

There are two ways the firmware_loader can use the built-in
firmware: with or without the pre-allocated buffer. We already
have one explicit use case for each of these, and so split them
up so that it is clear what the intention is on the caller side.

This also paves the way so that eventually other callers outside
of the firmware loader can uses these if and when needed.

While at it, adopt the firmware prefix for the routine names.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/base/firmware_loader/main.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index ef904b8b112e..eb4085b92ad4 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -111,8 +111,7 @@ static bool fw_copy_to_prealloc_buf(struct firmware *fw,
 	return true;
 }
 
-static bool fw_get_builtin_firmware(struct firmware *fw, const char *name,
-				    void *buf, size_t size)
+static bool firmware_request_builtin(struct firmware *fw, const char *name)
 {
 	struct builtin_fw *b_fw;
 
@@ -120,13 +119,21 @@ static bool fw_get_builtin_firmware(struct firmware *fw, const char *name,
 		if (strcmp(name, b_fw->name) == 0) {
 			fw->size = b_fw->size;
 			fw->data = b_fw->data;
-			return fw_copy_to_prealloc_buf(fw, buf, size);
+			return true;
 		}
 	}
 
 	return false;
 }
 
+static bool firmware_request_builtin_buf(struct firmware *fw, const char *name,
+					 void *buf, size_t size)
+{
+	if (!firmware_request_builtin(fw, name))
+		return false;
+	return fw_copy_to_prealloc_buf(fw, buf, size);
+}
+
 static bool fw_is_builtin_firmware(const struct firmware *fw)
 {
 	struct builtin_fw *b_fw;
@@ -140,9 +147,15 @@ static bool fw_is_builtin_firmware(const struct firmware *fw)
 
 #else /* Module case - no builtin firmware support */
 
-static inline bool fw_get_builtin_firmware(struct firmware *fw,
-					   const char *name, void *buf,
-					   size_t size)
+static inline bool firmware_request_builtin(struct firmware *fw,
+					    const char *name)
+{
+	return false;
+}
+
+static inline bool firmware_request_builtin_buf(struct firmware *fw,
+						const char *name, void *buf,
+						size_t size)
 {
 	return false;
 }
@@ -737,7 +750,7 @@ _request_firmware_prepare(struct firmware **firmware_p, const char *name,
 		return -ENOMEM;
 	}
 
-	if (fw_get_builtin_firmware(firmware, name, dbuf, size)) {
+	if (firmware_request_builtin_buf(firmware, name, dbuf, size)) {
 		dev_dbg(device, "using built-in %s\n", name);
 		return 0; /* assigned */
 	}
@@ -1216,7 +1229,7 @@ static int uncache_firmware(const char *fw_name)
 
 	pr_debug("%s: %s\n", __func__, fw_name);
 
-	if (fw_get_builtin_firmware(&fw, fw_name, NULL, 0))
+	if (firmware_request_builtin(&fw, fw_name))
 		return 0;
 
 	fw_priv = lookup_fw_priv(fw_name);
-- 
2.30.2

