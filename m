Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF80422E52
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 18:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbhJEQuG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 12:50:06 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:34234 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236487AbhJEQuG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 12:50:06 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id D06F01D3B;
        Tue,  5 Oct 2021 19:48:13 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1633452493;
        bh=YuskuQuAgZsOqG0YgqLVC+7Kcm0wSnwnkm4o59cUwKY=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=SZ8XrpNBmCFHkO9W4bNRP7bYOkUVfJ9pJzl3mYijVoejGQExvwMYCuc2Yn/hgpYL7
         fN4I37AC16I1AcTkBeAi9h2DSY2lR8k9EojxVLv7vpvD98v5soc4Pdp21GdGmJKPf5
         Ndk41kjOYTmPZi3w+2lNgDcajefr2+Mo7rRutdbc=
Received: from [192.168.211.181] (192.168.211.181) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 5 Oct 2021 19:48:13 +0300
Message-ID: <4446f0e7-4b15-2e51-a752-e07e95a6da24@paragon-software.com>
Date:   Tue, 5 Oct 2021 19:48:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: [PATCH 4/5] fs/ntfs3: Refactor ni_parse_reparse
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <98a166e4-f894-8bff-9479-05ef5435f1ed@paragon-software.com>
In-Reply-To: <98a166e4-f894-8bff-9479-05ef5435f1ed@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.181]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change argument from void* to struct REPARSE_DATA_BUFFER*
We copy data to buffer, so we can read it later in ntfs_read_mft.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/frecord.c | 9 +++++----
 fs/ntfs3/ntfs_fs.h | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 007602badd90..ecb965e4afd0 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1710,18 +1710,16 @@ int ni_new_attr_flags(struct ntfs_inode *ni, enum FILE_ATTRIBUTE new_fa)
 /*
  * ni_parse_reparse
  *
- * Buffer is at least 24 bytes.
+ * buffer - memory for reparse buffer header
  */
 enum REPARSE_SIGN ni_parse_reparse(struct ntfs_inode *ni, struct ATTRIB *attr,
-				   void *buffer)
+				   struct REPARSE_DATA_BUFFER *buffer)
 {
 	const struct REPARSE_DATA_BUFFER *rp = NULL;
 	u8 bits;
 	u16 len;
 	typeof(rp->CompressReparseBuffer) *cmpr;
 
-	static_assert(sizeof(struct REPARSE_DATA_BUFFER) <= 24);
-
 	/* Try to estimate reparse point. */
 	if (!attr->non_res) {
 		rp = resident_data_ex(attr, sizeof(struct REPARSE_DATA_BUFFER));
@@ -1807,6 +1805,9 @@ enum REPARSE_SIGN ni_parse_reparse(struct ntfs_inode *ni, struct ATTRIB *attr,
 		return REPARSE_NONE;
 	}
 
+	if (buffer != rp)
+		memcpy(buffer, rp, sizeof(struct REPARSE_DATA_BUFFER));
+
 	/* Looks like normal symlink. */
 	return REPARSE_LINK;
 }
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 9277b552f257..e95d93c683ed 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -547,7 +547,7 @@ struct ATTR_FILE_NAME *ni_fname_type(struct ntfs_inode *ni, u8 name_type,
 				     struct ATTR_LIST_ENTRY **entry);
 int ni_new_attr_flags(struct ntfs_inode *ni, enum FILE_ATTRIBUTE new_fa);
 enum REPARSE_SIGN ni_parse_reparse(struct ntfs_inode *ni, struct ATTRIB *attr,
-				   void *buffer);
+				   struct REPARSE_DATA_BUFFER *buffer);
 int ni_write_inode(struct inode *inode, int sync, const char *hint);
 #define _ni_write_inode(i, w) ni_write_inode(i, w, __func__)
 int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
-- 
2.33.0


