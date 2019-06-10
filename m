Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5EE63BB24
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 19:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387750AbfFJRkQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 13:40:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55402 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfFJRkQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:40:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so179348wmj.5;
        Mon, 10 Jun 2019 10:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sRxFa1Jf076GSTOYcljbXAZ97bbjXQCf03nwhBl2QN4=;
        b=XVzAha6eYDYQHoal5tpO1DzLP2UZcotLcWiAf1wsWBNC3ofsDm7DcZWkRdLvqwBBMs
         /k+C3jzSPOHX1/VKTUZbzOM3mUQB3FVOVcaScrACbQdS5HrhDhFV5JBA+r05HH2Cp2sA
         YCJbottNcfvr/9rxUEXutVLNePYPL1TkHgUgGRdA3vrALQkSF/mgmB/MwBOtcMiR9ivy
         QkCxGyCyT4HXV0fe6/BDztCm82tRN2wx7K8KW4xYfOJz0JlB0R+CViqaImVFWxl3ziix
         0wo9XhxlD1z3LlIcZI7KXdfvoxiNqhQw2dozVXgXOjW1hObrjpFVh72TKnNAmYKH5dLr
         HlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sRxFa1Jf076GSTOYcljbXAZ97bbjXQCf03nwhBl2QN4=;
        b=Sc9yhIldBP9TkUuWwYFeneLoChbcF6twTeXCnCh3KxWJ+LWvImVxcmSlGYtSio6n2U
         eDJ/qlNFOLTayodRtcZClzwFGwmVcWZZn7kTDT98FUiWNG6z9Py/miTSh6TFTBnYZwyE
         bRMvskywbF42OIOS5PoQ5JfvuN9XFNDeHOpCn5xq1ow15x6KfnImxj0w1okwoWOiaWKv
         ThNlgQWeH/AexlFVv6shEYTHDcqo5dTJLIx62j+anSYsB1qzacpz8Z7P5ciGXRGDxE/F
         8padWIlzihCTzxNsLrLV5qMYvt7wV2q3X9+z9OHzpA9c2TJjZe+LkZYkv+CuUw3kt+O2
         wt8Q==
X-Gm-Message-State: APjAAAW46pTgkEdzBDWRgfI2ei05W5Tb7Dbt6rmRHUC2Q0VGcA0gqXnz
        S1Z8Hl6+AT6fiOn6GOFXPlA=
X-Google-Smtp-Source: APXvYqyoiEWH7B7F352DUKuVisMiLNOigQe3ypbo2xQ7RfdeUcyXu5rDKCpbj7mBY95ySuDUj+P1KQ==
X-Received: by 2002:a7b:c344:: with SMTP id l4mr14053376wmj.25.1560188413799;
        Mon, 10 Jun 2019 10:40:13 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id g17sm11659366wrm.7.2019.06.10.10.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 10:40:13 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: [PATCH] ceph: copy_file_range needs to strip setuid bits and update timestamps
Date:   Mon, 10 Jun 2019 20:40:07 +0300
Message-Id: <20190610174007.4818-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
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

Hi Ilya,

Please consider applying this patch to ceph branch after merging
Darrick's copy-file-range-fixes branch from:
        git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

The series (including this patch) was tested on ceph by
Luis Henriques using new copy_range xfstests.

AFAIK, only fallback from ceph to generic_copy_file_range()
implementation was tested and not the actual ceph clustered
copy_file_range.

Thanks,
Amir.

 fs/ceph/file.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index c5517ffeb11c..b04c97c7d393 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1949,6 +1949,15 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
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
@@ -2099,6 +2108,14 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 out:
 	ceph_free_cap_flush(prealloc_cf);
 
+	file_accessed(src_file);
+	/* To be on the safe side, try to remove privs also after copy */
+	inode_lock(dst_inode);
+	err = file_modified(dst_file);
+	inode_unlock(dst_inode);
+	if (err < 0)
+		dout("failed to modify dst file after copy (%d)\n", err);
+
 	return ret;
 }
 
-- 
2.17.1

