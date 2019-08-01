Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0C67D2AF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 03:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbfHABQw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 21:16:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33568 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729398AbfHABQq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 21:16:46 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hszhJ-0002IH-9s; Thu, 01 Aug 2019 03:16:02 +0200
Message-Id: <20190801010944.364767635@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 01 Aug 2019 03:01:31 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>, linux-ext4@vger.kernel.org,
        "Theodore Tso" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Joel Becker <jlbec@evilplan.org>
Subject: [patch V2 5/7] fs/jbd2: Simplify journal_unmap_buffer()
References: <20190801010126.245731659@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

journal_unmap_buffer() checks first whether the buffer head is a journal.
If so it takes locks and then invokes jbd2_journal_grab_journal_head()
followed by another check whether this is journal head buffer.

The double checking is pointless.

Replace the initial check with jbd2_journal_grab_journal_head() which
alredy checks whether the buffer head is actually a journal.

Allows also early access to the journal head pointer for the upcoming
conversion of state lock to a regular spinlock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-ext4@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.com>
---
V2: New patch
---
 fs/jbd2/transaction.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2196,7 +2196,8 @@ static int journal_unmap_buffer(journal_
 	 * holding the page lock. --sct
 	 */
 
-	if (!buffer_jbd(bh))
+	jh = jbd2_journal_grab_journal_head(bh);
+	if (!jh)
 		goto zap_buffer_unlocked;
 
 	/* OK, we have data buffer in journaled mode */
@@ -2204,10 +2205,6 @@ static int journal_unmap_buffer(journal_
 	jbd_lock_bh_state(bh);
 	spin_lock(&journal->j_list_lock);
 
-	jh = jbd2_journal_grab_journal_head(bh);
-	if (!jh)
-		goto zap_buffer_no_jh;
-
 	/*
 	 * We cannot remove the buffer from checkpoint lists until the
 	 * transaction adding inode to orphan list (let's call it T)
@@ -2329,7 +2326,6 @@ static int journal_unmap_buffer(journal_
 	 */
 	jh->b_modified = 0;
 	jbd2_journal_put_journal_head(jh);
-zap_buffer_no_jh:
 	spin_unlock(&journal->j_list_lock);
 	jbd_unlock_bh_state(bh);
 	write_unlock(&journal->j_state_lock);


