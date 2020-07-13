Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A61E21E2B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 23:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgGMV62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 17:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgGMV61 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 17:58:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD3CC061794
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2020 14:58:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t7so19147675ybk.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2020 14:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Gs/Gv3Cy5wqDBUEc1MH9Cm/5K7mAub8SPlwC+wQyYqE=;
        b=YdJOjCV7fIReprKUDgUqFRgD7IdA0HPn3o836MbjtwW5cjTi5pUg25Y/X/oLHsHOiq
         /dLDHo22UeKa9ZgZodQ/TxC5er0jV/ttg2YVNgxC6l+QIqgeTnfN2HSdyWKfBxwvuPyH
         ikcV3icBhj8W+JJAu3MWOqZcDkjwEN1ppZ3Mx8V81ot5qNKRaPDiT+5r3f/jCTa0nFp3
         LZHboA8G6zKKHlbyiDIYDuQawcKreTDOA1yhBekhAWB1CpYbf1JYSfd3k2xhpMKJMuw4
         S+Dxpv0zG66M5AantRlwmPLrSGGSwSKIvOnRdPUmRYTPitDSrZ4tbqul9mIBO24Bp9KX
         wMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Gs/Gv3Cy5wqDBUEc1MH9Cm/5K7mAub8SPlwC+wQyYqE=;
        b=qrEMJCoAFQRWUaB97FWBSymsN9L/rC97s2neugm7FFDsbTZUc39flATONLyLJlLXFf
         Fmkrps8se/ZWSKivULtDMwNhilzBmkfzAhbC66hquEGUAE3DVfhxeGpZ+sxIkVbmHjyX
         AY+LKmZCp/+uSOTg5wVXN7IkeTRLIGMt8gCUtAQUK/fZvo99VnodA8l8/UuKWBs7eI4U
         uV4+f9qGH+9i4u92G5nEU8o4LiK1cQsHfAAsHrMSeKn3tdUeXI4hJbCjpxAs1H1UL3Bf
         8pIy+fynA4L8rKT1IeDx1z3w7JyIXlOv6UesHhSLWvLuGAHHgGFB6O0PMeKQ+dn+U58L
         7+ZA==
X-Gm-Message-State: AOAM53330VpHg634vJgGhk3nL1FjDh9xYJuw6zHWgmqwiWkkVAC0wCjt
        8MVsvrDDCXn0iVSSXC1ZuQnbM8tY29t1TbqjhQ==
X-Google-Smtp-Source: ABdhPJzoH1tIybvnt/uhpJ3VlQqwMSj3mOdOZMzcjfyYW8JRP/j82atHUsw1U6qKlkhK2AGbwHpshmfQ0hVXj+uHEA==
X-Received: by 2002:a25:6910:: with SMTP id e16mr3394641ybc.207.1594677506340;
 Mon, 13 Jul 2020 14:58:26 -0700 (PDT)
Date:   Mon, 13 Jul 2020 14:57:59 -0700
Message-Id: <20200713215759.3701482-1-victorhsieh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH] fs/9p: Fix TCREATE's fid in protocol
From:   Victor Hsieh <victorhsieh@google.com>
To:     v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Victor Hsieh <victorhsieh@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The fid parameter of TCREATE represents the directory that the file
should be created at. The current implementation mistakenly passes a
locally created fid for the file. The correct file fid is usually
retrieved by another WALK call, which does happen right after.

The problem happens when a new created fd is read from (i.e. where
private_data->fid is used), but not write to.

Fixes: 5643135a2846 ("fs/9p: This patch implements TLCREATE for 9p2000.L protocol.")
Signed-off-by: Victor Hsieh <victorhsieh@google.com>
Cc: stable@vger.kernel.org
---
 fs/9p/vfs_inode_dotl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 60328b21c5fb..90a7aaea918d 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -285,7 +285,7 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 			 err);
 		goto error;
 	}
-	err = p9_client_create_dotl(ofid, name, v9fs_open_to_dotl_flags(flags),
+	err = p9_client_create_dotl(dfid, name, v9fs_open_to_dotl_flags(flags),
 				    mode, gid, &qid);
 	if (err < 0) {
 		p9_debug(P9_DEBUG_VFS, "p9_client_open_dotl failed in creat %d\n",
-- 
2.27.0.383.g050319c2ae-goog

