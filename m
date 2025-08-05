Return-Path: <linux-fsdevel+bounces-56790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54821B1BA1A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 20:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EC263AD76E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 18:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1F329827C;
	Tue,  5 Aug 2025 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EsdhWCbG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887EE18A6DB
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754418627; cv=none; b=vGndqikPXBvP5xK2KgazBljUtuN4IANnnAF+E09pubJC+b1aOTMcORMPcZzXAlPzei8pG/Rqzekg2kWirH1h8Je5RDHZhMR8bYM0LfigBhQWoQHolQKrEBM1S45kwFkOFi93jSSJ+xuibPycIabRJYep3g5FzU1GjCcGSsZ5DdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754418627; c=relaxed/simple;
	bh=26q9N1vo03U4nVt/GXjomWfYD8iDuDUC81VY5mwy5m4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vEF6kZf0jWIIbaqs4Tbygn6cMJ1df3wUZ/EJSXhQV0xgf2UzaXxwbrqZIKx//+6Ttihmz0Cazhfvr9K2uEjLxjIMCn0nBSjvJX0qgn+oEWxLTaaqA7Is1jLHtu0pNupmf2Z+VAnUtTjukA+R94q3rbwiUZ0SYQ0MQrGkR544cpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EsdhWCbG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754418624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vz+7NfaqBpEjmqUoN8iIqDgcLEFKL8pbt/BKn73/gY8=;
	b=EsdhWCbGIZRwcE2DFWXqyGJobNmeDFt9JZBuwYQ/dFFNhjRMDy9Q+oElKL1pcVTJo0TUDB
	gZHIHnKrkELO/SghvIhaiM1y+3D2FYyd7+pymt5b8EA8cqUwOpDyrQQyBGDgVPtWqWnU4A
	52Dy/Z4FONrC45Va6rOvgqMtDtIHyNU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-JPQ77flKP5yEie9y7DLGAQ-1; Tue, 05 Aug 2025 14:30:22 -0400
X-MC-Unique: JPQ77flKP5yEie9y7DLGAQ-1
X-Mimecast-MFC-AGG-ID: JPQ77flKP5yEie9y7DLGAQ_1754418621
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-458c0845b34so17486815e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Aug 2025 11:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754418621; x=1755023421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vz+7NfaqBpEjmqUoN8iIqDgcLEFKL8pbt/BKn73/gY8=;
        b=duVFsReKNLFPGctgt2/8rPAiyHjsBj3B9x7UWXJ3T4gB5GVUy6D4IupTQvg8qFtthp
         apDkZ+fgIqkjV0vuPZ2LNC2ZcW1aul3GDgaK+Hg/VrxXTvqshhvPyz5/Tf+YOxEWyoKP
         dKuH+gBRHApVrP1AdnnLHTZ51D71ZfgOm59C7H9OkmMEqQTx6b0b2wCx1VtxQQ5fimd1
         /I4SDbYzoHhMT/4suJlcXARcnZ0jMw2kmzzhvFYDmXl2LNL1k/iFHF1Cb3jhh52RIL12
         1VTjhuAt5MNGSwbHI+WgPx3yoPJv8zVjN1MMysYo3hXBaHUf9pcEFPZoBh92hZ2wJ0qp
         6rpw==
X-Gm-Message-State: AOJu0Yy06Pi20mYE2DCvnpu9ZMNG3DTfc+JlKQ32urH/za3PGvPqPT1v
	B34ZOMdrQi/Kzw2vtDhZbZsRDL0XX+1J+ZBCxtdkK4YWvNP7G8Kgk0STR6lc8qgpdjacY6/ym28
	kOZwl6OodvOeKzhID7WDEpxrHhJG6v93J21nhMWjxIFe262gPQ8FmDZQJvGd9bIpSZ1PhJhqtA+
	QW7b+xiNfuheieRQ/OrNCRBpHi9n6DqV8Op2jphvZgXEAZzE878P7g0g==
X-Gm-Gg: ASbGncsVYxNZ0UtABgePMnukL4Di3t9B1OTPyEvRaNEs/E241tZOUiUGlks4Z9CFU01
	LZrta1x6Z1h+ikGAAopZHmIJRyIydFyAZXfptZq+0Aw23O0yJ0ceU63C7nxZu6M3KnAF2WQaFYL
	1V8mHSIYv3+QJx6U3RRzcZbKzyTuvm+uhc3NK2RyVRY3Xk6hLubbrCz5/sHdyYUvCITOw/MRCn2
	nRR6DH67+2nPM8PEMKXcSqFPYwcjLxq1m7q5jVLzSLS2ulSZbM+BG9Mh5IGxlvwx2b57piTdfeW
	qSHBeFsbiDBkjZw9341QBVjKdMN4qkWkFjTZII+5wV2GsQd/C7VOF2yoqEgYNEDZJjG4Qa4/xLt
	47l0Pz7D5r3pnzxbhmLMJGxovEvTT0FRT6Y6NnnJzf2ZtD/MFyhgZ
X-Received: by 2002:a05:600c:3113:b0:43b:ca39:6c75 with SMTP id 5b1f17b1804b1-458b6b32b36mr124379565e9.16.1754418620624;
        Tue, 05 Aug 2025 11:30:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA65XS3ukBru6fA8XZ7fqNcSbdk0lbdbWRU15/yDX0/KoWXrzStOV+oBX0t99I4dK1u6P8qQ==
X-Received: by 2002:a05:600c:3113:b0:43b:ca39:6c75 with SMTP id 5b1f17b1804b1-458b6b32b36mr124379315e9.16.1754418619986;
        Tue, 05 Aug 2025 11:30:19 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (2A00111001223DBEE14EFA8D033F8FE7.mobile.pool.telekom.hu. [2a00:1110:122:3dbe:e14e:fa8d:33f:8fe7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e586ad64sm14164595e9.20.2025.08.05.11.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 11:30:19 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Bernd Schubert <bschubert@ddn.com>,
	Florian Weimer <fweimer@redhat.com>
Subject: [PATCH 1/2] fuse: fix COPY_FILE_RANGE interface
Date: Tue,  5 Aug 2025 20:30:15 +0200
Message-ID: <20250805183017.4072973-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FUSE protocol uses struct fuse_write_out to convey the return value of
copy_file_range, which is restricted to uint32_t.  But the COPY_FILE_RANGE
interface supports a 64-bit size copies.

Currently the number of bytes copied is silently truncated to 32-bit, which
is unfortunate at best.

Introduce a new op COPY_FILE_RANGE_64, which is identical, except the
number of bytes copied is returned in a 64-bit value.

If the fuse server does not support COPY_FILE_RANGE_64, fall back to
COPY_FILE_RANGE and truncate the size to UINT_MAX - 4096.

Reported-by: Florian Weimer <fweimer@redhat.com>
Closes: https://lore.kernel.org/all/lhuh5ynl8z5.fsf@oldenburg.str.redhat.com/
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/file.c            | 34 ++++++++++++++++++++++++++--------
 fs/fuse/fuse_i.h          |  3 +++
 include/uapi/linux/fuse.h | 12 +++++++++++-
 3 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index adc4aa6810f5..bd6624885855 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3017,6 +3017,8 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 		.flags = flags
 	};
 	struct fuse_write_out outarg;
+	struct fuse_copy_file_range_out outarg_64;
+	u64 bytes_copied;
 	ssize_t err;
 	/* mark unstable when write-back is not used, and file_out gets
 	 * extended */
@@ -3066,30 +3068,46 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (is_unstable)
 		set_bit(FUSE_I_SIZE_UNSTABLE, &fi_out->state);
 
-	args.opcode = FUSE_COPY_FILE_RANGE;
+	args.opcode = FUSE_COPY_FILE_RANGE_64;
 	args.nodeid = ff_in->nodeid;
 	args.in_numargs = 1;
 	args.in_args[0].size = sizeof(inarg);
 	args.in_args[0].value = &inarg;
 	args.out_numargs = 1;
-	args.out_args[0].size = sizeof(outarg);
-	args.out_args[0].value = &outarg;
+	args.out_args[0].size = sizeof(outarg_64);
+	args.out_args[0].value = &outarg_64;
+	if (fc->no_copy_file_range_64) {
+fallback:
+		/* Fall back to old op that can't handle large copy length */
+		args.opcode = FUSE_COPY_FILE_RANGE;
+		args.out_args[0].size = sizeof(outarg);
+		args.out_args[0].value = &outarg;
+		inarg.len = min_t(size_t, len, 0xfffff000);
+	}
 	err = fuse_simple_request(fm, &args);
 	if (err == -ENOSYS) {
-		fc->no_copy_file_range = 1;
-		err = -EOPNOTSUPP;
+		if (fc->no_copy_file_range_64) {
+			fc->no_copy_file_range = 1;
+			err = -EOPNOTSUPP;
+		} else {
+			fc->no_copy_file_range_64 = 1;
+			goto fallback;
+		}
 	}
 	if (err)
 		goto out;
 
+	bytes_copied = fc->no_copy_file_range_64 ?
+		outarg.size : outarg_64.bytes_copied;
+
 	truncate_inode_pages_range(inode_out->i_mapping,
 				   ALIGN_DOWN(pos_out, PAGE_SIZE),
-				   ALIGN(pos_out + outarg.size, PAGE_SIZE) - 1);
+				   ALIGN(pos_out + bytes_copied, PAGE_SIZE) - 1);
 
 	file_update_time(file_out);
-	fuse_write_update_attr(inode_out, pos_out + outarg.size, outarg.size);
+	fuse_write_update_attr(inode_out, pos_out + bytes_copied, bytes_copied);
 
-	err = outarg.size;
+	err = bytes_copied;
 out:
 	if (is_unstable)
 		clear_bit(FUSE_I_SIZE_UNSTABLE, &fi_out->state);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index b54f4f57789f..a8be19f686b1 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -850,6 +850,9 @@ struct fuse_conn {
 	/** Does the filesystem support copy_file_range? */
 	unsigned no_copy_file_range:1;
 
+	/** Does the filesystem support copy_file_range_64? */
+	unsigned no_copy_file_range_64:1;
+
 	/* Send DESTROY request */
 	unsigned int destroy:1;
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 122d6586e8d4..94621f68a5cc 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -235,6 +235,10 @@
  *
  *  7.44
  *  - add FUSE_NOTIFY_INC_EPOCH
+ *
+ *  7.45
+ *  - add FUSE_COPY_FILE_RANGE_64
+ *  - add struct fuse_copy_file_range_out
  */
 
 #ifndef _LINUX_FUSE_H
@@ -270,7 +274,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 44
+#define FUSE_KERNEL_MINOR_VERSION 45
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -657,6 +661,7 @@ enum fuse_opcode {
 	FUSE_SYNCFS		= 50,
 	FUSE_TMPFILE		= 51,
 	FUSE_STATX		= 52,
+	FUSE_COPY_FILE_RANGE_64	= 53,
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
@@ -1148,6 +1153,11 @@ struct fuse_copy_file_range_in {
 	uint64_t	flags;
 };
 
+/* For FUSE_COPY_FILE_RANGE_64 */
+struct fuse_copy_file_range_out {
+	uint64_t	bytes_copied;
+};
+
 #define FUSE_SETUPMAPPING_FLAG_WRITE (1ull << 0)
 #define FUSE_SETUPMAPPING_FLAG_READ (1ull << 1)
 struct fuse_setupmapping_in {
-- 
2.49.0


