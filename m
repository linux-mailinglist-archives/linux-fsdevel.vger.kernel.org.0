Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 922032E39A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 19:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfE2Rnt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 13:43:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36412 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbfE2Rns (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 13:43:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id v22so2188603wml.1;
        Wed, 29 May 2019 10:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rlDX58TIMkSnxlZYvBJZ2TZQKYpka5ehiNgustkWnZY=;
        b=PebP4+cLhsmj4O+1azOWcIfAVONfFzTh1sA9YSTYEBAqybToCfE37RpBbr7J9ptozi
         RmOGNtC0UuYTmEP3nYBBuEw10G2PIKqbSZRnlYGH3pdBC1WbUqM9effRhKKC7ZCZWxR+
         mn9v/TgTQtecIOFKq2sRrcpKuoU5myZ0nXvAQ1jyxpkh+PMs5uvaMTLWgp8sAUHUAo3G
         l/vLcINnzwiZcdCt1d9y2Ylo03GCaKy0nFJ8d/moT6PxaRTh/ZNXEd6+9NQhxWgzPVTo
         Cn34hQiE6iWkVGyGyscRfsy7yvxqigDx8JMxip1JXYtHhjMx6rgv0h5iDL+sgsCUQpgy
         JeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rlDX58TIMkSnxlZYvBJZ2TZQKYpka5ehiNgustkWnZY=;
        b=BZ4v7xrF/WV99P6LtNx/1Lu6DZfHxxREy8hQu+LmP8Avp/QF9iVSjtFeMJZ6qiXrtt
         EdaMeKEtFyIw+SOFDwFQnyyQe8Yv6LEjNH2ZVubwCK7WNJUM6ITxv20E8p8JzqFHhCuR
         uY+zddWK0UJ0Hh6bJ2Irqd0MGozS14VKG/3t5AIJa35/v3SMiY+1fY8X2qvD7Frtf1ob
         DsA9DHdcz2+IOdj8HXIoJsesNftf9rooG1pu7c7t7XLak+U322yzBL5AZnzEqMTYETTu
         mdUgyi2oIIuSoZJwuSR1omoTol9wXEjxapSh9KG7c/Z5IIH+5by+EPjmjtvmssff/T+T
         VlqA==
X-Gm-Message-State: APjAAAWcNWRrsCp/VUj4Zh8Oc418dIpRv2PqttcRuNSlWa5FBWtHChYt
        /ZQC1MxAu3YuDflZ91N8vjzgoFIaP5g=
X-Google-Smtp-Source: APXvYqyZnP/ym9Cj9u95IdXYn2JeWpOXl96aMvy78ul3u/IC+OGJ1gY7fQFBpkU10Ayxtspk+rk0RA==
X-Received: by 2002:a1c:eb0c:: with SMTP id j12mr7503798wmh.55.1559151825614;
        Wed, 29 May 2019 10:43:45 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id k125sm31702wmb.34.2019.05.29.10.43.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 10:43:45 -0700 (PDT)
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
Subject: [PATCH v3 09/13] ceph: copy_file_range needs to strip setuid bits and update timestamps
Date:   Wed, 29 May 2019 20:43:13 +0300
Message-Id: <20190529174318.22424-10-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529174318.22424-1-amir73il@gmail.com>
References: <20190529174318.22424-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Because ceph doesn't hold destination inode lock throughout the copy,
strip setuid bits before and after copy.

The destination inode mtime is updated before and after the copy and the
source inode atime is updated after the copy, similar to the filesystem
->read_iter() implementation.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/ceph/file.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index e87f7b2023af..8a70708e1aca 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1947,6 +1947,15 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 		goto out;
 	}
 
+	/* Should dst_inode lock be held throughout the copy operation? */
+	inode_lock(dst_inode);
+	ret = file_modified(dst_file);
+	inode_unlock(dst_inode);
+	if (ret < 0) {
+		dout("failed to modify dst file before copy (%zd)\n", ret);
+		goto out;
+	}
+
 	/*
 	 * We need FILE_WR caps for dst_ci and FILE_RD for src_ci as other
 	 * clients may have dirty data in their caches.  And OSDs know nothing
@@ -2097,6 +2106,14 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 out:
 	ceph_free_cap_flush(prealloc_cf);
 
+	file_accessed(src_file);
+	/* To be on the safe side, remove privs also after copy */
+	inode_lock(dst_inode);
+	err = file_modified(dst_file);
+	inode_unlock(dst_inode);
+	if (err < 0)
+		dout("failed to modify dst file after copy (%zd)\n", err);
+
 	return ret;
 }
 
-- 
2.17.1

