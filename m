Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBBA48BD53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 03:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348829AbiALCeT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 21:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348820AbiALCeS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:34:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF37C06173F;
        Tue, 11 Jan 2022 18:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=lAmMImhY7cLXv0Zia2nBSBgJ5zwPiW79XSAGp7Fylqc=; b=cqsOZ3UM1DSQIKpcTX0Pl8Izb4
        yW1auuGqF5kEOtmIsKnR/JHohfUIwoeixZF8JcSdH7l4ny4+EXCpRe3m+g34aZ7+0Y9srKVutJjWq
        wiJIwHI7HyH6YsQhhR9JmYLbEe9uSHEN6mI8FLoWuxJkID58hq+9RPYzNiQB3V+f85qbUCoZN6Wfe
        zfm7xNoYmyGvzGcaNIkP9gRFchkLz8Uy7AuoJilY6lAdFNBJaLTMtGFi8QX7i3KSx8CMMH/pob/cj
        uBcRBPxx95VZEVQUxKw4gEsZgjjzMTvkyFIphFi5IKQmEAaGUzhhFHcjnNtOsg7v3KNzPCPC5IatQ
        3ErZseRQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7TSr-000u7T-Hv; Wed, 12 Jan 2022 02:34:17 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     gregkh@linuxfoundation.org, bp@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH] firmware_loader: simplfy builtin or module check
Date:   Tue, 11 Jan 2022 18:34:16 -0800
Message-Id: <20220112023416.215644-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The existing check is outdated and confuses developers. Use the
already existing IS_ENABLED() defined on kconfig.h which makes
the intention much clearer.

Reported-by: Borislav Petkov <bp@alien8.de>
Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/firmware.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index 3b057dfc8284..fa3493dbe84a 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -34,7 +34,7 @@ static inline bool firmware_request_builtin(struct firmware *fw,
 }
 #endif
 
-#if defined(CONFIG_FW_LOADER) || (defined(CONFIG_FW_LOADER_MODULE) && defined(MODULE))
+#if IS_ENABLED(CONFIG_FW_LOADER)
 int request_firmware(const struct firmware **fw, const char *name,
 		     struct device *device);
 int firmware_request_nowarn(const struct firmware **fw, const char *name,
-- 
2.34.1

