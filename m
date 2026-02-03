Return-Path: <linux-fsdevel+bounces-76153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP99OjaYgWl/HAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:39:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AB1D5616
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 352AF313F2E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 06:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4E438F95D;
	Tue,  3 Feb 2026 06:30:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6A3217F33;
	Tue,  3 Feb 2026 06:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770100226; cv=none; b=u4ZrNrT/J/Rgc4lWoctJ1nz4ZSt/4FsNvDjb8eOpURGbsJhhAaeZea+KKalUzPPD5Tp8SPjvrckL30eeAUnGPseFa3yLbaA2MNETScdntEKytQD/XLQJofy2k7HCYI6BHTap7Mx0i+uAlyhHlJs9iH8E2tq0j8AanxQg1Saowtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770100226; c=relaxed/simple;
	bh=sdjhgFitvoj93jiAlBSeBXFFj/fozLH8/bgWeU3UPS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YaGyzDqK0k4S4T2YtqF9nGOPehi+2WQbpDoHjaOjjcYNnB+ho5yyyTKX2737ZHloSohawCFtxbezOLsuysUCuDuKGODVpY5aWHRP7/Q2kycS0EGKcx+l52kM0RnMi+5Qzr1eDkGKKdTZquEfq0vJCSsV8tWs94H7RuXtkx6Y4do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f4tqr0nNYzYQtyn;
	Tue,  3 Feb 2026 14:29:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0D1FE40575;
	Tue,  3 Feb 2026 14:30:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgAHaPjnlYFpiadbGA--.27803S20;
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
Subject: [PATCH -next v2 16/22] iomap: support invalidating partial folios
Date: Tue,  3 Feb 2026 14:25:16 +0800
Message-ID: <20260203062523.3869120-17-yi.zhang@huawei.com>
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
X-CM-TRANSID:gCh0CgAHaPjnlYFpiadbGA--.27803S20
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1xtrW5Jw48tw18Kr4fAFb_yoW8Aw4kpF
	W5KrWDGryDGr17uw17Ca1xZF1j9a93XF17CFW3Ww1a9Fs8tw1vgFy5Ka1Y9ayUAr97AFyS
	vrsFqFyvqF15A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,linux.ibm.com,gmail.com,infradead.org,kernel.org,huawei.com,huaweicloud.com,fnnas.com];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-76153-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@huawei.com,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A5AB1D5616
X-Rspamd-Action: no action

Current iomap_invalidate_folio() can only invalidate an entire folio. If
we truncate a partial folio on a filesystem where the block size is
smaller than the folio size, it will leave behind dirty bits from the
truncated or punched blocks. During the write-back process, it will
attempt to map the invalid hole range. Fortunately, this has not
caused any real problems so far because the ->writeback_range() function
corrects the length.

However, the implementation of FALLOC_FL_ZERO_RANGE in ext4 depends on
the support for invalidating partial folios. When ext4 partially zeroes
out a dirty and unwritten folio, it does not perform a flush first like
XFS. Therefore, if the dirty bits of the corresponding area cannot be
cleared, the zeroed area after writeback remains in the written state
rather than reverting to the unwritten state. Therefore, fix this by
supporting invalidating partial folios.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
This is cherry picked form:
 https://lore.kernel.org/linux-fsdevel/20240812121159.3775074-3-yi.zhang@huaweicloud.com/
No code changes, only update the commit message to explain why Ext4
needs this.

 fs/iomap/buffered-io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3c8e085e79cf..d4dd1874a471 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -744,6 +744,8 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
 		WARN_ON_ONCE(folio_test_writeback(folio));
 		folio_cancel_dirty(folio);
 		ifs_free(folio);
+	} else {
+		iomap_clear_range_dirty(folio, offset, len);
 	}
 }
 EXPORT_SYMBOL_GPL(iomap_invalidate_folio);
-- 
2.52.0


