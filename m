Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43207602AFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 14:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiJRMAo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 08:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiJRL7f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:59:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00B1AEA34;
        Tue, 18 Oct 2022 04:58:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8112A6153A;
        Tue, 18 Oct 2022 11:58:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E67C433B5;
        Tue, 18 Oct 2022 11:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666094312;
        bh=H65PbSrFQ5XpE0zxuBTanfDd3B2uKXxHFfeCQl9nkUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dBFhOTlSesO86YL+exBpMByC+Z5umK2qLOibRpcN/6Ev/LBSb0v231dT/i/NupL2W
         wj3snr1aBxxDokOMiuFAXIKxlN6E/whVFfKBLgcxzF/yLht0lJUNtB3vlhy27iIf8Z
         A97pA/+kggie5ZTwVjVb0buXQZfueUOCv2RIsqvC6nNxpUSfXx4XC2tvObEZDo4VpB
         eQkBlksxkCjUNvac7X4dScEGaJJcWMWtAM4gRutuWE4cUuT2+BJyJkhY4OHBtKoaZj
         KVU+ksBQgtKKwG2xrc0PKXn0whgUPAOjvF/4VB1lIbMpzaLyI+lQJJZYe8NAKmTev8
         z5BF8/7vn16YQ==
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
Subject: [PATCH v5 28/30] cifs: use stub posix acl handlers
Date:   Tue, 18 Oct 2022 13:56:58 +0200
Message-Id: <20221018115700.166010-29-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018115700.166010-1-brauner@kernel.org>
References: <20221018115700.166010-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15528; i=brauner@kernel.org; h=from:subject; bh=H65PbSrFQ5XpE0zxuBTanfDd3B2uKXxHFfeCQl9nkUo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST7TdHKuZx6WbtkTUDLXLv83w72HOH+K39sYYm4uigtTOHO xiNfOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACai0Mjwv+JZ14fUVqGPLrHTf/Ouj+ g5Jv3ryt7k5sNrltp5tlzYVsvI0Kn6OM/uSXLa7nsnTuU/4EjtnrtPM66R3bny1ctrQp6PWQA=
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

Now that cifs supports the get and set acl inode operations and the vfs
has been switched to the new posi api, cifs can simply rely on the stub
posix acl handlers. The custom xattr handlers and associated unused
helpers can be removed.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    unchanged
    
    /* v3 */
    unchanged
    
    /* v4 */
    "Sedat Dilek (DHL Supply Chain)" <sedat.dilek@dhl.com>:
    - s/CONFIG_XFS_POSIX_ACL/CONFIG_FS_POSIX_ACL/
    
    /* v5 */
    unchanged

 fs/cifs/cifsproto.h |   8 --
 fs/cifs/cifssmb.c   | 298 --------------------------------------------
 fs/cifs/xattr.c     |  68 +---------
 3 files changed, 4 insertions(+), 370 deletions(-)

diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index ce7f08a387b5..f50f96e4ec30 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -541,18 +541,10 @@ extern int CIFSSMBGetCIFSACL(const unsigned int xid, struct cifs_tcon *tcon,
 			__u16 fid, struct cifs_ntsd **acl_inf, __u32 *buflen);
 extern int CIFSSMBSetCIFSACL(const unsigned int, struct cifs_tcon *, __u16,
 			struct cifs_ntsd *, __u32, int);
-extern int CIFSSMBGetPosixACL(const unsigned int xid, struct cifs_tcon *tcon,
-		const unsigned char *searchName,
-		char *acl_inf, const int buflen, const int acl_type,
-		const struct nls_table *nls_codepage, int remap_special_chars);
 extern int cifs_do_get_acl(const unsigned int xid, struct cifs_tcon *tcon,
 			   const unsigned char *searchName,
 			   struct posix_acl **acl, const int acl_type,
 			   const struct nls_table *nls_codepage, int remap);
-extern int CIFSSMBSetPosixACL(const unsigned int xid, struct cifs_tcon *tcon,
-		const unsigned char *fileName,
-		const char *local_acl, const int buflen, const int acl_type,
-		const struct nls_table *nls_codepage, int remap_special_chars);
 extern int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
 			   const unsigned char *fileName,
 			   const struct posix_acl *acl, const int acl_type,
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index f119ca917947..23f10e0d6e7e 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -2914,304 +2914,6 @@ CIFSSMB_set_compression(const unsigned int xid, struct cifs_tcon *tcon,
 
 #ifdef CONFIG_CIFS_POSIX
 
-/*Convert an Access Control Entry from wire format to local POSIX xattr format*/
-static void cifs_convert_ace(struct posix_acl_xattr_entry *ace,
-			     struct cifs_posix_ace *cifs_ace)
-{
-	/* u8 cifs fields do not need le conversion */
-	ace->e_perm = cpu_to_le16(cifs_ace->cifs_e_perm);
-	ace->e_tag  = cpu_to_le16(cifs_ace->cifs_e_tag);
-	ace->e_id   = cpu_to_le32(le64_to_cpu(cifs_ace->cifs_uid));
-/*
-	cifs_dbg(FYI, "perm %d tag %d id %d\n",
-		 ace->e_perm, ace->e_tag, ace->e_id);
-*/
-
-	return;
-}
-
-/* Convert ACL from CIFS POSIX wire format to local Linux POSIX ACL xattr */
-static int cifs_copy_posix_acl(char *trgt, char *src, const int buflen,
-			       const int acl_type, const int size_of_data_area)
-{
-	int size =  0;
-	int i;
-	__u16 count;
-	struct cifs_posix_ace *pACE;
-	struct cifs_posix_acl *cifs_acl = (struct cifs_posix_acl *)src;
-	struct posix_acl_xattr_header *local_acl = (void *)trgt;
-
-	if (le16_to_cpu(cifs_acl->version) != CIFS_ACL_VERSION)
-		return -EOPNOTSUPP;
-
-	if (acl_type == ACL_TYPE_ACCESS) {
-		count = le16_to_cpu(cifs_acl->access_entry_count);
-		pACE = &cifs_acl->ace_array[0];
-		size = sizeof(struct cifs_posix_acl);
-		size += sizeof(struct cifs_posix_ace) * count;
-		/* check if we would go beyond end of SMB */
-		if (size_of_data_area < size) {
-			cifs_dbg(FYI, "bad CIFS POSIX ACL size %d vs. %d\n",
-				 size_of_data_area, size);
-			return -EINVAL;
-		}
-	} else if (acl_type == ACL_TYPE_DEFAULT) {
-		count = le16_to_cpu(cifs_acl->access_entry_count);
-		size = sizeof(struct cifs_posix_acl);
-		size += sizeof(struct cifs_posix_ace) * count;
-/* skip past access ACEs to get to default ACEs */
-		pACE = &cifs_acl->ace_array[count];
-		count = le16_to_cpu(cifs_acl->default_entry_count);
-		size += sizeof(struct cifs_posix_ace) * count;
-		/* check if we would go beyond end of SMB */
-		if (size_of_data_area < size)
-			return -EINVAL;
-	} else {
-		/* illegal type */
-		return -EINVAL;
-	}
-
-	size = posix_acl_xattr_size(count);
-	if ((buflen == 0) || (local_acl == NULL)) {
-		/* used to query ACL EA size */
-	} else if (size > buflen) {
-		return -ERANGE;
-	} else /* buffer big enough */ {
-		struct posix_acl_xattr_entry *ace = (void *)(local_acl + 1);
-
-		local_acl->a_version = cpu_to_le32(POSIX_ACL_XATTR_VERSION);
-		for (i = 0; i < count ; i++) {
-			cifs_convert_ace(&ace[i], pACE);
-			pACE++;
-		}
-	}
-	return size;
-}
-
-static void convert_ace_to_cifs_ace(struct cifs_posix_ace *cifs_ace,
-				     const struct posix_acl_xattr_entry *local_ace)
-{
-	cifs_ace->cifs_e_perm = le16_to_cpu(local_ace->e_perm);
-	cifs_ace->cifs_e_tag =  le16_to_cpu(local_ace->e_tag);
-	/* BB is there a better way to handle the large uid? */
-	if (local_ace->e_id == cpu_to_le32(-1)) {
-	/* Probably no need to le convert -1 on any arch but can not hurt */
-		cifs_ace->cifs_uid = cpu_to_le64(-1);
-	} else
-		cifs_ace->cifs_uid = cpu_to_le64(le32_to_cpu(local_ace->e_id));
-/*
-	cifs_dbg(FYI, "perm %d tag %d id %d\n",
-		 ace->e_perm, ace->e_tag, ace->e_id);
-*/
-}
-
-/* Convert ACL from local Linux POSIX xattr to CIFS POSIX ACL wire format */
-static __u16 ACL_to_cifs_posix(char *parm_data, const char *pACL,
-			       const int buflen, const int acl_type)
-{
-	__u16 rc = 0;
-	struct cifs_posix_acl *cifs_acl = (struct cifs_posix_acl *)parm_data;
-	struct posix_acl_xattr_header *local_acl = (void *)pACL;
-	struct posix_acl_xattr_entry *ace = (void *)(local_acl + 1);
-	int count;
-	int i;
-
-	if ((buflen == 0) || (pACL == NULL) || (cifs_acl == NULL))
-		return 0;
-
-	count = posix_acl_xattr_count((size_t)buflen);
-	cifs_dbg(FYI, "setting acl with %d entries from buf of length %d and version of %d\n",
-		 count, buflen, le32_to_cpu(local_acl->a_version));
-	if (le32_to_cpu(local_acl->a_version) != 2) {
-		cifs_dbg(FYI, "unknown POSIX ACL version %d\n",
-			 le32_to_cpu(local_acl->a_version));
-		return 0;
-	}
-	cifs_acl->version = cpu_to_le16(1);
-	if (acl_type == ACL_TYPE_ACCESS) {
-		cifs_acl->access_entry_count = cpu_to_le16(count);
-		cifs_acl->default_entry_count = cpu_to_le16(0xFFFF);
-	} else if (acl_type == ACL_TYPE_DEFAULT) {
-		cifs_acl->default_entry_count = cpu_to_le16(count);
-		cifs_acl->access_entry_count = cpu_to_le16(0xFFFF);
-	} else {
-		cifs_dbg(FYI, "unknown ACL type %d\n", acl_type);
-		return 0;
-	}
-	for (i = 0; i < count; i++)
-		convert_ace_to_cifs_ace(&cifs_acl->ace_array[i], &ace[i]);
-	if (rc == 0) {
-		rc = (__u16)(count * sizeof(struct cifs_posix_ace));
-		rc += sizeof(struct cifs_posix_acl);
-		/* BB add check to make sure ACL does not overflow SMB */
-	}
-	return rc;
-}
-
-int
-CIFSSMBGetPosixACL(const unsigned int xid, struct cifs_tcon *tcon,
-		   const unsigned char *searchName,
-		   char *acl_inf, const int buflen, const int acl_type,
-		   const struct nls_table *nls_codepage, int remap)
-{
-/* SMB_QUERY_POSIX_ACL */
-	TRANSACTION2_QPI_REQ *pSMB = NULL;
-	TRANSACTION2_QPI_RSP *pSMBr = NULL;
-	int rc = 0;
-	int bytes_returned;
-	int name_len;
-	__u16 params, byte_count;
-
-	cifs_dbg(FYI, "In GetPosixACL (Unix) for path %s\n", searchName);
-
-queryAclRetry:
-	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
-		(void **) &pSMBr);
-	if (rc)
-		return rc;
-
-	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
-		name_len =
-			cifsConvertToUTF16((__le16 *) pSMB->FileName,
-					   searchName, PATH_MAX, nls_codepage,
-					   remap);
-		name_len++;     /* trailing null */
-		name_len *= 2;
-		pSMB->FileName[name_len] = 0;
-		pSMB->FileName[name_len+1] = 0;
-	} else {
-		name_len = copy_path_name(pSMB->FileName, searchName);
-	}
-
-	params = 2 /* level */  + 4 /* rsrvd */  + name_len /* incl null */ ;
-	pSMB->TotalDataCount = 0;
-	pSMB->MaxParameterCount = cpu_to_le16(2);
-	/* BB find exact max data count below from sess structure BB */
-	pSMB->MaxDataCount = cpu_to_le16(4000);
-	pSMB->MaxSetupCount = 0;
-	pSMB->Reserved = 0;
-	pSMB->Flags = 0;
-	pSMB->Timeout = 0;
-	pSMB->Reserved2 = 0;
-	pSMB->ParameterOffset = cpu_to_le16(
-		offsetof(struct smb_com_transaction2_qpi_req,
-			 InformationLevel) - 4);
-	pSMB->DataCount = 0;
-	pSMB->DataOffset = 0;
-	pSMB->SetupCount = 1;
-	pSMB->Reserved3 = 0;
-	pSMB->SubCommand = cpu_to_le16(TRANS2_QUERY_PATH_INFORMATION);
-	byte_count = params + 1 /* pad */ ;
-	pSMB->TotalParameterCount = cpu_to_le16(params);
-	pSMB->ParameterCount = pSMB->TotalParameterCount;
-	pSMB->InformationLevel = cpu_to_le16(SMB_QUERY_POSIX_ACL);
-	pSMB->Reserved4 = 0;
-	inc_rfc1001_len(pSMB, byte_count);
-	pSMB->ByteCount = cpu_to_le16(byte_count);
-
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
-		(struct smb_hdr *) pSMBr, &bytes_returned, 0);
-	cifs_stats_inc(&tcon->stats.cifs_stats.num_acl_get);
-	if (rc) {
-		cifs_dbg(FYI, "Send error in Query POSIX ACL = %d\n", rc);
-	} else {
-		/* decode response */
-
-		rc = validate_t2((struct smb_t2_rsp *)pSMBr);
-		/* BB also check enough total bytes returned */
-		if (rc || get_bcc(&pSMBr->hdr) < 2)
-			rc = -EIO;      /* bad smb */
-		else {
-			__u16 data_offset = le16_to_cpu(pSMBr->t2.DataOffset);
-			__u16 count = le16_to_cpu(pSMBr->t2.DataCount);
-			rc = cifs_copy_posix_acl(acl_inf,
-				(char *)&pSMBr->hdr.Protocol+data_offset,
-				buflen, acl_type, count);
-		}
-	}
-	cifs_buf_release(pSMB);
-	if (rc == -EAGAIN)
-		goto queryAclRetry;
-	return rc;
-}
-
-int
-CIFSSMBSetPosixACL(const unsigned int xid, struct cifs_tcon *tcon,
-		   const unsigned char *fileName,
-		   const char *local_acl, const int buflen,
-		   const int acl_type,
-		   const struct nls_table *nls_codepage, int remap)
-{
-	struct smb_com_transaction2_spi_req *pSMB = NULL;
-	struct smb_com_transaction2_spi_rsp *pSMBr = NULL;
-	char *parm_data;
-	int name_len;
-	int rc = 0;
-	int bytes_returned = 0;
-	__u16 params, byte_count, data_count, param_offset, offset;
-
-	cifs_dbg(FYI, "In SetPosixACL (Unix) for path %s\n", fileName);
-setAclRetry:
-	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
-		      (void **) &pSMBr);
-	if (rc)
-		return rc;
-	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
-		name_len =
-			cifsConvertToUTF16((__le16 *) pSMB->FileName, fileName,
-					   PATH_MAX, nls_codepage, remap);
-		name_len++;     /* trailing null */
-		name_len *= 2;
-	} else {
-		name_len = copy_path_name(pSMB->FileName, fileName);
-	}
-	params = 6 + name_len;
-	pSMB->MaxParameterCount = cpu_to_le16(2);
-	/* BB find max SMB size from sess */
-	pSMB->MaxDataCount = cpu_to_le16(1000);
-	pSMB->MaxSetupCount = 0;
-	pSMB->Reserved = 0;
-	pSMB->Flags = 0;
-	pSMB->Timeout = 0;
-	pSMB->Reserved2 = 0;
-	param_offset = offsetof(struct smb_com_transaction2_spi_req,
-				InformationLevel) - 4;
-	offset = param_offset + params;
-	parm_data = ((char *) &pSMB->hdr.Protocol) + offset;
-	pSMB->ParameterOffset = cpu_to_le16(param_offset);
-
-	/* convert to on the wire format for POSIX ACL */
-	data_count = ACL_to_cifs_posix(parm_data, local_acl, buflen, acl_type);
-
-	if (data_count == 0) {
-		rc = -EOPNOTSUPP;
-		goto setACLerrorExit;
-	}
-	pSMB->DataOffset = cpu_to_le16(offset);
-	pSMB->SetupCount = 1;
-	pSMB->Reserved3 = 0;
-	pSMB->SubCommand = cpu_to_le16(TRANS2_SET_PATH_INFORMATION);
-	pSMB->InformationLevel = cpu_to_le16(SMB_SET_POSIX_ACL);
-	byte_count = 3 /* pad */  + params + data_count;
-	pSMB->DataCount = cpu_to_le16(data_count);
-	pSMB->TotalDataCount = pSMB->DataCount;
-	pSMB->ParameterCount = cpu_to_le16(params);
-	pSMB->TotalParameterCount = pSMB->ParameterCount;
-	pSMB->Reserved4 = 0;
-	inc_rfc1001_len(pSMB, byte_count);
-	pSMB->ByteCount = cpu_to_le16(byte_count);
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
-			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
-	if (rc)
-		cifs_dbg(FYI, "Set POSIX ACL returned %d\n", rc);
-
-setACLerrorExit:
-	cifs_buf_release(pSMB);
-	if (rc == -EAGAIN)
-		goto setAclRetry;
-	return rc;
-}
-
 #ifdef CONFIG_FS_POSIX_ACL
 /**
  * cifs_init_posix_acl - convert ACL from cifs to POSIX ACL format
diff --git a/fs/cifs/xattr.c b/fs/cifs/xattr.c
index 998fa51f9b68..5f2fb2fd2e37 100644
--- a/fs/cifs/xattr.c
+++ b/fs/cifs/xattr.c
@@ -200,32 +200,6 @@ static int cifs_xattr_set(const struct xattr_handler *handler,
 		}
 		break;
 	}
-
-#ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
-	case XATTR_ACL_ACCESS:
-#ifdef CONFIG_CIFS_POSIX
-		if (!value)
-			goto out;
-		if (sb->s_flags & SB_POSIXACL)
-			rc = CIFSSMBSetPosixACL(xid, pTcon, full_path,
-				value, (const int)size,
-				ACL_TYPE_ACCESS, cifs_sb->local_nls,
-				cifs_remap(cifs_sb));
-#endif  /* CONFIG_CIFS_POSIX */
-		break;
-
-	case XATTR_ACL_DEFAULT:
-#ifdef CONFIG_CIFS_POSIX
-		if (!value)
-			goto out;
-		if (sb->s_flags & SB_POSIXACL)
-			rc = CIFSSMBSetPosixACL(xid, pTcon, full_path,
-				value, (const int)size,
-				ACL_TYPE_DEFAULT, cifs_sb->local_nls,
-				cifs_remap(cifs_sb));
-#endif  /* CONFIG_CIFS_POSIX */
-		break;
-#endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
 	}
 
 out:
@@ -366,27 +340,6 @@ static int cifs_xattr_get(const struct xattr_handler *handler,
 		}
 		break;
 	}
-#ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
-	case XATTR_ACL_ACCESS:
-#ifdef CONFIG_CIFS_POSIX
-		if (sb->s_flags & SB_POSIXACL)
-			rc = CIFSSMBGetPosixACL(xid, pTcon, full_path,
-				value, size, ACL_TYPE_ACCESS,
-				cifs_sb->local_nls,
-				cifs_remap(cifs_sb));
-#endif  /* CONFIG_CIFS_POSIX */
-		break;
-
-	case XATTR_ACL_DEFAULT:
-#ifdef CONFIG_CIFS_POSIX
-		if (sb->s_flags & SB_POSIXACL)
-			rc = CIFSSMBGetPosixACL(xid, pTcon, full_path,
-				value, size, ACL_TYPE_DEFAULT,
-				cifs_sb->local_nls,
-				cifs_remap(cifs_sb));
-#endif  /* CONFIG_CIFS_POSIX */
-		break;
-#endif /* ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
 	}
 
 	/* We could add an additional check for streams ie
@@ -525,21 +478,6 @@ static const struct xattr_handler smb3_ntsd_full_xattr_handler = {
 	.set = cifs_xattr_set,
 };
 
-
-static const struct xattr_handler cifs_posix_acl_access_xattr_handler = {
-	.name = XATTR_NAME_POSIX_ACL_ACCESS,
-	.flags = XATTR_ACL_ACCESS,
-	.get = cifs_xattr_get,
-	.set = cifs_xattr_set,
-};
-
-static const struct xattr_handler cifs_posix_acl_default_xattr_handler = {
-	.name = XATTR_NAME_POSIX_ACL_DEFAULT,
-	.flags = XATTR_ACL_DEFAULT,
-	.get = cifs_xattr_get,
-	.set = cifs_xattr_set,
-};
-
 const struct xattr_handler *cifs_xattr_handlers[] = {
 	&cifs_user_xattr_handler,
 	&cifs_os2_xattr_handler,
@@ -549,7 +487,9 @@ const struct xattr_handler *cifs_xattr_handlers[] = {
 	&smb3_ntsd_xattr_handler, /* alias for above since avoiding "cifs" */
 	&cifs_cifs_ntsd_full_xattr_handler,
 	&smb3_ntsd_full_xattr_handler, /* alias for above since avoiding "cifs" */
-	&cifs_posix_acl_access_xattr_handler,
-	&cifs_posix_acl_default_xattr_handler,
+#ifdef CONFIG_FS_POSIX_ACL
+	&posix_acl_access_xattr_handler,
+	&posix_acl_default_xattr_handler,
+#endif
 	NULL
 };
-- 
2.34.1

