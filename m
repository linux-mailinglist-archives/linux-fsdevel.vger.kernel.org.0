Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7B249C2C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 05:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbiAZEsy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 23:48:54 -0500
Received: from mx1.mailbun.net ([170.39.20.100]:35952 "EHLO mx1.mailbun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232432AbiAZEsy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 23:48:54 -0500
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jan 2022 23:48:54 EST
Received: from localhost.localdomain (unknown [170.39.20.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ariadne@dereferenced.org)
        by mx1.mailbun.net (Postfix) with ESMTPSA id 028D1E03DA;
        Wed, 26 Jan 2022 04:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dereferenced.org;
        s=mailbun; t=1643171994;
        bh=4nnMnUbFTs6hDVYWjYDILAGkt7JwLNkIScd3QeqynKQ=;
        h=From:To:Cc:Subject:Date;
        b=FxokfEp1KrENkBXoKKat/N3TxFAT8EUg0Itzt1xhLib2W78Jy8LiUL6GDAz7SBR0r
         fA9Ab1JA/Ha0HtR7rOpoosDLiISo/89ohP+FUup6oakR05Dbq5mC66feA17S5QvUkM
         83bTS/FWSP2WeNGEUNHIs/OcL35dZ+qmV0WEI42LXIt22PKzC5P8KImAgxfRLoGoEG
         JMYw0NQxYuhums0whoLe3lZa+t1m+1WGPiJ2O9ai8fzKxCSOFbR3TipfNlx+MyZThJ
         L+wOfUEhbnzxjybrZ9pu2YLvhHpELTulBCUtdwkWc38wmkxTU9LR+R+bPYuThmgdru
         kKBLKQOcnYRkA==
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ariadne Conill <ariadne@dereferenced.org>
Subject: [PATCH] fs/exec: require argv[0] presence in do_execveat_common()
Date:   Wed, 26 Jan 2022 04:39:47 +0000
Message-Id: <20220126043947.10058-1-ariadne@dereferenced.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The first argument to argv when used with execv family of calls is
required to be the name of the program being executed, per POSIX.

By validating this in do_execveat_common(), we can prevent execution
of shellcode which invokes execv(2) family syscalls with argc < 1,
a scenario which is disallowed by POSIX, thus providing a mitigation
against CVE-2021-4034 and similar bugs in the future.

The use of -EFAULT for this case is similar to other systems, such
as FreeBSD and OpenBSD.

Interestingly, Michael Kerrisk opened an issue about this in 2008,
but there was no consensus to support fixing this issue then.
Hopefully now that CVE-2021-4034 shows practical exploitative use
of this bug in a shellcode, we can reconsider.

Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>
---
 fs/exec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 79f2c9483302..de0b832473ed 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1897,8 +1897,10 @@ static int do_execveat_common(int fd, struct filename *filename,
 	}
 
 	retval = count(argv, MAX_ARG_STRINGS);
-	if (retval < 0)
+	if (retval < 1) {
+		retval = -EFAULT;
 		goto out_free;
+	}
 	bprm->argc = retval;
 
 	retval = count(envp, MAX_ARG_STRINGS);
-- 
2.34.1

