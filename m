Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DF523E7FA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 09:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgHGHa5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 03:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHGHa4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:30:56 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15581C061574;
        Fri,  7 Aug 2020 00:30:56 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u20so562975pfn.0;
        Fri, 07 Aug 2020 00:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=12q2iDN/YQAMmiwijXrl91ogiPtfmiW0SAQOocLHo1Y=;
        b=PgDuZ1AoFYFz62izIwb8cPWickw2zyUdR0fekCVZjn9rmvwp1dzA8gYt15mXy/X4nO
         MfNUI/+cBcpKSP4nPLppo4NFz3iFo1r1mqopO+rcJe5qBu4AYJLOPEiHgi/gnJgC4YEN
         5NyPkQysnkUJIaIpEXqjE6VhRgc79RaVwtW2JtDMDKlxsemMhm6jsKNhHMCNwKBIGdBK
         S4OxKHs9oXOcnl9lJ3g87nJK/NmOfy8390CCCP8twbF/8NTkzGtGZSsEYrkiGCqi7R7/
         y6RBUOlERLfa1CPuuRmdVsPOzez4He2s75v6O2IgMZjwWtUjqxAhDlx3MCKozp0qEzNG
         /PVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=12q2iDN/YQAMmiwijXrl91ogiPtfmiW0SAQOocLHo1Y=;
        b=ShEtwcTTzeiKCMvJ/V6xTcY0LjgI43Z81DDmKcdDLfe7qp1HSq0D/CLOLNv89u1VcW
         OHG/2RrvyICdJVkAsqVyEjkapiUigFTLfah3+T9qQi5E1WsppeJQmRWjkMN+W61I6o4c
         BcuW/c7hfgfkWWe9GrxqG16Y7U0xdubeCInmVAJo0leYkDKR8slaXwPyONEsYasKnTcz
         Ha80lxMajwXZ0scmxktWQ0U4/3kKN/q2lfetoqW1zhxC8NPJkUeiyekSmqSnwXTq+uIa
         3o6OYzC+eomr6l+chRQqCsIme83+frpNZ2t3D7TVOKoetWg3AUuhqalVt53ywbrZPS/x
         3Fuw==
X-Gm-Message-State: AOAM530+FXS3WOFMW8JUx8MRdgn0Y4pulApRT5AQfcmUAnVN4oKGJJXb
        yRR4xui4Ia2KOgIYW82/tHE=
X-Google-Smtp-Source: ABdhPJwN1X8goGoRMJDRaLdI3tWVPblbljhOmdmPEQtcE39uDEZoEfEDxp7/KdozksQUtltWL3YB0A==
X-Received: by 2002:a62:1543:: with SMTP id 64mr12301411pfv.242.1596785455446;
        Fri, 07 Aug 2020 00:30:55 -0700 (PDT)
Received: from dc803.localdomain (FL1-218-42-16-224.hyg.mesh.ad.jp. [218.42.16.224])
        by smtp.gmail.com with ESMTPSA id y7sm10020079pjm.3.2020.08.07.00.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 00:30:55 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] exfat: add dir-entry set checksum validation
Date:   Fri,  7 Aug 2020 16:30:48 +0900
Message-Id: <20200807073049.24959-1-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add checksum validation for dir-entry set when getting it.
exfat_calc_dir_chksum_with_entry_set() also validates entry-type.

** This patch depends on:
  '[PATCH v3] exfat: integrates dir-entry getting and validation'

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
 fs/exfat/dir.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index c9715c7a55a1..2e79ac464f5f 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -563,18 +563,27 @@ int exfat_remove_entries(struct inode *inode, struct exfat_chain *p_dir,
 	return 0;
 }
 
-void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es)
+static int exfat_calc_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es, u16 *chksum)
 {
-	int chksum_type = CS_DIR_ENTRY, i;
-	unsigned short chksum = 0;
 	struct exfat_dentry *ep;
+	int i;
 
-	for (i = 0; i < es->num_entries; i++) {
-		ep = exfat_get_validated_dentry(es, i, TYPE_ALL);
-		chksum = exfat_calc_chksum16(ep, DENTRY_SIZE, chksum,
-					     chksum_type);
-		chksum_type = CS_DEFAULT;
+	ep = container_of(es->de_file, struct exfat_dentry, dentry.file);
+	*chksum = exfat_calc_chksum16(ep, DENTRY_SIZE, 0, CS_DIR_ENTRY);
+	for (i = 0; i < es->de_file->num_ext; i++) {
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
+	exfat_calc_dir_chksum_with_entry_set(es, &chksum);
 	es->de_file->checksum = cpu_to_le16(chksum);
 	es->modified = true;
 }
@@ -775,6 +784,7 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 	struct exfat_entry_set_cache *es;
 	struct exfat_dentry *ep;
 	struct buffer_head *bh;
+	u16 chksum;
 
 	if (p_dir->dir == DIR_DELETED) {
 		exfat_err(sb, "access to deleted dentry");
@@ -839,10 +849,10 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 		goto free_es;
 	es->de_stream = &ep->dentry.stream;
 
-	for (i = 2; i < es->num_entries; i++) {
-		if (!exfat_get_validated_dentry(es, i, TYPE_SECONDARY))
-			goto free_es;
-	}
+	if (max_entries == ES_ALL_ENTRIES &&
+	    ((exfat_calc_dir_chksum_with_entry_set(es, &chksum) ||
+	      chksum != le16_to_cpu(es->de_file->checksum))))
+		goto free_es;
 
 	return es;
 
-- 
2.25.1

