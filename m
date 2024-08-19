Return-Path: <linux-fsdevel+bounces-26223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C06956344
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 07:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0B428113A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 05:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3C8156649;
	Mon, 19 Aug 2024 05:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ebJrfH3z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dfHEv6A2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="glfVZhvJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="egZTwQoV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD8014BF97;
	Mon, 19 Aug 2024 05:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724045813; cv=none; b=LrpReiR2AyyV8jNzO/mJ185UVxf0evBjUOZpoFpsxChodqwcYn4gnP33QzFLlj7laIgVMKGk5JGk5u2HHxWSAM6U0hTTp4UgXCglUQ0X7kpKMvw9aWH0ljcS/DVwLhLB8MprCyN5e8C/H4skbD8hSyHMrtFoWUNY2efmUfWBdeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724045813; c=relaxed/simple;
	bh=dXT+BZ3WSUKgGmf524ufGWLEyDGICFGHu6d9H17eZm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cU5+Y+eHADRs5JJ3LDvMu5TPEhD+W4xkLqW/+8yiWqlUvRWv9m26JWEeRcKPz8MYoynhyMkMQ4FsLTt58rKGwnZzbvi7qxRGyvjnbsO1Q1KvDY+7GDqruXQasFiuEiuRzo0YO/6jgRGgROpcL/eQitGEbVqYuk+Pr+ZUeEo64Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ebJrfH3z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dfHEv6A2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=glfVZhvJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=egZTwQoV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EDE8B1FE4A;
	Mon, 19 Aug 2024 05:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724045810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=99n6Rtaia2ltl6nndYZ1fU6VQEYcBq82sNN4NW0+8Nw=;
	b=ebJrfH3zbUidS3mMF8FBV/TbvfRIjxJU1neZAsv7trFvISd6NBzV3KDV7g3w3aBuwRmE8B
	JI8+nedWg/FqJ07KebAPf3lmIBnIKQ87IpxIQ118xzB62hzaP4OiMbopQpth43OZTF+dje
	4bpwtjnCQbtVjLcGy4fpkIDCQVCmGGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724045810;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=99n6Rtaia2ltl6nndYZ1fU6VQEYcBq82sNN4NW0+8Nw=;
	b=dfHEv6A2UQS3oS+nArKDDRFKHVPK8pAccWq/ztPe2CKP9AdH8KS1cm5g4GDFDRlz3ORbRl
	g03jboN8qej14GAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724045809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=99n6Rtaia2ltl6nndYZ1fU6VQEYcBq82sNN4NW0+8Nw=;
	b=glfVZhvJSlIlq6ohO2MpzqBEJfCXlXUT8TCmoTBaK0N915KbYnHv6+9WSaLEw1EEYFsVTs
	dKYk1BTLKaIwJNTcD/yZ05UGVYo0kK1EoB9xWkWRRkGfuw4z1G3zOKr/NwthPZEkCqeiy1
	41YTxqsMfPzxo4j2KRREXTL19yM/C9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724045809;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=99n6Rtaia2ltl6nndYZ1fU6VQEYcBq82sNN4NW0+8Nw=;
	b=egZTwQoVBFYMHj4zo8g/DGzg7NwQVSMn0aF+rg1DK8TfUrqDr7leJKzqFrEVL04DPaQddZ
	kfhOH9+eOlqwzsBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2AF921397F;
	Mon, 19 Aug 2024 05:36:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3R98EO/ZwmbhYQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 19 Aug 2024 05:36:47 +0000
From: NeilBrown <neilb@suse.de>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/9] XFS: use wait_var_event() when waiting of i_pincount.
Date: Mon, 19 Aug 2024 15:20:37 +1000
Message-ID: <20240819053605.11706-4-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240819053605.11706-1-neilb@suse.de>
References: <20240819053605.11706-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80

__xfs_iunpin_wait() is nearly an open-coded version of wait_var_event().
The bit XFS_IPINNED in ->i_flags is never used (not set, cleared,
or tested).  Its only role is in choosing a wait_queue.

The code is more transparent if we discard that flag bit and use
wait_var_event() to wait for the pincount to reach zero, which is
signalled by wake_up_var() - or more specifically
atomic_dec_and_wake_up_var()

In order to use io_schedule(), we actually use ___wait_var_event().

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/xfs/xfs_inode.c      | 24 +++++-------------------
 fs/xfs/xfs_inode.h      |  2 --
 fs/xfs/xfs_inode_item.c |  3 +--
 3 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 7dc6f326936c..a855295363b5 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1899,29 +1899,15 @@ xfs_iunpin(
 
 }
 
-static void
-__xfs_iunpin_wait(
-	struct xfs_inode	*ip)
-{
-	wait_queue_head_t *wq = bit_waitqueue(&ip->i_flags, __XFS_IPINNED_BIT);
-	DEFINE_WAIT_BIT(wait, &ip->i_flags, __XFS_IPINNED_BIT);
-
-	xfs_iunpin(ip);
-
-	do {
-		prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
-		if (xfs_ipincount(ip))
-			io_schedule();
-	} while (xfs_ipincount(ip));
-	finish_wait(wq, &wait.wq_entry);
-}
-
 void
 xfs_iunpin_wait(
 	struct xfs_inode	*ip)
 {
-	if (xfs_ipincount(ip))
-		__xfs_iunpin_wait(ip);
+	if (xfs_ipincount(ip)) {
+		xfs_iunpin(ip);
+		___wait_var_event(&ip->i_pincount, xfs_ipincount(ip) == 0,
+				  TASK_UNINTERRUPTIBLE, 0, 0, io_schedule());
+	}
 }
 
 /*
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 51defdebef30..5062580034ec 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -337,8 +337,6 @@ static inline bool xfs_inode_has_bigrtalloc(struct xfs_inode *ip)
 #define XFS_ITRUNCATED		(1 << 5) /* truncated down so flush-on-close */
 #define XFS_IDIRTY_RELEASE	(1 << 6) /* dirty release already seen */
 #define XFS_IFLUSHING		(1 << 7) /* inode is being flushed */
-#define __XFS_IPINNED_BIT	8	 /* wakeup key for zero pin count */
-#define XFS_IPINNED		(1 << __XFS_IPINNED_BIT)
 #define XFS_IEOFBLOCKS		(1 << 9) /* has the preallocblocks tag set */
 #define XFS_NEED_INACTIVE	(1 << 10) /* see XFS_INACTIVATING below */
 /*
diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index b509cbd191f4..7fee751c7dfd 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -712,8 +712,7 @@ xfs_inode_item_unpin(
 	trace_xfs_inode_unpin(ip, _RET_IP_);
 	ASSERT(lip->li_buf || xfs_iflags_test(ip, XFS_ISTALE));
 	ASSERT(atomic_read(&ip->i_pincount) > 0);
-	if (atomic_dec_and_test(&ip->i_pincount))
-		wake_up_bit(&ip->i_flags, __XFS_IPINNED_BIT);
+	atomic_dec_and_wake_up_var(&ip->i_pincount);
 }
 
 STATIC uint
-- 
2.44.0


