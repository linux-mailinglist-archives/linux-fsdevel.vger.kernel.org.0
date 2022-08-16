Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD73595D4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 15:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbiHPN2S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 09:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbiHPN2I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:28:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B35BF5E;
        Tue, 16 Aug 2022 06:28:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7AE5EB81A20;
        Tue, 16 Aug 2022 13:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA329C43470;
        Tue, 16 Aug 2022 13:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660656484;
        bh=2zSq9xhOslR+RZJl6daUuNMh3IFMdGv5GllfBZ7aAAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H16bZ/ckNdffuwx6HGPkIjwjJoljvvuzvGOhu0ca0IqboR3xgmGklyR4TTtXN8bbU
         fWZcbVmyWifkrdZmEp3wUprf+mJgmxd8U6X2sAaegdKlcseI5Be6m3sbEBy/mtJiXi
         iKQRtQethI7SPJIMZ3sYA9NNGQodbNnP6libeiNo4JXZL3eOBU6zfgRSyqgepjTnYH
         b4s4wu8vOASbxm5i7DEy2+6QJfm2niMJm+BLqSLyftB8D+wWJUy5Vu2JqmAi4B9pjy
         64As5PorAlpXYxXiLu/3Mhqm49nOrwyIzkzVGnX4nvGUJ+h4zYILErMQX/DnfiEDDY
         e/vHg9/ZBE/kA==
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        ceph-devel@vger.kernel.org
Subject: [PATCH 3/4] afs: fill out change attribute in statx replies
Date:   Tue, 16 Aug 2022 09:27:58 -0400
Message-Id: <20220816132759.43248-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220816132759.43248-1-jlayton@kernel.org>
References: <20220816132759.43248-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 6d3a3dbe4928..bc65cc2dd2d5 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -762,6 +762,8 @@ int afs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 	do {
 		read_seqbegin_or_lock(&vnode->cb_lock, &seq);
 		generic_fillattr(&init_user_ns, inode, stat);
+		stat->change_attr = inode_peek_iversion_raw(inode);
+		stat->result_mask |= STATX_CHANGE_ATTR;
 		if (test_bit(AFS_VNODE_SILLY_DELETED, &vnode->flags) &&
 		    stat->nlink > 0)
 			stat->nlink -= 1;
-- 
2.37.2

