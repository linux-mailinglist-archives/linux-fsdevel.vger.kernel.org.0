Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10BA49C123
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 03:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbiAZCSb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 21:18:31 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50332 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236231AbiAZCS1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 21:18:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 046E0615D5;
        Wed, 26 Jan 2022 02:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F8DC340E0;
        Wed, 26 Jan 2022 02:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643163506;
        bh=fshBKAaTLjg1EN4iFTGI+CGmy96ZycGCbpcDBiTRnQI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mVfYwoh/yU4yHrkKAsfUyyKTeBzYw1/z5DrMaHK7fSKmpK0apUBTF1wp21co5c1ZQ
         oLomLRs6/93dqaOXA7wpbqnBLzYn2QI9Y5uoypGUKi+cLMQEX4q96gOlWDXMuKazhA
         SXmCBc7+j93hLLWmcvBOzy/QJDMsgjFskBJoNZyDt42jvo5F66IZZ3Jap8u5CagTE3
         w+Pgcq54PqYIiU7l2Eq7eJmrbh/7iPKli+YHildcHstsxJD7InHSlp2GOXrzRByWc5
         iA/kYZHlnJ/ZWg5Vcozrdx5O4QwOJWF/6GBtN5Hqyk1nSCs7lh0KPdIK4nIfTes8TF
         hMIuGroWQ4eEg==
Subject: [PATCH 3/4] quota: make dquot_quota_sync return errors from ->sync_fs
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.com
Date:   Tue, 25 Jan 2022 18:18:26 -0800
Message-ID: <164316350602.2600168.17959517250738452981.stgit@magnolia>
In-Reply-To: <164316348940.2600168.17153575889519271710.stgit@magnolia>
References: <164316348940.2600168.17153575889519271710.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Strangely, dquot_quota_sync ignores the return code from the ->sync_fs
call, which means that quotacalls like Q_SYNC never see the error.  This
doesn't seem right, so fix that.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/quota/dquot.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)


diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 22d904bde6ab..a74aef99bd3d 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -690,9 +690,14 @@ int dquot_quota_sync(struct super_block *sb, int type)
 	/* This is not very clever (and fast) but currently I don't know about
 	 * any other simple way of getting quota data to disk and we must get
 	 * them there for userspace to be visible... */
-	if (sb->s_op->sync_fs)
-		sb->s_op->sync_fs(sb, 1);
-	sync_blockdev(sb->s_bdev);
+	if (sb->s_op->sync_fs) {
+		ret = sb->s_op->sync_fs(sb, 1);
+		if (ret)
+			return ret;
+	}
+	ret = sync_blockdev(sb->s_bdev);
+	if (ret)
+		return ret;
 
 	/*
 	 * Now when everything is written we can discard the pagecache so

