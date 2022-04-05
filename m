Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAFE4F2D45
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Apr 2022 13:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239257AbiDEJxN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 05:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244165AbiDEJlJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:41:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850F2BABB2;
        Tue,  5 Apr 2022 02:25:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22EE96164E;
        Tue,  5 Apr 2022 09:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD8CC385A0;
        Tue,  5 Apr 2022 09:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649150722;
        bh=qf4ZwozjSQoZIc83YqsJxUrUHToM2owTQGjbfuCX/KU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EmoXBARIZ7xj0IZzawdm+k2cqzZUTo02txyP3HbmeUr0tnpVHvpOv8iyaRHSDqDIT
         oxshoyUled4saJ8wtvS23eix+wsNAIxnVZxyKgzK9okkofqFaP8z7epYM2E2CTdvri
         Z9+o4OYgR8+NsWhxpi8Zk8dOR+SNyRLqEDP82Dfo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ariadne Conill <ariadne@dereferenced.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Rich Felker <dalias@libc.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 5.15 156/913] exec: Force single empty string when argv is empty
Date:   Tue,  5 Apr 2022 09:20:18 +0200
Message-Id: <20220405070344.514801608@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070339.801210740@linuxfoundation.org>
References: <20220405070339.801210740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

commit dcd46d897adb70d63e025f175a00a89797d31a43 upstream.

Quoting[1] Ariadne Conill:

"In several other operating systems, it is a hard requirement that the
second argument to execve(2) be the name of a program, thus prohibiting
a scenario where argc < 1. POSIX 2017 also recommends this behaviour,
but it is not an explicit requirement[2]:

    The argument arg0 should point to a filename string that is
    associated with the process being started by one of the exec
    functions.
...
Interestingly, Michael Kerrisk opened an issue about this in 2008[3],
but there was no consensus to support fixing this issue then.
Hopefully now that CVE-2021-4034 shows practical exploitative use[4]
of this bug in a shellcode, we can reconsider.

This issue is being tracked in the KSPP issue tracker[5]."

While the initial code searches[6][7] turned up what appeared to be
mostly corner case tests, trying to that just reject argv == NULL
(or an immediately terminated pointer list) quickly started tripping[8]
existing userspace programs.

The next best approach is forcing a single empty string into argv and
adjusting argc to match. The number of programs depending on argc == 0
seems a smaller set than those calling execve with a NULL argv.

Account for the additional stack space in bprm_stack_limits(). Inject an
empty string when argc == 0 (and set argc = 1). Warn about the case so
userspace has some notice about the change:

    process './argc0' launched './argc0' with NULL argv: empty string added

Additionally WARN() and reject NULL argv usage for kernel threads.

[1] https://lore.kernel.org/lkml/20220127000724.15106-1-ariadne@dereferenced.org/
[2] https://pubs.opengroup.org/onlinepubs/9699919799/functions/exec.html
[3] https://bugzilla.kernel.org/show_bug.cgi?id=8408
[4] https://www.qualys.com/2022/01/25/cve-2021-4034/pwnkit.txt
[5] https://github.com/KSPP/linux/issues/176
[6] https://codesearch.debian.net/search?q=execve%5C+*%5C%28%5B%5E%2C%5D%2B%2C+*NULL&literal=0
[7] https://codesearch.debian.net/search?q=execlp%3F%5Cs*%5C%28%5B%5E%2C%5D%2B%2C%5Cs*NULL&literal=0
[8] https://lore.kernel.org/lkml/20220131144352.GE16385@xsang-OptiPlex-9020/

Reported-by: Ariadne Conill <ariadne@dereferenced.org>
Reported-by: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Rich Felker <dalias@libc.org>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Christian Brauner <brauner@kernel.org>
Acked-by: Ariadne Conill <ariadne@dereferenced.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20220201000947.2453721-1-keescook@chromium.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/exec.c |   26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

--- a/fs/exec.c
+++ b/fs/exec.c
@@ -494,8 +494,14 @@ static int bprm_stack_limits(struct linu
 	 * the stack. They aren't stored until much later when we can't
 	 * signal to the parent that the child has run out of stack space.
 	 * Instead, calculate it here so it's possible to fail gracefully.
+	 *
+	 * In the case of argc = 0, make sure there is space for adding a
+	 * empty string (which will bump argc to 1), to ensure confused
+	 * userspace programs don't start processing from argv[1], thinking
+	 * argc can never be 0, to keep them from walking envp by accident.
+	 * See do_execveat_common().
 	 */
-	ptr_size = (bprm->argc + bprm->envc) * sizeof(void *);
+	ptr_size = (max(bprm->argc, 1) + bprm->envc) * sizeof(void *);
 	if (limit <= ptr_size)
 		return -E2BIG;
 	limit -= ptr_size;
@@ -1895,6 +1901,9 @@ static int do_execveat_common(int fd, st
 	}
 
 	retval = count(argv, MAX_ARG_STRINGS);
+	if (retval == 0)
+		pr_warn_once("process '%s' launched '%s' with NULL argv: empty string added\n",
+			     current->comm, bprm->filename);
 	if (retval < 0)
 		goto out_free;
 	bprm->argc = retval;
@@ -1921,6 +1930,19 @@ static int do_execveat_common(int fd, st
 	if (retval < 0)
 		goto out_free;
 
+	/*
+	 * When argv is empty, add an empty string ("") as argv[0] to
+	 * ensure confused userspace programs that start processing
+	 * from argv[1] won't end up walking envp. See also
+	 * bprm_stack_limits().
+	 */
+	if (bprm->argc == 0) {
+		retval = copy_string_kernel("", bprm);
+		if (retval < 0)
+			goto out_free;
+		bprm->argc = 1;
+	}
+
 	retval = bprm_execve(bprm, fd, filename, flags);
 out_free:
 	free_bprm(bprm);
@@ -1949,6 +1971,8 @@ int kernel_execve(const char *kernel_fil
 	}
 
 	retval = count_strings_kernel(argv);
+	if (WARN_ON_ONCE(retval == 0))
+		retval = -EINVAL;
 	if (retval < 0)
 		goto out_free;
 	bprm->argc = retval;


