Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9888D105D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 15:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbfJINkQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 09:40:16 -0400
Received: from mout02.posteo.de ([185.67.36.66]:42505 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731293AbfJINkO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:40:14 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 58861240100
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2019 15:32:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1570627927; bh=Iwg5/9KBuQdylE3CE5fdVfFc4CNvlOD+2Jrd/IUhVYY=;
        h=From:To:Cc:Subject:Date:From;
        b=FxMOzmOZcUOWsWC4tInheRglsIOHz08/4niPEUM7YvrWiMjFQVPacvkMH30iTd8wk
         TTgamawL8LUQg+WANOlEVG3N/wRAVnQoohFp8VMO1uwBhj/QPY6jR+Vr0xi5Jnrnds
         AriEhJMFpC0lxQci6GtiyArSF8wUfTQbY06CIVpkUcv6L79/aHeoCxKp0GxPIW2bln
         LhU9x51NAvH6Q1aD1i+LDbKBfu21txDPlo1b/A9wuhb4sjMy5v8Fxs8wfASSvBStaB
         PGXSNwp+wrAwubdC8soWIKfGkHqDECTmA+5jDRFePYkzqXlKCL2xpSHCBV2GweZfTg
         5mi7KAzjgY0UA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 46pFWC0R5dz9rxN;
        Wed,  9 Oct 2019 15:32:07 +0200 (CEST)
From:   philipp.ammann@posteo.de
To:     linux-fsdevel@vger.kernel.org
Cc:     Andreas Schneider <asn@cryptomilk.org>
Subject: [PATCH 3/6] Check that the new path while moving a file is not too long
Date:   Wed,  9 Oct 2019 15:31:54 +0200
Message-Id: <20191009133157.14028-4-philipp.ammann@posteo.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009133157.14028-1-philipp.ammann@posteo.de>
References: <20191009133157.14028-1-philipp.ammann@posteo.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Andreas Schneider <asn@cryptomilk.org>

Signed-off-by: Andreas Schneider <asn@cryptomilk.org>
---
 drivers/staging/exfat/exfat_super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 5f6caee819a6..b63186a67af6 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -1300,6 +1300,9 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 	}
 
 	/* check the validity of directory name in the given new pathname */
+	if (strlen(new_path) >= MAX_NAME_LENGTH)
+		return FFS_NAMETOOLONG;
+
 	ret = resolve_path(new_parent_inode, new_path, &newdir, &uni_name);
 	if (ret)
 		goto out2;
-- 
2.21.0

