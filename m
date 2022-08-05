Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2239158AFED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 20:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241487AbiHESgD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 14:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241484AbiHESfx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 14:35:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5A76350;
        Fri,  5 Aug 2022 11:35:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF232B829E9;
        Fri,  5 Aug 2022 18:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD426C433D6;
        Fri,  5 Aug 2022 18:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659724549;
        bh=IMTrWJWnieceGbG5NqZtFEctzXK036a+Q7hbE1yr5UE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tgn7hhdvDfOpGmH2MNlYJDkipS/1LtOgwvgrmyZIfwFOY21hGb2rYGFHPzuFfKaYS
         +iHiQLsxliCX1g6VjMXydeMi5QYvLQJZ/Ycr89q4t/rpGmlo1ZBMsoYCu7mApT4C8y
         vJMpCd1vtxt4rx+N527SMhS8kHBDbiaOWCVablIXKbN7L7iXZfmb9LWX13XRhTzs4R
         OV0iOFGYLYBLGUNON95UGqw5J7VXNW440ygYcXyMY161/2G68hP2osUusyqcCieKFt
         72GE+18HXyp/533ALd6KWJXgtmd4/Qqo3J1zir2MXfAJxqIJs2WVpk2H2sj7ry/SF9
         JGlt+2/zLFEcw==
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     dhowells@redhat.com, lczerner@redhat.com, bxue@redhat.com,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [RFC PATCH 3/4] afs: fill out change attribute in statx replies
Date:   Fri,  5 Aug 2022 14:35:42 -0400
Message-Id: <20220805183543.274352-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805183543.274352-1-jlayton@kernel.org>
References: <20220805183543.274352-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Always copy the change attribute in a statx reply, and set the
STATX_CHGATTR bit unconditionally.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/afs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 64dab70d4a4f..dffd6edd6628 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -760,6 +760,8 @@ int afs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 	do {
 		read_seqbegin_or_lock(&vnode->cb_lock, &seq);
 		generic_fillattr(&init_user_ns, inode, stat);
+		stat->chgattr = inode_peek_iversion_raw(inode);
+		stat->result_mask |= STATX_CHGATTR;
 		if (test_bit(AFS_VNODE_SILLY_DELETED, &vnode->flags) &&
 		    stat->nlink > 0)
 			stat->nlink -= 1;
-- 
2.37.1

