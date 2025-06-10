Return-Path: <linux-fsdevel+bounces-51199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BA6AD4440
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 22:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2119E3A5165
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 20:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F54267B87;
	Tue, 10 Jun 2025 20:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILXVzemp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C13266F05;
	Tue, 10 Jun 2025 20:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749589067; cv=none; b=Wa3cBI7dGTVFN6PWBmGcTVkBOzUXDnPd2GMzs0y6e39S+Vc6YZbFqwwWE/hEXLvYErufoQso5mbEQ4Bp98SkJOcozG10iQL1lpPvCP9ykSWrJ+e32NeZIN2zWiNr/SjsWopDSVnWTe0QvRbyKuw2DrAw3IAD95zU7kdieCiYSBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749589067; c=relaxed/simple;
	bh=TjC4455SbLexa7DQWrEx9iQXzGI/Y2o1DlLdfjD9Meg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LR/MMYZx+/iVkfvRmgLBCkGiN6SOtVF2NF3vWTQ0oa0ARpHzx+WpmnbaRij2SXyGJKNmxeWTvqfC6JPo4yObzEZbdGCNOa2JTYCf0ggZzer0PBJXOptZJ0ioPT5f9PfLgbBcLv+Br3h472BbON95fLB9uLL8CAOlPhRqIt62E1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILXVzemp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70015C4CEED;
	Tue, 10 Jun 2025 20:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749589066;
	bh=TjC4455SbLexa7DQWrEx9iQXzGI/Y2o1DlLdfjD9Meg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ILXVzemp4WSJyNro4r40cAQz+sLYwW4Yw85jntMd45Kzeh+0brNgmIJSvGWTEnM2n
	 xi7nMZnM+fLXomEf7SqEhffCWMWPqMmWJAKZ7TZiLwASAlNFMxw0zor5yy1CoP3N71
	 ckFox2bOTCzUQ95uy73+zn6zEbZF0yHYSup52Zoyn1tjLlBrMoGlf2XLTSA68+Lh1W
	 T7WyV+KT9v7Cdq/b5Cjq28L+oGASYRCsNTiSMzbCNQ1tYaY6ANJxTFcatju9kUyehj
	 YMxEpP6Fn8GC/5p2P63AYAt4chaqRdj5ooGbpxI7j3H43+9Ko3kEPUZ65jbQI3u2+X
	 FkG5SUAe4wnQg==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/6] NFSD: issue READs using O_DIRECT even if IO is misaligned
Date: Tue, 10 Jun 2025 16:57:37 -0400
Message-ID: <20250610205737.63343-7-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250610205737.63343-1-snitzer@kernel.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If enable-dontcache is used, expand any misaligned READ to the next
DIO-aligned block (on either end of the READ).

Reserve an extra page in svc_serv_maxpages() because nfsd_iter_read()
might need two extra pages when a READ payload is not DIO-aligned --
but nfsd_iter_read() and nfsd_splice_actor() are mutually exclusive
(so reuse page reserved for nfsd_splice_actor).

Also add nfsd_read_vector_dio trace event. This combination of
trace events is useful:

 echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_vector/enable
 echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_vector_dio/enable
 echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_io_done/enable
 echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_read/enable

Which for this dd command:

 dd if=/mnt/share1/test of=/dev/null bs=47008 count=2 iflag=direct

Results in:

 nfsd-16580   [001] .....  5672.403130: nfsd_read_vector_dio: xid=0x5ccf019c fh_hash=0xe4dadb60 offset=0 len=47008 start=0+0 end=47104-96
 nfsd-16580   [001] .....  5672.403131: nfsd_read_vector: xid=0x5ccf019c fh_hash=0xe4dadb60 offset=0 len=47104
 nfsd-16580   [001] .....  5672.403134: xfs_file_direct_read: dev 253:0 ino 0x1c2388c1 disize 0x16f40 pos 0x0 bytecount 0xb800
 nfsd-16580   [001] .....  5672.404380: nfsd_read_io_done: xid=0x5ccf019c fh_hash=0xe4dadb60 offset=0 len=47008

 nfsd-16580   [001] .....  5672.404672: nfsd_read_vector_dio: xid=0x5dcf019c fh_hash=0xe4dadb60 offset=47008 len=47008 start=46592+416 end=94208-192
 nfsd-16580   [001] .....  5672.404672: nfsd_read_vector: xid=0x5dcf019c fh_hash=0xe4dadb60 offset=46592 len=47616
 nfsd-16580   [001] .....  5672.404673: xfs_file_direct_read: dev 253:0 ino 0x1c2388c1 disize 0x16f40 pos 0xb600 bytecount 0xba00
 nfsd-16580   [001] .....  5672.405771: nfsd_read_io_done: xid=0x5dcf019c fh_hash=0xe4dadb60 offset=47008 len=47008

Suggested-by: Jeff Layton <jlayton@kernel.org>
Suggested-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/trace.h            | 37 ++++++++++++++++++++++
 fs/nfsd/vfs.c              | 65 ++++++++++++++++++++++++++++----------
 include/linux/sunrpc/svc.h |  5 ++-
 3 files changed, 90 insertions(+), 17 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 3c5505ef5e3a..a46515b953f4 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -473,6 +473,43 @@ DEFINE_NFSD_IO_EVENT(write_done);
 DEFINE_NFSD_IO_EVENT(commit_start);
 DEFINE_NFSD_IO_EVENT(commit_done);
 
+TRACE_EVENT(nfsd_read_vector_dio,
+	TP_PROTO(struct svc_rqst *rqstp,
+		 struct svc_fh	*fhp,
+		 u64		offset,
+		 u32		len,
+		 loff_t         start,
+		 loff_t         start_extra,
+		 loff_t         end,
+		 loff_t         end_extra),
+	TP_ARGS(rqstp, fhp, offset, len, start, start_extra, end, end_extra),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, fh_hash)
+		__field(u64, offset)
+		__field(u32, len)
+		__field(loff_t, start)
+		__field(loff_t, start_extra)
+		__field(loff_t, end)
+		__field(loff_t, end_extra)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+		__entry->offset = offset;
+		__entry->len = len;
+		__entry->start = start;
+		__entry->start_extra = start_extra;
+		__entry->end = end;
+		__entry->end_extra = end_extra;
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x offset=%llu len=%u start=%llu+%llu end=%llu-%llu",
+		  __entry->xid, __entry->fh_hash,
+		  __entry->offset, __entry->len,
+		  __entry->start, __entry->start_extra,
+		  __entry->end, __entry->end_extra)
+);
+
 DECLARE_EVENT_CLASS(nfsd_err_class,
 	TP_PROTO(struct svc_rqst *rqstp,
 		 struct svc_fh	*fhp,
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index a942609e3ab9..be5d025b4680 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -19,6 +19,7 @@
 #include <linux/splice.h>
 #include <linux/falloc.h>
 #include <linux/fcntl.h>
+#include <linux/math.h>
 #include <linux/namei.h>
 #include <linux/delay.h>
 #include <linux/fsnotify.h>
@@ -1101,15 +1102,41 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		      unsigned int base, u32 *eof)
 {
 	struct file *file = nf->nf_file;
-	unsigned long v, total;
+	unsigned long v, total, in_count = *count;
+	loff_t start_extra = 0, end_extra = 0;
 	struct iov_iter iter;
-	loff_t ppos = offset;
+	loff_t ppos;
 	rwf_t flags = 0;
 	ssize_t host_err;
 	size_t len;
 
+	/*
+	 * If dontcache enabled, expand any misaligned READ to
+	 * the next DIO-aligned block (on either end of the READ).
+	 */
+	if (nfsd_enable_dontcache && nf->nf_dio_mem_align &&
+	    (base & (nf->nf_dio_mem_align-1)) == 0) {
+		const u32 dio_blocksize = nf->nf_dio_read_offset_align;
+		loff_t orig_end = offset + *count;
+		loff_t start = round_down(offset, dio_blocksize);
+		loff_t end = round_up(orig_end, dio_blocksize);
+
+		WARN_ON_ONCE(dio_blocksize > PAGE_SIZE);
+		start_extra = offset - start;
+		end_extra = end - orig_end;
+
+		/* Show original offset and count, and how it was expanded for DIO */
+		trace_nfsd_read_vector_dio(rqstp, fhp, offset, *count,
+					   start, start_extra, end, end_extra);
+
+		/* trace_nfsd_read_vector() will reflect larger DIO-aligned READ */
+		offset = start;
+		in_count = end - start;
+		flags |= RWF_DIRECT;
+	}
+
 	v = 0;
-	total = *count;
+	total = in_count;
 	while (total) {
 		len = min_t(size_t, total, PAGE_SIZE - base);
 		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++),
@@ -1120,21 +1147,27 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 	WARN_ON_ONCE(v > rqstp->rq_maxpages);
 
-	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
-	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
-
-	if (nfsd_enable_dontcache) {
-		if (is_dio_aligned(&iter, offset, nf->nf_dio_read_offset_align))
-			flags |= RWF_DIRECT;
-		/* FIXME: not using RWF_DONTCACHE for misaligned IO because it works
-		 * against us (due to RMW needing to read without benefit of cache),
-		 * whereas buffered IO enables misaligned IO to be more performant.
-		 */
-		//else
-		//	flags |= RWF_DONTCACHE;
-	}
+	trace_nfsd_read_vector(rqstp, fhp, offset, in_count);
+	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, in_count);
 
+	ppos = offset;
 	host_err = vfs_iter_read(file, &iter, &ppos, flags);
+
+	if ((start_extra || end_extra) && host_err >= 0) {
+		rqstp->rq_bvec[0].bv_offset += start_extra;
+		rqstp->rq_bvec[0].bv_len -= start_extra;
+		rqstp->rq_bvec[v].bv_len -= end_extra;
+		/* Must adjust returned read size to reflect original extent */
+		offset += start_extra;
+		if (likely(host_err >= start_extra)) {
+			host_err -= start_extra;
+			if (host_err > *count)
+				host_err = *count;
+		} else {
+			/* Short read that didn't read any of requested data */
+			host_err = 0;
+		}
+	}
 	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
 }
 
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 46f7991cea58..52f5c9ec35aa 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -163,10 +163,13 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
  * pages, one for the request, and one for the reply.
  * nfsd_splice_actor() might need an extra page when a READ payload
  * is not page-aligned.
+ * nfsd_iter_read() might need two extra pages when a READ payload
+ * is not DIO-aligned -- but nfsd_iter_read() and nfsd_splice_actor()
+ * are mutually exclusive.
  */
 static inline unsigned long svc_serv_maxpages(const struct svc_serv *serv)
 {
-	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1;
+	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1 + 1;
 }
 
 /*
-- 
2.44.0


