Return-Path: <linux-fsdevel+bounces-76155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKReI2aXgWl/HAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:36:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36452D550B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D4AE3050960
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 06:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E05B392823;
	Tue,  3 Feb 2026 06:30:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A7A38B7D4;
	Tue,  3 Feb 2026 06:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770100227; cv=none; b=UGzpqxdPYG9/eh1Z4bJ3PeW2KOjpHtoNQW7I9obMLLVDhBz4yhhrpg5h/HF9X4Ck1o2/KkNmkKceo0NmfecL7WvSh7xIBd2Q15wfohxJjmsEYkiWRTH+1TFdYusPuTQrdKVBaDYHthxt6yabq3GGLmFCtn1bdPgPgZaxdqSpNyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770100227; c=relaxed/simple;
	bh=RlJROsKsuZ2IUY0rvdbWaYINjizodYjUAPp4dLBZuY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9LJlIxhDN0HOIEJIkRaLHuroUrnjDWdj45wTKsqEsxMvdefiLQ4NktFNsWod8XX15JuxBjFMy6Mtpya8I7qCCYMCHLgrTkgTb0YnM03lh12hjmeT8qKr7K8ocVX2kXy3FcjKExthx30ZhYaqCDtvxE25MI/Fxc96swN3PJtazk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f4tqr2LFMzYQv00;
	Tue,  3 Feb 2026 14:29:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4319E4056B;
	Tue,  3 Feb 2026 14:30:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgAHaPjnlYFpiadbGA--.27803S23;
	Tue, 03 Feb 2026 14:30:15 +0800 (CST)
From: Zhang Yi <yi.zhang@huawei.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yizhang089@gmail.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com,
	yukuai@fnnas.com
Subject: [PATCH -next v2 19/22] ext4: add block mapping tracepoints for iomap buffered I/O path
Date: Tue,  3 Feb 2026 14:25:19 +0800
Message-ID: <20260203062523.3869120-20-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203062523.3869120-1-yi.zhang@huawei.com>
References: <20260203062523.3869120-1-yi.zhang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHaPjnlYFpiadbGA--.27803S23
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4DXw48ur43Zr47KFWDCFg_yoWrJFyxpF
	yDtFy5GF4rZrsF9w4fWrW3Zr1Fva1xKr4UGry3Wry5JFWxtr42gF4UGFyYyFy5tw4jkryf
	XF4Yyry8G3W7urDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7Iv64x0x7Aq67IIx4CEVc8vx2IErcIFxwACI4
	02YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF
	04k20xvEw4C26cxK6c8Ij28IcwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZyC
	LUUUUU=
Sender: yi.zhang@huaweicloud.com
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,linux.ibm.com,gmail.com,infradead.org,kernel.org,huawei.com,huaweicloud.com,fnnas.com];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-76155-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@huawei.com,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 36452D550B
X-Rspamd-Action: no action

Add tracepoints for iomap buffered read, write, partial block zeroing
and writeback operations.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c             |  6 +++++
 include/trace/events/ext4.h | 45 +++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c59f3adba0f3..77dcca584153 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3956,6 +3956,8 @@ static int ext4_iomap_buffered_read_begin(struct inode *inode, loff_t offset,
 	if (ret < 0)
 		return ret;
 
+	trace_ext4_iomap_buffered_read_begin(inode, &map, offset, length,
+					     flags);
 	ext4_set_iomap(inode, iomap, &map, offset, length, flags);
 	return 0;
 }
@@ -4040,6 +4042,8 @@ static int ext4_iomap_buffered_do_write_begin(struct inode *inode,
 	if (ret < 0)
 		return ret;
 
+	trace_ext4_iomap_buffered_write_begin(inode, &map, offset, length,
+					      flags);
 	ext4_set_iomap(inode, iomap, &map, offset, length, flags);
 	return 0;
 }
@@ -4142,6 +4146,7 @@ static int ext4_iomap_zero_begin(struct inode *inode,
 			map.m_len = (offset >> blkbits) - map.m_lblk;
 	}
 
+	trace_ext4_iomap_zero_begin(inode, &map, offset, length, flags);
 	ext4_set_iomap(inode, iomap, &map, offset, length, flags);
 	iomap->flags |= iomap_flags;
 
@@ -4319,6 +4324,7 @@ static int ext4_iomap_map_writeback_range(struct iomap_writepage_ctx *wpc,
 	}
 out:
 	ewpc->data_seq = map.m_seq;
+	trace_ext4_iomap_map_writeback_range(inode, &map, offset, dirty_len, 0);
 	ext4_set_iomap(inode, &wpc->iomap, &map, offset, dirty_len, 0);
 	return 0;
 }
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index a3e8fe414df8..1922df4190e7 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -3096,6 +3096,51 @@ TRACE_EVENT(ext4_move_extent_exit,
 		  __entry->ret)
 );
 
+DECLARE_EVENT_CLASS(ext4_set_iomap_class,
+	TP_PROTO(struct inode *inode, struct ext4_map_blocks *map,
+		 loff_t offset, loff_t length, unsigned int flags),
+	TP_ARGS(inode, map, offset, length, flags),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(ino_t, ino)
+		__field(ext4_lblk_t, m_lblk)
+		__field(unsigned int, m_len)
+		__field(unsigned int, m_flags)
+		__field(u64, m_seq)
+		__field(loff_t, offset)
+		__field(loff_t, length)
+		__field(unsigned int, iomap_flags)
+	),
+	TP_fast_assign(
+		__entry->dev		= inode->i_sb->s_dev;
+		__entry->ino		= inode->i_ino;
+		__entry->m_lblk		= map->m_lblk;
+		__entry->m_len		= map->m_len;
+		__entry->m_flags	= map->m_flags;
+		__entry->m_seq		= map->m_seq;
+		__entry->offset		= offset;
+		__entry->length		= length;
+		__entry->iomap_flags	= flags;
+
+	),
+	TP_printk("dev %d:%d ino %lu m_lblk %u m_len %u m_flags %s m_seq %llu orig_off 0x%llx orig_len 0x%llx iomap_flags 0x%x",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino, __entry->m_lblk, __entry->m_len,
+		  show_mflags(__entry->m_flags), __entry->m_seq,
+		  __entry->offset, __entry->length, __entry->iomap_flags)
+)
+
+#define DEFINE_SET_IOMAP_EVENT(name) \
+DEFINE_EVENT(ext4_set_iomap_class, name, \
+	TP_PROTO(struct inode *inode, struct ext4_map_blocks *map, \
+		 loff_t offset, loff_t length, unsigned int flags), \
+	TP_ARGS(inode, map, offset, length, flags))
+
+DEFINE_SET_IOMAP_EVENT(ext4_iomap_buffered_read_begin);
+DEFINE_SET_IOMAP_EVENT(ext4_iomap_buffered_write_begin);
+DEFINE_SET_IOMAP_EVENT(ext4_iomap_map_writeback_range);
+DEFINE_SET_IOMAP_EVENT(ext4_iomap_zero_begin);
+
 #endif /* _TRACE_EXT4_H */
 
 /* This part must be outside protection */
-- 
2.52.0


