Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3084621F93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 23:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfEQVZA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 17:25:00 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:33650 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbfEQVZA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 17:25:00 -0400
Received: by mail-pg1-f201.google.com with SMTP id s8so5207860pgk.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2019 14:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2s+WtHt0xVYSES8yQsV6/RNZ+qrsDxexZPBb8+//cQ8=;
        b=qhWHzJsakiKjFraRvn973QzeDsH0PgsqRUAi2bbGjU1G48Npxz35o70nSQ0PrpO3Em
         i99hzLUtO0DkehOa8ldTXHCoaN7DIgwldadkwd2MkfUr7AV9WfgorAf5yDZb+IP/uIMV
         BzlZoVPkMcyWdoC9MU+SJZo282uydDZS8c3qxk4KQjcA3FtLbb6LyleQtfEjLG6XoRZ9
         BSClrnkIjksUmBOWBhdAAjmMJmlaP/lp2iUuSnunoRtBIznZdtsVHN9W55pWeGyhWUR1
         khMvcJdO1WGkBo5j9vmG7/IWqP4qDpbYJ8qvaeU1mgsYD86SCuE0P7r6+XVTYUNwdUqM
         Aobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2s+WtHt0xVYSES8yQsV6/RNZ+qrsDxexZPBb8+//cQ8=;
        b=nvU4lHBbOVz3yS3OlHg0ZEKRRGhGhELr2cSy7aHReFgLqkTWQYYzTVXRbFVVL0dQQo
         Y8WVAesxQAtW5qkO2T7tIxDQxyCyMrDu4U7XiuFIX27wFvMRAPeMS51b4xOJk7uRvwvo
         xZlGM3Rb7/umBDBX4rxOdfe2rXisuumtl28F2TLCDYrqOSeGZmsVVkKBsDfi1LzAeSbj
         3XrE/MgE4ynCcS/GVR09defTl4vnbqhJ5b8LP+wQXEA51h9EsWIpNpZkIv4Ss7/glDsM
         ++jNMJ6inrM2aqmu6EvDm2eR7SjUstUSKPy94fX0FUi6Og1dGayHJIkPKrx8arlZVW1l
         sydQ==
X-Gm-Message-State: APjAAAVFeC47O1hxU5lmcNb5VM9nXf1vpq2XNjVPFeSIMb8vtdt3Gavo
        CQ4aMOe4w7WIfMa6UYzpynjUnDa6RfUKT8BZ9zgd+Q==
X-Google-Smtp-Source: APXvYqwPf2+O0p+dSfTpp5u79tgKSV9op63b3cr5zHPIY6Z7Qo46V24Lsfk2ye858N9iXgG32j6T4ReODfabQ+zKRrzLEw==
X-Received: by 2002:a65:42ca:: with SMTP id l10mr6451745pgp.181.1558128299252;
 Fri, 17 May 2019 14:24:59 -0700 (PDT)
Date:   Fri, 17 May 2019 14:24:44 -0700
In-Reply-To: <20190517212448.14256-1-matthewgarrett@google.com>
Message-Id: <20190517212448.14256-3-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190517212448.14256-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH V3 2/6] FUSE: Allow filesystems to provide gethash methods
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
index 06096b60f1df..cf73c1712333 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3156,6 +3156,38 @@ static ssize_t fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 
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
 
@@ -3177,6 +3209,7 @@ static const struct file_operations fuse_file_operations = {
 	.poll		= fuse_file_poll,
 	.fallocate	= fuse_file_fallocate,
 	.copy_file_range = fuse_copy_file_range,
+	.get_hash	= fuse_file_get_hash,
 };
 
 static const struct address_space_operations fuse_file_aops  = {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 0920c0c032a0..7e796eaebe38 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -714,6 +714,13 @@ struct fuse_conn {
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
index ec5d9953dfb6..845e6c48a6f4 100644
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
@@ -456,6 +457,7 @@ enum {
 	OPT_ALLOW_OTHER,
 	OPT_MAX_READ,
 	OPT_BLKSIZE,
+	OPT_ALLOW_GETHASH,
 	OPT_ERR
 };
 
@@ -468,6 +470,7 @@ static const match_table_t tokens = {
 	{OPT_ALLOW_OTHER,		"allow_other"},
 	{OPT_MAX_READ,			"max_read=%u"},
 	{OPT_BLKSIZE,			"blksize=%u"},
+	{OPT_ALLOW_GETHASH,		"allow_gethash"},
 	{OPT_ERR,			NULL}
 };
 
@@ -554,6 +557,15 @@ static int parse_fuse_opt(char *opt, struct fuse_mount_data *d, int is_bdev,
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
@@ -577,6 +589,8 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",default_permissions");
 	if (fc->allow_other)
 		seq_puts(m, ",allow_other");
+	if (fc->allow_gethash)
+		seq_puts(m, ",allow_gethash");
 	if (fc->max_read != ~0)
 		seq_printf(m, ",max_read=%u", fc->max_read);
 	if (sb->s_bdev && sb->s_blocksize != FUSE_DEFAULT_BLKSIZE)
@@ -1167,6 +1181,7 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 	fc->user_id = d.user_id;
 	fc->group_id = d.group_id;
 	fc->max_read = max_t(unsigned, 4096, d.max_read);
+	fc->allow_gethash = d.allow_gethash;
 
 	/* Used by get_root_inode() */
 	sb->s_fs_info = fc;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 2ac598614a8f..31a2dc016a8b 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -399,6 +399,7 @@ enum fuse_opcode {
 	FUSE_RENAME2		= 45,
 	FUSE_LSEEK		= 46,
 	FUSE_COPY_FILE_RANGE	= 47,
+	FUSE_GETHASH		= 48,
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
@@ -822,4 +823,9 @@ struct fuse_copy_file_range_in {
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

