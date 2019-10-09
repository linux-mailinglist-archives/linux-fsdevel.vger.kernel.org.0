Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A98AD105C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 15:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731339AbfJINkQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 09:40:16 -0400
Received: from mout02.posteo.de ([185.67.36.66]:53005 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731259AbfJINkO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:40:14 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id CB6E12400FF
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2019 15:32:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1570627927; bh=qi8nNlBgU2FQhwXxuF04700QnQlYmpHyq5Gu24vhgcE=;
        h=From:To:Cc:Subject:Date:From;
        b=qPNPV9WOJZcKbIeZwjcrEHyDl5hiHaEPK7LmelSLdFAUa13lBwB1ioyl5tlbA1JOd
         rdGODtzDRnnyDDVX3dt491MSWopYKs5DUmCVHMoW4Rf5Cg+B4r7eqWpTy5lLRilkW+
         caiTmPF3WuW6Jfj6r02TCg/w7Y+ZNpZfVH7ZSJxnc6qVB2lNCja89f8BpLYOjw3jKh
         ZxX3JRwbgmYKi5jJlbi/t8RZ8TfjEAnIPCdkIp9Kn4ajBezuiQc61b4AsojgF+w62w
         Bvj6KkahxMdfohCMONCmt1/Nxe0tCnue5p1AchMI8QXu4+DBmUZ5tkjmyhqVzlY5At
         yAPJGvXi6zR1Q==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 46pFWC3vj7z9rxM;
        Wed,  9 Oct 2019 15:32:07 +0200 (CEST)
From:   philipp.ammann@posteo.de
To:     linux-fsdevel@vger.kernel.org
Cc:     Andreas Schneider <asn@cryptomilk.org>
Subject: [PATCH 6/6] Add device ejected to mount options
Date:   Wed,  9 Oct 2019 15:31:57 +0200
Message-Id: <20191009133157.14028-7-philipp.ammann@posteo.de>
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
index e8e481a5ddc9..d97616351159 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -3541,6 +3541,7 @@ static int exfat_show_options(struct seq_file *m, struct dentry *root)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(root->d_sb);
 	struct exfat_mount_options *opts = &sbi->options;
+	FS_INFO_T *p_fs = &(sbi->fs_info);
 
 	if (__kuid_val(opts->fs_uid))
 		seq_printf(m, ",uid=%u", __kuid_val(opts->fs_uid));
@@ -3565,6 +3566,8 @@ static int exfat_show_options(struct seq_file *m, struct dentry *root)
 	if (opts->discard)
 		seq_puts(m, ",discard");
 #endif
+	if (p_fs->dev_ejected)
+		seq_puts(m, ",ejected");
 	return 0;
 }
 
-- 
2.21.0

