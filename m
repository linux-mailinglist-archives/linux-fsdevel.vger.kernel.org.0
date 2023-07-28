Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698B4766C45
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 13:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbjG1L7M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 07:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236338AbjG1L7H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:59:07 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA8F3C2F;
        Fri, 28 Jul 2023 04:59:04 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RC5l91gd3z9sTn;
        Fri, 28 Jul 2023 13:59:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1690545541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9/8Enmq6dGEBOaAdXif/TTkAgQwGHnKWZ5AzFbgN4lM=;
        b=t5NZavTc7lWMKBbq8l3ZnXRLu/MSHXptAjkir+IPnEbyJtD5N+MkUUZW4zTOWwNf2tiqzU
        /zRFaTWsRg705H2Svh+ckkCC1uUTfv5zRQfRac37UDqlVvB1UaRwHRhzWKtaJuXB6JXrBh
        YS0s0IFQeC7V+g++epP5p17PlYO0wu9ez6u/1lRDrTJ1BBJqeW/krT6PDXd2hmOUvyTQGC
        laYDsAPgtBG6N9QxDcA3ndGe2StnvvdBQvPiTVcga4jkGnnniZSz3bGGMcdbYgxZV2cagy
        SiodEq0drMJBmEQJApSnSyTpYEQxHDwSCNoeGcalJ57epuPhXNMVGes8bM/H6g==
From:   Aleksa Sarai <cyphar@cyphar.com>
Date:   Fri, 28 Jul 2023 21:58:26 +1000
Subject: [PATCH] fchmodat2: add support for AT_EMPTY_PATH
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230728-fchmodat2-at_empty_path-v1-1-f3add31d3516@cyphar.com>
X-B4-Tracking: v=1; b=H4sIAGGtw2QC/x3MTQqAIBBA4avErBN0Cvq5SoSIjTmLSlSiiO6et
 PwW7z2QKDIlGKsHIp2c+NgLVF2B9WZfSfBSDCixkR32wlm/HYvJKEzWtIV862CyF42S1rXSDqg
 clDpEcnz952l+3w8jpB3yaQAAAA==
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Alexey Gladkov <legion@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1877; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=Sdckq9QBnej4bYwFL1SzVqR7z5ef8LWJ7BK0J1vaGeM=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaQcXls/546PAaPoeos/bF1/XzHtjn7Pe6ib3eDr0o8BK
 dN2Rc2e1FHKwiDGxSArpsiyzc8zdNP8xVeSP61kg5nDygQyhIGLUwAm0r6c4Z9m64T9W5KdbQKO
 uuz6lMgyY/Hy/H0BiQZXV96SbincMIGXkWG5ePa9Dw+WiBV8mCXF7/sgc9EZkdnPcryaZNOy2HJ
 3RbICAA==
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This allows userspace to avoid going through /proc/self/fd when dealing
with all types of file descriptors for chmod(), and makes fchmodat2() a
proper superset of all other chmod syscalls.

The primary difference between fchmodat2(AT_EMPTY_PATH) and fchmod() is
that fchmod() doesn't operate on O_PATH file descriptors by design. To
quote open(2):

> O_PATH (since Linux 2.6.39)
> [...]
> The file itself is not opened, and other file operations (e.g.,
> read(2), write(2), fchmod(2), fchown(2), fgetxattr(2), ioctl(2),
> mmap(2)) fail with the error EBADF.

However, procfs has allowed userspace to do this operation ever since
the introduction of O_PATH through magic-links, so adding this feature
is only an improvement for programs that have to mess around with
/proc/self/fd/$n today to get this behaviour. In addition,
fchownat(AT_EMPTY_PATH) has existed since the introduction of O_PATH and
allows chown() operations directly on O_PATH descriptors.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/open.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index e52d78e5a333..b8883ec286f5 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -678,10 +678,12 @@ static int do_fchmodat(int dfd, const char __user *filename, umode_t mode,
 	int error;
 	unsigned int lookup_flags;
 
-	if (unlikely(flags & ~AT_SYMLINK_NOFOLLOW))
+	if (unlikely(flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)))
 		return -EINVAL;
 
 	lookup_flags = (flags & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FOLLOW;
+	if (flags & AT_EMPTY_PATH)
+		lookup_flags |= LOOKUP_EMPTY;
 
 retry:
 	error = user_path_at(dfd, filename, lookup_flags, &path);

---
base-commit: 4859c257d295949c23f4074850a8c2ec31357abb
change-id: 20230728-fchmodat2-at_empty_path-310cf40c921f

Best regards,
-- 
Aleksa Sarai <cyphar@cyphar.com>

