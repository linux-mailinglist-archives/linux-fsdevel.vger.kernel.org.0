Return-Path: <linux-fsdevel+bounces-72656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF758CFEDD7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 17:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BF8332FC2F8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 16:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F60397ADA;
	Wed,  7 Jan 2026 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjFzTIUj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D9B3986EA
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800098; cv=none; b=N+XuzDx8aj/XwVN/ZIPkP0qa9x2SlTV9mQE2M4VnAQ6t3Brb5huJ8KSxTSp97fW1+Wam7maG06cTOZ4LNYsmoT2mvlSWyE0nAGC0v4ES4qBz93c1ZrUr40WJNHRe1pNAyvQEI1Cxm4N+uUv9DY8JVFqKVHp2rGWH3pWj5y5m9CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800098; c=relaxed/simple;
	bh=vRum9MOJIbnk5V10fy2a3HtDPMHvk45XsqC1Kt9gTgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYMf9w9uu5TZ9tc5hkTGaODr7y/6RtRfml+nuQyM6O5yFR0tHIgKT0z6PgwCBCncwRINhbwqAwELhGh8djbgObazLQAfIx2F6PqthDBcRx5KLlkEDJZ++gS+BB5IZLktWXDqBjJGrqovz/H9gL9igAwMtPr0KpHwq2XLyYBsYCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjFzTIUj; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4537407477aso1408959b6e.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 07:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767800094; x=1768404894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgHZ9K8s1Kd63AAlsULJaWt5wwYk3G9jV8eBPFKbz1s=;
        b=BjFzTIUjkYpx6wOsG9e0FAo2iFBu0Uh4VZwYzEjZbSko/1UaFMXNZ8CKe0I231aUDI
         Sz4QOoQ+WR1prTMm257yO/NB2prFPiMo7wDBbj9HhPtbM9wyxHtPpbB1oRLwlEmXsOnh
         obavnCzloKMJ0QN3m3IRWq/4afbVbYeE7jerw3gCzG1KQs+40NfyyJ6OGyS7dSBGdz8U
         cHAym38Ysnj5iG1tTIorWb4Do6iE5X3vYOvwBRM9MtePaeXepf9ei8q40DKnVuQwZ+4P
         rMwHXdx/LxJ64Q692IGXt3gvZ22cTs4FdG0N0TMv/yfhREBu3JBtmSep8RU+61H6cGsX
         IgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767800094; x=1768404894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AgHZ9K8s1Kd63AAlsULJaWt5wwYk3G9jV8eBPFKbz1s=;
        b=aWX/cIuxBxURjgYEpdElY1qU6c4YFsr9RaC3bfAoO2YHtd98txW6nCNejMMro0NWRM
         D0iSHeXF+6F1lgQSCWifwqO8LsK4pbO2Mmby8MgaeLRahYFJ+R0IhTGwv59bbTF0G8l6
         w4COnrAMQka55u7f1uBjnLDawgr8WbEopPKuOZXIWxbdukn9FYJ4+vJruhd+HI/5A2I/
         ORKLvBCRaHZbPYS8Ld/aITHxptSJW2D+CKU1puRpwJQ4Re2Sc2jsgg5UaHmlbEfNrCm2
         pvq8CB8hm4v1VS/xdXqA6ENHvRejjQSIR1TS1+SrI82GW1dBdxZexx1zu2XctPXI5uLU
         /BKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpjZTdw9+4wGlajuMHr3o9cilS9RulOr+TajmA2s8U51OBCvlDpUcJOIheJjzCQ9XOqj+STDxqLoghBkjU@vger.kernel.org
X-Gm-Message-State: AOJu0YznZu662H32nsaYKXUoE8IcUQWUZSLEZhOntOm9/5A0kCVoeiF5
	aqL2UUs/OWie3dp/12T+pt6g0IOMyIj7/+DPCYAc2PwBy53xQnYIk2oL
X-Gm-Gg: AY/fxX7MDXo2bYzEHFstglGZJP01g76VtApeCD55ZoA/IqXEmtVX5XhlrztUh9HYDgw
	EQDTJaSEVbZ56sQ9Ih04uBFX2iv2JVJKTU6JdBI/5eFxRnCJxvBHrqCNx1rsiASDTlyFWiHcH+V
	rGMD/BZtht0Y79s0DSQ4QT13M5NJ1NK9sj9E5ZfyefqFcM8qsCMLGkZ2AUWewZUzpcWWhVJWmxe
	/cgiwXWwhqKacN8G5ED2P80kZy2DsusayjlxA9EVyp6LQix0UAWTy6NCOCOO7xRZ3hSVwzArviK
	qLIaBT646jd0Wy1fy9iKuw2YoYhkA3aG5A2lqeepGvkgftC6Zs3f77SyCGFm85LUzu8xAB4YxWS
	ySb764wr4Ote+3qJbP20UwJtKCKSc+tBFxPaxtAsJEuOJYUXc5DKDXwoHUCai7xTFd+jtAh+le2
	zTWL50QGjXc+gbK+awO9WL3VE8LC1DRrPNqfRWPO+O+vMr1MlXp6hNN54=
X-Google-Smtp-Source: AGHT+IEctONtJN8X6RkDy3vlMMfCQL9fRHlA6U9Vq5ZhSHzcHAHtRbTqbeZMB15NbJe9BeCbtXIxAQ==
X-Received: by 2002:a05:6808:16a2:b0:450:340:2693 with SMTP id 5614622812f47-45a6bee4000mr1183862b6e.42.1767800094073;
        Wed, 07 Jan 2026 07:34:54 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e183ac3sm2398424b6e.4.2026.01.07.07.34.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 07:34:53 -0800 (PST)
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
	Chen Linxuan <chenlinxuan@uniontech.com>,
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
	linux-fsdevel@vger.kernel.org,
	John Groves <john@groves.net>
Subject: [PATCH V3 2/4] fuse_kernel.h: add famfs DAX fmap protocol definitions
Date: Wed,  7 Jan 2026 09:34:41 -0600
Message-ID: <20260107153443.64794-3-john@groves.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107153443.64794-1-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153443.64794-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add FUSE protocol version 7.46 definitions for famfs DAX file mapping:

Capability flag:
  - FUSE_DAX_FMAP (bit 43): kernel supports DAX fmap operations

New opcodes:
  - FUSE_GET_FMAP (54): retrieve file extent map for DAX mapping
  - FUSE_GET_DAXDEV (55): retrieve DAX device info by index

New structures for GET_FMAP reply:
  - struct fuse_famfs_fmap_header: file map header with type and extent info
  - struct fuse_famfs_simple_ext: simple extent (device, offset, length)
  - struct fuse_famfs_iext: interleaved extent for striped allocations

New structures for GET_DAXDEV:
  - struct fuse_get_daxdev_in: request DAX device by index
  - struct fuse_daxdev_out: DAX device name response

Supporting definitions:
  - enum fuse_famfs_file_type: regular, superblock, or log file
  - enum famfs_ext_type: simple or interleaved extent type

Signed-off-by: John Groves <john@groves.net>
---
 include/fuse_kernel.h | 88 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index c13e1f9..7fdfc30 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -240,6 +240,19 @@
  *  - add FUSE_COPY_FILE_RANGE_64
  *  - add struct fuse_copy_file_range_out
  *  - add FUSE_NOTIFY_PRUNE
+ *
+ *  7.46
+ *    - Add FUSE_DAX_FMAP capability - ability to handle in-kernel fsdax maps
+ *    - Add the following structures for the GET_FMAP message reply components:
+ *      - struct fuse_famfs_simple_ext
+ *      - struct fuse_famfs_iext
+ *      - struct fuse_famfs_fmap_header
+ *    - Add the following structs for the GET_DAXDEV message and reply
+ *      - struct fuse_get_daxdev_in
+ *      - struct fuse_get_daxdev_out
+ *    - Add the following enumerated types
+ *      - enum fuse_famfs_file_type
+ *      - enum famfs_ext_type
  */
 
 #ifndef _LINUX_FUSE_H
@@ -448,6 +461,7 @@ struct fuse_file_lock {
  * FUSE_OVER_IO_URING: Indicate that client supports io-uring
  * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
  *			 init_out.request_timeout contains the timeout (in secs)
+ * FUSE_DAX_FMAP:        kernel supports dev_dax_iomap (aka famfs) fmaps
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -495,6 +509,7 @@ struct fuse_file_lock {
 #define FUSE_ALLOW_IDMAP	(1ULL << 40)
 #define FUSE_OVER_IO_URING	(1ULL << 41)
 #define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
+#define FUSE_DAX_FMAP		(1ULL << 43)
 
 /**
  * CUSE INIT request/reply flags
@@ -664,6 +679,10 @@ enum fuse_opcode {
 	FUSE_STATX		= 52,
 	FUSE_COPY_FILE_RANGE_64	= 53,
 
+	/* Famfs / devdax opcodes */
+	FUSE_GET_FMAP           = 54,
+	FUSE_GET_DAXDEV         = 55,
+
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
 
@@ -1308,4 +1327,73 @@ struct fuse_uring_cmd_req {
 	uint8_t padding[6];
 };
 
+/* Famfs fmap message components */
+
+#define FAMFS_FMAP_VERSION 1
+
+#define FAMFS_FMAP_MAX 32768 /* Largest supported fmap message */
+#define FUSE_FAMFS_MAX_EXTENTS 32
+#define FUSE_FAMFS_MAX_STRIPS 32
+
+enum fuse_famfs_file_type {
+	FUSE_FAMFS_FILE_REG,
+	FUSE_FAMFS_FILE_SUPERBLOCK,
+	FUSE_FAMFS_FILE_LOG,
+};
+
+enum famfs_ext_type {
+	FUSE_FAMFS_EXT_SIMPLE = 0,
+	FUSE_FAMFS_EXT_INTERLEAVE = 1,
+};
+
+struct fuse_famfs_simple_ext {
+	uint32_t se_devindex;
+	uint32_t reserved;
+	uint64_t se_offset;
+	uint64_t se_len;
+};
+
+struct fuse_famfs_iext { /* Interleaved extent */
+	uint32_t ie_nstrips;
+	uint32_t ie_chunk_size;
+	uint64_t ie_nbytes; /* Total bytes for this interleaved_ext;
+			     * sum of strips may be more
+			     */
+	uint64_t reserved;
+};
+
+struct fuse_famfs_fmap_header {
+	uint8_t file_type; /* enum famfs_file_type */
+	uint8_t reserved;
+	uint16_t fmap_version;
+	uint32_t ext_type; /* enum famfs_log_ext_type */
+	uint32_t nextents;
+	uint32_t reserved0;
+	uint64_t file_size;
+	uint64_t reserved1;
+};
+
+struct fuse_get_daxdev_in {
+	uint32_t        daxdev_num;
+};
+
+#define DAXDEV_NAME_MAX 256
+
+/* fuse_daxdev_out has enough space for a uuid if we need it */
+struct fuse_daxdev_out {
+	uint16_t index;
+	uint16_t reserved;
+	uint32_t reserved2;
+	uint64_t reserved3;
+	uint64_t reserved4;
+	char name[DAXDEV_NAME_MAX];
+};
+
+static __inline__ int32_t fmap_msg_min_size(void)
+{
+	/* Smallest fmap message is a header plus one simple extent */
+	return (sizeof(struct fuse_famfs_fmap_header)
+		+ sizeof(struct fuse_famfs_simple_ext));
+}
+
 #endif /* _LINUX_FUSE_H */
-- 
2.49.0


