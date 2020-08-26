Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEDB8252D2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 13:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgHZL6g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 07:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbgHZL61 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:58:27 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3A9C061756;
        Wed, 26 Aug 2020 04:58:27 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id nv17so774617pjb.3;
        Wed, 26 Aug 2020 04:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dQIGxYJaUiJMLQpqZWtcUMCMHoPDF7noeoktQGM/wjs=;
        b=IOyJhRFh09wT/24mhGxZxBsCozH8kIk8e5bFNSSXiGic7AS5ete9osc24mh6Hktq9f
         hROs8xawJJxEJrJrjJY5lwfSbKro/gm10LgzPnd3Dyrh09wpSjRfBfIoosr9R1gjCCpr
         JP1CaHBakP43+/qBWqA6NMAfG0dTmpJpTB1wjAh6DplZ4kFV9OZZGkgMX473l/wbg4OC
         uYWdJl8540es/L5AvbI8IRcnvscUNdHf3jXIzOtcDzvBeh0wB1ZgEj2MMvrfpfZAodLp
         0qjrCEw+gAoaPQklSDrEUxmY4yZyj/712OnVfcrflC2fzRsVV9pMVJNzTqlKy/dODoN/
         /WxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dQIGxYJaUiJMLQpqZWtcUMCMHoPDF7noeoktQGM/wjs=;
        b=IIGwaYZe/Fog2uZ3nXBIn8X2IxS3vgucQYGgBxu+csvTpMJ0yDmA8u9C9BBYWthb8f
         uLsl2YIBL1XCdke8Kyxol42lGDdv88wJog4g7tTn79+hvS4uDVdIrdRXJbCAl3jAlu3N
         lTI1+hR3rjpaV8k66kS6hArnMA3zmKgoT2+XDjyAYR9Nb8w9+oum1F2KgzM3DtkxsCAO
         jO3kvLt2ng6NFrBRa5dGai/Q25sQ5G9jCm82mSO9eKZOyEHcjus9LSd/+ewOVbNkmxgS
         Xv1qQ3UPst/aMp12Xa3RrF35N6MH6hM5ShjjxMvb9YBYB81QIrEVFD2eJUTod5uooCaC
         DVzA==
X-Gm-Message-State: AOAM532V7qyglOX53x1UemJSebrHuKzUM+KMuNgQo/hb16O8kv+aHyIa
        L+pdlyQ6H8MdxFeOSbfusGU=
X-Google-Smtp-Source: ABdhPJyw83TZfUrlsSOzHEVh5+pESazEKfwXfQ6EAbqUqAAzwDCiz6kvVVYkDfT+ItE1Sw0eoXSYGA==
X-Received: by 2002:a17:90b:4c49:: with SMTP id np9mr5844214pjb.183.1598443106627;
        Wed, 26 Aug 2020 04:58:26 -0700 (PDT)
Received: from dc803.localdomain (FL1-111-169-205-196.hyg.mesh.ad.jp. [111.169.205.196])
        by smtp.gmail.com with ESMTPSA id v1sm1957904pjh.16.2020.08.26.04.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 04:58:26 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] exfat: add dir-entry set checksum validation
Date:   Wed, 26 Aug 2020 20:57:40 +0900
Message-Id: <20200826115742.21207-4-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826115742.21207-1-kohada.t2@gmail.com>
References: <20200826115742.21207-1-kohada.t2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add checksum validation for dir-entry set when getting it.
exfat_calc_entry_set_chksum_with() also validates entry-type.

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
Changes in v2
 - Add error log if checksum mismatch
Changes in v3:
 - Nothing
Changes in v4:
 - Into patch series '[PATCH v4] exfat: integrates dir-entry getting and validation'

 fs/exfat/dir.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index cd37091844fa..d4beea796708 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -565,18 +565,26 @@ int exfat_remove_entries(struct inode *inode, struct exfat_chain *p_dir,
 	return 0;
 }
 
-void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es)
+static int exfat_calc_entry_set_chksum(struct exfat_entry_set_cache *es, u16 *chksum)
 {
-	int chksum_type = CS_DIR_ENTRY, i;
-	u16 chksum = 0;
 	struct exfat_dentry *ep;
+	int i;
 
-	for (i = 0; i < es->num_entries; i++) {
-		ep = exfat_get_validated_dentry(es, i, TYPE_ALL);
-		chksum = exfat_calc_chksum16(ep, DENTRY_SIZE, chksum,
-					     chksum_type);
-		chksum_type = CS_DEFAULT;
+	*chksum = exfat_calc_chksum16(es->ep_file, DENTRY_SIZE, 0, CS_DIR_ENTRY);
+	for (i = 0; i < ES_FILE(es).num_ext; i++) {
+		ep = exfat_get_validated_dentry(es, 1 + i, TYPE_SECONDARY);
+		if (!ep)
+			return -EIO;
+		*chksum = exfat_calc_chksum16(ep, DENTRY_SIZE, *chksum, CS_DEFAULT);
 	}
+	return 0;
+}
+
+void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es)
+{
+	u16 chksum;
+
+	exfat_calc_entry_set_chksum(es, &chksum);
 	ES_FILE(es).checksum = cpu_to_le16(chksum);
 	es->modified = true;
 }
@@ -776,6 +784,7 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_entry_set_cache *es;
 	struct buffer_head *bh;
+	u16 chksum;
 
 	if (p_dir->dir == DIR_DELETED) {
 		exfat_err(sb, "access to deleted dentry");
@@ -839,9 +848,12 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 		goto free_es;
 
 	if (max_entries == ES_ALL_ENTRIES) {
-		for (i = 0; i < ES_FILE(es).num_ext; i++)
-			if (!exfat_get_validated_dentry(es, ES_INDEX_STREAM + i, TYPE_SECONDARY))
-				goto free_es;
+		if (exfat_calc_entry_set_chksum(es, &chksum) ||
+		   chksum != le16_to_cpu(ES_FILE(es).checksum)) {
+			exfat_err(sb, "invalid entry-set checksum (entry : 0x%08x, set-checksum : 0x%04x, checksum : 0x%04x)",
+				  entry, le16_to_cpu(ES_FILE(es).checksum), chksum);
+			goto free_es;
+		}
 		for (i = 0; i * EXFAT_FILE_NAME_LEN < ES_STREAM(es).name_len; i++)
 			if (!exfat_get_validated_dentry(es, ES_INDEX_NAME + i, TYPE_NAME))
 				goto free_es;
-- 
2.25.1

