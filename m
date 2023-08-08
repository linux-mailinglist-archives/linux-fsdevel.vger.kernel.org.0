Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FBD77487B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 21:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbjHHTdc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 15:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236300AbjHHTdQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:33:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88336222CE;
        Tue,  8 Aug 2023 10:36:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27E1F62788;
        Tue,  8 Aug 2023 17:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0D4C433CA;
        Tue,  8 Aug 2023 17:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691516162;
        bh=hcG4JmKbckgBfZQK+co26W7c8YuOsWmymvwei5Re2CI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SPUyRYpGDpWAlgSxVECNisRsgXC4PoBQ+eBMJhF7XdSHKz2E9gBDN+Pxg0lP0wU1V
         2lCOH7/ZROGbo7lJNKqYS9RJlrtdSi9smaFktr90RigvyiEvGzVVCm5dpND2jX22zd
         8NJKXEoMaFZb9ccH0lYCgytrz67B6xoVVUNH/0MfOlPmA9ff8GSUu0D/loc0LbmkgX
         wNwJDJeQdfQz9XhnL0oGLvCMPPRiQd6RTV+g/iirsuTEYGJPIEE0QWR9N45M7bNEso
         7KlV8wPWejHTzbQnemdbRMBwAH5SjYxixq07kmZCGvgWl5oaC4UBaneWhn3o4DZsUy
         Dg2hwoKZa706w==
Date:   Tue, 8 Aug 2023 19:35:58 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mateusz Guzik <mjguzik@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] fs: use __fput_sync in close(2)
Message-ID: <20230808-divers-verehren-02abcc37fe60@brauner>
References: <20230806230627.1394689-1-mjguzik@gmail.com>
 <87o7jidqlg.fsf@email.froward.int.ebiederm.org>
 <CAHk-=whk-8Pv5YXH4jNfyAf2xiQCGCUVyBWw71qJEafn4mT6vw@mail.gmail.com>
 <CAGudoHE5UDj0Y7fY=gicOq8Je=e1MX+5VWo04qoDRpHRG03fFg@mail.gmail.com>
 <CAHk-=wj+Uu+=iUZLc+MfOBKgRoyM56c0z0ustZKru0We9os63A@mail.gmail.com>
 <CAGudoHE=jJ+MKduj9-95Nk8_F=fkv2P+akftvFw1fVr46jm8ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ooa7r4rkjff7kak6"
Content-Disposition: inline
In-Reply-To: <CAGudoHE=jJ+MKduj9-95Nk8_F=fkv2P+akftvFw1fVr46jm8ng@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ooa7r4rkjff7kak6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

> you guys sort it out ;)

You're all driving me nuts. ;)
Fixed patch appended and put on vfs.misc for testing...
@Linus, you ok with the appended thing?

--ooa7r4rkjff7kak6
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-fs-use-__fput_sync-in-close-2.patch"

From 9b0919d12c74b3de6c23c52dc5b3d6ffd24fecee Mon Sep 17 00:00:00 2001
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 8 Aug 2023 19:26:35 +0200
Subject: [PATCH] fs: use __fput_sync in close(2)

close(2) is a special case which guarantees a shallow kernel stack,
making delegation to task_work machinery unnecessary. Said delegation is
problematic as it involves atomic ops and interrupt masking trips, none
of which are cheap on x86-64. Forcing close(2) to do it looks like an
oversight in the original work.

Moreover presence of CONFIG_RSEQ adds an additional overhead as fput()
-> task_work_add(..., TWA_RESUME) -> set_notify_resume() makes the
thread returning to userspace land in resume_user_mode_work(), where
rseq_handle_notify_resume takes a SMAP round-trip if rseq is enabled for
the thread (and it is by default with contemporary glibc).

Sample result when benchmarking open1_processes -t 1 from will-it-scale
(that's an open + close loop) + tmpfs on /tmp, running on the Sapphire
Rapid CPU (ops/s):
stock+RSEQ:     1329857
stock-RSEQ:     1421667 (+7%)
patched:        1523521 (+14.5% / +7%) (with / without rseq)

Patched result is the same regardless of rseq as the codepath is avoided.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/file_table.c |  5 +----
 fs/open.c       | 27 ++++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index fc7d677ff5ad..ee21b3da9d08 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -461,11 +461,8 @@ void fput(struct file *file)
  */
 void __fput_sync(struct file *file)
 {
-	if (atomic_long_dec_and_test(&file->f_count)) {
-		struct task_struct *task = current;
-		BUG_ON(!(task->flags & PF_KTHREAD));
+	if (atomic_long_dec_and_test(&file->f_count))
 		__fput(file);
-	}
 }
 
 EXPORT_SYMBOL(fput);
diff --git a/fs/open.c b/fs/open.c
index e6ead0f19964..1f5b3a5f7f18 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1503,7 +1503,7 @@ SYSCALL_DEFINE2(creat, const char __user *, pathname, umode_t, mode)
  * "id" is the POSIX thread ID. We use the
  * files pointer for this..
  */
-int filp_close(struct file *filp, fl_owner_t id)
+static int filp_flush(struct file *filp, fl_owner_t id)
 {
 	int retval = 0;
 
@@ -1520,10 +1520,18 @@ int filp_close(struct file *filp, fl_owner_t id)
 		dnotify_flush(filp, id);
 		locks_remove_posix(filp, id);
 	}
-	fput(filp);
 	return retval;
 }
 
+int filp_close(struct file *filp, fl_owner_t id)
+{
+	int retval;
+
+	retval = filp_flush(filp, id);
+	fput(filp);
+
+	return retval;
+}
 EXPORT_SYMBOL(filp_close);
 
 /*
@@ -1533,7 +1541,20 @@ EXPORT_SYMBOL(filp_close);
  */
 SYSCALL_DEFINE1(close, unsigned int, fd)
 {
-	int retval = close_fd(fd);
+	int retval;
+	struct file *file;
+
+	file = close_fd_get_file(fd);
+	if (!file)
+		return -EBADF;
+
+	retval = filp_flush(file, current->files);
+
+	/*
+	 * We're returning to user space. Don't bother
+	 * with any delayed fput() cases.
+	 */
+	__fput_sync(file);
 
 	/* can't restart close syscall because file table entry was cleared */
 	if (unlikely(retval == -ERESTARTSYS ||
-- 
2.34.1


--ooa7r4rkjff7kak6--
