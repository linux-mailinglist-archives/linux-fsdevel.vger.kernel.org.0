Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A18E12E391
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 19:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfE2Rnq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 13:43:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50753 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbfE2Rnp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 13:43:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id f204so2264471wme.0;
        Wed, 29 May 2019 10:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yYTFJKL40LM++VpLTZTzwXvwxxD1UrCsqPZT6tG+/XE=;
        b=cSqvCgWy1YUQe0dHZNRcbGIm/QEpVxUs6IT3YXaSyTh4x9WjSNR5boI0WRhPgPAwTC
         YiOR+sZiQ2g335Wkr7SvCOrlFeo8ICtA+/A4NNSnHdOKdDSWWnXG8PDIkjWDzo450BPH
         iEcy/YGbb+k+IYl//FLQyIIaCWywEu9FP5bLBCJpDzO704xeoNqoCwoLqoNWeelRTvMx
         aTlXk/0tm4w7OrQ6tcZpAMrsdO/ONgCDJCNZQWiR5retFl7gsuPPehmDMoOE8i9Zrgzo
         aP+pBNX7yLNjvozjcUMh3FQX+L0lNchxh8e3MP9zvR6pSYznLHLW6k/NYIqE3gNMgS/B
         5bcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yYTFJKL40LM++VpLTZTzwXvwxxD1UrCsqPZT6tG+/XE=;
        b=krNgBSOQcjUiqjrVtHXNlvYluzCxCYSaxmalJHYugjo4lQKbRbt4SF75NI9E7hXJSr
         WA4rxP/7FnEPNjlwI1hPgXJC5jQCQ4/ywIjxXWV2mQ4GuRUK241eJ3usOL2vFJcYcByy
         9uTwU2Xi8SjoJFqgtNG38MQLsw/Za5DGSRQEB+IYToul3vyIfSKjQQ7zZyRh5BfGRFYj
         3Cg928n+pINQtLeJUHmnUUlZevZJ1Q/57rOWEWNuB2SVcofEQ75sywioYINgiwLaT8Un
         6JZ2lysN+GHU3jjoShZU73CBKwgkdSU5pb/Gar+Vh9/4Bi6cXKl7aIe0PN+tF3I9fH/u
         dywQ==
X-Gm-Message-State: APjAAAU7JJpdz3MdGX3JdYKKvWwCWT/OAyL2TOyS7uuJnUbHh0E3TTEl
        57OMurvcgWLNf9jBFuE0vXM=
X-Google-Smtp-Source: APXvYqwquQoM7yAP2+/AyNykqKSjW4fG5r+voHHnsO1jrH6Riwda2nc9fTFThBKC6BcsinK57kEFVg==
X-Received: by 2002:a1c:f60d:: with SMTP id w13mr7438206wmc.40.1559151823589;
        Wed, 29 May 2019 10:43:43 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id k125sm31702wmb.34.2019.05.29.10.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 10:43:42 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        linux-xfs@vger.kernel.org,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH v3 08/13] vfs: copy_file_range needs to strip setuid bits and update timestamps
Date:   Wed, 29 May 2019 20:43:12 +0300
Message-Id: <20190529174318.22424-9-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529174318.22424-1-amir73il@gmail.com>
References: <20190529174318.22424-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Because generic_copy_file_range doesn't hold the destination inode lock
throughout the copy, strip setuid bits before and after copy.

The destination inode mtime is updated before and after the copy and the
source inode atime is updated after the copy, similar to
generic_file_read_iter().

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/read_write.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index cec7e7b1f693..706ea5f276a7 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1590,8 +1590,27 @@ ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
 				struct file *file_out, loff_t pos_out,
 				size_t len, unsigned int flags)
 {
-	return do_splice_direct(file_in, &pos_in, file_out, &pos_out,
-				len > MAX_RW_COUNT ? MAX_RW_COUNT : len, 0);
+	struct inode *inode_out = file_inode(file_out);
+	int ret, err;
+
+	/* Should inode_out lock be held throughout the copy operation? */
+	inode_lock(inode_out);
+	err = file_modified(file_out);
+	inode_unlock(inode_out);
+	if (err)
+		return err;
+
+	ret = do_splice_direct(file_in, &pos_in, file_out, &pos_out,
+			       len > MAX_RW_COUNT ? MAX_RW_COUNT : len, 0);
+
+	file_accessed(file_in);
+
+	/* To be on the safe side, remove privs also after copy */
+	inode_lock(inode_out);
+	err = file_modified(file_out);
+	inode_unlock(inode_out);
+
+	return err ?: ret;
 }
 EXPORT_SYMBOL(generic_copy_file_range);
 
-- 
2.17.1

