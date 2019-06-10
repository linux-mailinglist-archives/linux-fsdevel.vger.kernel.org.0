Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB673BB1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 19:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388185AbfFJRhH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 13:37:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37653 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387643AbfFJRhH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:37:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id 22so186835wmg.2;
        Mon, 10 Jun 2019 10:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dNd7lU6c2A+wgDItBB4dmNeiVZ02cUuGhyiCfR1LShI=;
        b=ttV/zx7yCdtitpTexlR05UW0tllm5wK+SaHltq60Kn7B8jqrV0vYEuxx+9lAFqG4ls
         yMInlnWFxukmDOOoM15qXTKi1+IbGZw1dM1UqPb+Zth1huw2tfhogPn9EZDYkpH7ODp0
         Ot26yaTX4oXe/T84LwbMysNxMSFW/3Tdbd9Sii2CycL+Xf/DP+xJxprBr7gT9seszRZl
         Ksh+U6y5fk60zRMzhSFnS9luJ29jxEyGQMHIpab5q8zGpcixdKrFYJBwCOjprwNVfTUM
         XFbaFOAdoC5keqaJC79CraJwRTdxJEZRuLo3JA3kelfx4bTHXu4gYTnAhJRMSpYuwZ6C
         HxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dNd7lU6c2A+wgDItBB4dmNeiVZ02cUuGhyiCfR1LShI=;
        b=EXW4/FTIhbaY+cQoiKdZ80jC6Ec2GURZFd35Gs48tAbPTcrPVkvm0tV66qYnhn51Mb
         ww+fmg6VczmCu9Q+MFjgwneYkUkHEDeEGuCAydAv+JCyebgQScCbCjN1JEHhRb7aWi8P
         JIhI8byVFyWesjSvRnozsmh52qzCspolfGyvxMeTv2fVCFeb+uTXV7Z+uxcI5ijXYi7m
         1EG5CmiqY62LCDnmg5TWTyTFfaPWmeZelwIT/RZAtyvpsKho6hqmEzwCf2MIXTrX1FGK
         zj5tv5/MUk5eaFK/IpTOfHww1amVbIFyRjQCr7K9T/G4iiY7pTDJVhTJinEtFzO6mLFf
         JwVw==
X-Gm-Message-State: APjAAAVCxAt635j37mvEQ9rlm/lZ6AMEu3EAZGHQcx+Lc9PnpnLd0wET
        c4OvYCXUxBjk+nseCS0bAE8=
X-Google-Smtp-Source: APXvYqza+wDRDse2uMNkCwriD4ehxEez28vTez5KxlAwdXvosKd3Y4t7iUHYgRfe3sV2L/asN8nOOA==
X-Received: by 2002:a05:600c:254b:: with SMTP id e11mr13254526wma.171.1560188225543;
        Mon, 10 Jun 2019 10:37:05 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id b7sm9526927wrx.83.2019.06.10.10.37.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 10:37:04 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Steve French <smfrench@gmail.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org
Subject: [PATCH] cifs: copy_file_range needs to strip setuid bits and update timestamps
Date:   Mon, 10 Jun 2019 20:36:57 +0300
Message-Id: <20190610173657.4655-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
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

Hi Steve,

Please apply this patch to you cifs branch after merging Darrick's
copy-file-range-fixes branch from:
        git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

Thanks,
Amir.

 fs/cifs/cifsfs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index f11eea6125c1..83956452c108 100644
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

