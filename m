Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C3E58AFD5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 20:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241462AbiHESfv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 14:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241368AbiHESfu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 14:35:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A128125CB;
        Fri,  5 Aug 2022 11:35:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23761619B9;
        Fri,  5 Aug 2022 18:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944AFC433B5;
        Fri,  5 Aug 2022 18:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659724548;
        bh=CXhOaBQbPFYiQTY/SMRa/9kU9DcUByI7xcnrlvCh3Z0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hbv0DjQP9ER5DxNx6k3QSNQvAG1dC0pXEiWkUZpPHqewQW1+ykAp5DIo5PYWHqz7l
         J3WJSgD6wA6Hh1Rui3FzLzKLmJHX5NIpkZNHV63mpySM/GSq4+LqUa9mQnqCrgcSdB
         tF7SWLckJxh095ZF8IieD9k/PFUH9DbBNBs6eJ2baWF1WRkt/Xo6CsAJMsJtB4NIC1
         H1diaZcDxasE5uYBfRy+p5Y7yffr01EkymCvqHk/Ej2RgJbuBzFbB/Ohbq15jkSmS/
         OqLk/42/XDXkBldd+XiWLiMb+TYpf9V4z3PHB/l0kq/fTpUqc+RWLroQmjlcwA5f8u
         Dl5Qh/hixeiTQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     dhowells@redhat.com, lczerner@redhat.com, bxue@redhat.com,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [RFC PATCH 2/4] nfs: report the change attribute if requested
Date:   Fri,  5 Aug 2022 14:35:41 -0400
Message-Id: <20220805183543.274352-3-jlayton@kernel.org>
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

Allow NFS to report the i_version in statx. Since the cost to fetch it
is relatively cheap, do it unconditionally and just set the flag if it
looks like it's valid.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index b4e46b0ffa2d..8e0e7ecf6429 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -829,6 +829,8 @@ static u32 nfs_get_valid_attrmask(struct inode *inode)
 		reply_mask |= STATX_UID | STATX_GID;
 	if (!(cache_validity & NFS_INO_INVALID_BLOCKS))
 		reply_mask |= STATX_BLOCKS;
+	if (!(cache_validity & NFS_INO_INVALID_CHANGE))
+		reply_mask |= STATX_CHGATTR;
 	return reply_mask;
 }
 
@@ -914,6 +916,7 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 
 	generic_fillattr(&init_user_ns, inode, stat);
 	stat->ino = nfs_compat_user_ino64(NFS_FILEID(inode));
+	stat->chgattr = inode_peek_iversion_raw(inode);
 	if (S_ISDIR(inode->i_mode))
 		stat->blksize = NFS_SERVER(inode)->dtsize;
 out:
-- 
2.37.1

