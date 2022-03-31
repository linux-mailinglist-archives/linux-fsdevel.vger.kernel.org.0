Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4864EDD33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 17:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238594AbiCaPgN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 11:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238753AbiCaPfr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:35:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB29C2274D6;
        Thu, 31 Mar 2022 08:32:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB24D61A82;
        Thu, 31 Mar 2022 15:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9394BC3410F;
        Thu, 31 Mar 2022 15:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648740726;
        bh=+4d1+CXq+9ZDinb1ZWpVB2RADQjE1XweuloJYwAgNNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K53ECP+R6Jnu0hROF0Y108m2Kp1x7VBVqhmRjmKhs2ow9hnKyag4y7s8G9XuBbDE9
         E/FI3BO21ynnBIn/FQy68tIGt5T/QDgY2voLk+0rTH+GvMgzINUFyvpmxMgzF9UY67
         uVvEQFUhqsApDoxyDq3Gt3hQ9g2mprMfrBFHdOlvkyAKv6hoxKyLxfQRpx4V/He+aF
         soN7qScxAZJ6JxE+hQ5UU8NlL7Rs4AghbxurNLgycTVgec1E8RNuA+nsWW6QluOBrV
         XDIHideRFdPXkC+ZVhTXmsUlEDRVSEV1hPWXqhuPA4gSd/NHvyiF338/h+P2mtKXpN
         Tcmr9MN/CueWw==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     xiubli@redhat.com, idryomov@gmail.com, lhenriques@suse.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 37/54] ceph: get file size from fscrypt_file when present in inode traces
Date:   Thu, 31 Mar 2022 11:31:13 -0400
Message-Id: <20220331153130.41287-38-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331153130.41287-1-jlayton@kernel.org>
References: <20220331153130.41287-1-jlayton@kernel.org>
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

When we get an inode trace from the MDS, grab the fscrypt_file field if
the inode is encrypted, and use it to populate the i_size field instead
of the regular inode size field.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/inode.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index d53f771128ed..20eed306895f 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1023,6 +1023,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 
 	if (new_version ||
 	    (new_issued & (CEPH_CAP_ANY_FILE_RD | CEPH_CAP_ANY_FILE_WR))) {
+		u64 size = le64_to_cpu(info->size);
 		s64 old_pool = ci->i_layout.pool_id;
 		struct ceph_string *old_ns;
 
@@ -1036,10 +1037,21 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 
 		pool_ns = old_ns;
 
+		if (IS_ENCRYPTED(inode) && size && (iinfo->fscrypt_file_len == sizeof(__le64))) {
+			u64 fsize = __le64_to_cpu(*(__le64 *)iinfo->fscrypt_file);
+
+			if (size == round_up(fsize, CEPH_FSCRYPT_BLOCK_SIZE)) {
+				size = fsize;
+			} else {
+				pr_warn("fscrypt size mismatch: size=%llu fscrypt_file=%llu, discarding fscrypt_file size.\n",
+					info->size, size);
+			}
+		}
+
 		queue_trunc = ceph_fill_file_size(inode, issued,
-					le32_to_cpu(info->truncate_seq),
-					le64_to_cpu(info->truncate_size),
-					le64_to_cpu(info->size));
+						  le32_to_cpu(info->truncate_seq),
+						  le64_to_cpu(info->truncate_size),
+						  size);
 		/* only update max_size on auth cap */
 		if ((info->cap.flags & CEPH_CAP_FLAG_AUTH) &&
 		    ci->i_max_size != le64_to_cpu(info->max_size)) {
-- 
2.35.1

