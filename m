Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565014E40EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 15:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237565AbiCVORZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 10:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236543AbiCVOPC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:15:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA547EB38;
        Tue, 22 Mar 2022 07:13:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28C09615C7;
        Tue, 22 Mar 2022 14:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBF4C340EC;
        Tue, 22 Mar 2022 14:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647958412;
        bh=KoFo4bohfOgUxMTT0tlbpIvZ4LFi9MZlB3HiMQ55h5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MQqF5O+P5kBCgbY7XcFsLoeWiLbdtfww2rPaack7sM7wvVeYITEhhjM6rNjolwfn9
         mzxZSoepbnYRWMnuv110yyOBiffoGMdSbKcnesPr3xebGSPB2Ao7h9j5TcwjgttevI
         UZUuuB33JTUNhuL28yx1cNGR3kxP4aTQTXTkJGLScQ24pZPLSMwVt798G561Pv61Zh
         0jv8jTPqdg0tct8cLV7uRvGhVWbONNJzLMhn0nYJIUDfcWUeG/mV0ZRl84ChZxI+pM
         /W/8G6JASzdKJlqysiX8vgOgJW7RSYhtKQIRF6+5K9rGIZk8ONlgMJeEtsJFDDtsBJ
         epRHYkHn2UNhg==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [RFC PATCH v11 14/51] ceph: make ceph_msdc_build_path use ref-walk
Date:   Tue, 22 Mar 2022 10:12:39 -0400
Message-Id: <20220322141316.41325-15-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322141316.41325-1-jlayton@kernel.org>
References: <20220322141316.41325-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Encryption potentially requires allocation, at which point we'll need to
be in a non-atomic context. Convert ceph_msdc_build_path to take dentry
spinlocks and references instead of using rcu_read_lock to walk the
path.

This is slightly less efficient, and we may want to eventually allow
using RCU when the leaf dentry isn't encrypted.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/mds_client.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 49ba47baac8e..d12b1bfb2d29 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2398,7 +2398,8 @@ static inline  u64 __get_oldest_tid(struct ceph_mds_client *mdsc)
 char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
 			   int stop_on_nosnap)
 {
-	struct dentry *temp;
+	struct dentry *cur;
+	struct inode *inode;
 	char *path;
 	int pos;
 	unsigned seq;
@@ -2415,34 +2416,35 @@ char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
 	path[pos] = '\0';
 
 	seq = read_seqbegin(&rename_lock);
-	rcu_read_lock();
-	temp = dentry;
+	cur = dget(dentry);
 	for (;;) {
-		struct inode *inode;
+		struct dentry *temp;
 
-		spin_lock(&temp->d_lock);
-		inode = d_inode(temp);
+		spin_lock(&cur->d_lock);
+		inode = d_inode(cur);
 		if (inode && ceph_snap(inode) == CEPH_SNAPDIR) {
 			dout("build_path path+%d: %p SNAPDIR\n",
-			     pos, temp);
-		} else if (stop_on_nosnap && inode && dentry != temp &&
+			     pos, cur);
+		} else if (stop_on_nosnap && inode && dentry != cur &&
 			   ceph_snap(inode) == CEPH_NOSNAP) {
-			spin_unlock(&temp->d_lock);
+			spin_unlock(&cur->d_lock);
 			pos++; /* get rid of any prepended '/' */
 			break;
 		} else {
-			pos -= temp->d_name.len;
+			pos -= cur->d_name.len;
 			if (pos < 0) {
-				spin_unlock(&temp->d_lock);
+				spin_unlock(&cur->d_lock);
 				break;
 			}
-			memcpy(path + pos, temp->d_name.name, temp->d_name.len);
+			memcpy(path + pos, cur->d_name.name, cur->d_name.len);
 		}
+		temp = cur;
 		spin_unlock(&temp->d_lock);
-		temp = READ_ONCE(temp->d_parent);
+		cur = dget_parent(temp);
+		dput(temp);
 
 		/* Are we at the root? */
-		if (IS_ROOT(temp))
+		if (IS_ROOT(cur))
 			break;
 
 		/* Are we out of buffer? */
@@ -2451,8 +2453,9 @@ char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
 
 		path[pos] = '/';
 	}
-	base = ceph_ino(d_inode(temp));
-	rcu_read_unlock();
+	inode = d_inode(cur);
+	base = inode ? ceph_ino(inode) : 0;
+	dput(cur);
 
 	if (read_seqretry(&rename_lock, seq))
 		goto retry;
-- 
2.35.1

