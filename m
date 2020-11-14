Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911992B2B27
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 04:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgKNDzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 22:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKNDzD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 22:55:03 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C591C0613D1;
        Fri, 13 Nov 2020 19:55:02 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdmeL-005Z4T-DF; Sat, 14 Nov 2020 03:54:53 +0000
Date:   Sat, 14 Nov 2020 03:54:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
Message-ID: <20201114035453.GM3576660@ZenIV.linux.org.uk>
References: <20201104082738.1054792-2-hch@lst.de>
 <20201110213253.GV3576660@ZenIV.linux.org.uk>
 <20201110213511.GW3576660@ZenIV.linux.org.uk>
 <20201110232028.GX3576660@ZenIV.linux.org.uk>
 <CAHk-=whTqr4Lp0NYR6k3yc2EbiF0RR17=TJPa4JBQATMR__XqA@mail.gmail.com>
 <20201111215220.GA3576660@ZenIV.linux.org.uk>
 <20201111222116.GA919131@ZenIV.linux.org.uk>
 <20201113235453.GA227700@ubuntu-m3-large-x86>
 <20201114011754.GL3576660@ZenIV.linux.org.uk>
 <20201114030124.GA236@Ryzen-9-3900X.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114030124.GA236@Ryzen-9-3900X.localdomain>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 13, 2020 at 08:01:24PM -0700, Nathan Chancellor wrote:
> Sure thing, it does trigger.
> 
> [    0.235058] ------------[ cut here ]------------
> [    0.235062] WARNING: CPU: 15 PID: 237 at fs/seq_file.c:176 seq_read_iter+0x3b3/0x3f0
> [    0.235064] CPU: 15 PID: 237 Comm: localhost Not tainted 5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #15
> [    0.235065] RIP: 0010:seq_read_iter+0x3b3/0x3f0
> [    0.235066] Code: ba 01 00 00 00 e8 6d d2 fc ff 4c 89 e7 48 89 ee 48 8b 54 24 10 e8 ad 8b 45 00 49 01 c5 48 29 43 18 48 89 43 10 e9 61 fe ff ff <0f> 0b e9 6f fc ff ff 0f 0b 45 31 ed e9 0d fd ff ff 48 c7 43 18 00
> [    0.235067] RSP: 0018:ffff9c774063bd08 EFLAGS: 00010246
> [    0.235068] RAX: ffff91a77ac01f00 RBX: ffff91a50133c348 RCX: 0000000000000001
> [    0.235069] RDX: ffff9c774063bdb8 RSI: ffff9c774063bd60 RDI: ffff9c774063bd88
> [    0.235069] RBP: 0000000000000000 R08: 0000000000000000 R09: ffff91a50058b768
> [    0.235070] R10: ffff91a7f79f0000 R11: ffffffffbc2c2030 R12: ffff9c774063bd88
> [    0.235070] R13: ffff9c774063bd60 R14: ffff9c774063be48 R15: ffff91a77af58900
> [    0.235072] FS:  000000000029c800(0000) GS:ffff91a7f7bc0000(0000) knlGS:0000000000000000
> [    0.235073] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.235073] CR2: 00007ab6c1fabad0 CR3: 000000037a004000 CR4: 0000000000350ea0
> [    0.235074] Call Trace:
> [    0.235077]  seq_read+0x127/0x150
> [    0.235078]  proc_reg_read+0x42/0xa0
> [    0.235080]  do_iter_read+0x14c/0x1e0
> [    0.235081]  do_readv+0x18d/0x240
> [    0.235083]  do_syscall_64+0x33/0x70
> [    0.235085]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

*blink*

	Lovely...  For one thing, it did *not* go through
proc_reg_read_iter().  For another, it has hit proc_reg_read() with
zero length, which must've been an iovec with zero ->iov_len in
readv(2) arguments.  I wonder if we should use that kind of
pathology (readv() with zero-length segment in the middle of
iovec array) for regression tests...

	OK...  First of all, since that kind of crap can happen,
let's do this (incremental to be folded); then (and that's
a separate patch) we ought to switch the proc_ops with ->proc_read
equal to seq_read to ->proc_read_iter = seq_read_iter, so that
those guys would not mess with seq_read() wrapper at all.

	Finally, is there any point having do_loop_readv_writev()
call any methods for zero-length segments?

	In any case, the following should be folded into
"fix return values of seq_read_iter()"; could you check if that
fixes the problem you are seeing?

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 07b33c1f34a9..e66d6b8bae23 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -211,9 +211,9 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		m->count -= n;
 		m->from += n;
 		copied += n;
-		if (!iov_iter_count(iter) || m->count)
-			goto Done;
 	}
+	if (m->count || !iov_iter_count(iter))
+		goto Done;
 	/* we need at least one record in buffer */
 	m->from = 0;
 	p = m->op->start(m, &m->index);
