Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D558298D26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 13:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775594AbgJZMvl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 08:51:41 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:38550 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775592AbgJZMvk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 08:51:40 -0400
Received: by mail-wm1-f45.google.com with SMTP id l15so12354258wmi.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2020 05:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UlQHDovrNDKdm6IMWfQLoIWvimboiAorH8hQQgAJgW0=;
        b=os91uLp57kt4nqat5HhkoFKu6bst0Qcip5dCGs+GvojC0bpuwZ87xH7J6IBws0VczG
         XPofmJhdzL0jGnAl6RZjzKbExzR7Rc/VWc5QjqsGdhTHsX4SVHpZZX9ocf/p9DCdsrhj
         FJEONn2hG6iPGGKJY98/OheZt1U7MlZX1Jwh+yQN55tcnKyxt4Krtpny80nszreQBFMP
         dAcu9csc7hrNClTue7rOb3KSe7sVhPMhdBb1zF5D2KCaKh/0PzPqHqg7etkCNtu41qt/
         8A57UamCKtKZYxYbvHxGZpgy7thVmw6xRGgHQVYUrmOhT7ST0eVjfOq/tusBWiLQI0Cw
         gR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UlQHDovrNDKdm6IMWfQLoIWvimboiAorH8hQQgAJgW0=;
        b=jEqi9NXg4cme9iOFNiYkqOm+4dwluZJ8QieEaltLeUegGazJZtGWR4NtRRyWP3zi+v
         dTngcfE6tOKoU5goGheday7+iwgr7I+TAck3iaZh64qCmWcA4n6WUBN4Q2roeXYn5AR7
         k2qjmZHfAsj4iVYYy5n6V9Egpn90DhICBTcIJiXWYYR9UZS482fM/GSQXaopr3qzkdlD
         Px6HdUdZxzZ01DE6LZmbhWYdx7rrer0VxbX4tmeBvLlXtAukVV8rZAnY2s4jf03SyFMa
         OiFj9uzRCBtsxLN4/Mqi/RO+1V2/xuGN0n1e5LahUGGVW/C/QCA1r93u1nWZb7Yj8DhK
         R7jg==
X-Gm-Message-State: AOAM5322E7t//V+Fn9NdRlsdhbEgL7X17qIOBAKCfEdogILPCM19z+4b
        BtiW+ayrmMdWnGE5mfKf7r7xXQ==
X-Google-Smtp-Source: ABdhPJz7wg2jt+vpyty1PDUJG2zT0AyXcJOSKop7mt8WbVzDGhWyUwqVGRB0zA/hvDJyZKOuEY00Eg==
X-Received: by 2002:a1c:2c02:: with SMTP id s2mr16656471wms.66.1603716698330;
        Mon, 26 Oct 2020 05:51:38 -0700 (PDT)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id r1sm24423262wro.18.2020.10.26.05.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 05:51:37 -0700 (PDT)
From:   Alessio Balsini <balsini@android.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V10 3/5] fuse: Introduce synchronous read and write for passthrough
Date:   Mon, 26 Oct 2020 12:50:14 +0000
Message-Id: <20201026125016.1905945-4-balsini@android.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201026125016.1905945-1-balsini@android.com>
References: <20201026125016.1905945-1-balsini@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All the read and write operations performed on fuse_files which have the
passthrough feature enabled are forwarded to the associated lower file
system file via VFS.

Sending the request directly to the lower file system avoids the userspace
round-trip that, because of possible context switches and additional
operations might reduce the overall performance, especially in those cases
where caching doesn't help, for example in reads at random offsets.

Verifying if a fuse_file has a lower file system file associated with can
be done by checking the validity of its passthrough_filp pointer. This
pointer is not NULL only if passthrough has been successfully enabled via
the appropriate ioctl().
When a read/write operation is requested for a FUSE file with passthrough
enabled, a new equivalent VFS request is generated, which instead targets
the lower file system file.
The VFS layer performs additional checks that allow for safer operations
but may cause the operation to fail if the process accessing the FUSE file
system does not have access to the lower file system.

This change only implements synchronous requests in passthrough, returning
an error in the case of asynchronous operations, yet covering the majority
of the use cases.

Signed-off-by: Alessio Balsini <balsini@android.com>
---
 fs/fuse/file.c        |  8 +++--
 fs/fuse/fuse_i.h      |  2 ++
 fs/fuse/passthrough.c | 70 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 84daaf084197..f7a12489c0ef 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1545,7 +1545,9 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (is_bad_inode(file_inode(file)))
 		return -EIO;
 
-	if (!(ff->open_flags & FOPEN_DIRECT_IO))
+	if (ff->passthrough.filp)
+		return fuse_passthrough_read_iter(iocb, to);
+	else if (!(ff->open_flags & FOPEN_DIRECT_IO))
 		return fuse_cache_read_iter(iocb, to);
 	else
 		return fuse_direct_read_iter(iocb, to);
@@ -1559,7 +1561,9 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (is_bad_inode(file_inode(file)))
 		return -EIO;
 
-	if (!(ff->open_flags & FOPEN_DIRECT_IO))
+	if (ff->passthrough.filp)
+		return fuse_passthrough_write_iter(iocb, from);
+	else if (!(ff->open_flags & FOPEN_DIRECT_IO))
 		return fuse_cache_write_iter(iocb, from);
 	else
 		return fuse_direct_write_iter(iocb, from);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 32da45ce86e0..a888d3df5877 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1118,5 +1118,7 @@ int fuse_passthrough_open(struct fuse_dev *fud,
 int fuse_passthrough_setup(struct fuse_conn *fc, struct fuse_file *ff,
 			   struct fuse_open_out *openarg);
 void fuse_passthrough_release(struct fuse_passthrough *passthrough);
+ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *to);
+ssize_t fuse_passthrough_write_iter(struct kiocb *iocb, struct iov_iter *from);
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index a135c955cc33..5a78cb336db4 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -4,6 +4,76 @@
 
 #include <linux/fuse.h>
 #include <linux/idr.h>
+#include <linux/uio.h>
+
+static void fuse_copyattr(struct file *dst_file, struct file *src_file)
+{
+	struct inode *dst = file_inode(dst_file);
+	struct inode *src = file_inode(src_file);
+
+	i_size_write(dst, i_size_read(src));
+}
+
+static inline rwf_t iocb_to_rw_flags(int ifl)
+{
+	rwf_t flags = 0;
+
+	if (ifl & IOCB_APPEND)
+		flags |= RWF_APPEND;
+	if (ifl & IOCB_DSYNC)
+		flags |= RWF_DSYNC;
+	if (ifl & IOCB_HIPRI)
+		flags |= RWF_HIPRI;
+	if (ifl & IOCB_NOWAIT)
+		flags |= RWF_NOWAIT;
+	if (ifl & IOCB_SYNC)
+		flags |= RWF_SYNC;
+
+	return flags;
+}
+
+ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
+				   struct iov_iter *iter)
+{
+	ssize_t ret;
+	struct file *fuse_filp = iocb_fuse->ki_filp;
+	struct fuse_file *ff = fuse_filp->private_data;
+	struct file *passthrough_filp = ff->passthrough.filp;
+
+	if (!iov_iter_count(iter))
+		return 0;
+
+	ret = vfs_iter_read(passthrough_filp, iter, &iocb_fuse->ki_pos,
+			    iocb_to_rw_flags(iocb_fuse->ki_flags));
+
+	return ret;
+}
+
+ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
+				    struct iov_iter *iter)
+{
+	ssize_t ret;
+	struct file *fuse_filp = iocb_fuse->ki_filp;
+	struct fuse_file *ff = fuse_filp->private_data;
+	struct inode *fuse_inode = file_inode(fuse_filp);
+	struct file *passthrough_filp = ff->passthrough.filp;
+
+	if (!iov_iter_count(iter))
+		return 0;
+
+	inode_lock(fuse_inode);
+
+	file_start_write(passthrough_filp);
+	ret = vfs_iter_write(passthrough_filp, iter, &iocb_fuse->ki_pos,
+			     iocb_to_rw_flags(iocb_fuse->ki_flags));
+	file_end_write(passthrough_filp);
+	if (ret > 0)
+		fuse_copyattr(fuse_filp, passthrough_filp);
+
+	inode_unlock(fuse_inode);
+
+	return ret;
+}
 
 int fuse_passthrough_open(struct fuse_dev *fud,
 			  struct fuse_passthrough_out *pto)
-- 
2.29.0.rc1.297.gfa9743e501-goog

