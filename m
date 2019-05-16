Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7A12035E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 12:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfEPK1B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 06:27:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39519 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfEPK1B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 06:27:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id w8so2759787wrl.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 03:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=92UflgOu/j9LiI2qc0tPQ67e3Dpk5CHT3nyHp7GlrTI=;
        b=jxY9UJJSDHi/1C15s6x7Jq9TrkOKpT3uktOIZi09F6SdMpMzYqx8UL3bMmKoDH9bfj
         eXRcuG/oo4wYQtyFs6DVNwUq1Z96K9ZS3zlQgoDy33n2NORxHeIZVhY7R0WFHZ2SbTvm
         ZCR134tAIsHoGoBo6iYzzwLLEwryve7450kH+imIVrNTmkx4r0xwsJp1z9lY1TiA1tRO
         f6yKYRDQRoFSSGb4iSI8zzgHG/+d8jskaZhvkFy5xRr45oC/vFu31a3XfV1HPy/EZV+S
         JIOjtsBeSldqInRVO8Pld/l/1p88aq2HmeFm9W23rECQdkS313EmkRvevJ8tBg51y72x
         EJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=92UflgOu/j9LiI2qc0tPQ67e3Dpk5CHT3nyHp7GlrTI=;
        b=ccBqrTsHoJPeOLHhMg1CaEEGDDgAwIt5pBnUDF3wcN/3sKpQkoRLcLx+XNDYDWAf2h
         bUg5Vjf56Hvug+sxSi89XcP+ID4kr/keuwJen2nnC+gLlEurLcoDMyZWeV85YQ8lMC8W
         oBAsUSJIyJex9IART13nr2SYrP6/vQKiF6+TEJNZN8ERSRxRP7sRDXcKYYX8yYQF2N40
         YSR/luTKMg9iaC/276/DRCuI3lF5as5RDJp3cDtU0DYooStypP0IzEClJd4VYo7xlvA+
         q308M47itvLcOO8DPir7cNxP4FG1rR77MzjZPp6VzAK5gclztZT7bGv/r9y2LCQySIEq
         38Xw==
X-Gm-Message-State: APjAAAWiVZKYEbXqh2GL9LwojmL+zbk0WZTeXXj1D8ceiHuk4ktKy/Mb
        vbRPB/iDQ0XKJx6f+z2AidY=
X-Google-Smtp-Source: APXvYqwMpEKMjmzaFSlC8Je1xQi2QUOmJORHyMcbF53z2ojiMNExkV9/Qh5C/lbV+6hHWAonKwmf/g==
X-Received: by 2002:adf:ebd2:: with SMTP id v18mr10948417wrn.108.1558002419996;
        Thu, 16 May 2019 03:26:59 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id d72sm4506299wmd.12.2019.05.16.03.26.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 03:26:59 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v2 05/14] fs: convert qibfs/ipathfs to use simple_remove() helper
Date:   Thu, 16 May 2019 13:26:32 +0300
Message-Id: <20190516102641.6574-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516102641.6574-1-amir73il@gmail.com>
References: <20190516102641.6574-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This will allow generating fsnotify delete events after the
fsnotify_nameremove() hook is removed from d_delete().

Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 drivers/infiniband/hw/qib/qib_fs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_fs.c b/drivers/infiniband/hw/qib/qib_fs.c
index ceb42d948412..795938a2488b 100644
--- a/drivers/infiniband/hw/qib/qib_fs.c
+++ b/drivers/infiniband/hw/qib/qib_fs.c
@@ -491,8 +491,7 @@ static int remove_device_files(struct super_block *sb,
 	}
 	remove_file(dir, "flash");
 	inode_unlock(d_inode(dir));
-	ret = simple_rmdir(d_inode(root), dir);
-	d_delete(dir);
+	ret = simple_remove(d_inode(root), dir);
 	dput(dir);
 
 bail:
-- 
2.17.1

