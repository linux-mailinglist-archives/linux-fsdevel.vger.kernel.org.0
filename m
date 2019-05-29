Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF3662E39D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 19:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfE2Rnv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 13:43:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51785 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbfE2Rnu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 13:43:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id f10so2260117wmb.1;
        Wed, 29 May 2019 10:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LuX5OE/4xeK/rXyfFoIQSO2O4Y7R4fvZmK/kzW/AyOc=;
        b=QHweU0W6vis1g3FWDAwkvTc+uYcEbVGnabnUr7ydLPiaQ3VrO88OCdIzY5BuI3zQoG
         LlTWKvE2bVVaHzwMESE8R+eWV49mdBnzRpu3tpoknpTd2dNdkmUPS5XIgA5DzCU1Jr0F
         z53LCTl/JAES+/k0/yaedPqY29A3bBCwhnnhYM8MyWD4c9T0x34U3HEIr4F0olVyCOTv
         v77+R6+7M3jiLcAW0VAXG0qjm9J3aL63EY7HqcxAbHCk2WTIKfFC0lZ4vG1RkfzwKBCf
         kDG90wvjrRHn6eUW72BWo6Rd7gCydWt6cPZiQwyLRa6I+X/BHVUsBljW3xIctCi34JQn
         CAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LuX5OE/4xeK/rXyfFoIQSO2O4Y7R4fvZmK/kzW/AyOc=;
        b=Acg6sMW8W6Dews3VO6/A+AyqB38Cd3m7Aq9mgkPyjGsmmpMwva5MSX4LH7+8HT0sn9
         kUEF09TADT2M9PQxvGREqMG2YS47tAYLR88Ak1jwnm1CuWH+voSEF2yABOR9l5yC8roL
         o1Hd+yVh7RKx6c4wXG//CycjccgmlsRb2Zj6rHApbmIpqyEmgCmr/LkqR1lcvnrCbRFN
         K2mRFBD4X+I4nCBF37mgOE+/9Tw8VL0P6YvqLc6y6BfIc30xx1om31K7/xrkNKPUx+w4
         9RiCvcbkrbNQRtYQshJWimskIDYZXpCLvF7yU6k8N04APkewCRfGXD3RbjDTWabZD7bK
         xMtA==
X-Gm-Message-State: APjAAAWncXOTdnFpR8r6Ql7VJL9Rfb4R3FOmcvHqmMJq3qfLYZw4Z5zU
        zSZ96ZIgRvQ1v2IGEnOBrzI=
X-Google-Smtp-Source: APXvYqxMVTsGcUrsWM2pHjICaDWZ1YGun6kQavpkUgEVYAdBg5XpQfH588VNTDt/ZqGP9JxDTC8tTA==
X-Received: by 2002:a1c:9904:: with SMTP id b4mr7585387wme.1.1559151827378;
        Wed, 29 May 2019 10:43:47 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id k125sm31702wmb.34.2019.05.29.10.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 10:43:46 -0700 (PDT)
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
Subject: [PATCH v3 10/13] cifs: copy_file_range needs to strip setuid bits and update timestamps
Date:   Wed, 29 May 2019 20:43:14 +0300
Message-Id: <20190529174318.22424-11-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529174318.22424-1-amir73il@gmail.com>
References: <20190529174318.22424-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

cifs has both source and destination inodes locked throughout the copy.
Like ->write_iter(), we update mtime and strip setuid bits of destination
file before copy and like ->read_iter(), we update atime of source file
after copy.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/cifs/cifsfs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index c65823270313..ab6c5c24146d 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1096,6 +1096,10 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 		goto out;
 	}
 
+	rc = -EOPNOTSUPP;
+	if (!target_tcon->ses->server->ops->copychunk_range)
+		goto out;
+
 	/*
 	 * Note: cifs case is easier than btrfs since server responsible for
 	 * checks for proper open modes and file type and if it wants
@@ -1107,11 +1111,12 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 	/* should we flush first and last page first */
 	truncate_inode_pages(&target_inode->i_data, 0);
 
-	if (target_tcon->ses->server->ops->copychunk_range)
+	rc = file_modified(dst_file);
+	if (!rc)
 		rc = target_tcon->ses->server->ops->copychunk_range(xid,
 			smb_file_src, smb_file_target, off, len, destoff);
-	else
-		rc = -EOPNOTSUPP;
+
+	file_accessed(src_file);
 
 	/* force revalidate of size and timestamps of target file now
 	 * that target is updated on the server
-- 
2.17.1

