Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DCD788F94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 22:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjHYUNO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 16:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjHYUMo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 16:12:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC62268A;
        Fri, 25 Aug 2023 13:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=A01TE489ckQP9O12cr6XeHZtnw6Y2F2mnpUztYb0dK8=; b=InTD+PckuTsmPz9rB/jBiJHJsl
        CFTmebln5vVjMB+j1Y8ydtnKkDJESeQm1yxS21iAvZg6PlCKgHjsoIu8lP5C6ojqEoaea0hBCVdEu
        UPr6VvMqzW9WjsV4ll29xsvSFhBsJmsNIrUJxcRiLZtMAuY1BaKzmjSXhIde7mZqK1Cg0VmjwOvq9
        y5aiKBHiAawwmmIdzkxN0f6+nqaBO4k3YJwdiyhET0EgPTdP75dkyMXTe3aSPVVwFn8m4N28wruJQ
        pBx4ujdYyvjH0LBwcZpxcPFfVqpDEV4iH+ysWzJXEpCZn8WXaNe86u00LlIqehAohBk0u1XkC6IVw
        pMrAm5Yg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qZdAW-001SaB-1g; Fri, 25 Aug 2023 20:12:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/15] ceph: Convert __ceph_do_getattr() to take a folio
Date:   Fri, 25 Aug 2023 21:12:21 +0100
Message-Id: <20230825201225.348148-12-willy@infradead.org>
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

Both callers now have a folio, so pass it in.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/addr.c  | 2 +-
 fs/ceph/file.c  | 2 +-
 fs/ceph/inode.c | 6 +++---
 fs/ceph/super.h | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 1812c3e6e64f..09178a8ebbde 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1618,7 +1618,7 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 			ret = VM_FAULT_OOM;
 			goto out_inline;
 		}
-		err = __ceph_do_getattr(inode, &folio->page,
+		err = __ceph_do_getattr(inode, folio,
 					 CEPH_STAT_CAP_INLINE_DATA, true);
 		if (err < 0 || off >= i_size_read(inode)) {
 			folio_unlock(folio);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 5c4f763b1304..f4c3cb05b6f1 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2091,7 +2091,7 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 				return -ENOMEM;
 		}
 
-		statret = __ceph_do_getattr(inode, &folio->page,
+		statret = __ceph_do_getattr(inode, folio,
 					    CEPH_STAT_CAP_INLINE_DATA, !!folio);
 		if (statret < 0) {
 			if (folio)
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 800ab7920513..ced036d47b3b 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2809,7 +2809,7 @@ int ceph_try_to_choose_auth_mds(struct inode *inode, int mask)
  * Verify that we have a lease on the given mask.  If not,
  * do a getattr against an mds.
  */
-int __ceph_do_getattr(struct inode *inode, struct page *locked_page,
+int __ceph_do_getattr(struct inode *inode, struct folio *locked_folio,
 		      int mask, bool force)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_client(inode->i_sb);
@@ -2836,9 +2836,9 @@ int __ceph_do_getattr(struct inode *inode, struct page *locked_page,
 	ihold(inode);
 	req->r_num_caps = 1;
 	req->r_args.getattr.mask = cpu_to_le32(mask);
-	req->r_locked_page = locked_page;
+	req->r_locked_page = &locked_folio->page;
 	err = ceph_mdsc_do_request(mdsc, NULL, req);
-	if (locked_page && err == 0) {
+	if (locked_folio && err == 0) {
 		u64 inline_version = req->r_reply_info.targeti.inline_version;
 		if (inline_version == 0) {
 			/* the reply is supposed to contain inline data */
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 51c7f2b14f6f..3649ac41a626 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1081,8 +1081,8 @@ static inline void ceph_queue_flush_snaps(struct inode *inode)
 }
 
 extern int ceph_try_to_choose_auth_mds(struct inode *inode, int mask);
-extern int __ceph_do_getattr(struct inode *inode, struct page *locked_page,
-			     int mask, bool force);
+int __ceph_do_getattr(struct inode *inode, struct folio *locked_folio,
+		int mask, bool force);
 static inline int ceph_do_getattr(struct inode *inode, int mask, bool force)
 {
 	return __ceph_do_getattr(inode, NULL, mask, force);
-- 
2.40.1

