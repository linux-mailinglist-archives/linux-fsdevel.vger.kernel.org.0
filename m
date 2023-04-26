Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E016EF1D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Apr 2023 12:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240374AbjDZKU1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 06:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240238AbjDZKUV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 06:20:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6A33C39
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Apr 2023 03:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29AFB62B8C
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Apr 2023 10:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69754C4339C;
        Wed, 26 Apr 2023 10:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682504419;
        bh=0+8LxOKXGKCvqagfKq127FWqroGkUmeQVQasqMNW7Qw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fQAOF4ijN10Rs92SLGh+Nbw4EvoLumPTmPZT5tCintz8fYkrH7WKto9F/dpQya3EQ
         Sh1CEDBR3XjDlNrbhWdtOn4qb6lMaT9YNlZK/035mKjMotUadoXIqAe3th51WSnwsl
         lP+hez7gcRjvMJYaaSdB9ILygu/sSPYw55t7d2GkTw9Sil52hHLQjBWHguLbYQYxUR
         4aWfUA1seR+9cU/nrULaCpoakoFpr4wxEMBqof0Pd2yP+2e+GEkmRnWv2YK76wMBPt
         NfZr9eT7AvRDszdK3UJmWAhyv6EOYB8jDkVMq3GYFBPLdgQXaISznDmywK9O7475GV
         nLJxOz0hYFXkw==
From:   cem@kernel.org
To:     hughd@google.com
Cc:     jack@suse.cz, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        djwong@kernel.org
Subject: [PATCH 3/6] quota: Check presence of quota operation structures instead of ->quota_read and ->quota_write callbacks
Date:   Wed, 26 Apr 2023 12:20:05 +0200
Message-Id: <20230426102008.2930932-4-cem@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230426102008.2930932-1-cem@kernel.org>
References: <20230426102008.2930932-1-cem@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

