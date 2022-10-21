Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9AB607CBC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 18:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiJUQwK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 12:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiJUQwF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:52:05 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1443628511B;
        Fri, 21 Oct 2022 09:52:03 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 01ADA2201;
        Fri, 21 Oct 2022 16:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1666370969;
        bh=ZCNllPC/IP07/I4v8msKmPt1Eyvxq647ljuvf/bKJqE=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=BCNrNY4SZycSHjYIYtcSk/wdH/VOM2dKBRiLSxnClHBh58xSKhUY8mrLfMAGPcYoc
         O/3wJJsNoD+NQehqoADpq2Q7EACnrLf0QSRZOezV/fhpuxjGMyI5NJNOGtPmm66Orh
         2Bodl6Ed1N/pn5CY1UD0pYXONoaX53RcN1f1xpnw=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 21 Oct 2022 19:52:01 +0300
Message-ID: <21a9d399-f3bf-6e57-0f38-cdbf68fdad58@paragon-software.com>
Date:   Fri, 21 Oct 2022 19:52:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 2/4] fs/ntfs3: Fix sparse problems
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <9a7d08c2-e503-ac1d-1621-20369c073530@paragon-software.com>
In-Reply-To: <9a7d08c2-e503-ac1d-1621-20369c073530@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixing various problems, detected by sparse.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/attrib.c  |  7 ++++---
  fs/ntfs3/dir.c     |  4 ++--
  fs/ntfs3/frecord.c |  3 +--
  fs/ntfs3/namei.c   | 13 ++++++-------
  4 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 63169529b52c..b2f54fab4001 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -2308,7 +2308,8 @@ int attr_insert_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
  
  		if (!attr_b->non_res) {
  			/* Still resident. */
-			char *data = Add2Ptr(attr_b, attr_b->res.data_off);
+			char *data = Add2Ptr(attr_b,
+					     le16_to_cpu(attr_b->res.data_off));
  
  			memmove(data + bytes, data, bytes);
  			memset(data, 0, bytes);
@@ -2400,8 +2401,8 @@ int attr_insert_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
  	if (vbo <= ni->i_valid)
  		ni->i_valid += bytes;
  
-	attr_b->nres.data_size = le64_to_cpu(data_size + bytes);
-	attr_b->nres.alloc_size = le64_to_cpu(alloc_size + bytes);
+	attr_b->nres.data_size = cpu_to_le64(data_size + bytes);
+	attr_b->nres.alloc_size = cpu_to_le64(alloc_size + bytes);
  
  	/* ni->valid may be not equal valid_size (temporary). */
  	if (ni->i_valid > data_size + bytes)
diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index fb438d604040..063a6654199b 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -26,8 +26,8 @@ int ntfs_utf16_to_nls(struct ntfs_sb_info *sbi, const __le16 *name, u32 len,
  
  	if (!nls) {
  		/* UTF-16 -> UTF-8 */
-		ret = utf16s_to_utf8s(name, len, UTF16_LITTLE_ENDIAN, buf,
-				      buf_len);
+		ret = utf16s_to_utf8s((wchar_t *)name, len, UTF16_LITTLE_ENDIAN,
+				      buf, buf_len);
  		buf[ret] = '\0';
  		return ret;
  	}
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 8a741706c7a5..a7aed31e7c93 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1670,8 +1670,7 @@ struct ATTR_FILE_NAME *ni_fname_name(struct ntfs_inode *ni,
  		goto next;
  
  	fns = (struct le_str *)&fname->name_len;
-	if (ntfs_cmp_names(uni->name, uni->len, fns->name, fns->len, NULL,
-			       false))
+	if (ntfs_cmp_names_cpu(uni, fns, NULL, false))
  		goto next;
  
  	return fname;
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 315763eb05ff..ff76389475ad 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -427,7 +427,8 @@ static int ntfs_d_compare(const struct dentry *dentry, unsigned int len1,
  	unsigned int len2 = name->len;
  	unsigned int lm = min(len1, len2);
  	unsigned char c1, c2;
-	struct cpu_str *uni1, *uni2;
+	struct cpu_str *uni1;
+	struct le_str *uni2;
  
  	/* First try fast implementation. */
  	for (;;) {
@@ -468,8 +469,9 @@ static int ntfs_d_compare(const struct dentry *dentry, unsigned int len1,
  
  	uni2 = Add2Ptr(uni1, 2048);
  
-	ret = ntfs_nls_to_utf16(sbi, name->name, name->len, uni2, NTFS_NAME_LEN,
-				UTF16_HOST_ENDIAN);
+	ret = ntfs_nls_to_utf16(sbi, name->name, name->len,
+				(struct cpu_str *)uni2, NTFS_NAME_LEN,
+				UTF16_LITTLE_ENDIAN);
  	if (ret < 0)
  		goto out;
  
@@ -478,10 +480,7 @@ static int ntfs_d_compare(const struct dentry *dentry, unsigned int len1,
  		goto out;
  	}
  
-	ret = !ntfs_cmp_names(uni1->name, uni1->len, uni2->name, uni2->len,
-			      sbi->upcase, false)
-		      ? 0
-		      : 1;
+	ret = !ntfs_cmp_names_cpu(uni1, uni2, sbi->upcase, false) ? 0 : 1;
  
  out:
  	__putname(uni1);
-- 
2.37.0


