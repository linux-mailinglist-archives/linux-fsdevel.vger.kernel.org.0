Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6634767328
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 18:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfGLQSa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 12:18:30 -0400
Received: from bran.ispras.ru ([83.149.199.196]:30264 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726449AbfGLQS3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 12:18:29 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jul 2019 12:18:28 EDT
Received: from falasarna.intra.ispras.ru (falasarna.intra.ispras.ru [10.10.3.49])
        by smtp.ispras.ru (Postfix) with ESMTP id D61F9201D0;
        Fri, 12 Jul 2019 19:13:23 +0300 (MSK)
From:   Alexey Izbyshev <izbyshev@ispras.ru>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        security@kernel.org, Alexey Izbyshev <izbyshev@ispras.ru>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH] proc: Fix uninitialized byte read in get_mm_cmdline()
Date:   Fri, 12 Jul 2019 19:09:13 +0300
Message-Id: <20190712160913.17727-1-izbyshev@ispras.ru>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

get_mm_cmdline() leaks an uninitialized byte located at
user-controlled offset in a newly-allocated kernel page in
the following scenario.

- When reading the last chunk of cmdline, access_remote_vm()
  fails to copy the requested number of bytes, but still copies
  enough bytes so that we get into the body of
  "if (pos + got >= arg_end)" statement. This can be arranged by user,
  for example, by applying mprotect(PROT_NONE) to the env block.

- strnlen() doesn't find a NUL byte. This too can be arranged
  by user via suitable modifications of argument and env blocks.

- The above causes the following condition to be true despite
  that no NUL byte was found:

	/* Include the NUL if it existed */
	if (got < size)
		got++;

The resulting increment causes the subsequent copy_to_user()
to copy an extra byte from "page" to userspace. That byte might
come from previous uses of memory referred by "page" before
it was allocated by get_mm_cmdline(), potentially leaking
data belonging to other processes or kernel.

Fix this by ensuring that "size + offset" doesn't exceed the number
of bytes copied by access_remote_vm().

Fixes: f5b65348fd77 ("proc: fix missing final NUL in get_mm_cmdline() rewrite")
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Alexey Izbyshev <izbyshev@ispras.ru>
---

This patch was initially sent to <security@kernel.org> accompanied
with a little program that exploits the bug to dump the kernel page
used in get_mm_cmdline().

Thanks to Oleg Nesterov and Laura Abbott for their feedback!

 fs/proc/base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 255f6754c70d..6e30dd791761 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -275,6 +275,8 @@ static ssize_t get_mm_cmdline(struct mm_struct *mm, char __user *buf,
 		if (got <= offset)
 			break;
 		got -= offset;
+		if (got < size)
+			size = got;
 
 		/* Don't walk past a NUL character once you hit arg_end */
 		if (pos + got >= arg_end) {
-- 
2.21.0

