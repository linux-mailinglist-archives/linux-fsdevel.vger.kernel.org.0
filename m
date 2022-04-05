Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59134F4D66
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582063AbiDEXlz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573588AbiDETXK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:23:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AC14BB9E;
        Tue,  5 Apr 2022 12:21:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AB8761899;
        Tue,  5 Apr 2022 19:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD4CC385A0;
        Tue,  5 Apr 2022 19:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649186469;
        bh=PDf3viSS4Mrr2b1LxuraoL8yqmsI0zQ6OYJs90Hla08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oHkKb0zOXEGuXDRiw+PFtURhv5EVKSUUB/pEPOSwoTvrDKMMkparT8Yo9oxfzEdL7
         bvqrG7PYDMEL/jj4n/I1QjdBPH5Iz5sKnujn5kmgM+FsE1GbkM4ubK5HYbiB5i5GRt
         2GcheSsP2jMI0mhKOO25nWlz8HuwFSYd4XZYRKqNMBMfZji8WIC2CWZPrnd+ZW5RDK
         4Pr63v2KKhS0GKMKuMiM7gSXx76ok2+wQrXigURfS7r4uJ3XEuk8lChHl/M0dM9RFe
         lBusEbXaxGN9jNBzLuuXFfJasFxbyPQbDFs7VY/qr/PCYY6ZIgcswU24BwK29WyORq
         YTE1HezVsEIQQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [PATCH v13 41/59] ceph: get file size from fscrypt_file when present in inode traces
Date:   Tue,  5 Apr 2022 15:20:12 -0400
Message-Id: <20220405192030.178326-42-jlayton@kernel.org>
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

When we get an inode trace from the MDS, grab the fscrypt_file field if
the inode is encrypted, and use it to populate the i_size field instead
of the regular inode size field.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/inode.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index b9454721c976..f2a59306e4a6 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1024,6 +1024,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 
 	if (new_version ||
 	    (new_issued & (CEPH_CAP_ANY_FILE_RD | CEPH_CAP_ANY_FILE_WR))) {
+		u64 size = le64_to_cpu(info->size);
 		s64 old_pool = ci->i_layout.pool_id;
 		struct ceph_string *old_ns;
 
@@ -1037,10 +1038,21 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 
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

