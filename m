Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF0475242D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 15:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjGMNtP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 09:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjGMNtJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:49:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A494D19B4
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 06:49:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39EE46153F
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 13:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED43C433CD;
        Thu, 13 Jul 2023 13:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689256146;
        bh=okwg5m+9iRcDR+mIe+e593XoCBrrkAftdLKtFY7t22A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RgP5nZT990UkDxviYs+LUZ/HPon2RZaJfpBtPgi1kRxGWXeX6s+bh+amI0VXt09iG
         eHVT7xfKVNPXE2H6fNVrJovWYUYZynW5ITk9v9t9uU+9PX6T7Ub4+Xy7Bltj6ixQxz
         hnpTQB+PkAde7nzTp3V97Ph0hCRt8tl5VmXxnya+/zEDKkBma0fZT/V3+6RK4lGg5l
         AfkivvgOYA9ibjzCjxO4mAteKSKrKko5Ulm4ixlcGFgnjbN/05+javYG1cEoDT8Oo0
         C8IXojGKpMu52V7SnhFqA7PD6S4UDvoXs8EWCf/Yq0OPePeslYAJrM286JBNRFjaze
         5CAYK6mI+Ci7Q==
From:   cem@kernel.org
To:     linux-fsdevel@vger.kernel.org
Cc:     jack@suse.cz, akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, djwong@kernel.org, hughd@google.com,
        brauner@kernel.org, mcgrof@kernel.org
Subject: [PATCH 3/6] quota: Check presence of quota operation structures instead of ->quota_read and ->quota_write callbacks
Date:   Thu, 13 Jul 2023 15:48:45 +0200
Message-Id: <20230713134848.249779-4-cem@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230713134848.249779-1-cem@kernel.org>
References: <20230713134848.249779-1-cem@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

Currently we check whether superblock has ->quota_read and ->quota_write
operations to check whether filesystem supports quotas. However for
example for shmfs we will not read or write dquots so check whether
quota operations are set in the superblock instead.

Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 fs/quota/dquot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index e3e4f4047657..4d826c369da2 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2367,7 +2367,7 @@ int dquot_load_quota_sb(struct super_block *sb, int type, int format_id,
 
 	if (!fmt)
 		return -ESRCH;
-	if (!sb->s_op->quota_write || !sb->s_op->quota_read ||
+	if (!sb->dq_op || !sb->s_qcop ||
 	    (type == PRJQUOTA && sb->dq_op->get_projid == NULL)) {
 		error = -EINVAL;
 		goto out_fmt;
-- 
2.39.2

