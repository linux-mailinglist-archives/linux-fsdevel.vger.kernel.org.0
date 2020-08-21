Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3AC24CD3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 07:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgHUFXJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 01:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgHUFXH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 01:23:07 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A3DC061385;
        Thu, 20 Aug 2020 22:23:07 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ds1so329131pjb.1;
        Thu, 20 Aug 2020 22:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZZbvEOuYBmxlDQktmrCFXwfwHsDZjGpqfzYq7LMyb/o=;
        b=WUFouK4/7MwMoyMcslhAyJ290hTSQeapeDAXmbMPHR18J7yXx6w+eIciJSA5COrpkx
         gxfJN0mAMV2G8Hxuc0Y4NIB7S/lMl4grm7AqoRMKvfWPkTNW/1EiPAutzxtcokplL/vi
         cYKIOa+e4Iey2iliK+lsi10BoVGEderWVMah628HIbIJvh/nyxdoquISg5iaBPlN0Aqh
         JZFKG4CgMb86SLOdh/gV9BWJzER6N2bYt2/hUObNzCUw4yiZ2ToN0Vh55Iat6qW43l7f
         D/WUS5idzfsUZsitGuuEWWi/Emby9C4Mc9jWu6j+USWftwVR6+z1sYf/qC3cRmAROTht
         TdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZZbvEOuYBmxlDQktmrCFXwfwHsDZjGpqfzYq7LMyb/o=;
        b=rxSpvdVZkQomd/98TSXC8wDIV4SMiFdCmcPORejopGgiz7qJgha3obQKxP4osoYdT0
         2PeUXfMmf5qBeaSZrJWt2MkkpYWBwANO/ToFHjA+v5P7fl0vnpBLSZeKZQ21mIEczlAC
         hsWjXPkV4SIl2PK+T7hglBHtIqrJlloQ0qdoM+2bNO8M+ltlRWexnQm+qWoPr6YFmz0A
         aHflu3BbUmulDdNIQU2Ges3Xmzbs9vCT8Mv2YVS+J94V59z68WIH6byB8k5n5RsL8Q/i
         wt8QQ0+Yz3Wh+8DTif0ZQvvLNasHvR4Mva5sZKlvjRnWQZG7xJRVajNLFsJkhBo+uMqN
         Xnbg==
X-Gm-Message-State: AOAM532qEYtsaouIwh+DOFvJZGZu/WKNeHPorPIYBNQ55mKEvyPShxfk
        JF5ebGULGhL3LAheh23lFIY=
X-Google-Smtp-Source: ABdhPJzyDbe4Emcx/YCdc+w+TJ4f9S2PFELEXtMeUODVX9tLxlKN6nbftTjkrF4d1CNhJs8eQjTEFA==
X-Received: by 2002:a17:90a:ce94:: with SMTP id g20mr1036970pju.61.1597987387066;
        Thu, 20 Aug 2020 22:23:07 -0700 (PDT)
Received: from dc803.localdomain (flh2-125-196-131-224.osk.mesh.ad.jp. [125.196.131.224])
        by smtp.gmail.com with ESMTPSA id t19sm925602pfc.5.2020.08.20.22.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 22:23:06 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] exfat: add dir-entry set checksum validation
Date:   Fri, 21 Aug 2020 14:22:54 +0900
Message-Id: <20200821052255.30626-1-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add checksum validation for dir-entry set when getting it.
exfat_calc_entry_set_chksum_with() also validates entry-type.

** This patch depends on:
  '[PATCH v3] exfat: integrates dir-entry getting and validation'

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
Changes in v2
 - Add error log if checksum mismatch

 fs/exfat/dir.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 0b42544e6340..6f9de364a919 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -565,18 +565,27 @@ int exfat_remove_entries(struct inode *inode, struct exfat_chain *p_dir,
 	return 0;
 }
 
-void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es)
+static int exfat_calc_entry_set_chksum(struct exfat_entry_set_cache *es, u16 *chksum)
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
+	exfat_calc_entry_set_chksum(es, &chksum);
 	es->de_file->checksum = cpu_to_le16(chksum);
 	es->modified = true;
 }
@@ -777,6 +786,7 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 	struct exfat_entry_set_cache *es;
 	struct exfat_dentry *ep;
 	struct buffer_head *bh;
+	u16 chksum;
 
 	if (p_dir->dir == DIR_DELETED) {
 		exfat_err(sb, "access to deleted dentry");
@@ -841,11 +851,13 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 		goto free_es;
 	es->de_stream = &ep->dentry.stream;
 
-	for (i = 2; i < es->num_entries; i++) {
-		if (!exfat_get_validated_dentry(es, i, TYPE_SECONDARY))
-			goto free_es;
+	if (max_entries == ES_ALL_ENTRIES &&
+	    ((exfat_calc_entry_set_chksum(es, &chksum) ||
+	      chksum != le16_to_cpu(es->de_file->checksum)))) {
+		exfat_err(sb, "invalid entry-set checksum (entry : 0x%08x, set-checksum : 0x%04x, checksum : 0x%04x)",
+			  entry, le16_to_cpu(es->de_file->checksum), chksum);
+		goto free_es;
 	}
-
 	return es;
 
 free_es:
-- 
2.25.1

