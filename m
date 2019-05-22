Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBDD269A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 20:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbfEVSNn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 14:13:43 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:42207 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbfEVSNn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 14:13:43 -0400
Received: by mail-yb1-f201.google.com with SMTP id v22so2847676ybb.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2019 11:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+IAS24bvoT6KCKSZJBMAHwUwLFDiYhVfFPEcOO2vYVU=;
        b=K+Tv4+2eWCBG6jteYwWoWD112XnDeiwE74I2pfmVgpjqDREXF/cwC08ChiXR9XB2uD
         n4yesW5u9RR+oRKmBKHMRhYhRe8IhgtGLjmrY0bqb+w+Ij21Ixiqs2AfHtrnB7W+2+ZY
         eMv7rj6gmXkO5s0hOF3gHT5VzwrVabwAlJabccJ3WmGDkvK8JNH/4FWnsO1/yIUsuXr/
         7OtOnsiih+4MLXJvIfZsmng7eK6vVQTtYpVJ7QygC/eJ15l+FpOZWp/QNEGCdKDNKVVA
         SYL2BaeyVb/UEUvk8bQNVrpFtNjPlfcuUxpMBUe1i2c9C0vKHl6p58a5lHr/NTzS7woI
         lscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+IAS24bvoT6KCKSZJBMAHwUwLFDiYhVfFPEcOO2vYVU=;
        b=RNK/1QAJ7qKoNPID+kmK9duyCDiYYt6lrtucnV/w6415qiXUrXXkW7XjWgJONKwxKr
         TfO1mM1q9e4jft4s391XHLnOI99FClUUpVZxl2RCcEGH0qzlkb8MhwypxLZNhQGzL5Su
         cE6DT7MnMxAEgJmqUYJI4Fz768GzP2KREji3rc8RiJGwvBqmi0Oxk646xtLuC9pCO+bG
         8Jsa45MkxNP0Vc4nz8bTl29/abyOB1qfXx6Kr5etL4QsnEhnHvVxapcydhxBRvHpGUw+
         NIluevozEJMW4Tf3n1EepWN4sO+PyO1oNowSGVxfyQTsVZlKvd1o2n7b3zIPAkaa1E3x
         Dhlw==
X-Gm-Message-State: APjAAAU+xC7vGiONO36uA7GEOh3N1k9tMpzGqgti+ohjl17hHL3N9YZc
        n99FrorAqPjiY+lLHLElOMC4cSTKsOwgklq1IT2jew==
X-Google-Smtp-Source: APXvYqwihKKb/sLg0LH6caYO15TawZZFk1N9W6Uo6d7ym4JR4ny6W0RaIpB8x69+AxEQAK0LVSYmImgu9uyVR7/CvSj7qg==
X-Received: by 2002:a81:59c2:: with SMTP id n185mr41299555ywb.21.1558548822021;
 Wed, 22 May 2019 11:13:42 -0700 (PDT)
Date:   Wed, 22 May 2019 11:13:26 -0700
In-Reply-To: <20190522181327.71980-1-matthewgarrett@google.com>
Message-Id: <20190522181327.71980-5-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190522181327.71980-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH V4 4/5] FUSE: Allow filesystems to provide gethash methods
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.vnet.ibm.com, dmitry.kasatkin@gmail.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matthew Garrett <mjg59@google.com>

FUSE implementations may have a secure way to provide file hashes (eg,
they're a front-end to a remote store that ties files to their hashes).
Allow filesystems to expose this information, but require an option to
be provided before it can be used. This is to avoid malicious users
being able to mount an unprivileged FUSE filesystem that provides
incorrect hashes.

A sufficiently malicious FUSE filesystem may still simply swap out its
contents after the hash has been obtained - this patchset does nothing
to change that, and sysadmins should have appropriate policy in place to
protect against that.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 fs/fuse/file.c            | 33 +++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h          |  7 +++++++
 fs/fuse/inode.c           | 15 +++++++++++++++
 include/uapi/linux/fuse.h |  6 ++++++
 4 files changed, 61 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 3959f08279e6..a89ace030d1c 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3170,6 +3170,38 @@ static ssize_t fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 
 	inode_unlock(inode_out);
 
+	return err;
+};
+
+static int fuse_file_get_hash(struct file *file, enum hash_algo hash,
+			      uint8_t *buf, size_t size)
+{
+	struct fuse_file *ff = file->private_data;
+	struct fuse_conn *fc = ff->fc;
+	FUSE_ARGS(args);
+	struct fuse_gethash_in inarg;
+	int err = 0;
+
+	if (!fc->allow_gethash)
+		return -EOPNOTSUPP;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.size = size;
+	inarg.hash = hash;
+	args.in.h.opcode = FUSE_GETHASH;
+	args.in.h.nodeid = ff->nodeid;
+	args.in.numargs = 1;
+	args.in.args[0].size = sizeof(inarg);
+	args.in.args[0].value = &inarg;
+	args.out.numargs = 1;
+	args.out.args[0].size = size;
+	args.out.args[0].value = buf;
+
+	err = fuse_simple_request(fc, &args);
+
+	if (err == -ENOSYS)
+		err = -EOPNOTSUPP;
+
 	return err;
 }
 
@@ -3191,6 +3223,7 @@ static const struct file_operations fuse_file_operations = {
 	.poll		= fuse_file_poll,
 	.fallocate	= fuse_file_fallocate,
 	.copy_file_range = fuse_copy_file_range,
+	.get_hash	= fuse_file_get_hash,
 };
 
 static const struct address_space_operations fuse_file_aops  = {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 24dbca777775..06c8d396cc74 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -721,6 +721,13 @@ struct fuse_conn {
 	/** Does the filesystem support copy_file_range? */
 	unsigned no_copy_file_range:1;
 
+	/*
+	 * Allow the underlying filesystem to the hash of a file. This is
+	 * used by IMA to avoid needing to calculate the hash on every
+	 * measurement
+	 */
+	unsigned allow_gethash:1;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 4bb885b0f032..ef7f408ac69c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -70,6 +70,7 @@ struct fuse_mount_data {
 	unsigned group_id_present:1;
 	unsigned default_permissions:1;
 	unsigned allow_other:1;
+	unsigned allow_gethash:1;
 	unsigned max_read;
 	unsigned blksize;
 };
@@ -451,6 +452,7 @@ enum {
 	OPT_ALLOW_OTHER,
 	OPT_MAX_READ,
 	OPT_BLKSIZE,
+	OPT_ALLOW_GETHASH,
 	OPT_ERR
 };
 
@@ -463,6 +465,7 @@ static const match_table_t tokens = {
 	{OPT_ALLOW_OTHER,		"allow_other"},
 	{OPT_MAX_READ,			"max_read=%u"},
 	{OPT_BLKSIZE,			"blksize=%u"},
+	{OPT_ALLOW_GETHASH,		"allow_gethash"},
 	{OPT_ERR,			NULL}
 };
 
@@ -549,6 +552,15 @@ static int parse_fuse_opt(char *opt, struct fuse_mount_data *d, int is_bdev,
 			d->blksize = value;
 			break;
 
+		case OPT_ALLOW_GETHASH:
+			/*
+			 * This is relevant to security decisions made in
+			 * the root namespace, so restrict it more strongly
+			 */
+			if (capable(CAP_SYS_ADMIN))
+				d->allow_gethash = 1;
+			break;
+
 		default:
 			return 0;
 		}
@@ -572,6 +584,8 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",default_permissions");
 	if (fc->allow_other)
 		seq_puts(m, ",allow_other");
+	if (fc->allow_gethash)
+		seq_puts(m, ",allow_gethash");
 	if (fc->max_read != ~0)
 		seq_printf(m, ",max_read=%u", fc->max_read);
 	if (sb->s_bdev && sb->s_blocksize != FUSE_DEFAULT_BLKSIZE)
@@ -1164,6 +1178,7 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 	fc->user_id = d.user_id;
 	fc->group_id = d.group_id;
 	fc->max_read = max_t(unsigned, 4096, d.max_read);
+	fc->allow_gethash = d.allow_gethash;
 
 	/* Used by get_root_inode() */
 	sb->s_fs_info = fc;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 19fb55e3c73e..2487e2c3a4ba 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -417,6 +417,7 @@ enum fuse_opcode {
 	FUSE_RENAME2		= 45,
 	FUSE_LSEEK		= 46,
 	FUSE_COPY_FILE_RANGE	= 47,
+	FUSE_GETHASH		= 48,
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
@@ -840,4 +841,9 @@ struct fuse_copy_file_range_in {
 	uint64_t	flags;
 };
 
+struct fuse_gethash_in {
+	uint32_t	size;
+	uint32_t	hash;
+};
+
 #endif /* _LINUX_FUSE_H */
-- 
2.21.0.1020.gf2820cf01a-goog

