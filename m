Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893EB788FA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 22:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjHYUNM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 16:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjHYUMl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 16:12:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A48268F;
        Fri, 25 Aug 2023 13:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dhiojXSvdUlOX72At1qltK2xt894rQa+8d88bX+5rNI=; b=Zyd55oC4gCM8VKt7zmpBQof+2/
        /yfWY58WgBfDfW98Lkdn0Nrn0E65CxE7P0cHS6HJ8VfASlWkg0tqiiAqy7TXBquQynE8rbZ5/iE7I
        9Z9FCgHZKE14jBIJA7c++jCduhyUD8jjq2cGKtAUssoI0AN6YtLJSTnKsHjiuqEpAX9nOqg3HI5Io
        CMoHSTRQY/SVGxBxWobbxr2uEvNXEgfhOWE36hb73VAxbBvk7RhEYmNzBB3qfAo+oBpuutQUqW5Yv
        kMa3TF/X0unS1v1eOhEOli/rHsgUvxTeY33NrFAFkHB5EV86lEEj15H73sLKPvxr5T+tC14c9fq4n
        DU19ZCkA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qZdAW-001SaH-5g; Fri, 25 Aug 2023 20:12:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/15] ceph: Convert ceph_fill_inode() to take a folio
Date:   Fri, 25 Aug 2023 21:12:22 +0100
Message-Id: <20230825201225.348148-13-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230825201225.348148-1-willy@infradead.org>
References: <20230825201225.348148-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Its one caller already has a folio, so pass it through req->r_locked_folio
into ceph_fill_inode().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/inode.c      | 10 +++++-----
 fs/ceph/mds_client.h |  2 +-
 fs/ceph/super.h      |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index ced036d47b3b..d5f0fe39b92f 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -913,7 +913,7 @@ static int decode_encrypted_symlink(const char *encsym, int symlen, u8 **decsym)
  * Populate an inode based on info from mds.  May be called on new or
  * existing inodes.
  */
-int ceph_fill_inode(struct inode *inode, struct page *locked_page,
+int ceph_fill_inode(struct inode *inode, struct folio *locked_folio,
 		    struct ceph_mds_reply_info_in *iinfo,
 		    struct ceph_mds_reply_dirfrag *dirinfo,
 		    struct ceph_mds_session *session, int cap_fmode,
@@ -1261,7 +1261,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 		int cache_caps = CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO;
 		ci->i_inline_version = iinfo->inline_version;
 		if (ceph_has_inline_data(ci) &&
-		    (locked_page || (info_caps & cache_caps)))
+		    (locked_folio || (info_caps & cache_caps)))
 			fill_inline = true;
 	}
 
@@ -1277,7 +1277,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 	ceph_fscache_register_inode_cookie(inode);
 
 	if (fill_inline)
-		ceph_fill_inline_data(inode, locked_page,
+		ceph_fill_inline_data(inode, &locked_folio->page,
 				      iinfo->inline_data, iinfo->inline_len);
 
 	if (wake)
@@ -1596,7 +1596,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 		BUG_ON(!req->r_target_inode);
 
 		in = req->r_target_inode;
-		err = ceph_fill_inode(in, req->r_locked_page, &rinfo->targeti,
+		err = ceph_fill_inode(in, req->r_locked_folio, &rinfo->targeti,
 				NULL, session,
 				(!test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags) &&
 				 !test_bit(CEPH_MDS_R_ASYNC, &req->r_req_flags) &&
@@ -2836,7 +2836,7 @@ int __ceph_do_getattr(struct inode *inode, struct folio *locked_folio,
 	ihold(inode);
 	req->r_num_caps = 1;
 	req->r_args.getattr.mask = cpu_to_le32(mask);
-	req->r_locked_page = &locked_folio->page;
+	req->r_locked_folio = locked_folio;
 	err = ceph_mdsc_do_request(mdsc, NULL, req);
 	if (locked_folio && err == 0) {
 		u64 inline_version = req->r_reply_info.targeti.inline_version;
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 1fa0f78b7b79..d2cf2ff9fa66 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -320,7 +320,7 @@ struct ceph_mds_request {
 	int r_err;
 	u32               r_readdir_offset;
 
-	struct page *r_locked_page;
+	struct folio *r_locked_folio;
 	int r_dir_caps;
 	int r_num_caps;
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 3649ac41a626..d741a9d15f52 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1038,7 +1038,7 @@ extern void ceph_fill_file_time(struct inode *inode, int issued,
 				u64 time_warp_seq, struct timespec64 *ctime,
 				struct timespec64 *mtime,
 				struct timespec64 *atime);
-extern int ceph_fill_inode(struct inode *inode, struct page *locked_page,
+int ceph_fill_inode(struct inode *inode, struct folio *locked_folio,
 		    struct ceph_mds_reply_info_in *iinfo,
 		    struct ceph_mds_reply_dirfrag *dirinfo,
 		    struct ceph_mds_session *session, int cap_fmode,
-- 
2.40.1

