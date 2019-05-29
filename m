Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 567D82E3AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 19:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfE2Rn7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 13:43:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42154 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbfE2Rnv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 13:43:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id l2so2379570wrb.9;
        Wed, 29 May 2019 10:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iB8gfO01UWVOvIbXC1SgRvasH8gb3p1b2pcn/FSICGQ=;
        b=b0k7Uhky+yocLh7DQ5oosoZKI7/cqVQKaU4lK18qqSzkTiwbokIBbcPe+8QkWpRXa8
         /SdwMHVqdJZQqTm1Fq1HdJTbttYNaiTx80cqXKZKTcxiAlH7x47tQiZtgM09gOqMUU4c
         dOG8N4gYpx+jTYmeNj39drvhVoHEmrwIeEvk/HncoD+JQ42uuDcCp/FazXiOnmjbmA0y
         Qyws70g4mdHlzhfgWhGdgY/dMtF8JmkPZiaOrD7l5uW8qrY61bJjm1qranskdKzNJQKa
         7EVtbBYF9DG+lINa//bbPNSWhu3w6ZQMnKrFNN3ZOzT9LC9pbEW5SVAV44T0KHYzwOYb
         DcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iB8gfO01UWVOvIbXC1SgRvasH8gb3p1b2pcn/FSICGQ=;
        b=kpnlOT/7+5r0Ewo6ThMmk0KjjbrF64+XosP/4yYxy3MBcwI84b3ojsus4EwSTuEwpP
         u1bnVn7Dl4nqJ7sdB+l304rHwjschwt050RVBblQ//7f7gOts9YezS/VleehbElM8eXL
         xASgZr/grByxK8LcSJrec+Mcked0v0S+7OB1g4GAPT/BtJRS4t/U/t+cjAbcy8JG/JJE
         sCqQN5H4uOP5w3BMfWIpSkywjYdmyC7uPUTTjUJLxrh3oWuYVzGvnKcaznLhUc7mkTKp
         azaA0EdL9HTONDlFnGPiFnuBYUb3/jBPJDDqGWTa7amD7ozMBR/ENlNJzhwZ2bTD+w/l
         yohQ==
X-Gm-Message-State: APjAAAXy8y1Bpvj7ngqIYQ6Y7ynqh8C1p58NCZRHh8QZR8B8ewbe1eFE
        PSKrGi0A09pA+DWVIglHdoc=
X-Google-Smtp-Source: APXvYqwJOJ4izTFnolZmkhfQaBuL6JfpKe4IKnghtgloYRwVTP4nUzDRTpo9aL+/5u/O6Q118FCXnA==
X-Received: by 2002:adf:db4c:: with SMTP id f12mr4020367wrj.243.1559151829055;
        Wed, 29 May 2019 10:43:49 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id k125sm31702wmb.34.2019.05.29.10.43.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 10:43:48 -0700 (PDT)
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
Subject: [PATCH v3 11/13] fuse: copy_file_range needs to strip setuid bits and update timestamps
Date:   Wed, 29 May 2019 20:43:15 +0300
Message-Id: <20190529174318.22424-12-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529174318.22424-1-amir73il@gmail.com>
References: <20190529174318.22424-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Like ->write_iter(), we update mtime and strip setuid of dst file before
copy and like ->read_iter(), we update atime of src file after copy.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e03901ae729b..7f33d68f66d9 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3128,6 +3128,10 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 
 	inode_lock(inode_out);
 
+	err = file_modified(file_out);
+	if (err)
+		goto out;
+
 	if (fc->writeback_cache) {
 		err = filemap_write_and_wait_range(inode_out->i_mapping,
 						   pos_out, pos_out + len);
@@ -3169,6 +3173,7 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 		clear_bit(FUSE_I_SIZE_UNSTABLE, &fi_out->state);
 
 	inode_unlock(inode_out);
+	file_accessed(file_in);
 
 	return err;
 }
-- 
2.17.1

