Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4804366F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 17:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbhJUQBP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 12:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhJUQBP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:01:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04112C061348;
        Thu, 21 Oct 2021 08:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rHoTJjYWMdAiapE2XRg3xLJcB1bcn01nx+1c6y3EDeQ=; b=LO+V5ESHFJAxWWwrJFBS7d2p36
        Blz/PkXiDj2bnFiPVfa7wOY8AF2C05wZ4ln7FW9Mdo2z6uFffTBJykCcVD48pTrpsPcKQ/MoRSYzp
        fak90Q4LIV9DUrzov33Chyhp62QXBbaF1r+TRxX7JjW+kgrSjqtXKuZNTeGUIem34KySR4Z2VEO8t
        U1huuWJ/OMEQ1aF52yjWgYRgt6yGEry/rCmVSS6X5UcPmxH6azBmiR4WW0r+weNbHxMyMzPtKnkEj
        lwHfaHM13/b+45LydAnKUSyDdt+7zKRqaSX0E68X3lmrfDFJ7FhFbLIkXyaBxmSyyIoDraujZZ3Bm
        xQimJa9A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdaSq-008GM0-Ce; Thu, 21 Oct 2021 15:58:44 +0000
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
Subject: [PATCH v2 02/10] firmware_loader: remove old DECLARE_BUILTIN_FIRMWARE()
Date:   Thu, 21 Oct 2021 08:58:35 -0700
Message-Id: <20211021155843.1969401-3-mcgrof@kernel.org>
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

This was never used upstream. Time to get rid of it. We
don't carry around unused baggage.

Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/firmware.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index d743a8d1c2fe..34e8d5844fa0 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -32,19 +32,6 @@ struct builtin_fw {
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

