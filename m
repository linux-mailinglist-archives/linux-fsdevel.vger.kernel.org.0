Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC131145CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 18:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbfLERV5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 12:21:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45264 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729711AbfLERV5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:21:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575566516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ly/epWve+/cPaZY37VoFmJhJWai9+r3sAb3SoA4680E=;
        b=Ngs7dVDdQ8ZoA5287/LHOgAJ2s/5qtRXjQlUMth3X0PKeAv7CZ1HU//6Kv+8FVNf7rn0XJ
        wV2XB9swANis+5axeZkNs2bT2ex5GhUuI4A/CR5VvpUL6RNw7AoNRNP4iN8M4OzTzPlnCj
        JT+Snz/Aog0KIT+vbiTqyLW7Bi2piRA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231--maKD96LN0SRlq_ZR4R3mg-1; Thu, 05 Dec 2019 12:21:53 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B735DB60;
        Thu,  5 Dec 2019 17:21:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2E816E702;
        Thu,  5 Dec 2019 17:21:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/2] pipe: Fix missing mask update after pipe_wait()
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, ebiggers@kernel.org
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 05 Dec 2019 17:21:50 +0000
Message-ID: <157556651022.20869.2027577608881946885.stgit@warthog.procyon.org.uk>
In-Reply-To: <157556649610.20869.8537079649495343567.stgit@warthog.procyon.org.uk>
References: <157556649610.20869.8537079649495343567.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: -maKD96LN0SRlq_ZR4R3mg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix pipe_write() to regenerate the ring index mask and update max_usage
after calling pipe_wait().

This is necessary as the latter function drops the pipe lock, thereby
allowing F_SETPIPE_SZ change it.  Without this, pipe_write() may
subsequently miscalculate the array indices and pipe fullness, leading to
an oops like the following:

 BUG: KASAN: slab-out-of-bounds in pipe_write+0xc25/0xe10 fs/pipe.c:481
 Write of size 8 at addr ffff8880771167a8 by task syz-executor.3/7987
 ...
 CPU: 1 PID: 7987 Comm: syz-executor.3 Not tainted 5.4.0-rc2-syzkaller #0
 ...
 Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x113/0x167 lib/dump_stack.c:113
  print_address_description.constprop.8.cold.10+0x9/0x31d mm/kasan/report.c:374
  __kasan_report.cold.11+0x1b/0x3a mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:634
  __asan_report_store8_noabort+0x17/0x20 mm/kasan/generic_report.c:137
  pipe_write+0xc25/0xe10 fs/pipe.c:481
  call_write_iter include/linux/fs.h:1895 [inline]
  new_sync_write+0x3fd/0x7e0 fs/read_write.c:483
  __vfs_write+0x94/0x110 fs/read_write.c:496
  vfs_write+0x18a/0x520 fs/read_write.c:558
  ksys_write+0x105/0x220 fs/read_write.c:611
  __do_sys_write fs/read_write.c:623 [inline]
  __se_sys_write fs/read_write.c:620 [inline]
  __x64_sys_write+0x6e/0xb0 fs/read_write.c:620
  do_syscall_64+0xca/0x5d0 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fixes: 8cefc107ca54 ("pipe: Use head and tail pointers for the ring, not cursor and length")
Reported-by: syzbot+838eb0878ffd51f27c41@syzkaller.appspotmail.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Biggers <ebiggers@kernel.org>
---

 fs/pipe.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/pipe.c b/fs/pipe.c
index 5f89f73d4366..4d2a7bbc5d31 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -526,6 +526,8 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		}
 		pipe->waiting_writers++;
 		pipe_wait(pipe);
+		mask = pipe->ring_size - 1;
+		max_usage = pipe->max_usage;
 		pipe->waiting_writers--;
 	}
 out:

