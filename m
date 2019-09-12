Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 414C1B0D7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 13:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbfILLDv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 07:03:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33028 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730268AbfILLDv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 07:03:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so15792285pfl.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2019 04:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gWhEv95xTEIL42qPF3+CSeyG/Xs7G/CybwgHcd2mrXY=;
        b=Vsnv9GpP/UwFIuF1xKQ1ymfWv4uzJy++3sv+5fdk76QqcRzf9lyyN6naP60MS7Bsuo
         qANymsS6MIzGRxEsVIzIZYhj9h1hwplWnVrxDyN5m5Zwd+0ksXYwlydloFFbK2Mkm3SZ
         xwTtkUApbqn/nkubInIphQb1goysnPXrkeWScszARjIf4vUHVIJfMPCfbRnEhvCFP6UM
         QidOAQJgxDipAwRqwINCbG8y4d34iQ+8wD5hVQaz+IQxpxf6Hx/Oqwg5lWUch1vPX8Fs
         XuSQ1FZIalNZcE+XjZioGEH+X9ZdHIe6WY/3C3sNk49A2uraGYFOtAm2b7H6Wdlv2ieL
         hvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gWhEv95xTEIL42qPF3+CSeyG/Xs7G/CybwgHcd2mrXY=;
        b=QhzeGBHqRXNXYgllxwPLvkgCO0GcUaAuqbJ2XkZmP8wIIR2wkfjXt1XIKytCYbVVcC
         Mlaug1E/0P7m2uSEPuoT5Pqof42n2zzF4byc/Nad+iy206LSUOlDqJeCGnsKJK4mTakI
         PC/zlU3GGVZ0JMeT0s1nB0sYZEP9XIy5WBu070LkB+bJZPnNlbh3RbdyW/FrZRMPHOaH
         /GfOfqmx5AMPUAAbEKwPbtDsLQFQ4dGzGPKW/aR/G5STF06OSqO4r2yy+H4+9J/LRb6r
         +Lb2Z59CIh6s5tXUFukYnP1V/sfOoFEKiGG1yUCGP/H6fla5/clHGvCBq3T0/ItINskp
         1uOw==
X-Gm-Message-State: APjAAAUSVq1kmXrhhCiNgrkLB/Oh+PWydi8GcMKlrD6TzDBqoz8cCTKN
        7w9vFl0bqIZnGUnyOekVaIID
X-Google-Smtp-Source: APXvYqykU0mNgWLqAuP8phxMNxNkCBH3W2aeVGPttM6WmZ4Nl3WnKNHLPADJRMDRTPoNGP8s5YETyw==
X-Received: by 2002:a63:d64f:: with SMTP id d15mr38390739pgj.345.1568286230822;
        Thu, 12 Sep 2019 04:03:50 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id c125sm31171591pfa.107.2019.09.12.04.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 04:03:50 -0700 (PDT)
Date:   Thu, 12 Sep 2019 21:03:44 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
Subject: [PATCH v3 1/6] ext4: introduce direct IO read path using iomap
 infrastructure
Message-ID: <532d8deae8e522a27539470457eec6b1a5683127.1568282664.git.mbobrowski@mbobrowski.org>
References: <cover.1568282664.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568282664.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces a new direct IO read path that makes use of the
iomap infrastructure.

The new function ext4_dio_read_iter() is responsible for calling into
the iomap infrastructure via iomap_dio_rw(). If the inode in question
does not pass preliminary checks in ext4_dio_checks(), then we simply
fallback to buffered IO and take that path to fulfil the request. It's
imperative that we drop the IOCB_DIRECT flag from iocb->ki_flags in
order to prevent generic_file_read_iter() from trying to take the
direct IO code path again.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/file.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 70b0438dbc94..e52e3928dc25 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -34,6 +34,53 @@
 #include "xattr.h"
 #include "acl.h"
 
+static bool ext4_dio_checks(struct inode *inode)
+{
+#if IS_ENABLED(CONFIG_FS_ENCRYPTION)
+	if (IS_ENCRYPTED(inode))
+		return false;
+#endif
+	if (ext4_should_journal_data(inode))
+		return false;
+	if (ext4_has_inline_data(inode))
+		return false;
+	return true;
+}
+
+static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	ssize_t ret;
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	/*
+	 * Get exclusion from truncate and other inode operations.
+	 */
+	if (!inode_trylock_shared(inode)) {
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			return -EAGAIN;
+		inode_lock_shared(inode);
+	}
+
+	if (!ext4_dio_checks(inode)) {
+		inode_unlock_shared(inode);
+		/*
+		 * Fallback to buffered IO if the operation being
+		 * performed on the inode is not supported by direct
+		 * IO. The IOCB_DIRECT flag flags needs to be cleared
+		 * here to ensure that the direct IO code path within
+		 * generic_file_read_iter() is not taken again.
+		 */
+		iocb->ki_flags &= ~IOCB_DIRECT;
+		return generic_file_read_iter(iocb, to);
+	}
+
+	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL);
+	inode_unlock_shared(inode);
+
+	file_accessed(iocb->ki_filp);
+	return ret;
+}
+
 #ifdef CONFIG_FS_DAX
 static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
@@ -64,16 +111,19 @@ static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 static ssize_t ext4_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(file_inode(iocb->ki_filp)->i_sb))))
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
 		return -EIO;
 
 	if (!iov_iter_count(to))
 		return 0; /* skip atime */
 
-#ifdef CONFIG_FS_DAX
-	if (IS_DAX(file_inode(iocb->ki_filp)))
+	if (IS_DAX(inode))
 		return ext4_dax_read_iter(iocb, to);
-#endif
+
+	if (iocb->ki_flags & IOCB_DIRECT)
+		return ext4_dio_read_iter(iocb, to);
 	return generic_file_read_iter(iocb, to);
 }
 
-- 
2.20.1

