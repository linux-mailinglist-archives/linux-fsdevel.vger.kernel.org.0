Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6DD66374E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 03:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237901AbjAJC0B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 21:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237896AbjAJCZ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 21:25:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30B762CF
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jan 2023 18:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=YFc56eYhHckNktLpTW8qOwumnlJuXsWVNAm4k/1AqGE=; b=QmeZVHBShsPuRvIyQto4v66qXc
        VrtPlF+fnSSTaI4dSCge7LgXllrTCxGauDSRl8BOrQmLCjuuu2i4UIsm+twMxEabA89P5K2sPdiER
        mdGCpp4CC9CW1YS1IdMxVcnv/mH2UT4b6vB7VtvgThJ3/RB/cZF1aQeGwfyD+0VrAdbzWnG44uHCZ
        PO1LGnc+efLFy/pcnKNKqGJkmr6hvXMV3ItJJUlnFni6bAeyZ/fKCPnIOg3kSLJUDDa7UMhcOWU5J
        FCueqOBfzGsNn3u04hWHtnCoWEoQrFnX0Pa6SnplJlBcMP38SLVH3w5FNu+IjmUmvxKkEYm9jvRSI
        uj8kIIcw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pF4Kp-004yfc-9P; Tue, 10 Jan 2023 02:25:55 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, p.raghav@samsung.com,
        hch@infradead.org, john.johansen@canonical.com,
        dhowells@redhat.com, mcgrof@kernel.org
Subject: [RFC 2/3] fs: use SB_NOUSER on path_mount() instead of deprecated MS_NOUSER
Date:   Mon,  9 Jan 2023 18:25:53 -0800
Message-Id: <20230110022554.1186499-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230110022554.1186499-1-mcgrof@kernel.org>
References: <20230110022554.1186499-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The goal behind 462ec50cb5 ("VFS: Differentiate mount flags (MS_*) from
internal superblock flags") was to phase out MS_* users for internal
uses. But we can't remove the old MS_* until we have all users out so
just use the SB_* helper for this check.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ab467ee58341..bf1cc8527057 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3411,7 +3411,7 @@ int path_mount(const char *dev_name, struct path *path,
 	if (data_page)
 		((char *)data_page)[PAGE_SIZE - 1] = 0;
 
-	if (flags & MS_NOUSER)
+	if (flags & SB_NOUSER)
 		return -EINVAL;
 
 	ret = security_sb_mount(dev_name, path, type_page, flags, data_page);
-- 
2.35.1

