Return-Path: <linux-fsdevel+bounces-67288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA322C3A9E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 12:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB2F1A43728
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 11:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB573101AA;
	Thu,  6 Nov 2025 11:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VfHVcgmp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o1GL4jP2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B250930F932;
	Thu,  6 Nov 2025 11:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428986; cv=none; b=Oq+421zOYex+kN926bZ9WTD0MIDMMOkq/hW9p0HP3zIz0KTb/KsSEekLF0gUvRHPqVur7Wv/m4WtyhPHcAQ5QwA3i/FKIkkUgiOOLYj3oNnnDwigQfSdPGcsK0gJ8zzdiw/W8NzLHqd3RVC3F/kt4VYavnaR+PudrDHwlvbLN/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428986; c=relaxed/simple;
	bh=yL1dKuTwJbqWHWFM/S4JLHnPEsgFEplZUtp9/v+jbis=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GtcBUIZj8z4AD4cnaOSJlNaHpMOClzhGnY81mL9ArGJhMcG1l80bbI50/0QPpPfomcZdL4tt7uwEx+mslIfTY6sDcxTY+sadCb0ipHFZRyFYKwIAD+KZWBZAvpIKgBncFGINU9/hwWZTITYf+9gW1jyBxegkr8V+dZkjXyjq1So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VfHVcgmp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o1GL4jP2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762428982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3OFVSDhbG36SsIf5lzC388elLqvaZZTmYLAdGi/UGDg=;
	b=VfHVcgmpJH3uTfDhchkD4wuvXiCeO6Y0cgIqWhodPDv0n2WVyYSiJgJJpsP+TuMeWHGFhk
	awrfiT1E4sgpQl/J9FkfBBes3xk5bIN19ceahwVKoZUp77RiupUePOYXKRjfWcOOZNzJyI
	nEGwsjZJXoedyhMd+JsaSo0915zq3oA0kUISJHkpjhjfUhWqF7la7YqWpyki7iPmNWmakE
	1xhtxvITVT9bFAfdxm0ZQDDm4fTBoi6xT7qZeJDMw7135L0MoVUU7nVX9ZV0r7kk20V5Hd
	8BnaSJ/s1Q5JnQT8KCr/Flgxrv/goYiQYt5i7ji3eoWtF4DinD6WOF+xYK6ieQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762428982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3OFVSDhbG36SsIf5lzC388elLqvaZZTmYLAdGi/UGDg=;
	b=o1GL4jP2YCiTuyko5Z4t0WrMdYgexNYHQsUuVxE4kxErQm/WLMPqalMwDn0asv1C6ScxeV
	1J3sSKVoaU//4sBA==
To: Petr Mladek <pmladek@suse.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, syzbot
 <syzbot+3686758660f980b402dc@syzkaller.appspotmail.com>,
 "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
 brauner@kernel.org, chao@kernel.org, djwong@kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [iomap?] kernel BUG in folio_end_read (2)
In-Reply-To: <87bjlgqmk5.fsf@jogness.linutronix.de>
References: <CAJnrk1bF8sLU6tG2MGkt_KR4BoTd_k01CMVZJ9js2-eyh80tbw@mail.gmail.com>
 <69096836.a70a0220.88fb8.0006.GAE@google.com>
 <CAJnrk1Yo4dRVSaPCaAGkHc+in03KaTXJ+KxckhLoSrRxbEdDBg@mail.gmail.com>
 <aQpFLJM96uRpO4S-@pathway.suse.cz> <87ldkk34yj.fsf@jogness.linutronix.de>
 <aQuABK25fdBVTGZc@pathway.suse.cz> <87bjlgqmk5.fsf@jogness.linutronix.de>
Date: Thu, 06 Nov 2025 12:42:21 +0106
Message-ID: <87tsz7iea2.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-11-05, John Ogness <john.ogness@linutronix.de> wrote:
>> Another question is whether this is the only problem caused the patch.
>
> This comparison is quite special. It caught my attention while combing
> through the code.

The reason that this comparison is special is because it is the only one
that does not take wrapping into account. I did it that way originally
because it is AND with a wrap check. But this is an ugly special
case. It should use the same wrap check as the other 3 cases in
nbcon.c. If it had, the bug would not have happened.

I always considered these wrap checks to be non-obvious and
error-prone. So what if we create a nice helper function to simplify and
unify the wrap checks? Something like this:

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 839f504db6d30..8499ee642c31d 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -390,6 +390,17 @@ static unsigned int to_blk_size(unsigned int size)
 	return size;
 }
 
+/*
+ * Check if @lpos1 is before @lpos2. This takes ringbuffer wrapping
+ * into account. If @lpos1 is more than a full wrap before @lpos2,
+ * it is considered to be after @lpos2.
+ */
+static bool lpos1_before_lpos2(struct prb_data_ring *data_ring,
+			       unsigned long lpos1, unsigned long lpos2)
+{
+	return lpos2 - lpos1 - 1 < DATA_SIZE(data_ring);
+}
+
 /*
  * Sanity checker for reserve size. The ringbuffer code assumes that a data
  * block does not exceed the maximum possible size that could fit within the
@@ -577,7 +588,7 @@ static bool data_make_reusable(struct printk_ringbuffer *rb,
 	unsigned long id;
 
 	/* Loop until @lpos_begin has advanced to or beyond @lpos_end. */
-	while ((lpos_end - lpos_begin) - 1 < DATA_SIZE(data_ring)) {
+	while (lpos1_before_lpos2(data_ring, lpos_begin, lpos_end)) {
 		blk = to_block(data_ring, lpos_begin);
 
 		/*
@@ -668,7 +679,7 @@ static bool data_push_tail(struct printk_ringbuffer *rb, unsigned long lpos)
 	 * sees the new tail lpos, any descriptor states that transitioned to
 	 * the reusable state must already be visible.
 	 */
-	while ((lpos - tail_lpos) - 1 < DATA_SIZE(data_ring)) {
+	while (lpos1_before_lpos2(data_ring, tail_lpos, lpos)) {
 		/*
 		 * Make all descriptors reusable that are associated with
 		 * data blocks before @lpos.
@@ -1149,7 +1160,7 @@ static char *data_realloc(struct printk_ringbuffer *rb, unsigned int size,
 	next_lpos = get_next_lpos(data_ring, blk_lpos->begin, size);
 
 	/* If the data block does not increase, there is nothing to do. */
-	if (head_lpos - next_lpos < DATA_SIZE(data_ring)) {
+	if (!lpos1_before_lpos2(data_ring, head_lpos, next_lpos)) {
 		if (wrapped)
 			blk = to_block(data_ring, 0);
 		else
@@ -1262,7 +1273,7 @@ static const char *get_data(struct prb_data_ring *data_ring,
 
 	/* Regular data block: @begin less than @next and in same wrap. */
 	if (!is_blk_wrapped(data_ring, blk_lpos->begin, blk_lpos->next) &&
-	    blk_lpos->begin < blk_lpos->next) {
+	    lpos1_before_lpos2(data_ring, blk_lpos->begin, blk_lpos->next)) {
 		db = to_block(data_ring, blk_lpos->begin);
 		*data_size = blk_lpos->next - blk_lpos->begin;
 
This change also fixes the issue. Thoughts?

John

