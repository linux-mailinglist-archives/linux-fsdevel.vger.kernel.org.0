Return-Path: <linux-fsdevel+bounces-67473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F073C41782
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 20:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E7FBC34D134
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 19:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47F333A018;
	Fri,  7 Nov 2025 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qkvbxtBQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qDmQYczD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C1C334691
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 19:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762544903; cv=none; b=sJwhegbciqTq3CACzwhytEp1gjK4gvTM2Ed3+AoB90UqwXsmAedcYNi9Zgy0aR1sNPz7q9NqeJqGa8eNbP+dfm5Yrg5ohDtJg2ivWyiXZbGAFD6guvn5rSZM+ZrhfGgp8b6Wg3musT/0HjWpM6HpqsFLmiWUCicxDTBgTxdkKGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762544903; c=relaxed/simple;
	bh=xhfGegLyC0qmYHR2Cn+EA+Am2tWiKLZdpesevI/Yht8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tEBDmlBymRGXM/8LyRBIExWrI7xy6JUi3Q/N63REiWyf8yrRHJP+PfwwzMq2kJAXaUBrrn58wdOQ950fE5YMfRxEjy2+Rrn2sXbL1S9tIh8PMDHEuyGli/ZdfmRlFra6GXJkKz64/HwsPelSLxer+1J3JpksyZLKqghiZSCy0Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qkvbxtBQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qDmQYczD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from pathway.suse.cz (unknown [10.100.208.146])
	by smtp-out2.suse.de (Postfix) with ESMTP id 14CC32056D;
	Fri,  7 Nov 2025 19:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762544899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IeO70OJ5TY7FEk0BCI4hVN3mDp8lmCuzmxRyi+G2tng=;
	b=qkvbxtBQDmIDilJnTOR0vYQytDAYcCw71oDIP3POIkLEhr8bapI3sWiATSNDFvTeRucO8H
	LIPX1a3YE3GSiy6axv1llPkccnytvEYkFxzhT98XYRO1rfkRjHLL56Ile/Y7srAVPSM4yN
	Wh1TV2iE8VQSmTV4FVbXIZHKINQOAAg=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762544898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IeO70OJ5TY7FEk0BCI4hVN3mDp8lmCuzmxRyi+G2tng=;
	b=qDmQYczDGUxbgVIUIjLuV4gS0bREuJF+39GbqXFP+0r/zTMv+p7W8nNHpW5N2tdqeAOCt6
	2m6dtwSCm6xiG1m1D4OKACkz/bwP1gft3kKFiW0IdHQX4f8je6VBm4eSN3JxEVoDbiC1oH
	RlvIJmhpoywOTxhEAVMBPPDpTIxuuIg=
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	"amurray @ thegoodpenguin . co . uk" <amurray@thegoodpenguin.co.uk>,
	brauner@kernel.org,
	chao@kernel.org,
	djwong@kernel.org,
	jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 2/2] printk_ringbuffer: Create a helper function to decide whether a more space is needed
Date: Fri,  7 Nov 2025 20:47:20 +0100
Message-ID: <20251107194720.1231457-3-pmladek@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107194720.1231457-1-pmladek@suse.com>
References: <20251107194720.1231457-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.79 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.942];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	R_RATELIMIT(0.00)[to_ip_from(RLreigq8okzrb3g3qsqhoz9iaq)];
	FREEMAIL_CC(0.00)[gmail.com,thegoodpenguin.co.uk,kernel.org,lists.sourceforge.net,vger.kernel.org,googlegroups.com,suse.com];
	RCVD_COUNT_ZERO(0.00)[0];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -6.79

The decision whether some more space is needed is tricky in the printk
ring buffer code:

  1. The given lpos values might overflow. A subtraction must be used
     instead of a simple "lower than" check.

  2. Another CPU might reuse the space in the mean time. It can be
     detected when the subtraction is bigger than DATA_SIZE(data_ring).

  3. There is exactly enough space when the result of the subtraction
     is zero. But more space is needed when the result is exactly
     DATA_SIZE(data_ring).

Add a helper function to make sure that the check is done correctly
in all situations. Also it helps to make the code consistent and
better documented.

Suggested-by: John Ogness <john.ogness@linutronix.de>
Link: https://lore.kernel.org/r/87tsz7iea2.fsf@jogness.linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk_ringbuffer.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 3e6fd8d6fa9f..ede3039dd041 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -411,6 +411,23 @@ static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
 	return to_blk_size(size) <= DATA_SIZE(data_ring) / 2;
 }
 
+/*
+ * Compare the current and requested logical position and decide
+ * whether more space needed.
+ *
+ * Return false when @lpos_current is already at or beyond @lpos_target.
+ *
+ * Also return false when the difference between the positions is bigger
+ * than the size of the data buffer. It might happen only when the caller
+ * raced with another CPU(s) which already made and used the space.
+ */
+static bool need_more_space(struct prb_data_ring *data_ring,
+			    unsigned long lpos_current,
+			    unsigned long lpos_target)
+{
+	return lpos_target - lpos_current - 1 < DATA_SIZE(data_ring);
+}
+
 /* Query the state of a descriptor. */
 static enum desc_state get_desc_state(unsigned long id,
 				      unsigned long state_val)
@@ -577,7 +594,7 @@ static bool data_make_reusable(struct printk_ringbuffer *rb,
 	unsigned long id;
 
 	/* Loop until @lpos_begin has advanced to or beyond @lpos_end. */
-	while ((lpos_end - lpos_begin) - 1 < DATA_SIZE(data_ring)) {
+	while (need_more_space(data_ring, lpos_begin, lpos_end)) {
 		blk = to_block(data_ring, lpos_begin);
 
 		/*
@@ -668,7 +685,7 @@ static bool data_push_tail(struct printk_ringbuffer *rb, unsigned long lpos)
 	 * sees the new tail lpos, any descriptor states that transitioned to
 	 * the reusable state must already be visible.
 	 */
-	while ((lpos - tail_lpos) - 1 < DATA_SIZE(data_ring)) {
+	while (need_more_space(data_ring, tail_lpos, lpos)) {
 		/*
 		 * Make all descriptors reusable that are associated with
 		 * data blocks before @lpos.
@@ -1148,8 +1165,14 @@ static char *data_realloc(struct printk_ringbuffer *rb, unsigned int size,
 
 	next_lpos = get_next_lpos(data_ring, blk_lpos->begin, size);
 
-	/* If the data block does not increase, there is nothing to do. */
-	if (head_lpos - next_lpos < DATA_SIZE(data_ring)) {
+	/*
+	 * Use the current data block when the size does not increase.
+	 *
+	 * Note that need_more_space() could never return false here because
+	 * the difference between the positions was bigger than the data
+	 * buffer size. The data block is reopened and can't get reused.
+	 */
+	if (!need_more_space(data_ring, head_lpos, next_lpos)) {
 		if (wrapped)
 			blk = to_block(data_ring, 0);
 		else
-- 
2.51.1


