Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043C2573B8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 18:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbiGMQrz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 12:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236688AbiGMQrw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:47:52 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B312B2FFC0;
        Wed, 13 Jul 2022 09:47:51 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 1161E1DDC;
        Wed, 13 Jul 2022 16:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1657730802;
        bh=uzHNxd7dfVtO8sDJoVYoTuddxcGC53KhUNVKS77W3J0=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=YOonUpH+axxRMOO52aSRGsF3Zgb0BA3kAz89srY2VBWouNhoMhXET3hE8X7saCQIX
         YrnrZn16o0Sf5EbARTW0xIPJJ48J5bqGpEvB8yrR2fD1IkZzRfYoN82VH1L7BdpNuB
         3KI6auNQ3g1YpoIbnxs6qhB9rNOXcGj21DoAfqio=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 9316F213E;
        Wed, 13 Jul 2022 16:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1657730869;
        bh=uzHNxd7dfVtO8sDJoVYoTuddxcGC53KhUNVKS77W3J0=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=NkfYVRoSUZ+PooFsLHSf3tCEG1YmZ76zWJBU7PTyUzLtRkQgYIhcAZg+4L7sEC/hG
         Cv7Y2/RaJDCk0UOSlLuWWXN8mwRcECpH1UDmwKRWpWCfmKR/TsAnmvau0DCStP/W/w
         Q4VoF/VpmSd8d0HNXB7pzwn0mGTB0Fo1ns7uqqSw=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 13 Jul 2022 19:47:49 +0300
Message-ID: <8a2f659b-a73c-349d-5bf2-506b9084a28d@paragon-software.com>
Date:   Wed, 13 Jul 2022 19:47:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 6/6] fs/ntfs3: Make ni_ins_new_attr return error
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <2101d95b-be41-6e6d-e019-bc70f816b2e8@paragon-software.com>
In-Reply-To: <2101d95b-be41-6e6d-e019-bc70f816b2e8@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Function ni_ins_new_attr now returns ERR_PTR(err),
so we check it now in other functions like ni_expand_mft_list

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/frecord.c | 29 ++++++++++++++++++++++++++---
  1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index bdc568053fae..381a38a06ec2 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -469,7 +469,7 @@ ni_ins_new_attr(struct ntfs_inode *ni, struct mft_inode *mi,
  				&ref, &le);
  		if (err) {
  			/* No memory or no space. */
-			return NULL;
+			return ERR_PTR(err);
  		}
  		le_added = true;
  
@@ -1011,6 +1011,8 @@ static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
  				       name_off, svcn, ins_le);
  		if (!attr)
  			continue;
+		if (IS_ERR(attr))
+			return PTR_ERR(attr);
  
  		if (ins_attr)
  			*ins_attr = attr;
@@ -1032,8 +1034,15 @@ static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
  
  	attr = ni_ins_new_attr(ni, mi, le, type, name, name_len, asize,
  			       name_off, svcn, ins_le);
-	if (!attr)
+	if (!attr) {
+		err = -EINVAL;
  		goto out2;
+	}
+
+	if (IS_ERR(attr)) {
+		err = PTR_ERR(attr);
+		goto out2;
+	}
  
  	if (ins_attr)
  		*ins_attr = attr;
@@ -1045,7 +1054,6 @@ static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
  out2:
  	ni_remove_mi(ni, mi);
  	mi_put(mi);
-	err = -EINVAL;
  
  out1:
  	ntfs_mark_rec_free(sbi, rno, is_mft);
@@ -1101,6 +1109,11 @@ static int ni_insert_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
  	if (asize <= free) {
  		attr = ni_ins_new_attr(ni, &ni->mi, NULL, type, name, name_len,
  				       asize, name_off, svcn, ins_le);
+		if (IS_ERR(attr)) {
+			err = PTR_ERR(attr);
+			goto out;
+		}
+
  		if (attr) {
  			if (ins_attr)
  				*ins_attr = attr;
@@ -1198,6 +1211,11 @@ static int ni_insert_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
  		goto out;
  	}
  
+	if (IS_ERR(attr)) {
+		err = PTR_ERR(attr);
+		goto out;
+	}
+
  	if (ins_attr)
  		*ins_attr = attr;
  	if (ins_mi)
@@ -1313,6 +1331,11 @@ static int ni_expand_mft_list(struct ntfs_inode *ni)
  		goto out;
  	}
  
+	if (IS_ERR(attr)) {
+		err = PTR_ERR(attr);
+		goto out;
+	}
+
  	attr->non_res = 1;
  	attr->name_off = SIZEOF_NONRESIDENT_LE;
  	attr->flags = 0;
-- 
2.37.0


