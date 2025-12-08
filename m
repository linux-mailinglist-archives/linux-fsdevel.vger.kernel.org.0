Return-Path: <linux-fsdevel+bounces-70977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AA3CAE066
	for <lists+linux-fsdevel@lfdr.de>; Mon, 08 Dec 2025 19:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 204A1301EDD6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Dec 2025 18:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8E22BEC28;
	Mon,  8 Dec 2025 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJgU8aXl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSZRDdQZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC62C1E51E0
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Dec 2025 18:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765219729; cv=none; b=jLTv/s/B4ZSbY59vcymGIMC+8AFIDTNScpMYggWPHiCTzAD9026K81lER5HlxCz4GFrfS77tUOBHWWLCay9MEkC/HA73ICCalUNb6TT0KZXydTkxjBkzm4R86KoiArJb6ckgenKEiU5dX56g5xVmRpzWi124lwOo/7flAJaeTtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765219729; c=relaxed/simple;
	bh=uL8MklYiIuc/c3jR+rO3/595sE8HkECV2Mdcf0+gr5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KEP5nrdenlKEUFK0AJuJhiyr7vX1HuO+eHhdvM6JBeLYq2kcCYKMq2DsDbsNMBfohpn52q6D6JT3GdkyPZg2xxju6neK86jfu336kyAjpVF22wUh5UGOJ+bTR/tK9wxfdlyzBvS94m0Cu9Jc7fTXu26HK5EHv/hVycnvvCL67FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hJgU8aXl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fSZRDdQZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765219726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h1R3Yr2a3oOfgX7ss1REjahyyeDQP27kHipQkKLgF34=;
	b=hJgU8aXlqY+9f+U0vAyq7vEyAXaGZlR5I3B4xrzmAI36aVX0zg53HWNjM2DwOI6fKAvjiM
	DjX2Qoib9XnYoUKob1RnqZAhtnWrad9x1iObzEE47ki7cMejHc+3vN0qAWWdQqM8/CLJ5e
	fDjKIPg9lBqZtpiPOJgtY6h6VOO86PA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-kpy4qn16OlW8wzJ6nYRnwQ-1; Mon, 08 Dec 2025 13:48:45 -0500
X-MC-Unique: kpy4qn16OlW8wzJ6nYRnwQ-1
X-Mimecast-MFC-AGG-ID: kpy4qn16OlW8wzJ6nYRnwQ_1765219725
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-298535ef0ccso22190795ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Dec 2025 10:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765219724; x=1765824524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h1R3Yr2a3oOfgX7ss1REjahyyeDQP27kHipQkKLgF34=;
        b=fSZRDdQZ/ORtSFzaWzb2hpyhN+eMnhKA/u6ataIxxSyzI6RlAeJyRfKkdWbHZrSnHN
         LhWkQzzGTAjqagCh4tX1zEp4d7GJQBdfVlLWBwfgxF0q+o/6d1VFWjp9DcgGkgZNX7wC
         B4ZMrV9xaHHd2kelQ9TdhQdC0ruuaq/C9kF0E4WKoFXql+GJGGvqcgMTYAs203twq64/
         VebSwf4MhhqyOfNARS/9hAXZlRMceeMF5d0/fXDAWDPGtmtU3NDsYquT3Vn+g7AlPs0x
         lzIlc7eHqwbAwEE4Yz0zfhN+xtHg9rpwxUywYK7TOipiAuNWpROAy7njZ9rgu66yK8mu
         Qfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765219724; x=1765824524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1R3Yr2a3oOfgX7ss1REjahyyeDQP27kHipQkKLgF34=;
        b=H48oPEI2aGprxG9c22e+fh5VdmTcfzhdDnsCYmXKCWl5vClcWnKhTHTL6RNQ2dXRMY
         lpdhtjsuv/deGLK8nT3fIx/o6W8hoPSv8xtdFVf73zsNHMLQg8TQl9dka7cvHs3CwXj9
         cuVjVBL7QWJGSPDb6Ixf1yAtYyUzqpF0YcKLHsTEGogJHLqElKSL1Ale9z74CeYS5ZeM
         0Ksh+KjLIMqUjwrWeYZXJWkar5hQn8lfCldtAA/J3F26phff+w+6ip8lH8lgtVQ1sHlS
         5KwGlBGnV5HvV+vN2Nr4xOyMnUs7vFoNO1dUSigdr1YUp6XluusneQcnMN/fG0Ir+0zf
         a7fw==
X-Forwarded-Encrypted: i=1; AJvYcCWB9gUmJoUfAsuQlMg4QF4jwtVQvR7/AbSjpZlGHysAMXc3jB4eX75AqFvQd3EjQZ/ji9aSuaISiNA+xiW0@vger.kernel.org
X-Gm-Message-State: AOJu0YzovCPfcIbtfPXq4VSjSsqygivcMh+3fq3wvnfH13X+ggInIVo3
	BpngMSHmPZyiWRNTPFDmlbV1YlAA0cpnEnN2diNDq4oo7zBo+l83fHxckplCU9D1Mippy+GSyRy
	B05GGVLUgC8RD912n9YoXxek+BPcqhP5O3aoZ3IIGOed4UO8VDAC9kh0BGOpyfhRPCUZk0U2dRv
	/Q
X-Gm-Gg: ASbGncs9CH7GwH5FBEzY2wcUsUqZWIBcaIhvpGFyrMFE9V3evASvQqgupJ6wnGjQ8hR
	Yq3hvND6jHx3hMEkPLCkwXGDi1tBalc95WmWJiOxNbq8D7Wjx8Yqg775pIcEcQPddKCJ2aCLSOk
	Bd7qIuHj+BKEcF57Per7I59YQfbEwQmoiZBRw3OKfkCiWg1CpKCK8ERYVRCJIFSomQ80vIeBoUX
	VP1X4JHEBQt7fPxaDCkq0Bo4D9N/XUFYtdt3scsHHaCqoPd1C67x7iTLDE1cMlBgKg4X/e0ZdG1
	cwcZt9sbQ1jRX8wxOfUbLMYFCarVTQm2ajOV6/sRw1/k3ZPCUmNV2M1C4ecjoL5F99XV0G4zc1+
	L0vlqsDpbXCpxQ5yk1QkT7VpXniYJds7HH6/QVw==
X-Received: by 2002:a05:6a20:7283:b0:363:819f:4962 with SMTP id adf61e73a8af0-36618164a7amr8848470637.40.1765219724073;
        Mon, 08 Dec 2025 10:48:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWyIr86JYQPxT5xn/4CPk5SaKSoq5UZgYSwhtzIMCxOKYzrI2S+Nb6uYNMu0pMo1X/14U5zg==
X-Received: by 2002:a05:6a20:7283:b0:363:819f:4962 with SMTP id adf61e73a8af0-36618164a7amr8848450637.40.1765219723624;
        Mon, 08 Dec 2025 10:48:43 -0800 (PST)
Received: from dkarn-thinkpadp16vgen1.punetw6.csb ([2402:e280:3e0d:a45:335a:59cd:dd80:b6bf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34a47aa570fsm48184a91.0.2025.12.08.10.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 10:48:43 -0800 (PST)
From: Deepakkumar Karn <dkarn@redhat.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+e07658f51ca22ab65b4e@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	Deepakkumar Karn <dkarn@redhat.com>
Subject: [PATCH] fs: add NULL check in drop_buffers() to prevent null-ptr-deref
Date: Tue,  9 Dec 2025 00:18:07 +0530
Message-ID: <20251208184807.514738-1-dkarn@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drop_buffers() dereferences the buffer_head pointer returned by
folio_buffers() without checking for NULL. This leads to a null pointer
dereference when called from try_to_free_buffers() on a folio with no
buffers attached. This happens when filemap_release_folio() is called on
a folio belonging to a mapping with AS_RELEASE_ALWAYS set but without
release_folio address_space operation defined. In such case,
folio_needs_release() returns true because of AS_RELEASE_ALWAYS flag,
the folio has no private buffer data, causing the try_to_free_buffers()
with a folio that has no buffers.

Adding NULL check for the buffer_head pointer and return false early if
no buffers are attached to the folio.

Reported-by: syzbot+e07658f51ca22ab65b4e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e07658f51ca22ab65b4e
Fixes: 6439476311a6 ("fs: Convert drop_buffers() to use a folio")
Signed-off-by: Deepakkumar Karn <dkarn@redhat.com>
---
 fs/buffer.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 838c0c571022..170d15a05d2d 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -480,7 +480,7 @@ EXPORT_SYMBOL(mark_buffer_async_write);
  * try_to_free_buffers() will be operating against the *blockdev* mapping
  * at the time, not against the S_ISREG file which depends on those buffers.
  * So the locking for i_private_list is via the i_private_lock in the address_space
- * which backs the buffers.  Which is different from the address_space 
+ * which backs the buffers.  Which is different from the address_space
  * against which the buffers are listed.  So for a particular address_space,
  * mapping->i_private_lock does *not* protect mapping->i_private_list!  In fact,
  * mapping->i_private_list will always be protected by the backing blockdev's
@@ -771,7 +771,7 @@ EXPORT_SYMBOL(block_dirty_folio);
  * Do this in two main stages: first we copy dirty buffers to a
  * temporary inode list, queueing the writes as we go.  Then we clean
  * up, waiting for those writes to complete.
- * 
+ *
  * During this second stage, any subsequent updates to the file may end
  * up refiling the buffer on the original inode's dirty list again, so
  * there is a chance we will end up with a buffer queued for write but
@@ -848,7 +848,7 @@ static int fsync_buffers_list(spinlock_t *lock, struct list_head *list)
 		brelse(bh);
 		spin_lock(lock);
 	}
-	
+
 	spin_unlock(lock);
 	err2 = osync_buffers_list(lock, list);
 	if (err)
@@ -1000,7 +1000,7 @@ static sector_t blkdev_max_block(struct block_device *bdev, unsigned int size)
 
 /*
  * Initialise the state of a blockdev folio's buffers.
- */ 
+ */
 static sector_t folio_init_buffers(struct folio *folio,
 		struct block_device *bdev, unsigned size)
 {
@@ -1546,7 +1546,7 @@ bool has_bh_in_lru(int cpu, void *dummy)
 {
 	struct bh_lru *b = per_cpu_ptr(&bh_lrus, cpu);
 	int i;
-	
+
 	for (i = 0; i < BH_LRU_SIZE; i++) {
 		if (b->bhs[i])
 			return true;
@@ -2166,7 +2166,7 @@ int __block_write_begin_int(struct folio *folio, loff_t pos, unsigned len,
 		if (folio_test_uptodate(folio)) {
 			if (!buffer_uptodate(bh))
 				set_buffer_uptodate(bh);
-			continue; 
+			continue;
 		}
 		if (!buffer_uptodate(bh) && !buffer_delay(bh) &&
 		    !buffer_unwritten(bh) &&
@@ -2468,7 +2468,7 @@ EXPORT_SYMBOL(block_read_full_folio);
 
 /* utility function for filesystems that need to do work on expanding
  * truncates.  Uses filesystem pagecache writes to allow the filesystem to
- * deal with the hole.  
+ * deal with the hole.
  */
 int generic_cont_expand_simple(struct inode *inode, loff_t size)
 {
@@ -2893,6 +2893,10 @@ drop_buffers(struct folio *folio, struct buffer_head **buffers_to_free)
 	struct buffer_head *head = folio_buffers(folio);
 	struct buffer_head *bh;
 
+	/* In cases of folio without buffer_head*/
+	if (!head)
+		return false;
+
 	bh = head;
 	do {
 		if (buffer_busy(bh))
-- 
2.52.0


