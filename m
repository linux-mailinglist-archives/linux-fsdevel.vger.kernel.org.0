Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261EE6D3F63
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 10:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjDCIsX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 04:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjDCIsV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:48:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD106A5D
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 01:48:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA5A0616CB
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 08:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC20DC4339C;
        Mon,  3 Apr 2023 08:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680511699;
        bh=Su2DoSY6BWVBfCUfk9QccjNDv0XP3B1+MpHIwHBykn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g9nWUEEMRDid916NyRQuwKd2XaaGWV6PBImgZfSim19fxbwjlJ3bEV94rgC0h2+yG
         ZZVrsheSbTsqjsCaCDG98G2AEQGYjcvVZZVg/UD+UKI/0XSHNUvD+XHXxMgiwvgbe6
         Ok/SsHK2nFBfSpOrN/M6T1FL2w94swHcw8AXKzBbiur1d5ivFpK5eOps8iHonayngv
         37R96Q2TjCpqsRGJJGbjCSA6dTKDrm6yyHbmGrnU9u4ZvsbosQuiU9QVraHbACq3oa
         5Hut+ESrPnQwO3Y0tUDvj7sVVlD29udS8iTCP1Zp/B539XMdpUaLddvAuX4wEClTFJ
         UfiZaMbADrhnA==
From:   cem@kernel.org
To:     hughd@google.com
Cc:     jack@suse.cz, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        djwong@kernel.org
Subject: [PATCH 3/6] quota: Check presence of quota operation structures instead of ->quota_read and ->quota_write callbacks
Date:   Mon,  3 Apr 2023 10:47:56 +0200
Message-Id: <20230403084759.884681-4-cem@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230403084759.884681-1-cem@kernel.org>
References: <20230403084759.884681-1-cem@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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
---
 fs/quota/dquot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index a6357f728034a..81563a83b609d 100644
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
2.30.2

