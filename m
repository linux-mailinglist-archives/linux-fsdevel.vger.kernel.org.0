Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FB5745F0A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 16:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjGCOtc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 10:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjGCOtb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:49:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98165B2
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jul 2023 07:49:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BFE160F8B
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jul 2023 14:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF43C433C9;
        Mon,  3 Jul 2023 14:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688395769;
        bh=z1E2pa1mWqK17rfpAp6GIgAVOnxoG69MivfKzsS2dOo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=FUJFQFxgJDgnlKuulhp0ohjMt3gU0OfkmyMbayIFBUeWVxzytLiq4JBhEPxmKtpnJ
         EKXNMim1kSt8kdM6x/MUy8FmWkbP8xbmSDtKpK0sdmlAMKcyKRsmno3kMBZ5/HyUCf
         TM10J8znH4he/viA3w3/zopR+Vb4QITvGDF6EoeUsxE+5RxXPZl862HmAHlfwVFLdv
         mp0psEtmQap7mVcerXpisSY/Vql1VbOBECWq7XaDdsJh+YToo2OWC7JesxM506eITb
         7X696/iHBVVYlY5Z1KuZ161tk+7mFBlM0w5SbkxNVdUvtKwUc0mmBLGrOdpL9ny6SO
         XM3O+qzy9bC/A==
From:   Christian Brauner <brauner@kernel.org>
Date:   Mon, 03 Jul 2023 16:49:12 +0200
Subject: [PATCH 2/2] fs: don't assume arguments are non-NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230703-vfs-rename-source-v1-2-37eebb29b65b@kernel.org>
References: <20230703-vfs-rename-source-v1-0-37eebb29b65b@kernel.org>
In-Reply-To: <20230703-vfs-rename-source-v1-0-37eebb29b65b@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1215; i=brauner@kernel.org;
 h=from:subject:message-id; bh=z1E2pa1mWqK17rfpAp6GIgAVOnxoG69MivfKzsS2dOo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQsuv9ZPK7qztaNZw99jKrzDBd22XlhY5N9jgr/yimmP1zO
 3J86r6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiV7kZ/nAs/sqeOS891Wxl7aRbZ9
 uZgjdvTAzkvFfwKk0xYdP6I44M/ysNNxc+UOq7H3fvSGT5tw9i770bFDLucJnt1d92d2F8ARMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The helper is explicitly documented as locking zero, one, or two
arguments. While all current callers do pass non-NULL arguments there's
no need or requirement for them to do so according to the code and the
unlock_two_nondirectories() helper is pretty clear about it as well. So
only call WARN_ON_ONCE() if the checked inode is valid.

Cc: Jan Kara <jack@suse.cz>
Fixes: 2454ad83b90a ("fs: Restrict lock_two_nondirectories() to non-directory inodes")
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index d37fad91c8da..8fefb69e1f84 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1156,8 +1156,10 @@ void lock_two_inodes(struct inode *inode1, struct inode *inode2,
  */
 void lock_two_nondirectories(struct inode *inode1, struct inode *inode2)
 {
-	WARN_ON_ONCE(S_ISDIR(inode1->i_mode));
-	WARN_ON_ONCE(S_ISDIR(inode2->i_mode));
+	if (inode1)
+		WARN_ON_ONCE(S_ISDIR(inode1->i_mode));
+	if (inode2)
+		WARN_ON_ONCE(S_ISDIR(inode2->i_mode));
 	lock_two_inodes(inode1, inode2, I_MUTEX_NORMAL, I_MUTEX_NONDIR2);
 }
 EXPORT_SYMBOL(lock_two_nondirectories);

-- 
2.34.1

