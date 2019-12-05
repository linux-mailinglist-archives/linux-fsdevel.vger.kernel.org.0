Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB309114946
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 23:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfLEWah (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 17:30:37 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47038 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727605AbfLEWah (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 17:30:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575585036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZAomhu2ho4RusDPg60Z89IOwCOmgdGXh3ov3pMESDfA=;
        b=gbhmhsl1Jy5db/7QXY/muE+c8haY2m5024Na65gFKVXbTQ8SHRTBsMvwjw1WGMmHXS0I2a
        iEZbIn/2gtLzZXmMLxhinvnOAnIclDe9kNwtl/1RoA4riL43ppD1mdosEA5yn7yJRwCfGH
        xG+G1M+F4ymJqbJLbsasN9U/d1Xl0m4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-kA61m-swNymKlk8QlxFSmA-1; Thu, 05 Dec 2019 17:30:33 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDA1A107ACCC;
        Thu,  5 Dec 2019 22:30:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A74A85C1D6;
        Thu,  5 Dec 2019 22:30:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/2] pipe: Remove assertion from pipe_poll() [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, ebiggers@kernel.org
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 05 Dec 2019 22:30:30 +0000
Message-ID: <157558502995.10278.1228819680102163966.stgit@warthog.procyon.org.uk>
In-Reply-To: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: kA61m-swNymKlk8QlxFSmA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

An assertion check was added to pipe_poll() to make sure that the ring
occupancy isn't seen to overflow the ring size.  However, since no locks
are held when the three values are read, it is possible for F_SETPIPE_SZ to
intervene and muck up the calculation, thereby causing the oops.

Fix this by simply removing the assertion and accepting that the
calculation might be approximate.

Note that the previous code also had a similar issue, though there was no
assertion check, since the occupancy counter and the ring size were not
read with a lock held, so it's possible that the poll check might have
malfunctioned then too.

Also wake up all the waiters so that they can reissue their checks if there
was a competing read or write.

Fixes: 8cefc107ca54 ("pipe: Use head and tail pointers for the ring, not cursor and length")
Reported-by: syzbot+d37abaade33a934f16f2@syzkaller.appspotmail.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Biggers <ebiggers@kernel.org>
---

 fs/pipe.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 648ce440ca85..da782ee251d2 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -579,8 +579,6 @@ pipe_poll(struct file *filp, poll_table *wait)
 
 	poll_wait(filp, &pipe->wait, wait);
 
-	BUG_ON(pipe_occupancy(head, tail) > pipe->ring_size);
-
 	/* Reading only -- no need for acquiring the semaphore.  */
 	mask = 0;
 	if (filp->f_mode & FMODE_READ) {
@@ -1176,6 +1174,7 @@ static long pipe_set_size(struct pipe_inode_info *pipe, unsigned long arg)
 	pipe->max_usage = nr_slots;
 	pipe->tail = tail;
 	pipe->head = head;
+	wake_up_interruptible_all(&pipe->wait);
 	return pipe->max_usage * PAGE_SIZE;
 
 out_revert_acct:

