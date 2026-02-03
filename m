Return-Path: <linux-fsdevel+bounces-76145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI0LBIiXgWmkHgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:36:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1ECD553E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29DC3303B70B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 06:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB1737C0F9;
	Tue,  3 Feb 2026 06:30:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DD9387593;
	Tue,  3 Feb 2026 06:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770100224; cv=none; b=mI/IKSdR8NkasQ3jUbcJ2TKDqGtzpZlootz5RdvOZQhaBOhdgAAWjSu6u3BX1C+a11dYLiEIP3Z9Sk9UL12DZujoc5WIZC3PvGHyQqgcTc5PtfP6oLvpfO6l8DSrJrf0F//l05Oow4xe/+wM2GtQagIKLmTZ8G5zxlSRQ/XBYaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770100224; c=relaxed/simple;
	bh=81fBNYVwZyhqpSP9hm1l5AESEUnNUjgm5eH549AHHeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mv1bWYYeO/6ELeg+oqMQTv+1y379ibAbulMLHYUAR1W5ytPsAqI0BETy3l9Dlxe19d7PYjfVmxw76T/iSPm6LjObDX8E3I8bFAxOZr7o6wgG89qaPIc+H5AMCrByM7pmhEfn4kpOeRElTbjTWxXNk0Eyit1xzOifL+LosFb71Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4f4trK6GNxzKHMck;
	Tue,  3 Feb 2026 14:29:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 333EC4058C;
	Tue,  3 Feb 2026 14:30:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgAHaPjnlYFpiadbGA--.27803S22;
	Tue, 03 Feb 2026 14:30:14 +0800 (CST)
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
Subject: [PATCH -next v2 18/22] ext4: do not order data for inodes using buffered iomap path
Date: Tue,  3 Feb 2026 14:25:18 +0800
Message-ID: <20260203062523.3869120-19-yi.zhang@huawei.com>
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
X-CM-TRANSID:gCh0CgAHaPjnlYFpiadbGA--.27803S22
X-Coremail-Antispam: 1UD129KBjvdXoWrKF4kJw45uryrtF1rKFWrGrg_yoWkJwc_XF
	yv9r4jq34avFn7uFWrGF15JasFyr48WryruFykKw4F9ryDtrsrZr1DAwsrAryDWF40kFnx
	Cr48Wr4rCw1xXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbL8YFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
	0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjsIEF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI
	8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxAI
	w28IcVAKzI0EY4vE52x082I5MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1-zst
	UUUUU==
Sender: yi.zhang@huaweicloud.com
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,linux.ibm.com,gmail.com,infradead.org,kernel.org,huawei.com,huaweicloud.com,fnnas.com];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-76145-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@huawei.com,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D1ECD553E
X-Rspamd-Action: no action

In the iomap buffered I/O path, we always allocate unwritten blocks when
doing append write, and flush data when doing partial block truncate
down. Therefore, there is no risk of exposing stale data, disable
ordered data mode for the iomap buffered I/O path.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4_jbd2.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 63d17c5201b5..7061c7188053 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -383,7 +383,12 @@ static inline int ext4_should_journal_data(struct inode *inode)
 
 static inline int ext4_should_order_data(struct inode *inode)
 {
-	return ext4_inode_journal_mode(inode) & EXT4_INODE_ORDERED_DATA_MODE;
+	/*
+	 * inodes using the iomap buffered I/O path do not use the
+	 * ordered data mode.
+	 */
+	return !ext4_inode_buffered_iomap(inode) &&
+		(ext4_inode_journal_mode(inode) & EXT4_INODE_ORDERED_DATA_MODE);
 }
 
 static inline int ext4_should_writeback_data(struct inode *inode)
-- 
2.52.0


