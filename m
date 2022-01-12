Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA5248C7C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 17:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354896AbiALQA5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 11:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243611AbiALQA4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:00:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FC2C06173F;
        Wed, 12 Jan 2022 08:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=a4RIhYLvj6dtCIsbKBQiK7ICIr+8JBXqAej9bojJf5U=; b=JJdIuf9iYn0J00n8xs8HqcPuUj
        qegSAtyPzsNSae4+aOtQk0DrvXy0jWLqwAjnOWffLGmuP8Ob/o+o5NWghKzU2FLnhTfX6gT9IRv3H
        e1S8c88W09JKM1pxYZ/n2/rbEhGstuGMonlhiqQQ9kSiXHit0A+xeJ5YRC7huDpcm34/VebixaDYG
        Xw5Fo7OvTVfa76IcCm18zCAZ6T3YSAZ1AHnDACp4xjBlfFK589XjgZRRyPY3MhzBXlbSoNxqvkoGO
        TF7weNEVOEQ7B0cC7LLbihysmo69fqPEEs/yw87+gV2zW+FF8iDvhVMLm/yE2uUv8XOp3SA8dnA/E
        ObIfanrw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7g3R-0032J4-N0; Wed, 12 Jan 2022 16:00:53 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     gregkh@linuxfoundation.org, bp@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] firmware_loader: simplfy builtin or module check
Date:   Wed, 12 Jan 2022 08:00:53 -0800
Message-Id: <20220112160053.723795-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The existing check is outdated and confuses developers. Use the
already existing IS_REACHABLE() defined on kconfig.h which makes
the intention much clearer.

Reported-by: Borislav Petkov <bp@alien8.de>
Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/firmware.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index 3b057dfc8284..ec2ccfebef65 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -34,7 +34,7 @@ static inline bool firmware_request_builtin(struct firmware *fw,
 }
 #endif
 
-#if defined(CONFIG_FW_LOADER) || (defined(CONFIG_FW_LOADER_MODULE) && defined(MODULE))
+#if IS_REACHABLE(CONFIG_FW_LOADER)
 int request_firmware(const struct firmware **fw, const char *name,
 		     struct device *device);
 int firmware_request_nowarn(const struct firmware **fw, const char *name,
-- 
2.34.1

