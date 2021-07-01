Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F073B8C8A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jul 2021 05:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238734AbhGADLE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 23:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238682AbhGADLD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 23:11:03 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9E1C061756;
        Wed, 30 Jun 2021 20:08:33 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id c5so4632413pfv.8;
        Wed, 30 Jun 2021 20:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1cEkAa62CvZ4mqbyDK6dMhTfrSLLUVAknl5Ed3GLxXY=;
        b=RYJGK5U6C3aJ8oaLUZhKwUgDvk9IelyGC/2kx/3d7VY6LYQtL65EyuUK99POf9F/vl
         p1HkyjQ3une836usUBEmliDY8L2mUl8q14kPcD8m91PELFJoLOXtgfNu0he2YPpCch/M
         PWVd7gij6Oni9HBxCWOG1lQNu6AIO2lKGXJiYDvQxGKB7c0BiefqmJzRf79KYnqqdbml
         70DsLsKu69HTZm5CtZ1ayU3ZyDfB1UhuIwGnIZ0uxhwdOaz2H5E7uMPRiILrmF9ibTKu
         m83DyuqmPD7kgV/G7e7RQy7YDmtrHFZsFHyvB30Io+/tjUCaG7Mx1nVcbPsA+D7QNI3t
         IqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1cEkAa62CvZ4mqbyDK6dMhTfrSLLUVAknl5Ed3GLxXY=;
        b=p3Biz13mX4qcCbem+cVN3CdSMOoEE1UMsMLwc5U8YL1V9DjXJ2hDa6XvZM9j18qa/s
         LZsNDxtTlxlfxn9Pt/IOIA97DbsIISsMvLcVqL5XX022n5pjgmkvPQ+jD+opQ5aKVY/+
         LxaTJ9iTTl4mY4eLWLNidWvxKbKekZjWfhzCeRulBJ+GuXRFT0VpSj9KX/U4DnCS/Bcr
         LTiJPY9XnB7RCe2JnTy3GoorVHcMlEZr92fL17NLDj6l6H/v5aAhjasJXz5u/G4ZuZxC
         KOqMW0QPi21Qyqm5AmzEfRLCUCErWHlp8fgIthGTvFQ5QfUZmBjkG817+dvK6jiU6Kwt
         LFbw==
X-Gm-Message-State: AOAM531s+ABpBBep+nfsVPP772Kzo/jVEOSfUdIahe6aXjavzdHCtm4J
        NqqSI76Nbk+kkskou7NIRmtLUXz21a+UNcyhaa8=
X-Google-Smtp-Source: ABdhPJyI1llPLK7QHRLLgdJdjPQ/hHdaD3/x62XjJIqEH/0EKa8W24O0pcv54UoRHWBCR5LqCwylFw==
X-Received: by 2002:a05:6a00:1898:b029:310:9cd3:7bf8 with SMTP id x24-20020a056a001898b02903109cd37bf8mr3901910pfh.12.1625108913546;
        Wed, 30 Jun 2021 20:08:33 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id g10sm4568568pjv.46.2021.06.30.20.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 20:08:33 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     gustavoars@kernel.org, viro@zeniv.linux.org.uk
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        slava@dubeyko.com, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2 1/3] hfs: add missing clean-up in hfs_fill_super
Date:   Thu,  1 Jul 2021 11:07:54 +0800
Message-Id: <20210701030756.58760-2-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210701030756.58760-1-desmondcheongzx@gmail.com>
References: <20210701030756.58760-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Before exiting hfs_fill_super, the struct hfs_find_data used in
hfs_find_init should be passed to hfs_find_exit to be cleaned up, and
to release the lock held on the btree.

The call to hfs_find_exit is missing from an error path. We add it
back in by consolidating calls to hfs_find_exit for error paths.

Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
---
 fs/hfs/super.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 44d07c9e3a7f..12d9bae39363 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -420,14 +420,12 @@ static int hfs_fill_super(struct super_block *sb, void *data, int silent)
 	if (!res) {
 		if (fd.entrylength > sizeof(rec) || fd.entrylength < 0) {
 			res =  -EIO;
-			goto bail;
+			goto bail_hfs_find;
 		}
 		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset, fd.entrylength);
 	}
-	if (res) {
-		hfs_find_exit(&fd);
-		goto bail_no_root;
-	}
+	if (res)
+		goto bail_hfs_find;
 	res = -EINVAL;
 	root_inode = hfs_iget(sb, &fd.search_key->cat, &rec);
 	hfs_find_exit(&fd);
@@ -443,6 +441,8 @@ static int hfs_fill_super(struct super_block *sb, void *data, int silent)
 	/* everything's okay */
 	return 0;
 
+bail_hfs_find:
+	hfs_find_exit(&fd);
 bail_no_root:
 	pr_err("get root inode failed\n");
 bail:
-- 
2.25.1

