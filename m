Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 089A12A8A8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2019 08:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfEZGLX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 May 2019 02:11:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42593 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfEZGLW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 May 2019 02:11:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id l2so13657630wrb.9;
        Sat, 25 May 2019 23:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zqG9JMtX+vHNyprOzkAJ1KkCxnAmtf74H0q9YGZXDsU=;
        b=AFjDAiKMr1H2ehfKhZmqJsbwBIjdZzOOdzaRVpj/ndzbe9LmjxjQC+so8If5qVNq1v
         zC6ehnYK5A24p4T7NVImlQvGmSdeCmv4sAMUvvq1zrWJZ54O5fST3vkj2HwrtUykQJdp
         Riv0p0XmFgeP7JD872uTSSj5rg1x0fZ1xt2x7AyxK2fQfUXQJp1sHkDixbbWrLli4rpO
         /CGm05znGrQpEj8a7PXNian05T8qi4Y3q8vQNcYRTsjaRP42cl6zZyjogXHFMm/vsjF6
         e1032Dhdez+RllJ/5zxuQWeA8tkDVqbb9s7E2MjRFcBCUGnJov2RPlE3mT+E0ADYtvpb
         v59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zqG9JMtX+vHNyprOzkAJ1KkCxnAmtf74H0q9YGZXDsU=;
        b=V0zXIBu5bAUuYualuDtC1cEhEloBTmfLRZG3/4nXYQgar/bdaJNTKgPQCiL33eCHJV
         7qge8Y9NvZxMwrlE73H0usrZKiHpPy9GE0Q/cyVL0u+X2QVSuRNUuzzUn3SaBcazljn7
         T8bA8HqBgkJ01xfXT/GAjIg8rT8X/HGP2zkLuGhNF1JozR4+CxItLxaj9urcuPh5auVW
         +8lr3XBMEb2Y5Ogjrhoge37hlxe/RKZu4O3djJxWLTIupU/QOwB5dZRbe/KuX5IwBXyN
         HpfK8WDj/8WltBO/Bv3bFX6r0aJuTho72VJoZcr7/fWKOmHUf074rFNMcKa5CH2m8HUL
         hhzw==
X-Gm-Message-State: APjAAAWkvyEncHe16awwnXCYFV36uWo6BbwYg2mcuAmLuJQl0s90sx1C
        SIKxI1+l8uSIQ50LLLu7v3o=
X-Google-Smtp-Source: APXvYqxKUzsiHW6Ri7Q/Xuo7SmX7yJv5pmo4Kz5II++OS4wFNt6PMaU/avaZ66pWprXimsWoRbOvuw==
X-Received: by 2002:adf:dd43:: with SMTP id u3mr5312119wrm.313.1558851079405;
        Sat, 25 May 2019 23:11:19 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id a124sm5302943wmh.3.2019.05.25.23.11.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 23:11:18 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-api@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v2 4/8] vfs: add missing checks to copy_file_range
Date:   Sun, 26 May 2019 09:10:55 +0300
Message-Id: <20190526061100.21761-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190526061100.21761-1-amir73il@gmail.com>
References: <20190526061100.21761-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Like the clone and dedupe interfaces we've recently fixed, the
copy_file_range() implementation is missing basic sanity, limits and
boundary condition tests on the parameters that are passed to it
from userspace. Create a new "generic_copy_file_checks()" function
modelled on the generic_remap_checks() function to provide this
missing functionality.

[Amir] Shorten copy length instead of checking pos_in limits
because input file size already abides by the limits.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/read_write.c    |  3 ++-
 include/linux/fs.h |  3 +++
 mm/filemap.c       | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index f1900bdb3127..b0fb1176b628 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1626,7 +1626,8 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
 		return -EXDEV;
 
-	ret = generic_file_rw_checks(file_in, file_out);
+	ret = generic_copy_file_checks(file_in, pos_in, file_out, pos_out, &len,
+				       flags);
 	if (unlikely(ret))
 		return ret;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 89b9b73eb581..e4d382c4342a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3050,6 +3050,9 @@ extern int generic_remap_checks(struct file *file_in, loff_t pos_in,
 				struct file *file_out, loff_t pos_out,
 				loff_t *count, unsigned int remap_flags);
 extern int generic_file_rw_checks(struct file *file_in, struct file *file_out);
+extern int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
+				    struct file *file_out, loff_t pos_out,
+				    size_t *count, unsigned int flags);
 extern ssize_t generic_file_read_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t __generic_file_write_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t generic_file_write_iter(struct kiocb *, struct iov_iter *);
diff --git a/mm/filemap.c b/mm/filemap.c
index 798aac92cd76..1852fbf08eeb 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3064,6 +3064,59 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
 	return 0;
 }
 
+/*
+ * Performs necessary checks before doing a file copy
+ *
+ * Can adjust amount of bytes to copy
+ * Returns appropriate error code that caller should return or
+ * zero in case the copy should be allowed.
+ */
+int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
+			     struct file *file_out, loff_t pos_out,
+			     size_t *req_count, unsigned int flags)
+{
+	struct inode *inode_in = file_inode(file_in);
+	struct inode *inode_out = file_inode(file_out);
+	uint64_t count = *req_count;
+	loff_t size_in;
+	int ret;
+
+	ret = generic_file_rw_checks(file_in, file_out);
+	if (ret)
+		return ret;
+
+	/* Don't touch certain kinds of inodes */
+	if (IS_IMMUTABLE(inode_out))
+		return -EPERM;
+
+	if (IS_SWAPFILE(inode_in) || IS_SWAPFILE(inode_out))
+		return -ETXTBSY;
+
+	/* Ensure offsets don't wrap. */
+	if (pos_in + count < pos_in || pos_out + count < pos_out)
+		return -EOVERFLOW;
+
+	/* Shorten the copy to EOF */
+	size_in = i_size_read(inode_in);
+	if (pos_in >= size_in)
+		count = 0;
+	else
+		count = min(count, size_in - (uint64_t)pos_in);
+
+	ret = generic_write_check_limits(file_out, pos_out, &count);
+	if (ret)
+		return ret;
+
+	/* Don't allow overlapped copying within the same file. */
+	if (inode_in == inode_out &&
+	    pos_out + count > pos_in &&
+	    pos_out < pos_in + count)
+		return -EINVAL;
+
+	*req_count = count;
+	return 0;
+}
+
 int pagecache_write_begin(struct file *file, struct address_space *mapping,
 				loff_t pos, unsigned len, unsigned flags,
 				struct page **pagep, void **fsdata)
-- 
2.17.1

