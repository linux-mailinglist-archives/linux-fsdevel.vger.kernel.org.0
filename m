Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21BA417854
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 18:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347376AbhIXQSJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 12:18:09 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:37422 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233727AbhIXQSJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 12:18:09 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 96C9C82359;
        Fri, 24 Sep 2021 19:16:33 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632500193;
        bh=TTvlWZtjHHzxwQJsZkX9U6WZp22CRR8+Jp8dht0zajs=;
        h=Date:Subject:From:To:References:CC:In-Reply-To;
        b=UUmaQiQ+z2zI5TVYOMyer3CYOGluk1LNH3wEgVR345ssy5n+dkkajHqi+IIIcHSx0
         y/298qdAKvr5z0i2LEul7cxH73avE7UAJ0EJZ0ilvkiT/mC4piLgI1qy5CPiP7C+PW
         YjRj60OZNGOUt6DtOQhBpG3dSUCqJjIUwiHN2D58=
Received: from [192.168.211.101] (192.168.211.101) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 24 Sep 2021 19:16:33 +0300
Message-ID: <cb84627e-ff9c-1945-ea53-89d66e13406b@paragon-software.com>
Date:   Fri, 24 Sep 2021 19:16:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: [PATCH 3/3] fs/ntfs3: Refactoring of ntfs_set_ea
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
References: <eb131ee0-3e89-da58-650c-5b84dd792a49@paragon-software.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <eb131ee0-3e89-da58-650c-5b84dd792a49@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.101]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make code more readable.
Don't try to read zero bytes.
Add warning when size of exteneded attribute exceeds limit.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/xattr.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 1ab109723b10..395e71291e28 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -75,6 +75,7 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
 			size_t add_bytes, const struct EA_INFO **info)
 {
 	int err;
+	struct ntfs_sb_info *sbi = ni->mi.sbi;
 	struct ATTR_LIST_ENTRY *le = NULL;
 	struct ATTRIB *attr_info, *attr_ea;
 	void *ea_p;
@@ -99,10 +100,10 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
 
 	/* Check Ea limit. */
 	size = le32_to_cpu((*info)->size);
-	if (size > ni->mi.sbi->ea_max_size)
+	if (size > sbi->ea_max_size)
 		return -EFBIG;
 
-	if (attr_size(attr_ea) > ni->mi.sbi->ea_max_size)
+	if (attr_size(attr_ea) > sbi->ea_max_size)
 		return -EFBIG;
 
 	/* Allocate memory for packed Ea. */
@@ -110,15 +111,16 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
 	if (!ea_p)
 		return -ENOMEM;
 
-	if (attr_ea->non_res) {
+	if (!size) {
+		;
+	} else if (attr_ea->non_res) {
 		struct runs_tree run;
 
 		run_init(&run);
 
 		err = attr_load_runs(attr_ea, ni, &run, NULL);
 		if (!err)
-			err = ntfs_read_run_nb(ni->mi.sbi, &run, 0, ea_p, size,
-					       NULL);
+			err = ntfs_read_run_nb(sbi, &run, 0, ea_p, size, NULL);
 		run_close(&run);
 
 		if (err)
@@ -366,21 +368,22 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
 	new_ea->name[name_len] = 0;
 	memcpy(new_ea->name + name_len + 1, value, val_size);
 	new_pack = le16_to_cpu(ea_info.size_pack) + packed_ea_size(new_ea);
-
-	/* Should fit into 16 bits. */
-	if (new_pack > 0xffff) {
-		err = -EFBIG; // -EINVAL?
-		goto out;
-	}
 	ea_info.size_pack = cpu_to_le16(new_pack);
-
 	/* New size of ATTR_EA. */
 	size += add;
-	if (size > sbi->ea_max_size) {
+	ea_info.size = cpu_to_le32(size);
+
+	/*
+	 * 1. Check ea_info.size_pack for overflow.
+	 * 2. New attibute size must fit value from $AttrDef
+	 */
+	if (new_pack > 0xffff || size > sbi->ea_max_size) {
+		ntfs_inode_warn(
+			inode,
+			"The size of exteneded attributes must not exceed 64K");
 		err = -EFBIG; // -EINVAL?
 		goto out;
 	}
-	ea_info.size = cpu_to_le32(size);
 
 update_ea:
 
-- 
2.33.0


