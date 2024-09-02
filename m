Return-Path: <linux-fsdevel+bounces-28270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C01B968C5C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 18:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03FE1C20B44
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 16:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881891AB6F6;
	Mon,  2 Sep 2024 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="oPQnB+hq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E1D1AB6D0;
	Mon,  2 Sep 2024 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725295601; cv=none; b=ArYdKjRtG8Gc+BPizAjm7yZ6NpG4Q8xRLsk9owLXRmCZPnZewPC+/fgDqUtRkgXtjDWfizDtQEzm5daAbGCibcx4raSbal6ROrMPXSgGon0Cd7TVeDV1zCF6kFTxaU5w7EZ6Xr7e4hFLe94ZD2JWLbPDAeHyEZr/GXvsGbtZ6EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725295601; c=relaxed/simple;
	bh=2JEtkyYBzbNUNWYD6K3reCmf/PfliNsGWxt62ICcuOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VcdnAuD9ZWoiPALu6yGmuctzK3/nU0UWigeP5xHSdK4nk+1g7+cVpcKe/VWdnbltmHVRethqlbu0axhtUZk1/YNl05xcfY7xnVP5S0SmNcEw2eiufxvJ2GtBgunx51dd7ySxdw+wnwlx3pOZ0MNpXX+9ptRfN0OafYHhBjP9ToI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=oPQnB+hq; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WyF5L1kQqz9tqL;
	Mon,  2 Sep 2024 18:46:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725295590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DYW8e2RAgi5MkOkqfurv6e1luZxwkEFySGMNtg8Nzlo=;
	b=oPQnB+hqa7XH5g9+gr6LNTU20LJqEkqpeyTK30MGGwRdEzKbVOpOAmNhhxrqJbO/UyXT2P
	GDQSz1ZtpmPJAQSbpR6gsfBGdGnenHUxjxCTIMn+dkByq8f8I2iITdoR6L8oJn9ReDYrij
	jg5HW040NxkE3/t5/p68SIPlJ8arf5Iut5uoBZnho3NCut3SZvYZ/xs6ZqqDQ30KuCPqAV
	cZsRtiHdPXMFu5dkGfuqT4Hp4mzYM+sAOadY2yHJLjB0kwllmri5HCSwioall5AH+LIlzq
	pcGEsJFvlFRgcSNiInvFTo1VZhXZ9C1A+dTjE7xTLKVW8xEgxtsj53YyVPf10w==
From: Aleksa Sarai <cyphar@cyphar.com>
To: fstests@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Christoph Hellwig <hch@infradead.org>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH xfstests v2 1/2] statx: update headers to include newer statx fields
Date: Tue,  3 Sep 2024 02:45:53 +1000
Message-ID: <20240902164554.928371-1-cyphar@cyphar.com>
In-Reply-To: <20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com>
References: <20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These come from Linux v6.11-rc5.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 src/open_by_handle.c |  4 +++-
 src/statx.h          | 22 ++++++++++++++++++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/src/open_by_handle.c b/src/open_by_handle.c
index 0f74ed08b1f0..d9c802ca9bd1 100644
--- a/src/open_by_handle.c
+++ b/src/open_by_handle.c
@@ -82,12 +82,14 @@ Examples:
 #include <string.h>
 #include <fcntl.h>
 #include <unistd.h>
-#include <sys/stat.h>
 #include <sys/types.h>
 #include <errno.h>
 #include <linux/limits.h>
 #include <libgen.h>
 
+#include <sys/stat.h>
+#include "statx.h"
+
 #define MAXFILES 1024
 
 struct handle {
diff --git a/src/statx.h b/src/statx.h
index 3f239d791dfe..935cb2ed415e 100644
--- a/src/statx.h
+++ b/src/statx.h
@@ -102,7 +102,7 @@ struct statx {
 	__u64	stx_ino;	/* Inode number */
 	__u64	stx_size;	/* File size */
 	__u64	stx_blocks;	/* Number of 512-byte blocks allocated */
-	__u64	__spare1[1];
+	__u64	stx_attributes_mask; /* Mask to show what's supported in stx_attributes */
 	/* 0x40 */
 	struct statx_timestamp	stx_atime;	/* Last access time */
 	struct statx_timestamp	stx_btime;	/* File creation time */
@@ -114,7 +114,18 @@ struct statx {
 	__u32	stx_dev_major;	/* ID of device containing file [uncond] */
 	__u32	stx_dev_minor;
 	/* 0x90 */
-	__u64	__spare2[14];	/* Spare space for future expansion */
+	__u64	stx_mnt_id;
+	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
+	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
+	/* 0xa0 */
+	__u64	stx_subvol;	/* Subvolume identifier */
+	__u32	stx_atomic_write_unit_min;	/* Min atomic write unit in bytes */
+	__u32	stx_atomic_write_unit_max;	/* Max atomic write unit in bytes */
+	/* 0xb0 */
+	__u32   stx_atomic_write_segments_max;	/* Max atomic write segment count */
+	__u32   __spare1[1];
+	/* 0xb8 */
+	__u64	__spare3[9];	/* Spare space for future expansion */
 	/* 0x100 */
 };
 
@@ -139,6 +150,13 @@ struct statx {
 #define STATX_BLOCKS		0x00000400U	/* Want/got stx_blocks */
 #define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the normal stat struct */
 #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
+#define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
+#define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
+#define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
+#define STATX_SUBVOL		0x00008000U	/* Want/got stx_subvol */
+#define STATX_WRITE_ATOMIC	0x00010000U	/* Want/got atomic_write_* fields */
+
+#define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 #define STATX_ALL		0x00000fffU	/* All currently supported flags */
 
 /*
-- 
2.46.0


