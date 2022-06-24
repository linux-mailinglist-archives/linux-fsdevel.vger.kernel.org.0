Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01F55598AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 13:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiFXLlb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 07:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiFXLl2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 07:41:28 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE907946B;
        Fri, 24 Jun 2022 04:41:25 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id A0C5A1D74;
        Fri, 24 Jun 2022 11:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1656070832;
        bh=wsI+VTIYH+j37kEK0piYgrtJJa0d/rvQA7XicNxJ+L4=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=bzSGPQvPb2+lJosI+YVjCM3AAPt9mWiSgN+DQeyiM49ESMT2kYeyrkfBKKA6My6AP
         n6y5v92brwcyD2K3CWL9cD0ooDf/IC11Y3KJ5itkAGiV0jbO6rhsrvr9idfm9fFhuw
         kf5M+ORyzgzZ1emK7Mm1BWxqtv7zwjogQzcWnUW0=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 24 Jun 2022 14:41:23 +0300
Message-ID: <8cb6d3fe-22ed-4166-c047-de0da97c4a11@paragon-software.com>
Date:   Fri, 24 Jun 2022 14:41:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: [PATCH 2/3] fs/ntfs3: Check reserved size for maximum allowed
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <f76c96bb-fdea-e1e5-5f47-c092af5fe556@paragon-software.com>
In-Reply-To: <f76c96bb-fdea-e1e5-5f47-c092af5fe556@paragon-software.com>
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

Also don't mask EFBIG
Fixes xfstest generic/485
Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/attrib.c | 11 ++++++++++-
  fs/ntfs3/file.c   |  3 ---
  2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index bea0e70e974a..3bd51cf4d8bd 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -2114,9 +2114,11 @@ int attr_insert_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
  
  	if (!attr_b->non_res) {
  		data_size = le32_to_cpu(attr_b->res.data_size);
+		alloc_size = data_size;
  		mask = sbi->cluster_mask; /* cluster_size - 1 */
  	} else {
  		data_size = le64_to_cpu(attr_b->nres.data_size);
+		alloc_size = le64_to_cpu(attr_b->nres.alloc_size);
  		mask = (sbi->cluster_size << attr_b->nres.c_unit) - 1;
  	}
  
@@ -2130,6 +2132,13 @@ int attr_insert_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
  		return -EINVAL;
  	}
  
+	/*
+	 * valid_size <= data_size <= alloc_size
+	 * Check alloc_size for maximum possible.
+	 */
+	if (bytes > sbi->maxbytes_sparse - alloc_size)
+		return -EFBIG;
+
  	vcn = vbo >> sbi->cluster_bits;
  	len = bytes >> sbi->cluster_bits;
  
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 5ee035e42c21..de37d5c1d60b 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -732,9 +732,6 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
  	if (map_locked)
  		filemap_invalidate_unlock(mapping);
  
-	if (err == -EFBIG)
-		err = -ENOSPC;
-
  	if (!err) {
  		inode->i_ctime = inode->i_mtime = current_time(inode);
  		mark_inode_dirty(inode);
-- 
2.36.1


