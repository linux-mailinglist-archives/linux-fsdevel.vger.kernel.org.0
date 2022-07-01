Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DB0563427
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 15:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbiGANL7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 09:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbiGANLo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:11:44 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAC753EFE;
        Fri,  1 Jul 2022 06:11:38 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 36DD021B5;
        Fri,  1 Jul 2022 13:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1656681039;
        bh=MdqLvxK34KSjRpWbcAm/crlXqAnDbqvWCj9YKSA+ccI=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=kEdPregi4Z795XuRO3VVB3tCcSIpidTXAFuD8eJjs3945Lhbu+IGBDPj1lKiOUD7K
         bcsBEjY3E0POIKUbt0KwA7MMijL9ZGtRPxR0CwGfmQOcp308qE0cm5IoVhFdhl2cmm
         2iewuqxKubcvUsg6+d/wpaGKB7tj57pPvmkEJgJI=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 1 Jul 2022 16:11:36 +0300
Message-ID: <02302c1c-d188-c326-7bad-1b2a2e7f9a15@paragon-software.com>
Date:   Fri, 1 Jul 2022 16:11:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: [PATCH 5/5] fs/ntfs3: Fill duplicate info in ni_add_name
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <34e58f6e-e508-4ad8-6941-37281ea7d3ef@paragon-software.com>
In-Reply-To: <34e58f6e-e508-4ad8-6941-37281ea7d3ef@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Work with names must be completed in ni_add_name

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/frecord.c | 20 ++++++++++++++------
  fs/ntfs3/inode.c   | 10 ----------
  2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 756d9a18fa00..acd9f444bd64 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1614,7 +1614,8 @@ struct ATTR_FILE_NAME *ni_fname_name(struct ntfs_inode *ni,
  	struct ATTRIB *attr = NULL;
  	struct ATTR_FILE_NAME *fname;
  
-	*le = NULL;
+	if (le)
+		*le = NULL;
  
  	/* Enumerate all names. */
  next:
@@ -1630,7 +1631,7 @@ struct ATTR_FILE_NAME *ni_fname_name(struct ntfs_inode *ni,
  		goto next;
  
  	if (!uni)
-		goto next;
+		return fname;
  
  	if (uni->len != fname->name_len)
  		goto next;
@@ -2969,7 +2970,7 @@ bool ni_remove_name_undo(struct ntfs_inode *dir_ni, struct ntfs_inode *ni,
  }
  
  /*
- * ni_add_name - Add new name in MFT and in directory.
+ * ni_add_name - Add new name into MFT and into directory.
   */
  int ni_add_name(struct ntfs_inode *dir_ni, struct ntfs_inode *ni,
  		struct NTFS_DE *de)
@@ -2978,13 +2979,20 @@ int ni_add_name(struct ntfs_inode *dir_ni, struct ntfs_inode *ni,
  	struct ATTRIB *attr;
  	struct ATTR_LIST_ENTRY *le;
  	struct mft_inode *mi;
+	struct ATTR_FILE_NAME *fname;
  	struct ATTR_FILE_NAME *de_name = (struct ATTR_FILE_NAME *)(de + 1);
  	u16 de_key_size = le16_to_cpu(de->key_size);
  
  	mi_get_ref(&ni->mi, &de->ref);
  	mi_get_ref(&dir_ni->mi, &de_name->home);
  
-	/* Insert new name in MFT. */
+	/* Fill duplicate from any ATTR_NAME. */
+	fname = ni_fname_name(ni, NULL, NULL, NULL, NULL);
+	if (fname)
+		memcpy(&de_name->dup, &fname->dup, sizeof(fname->dup));
+	de_name->dup.fa = ni->std_fa;
+
+	/* Insert new name into MFT. */
  	err = ni_insert_resident(ni, de_key_size, ATTR_NAME, NULL, 0, &attr,
  				 &mi, &le);
  	if (err)
@@ -2992,7 +3000,7 @@ int ni_add_name(struct ntfs_inode *dir_ni, struct ntfs_inode *ni,
  
  	memcpy(Add2Ptr(attr, SIZEOF_RESIDENT), de_name, de_key_size);
  
-	/* Insert new name in directory. */
+	/* Insert new name into directory. */
  	err = indx_insert_entry(&dir_ni->dir, dir_ni, de, ni->mi.sbi, NULL, 0);
  	if (err)
  		ni_remove_attr_le(ni, attr, mi, le);
@@ -3016,7 +3024,7 @@ int ni_rename(struct ntfs_inode *dir_ni, struct ntfs_inode *new_dir_ni,
  	 * 1) Add new name and remove old name.
  	 * 2) Remove old name and add new name.
  	 *
-	 * In most cases (not all!) adding new name in MFT and in directory can
+	 * In most cases (not all!) adding new name into MFT and into directory can
  	 * allocate additional cluster(s).
  	 * Second way may result to bad inode if we can't add new name
  	 * and then can't restore (add) old name.
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index a49da4ec6dc3..3ed319663747 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1659,7 +1659,6 @@ int ntfs_link_inode(struct inode *inode, struct dentry *dentry)
  	struct ntfs_inode *ni = ntfs_i(inode);
  	struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
  	struct NTFS_DE *de;
-	struct ATTR_FILE_NAME *de_name;
  
  	/* Allocate PATH_MAX bytes. */
  	de = __getname();
@@ -1674,15 +1673,6 @@ int ntfs_link_inode(struct inode *inode, struct dentry *dentry)
  	if (err)
  		goto out;
  
-	de_name = (struct ATTR_FILE_NAME *)(de + 1);
-	/* Fill duplicate info. */
-	de_name->dup.cr_time = de_name->dup.m_time = de_name->dup.c_time =
-		de_name->dup.a_time = kernel2nt(&inode->i_ctime);
-	de_name->dup.alloc_size = de_name->dup.data_size =
-		cpu_to_le64(inode->i_size);
-	de_name->dup.fa = ni->std_fa;
-	de_name->dup.ea_size = de_name->dup.reparse = 0;
-
  	err = ni_add_name(ntfs_i(d_inode(dentry->d_parent)), ni, de);
  out:
  	__putname(de);
-- 
2.37.0


