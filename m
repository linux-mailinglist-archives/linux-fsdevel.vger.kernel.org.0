Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1F11145CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 18:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbfLERVt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 12:21:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54364 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729994AbfLERVt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:21:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575566508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=svY1slGuIZvwKFZLvTtM6EnuVrwpXSnlHGxNC+hQMHY=;
        b=MSmBNBu/QP8C8Z5NjStk4DbgueGQYlJ6drDJbjWHQ1Yz57020pGTPjFBf6r4zHyXk/4ErF
        Sp4/FV2avUVEdjHKQR7xvCfonR60j+pMhalp0TlguXbudqymtEYjHrwv+/4dBcvgVltp4Y
        bjWSJUZfYPJQatjDVg3muMC58MN4D7M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-sT26HrRcNt-H0_fxHI0vCQ-1; Thu, 05 Dec 2019 12:21:46 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0337F8017DF;
        Thu,  5 Dec 2019 17:21:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E09905D9C9;
        Thu,  5 Dec 2019 17:21:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/2] pipe: Remove assertion from pipe_poll()
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, ebiggers@kernel.org
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 05 Dec 2019 17:21:43 +0000
Message-ID: <157556650320.20869.10314267987837887098.stgit@warthog.procyon.org.uk>
In-Reply-To: <157556649610.20869.8537079649495343567.stgit@warthog.procyon.org.uk>
References: <157556649610.20869.8537079649495343567.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: sT26HrRcNt-H0_fxHI0vCQ-1
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

 fs/pipe.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/pipe.c b/fs/pipe.c
index 648ce440ca85..5f89f73d4366 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1176,6 +1176,7 @@ static long pipe_set_size(struct pipe_inode_info *pipe, unsigned long arg)
 	pipe->max_usage = nr_slots;
 	pipe->tail = tail;
 	pipe->head = head;
+	wake_up_interruptible_all(&pipe->wait);
 	return pipe->max_usage * PAGE_SIZE;
 
 out_revert_acct:

