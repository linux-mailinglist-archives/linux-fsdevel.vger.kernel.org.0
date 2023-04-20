Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F996E8C10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 10:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbjDTIEW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 04:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbjDTIEM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:04:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E932D71
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 01:04:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E88E964155
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 08:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31E3C4339E;
        Thu, 20 Apr 2023 08:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681977850;
        bh=0+8LxOKXGKCvqagfKq127FWqroGkUmeQVQasqMNW7Qw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mBkZQ1F9VgycRDHsoGbYIdJtpqkW9EUk1GP7t6FjuL6HKZv7NZYs7B4nA0uLo2WnL
         CSFRvDYZeyW8hv+NcwD2Y2x8arQ9PYEbA96I/8de0RT1d7N9KiT+ZQJvukutA3e9ad
         02H2Sal8tVnAP2dVSrViq4u28Q4m9fIiuCNe2bfuo0DOK7oeazw4cOXsUHKlKihS2n
         S2+DHGwkIVVYCJKxC3MXg/XtgaksF232vwGWlfJ1gXvW8rGJoTuweYR+jxZzb/HOs/
         FVvMUMKy+s5I1O72wGLNOvxYFHoyQfH+ibXFMqgP8qxP8st113hgaAUypx8yMmRtER
         wRDRR1RJ1P9Rg==
From:   cem@kernel.org
To:     hughd@google.com
Cc:     jack@suse.cz, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        djwong@kernel.org
Subject: [PATCH 3/6] quota: Check presence of quota operation structures instead of ->quota_read and ->quota_write callbacks
Date:   Thu, 20 Apr 2023 10:03:56 +0200
Message-Id: <20230420080359.2551150-4-cem@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230420080359.2551150-1-cem@kernel.org>
References: <20230420080359.2551150-1-cem@kernel.org>
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

