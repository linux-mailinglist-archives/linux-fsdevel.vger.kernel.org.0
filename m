Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9812D602AB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 13:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiJRL5v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 07:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiJRL5l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:57:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A99BCB91;
        Tue, 18 Oct 2022 04:57:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB8CBB81EB9;
        Tue, 18 Oct 2022 11:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B58C433C1;
        Tue, 18 Oct 2022 11:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666094250;
        bh=nMvDos0wDSXRAJATVJ1eXAK1Wd17VvBI4D4zo6OOL20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=quguapL8kYaefPRaCkcko3qMqQTkaB7siMzZO9fWpbtTnP2DdHArBWdWfC9ZdiGSB
         RrdSnzXLrIGTx9UAHkT3MEPF+lMr2TNCYXB2dUbm1htkC9t07sC7BJK35p664jg22d
         FHBUxuW6gYMtTcu0IUBX8hVChZvPDiwx4ROrASPPqrW/Qf4Oh8oRigaEmadMQ9WYfG
         iDBJqrjwZZ10xsZZETxbEYWIFT+cIWyHQ4ludCALiLS6pYN1RqchSiDg0xndXmxLwh
         5eO/T2WTPrhPwLicpJ0EMD33AI3lfO/hP66pOwxaiqD3jMz20FTxaXaj8rJkXC/z+m
         nSVk+GhTFp4Cg==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Hyunchul Lee <hyc.lee@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-cifs@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v5 05/30] cifs: implement get acl method
Date:   Tue, 18 Oct 2022 13:56:35 +0200
Message-Id: <20221018115700.166010-6-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018115700.166010-1-brauner@kernel.org>
References: <20221018115700.166010-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13060; i=brauner@kernel.org; h=from:subject; bh=nMvDos0wDSXRAJATVJ1eXAK1Wd17VvBI4D4zo6OOL20=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST7TVHdzLw+SELa0KDAMtczra5JP+sUc/mHqc9OT/i3M8JF TDmoo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJBFowMm1JuZaQfa/eslPgr8fH/rV qZ9b6FP7VbGPRPlP5s7dNuYGTo3Rzq8DviUdDho8v2VCm9eF9es/OXmZ6r0R9pk7PpV86wAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current way of setting and getting posix acls through the generic
xattr interface is error prone and type unsafe. The vfs needs to
interpret and fixup posix acls before storing or reporting it to
userspace. Various hacks exist to make this work. The code is hard to
understand and difficult to maintain in it's current form. Instead of
making this work by hacking posix acls through xattr handlers we are
building a dedicated posix acl api around the get and set inode
operations. This removes a lot of hackiness and makes the codepaths
easier to maintain. A lot of background can be found in [1].

In order to build a type safe posix api around get and set acl we need
all filesystem to implement get and set acl.

So far cifs wasn't able to implement get and set acl inode operations
because it needs access to the dentry. Now that we extended the set acl
inode operation to take a dentry argument and added a new get acl inode
operation that takes a dentry argument we can let cifs implement get and
set acl inode operations.

This is mostly a copy and paste of the codepaths currently used in cifs'
posix acl xattr handler. After we have fully implemented the posix acl
api and switched the vfs over to it, the cifs specific posix acl xattr
handler and associated code will be removed and the code duplication
will go away.

Note, until the vfs has been switched to the new posix acl api this
patch is a non-functional change.

Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    Christian Brauner (Microsoft) <brauner@kernel.org>:
    - Surface acl error in all cases.
    
    /* v3 */
    unchanged
    
    /* v4 */
    unchanged
    
    /* v5 */
    unchanged

 fs/cifs/cifsacl.c   |  67 +++++++++++++++
 fs/cifs/cifsfs.c    |   2 +
 fs/cifs/cifsproto.h |   6 ++
 fs/cifs/cifssmb.c   | 196 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 271 insertions(+)

diff --git a/fs/cifs/cifsacl.c b/fs/cifs/cifsacl.c
index fa480d62f313..a6730e0eb57b 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -13,6 +13,7 @@
 #include <linux/string.h>
 #include <linux/keyctl.h>
 #include <linux/key-type.h>
+#include <uapi/linux/posix_acl.h>
 #include <keys/user-type.h>
 #include "cifspdu.h"
 #include "cifsglob.h"
@@ -20,6 +21,8 @@
 #include "cifsproto.h"
 #include "cifs_debug.h"
 #include "fs_context.h"
+#include "cifs_fs_sb.h"
+#include "cifs_unicode.h"
 
 /* security id for everyone/world system group */
 static const struct cifs_sid sid_everyone = {
@@ -1668,3 +1671,67 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 	kfree(pntsd);
 	return rc;
 }
+
+struct posix_acl *cifs_get_acl(struct user_namespace *mnt_userns,
+			       struct dentry *dentry, int type)
+{
+#if defined(CONFIG_CIFS_ALLOW_INSECURE_LEGACY) && defined(CONFIG_CIFS_POSIX)
+	struct posix_acl *acl = NULL;
+	ssize_t rc = -EOPNOTSUPP;
+	unsigned int xid;
+	struct super_block *sb = dentry->d_sb;
+	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
+	struct tcon_link *tlink;
+	struct cifs_tcon *pTcon;
+	const char *full_path;
+	void *page;
+
+	tlink = cifs_sb_tlink(cifs_sb);
+	if (IS_ERR(tlink))
+		return ERR_CAST(tlink);
+	pTcon = tlink_tcon(tlink);
+
+	xid = get_xid();
+	page = alloc_dentry_path();
+
+	full_path = build_path_from_dentry(dentry, page);
+	if (IS_ERR(full_path)) {
+		acl = ERR_CAST(full_path);
+		goto out;
+	}
+
+	/* return alt name if available as pseudo attr */
+	switch (type) {
+	case ACL_TYPE_ACCESS:
+		if (sb->s_flags & SB_POSIXACL)
+			rc = cifs_do_get_acl(xid, pTcon, full_path, &acl,
+					     ACL_TYPE_ACCESS,
+					     cifs_sb->local_nls,
+					     cifs_remap(cifs_sb));
+		break;
+
+	case ACL_TYPE_DEFAULT:
+		if (sb->s_flags & SB_POSIXACL)
+			rc = cifs_do_get_acl(xid, pTcon, full_path, &acl,
+					     ACL_TYPE_DEFAULT,
+					     cifs_sb->local_nls,
+					     cifs_remap(cifs_sb));
+		break;
+	}
+
+	if (rc < 0) {
+		if (rc == -EINVAL)
+			acl = ERR_PTR(-EOPNOTSUPP);
+		else
+			acl = ERR_PTR(rc);
+	}
+
+out:
+	free_dentry_path(page);
+	free_xid(xid);
+	cifs_put_tlink(tlink);
+	return acl;
+#else
+	return ERR_PTR(-EOPNOTSUPP);
+#endif
+}
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index c6ac19223ddc..05d0f84ede95 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1133,6 +1133,7 @@ const struct inode_operations cifs_dir_inode_ops = {
 	.symlink = cifs_symlink,
 	.mknod   = cifs_mknod,
 	.listxattr = cifs_listxattr,
+	.get_acl = cifs_get_acl,
 };
 
 const struct inode_operations cifs_file_inode_ops = {
@@ -1141,6 +1142,7 @@ const struct inode_operations cifs_file_inode_ops = {
 	.permission = cifs_permission,
 	.listxattr = cifs_listxattr,
 	.fiemap = cifs_fiemap,
+	.get_acl = cifs_get_acl,
 };
 
 const struct inode_operations cifs_symlink_inode_ops = {
diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index 83e83d8beabb..28e848495594 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -224,6 +224,8 @@ extern struct cifs_ntsd *get_cifs_acl(struct cifs_sb_info *, struct inode *,
 				      const char *, u32 *, u32);
 extern struct cifs_ntsd *get_cifs_acl_by_fid(struct cifs_sb_info *,
 				const struct cifs_fid *, u32 *, u32);
+extern struct posix_acl *cifs_get_acl(struct user_namespace *mnt_userns,
+				      struct dentry *dentry, int type);
 extern int set_cifs_acl(struct cifs_ntsd *, __u32, struct inode *,
 				const char *, int);
 extern unsigned int setup_authusers_ACE(struct cifs_ace *pace);
@@ -541,6 +543,10 @@ extern int CIFSSMBGetPosixACL(const unsigned int xid, struct cifs_tcon *tcon,
 		const unsigned char *searchName,
 		char *acl_inf, const int buflen, const int acl_type,
 		const struct nls_table *nls_codepage, int remap_special_chars);
+extern int cifs_do_get_acl(const unsigned int xid, struct cifs_tcon *tcon,
+			   const unsigned char *searchName,
+			   struct posix_acl **acl, const int acl_type,
+			   const struct nls_table *nls_codepage, int remap);
 extern int CIFSSMBSetPosixACL(const unsigned int xid, struct cifs_tcon *tcon,
 		const unsigned char *fileName,
 		const char *local_acl, const int buflen, const int acl_type,
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 1724066c1536..d30535406885 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -3212,6 +3212,202 @@ CIFSSMBSetPosixACL(const unsigned int xid, struct cifs_tcon *tcon,
 	return rc;
 }
 
+#ifdef CONFIG_FS_POSIX_ACL
+/**
+ * cifs_init_posix_acl - convert ACL from cifs to POSIX ACL format
+ * @ace: POSIX ACL entry to store converted ACL into
+ * @cifs_ace: ACL in cifs format
+ *
+ * Convert an Access Control Entry from wire format to local POSIX xattr
+ * format.
+ *
+ * Note that the @cifs_uid member is used to store both {g,u}id_t.
+ */
+static void cifs_init_posix_acl(struct posix_acl_entry *ace,
+				struct cifs_posix_ace *cifs_ace)
+{
+	/* u8 cifs fields do not need le conversion */
+	ace->e_perm = cifs_ace->cifs_e_perm;
+	ace->e_tag = cifs_ace->cifs_e_tag;
+
+	switch (ace->e_tag) {
+	case ACL_USER:
+		ace->e_uid = make_kuid(&init_user_ns,
+				       le64_to_cpu(cifs_ace->cifs_uid));
+		break;
+	case ACL_GROUP:
+		ace->e_gid = make_kgid(&init_user_ns,
+				       le64_to_cpu(cifs_ace->cifs_uid));
+		break;
+	}
+	return;
+}
+
+/**
+ * cifs_to_posix_acl - copy cifs ACL format to POSIX ACL format
+ * @acl: ACLs returned in POSIX ACL format
+ * @src: ACLs in cifs format
+ * @acl_type: type of POSIX ACL requested
+ * @size_of_data_area: size of SMB we got
+ *
+ * This function converts ACLs from cifs format to POSIX ACL format.
+ * If @acl is NULL then the size of the buffer required to store POSIX ACLs in
+ * their uapi format is returned.
+ */
+static int cifs_to_posix_acl(struct posix_acl **acl, char *src,
+			     const int acl_type, const int size_of_data_area)
+{
+	int size =  0;
+	__u16 count;
+	struct cifs_posix_ace *pACE;
+	struct cifs_posix_acl *cifs_acl = (struct cifs_posix_acl *)src;
+	struct posix_acl *kacl = NULL;
+	struct posix_acl_entry *pa, *pe;
+
+	if (le16_to_cpu(cifs_acl->version) != CIFS_ACL_VERSION)
+		return -EOPNOTSUPP;
+
+	if (acl_type == ACL_TYPE_ACCESS) {
+		count = le16_to_cpu(cifs_acl->access_entry_count);
+		pACE = &cifs_acl->ace_array[0];
+		size = sizeof(struct cifs_posix_acl);
+		size += sizeof(struct cifs_posix_ace) * count;
+		/* check if we would go beyond end of SMB */
+		if (size_of_data_area < size) {
+			cifs_dbg(FYI, "bad CIFS POSIX ACL size %d vs. %d\n",
+				 size_of_data_area, size);
+			return -EINVAL;
+		}
+	} else if (acl_type == ACL_TYPE_DEFAULT) {
+		count = le16_to_cpu(cifs_acl->access_entry_count);
+		size = sizeof(struct cifs_posix_acl);
+		size += sizeof(struct cifs_posix_ace) * count;
+		/* skip past access ACEs to get to default ACEs */
+		pACE = &cifs_acl->ace_array[count];
+		count = le16_to_cpu(cifs_acl->default_entry_count);
+		size += sizeof(struct cifs_posix_ace) * count;
+		/* check if we would go beyond end of SMB */
+		if (size_of_data_area < size)
+			return -EINVAL;
+	} else {
+		/* illegal type */
+		return -EINVAL;
+	}
+
+	/* Allocate number of POSIX ACLs to store in VFS format. */
+	kacl = posix_acl_alloc(count, GFP_NOFS);
+	if (!kacl)
+		return -ENOMEM;
+
+	FOREACH_ACL_ENTRY(pa, kacl, pe) {
+		cifs_init_posix_acl(pa, pACE);
+		pACE++;
+	}
+
+	*acl = kacl;
+	return 0;
+}
+
+int cifs_do_get_acl(const unsigned int xid, struct cifs_tcon *tcon,
+		    const unsigned char *searchName, struct posix_acl **acl,
+		    const int acl_type, const struct nls_table *nls_codepage,
+		    int remap)
+{
+/* SMB_QUERY_POSIX_ACL */
+	TRANSACTION2_QPI_REQ *pSMB = NULL;
+	TRANSACTION2_QPI_RSP *pSMBr = NULL;
+	int rc = 0;
+	int bytes_returned;
+	int name_len;
+	__u16 params, byte_count;
+
+	cifs_dbg(FYI, "In GetPosixACL (Unix) for path %s\n", searchName);
+
+queryAclRetry:
+	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
+		(void **) &pSMBr);
+	if (rc)
+		return rc;
+
+	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
+		name_len =
+			cifsConvertToUTF16((__le16 *) pSMB->FileName,
+					   searchName, PATH_MAX, nls_codepage,
+					   remap);
+		name_len++;     /* trailing null */
+		name_len *= 2;
+		pSMB->FileName[name_len] = 0;
+		pSMB->FileName[name_len+1] = 0;
+	} else {
+		name_len = copy_path_name(pSMB->FileName, searchName);
+	}
+
+	params = 2 /* level */  + 4 /* rsrvd */  + name_len /* incl null */ ;
+	pSMB->TotalDataCount = 0;
+	pSMB->MaxParameterCount = cpu_to_le16(2);
+	/* BB find exact max data count below from sess structure BB */
+	pSMB->MaxDataCount = cpu_to_le16(4000);
+	pSMB->MaxSetupCount = 0;
+	pSMB->Reserved = 0;
+	pSMB->Flags = 0;
+	pSMB->Timeout = 0;
+	pSMB->Reserved2 = 0;
+	pSMB->ParameterOffset = cpu_to_le16(
+		offsetof(struct smb_com_transaction2_qpi_req,
+			 InformationLevel) - 4);
+	pSMB->DataCount = 0;
+	pSMB->DataOffset = 0;
+	pSMB->SetupCount = 1;
+	pSMB->Reserved3 = 0;
+	pSMB->SubCommand = cpu_to_le16(TRANS2_QUERY_PATH_INFORMATION);
+	byte_count = params + 1 /* pad */ ;
+	pSMB->TotalParameterCount = cpu_to_le16(params);
+	pSMB->ParameterCount = pSMB->TotalParameterCount;
+	pSMB->InformationLevel = cpu_to_le16(SMB_QUERY_POSIX_ACL);
+	pSMB->Reserved4 = 0;
+	inc_rfc1001_len(pSMB, byte_count);
+	pSMB->ByteCount = cpu_to_le16(byte_count);
+
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+		(struct smb_hdr *) pSMBr, &bytes_returned, 0);
+	cifs_stats_inc(&tcon->stats.cifs_stats.num_acl_get);
+	if (rc) {
+		cifs_dbg(FYI, "Send error in Query POSIX ACL = %d\n", rc);
+	} else {
+		/* decode response */
+
+		rc = validate_t2((struct smb_t2_rsp *)pSMBr);
+		/* BB also check enough total bytes returned */
+		if (rc || get_bcc(&pSMBr->hdr) < 2)
+			rc = -EIO;      /* bad smb */
+		else {
+			__u16 data_offset = le16_to_cpu(pSMBr->t2.DataOffset);
+			__u16 count = le16_to_cpu(pSMBr->t2.DataCount);
+			rc = cifs_to_posix_acl(acl,
+				(char *)&pSMBr->hdr.Protocol+data_offset,
+				acl_type, count);
+		}
+	}
+	cifs_buf_release(pSMB);
+	/*
+	 * The else branch after SendReceive() doesn't return EAGAIN so if we
+	 * allocated @acl in cifs_to_posix_acl() we are guaranteed to return
+	 * here and don't leak POSIX ACLs.
+	 */
+	if (rc == -EAGAIN)
+		goto queryAclRetry;
+	return rc;
+}
+#else
+int cifs_do_get_acl(const unsigned int xid, struct cifs_tcon *tcon,
+		    const unsigned char *searchName, struct posix_acl **acl,
+		    const int acl_type, const struct nls_table *nls_codepage,
+		    int remap)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_FS_POSIX_ACL */
+
 int
 CIFSGetExtAttr(const unsigned int xid, struct cifs_tcon *tcon,
 	       const int netfid, __u64 *pExtAttrBits, __u64 *pMask)
-- 
2.34.1

