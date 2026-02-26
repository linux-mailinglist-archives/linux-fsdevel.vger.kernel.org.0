Return-Path: <linux-fsdevel+bounces-78449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLsuGSEHoGl/fQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 09:41:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F431A2B38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 09:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0D5A300BC76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 08:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0210395259;
	Thu, 26 Feb 2026 08:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T5K+2bTN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E443395247
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772095253; cv=none; b=l0Ssj3eIa8mrU1OVwkQ3EXMTWv5kyLdvnpq3Wqy8FrOBvvG/Lb6c9nicm9m/ho+MtVdEajiaI+TQ/bZWAB1Bso5Nrychbo2e9PeyMSK6+9vL3DdYyiOIUBL6b9gy7YeB+roLR3oJZvKc8sOS/M+20uddkYuKPp6FUbZfaoMUBLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772095253; c=relaxed/simple;
	bh=dwrTDGeh95iZKaCEtAc0YWQ6wKjI5cJcO3Vg+xhvHkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S1gi8DWcEBAPgl6/dyw7RipFFdOwKqbSXuLybaRn+GZVl0/lQckuQ1lPVzVmP1LztRVayL9ZCpchJIVyWGCdBHOpYZQ4MlGrL+XKyCam8rrE2BkSwEEUVdJdk32TprIgMQpB+Idb6BgFC8Ux6ni6dIijkrjmO75fqtQPxg1PPC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T5K+2bTN; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772095248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r6ok+REfdEcAEOyYdN8mpwOjfAi6PmuRiNBeuWg5TUU=;
	b=T5K+2bTNXbyiZNubyfIgKzDWc7n++7B7nePN71sU4f09J1Z1zIXlbtNc+/wUPPFZr90CyP
	WGRtf1eL2ccboUEI1sH532tb4YN/k/NZBD/VWOkRmOeKLQR6AWkjAVuuyOzUIdv48y05/E
	r/+dWZ9KNUA0tglW3MTUw+5KWgo1dkU=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-mm@kvack.org
Cc: jiayuan.chen@linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+6880f676b265dbd42d63@syzkaller.appspotmail.com,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Jan Kara <jack@suse.cz>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntfs3@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1] mm: annotate data race of f_ra.prev_pos
Date: Thu, 26 Feb 2026 16:40:07 +0800
Message-ID: <20260226084020.163720-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-78449-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel,6880f676b265dbd42d63];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,syzkaller.appspot.com:url,shopee.com:email]
X-Rspamd-Queue-Id: 93F431A2B38
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

KCSAN reports a data race when concurrent readers access the same
struct file:

  BUG: KCSAN: data-race in filemap_read / filemap_splice_read

  write to 0xffff88811a6f8228 of 8 bytes by task 10061 on cpu 0:
   filemap_splice_read+0x523/0x780 mm/filemap.c:3125
   ...

  write to 0xffff88811a6f8228 of 8 bytes by task 10066 on cpu 1:
   filemap_read+0x98d/0xa10 mm/filemap.c:2873
   ...

Both filemap_read() and filemap_splice_read() update f_ra.prev_pos
without synchronization. This is a benign race since prev_pos is only
used as a hint for readahead heuristics in page_cache_sync_ra(), and a
stale or torn value merely results in a suboptimal readahead decision,
not a correctness issue.

Use WRITE_ONCE/READ_ONCE to annotate all accesses to prev_pos across
the tree for consistency and silence KCSAN.

Reported-by: syzbot+6880f676b265dbd42d63@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=6880f676b265dbd42d63
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 fs/ext4/dir.c                    | 2 +-
 fs/ntfs3/fsntfs.c                | 2 +-
 include/trace/events/readahead.h | 2 +-
 mm/filemap.c                     | 6 +++---
 mm/readahead.c                   | 4 ++--
 mm/shmem.c                       | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 28b2a3deb954..1ddf7acce5ca 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -200,7 +200,7 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 					sb->s_bdev->bd_mapping,
 					&file->f_ra, file, index,
 					1 << EXT4_SB(sb)->s_min_folio_order);
-			file->f_ra.prev_pos = (loff_t)index << PAGE_SHIFT;
+			WRITE_ONCE(file->f_ra.prev_pos, (loff_t)index << PAGE_SHIFT);
 			bh = ext4_bread(NULL, inode, map.m_lblk, 0);
 			if (IS_ERR(bh)) {
 				err = PTR_ERR(bh);
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 0df2aa81d884..d1232fc03c08 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1239,7 +1239,7 @@ int ntfs_read_run_nb_ra(struct ntfs_sb_info *sbi, const struct runs_tree *run,
 			if (!ra_has_index(ra, index)) {
 				page_cache_sync_readahead(mapping, ra, NULL,
 							  index, 1);
-				ra->prev_pos = (loff_t)index << PAGE_SHIFT;
+				WRITE_ONCE(ra->prev_pos, (loff_t)index << PAGE_SHIFT);
 			}
 		}
 
diff --git a/include/trace/events/readahead.h b/include/trace/events/readahead.h
index 0997ac5eceab..63d8df6c2983 100644
--- a/include/trace/events/readahead.h
+++ b/include/trace/events/readahead.h
@@ -101,7 +101,7 @@ DECLARE_EVENT_CLASS(page_cache_ra_op,
 		__entry->async_size = ra->async_size;
 		__entry->ra_pages = ra->ra_pages;
 		__entry->mmap_miss = ra->mmap_miss;
-		__entry->prev_pos = ra->prev_pos;
+		__entry->prev_pos = READ_ONCE(ra->prev_pos);
 		__entry->req_count = req_count;
 	),
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 63f256307fdd..d3e2d4b826b9 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2771,7 +2771,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 	int i, error = 0;
 	bool writably_mapped;
 	loff_t isize, end_offset;
-	loff_t last_pos = ra->prev_pos;
+	loff_t last_pos = READ_ONCE(ra->prev_pos);
 
 	if (unlikely(iocb->ki_pos < 0))
 		return -EINVAL;
@@ -2870,7 +2870,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 	} while (iov_iter_count(iter) && iocb->ki_pos < isize && !error);
 
 	file_accessed(filp);
-	ra->prev_pos = last_pos;
+	WRITE_ONCE(ra->prev_pos, last_pos);
 	return already_read ? already_read : error;
 }
 EXPORT_SYMBOL_GPL(filemap_read);
@@ -3122,7 +3122,7 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 			len -= n;
 			total_spliced += n;
 			*ppos += n;
-			in->f_ra.prev_pos = *ppos;
+			WRITE_ONCE(in->f_ra.prev_pos, *ppos);
 			if (pipe_is_full(pipe))
 				goto out;
 		}
diff --git a/mm/readahead.c b/mm/readahead.c
index 7b05082c89ea..de49b35b0329 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -142,7 +142,7 @@ void
 file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
 {
 	ra->ra_pages = inode_to_bdi(mapping->host)->ra_pages;
-	ra->prev_pos = -1;
+	WRITE_ONCE(ra->prev_pos, -1);
 }
 EXPORT_SYMBOL_GPL(file_ra_state_init);
 
@@ -584,7 +584,7 @@ void page_cache_sync_ra(struct readahead_control *ractl,
 	}
 
 	max_pages = ractl_max_pages(ractl, req_count);
-	prev_index = (unsigned long long)ra->prev_pos >> PAGE_SHIFT;
+	prev_index = (unsigned long long)READ_ONCE(ra->prev_pos) >> PAGE_SHIFT;
 	/*
 	 * A start of file, oversized read, or sequential cache miss:
 	 * trivial case: (index - prev_index) == 1
diff --git a/mm/shmem.c b/mm/shmem.c
index 5e7dcf5bc5d3..03569199baf4 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3642,7 +3642,7 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
 		len -= n;
 		total_spliced += n;
 		*ppos += n;
-		in->f_ra.prev_pos = *ppos;
+		WRITE_ONCE(in->f_ra.prev_pos, *ppos);
 		if (pipe_is_full(pipe))
 			break;
 
-- 
2.43.0


