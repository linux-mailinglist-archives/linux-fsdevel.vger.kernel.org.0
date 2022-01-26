Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A748F49C8E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 12:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240855AbiAZLoz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 06:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240849AbiAZLoy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:44:54 -0500
X-Greylist: delayed 25499 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Jan 2022 03:44:53 PST
Received: from mx1.mailbun.net (unknown [IPv6:2602:fd37:1::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB25AC06161C;
        Wed, 26 Jan 2022 03:44:53 -0800 (PST)
Received: from localhost.localdomain (unknown [170.39.20.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ariadne@dereferenced.org)
        by mx1.mailbun.net (Postfix) with ESMTPSA id 5B84E11A00E;
        Wed, 26 Jan 2022 11:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dereferenced.org;
        s=mailbun; t=1643197493;
        bh=7jHNM//m/eDez5fIS/+4IvS3dV2J8nwkZpSA6zP+u9o=;
        h=From:To:Cc:Subject:Date;
        b=VgBw86tQRL0O699JNWWaPXipe4ag7eWzYI397GBI5hsEzItf1dcEMDNJSDSwH8HZd
         cIG/+B2Kj5Iy7AHJuz/lpSTGx1gtSxDPnQGPZwYxuw3LMBvg4hdo6V/hBLYJKj5XjS
         8PjE26Y4LXWK7dVJRT1V7QIEaYSgQu1z+7ZjM2JiZpb1AMP50RO+ePabw3eY/bHcfc
         wHQLfFUHVOq4eiKiuW9qmBDrR6LtTLUnsNTg6SxHSLk8NTsQFrWPdispjD1aV8Tzwy
         7WoWnRjfMKIPIbZnR33a+du0pVdLs2ZI45175M4aGGVviBty8KHJkLHD8VTYjiFC6h
         11LWmxjGcIqYQ==
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ariadne Conill <ariadne@dereferenced.org>
Subject: [PATCH v2] fs/exec: require argv[0] presence in do_execveat_common()
Date:   Wed, 26 Jan 2022 11:44:47 +0000
Message-Id: <20220126114447.25776-1-ariadne@dereferenced.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In several other operating systems, it is a hard requirement that the
first argument to execve(2) be the name of a program, thus prohibiting
a scenario where argc < 1.  POSIX 2017 also recommends this behaviour,
but it is not an explicit requirement[0]:

    The argument arg0 should point to a filename string that is
    associated with the process being started by one of the exec
    functions.

To ensure that execve(2) with argc < 1 is not a useful gadget for
shellcode to use, we can validate this in do_execveat_common() and
fail for this scenario, effectively blocking successful exploitation
of CVE-2021-4034 and similar bugs which depend on this gadget.

The use of -EFAULT for this case is similar to other systems, such
as FreeBSD, OpenBSD and Solaris.  QNX uses -EINVAL for this case.

Interestingly, Michael Kerrisk opened an issue about this in 2008[1],
but there was no consensus to support fixing this issue then.
Hopefully now that CVE-2021-4034 shows practical exploitative use
of this bug in a shellcode, we can reconsider.

[0]: https://pubs.opengroup.org/onlinepubs/9699919799/functions/exec.html
[1]: https://bugzilla.kernel.org/show_bug.cgi?id=8408

Changes from v1:
- Rework commit message significantly.
- Make the argv[0] check explicit rather than hijacking the error-check
  for count().

Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>
---
 fs/exec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 79f2c9483302..e52c41991aab 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1899,6 +1899,10 @@ static int do_execveat_common(int fd, struct filename *filename,
 	retval = count(argv, MAX_ARG_STRINGS);
 	if (retval < 0)
 		goto out_free;
+	if (retval == 0) {
+		retval = -EFAULT;
+		goto out_free;
+	}
 	bprm->argc = retval;
 
 	retval = count(envp, MAX_ARG_STRINGS);
-- 
2.34.1

