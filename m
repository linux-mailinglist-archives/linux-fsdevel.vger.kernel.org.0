Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5B3E3710
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 17:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409808AbfJXPyR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 11:54:17 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:42694 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2409775AbfJXPyN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:54:13 -0400
Received: from mr4.cc.vt.edu (junk.cc.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OFsBuX009973
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:11 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OFs6If014729
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:11 -0400
Received: by mail-qt1-f198.google.com with SMTP id c32so23011047qtb.14
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 08:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3IhcIWhcLHyE2F3fnkVjEngCjGh0YImaBO6o0ZZAEbo=;
        b=t0n3bzBJ2uiwDZGVXNXbzraK2hoyf/cH9tqEIEtJeFwWGiqmPaIJ/VgVErJTn+Qr9e
         95/ydH03JYIQZhuffAEh5JCoICMERtmYIr/ehuRchb4yD33cjkUdYm2m9lEvmJdc0O5V
         5mb1SGu/GC8Brvzpxg2cohTa6qVDCupn/FWJpjcJI4VIGLDekaSuzQrPQyBqDtPiqXHh
         o58toTyuV1bg6MfkXbGRcecBV70lNr1cVwvu0AnHDB/PpYhclvQ1QIlVuu9vwBjC0CSr
         uS/DVq9yEX5ige9mM4zJiAsI2pV6rhsGXGW122pSTiTxedgA/bSFEdARlIB351RVaeOY
         /pEA==
X-Gm-Message-State: APjAAAWgHx3RRG8wnG6Zi35fA9ZA5NEYO5SVmE13F/j7DhnHxRQMCBOi
        SWknD8QcVDYYhWICRFhLOTWIvRfAp1eORUBmm/qvbHY/Z+d7QPil32Pj3pqaa1cSvWdhPqk4DTY
        9NEJQPoJHJxJt5oG5Z2K3YcMAeOQBU4X3SeIZ
X-Received: by 2002:ac8:29a5:: with SMTP id 34mr4805484qts.56.1571932446570;
        Thu, 24 Oct 2019 08:54:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwAI1z9zAUExWF3+sgx/j9IB7U3ETV+dIINDgdeUTKX2tzo6cDj3OUk321lOKMWSA6TZLpYgA==
X-Received: by 2002:ac8:29a5:: with SMTP id 34mr4805446qts.56.1571932446273;
        Thu, 24 Oct 2019 08:54:06 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id x133sm12693274qka.44.2019.10.24.08.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:54:05 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/15] staging: exfat: Clean up return codes - FFS_NOTFOUND
Date:   Thu, 24 Oct 2019 11:53:13 -0400
Message-Id: <20191024155327.1095907-3-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert FFS_NOTFOUND to -ENOENT

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h       | 1 -
 drivers/staging/exfat/exfat_super.c | 6 +++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 4aca4ae44a98..1d82de4e1a5c 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -216,7 +216,6 @@ static inline u16 get_row_index(u16 i)
 #define FFS_SEMAPHOREERR        6
 #define FFS_INVALIDPATH         7
 #define FFS_INVALIDFID          8
-#define FFS_NOTFOUND            9
 #define FFS_FILEEXIST           10
 #define FFS_PERMISSIONERR       11
 #define FFS_NOTOPENED           12
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 273fe2310e76..50fc097ded69 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -572,7 +572,7 @@ static int ffsLookupFile(struct inode *inode, char *path, struct file_id_t *fid)
 	dentry = p_fs->fs_func->find_dir_entry(sb, &dir, &uni_name, num_entries,
 					       &dos_name, TYPE_ALL);
 	if (dentry < -1) {
-		ret = FFS_NOTFOUND;
+		ret = -ENOENT;
 		goto out;
 	}
 
@@ -2695,7 +2695,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 			err = -EINVAL;
 		else if (err == FFS_FILEEXIST)
 			err = -ENOTEMPTY;
-		else if (err == FFS_NOTFOUND)
+		else if (err == -ENOENT)
 			err = -ENOENT;
 		else if (err == FFS_DIRBUSY)
 			err = -EBUSY;
@@ -2752,7 +2752,7 @@ static int exfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 			err = -EINVAL;
 		else if (err == FFS_FILEEXIST)
 			err = -EEXIST;
-		else if (err == FFS_NOTFOUND)
+		else if (err == -ENOENT)
 			err = -ENOENT;
 		else if (err == -ENOSPC)
 			err = -ENOSPC;
-- 
2.23.0

