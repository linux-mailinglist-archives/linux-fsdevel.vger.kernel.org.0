Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDA975621B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 13:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjGQLxZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 07:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGQLxY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:53:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DEBA6
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 04:53:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07DA561035
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 11:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7C3C433C7;
        Mon, 17 Jul 2023 11:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689594802;
        bh=okwg5m+9iRcDR+mIe+e593XoCBrrkAftdLKtFY7t22A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NgK1YF37XbP9j3RFJRCOWrO8Z9eFBFeaswFRaTRK52mri/14LvTVamSqGrfkgET5I
         73ZJ9jFmvCb6Isbl6smJZ3tyVwdYWxF7Ahwog+f2fAJ+qwp50vML0CSnryw9G8SsD4
         My7IO/bcA1u4OS/SVGzwTFUp7cbgm5yYgvsUUbCtkCaFfiqMrwB+vy1KpVkb4uOFw2
         2mIr7dt13Gt+/Wfj8sJvphMtH1u7YsXK0+4kw9AQ+mL4YC4UbU+TDNJlJYmOk9lnfA
         sOBjeCrdsfzE7ENtPNcixHssScYzPx6wbx/6f/KdxtYY1nDOVuRfuFOGZap7atOG28
         Ry5dPQ9XUWn4g==
From:   cem@kernel.org
To:     linux-fsdevel@vger.kernel.org
Cc:     jack@suse.cz, akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, djwong@kernel.org, hughd@google.com,
        brauner@kernel.org, mcgrof@kernel.org
Subject: [PATCH 3/6] quota: Check presence of quota operation structures instead of ->quota_read and ->quota_write callbacks
Date:   Mon, 17 Jul 2023 13:52:13 +0200
Message-Id: <20230717115212.208651-4-cem@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230717115212.208651-1-cem@kernel.org>
References: <20230717115212.208651-1-cem@kernel.org>
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

