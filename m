Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 230E6312EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 18:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfEaQri (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 12:47:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34960 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfEaQr2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 12:47:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id c6so3429041wml.0;
        Fri, 31 May 2019 09:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HRG15X28X6wLonYTWAY6EmVHhxYS6KtDUNRAcBO9y7g=;
        b=cdHWOU+n5BJ1iIXZj596n6F7J0DaRYo/l9Q9ZkRKB58Hy9KKixfylYue3GMy8EUVeA
         lVW+aVOAWJkROkcM4kwa7yX4bIaXRZHxJY4qJxXJJY0f2i/N7s1bMruD2G3Te75el3Oz
         qdm7gLaE50S+GKI61kLrS5r3YZkOQkdRyYiyY9VFw2PYZx/YRMRyI0dNkEds7nCJYfhi
         3ZxdnMYYWrXhQixn2ndazZmOo82Q/+x2VC2vE6bw8U9WJRpHfG7Updc1i1VICHYKdNg0
         k8UNn5IdUuzpCOwfK0mRDvXEYN+O/TczVc2/DDhtZD6cupGIW6odrFuW9gYqQPcnJ8yi
         nuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HRG15X28X6wLonYTWAY6EmVHhxYS6KtDUNRAcBO9y7g=;
        b=ZELYVDvzGZVbblLhydMUpBnCWKU/OnyKVK6fPoEtzba+IMDjVxJPcZRgyj6ClsrrlN
         n6YU+cT13qd+HDkC4JLxUs41Ly/+IWfe3y8atAyhL96uKj1aeSkCcopwsFdIVw4A6Yzx
         LBOAOKFMBAV+UQu6CtdZK52R7M8C8812IpLE0Qu0/nOQKQjGHGBIDOAaWPrc/NbNmIE3
         rVN0sk5qxcRiHE7IyC/UrCeA/n8FFcHcRxdPyoJ43ssJTXVrFa85AvET4uqm1WGdW0Bc
         NNEpmU6rWN5YoMNi+dS+aYrKnD6lksSaah5i5wqI8/RDB3MX56nf249R2X6mamVEh90y
         oarA==
X-Gm-Message-State: APjAAAWszJLB2LDsRKZ17shzoJnExxNxMp+9MioG3NajZpQishiWMWBU
        F2s98IS75oEMoJ8FDOh4yjc=
X-Google-Smtp-Source: APXvYqwWgIYQ2clqTkQy9eygreKjNGojYUYCr7ZzWiQwEdeft9nzlvN4fuQ1DUcp3eNqfXaqES0nVA==
X-Received: by 2002:a1c:f712:: with SMTP id v18mr6653743wmh.143.1559321246752;
        Fri, 31 May 2019 09:47:26 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id n5sm7669593wrj.27.2019.05.31.09.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 09:47:26 -0700 (PDT)
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
Subject: [PATCH v4 9/9] fuse: copy_file_range needs to strip setuid bits and update timestamps
Date:   Fri, 31 May 2019 19:47:01 +0300
Message-Id: <20190531164701.15112-10-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531164701.15112-1-amir73il@gmail.com>
References: <20190531164701.15112-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Like ->write_iter(), we update mtime and strip setuid of dst file before
copy and like ->read_iter(), we update atime of src file after copy.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Acked-by: Miklos Szeredi <miklos@szeredi.hu>
---
 fs/fuse/file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 569baf286835..eab00cd089e8 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3131,6 +3131,10 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 
 	inode_lock(inode_out);
 
+	err = file_modified(file_out);
+	if (err)
+		goto out;
+
 	if (fc->writeback_cache) {
 		err = filemap_write_and_wait_range(inode_out->i_mapping,
 						   pos_out, pos_out + len);
@@ -3172,6 +3176,7 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 		clear_bit(FUSE_I_SIZE_UNSTABLE, &fi_out->state);
 
 	inode_unlock(inode_out);
+	file_accessed(file_in);
 
 	return err;
 }
-- 
2.17.1

