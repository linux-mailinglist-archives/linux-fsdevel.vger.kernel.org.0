Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83FF4E40C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 15:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236924AbiCVOP5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 10:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236946AbiCVOPd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:15:33 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD307EB0E;
        Tue, 22 Mar 2022 07:13:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ECCC7CE1E18;
        Tue, 22 Mar 2022 14:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B13C340EC;
        Tue, 22 Mar 2022 14:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647958430;
        bh=Zl375pRQCbRH4n2sSEDXRkXGO4gq68+coMqfdO7e67Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gpvarF70YCCR/XMB7zeWJF1i2ujcrpskNMMIb/KMJ2HxfUrKATQQvOYLZTWt1MHnO
         pWlaiHlB8lVNOZ/s5A9U7Y6+isD0x7kwbWYHGkGWev4m3mtNEBJll3eMIwZNvmvk9r
         9CLA2F6PifJ7VWfyyCM9p2itjidLALdDD566y7oB/KQHIUdZMYddkH6KpkfkMZ63/Q
         khohkn2NYQi07uuWHo4zVEF5g4UNNAEzHJ+jfCyCwdT3GiQcsEhrCi/stdprvrlK6F
         jdqpqnNpTpLZYVmJA9qQKVSDNdR6AhAM8HmWue+bMcuSk8sQstDv9e+ejW7Dg55ahk
         dPbPgViGo7ZrQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [RFC PATCH v11 33/51] ceph: fscrypt_file field handling in MClientRequest messages
Date:   Tue, 22 Mar 2022 10:12:58 -0400
Message-Id: <20220322141316.41325-34-jlayton@kernel.org>
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

For encrypted inodes, transmit a rounded-up size to the MDS as the
normal file size and send the real inode size in fscrypt_file field.

Also, fix up creates and truncates to also transmit fscrypt_file.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/dir.c        |  3 +++
 fs/ceph/file.c       |  2 ++
 fs/ceph/inode.c      | 18 ++++++++++++++++--
 fs/ceph/mds_client.c |  9 ++++++++-
 fs/ceph/mds_client.h |  2 ++
 5 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 8a9f916bfc6c..5ccf6453f02f 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -910,6 +910,9 @@ static int ceph_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 		goto out_req;
 	}
 
+	if (S_ISREG(mode) && IS_ENCRYPTED(dir))
+		set_bit(CEPH_MDS_R_FSCRYPT_FILE, &req->r_req_flags);
+
 	req->r_dentry = dget(dentry);
 	req->r_num_caps = 2;
 	req->r_parent = dir;
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 8a222ce5f8ce..df790317bedb 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -765,6 +765,8 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	req->r_args.open.mask = cpu_to_le32(mask);
 	req->r_parent = dir;
 	ihold(dir);
+	if (IS_ENCRYPTED(dir))
+		set_bit(CEPH_MDS_R_FSCRYPT_FILE, &req->r_req_flags);
 
 	if (flags & O_CREAT) {
 		struct ceph_file_layout lo;
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 35e7ef462136..599e27dae8c8 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2374,11 +2374,25 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr, struct ceph_iattr *c
 			}
 		} else if ((issued & CEPH_CAP_FILE_SHARED) == 0 ||
 			   attr->ia_size != isize) {
-			req->r_args.setattr.size = cpu_to_le64(attr->ia_size);
-			req->r_args.setattr.old_size = cpu_to_le64(isize);
 			mask |= CEPH_SETATTR_SIZE;
 			release |= CEPH_CAP_FILE_SHARED | CEPH_CAP_FILE_EXCL |
 				   CEPH_CAP_FILE_RD | CEPH_CAP_FILE_WR;
+			if (IS_ENCRYPTED(inode) && attr->ia_size) {
+				set_bit(CEPH_MDS_R_FSCRYPT_FILE, &req->r_req_flags);
+				mask |= CEPH_SETATTR_FSCRYPT_FILE;
+				req->r_args.setattr.size =
+					cpu_to_le64(round_up(attr->ia_size,
+							     CEPH_FSCRYPT_BLOCK_SIZE));
+				req->r_args.setattr.old_size =
+					cpu_to_le64(round_up(isize,
+							     CEPH_FSCRYPT_BLOCK_SIZE));
+				req->r_fscrypt_file = attr->ia_size;
+				/* FIXME: client must zero out any partial blocks! */
+			} else {
+				req->r_args.setattr.size = cpu_to_le64(attr->ia_size);
+				req->r_args.setattr.old_size = cpu_to_le64(isize);
+				req->r_fscrypt_file = 0;
+			}
 		}
 	}
 	if (ia_valid & ATTR_MTIME) {
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index a747ea7b7647..cd0c780a6f84 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2752,7 +2752,12 @@ static void encode_mclientrequest_tail(void **p, const struct ceph_mds_request *
 	} else {
 		ceph_encode_32(p, 0);
 	}
-	ceph_encode_32(p, 0); // fscrypt_file for now
+	if (test_bit(CEPH_MDS_R_FSCRYPT_FILE, &req->r_req_flags)) {
+		ceph_encode_32(p, sizeof(__le64));
+		ceph_encode_64(p, req->r_fscrypt_file);
+	} else {
+		ceph_encode_32(p, 0);
+	}
 }
 
 /*
@@ -2838,6 +2843,8 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 
 	/* fscrypt_file */
 	len += sizeof(u32);
+	if (test_bit(CEPH_MDS_R_FSCRYPT_FILE, &req->r_req_flags))
+		len += sizeof(__le64);
 
 	msg = ceph_msg_new2(CEPH_MSG_CLIENT_REQUEST, len, 1, GFP_NOFS, false);
 	if (!msg) {
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 046a9368c4a9..e297bf98c39f 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -282,6 +282,7 @@ struct ceph_mds_request {
 #define CEPH_MDS_R_DID_PREPOPULATE	(6) /* prepopulated readdir */
 #define CEPH_MDS_R_PARENT_LOCKED	(7) /* is r_parent->i_rwsem wlocked? */
 #define CEPH_MDS_R_ASYNC		(8) /* async request */
+#define CEPH_MDS_R_FSCRYPT_FILE		(9) /* must marshal fscrypt_file field */
 	unsigned long	r_req_flags;
 
 	struct mutex r_fill_mutex;
@@ -289,6 +290,7 @@ struct ceph_mds_request {
 	union ceph_mds_request_args r_args;
 
 	struct ceph_fscrypt_auth *r_fscrypt_auth;
+	u64	r_fscrypt_file;
 
 	u8 *r_altname;		    /* fscrypt binary crypttext for long filenames */
 	u32 r_altname_len;	    /* length of r_altname */
-- 
2.35.1

