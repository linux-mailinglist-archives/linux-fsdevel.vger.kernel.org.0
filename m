Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C75D6F59B8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 16:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjECOUw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 10:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjECOUr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 10:20:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C15761A7;
        Wed,  3 May 2023 07:20:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B004862DE4;
        Wed,  3 May 2023 14:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FBCC433D2;
        Wed,  3 May 2023 14:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683123645;
        bh=+ZM+liB0nOC40xQZQZ86xt6fi25JWXDh676GI1IVOtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OzK0qj3iyjj33ep8v0XmPObTk1v223SVrzA0av9ES+PbH+yxPsHca4yVlAiP/nZ5J
         s7ypPpbr+N586IurGZDou4HezY4YGv2LQiX7qFp8MH28smBMh/Nv1lmLgRtTubzXQc
         c6vf2NMtFc+hB39X4k4fFPtchaoyoUec4XW7/1MwS03OIfxS+48lpd0q4gb3cMmD85
         aldOFPYV57sA32GQ5RXkMdpoS66lInKvESkrVa1DzNeaVO1NpsV/fx+F8jE+uie0bm
         ElHEAdXHpk1hsrNVH/AHKt1QiMneeeXKLv9BU1SbklBImpppDJD4RmdfrTExd5ub23
         LS/h5b5LKx40g==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Neil Brown <neilb@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Theodore T'so <tytso@mit.edu>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: [PATCH v3 2/6] overlayfs: allow it handle multigrain timestamps
Date:   Wed,  3 May 2023 10:20:33 -0400
Message-Id: <20230503142037.153531-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230503142037.153531-1-jlayton@kernel.org>
References: <20230503142037.153531-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ensure that we strip off the I_CTIME_QUERIED bit when copying up.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/overlayfs/file.c | 7 +++++--
 fs/overlayfs/util.c | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 7c04f033aadd..cad715df8c4e 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -222,6 +222,7 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 static void ovl_file_accessed(struct file *file)
 {
 	struct inode *inode, *upperinode;
+	struct timespec64 ctime, uctime;
 
 	if (file->f_flags & O_NOATIME)
 		return;
@@ -232,10 +233,12 @@ static void ovl_file_accessed(struct file *file)
 	if (!upperinode)
 		return;
 
+	ctime = ctime_peek(inode);
+	uctime = ctime_peek(upperinode);
 	if ((!timespec64_equal(&inode->i_mtime, &upperinode->i_mtime) ||
-	     !timespec64_equal(&inode->i_ctime, &upperinode->i_ctime))) {
+	     !timespec64_equal(&ctime, &uctime))) {
 		inode->i_mtime = upperinode->i_mtime;
-		inode->i_ctime = upperinode->i_ctime;
+		inode->i_ctime = uctime;
 	}
 
 	touch_atime(&file->f_path);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 923d66d131c1..f4f9d7e189ef 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1117,6 +1117,6 @@ void ovl_copyattr(struct inode *inode)
 	inode->i_mode = realinode->i_mode;
 	inode->i_atime = realinode->i_atime;
 	inode->i_mtime = realinode->i_mtime;
-	inode->i_ctime = realinode->i_ctime;
+	inode->i_ctime = ctime_peek(realinode);
 	i_size_write(inode, i_size_read(realinode));
 }
-- 
2.40.1

