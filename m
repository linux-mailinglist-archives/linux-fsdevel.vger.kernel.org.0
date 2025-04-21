Return-Path: <linux-fsdevel+bounces-46756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A5FA94A5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 03:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C58E43B1D55
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 01:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA10513D503;
	Mon, 21 Apr 2025 01:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6Wja49Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88531C84BC;
	Mon, 21 Apr 2025 01:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745199273; cv=none; b=dtRHivjcTUaYvUW5nfACjFP+gOALM+UiVIPIpYcNVvpjerLGwqAuqaESLMM2N8kWqp8kvXizqzD4UDZ0U0UFQij0UpDPG8TiN1jJCeUEe0pDl5uCdjhAn+Vs/SUs8bTwKi9mt8O+8LgSUReUEgURveHQFX3PLkes/2fyLoAM8G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745199273; c=relaxed/simple;
	bh=Jht53ChYFHgs9fVdkHxX2GDuBPGNdx3JRH/1uFqn5+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TqGiCP4T9dhjPfdN4ebMzYE5hcg4oJnxiacBu0rDcfJ25bioXxnkpW+axNTzNzqrI/s4Td4mysdgn9EWhavVfx9Ajee6NpGcd7UOiG0rlGbipnmgq/Eye/xyeu4rEC5PbZcSBN5DQTfJZ9Va23mxldt3ketuUtr+5ngpnyqron8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6Wja49Y; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7272f9b4132so3007827a34.0;
        Sun, 20 Apr 2025 18:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745199271; x=1745804071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87hDz9VklLiiv0z6ZzoGmsWmujXBj1aSDF9l5QzufPk=;
        b=d6Wja49YOmNmk8sk/Al3t0bx0wf57fjCupxD1mZ+t+HzjvFmHHaqF+5q10STxbnx0I
         yh8tvzim94bvx+AQQ/pbd++kWEjYMFrLuzlzyF6u4aulLd4Ar3p47CBbRX1OGdKfBtpo
         AQOCnQLYThO49oY8nNItmU4nX9LOIaRBZQmGQs15ADHhNH+ohnaNmJs/baVlx+Xeay8s
         XLhewDpkWmgmr5uO16E+pgBbhHuKsZyITXYRzk/Slepee97/OFebiI6XswBpKS7Gf4I1
         645eFdx4LawDYOGHxHz+ssogAInQMpDksjY0v+ADNyC/XyaXFhDweO1AR3bWEJjK3VjT
         XLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745199271; x=1745804071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=87hDz9VklLiiv0z6ZzoGmsWmujXBj1aSDF9l5QzufPk=;
        b=bgAbLrJXz4ecJCRUeslAfjjNsRRgj9pDTTCluWta5tirKvH2csnxWGpGE0y010DoWr
         RUonC1pqF4Bhofgp3TgL3U5ClKkAbiuKMAikWUEZl0M8+luvFaC0cvPzUSx9Q/C/FuP6
         VjRnwwiehU0hxiTrl6KeKW8JTvodt+4vDxh17TpbvUoywaEMl/NUfmWU2/VdX6RFKJUc
         HoCweSJ8C9ZZv+qatxBnXJUhErj+8kqz0qOPapIZzSNNQbI7X9KRz0wHatEwGmXsnPwW
         BVHZBNzbqyvfeKJOtyA9QN/nI7HeAlK3zWtx9qZdv3q2ihvpJFq+Bv7eIVEjI00eBfcp
         BoeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdLo2UPSRm2l82dFAKU1PK/Tyd072TJTvZkh/H6l+yQL5u1OymUxW83V3/PN8blhSa/rsawc2VYfnTFN31Mg==@vger.kernel.org, AJvYcCUqUR/IR2GY+5HcB0JKuP6nrsrMEmu6Ac5OgK3QcbVSEm/K/QMY89jwPdgNmH4xVcaYdnDlHiKTIpU=@vger.kernel.org, AJvYcCVcwpXigDVdMtwh2UIzdw0RWqQM+84P//IM/5kuFmgpq9P8bFUB16rY0I05BDBf5qZlRDEJ/FF44CFQ@vger.kernel.org, AJvYcCXJSKWwm0Sigmr//l+fiwq3Hd/mOHsaRTZejHcaKCpBL9IR018cf9dWsjm+Jc9tESTp2zk6IZQMD1q3dhCn@vger.kernel.org
X-Gm-Message-State: AOJu0YzWOc00EWJZPVIv6SgHJ27yiPXVfrcwMR5pXVmbZes3YE2zssjn
	KKvPekcC3r4hZPTT6JxOFA6MmiONubitrA9W7tGIHe1NdqQ16ewY
X-Gm-Gg: ASbGncvIun3afxJXvb4Cdr7ix5arS/C5r1JqUjm5DMCYq/nBnttUo/knMWdjATAvsRw
	GOBvsbyAb2YenIyona+5pXj9jXPgn1IobX1YBbsDMtSxju3qD0kWzCFEOnGYzWaftdZTGjxCret
	TW9eIDAmfw+c2bH2PLhQdM0rIoc7imzt1FB3bsBiwfNVnByONus6uGfarnPCokQUPQYaanBedUp
	I+U+oehTOGpT40ibZN+ZidoWDxGWvPXl5T9ncK78+XXxANqcx8yK+rkPQtw8e7q2tA3eHP2JpbU
	HxX6l9PijdhwNCGXTBIFf5JTYMWDgUAvkpu5XK/+6ebbHMeOUxtCcmigFAEP+2CTnb2E3w==
X-Google-Smtp-Source: AGHT+IGp4vZtteKLozsEBPtZC1nWHMzjwcz0JoCBKnIYiH3inoL0umeX/iB+Kt+6JBcOpEy/kE2pLg==
X-Received: by 2002:a05:6830:6203:b0:72a:47ec:12da with SMTP id 46e09a7af769-7300621892cmr6947779a34.10.1745199270715;
        Sun, 20 Apr 2025 18:34:30 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a8f7:1b36:93ce:8dbf])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7300489cd44sm1267588a34.66.2025.04.20.18.34.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Apr 2025 18:34:30 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Miklos Szeredi <miklos@szeredb.hu>,
	Bernd Schubert <bschubert@ddn.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Luis Henriques <luis@igalia.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Petr Vorel <pvorel@suse.cz>,
	Brian Foster <bfoster@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	John Groves <john@groves.net>
Subject: [RFC PATCH 12/19] famfs_fuse: Plumb the GET_FMAP message/response
Date: Sun, 20 Apr 2025 20:33:39 -0500
Message-Id: <20250421013346.32530-13-john@groves.net>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250421013346.32530-1-john@groves.net>
References: <20250421013346.32530-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Upon completion of a LOOKUP, if we're in famfs-mode we do a GET_FMAP to
retrieve and cache up the file-to-dax map in the kernel. If this
succeeds, read/write/mmap are resolved direct-to-dax with no upcalls.

Signed-off-by: John Groves <john@groves.net>
---
 fs/fuse/dir.c             | 69 +++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h          | 36 +++++++++++++++++++-
 fs/fuse/inode.c           | 15 +++++++++
 include/uapi/linux/fuse.h |  4 +++
 4 files changed, 123 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index bc29db0117f4..ae135c55b9f6 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -359,6 +359,56 @@ bool fuse_invalid_attr(struct fuse_attr *attr)
 	return !fuse_valid_type(attr->mode) || !fuse_valid_size(attr->size);
 }
 
+#define FMAP_BUFSIZE 4096
+
+#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
+static void
+fuse_get_fmap_init(
+	struct fuse_conn *fc,
+	struct fuse_args *args,
+	u64 nodeid,
+	void *outbuf,
+	size_t outbuf_size)
+{
+	memset(outbuf, 0, outbuf_size);
+	args->opcode = FUSE_GET_FMAP;
+	args->nodeid = nodeid;
+
+	args->in_numargs = 0;
+
+	args->out_numargs = 1;
+	args->out_args[0].size = FMAP_BUFSIZE;
+	args->out_args[0].value = outbuf;
+}
+
+static int
+fuse_get_fmap(struct fuse_mount *fm, struct inode *inode, u64 nodeid)
+{
+	size_t fmap_size;
+	void *fmap_buf;
+	int err;
+
+	pr_notice("%s: nodeid=%lld, inode=%llx\n", __func__,
+		  nodeid, (u64)inode);
+	fmap_buf = kcalloc(1, FMAP_BUFSIZE, GFP_KERNEL);
+	FUSE_ARGS(args);
+	fuse_get_fmap_init(fm->fc, &args, nodeid, fmap_buf, FMAP_BUFSIZE);
+
+	/* Send GET_FMAP command */
+	err = fuse_simple_request(fm, &args);
+	if (err) {
+		pr_err("%s: err=%d from fuse_simple_request()\n",
+		       __func__, err);
+		return err;
+	}
+
+	fmap_size = args.out_args[0].size;
+	pr_notice("%s: nodei=%lld fmap_size=%ld\n", __func__, nodeid, fmap_size);
+
+	return 0;
+}
+#endif
+
 int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name,
 		     struct fuse_entry_out *outarg, struct inode **inode)
 {
@@ -404,6 +454,25 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 		fuse_queue_forget(fm->fc, forget, outarg->nodeid, 1);
 		goto out;
 	}
+
+#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
+	if (fm->fc->famfs_iomap) {
+		if (S_ISREG((*inode)->i_mode)) {
+			/* Note Lookup returns the looked-up inode in the attr
+			 * struct, but not in outarg->nodeid !
+			 */
+			pr_notice("%s: outarg: size=%d nodeid=%lld attr.ino=%lld\n",
+				 __func__, args.out_args[0].size, outarg->nodeid,
+				 outarg->attr.ino);
+			/* Get the famfs fmap */
+			fuse_get_fmap(fm, *inode, outarg->attr.ino);
+		} else
+			pr_notice("%s: no get_fmap for non-regular file\n",
+				 __func__);
+	} else
+		pr_notice("%s: fc->dax_iomap is not set\n", __func__);
+#endif
+
 	err = 0;
 
  out_put_forget:
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 931613102d32..437177c2f092 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -193,6 +193,10 @@ struct fuse_inode {
 	/** Reference to backing file in passthrough mode */
 	struct fuse_backing *fb;
 #endif
+
+#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
+	void *famfs_meta;
+#endif
 };
 
 /** FUSE inode state bits */
@@ -942,6 +946,8 @@ struct fuse_conn {
 #endif
 
 #if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
+	struct rw_semaphore famfs_devlist_sem;
+	struct famfs_dax_devlist *dax_devlist;
 	char *shadow;
 #endif
 };
@@ -1432,11 +1438,14 @@ void fuse_free_conn(struct fuse_conn *fc);
 
 /* dax.c */
 
+static inline int fuse_file_famfs(struct fuse_inode *fi); /* forward */
+
 /* This macro is used by virtio_fs, but now it also needs to filter for
  * "not famfs"
  */
 #define FUSE_IS_VIRTIO_DAX(fuse_inode) (IS_ENABLED(CONFIG_FUSE_DAX)	\
-					&& IS_DAX(&fuse_inode->inode))
+					&& IS_DAX(&fuse_inode->inode)	\
+					&& !fuse_file_famfs(fuse_inode))
 
 ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to);
 ssize_t fuse_dax_write_iter(struct kiocb *iocb, struct iov_iter *from);
@@ -1547,4 +1556,29 @@ extern void fuse_sysctl_unregister(void);
 #define fuse_sysctl_unregister()	do { } while (0)
 #endif /* CONFIG_SYSCTL */
 
+/* famfs.c */
+static inline struct fuse_backing *famfs_meta_set(struct fuse_inode *fi,
+						       void *meta)
+{
+#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
+	return xchg(&fi->famfs_meta, meta);
+#else
+	return NULL;
+#endif
+}
+
+static inline void famfs_meta_free(struct fuse_inode *fi)
+{
+	/* Stub wil be connected in a subsequent commit */
+}
+
+static inline int fuse_file_famfs(struct fuse_inode *fi)
+{
+#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
+	return (fi->famfs_meta != NULL);
+#else
+	return 0;
+#endif
+}
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 7f4b73e739cb..848c8818e6f7 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -117,6 +117,9 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 		fuse_inode_backing_set(fi, NULL);
 
+	if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
+		famfs_meta_set(fi, NULL);
+
 	return &fi->inode;
 
 out_free_forget:
@@ -138,6 +141,13 @@ static void fuse_free_inode(struct inode *inode)
 	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 		fuse_backing_put(fuse_inode_backing(fi));
 
+#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
+	if (S_ISREG(inode->i_mode) && fi->famfs_meta) {
+		famfs_meta_free(fi);
+		famfs_meta_set(fi, NULL);
+	}
+#endif
+
 	kmem_cache_free(fuse_inode_cachep, fi);
 }
 
@@ -1002,6 +1012,11 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 		fuse_backing_files_init(fc);
 
+	if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)) {
+		pr_notice("%s: Kernel is FUSE_FAMFS_DAX capable\n", __func__);
+		init_rwsem(&fc->famfs_devlist_sem);
+	}
+
 	INIT_LIST_HEAD(&fc->mounts);
 	list_add(&fm->fc_entry, &fc->mounts);
 	fm->fc = fc;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index f9e14180367a..d85fb692cf3b 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -652,6 +652,10 @@ enum fuse_opcode {
 	FUSE_TMPFILE		= 51,
 	FUSE_STATX		= 52,
 
+	/* Famfs / devdax opcodes */
+	FUSE_GET_FMAP           = 53,
+	FUSE_GET_DAXDEV         = 54,
+
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
 
-- 
2.49.0


