Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06180773B10
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 17:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjHHPkv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 11:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjHHPkg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:40:36 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FE5115;
        Tue,  8 Aug 2023 08:36:28 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686fc0d3c92so3931946b3a.0;
        Tue, 08 Aug 2023 08:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691508988; x=1692113788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohd14K5oR+JrF5FR78MmbbdwJ7n6halDzi8bumggJ7I=;
        b=Aj+/NLyI0M4bjOuiF+GrOUzh8mKxQX5IIwSr5wVfEEI0l7sJrjMwKUw1ymTphYw+nt
         RLXAmib2imTvrC+zW2kk5dI6POkLpD+E5XQVOpOfOKe1UXI2e5vNsKzZ607DKIi+BH3O
         5SFDkYMApqDoRfLC+O1xkB8DyagE7k0fq7eprQwBWQoPGKUXgj/xG01T+JarE3IeG5l3
         iu6V8cMRtQjna2+01pJOTIhQlF0veYkIn9b6bNj1+kGNFGWRvYHJ0MJXftSE8w1Jnxl9
         rUl4V6yWTwMk1SJ7fAi0qFO7yixjD2k+zw340olwzaNQH5WiemwHBezrrGQNtXQHyfAq
         yEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691508988; x=1692113788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohd14K5oR+JrF5FR78MmbbdwJ7n6halDzi8bumggJ7I=;
        b=MJQhv7XUemZLxE/PPk59gIKmpne53+1pHYH97xMy6FgspdwAGjV8bDhVhWLuEOo6w1
         ai1KDWBGBfzTAh/CHkUjwpYlmYFp65nSX7q30Tnu5Z+8CGzFJhtBmtB+AH8K3HAw0VEL
         0dyiT7iXDdna8qnYHlEB5mD89DvPW1R/UGmwC9eb3nIx3Mpf4gZAESC2cf/LF8FIOfhq
         oaElzhGfOtGucjxMCZGFEog1AITjw/eVqK3SueWkDVUVSZAxYqP0H38jIUt2hUn/sneB
         2GBSfsHODX9yNahevD82el2uyeFNeU3cweGnFI8+pZml89K1HJF44dE1+fJCoS8Idg+A
         HgqQ==
X-Gm-Message-State: AOJu0Yy2EVTmLof7aBb2rvI14fpfgA15fbeMDlJMcDaiakFXcUtbGYMG
        ZBGjJjcyeD0eCc5+wLg0BB9QHFZpJCqjZ/95
X-Google-Smtp-Source: AGHT+IEJkrwzqWUu/RKDr5oW4yXy5UhYxO5LIGeFvcigdoleJ/sRDxBJJ8Urbuxi3n0lOTYGwxRNDw==
X-Received: by 2002:a05:6830:1e0d:b0:6bc:9078:81c8 with SMTP id s13-20020a0568301e0d00b006bc907881c8mr11518461otr.20.1691490610989;
        Tue, 08 Aug 2023 03:30:10 -0700 (PDT)
Received: from manas-VirtualBox.iitr.ac.in ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id l12-20020a17090aec0c00b002677739860fsm7483268pjy.34.2023.08.08.03.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 03:30:10 -0700 (PDT)
From:   Manas Ghandat <ghandatmanas@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Manas Ghandat <ghandatmanas@gmail.com>,
        Linux-kernel-mentees@lists.linuxfoundation.org, anton@tuxera.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com
Subject: [PATCH v2] ntfs : fix shift-out-of-bounds in ntfs_iget
Date:   Tue,  8 Aug 2023 15:59:58 +0530
Message-Id: <20230808102958.8161-1-ghandatmanas@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <2023080821-blandness-survival-44af@gregkh>
References: <2023080821-blandness-survival-44af@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Added a check to the compression_unit so that out of bound doesn't occur.

Fix patching issues in version 2.

Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
Reported-by: syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4768a8f039aa677897d0
---
 fs/ntfs/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 6c3f38d66579..a657322874ed 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -1077,6 +1077,15 @@ static int ntfs_read_locked_inode(struct inode *vi)
 					goto unm_err_out;
 				}
 				if (a->data.non_resident.compression_unit) {
+					if (a->data.non_resident.compression_unit +
+						vol->cluster_size_bits > 32) {
+						ntfs_error(vi->i_sb,
+							"Found non-standard compression unit (%u).   Cannot handle this.",
+							a->data.non_resident.compression_unit
+						);
+						err = -EOPNOTSUPP;
+						goto unm_err_out;
+					}
 					ni->itype.compressed.block_size = 1U <<
 							(a->data.non_resident.
 							compression_unit +
-- 
2.37.2

