Return-Path: <linux-fsdevel+bounces-73837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ED0D216AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 22:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8E6D305819B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 21:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8151392C5F;
	Wed, 14 Jan 2026 21:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbGKgdOT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C3338A9BD
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 21:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768427129; cv=none; b=bb4bvv5cV9EE4lK9e6N3uT23dS8t2jCM22fE5J+jcOu1ubRTtYEC5VoSLDvwYkxhevwlBjX6Ix6IQLF7gQVfTbWf2nX4aKhHaocNx1XE1GD9EalpWmWiS6B4WlrMXjGSLOu1+YAwlZ4WaBxhtIzTDABu9sosraT/7yVFcVxHKmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768427129; c=relaxed/simple;
	bh=64imX2M1jBYG4Gju+wyYxzFrGS9hKawBE1V6rd+WCwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQgDC1QMQV1xlp9AqL1gCeQTxbbWK9dNWSziqL01lwmdK4LLlor7I2KJt4ubE0Kv1i4SK58eNV79pJXzsv3xKNcuKLNdLEnGj3R0DqIGAHLS24YBvvAE/3J1yfl59MuuelD/oP4zNbC5sBOWjyLBfio/7BimdIeoeOHNNeJheOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbGKgdOT; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7cfd2be567bso185283a34.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 13:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768427089; x=1769031889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCMfzYseGdgpcfKs/nbqdFGXhkfjkf3otWuk3WOoJPo=;
        b=MbGKgdOTyaVzus5T0n2oCJF2FlfdxZERuQaae79BIw6gj3XXzAM4w6zlDlvLrtdIRB
         eqO5gZV3uw49rpkISrFHcaTJa70piad/3Pp5T2/JzhkwtmjY4K7eajAcbOZQvNHlbLWZ
         UEUPYHgYo893UBPoZeFXkX91sTuhuMbLAW6FGEfcgLFPbZd19vOVg/tIWSDTVVn3iKuI
         q8eDgy2cfYoRk+WA4yuoA3jXcH5+p6NroPUikQwdJsDFNs57GMRmGzWc2XPlb3De9UoT
         8TGPzi3wkqLOkLOMDRf4x5+p9B4DHDAi3S1QYaqI26YbU4g8+cYPZuXXfem5i3arczz8
         lgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768427089; x=1769031889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zCMfzYseGdgpcfKs/nbqdFGXhkfjkf3otWuk3WOoJPo=;
        b=HxdIZEuUcuO6WWm9JeYuq42qU7kz30r5SO2b+XuOVSTdLQDcVYVC+aV84oROCCi2lq
         uUVnibhYe0sLwHd15uW6uHIlB17xfx/EfumJZxIZ+BTP2vfiCOkdm2aCJC4HOUoeWnHZ
         rDoBypGVSJd1FLdfTWEYNn6h7OfKbXfyH7p5a9eYr0uVXscNkmJD9EHFE/fyd/O437xj
         PNfd1asHQHRVfHRGkYWYGAjmXzFDOqVwBxY/ylH08LYKwdHlB4E1V6JdGtE7ABu40+u1
         lKdpfk8s+Lduy/hgLa/Purde852UbKvGhap7QK2nCyJZ3234SreV11E7rmhljjnOSgos
         rpWA==
X-Forwarded-Encrypted: i=1; AJvYcCU0J9J8Jq/xb2dRePvZWjmKzwWka2kLC/EZiPKYdISz3iaR4nvl62yy3sMuf9MGHJhicNOOJ+wHO8CUTUTa@vger.kernel.org
X-Gm-Message-State: AOJu0YziXblrgRMX8L+Fo5da7teH1YNivOHGvkK1JiuPA4gqARXpnNSI
	UUPhiW6OmiPlD1jXiMeGAXIanB37ViPnn1klC1VNYsMOYRqBVdrUKgIc
X-Gm-Gg: AY/fxX432L68Tt6LxI+ZclhdirXKH41sGvVTXC+EAEjUTyBHMcicuLGtFd+mE13Yxu6
	884MHAbroDD08ENJcYJKRmJNZyk2BiSSvvkCSEBYKi3NYSU1L5oq7PaOOplra9vpHV2ip+r2cRy
	BXdHg0iAv3TEnFhVtmzqh6hPC9jTb3iQkvEf7ETakGDeUHWByFb6FMvU9Pn1EvJzKKeeB8yzA0O
	o81zRe5gxwxO/sV31h0PVw6Zlf3fXzjLHCUxWGk+VQanFVk4+iY3DBno8VGkDDAjNxn/nDwkYoC
	Rf8Zd89W02xGtSF3tLbUaJc5xIbH4AU8xuchK+e1jdSlnaemXAyxkajLxhpgdgOpW+XSBlYpEcF
	n6M7rbcSy5Phq/7OAkVm8rI+6MEQiVlG8AMkwBibcJ9fRci3VK3MlFj+HG5G1qK4yeJZqrVXUub
	1D/jiKWO1t6fqIULKNu+d4EqDRpc9Ez2uh4VcnwuPpJhh8
X-Received: by 2002:a05:6808:158f:b0:45a:8cdc:102e with SMTP id 5614622812f47-45c714aa671mr2464387b6e.23.1768427088755;
        Wed, 14 Jan 2026 13:44:48 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:4c85:2962:e438:72c4])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e17cd0esm11964602b6e.3.2026.01.14.13.44.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Jan 2026 13:44:48 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	James Morse <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	venkataravis@micron.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH V4 3/3] fuse: add famfs DAX fmap support
Date: Wed, 14 Jan 2026 15:43:07 -0600
Message-ID: <20260114214307.29893-4-john@groves.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114214307.29893-1-john@groves.net>
References: <20260114153133.29420.compound@groves.net>
 <20260114214307.29893-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new FUSE operations and capability for famfs DAX file mapping:

- FUSE_CAP_DAX_FMAP: New capability flag at bit 32 (using want_ext/capable_ext
  fields) to indicate kernel and userspace support for DAX fmaps

- GET_FMAP: New operation to retrieve a file map for DAX-mapped files.
  Returns a fuse_famfs_fmap_header followed by simple or interleaved
  extent descriptors. The kernel passes the file size as an argument.

- GET_DAXDEV: New operation to retrieve DAX device info by index.
  Called when GET_FMAP returns an fmap referencing a previously
  unknown DAX device.

These operations enable FUSE filesystems to provide direct access
mappings to persistent memory, allowing the kernel to map files
directly to DAX devices without page cache intermediation.

Signed-off-by: John Groves <john@groves.net>
---
 include/fuse_common.h   |  5 +++++
 include/fuse_lowlevel.h | 37 +++++++++++++++++++++++++++++++++++++
 lib/fuse_lowlevel.c     | 31 ++++++++++++++++++++++++++++++-
 patch/maintainers.txt   |  0
 4 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100644 patch/maintainers.txt

diff --git a/include/fuse_common.h b/include/fuse_common.h
index 041188e..23b24e8 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -512,6 +512,11 @@ struct fuse_loop_config_v1 {
  */
 #define FUSE_CAP_OVER_IO_URING (1UL << 31)
 
+/**
+ * handle files that use famfs dax fmaps
+ */
+#define FUSE_CAP_DAX_FMAP (1UL << 32)
+
 /**
  * Ioctl flags
  *
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index 016f831..a94436a 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -1341,6 +1341,43 @@ struct fuse_lowlevel_ops {
 	 */
 	void (*statx)(fuse_req_t req, fuse_ino_t ino, int flags, int mask,
 		      struct fuse_file_info *fi);
+
+	/**
+	 * Get a famfs/devdax/fsdax fmap
+	 *
+	 * Retrieve a file map (aka fmap) for a previously looked-up file.
+	 * The fmap is serialized into the buffer, anchored by
+	 * struct fuse_famfs_fmap_header, followed by one or more
+	 * structs fuse_famfs_simple_ext, or fuse_famfs_iext (which itself
+	 * is followed by one or more fuse_famfs_simple_ext...
+	 *
+	 * Valid replies:
+	 *    fuse_reply_buf  (TODO: variable-size reply)
+	 *    fuse_reply_err
+	 *
+	 * @param req request handle
+	 * @param ino the inode number
+	 */
+	void (*get_fmap) (fuse_req_t req, fuse_ino_t ino, size_t size);
+
+	/**
+	 * Get a daxdev by index
+	 *
+	 * Retrieve info on a daxdev by index. This will be called any time
+	 * GET_FMAP has returned a file map that references a previously
+	 * unused daxdev. struct famfs_simple_ext, which is used for all
+	 * resolutions to daxdev offsets, references daxdevs by index.
+	 * In user space we maintain a master list of all referenced daxdevs
+	 * by index, which is queried by get_daxdev.
+	 *
+	 * Valid replies:
+	 *    fuse_reply_buf
+	 *    fuse_reply_err
+	 *
+	 * @param req request handle
+	 * @param ino the index of the daxdev
+	 */
+	void (*get_daxdev) (fuse_req_t req, int daxdev_index);
 };
 
 /**
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 0cde3d4..ac78233 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2769,7 +2769,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 			se->conn.capable_ext |= FUSE_CAP_NO_EXPORT_SUPPORT;
 		if (inargflags & FUSE_OVER_IO_URING)
 			se->conn.capable_ext |= FUSE_CAP_OVER_IO_URING;
-
+		if (inargflags & FUSE_DAX_FMAP)
+			se->conn.capable_ext |= FUSE_CAP_DAX_FMAP;
 	} else {
 		se->conn.max_readahead = 0;
 	}
@@ -2932,6 +2933,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 		outargflags |= FUSE_REQUEST_TIMEOUT;
 		outarg.request_timeout = se->conn.request_timeout;
 	}
+	if (se->conn.want_ext & FUSE_CAP_DAX_FMAP)
+		outargflags |= FUSE_DAX_FMAP;
 
 	outarg.max_readahead = se->conn.max_readahead;
 	outarg.max_write = se->conn.max_write;
@@ -3035,6 +3038,30 @@ static void do_destroy(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
 	_do_destroy(req, nodeid, inarg, NULL);
 }
 
+static void
+do_get_fmap(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+{
+	struct fuse_session *se = req->se;
+	struct fuse_getxattr_in *arg = (struct fuse_getxattr_in *) inarg;
+
+	if (se->op.get_fmap)
+		se->op.get_fmap(req, nodeid, arg->size);
+	else
+		fuse_reply_err(req, -EOPNOTSUPP);
+}
+
+static void
+do_get_daxdev(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+{
+	struct fuse_session *se = req->se;
+	(void)inarg;
+
+	if (se->op.get_daxdev)
+		se->op.get_daxdev(req, nodeid); /* Use nodeid as daxdev_index */
+	else
+		fuse_reply_err(req, -EOPNOTSUPP);
+}
+
 static void list_del_nreq(struct fuse_notify_req *nreq)
 {
 	struct fuse_notify_req *prev = nreq->prev;
@@ -3470,6 +3497,8 @@ static struct {
 	[FUSE_LSEEK]	   = { do_lseek,       "LSEEK"	     },
 	[FUSE_STATX]	   = { do_statx,       "STATX"	     },
 	[CUSE_INIT]	   = { cuse_lowlevel_init, "CUSE_INIT"   },
+	[FUSE_GET_FMAP]	   = { do_get_fmap, "GET_FMAP"       },
+	[FUSE_GET_DAXDEV]  = { do_get_daxdev, "GET_DAXDEV"   },
 };
 
 static struct {
diff --git a/patch/maintainers.txt b/patch/maintainers.txt
new file mode 100644
index 0000000..e69de29
-- 
2.52.0


