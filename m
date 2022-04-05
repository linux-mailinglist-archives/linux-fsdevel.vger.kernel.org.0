Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CE54F4D64
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582051AbiDEXlx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573572AbiDETWx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:22:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE7847551;
        Tue,  5 Apr 2022 12:20:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F09E260A5F;
        Tue,  5 Apr 2022 19:20:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1686C385A1;
        Tue,  5 Apr 2022 19:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649186454;
        bh=40bz7fgcSkfmSJmWJDKxd9JZxineBbUvX30XOIb7qbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ScUndJsO1iIF8TZnZGyatLX8D1Sre9qw03pcugwOP94pa2shH71KCYubeRtwLcte8
         q9RYFCVt+6ZMZu+QFNAqmtzeaZqPzTNzF+0MMe1HSjLzlKAUfQJOCwSn5IPQyvFZwA
         Vih4e+llhlS//shafvtvaB0Z5W9Dp2d+KmN/zlOSYwX9QOC2RhLZzyzN8RTJeMrYOv
         hpyzzA2FW6n9d9mp4bD/8vGRDgPflyQ83mZ5r+BySLJASgExrd54G46yrVdy9Ui5KN
         DXSaIWV0SsLsQ8K4bfs044u75kf+1m/5jdjNBj+fbaDli3Pysk4GHIOYY/Jhud32+3
         2fSg1Jk/m2S2Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [PATCH v13 24/59] ceph: properly set DCACHE_NOKEY_NAME flag in lookup
Date:   Tue,  5 Apr 2022 15:19:55 -0400
Message-Id: <20220405192030.178326-25-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405192030.178326-1-jlayton@kernel.org>
References: <20220405192030.178326-1-jlayton@kernel.org>
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

This is required so that we know to invalidate these dentries when the
directory is unlocked.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/dir.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 8cc7a49ee508..897f8618151b 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -760,6 +760,17 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 	if (dentry->d_name.len > NAME_MAX)
 		return ERR_PTR(-ENAMETOOLONG);
 
+	if (IS_ENCRYPTED(dir)) {
+		err = __fscrypt_prepare_readdir(dir);
+		if (err)
+			return ERR_PTR(err);
+		if (!fscrypt_has_encryption_key(dir)) {
+			spin_lock(&dentry->d_lock);
+			dentry->d_flags |= DCACHE_NOKEY_NAME;
+			spin_unlock(&dentry->d_lock);
+		}
+	}
+
 	/* can we conclude ENOENT locally? */
 	if (d_really_is_negative(dentry)) {
 		struct ceph_inode_info *ci = ceph_inode(dir);
-- 
2.35.1

