Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1567F730FDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 08:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244472AbjFOGut (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 02:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244612AbjFOGuC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:50:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FA61FC7;
        Wed, 14 Jun 2023 23:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=V3Zi4OuP05OwrLUjviLbjWEGaDIhmE++VTkqI7eipN0=; b=rTMswB3Udn5f0fpenAg3ggGptC
        TWSadr3J82UF0YNck4zRHtVR5l/IzqMxqo4W5yDDErZWw55Qy+pMiwgkpBlVECvfMNVPJ5oyflVQj
        zW86mOBzE5c6kI12wJoM64w286x5yqP3HeyG1N16ogXAVhpuMrNHN/Qp44is5eA3E27JmVCbSTAFJ
        yDPK+U1i7VuX8hpu2TRL2u4UQQ+bBjsy/5wOzQvK5f/MjH1ZbmWkz0akXj9d5Jj0DL4gAa/rOyc4P
        ER5zJGP5sLhTW/RMKY/IymsSg/10m4bbORPhyjpWMmZG21oW/oN/5WxTBxC+yLisuXbfipKG8tMOa
        T8KzCDtA==;
Received: from 2a02-8389-2341-5b80-8c8c-28f8-1274-e038.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8c8c:28f8:1274:e038] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9gn7-00DuCB-0D;
        Thu, 15 Jun 2023 06:49:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/11] md: deprecate bitmap file support
Date:   Thu, 15 Jun 2023 08:48:40 +0200
Message-Id: <20230615064840.629492-12-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615064840.629492-1-hch@lst.de>
References: <20230615064840.629492-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The support for bitmaps on files is a very bad idea abusing various kernel
APIs, and fundamentally requires the file to not be on the actual array
without a way to check that this is actually the case.  Add a deprecation
warning to see if we might be able to eventually drop it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/Kconfig | 2 +-
 drivers/md/md.c    | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index 9712ab9bcba52e..444517d1a2336a 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -51,7 +51,7 @@ config MD_AUTODETECT
 	  If unsure, say Y.
 
 config MD_BITMAP_FILE
-	bool "MD bitmap file support"
+	bool "MD bitmap file support (deprecated)"
 	default y
 	help
 	  If you say Y here, support for write intent bitmaps in files on an
diff --git a/drivers/md/md.c b/drivers/md/md.c
index c9fcefaf9c073b..d04a91295edf9d 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7026,6 +7026,8 @@ static int set_bitmap_file(struct mddev *mddev, int fd)
 				mdname(mddev));
 			return -EINVAL;
 		}
+		pr_warn("%s: using deprecated bitmap file support\n",
+			mdname(mddev));
 
 		f = fget(fd);
 
-- 
2.39.2

