Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2444866F9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jan 2022 16:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240715AbiAFPp4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 10:45:56 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47260 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240608AbiAFPpr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 10:45:47 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 532061F3A0;
        Thu,  6 Jan 2022 15:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641483945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=iE33MPtxfS2UgJsl/tnQXn2A5rT2nd54hpzjlZTX9f0=;
        b=tDi2Fy8XTXBG30SHU5Nea2NY1d/szacau1TeawiSFkssNS6eosntphD46QCAg67r+oPNRk
        p70F+s1PDXOnONqxWq2kJx939IRDiCkJv8YKYLowxgHrpQQNZDFrpyiQErE2UdE5kzSCl2
        TF9dVsI+KmGARvWaXN0E9j3jm6jwMVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641483945;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=iE33MPtxfS2UgJsl/tnQXn2A5rT2nd54hpzjlZTX9f0=;
        b=O1Fgx5PwzCOuxLveQcVQdzNUfjEF6lMo/jXxItlGlnfTPBGTHeZKFMqD5Q9ZeRldXdH+OF
        RKN05tNQ5fdEwsAA==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4A4B6A3B8A;
        Thu,  6 Jan 2022 15:45:45 +0000 (UTC)
Received: by localhost (Postfix, from userid 1000)
        id A7C41A0864; Thu,  6 Jan 2022 12:17:17 +0100 (CET)
Date:   Thu, 6 Jan 2022 12:17:17 +0100
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RESEND] Indefinitely sleeping task in poll_schedule_timeout()
Message-ID: <20220106111717.bg2uu5jc5kgwpyzd@quack3.lan>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="65gncorjdzigsipi"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--65gncorjdzigsipi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

For some reason this doesn't seem to have reached the lists so I'm
resending the email...
---

Hello!

I have been scratching my head over a crashdump where a task is sleeping
in do_select() -> poll_schedule_timeout() indefinitely although there are
things to read from a fd the select was run on. The oddity triggering this
is that the fd is no longer open in the task's files_struct. Another
unusual thing is that the file select(2) is running on was actually a
fsnotify_group but that particular thing does not seem to be substantial.
So what I think happened is the following race:

TASK1 (thread1)             TASK2                       TASK1 (thread2)
do_select()                      
  setup poll_wqueues table
                            generate fanotify event
                              wake_up(group->notification_waitq)
                                pollwake()
                                  table->triggered = 1
                                                        closes fd thread1 is
                                                          waiting for
  poll_schedule_timeout()
    - sees table->triggered
    table->triggered = 0
    return -EINTR
  loop back in do_select() but fdget() in the setup of poll_wqueues fails
now so we never find fanotify group's fd is ready for reading and sleep in
poll_schedule_timeout() indefinitely.

Arguably the application is doing something stupid (waiting for fd to
become readable while closing it) and it gets what it deserves but the fact
that do_select() holds the last file reference makes the outcome somewhat
unexpected - normally, ->release() would cleanup everything and writers
would know the file is dead (e.g. fanotify group would get torn down) but
that does not happen until do_select() calls poll_freewait() which never
happens...

So maybe something like attached patch (boot tested only so far)? What you
do think?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--65gncorjdzigsipi
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-select-Fix-indefinitely-sleeping-task-in-poll_schedu.patch"

From ae2a849f54b18568037fd27d0e83b3068cd3b292 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Tue, 4 Jan 2022 13:17:21 +0100
Subject: [PATCH] select: Fix indefinitely sleeping task in
 poll_schedule_timeout()

A task can end up indefinitely sleeping in do_select() ->
poll_schedule_timeout() when the following race happens:

TASK1 (thread1)             TASK2                       TASK1 (thread2)
do_select()
  setup poll_wqueues table
  with 'fd'
                            write data to 'fd'
                              pollwake()
                                table->triggered = 1
                                                        closes 'fd' thread1 is
                                                          waiting for
  poll_schedule_timeout()
    - sees table->triggered
    table->triggered = 0
    return -EINTR
  loop back in do_select() but fdget() in the setup of poll_wqueues
fails now so we never find 'fd' is ready for reading and sleep in
poll_schedule_timeout() indefinitely.

Make sure we return -EBADF from do_select() when we spot file we cannot
get anymore. This is the same behavior as when not open fd is passed to
select(2) from the start.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/select.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/select.c b/fs/select.c
index 945896d0ac9e..f839adf283ae 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -505,6 +505,7 @@ static int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)
 	for (;;) {
 		unsigned long *rinp, *routp, *rexp, *inp, *outp, *exp;
 		bool can_busy_loop = false;
+		bool bad_fd = false;
 
 		inp = fds->in; outp = fds->out; exp = fds->ex;
 		rinp = fds->res_in; routp = fds->res_out; rexp = fds->res_ex;
@@ -561,6 +562,8 @@ static int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)
 					} else if (busy_flag & mask)
 						can_busy_loop = true;
 
+				} else {
+					bad_fd = true;
 				}
 			}
 			if (res_in)
@@ -578,6 +581,10 @@ static int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)
 			retval = table.error;
 			break;
 		}
+		if (bad_fd) {
+			retval = -EBADF;
+			break;
+		}
 
 		/* only if found POLL_BUSY_LOOP sockets && not out of time */
 		if (can_busy_loop && !need_resched()) {
-- 
2.31.1


--65gncorjdzigsipi--
