Return-Path: <linux-fsdevel+bounces-71995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E09CDABD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 23:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB16430221AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 22:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297F7329C75;
	Tue, 23 Dec 2025 22:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dVlI1xY9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDFB32862D
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 22:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766528001; cv=none; b=P/yb/W569mDmTv0oV8tNZMqPh2Nc6Wr+4BF2YmBkrjrYiQawYyMtN0eAXblOkOsM0q6+nwX6TnUziyd8DL4vGxoRnGjUInuoB3P+xS77RXzJJ+cZqswNcbK70eI3sY4CJHjrQSVc4WLSN9oFULbBknGKro0eciS3FMNYAXUQhDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766528001; c=relaxed/simple;
	bh=fC6ZoLs0i5oAtAfGDv+35X2cJEyZlbkOGvYoVIrkR38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xz2nTsRllL+1OG/fwcyfWE106p8PuEsDGxYIW1klbV9wOmAg3nsV26zVsuAwf7VFU+UNzGtikkSDXw//CG1njuXPWcQGsaIUOC5bwIP94yQZBbwwBEV2oRZVeEf9N/1GxsBmTFL9lfwzQj88gqaXBY37IIMZSKD7QLe7W9stxLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=dVlI1xY9; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b73161849e1so1115389566b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 14:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1766527998; x=1767132798; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dyQMxsFmgDL3ZMJE0MRttB63yYTG6AbIMvy3H24Prk=;
        b=dVlI1xY9m+YfBKf9CWG5dQ2eShJcyNYkpa8+12kJ7KUb1pKN1G9ADyQuxAcGX2hr6j
         ExTLfO8lUgHs3Y1vIlk/WZGu9nb+rQRoEsdvjZGsePcVXlX9YoJYM54oic+1w5Mm9dah
         GIycnY/glqyFdQE0YQz7F3kNL88tVUODMMqMAEqH+s+yBGUin3G1gEscHkgZbZ+3Q1pO
         FKcuZyj48hNHylAlEOpdbjTQTfjTyxNn83bd6ZztotgHYuWNuYfhW+dqi5Lfbk84LKxx
         Ccd3z0736CPXqnRJbN3EMW1BD265El5QoNlKCWuIgL/u/tdXjhncM96cRz5FC7ZDrjpR
         5vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766527998; x=1767132798;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1dyQMxsFmgDL3ZMJE0MRttB63yYTG6AbIMvy3H24Prk=;
        b=IH/TMOJmYbWb+QgqUE08L94tOcnJgjRAi5dUvs2FAGZP8tDoexCF08ZruiDZiAls+z
         Zx1l2UHtLIiwt7++JO8R7oLgf6bvPC+p8eF49yeT9uM/il6kiPwvd0tqNlDqcV0Kq83a
         U+H5PSauLbFPhDUyaDMCE4GJy9J1lncWUjO5X3V+Wvr7E6VtZjiOjQtHoP3wdYbvhehM
         jY6qpiXCCh2kPE6fo11Pu8bx3inbSh1nDFGV8CEs0kOQAeWXAUkBnCxlczfnZFkfNTeK
         kTr9hk4HVqWmvWHHLR97UghkDc0i60gOOHCs/nVfN0V8QHfxyokQ3kviWbRw21w5e6dk
         MBHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4kXYw2bzZ0NM6jbAaL8Ip8pvsVu7ijKNtFscs5N30e1VbC4OQXw6KQvbF3NQHFk0DRSPff5XmC3fVhifu@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc02o2A8CfgwlIczhClOyvOkOTE8B1eR89CmKrCoROfAIDdGFg
	pOwOFu+odObPtSCYjwiHfk7JTgnyN+/jQz+lJ3H0kaD/IKx4Ww9t0/BH2Xkjw8Xd
X-Gm-Gg: AY/fxX6Vsm7o4S39bjyUjeF90+FcZSy/qeOvwlX3UK+GFK0lxFm2tMQAaEG2MxSCHgi
	+JW1T2XyAcciPFD2r99YDvZIo9jtuXG5Nf7VO6FLO96qL+yp5uHQKsyHBADH/FTN4CmN/WBN+zS
	Xpy3Vcrl1iYhs1RGejRsvkw4ROm0eqeCRbETdH+QRiywuSMsKhwZcPHIljKoY5hUpWZKgf6ucI0
	MA4CWRNS4KmLFp00yNrJFMtjvtBZ3iQA9QqejKnNnmNB+B/7n3BozjblR9hhBBJLb/qvBKQ3LvO
	HNa40aELNATEuvt3yALCiOtSMEhGnp48SIFPXh+kehFTntV3hRkIxrJ5uV3veT64tT7qmkpGA5t
	nx8PHQ/qV/L6U/0DEdg010dJVKIyzQbV9MWIDC4J7BY6PNw4SKEuaJCYdmI/nn0gAlxrwLs5Svn
	UlGlp7JP5p5weEm9uXEih4FWU/dqomfv+k5WSV0qBbS1ckPjhT
X-Google-Smtp-Source: AGHT+IFQVE24cGK8refH4Ac1kIMLYJcZHqhHOGf4yOsVOTzxHipBZfVYl88N/QyPQKytt/kxr929Rw==
X-Received: by 2002:a17:906:846d:b0:b80:18e5:9cb9 with SMTP id a640c23a62f3a-b803705df76mr1133649866b.39.1766527997599;
        Tue, 23 Dec 2025 14:13:17 -0800 (PST)
Received: from [127.0.1.1] (178-062-210-188.ip-addr.inexio.net. [188.210.62.178])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b90f53c70sm14903373a12.6.2025.12.23.14.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 14:13:16 -0800 (PST)
From: Horst Birthelmer <hbirthelmer@googlemail.com>
X-Google-Original-From: Horst Birthelmer <hbirthelmer@ddn.com>
Date: Tue, 23 Dec 2025 23:13:06 +0100
Subject: [PATCH RFC v2 2/2] fuse: add an implementation of open+getattr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-fuse-compounds-upstream-v2-2-0f7b4451c85e@ddn.com>
References: <20251223-fuse-compounds-upstream-v2-0-0f7b4451c85e@ddn.com>
In-Reply-To: <20251223-fuse-compounds-upstream-v2-0-0f7b4451c85e@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Horst Birthelmer <hbirthelmer@ddn.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766527992; l=7123;
 i=hbirthelmer@ddn.com; s=20251006; h=from:subject:message-id;
 bh=fC6ZoLs0i5oAtAfGDv+35X2cJEyZlbkOGvYoVIrkR38=;
 b=sV0iQanKpeheiU/t5Bnt+b8MPrNGvVYiUPnVEUQGqFcmApUbAqiQQVxOeJKHePVC/SCIm6zlC
 5mvnyuCMU7+B9iFbNVhXb7bDMtiqzXPi+iyBtkNLEp/35uiVzNSV+y6
X-Developer-Key: i=hbirthelmer@ddn.com; a=ed25519;
 pk=v3BVDFoy16EzgHZ23ObqW+kbpURtjrwxgKu8YNDKjGg=

The discussion about compound commands in fuse was
started over an argument to add a new operation that
will open a file and return its attributes in the same operation.

Here is a demonstration of that use case with compound commands.

Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
---
 fs/fuse/file.c   | 125 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 fs/fuse/fuse_i.h |   6 ++-
 fs/fuse/inode.c  |   6 +++
 fs/fuse/ioctl.c  |   2 +-
 4 files changed, 121 insertions(+), 18 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 01bc894e9c2b..507b4c4ba257 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -126,8 +126,84 @@ static void fuse_file_put(struct fuse_file *ff, bool sync)
 	}
 }
 
+static int fuse_compound_open_getattr(struct fuse_mount *fm, u64 nodeid,
+				int flags, int opcode,
+				struct fuse_file *ff,
+				struct fuse_attr_out *outattrp,
+				struct fuse_open_out *outopenp)
+{
+	struct fuse_compound_req *compound;
+	struct fuse_args open_args = {}, getattr_args = {};
+	struct fuse_open_in open_in = {};
+	struct fuse_getattr_in getattr_in = {};
+	int err;
+
+	/* Build compound request with flag to execute in the given order */
+	compound = fuse_compound_alloc(fm, 0);
+	if (IS_ERR(compound))
+		return PTR_ERR(compound);
+
+	/* Add OPEN */
+	open_in.flags = flags & ~(O_CREAT | O_EXCL | O_NOCTTY);
+	if (!fm->fc->atomic_o_trunc)
+		open_in.flags &= ~O_TRUNC;
+
+	if (fm->fc->handle_killpriv_v2 &&
+	    (open_in.flags & O_TRUNC) && !capable(CAP_FSETID)) {
+		open_in.open_flags |= FUSE_OPEN_KILL_SUIDGID;
+	}
+	open_args.opcode = opcode;
+	open_args.nodeid = nodeid;
+	open_args.in_numargs = 1;
+	open_args.in_args[0].size = sizeof(open_in);
+	open_args.in_args[0].value = &open_in;
+	open_args.out_numargs = 1;
+	open_args.out_args[0].size = sizeof(struct fuse_open_out);
+	open_args.out_args[0].value = outopenp;
+
+	err = fuse_compound_add(compound, &open_args);
+	if (err)
+		goto out;
+
+	/* Add GETATTR */
+	getattr_args.opcode = FUSE_GETATTR;
+	getattr_args.nodeid = nodeid;
+	getattr_args.in_numargs = 1;
+	getattr_args.in_args[0].size = sizeof(getattr_in);
+	getattr_args.in_args[0].value = &getattr_in;
+	getattr_args.out_numargs = 1;
+	getattr_args.out_args[0].size = sizeof(struct fuse_attr_out);
+	getattr_args.out_args[0].value = outattrp;
+
+	err = fuse_compound_add(compound, &getattr_args);
+	if (err)
+		goto out;
+
+	err = fuse_compound_send(compound);
+	if (err)
+		goto out;
+
+	/* Check if the OPEN operation succeeded */
+	err = fuse_compound_get_error(compound, 0);
+	if (err)
+		goto out;
+
+	/* Check if the GETATTR operation succeeded */
+	err = fuse_compound_get_error(compound, 1);
+	if (err)
+		goto out;
+
+	ff->fh = outopenp->fh;
+	ff->open_flags = outopenp->open_flags;
+
+out:
+	fuse_compound_free(compound);
+	return err;
+}
+
 struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
-				 unsigned int open_flags, bool isdir)
+				struct inode *inode,
+				unsigned int open_flags, bool isdir)
 {
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_file *ff;
@@ -153,23 +229,41 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 	if (open) {
 		/* Store outarg for fuse_finish_open() */
 		struct fuse_open_out *outargp = &ff->args->open_outarg;
-		int err;
+		int err = -ENOSYS;
+
+		if (inode && fc->compound_open_getattr) {
+			struct fuse_attr_out attr_outarg;
+			err = fuse_compound_open_getattr(fm, nodeid, open_flags,
+							opcode, ff, &attr_outarg, outargp);
+			if (!err)
+				fuse_change_attributes(inode, &attr_outarg.attr, NULL,
+						       ATTR_TIMEOUT(&attr_outarg),
+						       fuse_get_attr_version(fc));
+		}
+		if (err == -ENOSYS) {
+			err = fuse_send_open(fm, nodeid, open_flags, opcode, outargp);
 
-		err = fuse_send_open(fm, nodeid, open_flags, opcode, outargp);
-		if (!err) {
-			ff->fh = outargp->fh;
-			ff->open_flags = outargp->open_flags;
-		} else if (err != -ENOSYS) {
-			fuse_file_free(ff);
-			return ERR_PTR(err);
-		} else {
-			if (isdir) {
+			if (!err) {
+				ff->fh = outargp->fh;
+				ff->open_flags = outargp->open_flags;
+			}
+		}
+
+		if (err) {
+			if (err != -ENOSYS) {
+				/* err is not ENOSYS */
+				fuse_file_free(ff);
+				return ERR_PTR(err);
+			} else {
 				/* No release needed */
 				kfree(ff->args);
 				ff->args = NULL;
-				fc->no_opendir = 1;
-			} else {
-				fc->no_open = 1;
+
+				/* we don't have open */
+				if (isdir)
+					fc->no_opendir = 1;
+				else
+					fc->no_open = 1;
 			}
 		}
 	}
@@ -185,11 +279,10 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 int fuse_do_open(struct fuse_mount *fm, u64 nodeid, struct file *file,
 		 bool isdir)
 {
-	struct fuse_file *ff = fuse_file_open(fm, nodeid, file->f_flags, isdir);
+	struct fuse_file *ff = fuse_file_open(fm, nodeid, file_inode(file), file->f_flags, isdir);
 
 	if (!IS_ERR(ff))
 		file->private_data = ff;
-
 	return PTR_ERR_OR_ZERO(ff);
 }
 EXPORT_SYMBOL_GPL(fuse_do_open);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 86253517f59b..98af019037c3 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -924,6 +924,9 @@ struct fuse_conn {
 	/* Use io_uring for communication */
 	unsigned int io_uring;
 
+	/* Does the filesystem support compound operations? */
+	unsigned int compound_open_getattr:1;
+
 	/** Maximum stack depth for passthrough backing files */
 	int max_stack_depth;
 
@@ -1557,7 +1560,8 @@ void fuse_file_io_release(struct fuse_file *ff, struct inode *inode);
 
 /* file.c */
 struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
-				 unsigned int open_flags, bool isdir);
+								struct inode *inode,
+								unsigned int open_flags, bool isdir);
 void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 		       unsigned int open_flags, fl_owner_t id, bool isdir);
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 819e50d66622..a5fd721be96d 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -991,6 +991,12 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->blocked = 0;
 	fc->initialized = 0;
 	fc->connected = 1;
+
+	/* pretend fuse server supports compound operations
+	 * until it tells us otherwise.
+	 */
+	fc->compound_open_getattr = 1;
+
 	atomic64_set(&fc->attr_version, 1);
 	atomic64_set(&fc->evict_ctr, 1);
 	get_random_bytes(&fc->scramble_key, sizeof(fc->scramble_key));
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index fdc175e93f74..07a02e47b2c3 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -494,7 +494,7 @@ static struct fuse_file *fuse_priv_ioctl_prepare(struct inode *inode)
 	if (!S_ISREG(inode->i_mode) && !isdir)
 		return ERR_PTR(-ENOTTY);
 
-	return fuse_file_open(fm, get_node_id(inode), O_RDONLY, isdir);
+	return fuse_file_open(fm, get_node_id(inode), NULL, O_RDONLY, isdir);
 }
 
 static void fuse_priv_ioctl_cleanup(struct inode *inode, struct fuse_file *ff)

-- 
2.51.0


