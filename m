Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC1540FF32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 20:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344501AbhIQSYQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 14:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344380AbhIQSYI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 14:24:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75582C061574;
        Fri, 17 Sep 2021 11:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=C6YoTJio2JJPviAT+lMOgCbn00AxJ3TaPTyT+Yh3YZQ=; b=IJ2JLglUvnZwPSc1ZlUZfS4ioP
        WK6gyLTep0KUa/QICf09nDXKcUj/SgGm9Ylhy3FFGUsDikQ0H8aW/N53Pj5ZLzIh6QQCapobBK2Id
        w/6Nah9ZeQTuKdF31UmVgv7RBbmjBb2eVF+RDOvbNPMcgIfDYQnQu0WWCvEnKeFGdkm+dWapYfyZL
        pKalDwExdpsGsFXIPhGegHY1HXsxPrd7skl24r81GQtIpL85kfIV3Z+glNetfuxVmq5ZItL8MFWso
        gPigO0vS89t/rPrAiJogD5dpXYxozY6iye4YIloNDOCSG5W7pcy/+D8FkG2m4eVVyy219IQWc8PNo
        vOMlnY3Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRIVI-00Ep5a-D2; Fri, 17 Sep 2021 18:22:28 +0000
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
Subject: [PATCH 06/14] firmware_loader: remove old DECLARE_BUILTIN_FIRMWARE()
Date:   Fri, 17 Sep 2021 11:22:18 -0700
Message-Id: <20210917182226.3532898-7-mcgrof@kernel.org>
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

This was never used upstream. Time to get rid of it. We
don't carry around unused baggage.

Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/firmware.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index 29d17a05ead6..9f21a0db715f 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -28,19 +28,6 @@ struct builtin_fw {
 };
 
 bool firmware_request_builtin(struct firmware *fw, const char *name);
-
-/* We have to play tricks here much like stringify() to get the
-   __COUNTER__ macro to be expanded as we want it */
-#define __fw_concat1(x, y) x##y
-#define __fw_concat(x, y) __fw_concat1(x, y)
-
-#define DECLARE_BUILTIN_FIRMWARE(name, blob)				     \
-	DECLARE_BUILTIN_FIRMWARE_SIZE(name, &(blob), sizeof(blob))
-
-#define DECLARE_BUILTIN_FIRMWARE_SIZE(name, blob, size)			     \
-	static const struct builtin_fw __fw_concat(__builtin_fw,__COUNTER__) \
-	__used __section(".builtin_fw") = { name, blob, size }
-
 #else
 static inline bool firmware_request_builtin(struct firmware *fw,
 					    const char *name)
-- 
2.30.2

