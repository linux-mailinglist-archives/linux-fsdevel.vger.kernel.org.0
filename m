Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C1366962F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 12:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241198AbjAMLyG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 06:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241163AbjAMLwa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:52:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A58141D5F
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 03:50:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A994616B6
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 11:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772FBC433D2;
        Fri, 13 Jan 2023 11:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673610620;
        bh=9R7BcMuHd6I8LAw9NLfnhFfbY3W2jhpkvTR1LK5NyjQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=XczU2DhlmKskE8Z0j31fwOGyTw3jdT5Uf17h4bCaZYlQLsDYJF3p3wkEcuAzj011Z
         ulDuWR6NthS5S+mnvGDGzoyMLCIAslwwm3oA2bAXjJYB1OrludkJEseE8JoMg9TK8I
         mKJeLWyl2nvT9tGtIPQueFhoL1T2NGsyzisaBMWG9d3Wq7PgT7SDvOnki/ZayOyN4R
         prEFGYbYGgzA+q2TIA5eT5gqcPwhzPeUL43b0WLsJ5qfG/96hwwWfeW668XmmicShA
         7vLV9StwL9rMDDJ878drDY5q3ALwuddbx7B7FwFnVMHZHiq094DsHpjgVeguHcYZHo
         41asSHN6VZwVg==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 13 Jan 2023 12:49:32 +0100
Subject: [PATCH 24/25] fs: port vfs{g,u}id helpers to mnt_idmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230113-fs-idmapped-mnt_idmap-conversion-v1-24-fc84fa7eba67@kernel.org>
References: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
In-Reply-To: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        "Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: b4 0.12-dev-5b205
X-Developer-Signature: v=1; a=openpgp-sha256; l=37961; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9R7BcMuHd6I8LAw9NLfnhFfbY3W2jhpkvTR1LK5NyjQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQfdA0RsNHnv5D2Niqhpr1n17ztjQw/5jusOPrdUcf06VVN
 aynljlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInsZ2L4H/ehVWXOWYHlWubzq97a8t
 Svuzp9fas7/3OlkrAknqbi9YwMDfMtFZvSzTo+ad11mPfD633Hvnib9H9pX4Vf8xUuN7zDDgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert to struct mnt_idmap.

Last cycle we merged the necessary infrastructure in
256c8aed2b42 ("fs: introduce dedicated idmap type for mounts").
This is just the conversion to struct mnt_idmap.

Currently we still pass around the plain namespace that was attached to a
mount. This is in general pretty convenient but it makes it easy to
conflate namespaces that are relevant on the filesystem with namespaces
that are relevent on the mount level. Especially for non-vfs developers
without detailed knowledge in this area this can be a potential source for
bugs.

Once the conversion to struct mnt_idmap is done all helpers down to the
really low-level helpers will take a struct mnt_idmap argument instead of
two namespace arguments. This way it becomes impossible to conflate the two
eliminating the possibility of any bugs. All of the vfs and all filesystems
only operate on struct mnt_idmap.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/attr.c                     |  5 ++---
 fs/fat/file.c                 |  5 ++---
 fs/ksmbd/smb2pdu.c            |  9 ++------
 fs/ksmbd/smbacl.c             | 50 +++++++++++++++++++++----------------------
 fs/ksmbd/smbacl.h             | 12 +++++------
 fs/ksmbd/vfs.c                | 16 ++++++--------
 fs/open.c                     |  7 +++---
 fs/overlayfs/inode.c          | 10 ++++-----
 fs/posix_acl.c                | 17 ++++++---------
 fs/quota/dquot.c              |  5 ++---
 fs/xfs/xfs_iops.c             |  5 ++---
 include/linux/fs.h            | 14 ++++--------
 include/linux/mnt_idmapping.h | 40 +++++++++++++++++-----------------
 security/commoncap.c          |  9 +++-----
 14 files changed, 87 insertions(+), 117 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index a627ac74c4b1..1a100d392dd9 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -379,7 +379,6 @@ EXPORT_SYMBOL(may_setattr);
 int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct iattr *attr, struct inode **delegated_inode)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = dentry->d_inode;
 	umode_t mode = inode->i_mode;
 	int error;
@@ -453,11 +452,11 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 	 * namespace of the superblock.
 	 */
 	if (ia_valid & ATTR_UID &&
-	    !vfsuid_has_fsmapping(mnt_userns, inode->i_sb->s_user_ns,
+	    !vfsuid_has_fsmapping(idmap, inode->i_sb->s_user_ns,
 				  attr->ia_vfsuid))
 		return -EOVERFLOW;
 	if (ia_valid & ATTR_GID &&
-	    !vfsgid_has_fsmapping(mnt_userns, inode->i_sb->s_user_ns,
+	    !vfsgid_has_fsmapping(idmap, inode->i_sb->s_user_ns,
 				  attr->ia_vfsgid))
 		return -EOVERFLOW;
 
diff --git a/fs/fat/file.c b/fs/fat/file.c
index b48ad8acd2c5..795a4fad5c40 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -480,7 +480,6 @@ static int fat_allow_set_time(struct mnt_idmap *idmap,
 int fat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		struct iattr *attr)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct msdos_sb_info *sbi = MSDOS_SB(dentry->d_sb);
 	struct inode *inode = d_inode(dentry);
 	unsigned int ia_valid;
@@ -519,10 +518,10 @@ int fat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	}
 
 	if (((attr->ia_valid & ATTR_UID) &&
-	     (!uid_eq(from_vfsuid(mnt_userns, i_user_ns(inode), attr->ia_vfsuid),
+	     (!uid_eq(from_vfsuid(idmap, i_user_ns(inode), attr->ia_vfsuid),
 		      sbi->options.fs_uid))) ||
 	    ((attr->ia_valid & ATTR_GID) &&
-	     (!gid_eq(from_vfsgid(mnt_userns, i_user_ns(inode), attr->ia_vfsgid),
+	     (!gid_eq(from_vfsgid(idmap, i_user_ns(inode), attr->ia_vfsgid),
 		      sbi->options.fs_gid))) ||
 	    ((attr->ia_valid & ATTR_MODE) &&
 	     (attr->ia_mode & ~FAT_VALID_MODE)))
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 2d182aa31364..795984333bcb 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2513,7 +2513,6 @@ int smb2_open(struct ksmbd_work *work)
 	struct ksmbd_file *fp = NULL;
 	struct file *filp = NULL;
 	struct mnt_idmap *idmap = NULL;
-	struct user_namespace *user_ns = NULL;
 	struct kstat stat;
 	struct create_context *context;
 	struct lease_ctx_info *lc = NULL;
@@ -2767,7 +2766,6 @@ int smb2_open(struct ksmbd_work *work)
 	} else {
 		file_present = true;
 		idmap = mnt_idmap(path.mnt);
-		user_ns = mnt_idmap_owner(idmap);
 	}
 	if (stream_name) {
 		if (req->CreateOptions & FILE_DIRECTORY_FILE_LE) {
@@ -2867,7 +2865,6 @@ int smb2_open(struct ksmbd_work *work)
 
 		created = true;
 		idmap = mnt_idmap(path.mnt);
-		user_ns = mnt_idmap_owner(idmap);
 		if (ea_buf) {
 			if (le32_to_cpu(ea_buf->ccontext.DataLength) <
 			    sizeof(struct smb2_ea_info)) {
@@ -2999,7 +2996,7 @@ int smb2_open(struct ksmbd_work *work)
 					if (!pntsd)
 						goto err_out;
 
-					rc = build_sec_desc(user_ns,
+					rc = build_sec_desc(idmap,
 							    pntsd, NULL, 0,
 							    OWNER_SECINFO |
 							    GROUP_SECINFO |
@@ -5128,7 +5125,6 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
 {
 	struct ksmbd_file *fp;
 	struct mnt_idmap *idmap;
-	struct user_namespace *user_ns;
 	struct smb_ntsd *pntsd = (struct smb_ntsd *)rsp->Buffer, *ppntsd = NULL;
 	struct smb_fattr fattr = {{0}};
 	struct inode *inode;
@@ -5176,7 +5172,6 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
 		return -ENOENT;
 
 	idmap = file_mnt_idmap(fp->filp);
-	user_ns = mnt_idmap_owner(idmap);
 	inode = file_inode(fp->filp);
 	ksmbd_acls_fattr(&fattr, idmap, inode);
 
@@ -5188,7 +5183,7 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
 
 	/* Check if sd buffer size exceeds response buffer size */
 	if (smb2_resp_buf_len(work, 8) > ppntsd_size)
-		rc = build_sec_desc(user_ns, pntsd, ppntsd, ppntsd_size,
+		rc = build_sec_desc(idmap, pntsd, ppntsd, ppntsd_size,
 				    addition_info, &secdesclen, &fattr);
 	posix_acl_release(fattr.cf_acls);
 	posix_acl_release(fattr.cf_dacls);
diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index 31255290b435..6d6cfb6957a9 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -254,7 +254,7 @@ void id_to_sid(unsigned int cid, uint sidtype, struct smb_sid *ssid)
 	ssid->num_subauth++;
 }
 
-static int sid_to_id(struct user_namespace *user_ns,
+static int sid_to_id(struct mnt_idmap *idmap,
 		     struct smb_sid *psid, uint sidtype,
 		     struct smb_fattr *fattr)
 {
@@ -276,7 +276,7 @@ static int sid_to_id(struct user_namespace *user_ns,
 
 		id = le32_to_cpu(psid->sub_auth[psid->num_subauth - 1]);
 		uid = KUIDT_INIT(id);
-		uid = from_vfsuid(user_ns, &init_user_ns, VFSUIDT_INIT(uid));
+		uid = from_vfsuid(idmap, &init_user_ns, VFSUIDT_INIT(uid));
 		if (uid_valid(uid)) {
 			fattr->cf_uid = uid;
 			rc = 0;
@@ -287,7 +287,7 @@ static int sid_to_id(struct user_namespace *user_ns,
 
 		id = le32_to_cpu(psid->sub_auth[psid->num_subauth - 1]);
 		gid = KGIDT_INIT(id);
-		gid = from_vfsgid(user_ns, &init_user_ns, VFSGIDT_INIT(gid));
+		gid = from_vfsgid(idmap, &init_user_ns, VFSGIDT_INIT(gid));
 		if (gid_valid(gid)) {
 			fattr->cf_gid = gid;
 			rc = 0;
@@ -362,7 +362,7 @@ void free_acl_state(struct posix_acl_state *state)
 	kfree(state->groups);
 }
 
-static void parse_dacl(struct user_namespace *user_ns,
+static void parse_dacl(struct mnt_idmap *idmap,
 		       struct smb_acl *pdacl, char *end_of_acl,
 		       struct smb_sid *pownersid, struct smb_sid *pgrpsid,
 		       struct smb_fattr *fattr)
@@ -489,7 +489,7 @@ static void parse_dacl(struct user_namespace *user_ns,
 			acl_mode = access_flags_to_mode(fattr, ppace[i]->access_req,
 							ppace[i]->type);
 			temp_fattr.cf_uid = INVALID_UID;
-			ret = sid_to_id(user_ns, &ppace[i]->sid, SIDOWNER, &temp_fattr);
+			ret = sid_to_id(idmap, &ppace[i]->sid, SIDOWNER, &temp_fattr);
 			if (ret || uid_eq(temp_fattr.cf_uid, INVALID_UID)) {
 				pr_err("%s: Error %d mapping Owner SID to uid\n",
 				       __func__, ret);
@@ -575,7 +575,7 @@ static void parse_dacl(struct user_namespace *user_ns,
 	free_acl_state(&default_acl_state);
 }
 
-static void set_posix_acl_entries_dacl(struct user_namespace *user_ns,
+static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
 				       struct smb_ace *pndace,
 				       struct smb_fattr *fattr, u32 *num_aces,
 				       u16 *size, u32 nt_aces_num)
@@ -600,14 +600,14 @@ static void set_posix_acl_entries_dacl(struct user_namespace *user_ns,
 			uid_t uid;
 			unsigned int sid_type = SIDOWNER;
 
-			uid = posix_acl_uid_translate(user_ns, pace);
+			uid = posix_acl_uid_translate(idmap, pace);
 			if (!uid)
 				sid_type = SIDUNIX_USER;
 			id_to_sid(uid, sid_type, sid);
 		} else if (pace->e_tag == ACL_GROUP) {
 			gid_t gid;
 
-			gid = posix_acl_gid_translate(user_ns, pace);
+			gid = posix_acl_gid_translate(idmap, pace);
 			id_to_sid(gid, SIDUNIX_GROUP, sid);
 		} else if (pace->e_tag == ACL_OTHER && !nt_aces_num) {
 			smb_copy_sid(sid, &sid_everyone);
@@ -666,12 +666,12 @@ static void set_posix_acl_entries_dacl(struct user_namespace *user_ns,
 		if (pace->e_tag == ACL_USER) {
 			uid_t uid;
 
-			uid = posix_acl_uid_translate(user_ns, pace);
+			uid = posix_acl_uid_translate(idmap, pace);
 			id_to_sid(uid, SIDCREATOR_OWNER, sid);
 		} else if (pace->e_tag == ACL_GROUP) {
 			gid_t gid;
 
-			gid = posix_acl_gid_translate(user_ns, pace);
+			gid = posix_acl_gid_translate(idmap, pace);
 			id_to_sid(gid, SIDCREATOR_GROUP, sid);
 		} else {
 			kfree(sid);
@@ -689,7 +689,7 @@ static void set_posix_acl_entries_dacl(struct user_namespace *user_ns,
 	}
 }
 
-static void set_ntacl_dacl(struct user_namespace *user_ns,
+static void set_ntacl_dacl(struct mnt_idmap *idmap,
 			   struct smb_acl *pndacl,
 			   struct smb_acl *nt_dacl,
 			   unsigned int aces_size,
@@ -723,13 +723,13 @@ static void set_ntacl_dacl(struct user_namespace *user_ns,
 		}
 	}
 
-	set_posix_acl_entries_dacl(user_ns, pndace, fattr,
+	set_posix_acl_entries_dacl(idmap, pndace, fattr,
 				   &num_aces, &size, nt_num_aces);
 	pndacl->num_aces = cpu_to_le32(num_aces);
 	pndacl->size = cpu_to_le16(le16_to_cpu(pndacl->size) + size);
 }
 
-static void set_mode_dacl(struct user_namespace *user_ns,
+static void set_mode_dacl(struct mnt_idmap *idmap,
 			  struct smb_acl *pndacl, struct smb_fattr *fattr)
 {
 	struct smb_ace *pace, *pndace;
@@ -741,7 +741,7 @@ static void set_mode_dacl(struct user_namespace *user_ns,
 	pace = pndace = (struct smb_ace *)((char *)pndacl + sizeof(struct smb_acl));
 
 	if (fattr->cf_acls) {
-		set_posix_acl_entries_dacl(user_ns, pndace, fattr,
+		set_posix_acl_entries_dacl(idmap, pndace, fattr,
 					   &num_aces, &size, num_aces);
 		goto out;
 	}
@@ -808,7 +808,7 @@ static int parse_sid(struct smb_sid *psid, char *end_of_acl)
 }
 
 /* Convert CIFS ACL to POSIX form */
-int parse_sec_desc(struct user_namespace *user_ns, struct smb_ntsd *pntsd,
+int parse_sec_desc(struct mnt_idmap *idmap, struct smb_ntsd *pntsd,
 		   int acl_len, struct smb_fattr *fattr)
 {
 	int rc = 0;
@@ -851,7 +851,7 @@ int parse_sec_desc(struct user_namespace *user_ns, struct smb_ntsd *pntsd,
 			return rc;
 		}
 
-		rc = sid_to_id(user_ns, owner_sid_ptr, SIDOWNER, fattr);
+		rc = sid_to_id(idmap, owner_sid_ptr, SIDOWNER, fattr);
 		if (rc) {
 			pr_err("%s: Error %d mapping Owner SID to uid\n",
 			       __func__, rc);
@@ -866,7 +866,7 @@ int parse_sec_desc(struct user_namespace *user_ns, struct smb_ntsd *pntsd,
 			       __func__, rc);
 			return rc;
 		}
-		rc = sid_to_id(user_ns, group_sid_ptr, SIDUNIX_GROUP, fattr);
+		rc = sid_to_id(idmap, group_sid_ptr, SIDUNIX_GROUP, fattr);
 		if (rc) {
 			pr_err("%s: Error %d mapping Group SID to gid\n",
 			       __func__, rc);
@@ -881,7 +881,7 @@ int parse_sec_desc(struct user_namespace *user_ns, struct smb_ntsd *pntsd,
 		pntsd->type |= cpu_to_le16(DACL_PROTECTED);
 
 	if (dacloffset) {
-		parse_dacl(user_ns, dacl_ptr, end_of_acl,
+		parse_dacl(idmap, dacl_ptr, end_of_acl,
 			   owner_sid_ptr, group_sid_ptr, fattr);
 	}
 
@@ -889,7 +889,7 @@ int parse_sec_desc(struct user_namespace *user_ns, struct smb_ntsd *pntsd,
 }
 
 /* Convert permission bits from mode to equivalent CIFS ACL */
-int build_sec_desc(struct user_namespace *user_ns,
+int build_sec_desc(struct mnt_idmap *idmap,
 		   struct smb_ntsd *pntsd, struct smb_ntsd *ppntsd,
 		   int ppntsd_size, int addition_info, __u32 *secdesclen,
 		   struct smb_fattr *fattr)
@@ -950,7 +950,7 @@ int build_sec_desc(struct user_namespace *user_ns,
 		dacl_ptr->num_aces = 0;
 
 		if (!ppntsd) {
-			set_mode_dacl(user_ns, dacl_ptr, fattr);
+			set_mode_dacl(idmap, dacl_ptr, fattr);
 		} else {
 			struct smb_acl *ppdacl_ptr;
 			unsigned int dacl_offset = le32_to_cpu(ppntsd->dacloffset);
@@ -966,7 +966,7 @@ int build_sec_desc(struct user_namespace *user_ns,
 			    ppdacl_size < sizeof(struct smb_acl))
 				goto out;
 
-			set_ntacl_dacl(user_ns, dacl_ptr, ppdacl_ptr,
+			set_ntacl_dacl(idmap, dacl_ptr, ppdacl_ptr,
 				       ntacl_size - sizeof(struct smb_acl),
 				       nowner_sid_ptr, ngroup_sid_ptr,
 				       fattr);
@@ -1191,7 +1191,6 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			__le32 *pdaccess, int uid)
 {
 	struct mnt_idmap *idmap = mnt_idmap(path->mnt);
-	struct user_namespace *user_ns = mnt_idmap_owner(idmap);
 	struct smb_ntsd *pntsd = NULL;
 	struct smb_acl *pdacl;
 	struct posix_acl *posix_acls;
@@ -1297,9 +1296,9 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			pa_entry = posix_acls->a_entries;
 			for (i = 0; i < posix_acls->a_count; i++, pa_entry++) {
 				if (pa_entry->e_tag == ACL_USER)
-					id = posix_acl_uid_translate(user_ns, pa_entry);
+					id = posix_acl_uid_translate(idmap, pa_entry);
 				else if (pa_entry->e_tag == ACL_GROUP)
-					id = posix_acl_gid_translate(user_ns, pa_entry);
+					id = posix_acl_gid_translate(idmap, pa_entry);
 				else
 					continue;
 
@@ -1362,14 +1361,13 @@ int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 	struct smb_fattr fattr = {{0}};
 	struct inode *inode = d_inode(path->dentry);
 	struct mnt_idmap *idmap = mnt_idmap(path->mnt);
-	struct user_namespace *user_ns = mnt_idmap_owner(idmap);
 	struct iattr newattrs;
 
 	fattr.cf_uid = INVALID_UID;
 	fattr.cf_gid = INVALID_GID;
 	fattr.cf_mode = inode->i_mode;
 
-	rc = parse_sec_desc(user_ns, pntsd, ntsd_len, &fattr);
+	rc = parse_sec_desc(idmap, pntsd, ntsd_len, &fattr);
 	if (rc)
 		goto out;
 
diff --git a/fs/ksmbd/smbacl.h b/fs/ksmbd/smbacl.h
index 618f2e0236b3..49a8c292bd2e 100644
--- a/fs/ksmbd/smbacl.h
+++ b/fs/ksmbd/smbacl.h
@@ -190,9 +190,9 @@ struct posix_acl_state {
 	struct posix_ace_state_array *groups;
 };
 
-int parse_sec_desc(struct user_namespace *user_ns, struct smb_ntsd *pntsd,
+int parse_sec_desc(struct mnt_idmap *idmap, struct smb_ntsd *pntsd,
 		   int acl_len, struct smb_fattr *fattr);
-int build_sec_desc(struct user_namespace *user_ns, struct smb_ntsd *pntsd,
+int build_sec_desc(struct mnt_idmap *idmap, struct smb_ntsd *pntsd,
 		   struct smb_ntsd *ppntsd, int ppntsd_size, int addition_info,
 		   __u32 *secdesclen, struct smb_fattr *fattr);
 int init_acl_state(struct posix_acl_state *state, int cnt);
@@ -211,25 +211,25 @@ int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 void id_to_sid(unsigned int cid, uint sidtype, struct smb_sid *ssid);
 void ksmbd_init_domain(u32 *sub_auth);
 
-static inline uid_t posix_acl_uid_translate(struct user_namespace *mnt_userns,
+static inline uid_t posix_acl_uid_translate(struct mnt_idmap *idmap,
 					    struct posix_acl_entry *pace)
 {
 	vfsuid_t vfsuid;
 
 	/* If this is an idmapped mount, apply the idmapping. */
-	vfsuid = make_vfsuid(mnt_userns, &init_user_ns, pace->e_uid);
+	vfsuid = make_vfsuid(idmap, &init_user_ns, pace->e_uid);
 
 	/* Translate the kuid into a userspace id ksmbd would see. */
 	return from_kuid(&init_user_ns, vfsuid_into_kuid(vfsuid));
 }
 
-static inline gid_t posix_acl_gid_translate(struct user_namespace *mnt_userns,
+static inline gid_t posix_acl_gid_translate(struct mnt_idmap *idmap,
 					    struct posix_acl_entry *pace)
 {
 	vfsgid_t vfsgid;
 
 	/* If this is an idmapped mount, apply the idmapping. */
-	vfsgid = make_vfsgid(mnt_userns, &init_user_ns, pace->e_gid);
+	vfsgid = make_vfsgid(idmap, &init_user_ns, pace->e_gid);
 
 	/* Translate the kgid into a userspace id ksmbd would see. */
 	return from_kgid(&init_user_ns, vfsgid_into_kgid(vfsgid));
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index a1b3e4ef8045..fb699a62e68e 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -1362,7 +1362,7 @@ int ksmbd_vfs_remove_sd_xattrs(struct mnt_idmap *idmap,
 	return err;
 }
 
-static struct xattr_smb_acl *ksmbd_vfs_make_xattr_posix_acl(struct user_namespace *user_ns,
+static struct xattr_smb_acl *ksmbd_vfs_make_xattr_posix_acl(struct mnt_idmap *idmap,
 							    struct inode *inode,
 							    int acl_type)
 {
@@ -1392,14 +1392,14 @@ static struct xattr_smb_acl *ksmbd_vfs_make_xattr_posix_acl(struct user_namespac
 		switch (pa_entry->e_tag) {
 		case ACL_USER:
 			xa_entry->type = SMB_ACL_USER;
-			xa_entry->uid = posix_acl_uid_translate(user_ns, pa_entry);
+			xa_entry->uid = posix_acl_uid_translate(idmap, pa_entry);
 			break;
 		case ACL_USER_OBJ:
 			xa_entry->type = SMB_ACL_USER_OBJ;
 			break;
 		case ACL_GROUP:
 			xa_entry->type = SMB_ACL_GROUP;
-			xa_entry->gid = posix_acl_gid_translate(user_ns, pa_entry);
+			xa_entry->gid = posix_acl_gid_translate(idmap, pa_entry);
 			break;
 		case ACL_GROUP_OBJ:
 			xa_entry->type = SMB_ACL_GROUP_OBJ;
@@ -1433,7 +1433,6 @@ int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn,
 			   struct smb_ntsd *pntsd, int len)
 {
 	int rc;
-	struct user_namespace *user_ns = mnt_idmap_owner(idmap);
 	struct ndr sd_ndr = {0}, acl_ndr = {0};
 	struct xattr_ntacl acl = {0};
 	struct xattr_smb_acl *smb_acl, *def_smb_acl = NULL;
@@ -1462,10 +1461,10 @@ int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn,
 		return rc;
 	}
 
-	smb_acl = ksmbd_vfs_make_xattr_posix_acl(user_ns, inode,
+	smb_acl = ksmbd_vfs_make_xattr_posix_acl(idmap, inode,
 						 ACL_TYPE_ACCESS);
 	if (S_ISDIR(inode->i_mode))
-		def_smb_acl = ksmbd_vfs_make_xattr_posix_acl(user_ns, inode,
+		def_smb_acl = ksmbd_vfs_make_xattr_posix_acl(idmap, inode,
 							     ACL_TYPE_DEFAULT);
 
 	rc = ndr_encode_posix_acl(&acl_ndr, idmap, inode,
@@ -1508,7 +1507,6 @@ int ksmbd_vfs_get_sd_xattr(struct ksmbd_conn *conn,
 			   struct smb_ntsd **pntsd)
 {
 	int rc;
-	struct user_namespace *user_ns = mnt_idmap_owner(idmap);
 	struct ndr n;
 	struct inode *inode = d_inode(dentry);
 	struct ndr acl_ndr = {0};
@@ -1525,10 +1523,10 @@ int ksmbd_vfs_get_sd_xattr(struct ksmbd_conn *conn,
 	if (rc)
 		goto free_n_data;
 
-	smb_acl = ksmbd_vfs_make_xattr_posix_acl(user_ns, inode,
+	smb_acl = ksmbd_vfs_make_xattr_posix_acl(idmap, inode,
 						 ACL_TYPE_ACCESS);
 	if (S_ISDIR(inode->i_mode))
-		def_smb_acl = ksmbd_vfs_make_xattr_posix_acl(user_ns, inode,
+		def_smb_acl = ksmbd_vfs_make_xattr_posix_acl(idmap, inode,
 							     ACL_TYPE_DEFAULT);
 
 	rc = ndr_encode_posix_acl(&acl_ndr, idmap, inode, smb_acl,
diff --git a/fs/open.c b/fs/open.c
index e9e5da4815a9..f9d48da3c630 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -702,7 +702,7 @@ static inline bool setattr_vfsgid(struct iattr *attr, kgid_t kgid)
 int chown_common(const struct path *path, uid_t user, gid_t group)
 {
 	struct mnt_idmap *idmap;
-	struct user_namespace *mnt_userns, *fs_userns;
+	struct user_namespace *fs_userns;
 	struct inode *inode = path->dentry->d_inode;
 	struct inode *delegated_inode = NULL;
 	int error;
@@ -714,7 +714,6 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 	gid = make_kgid(current_user_ns(), group);
 
 	idmap = mnt_idmap(path->mnt);
-	mnt_userns = mnt_idmap_owner(idmap);
 	fs_userns = i_user_ns(inode);
 
 retry_deleg:
@@ -732,8 +731,8 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 	/* Continue to send actual fs values, not the mount values. */
 	error = security_path_chown(
 		path,
-		from_vfsuid(mnt_userns, fs_userns, newattrs.ia_vfsuid),
-		from_vfsgid(mnt_userns, fs_userns, newattrs.ia_vfsgid));
+		from_vfsuid(idmap, fs_userns, newattrs.ia_vfsuid),
+		from_vfsgid(idmap, fs_userns, newattrs.ia_vfsgid));
 	if (!error)
 		error = notify_change(idmap, path->dentry, &newattrs,
 				      &delegated_inode);
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 4e56d0cb7cce..541cf3717fc2 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -463,7 +463,7 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
  * alter the POSIX ACLs for the underlying filesystem.
  */
 static void ovl_idmap_posix_acl(const struct inode *realinode,
-				struct user_namespace *mnt_userns,
+				struct mnt_idmap *idmap,
 				struct posix_acl *acl)
 {
 	struct user_namespace *fs_userns = i_user_ns(realinode);
@@ -475,11 +475,11 @@ static void ovl_idmap_posix_acl(const struct inode *realinode,
 		struct posix_acl_entry *e = &acl->a_entries[i];
 		switch (e->e_tag) {
 		case ACL_USER:
-			vfsuid = make_vfsuid(mnt_userns, fs_userns, e->e_uid);
+			vfsuid = make_vfsuid(idmap, fs_userns, e->e_uid);
 			e->e_uid = vfsuid_into_kuid(vfsuid);
 			break;
 		case ACL_GROUP:
-			vfsgid = make_vfsgid(mnt_userns, fs_userns, e->e_gid);
+			vfsgid = make_vfsgid(idmap, fs_userns, e->e_gid);
 			e->e_gid = vfsgid_into_kgid(vfsgid);
 			break;
 		}
@@ -514,12 +514,10 @@ struct posix_acl *ovl_get_acl_path(const struct path *path,
 				   const char *acl_name, bool noperm)
 {
 	struct posix_acl *real_acl, *clone;
-	struct user_namespace *mnt_userns;
 	struct mnt_idmap *idmap;
 	struct inode *realinode = d_inode(path->dentry);
 
 	idmap = mnt_idmap(path->mnt);
-	mnt_userns = mnt_idmap_owner(idmap);
 
 	if (noperm)
 		real_acl = get_inode_acl(realinode, posix_acl_type(acl_name));
@@ -542,7 +540,7 @@ struct posix_acl *ovl_get_acl_path(const struct path *path,
 	if (!clone)
 		return ERR_PTR(-ENOMEM);
 
-	ovl_idmap_posix_acl(realinode, mnt_userns, clone);
+	ovl_idmap_posix_acl(realinode, idmap, clone);
 	return clone;
 }
 
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 7e0a8a068f98..8cc52110f1f9 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -377,7 +377,6 @@ posix_acl_permission(struct mnt_idmap *idmap, struct inode *inode,
 {
 	const struct posix_acl_entry *pa, *pe, *mask_obj;
 	struct user_namespace *fs_userns = i_user_ns(inode);
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	int found = 0;
 	vfsuid_t vfsuid;
 	vfsgid_t vfsgid;
@@ -393,7 +392,7 @@ posix_acl_permission(struct mnt_idmap *idmap, struct inode *inode,
                                         goto check_perm;
                                 break;
                         case ACL_USER:
-				vfsuid = make_vfsuid(mnt_userns, fs_userns,
+				vfsuid = make_vfsuid(idmap, fs_userns,
 						     pa->e_uid);
 				if (vfsuid_eq_kuid(vfsuid, current_fsuid()))
                                         goto mask;
@@ -407,7 +406,7 @@ posix_acl_permission(struct mnt_idmap *idmap, struct inode *inode,
                                 }
 				break;
                         case ACL_GROUP:
-				vfsgid = make_vfsgid(mnt_userns, fs_userns,
+				vfsgid = make_vfsgid(idmap, fs_userns,
 						     pa->e_gid);
 				if (vfsgid_in_group_p(vfsgid)) {
 					found = 1;
@@ -894,7 +893,6 @@ static ssize_t vfs_posix_acl_to_xattr(struct mnt_idmap *idmap,
 	struct posix_acl_xattr_header *ext_acl = buffer;
 	struct posix_acl_xattr_entry *ext_entry;
 	struct user_namespace *fs_userns, *caller_userns;
-	struct user_namespace *mnt_userns;
 	ssize_t real_size, n;
 	vfsuid_t vfsuid;
 	vfsgid_t vfsgid;
@@ -910,19 +908,18 @@ static ssize_t vfs_posix_acl_to_xattr(struct mnt_idmap *idmap,
 
 	fs_userns = i_user_ns(inode);
 	caller_userns = current_user_ns();
-	mnt_userns = mnt_idmap_owner(idmap);
 	for (n=0; n < acl->a_count; n++, ext_entry++) {
 		const struct posix_acl_entry *acl_e = &acl->a_entries[n];
 		ext_entry->e_tag  = cpu_to_le16(acl_e->e_tag);
 		ext_entry->e_perm = cpu_to_le16(acl_e->e_perm);
 		switch(acl_e->e_tag) {
 		case ACL_USER:
-			vfsuid = make_vfsuid(mnt_userns, fs_userns, acl_e->e_uid);
+			vfsuid = make_vfsuid(idmap, fs_userns, acl_e->e_uid);
 			ext_entry->e_id = cpu_to_le32(from_kuid(
 				caller_userns, vfsuid_into_kuid(vfsuid)));
 			break;
 		case ACL_GROUP:
-			vfsgid = make_vfsgid(mnt_userns, fs_userns, acl_e->e_gid);
+			vfsgid = make_vfsgid(idmap, fs_userns, acl_e->e_gid);
 			ext_entry->e_id = cpu_to_le32(from_kgid(
 				caller_userns, vfsgid_into_kgid(vfsgid)));
 			break;
@@ -1022,18 +1019,16 @@ static int vfs_set_acl_idmapped_mnt(struct mnt_idmap *idmap,
 				    struct user_namespace *fs_userns,
 				    struct posix_acl *acl)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
-
 	for (int n = 0; n < acl->a_count; n++) {
 		struct posix_acl_entry *acl_e = &acl->a_entries[n];
 
 		switch (acl_e->e_tag) {
 		case ACL_USER:
-			acl_e->e_uid = from_vfsuid(mnt_userns, fs_userns,
+			acl_e->e_uid = from_vfsuid(idmap, fs_userns,
 						   VFSUIDT_INIT(acl_e->e_uid));
 			break;
 		case ACL_GROUP:
-			acl_e->e_gid = from_vfsgid(mnt_userns, fs_userns,
+			acl_e->e_gid = from_vfsgid(idmap, fs_userns,
 						   VFSGIDT_INIT(acl_e->e_gid));
 			break;
 		}
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 207434a854f3..a6357f728034 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2088,7 +2088,6 @@ EXPORT_SYMBOL(__dquot_transfer);
 int dquot_transfer(struct mnt_idmap *idmap, struct inode *inode,
 		   struct iattr *iattr)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct dquot *transfer_to[MAXQUOTAS] = {};
 	struct dquot *dquot;
 	struct super_block *sb = inode->i_sb;
@@ -2098,7 +2097,7 @@ int dquot_transfer(struct mnt_idmap *idmap, struct inode *inode,
 		return 0;
 
 	if (i_uid_needs_update(idmap, iattr, inode)) {
-		kuid_t kuid = from_vfsuid(mnt_userns, i_user_ns(inode),
+		kuid_t kuid = from_vfsuid(idmap, i_user_ns(inode),
 					  iattr->ia_vfsuid);
 
 		dquot = dqget(sb, make_kqid_uid(kuid));
@@ -2112,7 +2111,7 @@ int dquot_transfer(struct mnt_idmap *idmap, struct inode *inode,
 		transfer_to[USRQUOTA] = dquot;
 	}
 	if (i_gid_needs_update(idmap, iattr, inode)) {
-		kgid_t kgid = from_vfsgid(mnt_userns, i_user_ns(inode),
+		kgid_t kgid = from_vfsgid(idmap, i_user_ns(inode),
 					  iattr->ia_vfsgid);
 
 		dquot = dqget(sb, make_kqid_gid(kgid));
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index d54423311831..24718adb3c16 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -663,7 +663,6 @@ xfs_setattr_nonsize(
 	kgid_t			gid = GLOBAL_ROOT_GID;
 	struct xfs_dquot	*udqp = NULL, *gdqp = NULL;
 	struct xfs_dquot	*old_udqp = NULL, *old_gdqp = NULL;
-	struct user_namespace	*mnt_userns = mnt_idmap_owner(idmap);
 
 	ASSERT((mask & ATTR_SIZE) == 0);
 
@@ -679,14 +678,14 @@ xfs_setattr_nonsize(
 		uint	qflags = 0;
 
 		if ((mask & ATTR_UID) && XFS_IS_UQUOTA_ON(mp)) {
-			uid = from_vfsuid(mnt_userns, i_user_ns(inode),
+			uid = from_vfsuid(idmap, i_user_ns(inode),
 					  iattr->ia_vfsuid);
 			qflags |= XFS_QMOPT_UQUOTA;
 		} else {
 			uid = inode->i_uid;
 		}
 		if ((mask & ATTR_GID) && XFS_IS_GQUOTA_ON(mp)) {
-			gid = from_vfsgid(mnt_userns, i_user_ns(inode),
+			gid = from_vfsgid(idmap, i_user_ns(inode),
 					  iattr->ia_vfsgid);
 			qflags |= XFS_QMOPT_GQUOTA;
 		}  else {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 54a95ed68322..bd040fe31014 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1642,8 +1642,7 @@ static inline void i_gid_write(struct inode *inode, gid_t gid)
 static inline vfsuid_t i_uid_into_vfsuid(struct mnt_idmap *idmap,
 					 const struct inode *inode)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
-	return make_vfsuid(mnt_userns, i_user_ns(inode), inode->i_uid);
+	return make_vfsuid(idmap, i_user_ns(inode), inode->i_uid);
 }
 
 /**
@@ -1679,10 +1678,8 @@ static inline void i_uid_update(struct mnt_idmap *idmap,
 				const struct iattr *attr,
 				struct inode *inode)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
-
 	if (attr->ia_valid & ATTR_UID)
-		inode->i_uid = from_vfsuid(mnt_userns, i_user_ns(inode),
+		inode->i_uid = from_vfsuid(idmap, i_user_ns(inode),
 					   attr->ia_vfsuid);
 }
 
@@ -1697,8 +1694,7 @@ static inline void i_uid_update(struct mnt_idmap *idmap,
 static inline vfsgid_t i_gid_into_vfsgid(struct mnt_idmap *idmap,
 					 const struct inode *inode)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
-	return make_vfsgid(mnt_userns, i_user_ns(inode), inode->i_gid);
+	return make_vfsgid(idmap, i_user_ns(inode), inode->i_gid);
 }
 
 /**
@@ -1734,10 +1730,8 @@ static inline void i_gid_update(struct mnt_idmap *idmap,
 				const struct iattr *attr,
 				struct inode *inode)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
-
 	if (attr->ia_valid & ATTR_GID)
-		inode->i_gid = from_vfsgid(mnt_userns, i_user_ns(inode),
+		inode->i_gid = from_vfsgid(idmap, i_user_ns(inode),
 					   attr->ia_vfsgid);
 }
 
diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
index d63e7c84a389..53d42b0b6f17 100644
--- a/include/linux/mnt_idmapping.h
+++ b/include/linux/mnt_idmapping.h
@@ -170,7 +170,7 @@ static inline bool no_idmapping(const struct user_namespace *mnt_userns,
 
 /**
  * make_vfsuid - map a filesystem kuid into a mnt_userns
- * @mnt_userns: the mount's idmapping
+ * @idmap: the mount's idmapping
  * @fs_userns: the filesystem's idmapping
  * @kuid : kuid to be mapped
  *
@@ -189,11 +189,12 @@ static inline bool no_idmapping(const struct user_namespace *mnt_userns,
  * returned.
  */
 
-static inline vfsuid_t make_vfsuid(struct user_namespace *mnt_userns,
+static inline vfsuid_t make_vfsuid(struct mnt_idmap *idmap,
 				   struct user_namespace *fs_userns,
 				   kuid_t kuid)
 {
 	uid_t uid;
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
 	if (no_idmapping(mnt_userns, fs_userns))
 		return VFSUIDT_INIT(kuid);
@@ -208,7 +209,7 @@ static inline vfsuid_t make_vfsuid(struct user_namespace *mnt_userns,
 
 /**
  * make_vfsgid - map a filesystem kgid into a mnt_userns
- * @mnt_userns: the mount's idmapping
+ * @idmap: the mount's idmapping
  * @fs_userns: the filesystem's idmapping
  * @kgid : kgid to be mapped
  *
@@ -227,11 +228,12 @@ static inline vfsuid_t make_vfsuid(struct user_namespace *mnt_userns,
  * returned.
  */
 
-static inline vfsgid_t make_vfsgid(struct user_namespace *mnt_userns,
+static inline vfsgid_t make_vfsgid(struct mnt_idmap *idmap,
 				   struct user_namespace *fs_userns,
 				   kgid_t kgid)
 {
 	gid_t gid;
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
 	if (no_idmapping(mnt_userns, fs_userns))
 		return VFSGIDT_INIT(kgid);
@@ -246,7 +248,7 @@ static inline vfsgid_t make_vfsgid(struct user_namespace *mnt_userns,
 
 /**
  * from_vfsuid - map a vfsuid into the filesystem idmapping
- * @mnt_userns: the mount's idmapping
+ * @idmap: the mount's idmapping
  * @fs_userns: the filesystem's idmapping
  * @vfsuid : vfsuid to be mapped
  *
@@ -255,11 +257,12 @@ static inline vfsgid_t make_vfsgid(struct user_namespace *mnt_userns,
  *
  * Return: @vfsuid mapped into the filesystem idmapping
  */
-static inline kuid_t from_vfsuid(struct user_namespace *mnt_userns,
+static inline kuid_t from_vfsuid(struct mnt_idmap *idmap,
 				 struct user_namespace *fs_userns,
 				 vfsuid_t vfsuid)
 {
 	uid_t uid;
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
 	if (no_idmapping(mnt_userns, fs_userns))
 		return AS_KUIDT(vfsuid);
@@ -273,7 +276,7 @@ static inline kuid_t from_vfsuid(struct user_namespace *mnt_userns,
 
 /**
  * vfsuid_has_fsmapping - check whether a vfsuid maps into the filesystem
- * @mnt_userns: the mount's idmapping
+ * @idmap: the mount's idmapping
  * @fs_userns: the filesystem's idmapping
  * @vfsuid: vfsuid to be mapped
  *
@@ -283,11 +286,11 @@ static inline kuid_t from_vfsuid(struct user_namespace *mnt_userns,
  *
  * Return: true if @vfsuid has a mapping in the filesystem, false if not.
  */
-static inline bool vfsuid_has_fsmapping(struct user_namespace *mnt_userns,
+static inline bool vfsuid_has_fsmapping(struct mnt_idmap *idmap,
 					struct user_namespace *fs_userns,
 					vfsuid_t vfsuid)
 {
-	return uid_valid(from_vfsuid(mnt_userns, fs_userns, vfsuid));
+	return uid_valid(from_vfsuid(idmap, fs_userns, vfsuid));
 }
 
 static inline bool vfsuid_has_mapping(struct user_namespace *userns,
@@ -311,7 +314,7 @@ static inline kuid_t vfsuid_into_kuid(vfsuid_t vfsuid)
 
 /**
  * from_vfsgid - map a vfsgid into the filesystem idmapping
- * @mnt_userns: the mount's idmapping
+ * @idmap: the mount's idmapping
  * @fs_userns: the filesystem's idmapping
  * @vfsgid : vfsgid to be mapped
  *
@@ -320,11 +323,12 @@ static inline kuid_t vfsuid_into_kuid(vfsuid_t vfsuid)
  *
  * Return: @vfsgid mapped into the filesystem idmapping
  */
-static inline kgid_t from_vfsgid(struct user_namespace *mnt_userns,
+static inline kgid_t from_vfsgid(struct mnt_idmap *idmap,
 				 struct user_namespace *fs_userns,
 				 vfsgid_t vfsgid)
 {
 	gid_t gid;
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
 	if (no_idmapping(mnt_userns, fs_userns))
 		return AS_KGIDT(vfsgid);
@@ -338,7 +342,7 @@ static inline kgid_t from_vfsgid(struct user_namespace *mnt_userns,
 
 /**
  * vfsgid_has_fsmapping - check whether a vfsgid maps into the filesystem
- * @mnt_userns: the mount's idmapping
+ * @idmap: the mount's idmapping
  * @fs_userns: the filesystem's idmapping
  * @vfsgid: vfsgid to be mapped
  *
@@ -348,11 +352,11 @@ static inline kgid_t from_vfsgid(struct user_namespace *mnt_userns,
  *
  * Return: true if @vfsgid has a mapping in the filesystem, false if not.
  */
-static inline bool vfsgid_has_fsmapping(struct user_namespace *mnt_userns,
+static inline bool vfsgid_has_fsmapping(struct mnt_idmap *idmap,
 					struct user_namespace *fs_userns,
 					vfsgid_t vfsgid)
 {
-	return gid_valid(from_vfsgid(mnt_userns, fs_userns, vfsgid));
+	return gid_valid(from_vfsgid(idmap, fs_userns, vfsgid));
 }
 
 static inline bool vfsgid_has_mapping(struct user_namespace *userns,
@@ -390,9 +394,7 @@ static inline kgid_t vfsgid_into_kgid(vfsgid_t vfsgid)
 static inline kuid_t mapped_fsuid(struct mnt_idmap *idmap,
 				  struct user_namespace *fs_userns)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
-	return from_vfsuid(mnt_userns, fs_userns,
-			   VFSUIDT_INIT(current_fsuid()));
+	return from_vfsuid(idmap, fs_userns, VFSUIDT_INIT(current_fsuid()));
 }
 
 /**
@@ -411,9 +413,7 @@ static inline kuid_t mapped_fsuid(struct mnt_idmap *idmap,
 static inline kgid_t mapped_fsgid(struct mnt_idmap *idmap,
 				  struct user_namespace *fs_userns)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
-	return from_vfsgid(mnt_userns, fs_userns,
-			   VFSGIDT_INIT(current_fsgid()));
+	return from_vfsgid(idmap, fs_userns, VFSGIDT_INIT(current_fsgid()));
 }
 
 #endif /* _LINUX_MNT_IDMAPPING_H */
diff --git a/security/commoncap.c b/security/commoncap.c
index beda11fa50f9..aec62db55271 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -391,7 +391,6 @@ int cap_inode_getsecurity(struct mnt_idmap *idmap,
 	struct vfs_ns_cap_data *nscap = NULL;
 	struct dentry *dentry;
 	struct user_namespace *fs_ns;
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
 	if (strcmp(name, "capability") != 0)
 		return -EOPNOTSUPP;
@@ -421,7 +420,7 @@ int cap_inode_getsecurity(struct mnt_idmap *idmap,
 	kroot = make_kuid(fs_ns, root);
 
 	/* If this is an idmapped mount shift the kuid. */
-	vfsroot = make_vfsuid(mnt_userns, fs_ns, kroot);
+	vfsroot = make_vfsuid(idmap, fs_ns, kroot);
 
 	/* If the root kuid maps to a valid uid in current ns, then return
 	 * this as a nscap. */
@@ -537,7 +536,6 @@ int cap_convert_nscap(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct inode *inode = d_backing_inode(dentry);
 	struct user_namespace *task_ns = current_user_ns(),
 		*fs_ns = inode->i_sb->s_user_ns;
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	kuid_t rootid;
 	vfsuid_t vfsrootid;
 	size_t newsize;
@@ -557,7 +555,7 @@ int cap_convert_nscap(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (!vfsuid_valid(vfsrootid))
 		return -EINVAL;
 
-	rootid = from_vfsuid(mnt_userns, fs_ns, vfsrootid);
+	rootid = from_vfsuid(idmap, fs_ns, vfsrootid);
 	if (!uid_valid(rootid))
 		return -EINVAL;
 
@@ -653,7 +651,6 @@ int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
 	kuid_t rootkuid;
 	vfsuid_t rootvfsuid;
 	struct user_namespace *fs_ns;
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
 	memset(cpu_caps, 0, sizeof(struct cpu_vfs_cap_data));
 
@@ -698,7 +695,7 @@ int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
 		return -EINVAL;
 	}
 
-	rootvfsuid = make_vfsuid(mnt_userns, fs_ns, rootkuid);
+	rootvfsuid = make_vfsuid(idmap, fs_ns, rootkuid);
 	if (!vfsuid_valid(rootvfsuid))
 		return -ENODATA;
 

-- 
2.34.1

