Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C0E4EDD23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 17:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238662AbiCaPgA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 11:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238643AbiCaPeu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:34:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6405223879;
        Thu, 31 Mar 2022 08:31:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8330CB82170;
        Thu, 31 Mar 2022 15:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F31BC36AE3;
        Thu, 31 Mar 2022 15:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648740717;
        bh=KMGS4bprVlohI670bguq8+HWWhGbVUnr8vKDTtVT1h0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ppSHBjy8kuIOMQLMu7BK/wb/ze95Bq5qbYYSC0sudFHo9WlEc6vZ5ZzffuoQQObF5
         4djPhi0hzBP6pW9x5O53af18ZXMGPrYrLkp8hEB0AaageAaBquLmNY0x3ASj3QDN0X
         7jTMI+9iXKJ4SZX/S3nnnHeWElU/Ej1gp8V3qmHF1WTireUOgngHHIYnsP0pTHvlbt
         aL5XhIc8poobriwCX+8qXKkEfh27IARBYV+U1uSkWI+TCNEHdkR+UAXDMKi55cyEpq
         85xCN1ycccELMzZNgKo/RNKJeQBmK/fCmsnpT5qkWudxNjIvqSbrJC9/1yB5nQKEiT
         mm265FzmLqBJg==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     xiubli@redhat.com, idryomov@gmail.com, lhenriques@suse.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 27/54] ceph: add ceph_encode_encrypted_dname() helper
Date:   Thu, 31 Mar 2022 11:31:03 -0400
Message-Id: <20220331153130.41287-28-jlayton@kernel.org>
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

From: Xiubo Li <xiubli@redhat.com>

Add a new helper that basically calls ceph_encode_encrypted_fname, but
with a qstr pointer instead of a dentry pointer. This will make it
simpler to decrypt names in a readdir reply, before we have a dentry.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/crypto.c | 11 ++++++++---
 fs/ceph/crypto.h |  8 ++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 7dee31e1e3bb..7cf45d374c1b 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -135,7 +135,7 @@ void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_se
 	swap(req->r_fscrypt_auth, as->fscrypt_auth);
 }
 
-int ceph_encode_encrypted_fname(const struct inode *parent, struct dentry *dentry, char *buf)
+int ceph_encode_encrypted_dname(const struct inode *parent, struct qstr *d_name, char *buf)
 {
 	u32 len;
 	int elen;
@@ -150,7 +150,7 @@ int ceph_encode_encrypted_fname(const struct inode *parent, struct dentry *dentr
 	 *
 	 * See: fscrypt_setup_filename
 	 */
-	if (!fscrypt_fname_encrypted_size(parent, dentry->d_name.len, NAME_MAX, &len))
+	if (!fscrypt_fname_encrypted_size(parent, d_name->len, NAME_MAX, &len))
 		return -ENAMETOOLONG;
 
 	/* Allocate a buffer appropriate to hold the result */
@@ -158,7 +158,7 @@ int ceph_encode_encrypted_fname(const struct inode *parent, struct dentry *dentr
 	if (!cryptbuf)
 		return -ENOMEM;
 
-	ret = fscrypt_fname_encrypt(parent, &dentry->d_name, cryptbuf, len);
+	ret = fscrypt_fname_encrypt(parent, d_name, cryptbuf, len);
 	if (ret) {
 		kfree(cryptbuf);
 		return ret;
@@ -182,6 +182,11 @@ int ceph_encode_encrypted_fname(const struct inode *parent, struct dentry *dentr
 	return elen;
 }
 
+int ceph_encode_encrypted_fname(const struct inode *parent, struct dentry *dentry, char *buf)
+{
+	return ceph_encode_encrypted_dname(parent, &dentry->d_name, buf);
+}
+
 /**
  * ceph_fname_to_usr - convert a filename for userland presentation
  * @fname: ceph_fname to be converted
diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
index 7e56aded5124..e54150260eba 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -67,6 +67,7 @@ void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc);
 int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
 				 struct ceph_acl_sec_ctx *as);
 void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_sec_ctx *as);
+int ceph_encode_encrypted_dname(const struct inode *parent, struct qstr *d_name, char *buf);
 int ceph_encode_encrypted_fname(const struct inode *parent, struct dentry *dentry, char *buf);
 
 static inline int ceph_fname_alloc_buffer(struct inode *parent, struct fscrypt_str *fname)
@@ -108,6 +109,13 @@ static inline void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req,
 {
 }
 
+static inline int ceph_encode_encrypted_dname(const struct inode *parent,
+					      struct qstr *d_name, char *buf)
+{
+	memcpy(buf, d_name->name, d_name->len);
+	return d_name->len;
+}
+
 static inline int ceph_encode_encrypted_fname(const struct inode *parent,
 						struct dentry *dentry, char *buf)
 {
-- 
2.35.1

