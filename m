Return-Path: <linux-fsdevel+bounces-63524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7D3BC0114
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 05:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 248A23AF5B6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 03:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9787D1FF1BF;
	Tue,  7 Oct 2025 03:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZIk8Bko6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZIk8Bko6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E7819D074
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Oct 2025 03:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759806647; cv=none; b=WW2sm66aeBYWcbDJSl3hNSGGFxwZcczAg1n4PkyDHrchUX5RYv9wZw4qtejzCdZb6AOuca7qTQ6YXTQqnzRI6t/4eRg1s5I2T4LFFWTXvJp7h1pc4aRlxTTUiTtqGcaeP/AqIgtidQBnKFIJ6o3h8BGzVsl1jtuDNLXVo/LBnQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759806647; c=relaxed/simple;
	bh=S2jWdqO7Lz5fBdIy9JnolT2heuF4T2L+DdOVQVL5wqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jthHzptmmZ+t4e65Z9cDJqwnDZRQ5nvYjJieeA6na+uhVX5/Vk8/QVKNQe2ldzMA7jt3RoyWhWdZn2Bjs0LsqSjI2X1Dm6vM9ebY8jLL8L2PXRG2fi+8mGtca1I+qlkOhih8fnmL0wGDKYGCeJxQ9fe9MlznQ02N9OdNnRuaPNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZIk8Bko6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZIk8Bko6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 264631F451;
	Tue,  7 Oct 2025 03:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759806643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TDEYSBRyOdxyC8QUhZcCBDBzgdxPtA72jaHQLbpqegM=;
	b=ZIk8Bko6e2j17UkakNTwN19ZWT7yP/IUIX6rqixA0YBCBxX/kah1w2bcn1FKJkOSVnHDT5
	zmiMlgoRpFx9GX9REwYAsu5oQp8anMsYQTiSuL+SUWb2tf6sVg76f9j00nvbM16BItuATU
	8sipg/6+ek9QyDTXTXf67nxM5RKKUSU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759806643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TDEYSBRyOdxyC8QUhZcCBDBzgdxPtA72jaHQLbpqegM=;
	b=ZIk8Bko6e2j17UkakNTwN19ZWT7yP/IUIX6rqixA0YBCBxX/kah1w2bcn1FKJkOSVnHDT5
	zmiMlgoRpFx9GX9REwYAsu5oQp8anMsYQTiSuL+SUWb2tf6sVg76f9j00nvbM16BItuATU
	8sipg/6+ek9QyDTXTXf67nxM5RKKUSU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EC7513693;
	Tue,  7 Oct 2025 03:10:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FV+PK7CE5GhiZQAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 07 Oct 2025 03:10:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: brauner@kernel.org,
	djwong@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC] iomap: ensure iomap_dio_bio_iter() only submit bios that are fs block aligned
Date: Tue,  7 Oct 2025 13:40:22 +1030
Message-ID: <aeed3476f7cff20c59172f790167b5879f5fec87.1759806405.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

[ASSERT TRIGGERED]
During my development of btrfs bs > ps support, I hit some read bios
that are submitted from iomap to btrfs, but are not aligned to fs block
size.

In my case the fs block size is 8K, the page size is 4K. The ASSERT()
looks like this:

 assertion failed: IS_ALIGNED(logical, blocksize) && IS_ALIGNED(length, blocksize) && length != 0 :: 0, in fs/btrfs/bio.c:833 (root=256 inode=260 logical=299360256 length=69632)
 ------------[ cut here ]------------
 kernel BUG at fs/btrfs/bio.c:833!
 Oops: invalid opcode: 0000 [#1] SMP
 CPU: 6 UID: 0 PID: 1153 Comm: fsstress Tainted: G            E       6.17.0-rc7-custom+ #291 PREEMPT(full)  be3ff76d2e76a554af2cfea604366d16e719ba97
 Tainted: [E]=UNSIGNED_MODULE
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
 RIP: 0010:btrfs_submit_bbio.cold+0x10c/0x127 [btrfs]
 Call Trace:
  <TASK>
  iomap_dio_bio_iter+0x1d3/0x570
  __iomap_dio_rw+0x547/0x8e0
  iomap_dio_rw+0x12/0x30
  btrfs_direct_read+0x135/0x220 [btrfs 24de5898492ba42c5e58573a6f20bf3c9894c726]
  btrfs_file_read_iter+0x21/0x70 [btrfs 24de5898492ba42c5e58573a6f20bf3c9894c726]
  vfs_read+0x25e/0x380
  ksys_read+0x73/0xe0
  do_syscall_64+0x82/0xae0
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
 Dumping ftrace buffer:
 ---------------------------------
 fsstress-1153      6..... 68530us : iomap_dio_bio_iter: length=81920 nr_pages=20 enter
 fsstress-1153      6..... 68539us : iomap_dio_bio_iter: length=81920 realsize=69632
 fsstress-1153      6..... 68540us : iomap_dio_bio_iter: nr_pages=3 for next
 ---------------------------------

[CAUSE]
The function iomap_dio_bio_iter() is doing the bio assembly and
submission, and it's calling bio_iov_iter_get_pages().

However that function can split the range, and in my case it split the
original 20 pages range into two ranges, with 17 and 3 pages for each.

Then the 17 pages range is passed to btrfs_dio_submit_io(), which later
calls into assert_bbio_alignment() and triggered the ASSERT() on fs
block size check.

This check is critical as btrfs needs to verify the data checksum at
read time and retry other mirrors when necessary.

If a sub-block range is passed in the read-verification and read-repair
functionality is lost.

This is never a problem for btrfs in the past, just because we do not
have the support for bs > ps cases.

And this is also not a problem for fses using iomap, because there is no
data checksum support.

[ENHANCEMENT]
Just follow what bcachefs is doing, check the bio size and revert the bio
to the fs boundary.

If after revert the bio is empty, we have to error out because we can
not fault in enough pages to fill a fs block.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Reason for RFC:

This change is forcing all fses using iomap to revert the iov iter each
time an unaligned range hit, even if the fs doesn't need to (e.g. no
data checksum requirement).

I'm not sure if the cost is acceptable or even necessary.

If the extra cost is not acceptable, I can add a new
iomap_dio_ops::need_strong_alignment() callback so that only btrfs will
do the revert.

 fs/iomap/direct-io.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index b84f6af2eb4c..f08babe7c83f 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -419,6 +419,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
 	do {
 		size_t n;
+		size_t unaligned;
 		if (dio->error) {
 			iov_iter_revert(dio->submit.iter, copied);
 			copied = ret = 0;
@@ -444,9 +445,26 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 			 */
 			bio_put(bio);
 			goto zero_tail;
+
 		}
 
+		/*
+		 * bio_iov_iter_get_pages() can split the ranges at page boundary,
+		 * if the fs has block size > page size and requires checksum,
+		 * such unaligned bio will cause problems.
+		 * Revert back to the fs block boundary.
+		 */
+		unaligned = bio->bi_iter.bi_size & (fs_block_size - 1);
+		bio->bi_iter.bi_size -= unaligned;
+		iov_iter_revert(dio->submit.iter, unaligned);
 		n = bio->bi_iter.bi_size;
+
+		/* Failed to get any aligned range. */
+		if (unlikely(n == 0)) {
+			bio_put(bio);
+			ret = -EFAULT;
+			goto zero_tail;
+		}
 		if (WARN_ON_ONCE((bio_opf & REQ_ATOMIC) && n != length)) {
 			/*
 			 * An atomic write bio must cover the complete length,
-- 
2.50.1


