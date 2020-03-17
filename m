Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0D818823C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 12:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgCQLcB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 07:32:01 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40230 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgCQLcB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:32:01 -0400
Received: by mail-lj1-f195.google.com with SMTP id 19so22340506ljj.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2020 04:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WmJlBqTMa5CmdiFIToGjODDNiC8IWRj11NilEIEtQyE=;
        b=F+QLlWXHueXk9FIie+nFx5HGLWeGdYJkP1o+weY4/OE7tGYvjaycevNwN888rlgn8/
         nTLBUXpuzAe/IDou25ef/q2vc4WvRwwug6YUdLnhfXfZVDS8027fcl7ELowhrgXoSEtY
         KB/HU3ypUqaJZR6sLIjBk22EL59kT6FsLYCgoS79hCVnV/7uXK3bACbOAImWiQ5zfDmV
         OlqVjFhQ0dUs97Wu5f1FzjrVVB4iciokJnoUKu5vXptLshhJeBCg7P7kDhQ349KTiC7w
         /97l8ecM3Q9N+M80A4VduEj/zPXxW7kDiUmHHsoK/FaHIwVXsqo7l7hu1VHHRoZeT6xI
         r3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WmJlBqTMa5CmdiFIToGjODDNiC8IWRj11NilEIEtQyE=;
        b=KvQUHqQwH1sMA1LjXXP5jsl7k6EvV4F0hAldJqpI0KEuFF04lIN33EbOOCDK9/cekD
         yZbc37dZ+9S1zegb8Cf7nueSwJWJAkWdfQdpzTC75SwV0lNsCKV2kZNgXhbbW6K0To7t
         B5BW2I5JnMfdOWQM2Ot1uJ8FlKSnOudbPbHc0k4fmy2be4VqbgG3XToBpqufN6kvA4Z/
         7guF2RsmxLqKbJsnFx1s++idfQKK8YOY9HjkZOuC2paO320cTCCPuVmIZ0QidxlANIHS
         RUavRGjCeim7hsAbn9mRj2Prtf4hRG+tsqDYQJA5bJGb39AUARdUupKV8/sdGXoxiJKq
         JBtw==
X-Gm-Message-State: ANhLgQ3Nyum0LkGg681BPvBZUpTbyQ9gF7Mf/C3uETMDVxGjRuZgZoFP
        6XpNDOZcvjlxBxtEK7NVMkE1uyr1YteD1w==
X-Google-Smtp-Source: ADFU+vuUA0PtGuRfrupcVqALAoBlNnXdvyHxT7lgi1sZxyelUn5XW7P+x0jA+NKEwgdlYgklvWkvNA==
X-Received: by 2002:a2e:9804:: with SMTP id a4mr500667ljj.180.1584444717157;
        Tue, 17 Mar 2020 04:31:57 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id a18sm2105691ljn.85.2020.03.17.04.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 04:31:56 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        Peter Maydell <peter.maydell@linaro.org>,
        Andy Lutomirski <luto@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] ext4: Give 32bit personalities 32bit hashes
Date:   Tue, 17 Mar 2020 12:31:53 +0100
Message-Id: <20200317113153.7945-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It was brought to my attention that this bug from 2018 was
still unresolved: 32 bit emulators like QEMU were given
64 bit hashes when running 32 bit emulation on 64 bit systems.

The personality(2) system call supports to let processes
indicate that they are 32 bit Linux to the kernel. This
was suggested by Teo in the original thread, so I just wired
it up and it solves the problem.

Programs that need the 32 bit hash only need to issue the
personality(PER_LINUX32) call and things start working.

I made a test program like this:

  #include <dirent.h>
  #include <errno.h>
  #include <stdio.h>
  #include <string.h>
  #include <sys/types.h>
  #include <sys/personality.h>

  int main(int argc, char** argv) {
    DIR* dir;
    personality(PER_LINUX32);
    dir = opendir("/boot");
    printf("dir=%p\n", dir);
    printf("readdir(dir)=%p\n", readdir(dir));
    printf("errno=%d: %s\n", errno, strerror(errno));
    return 0;
  }

This was compiled with an ARM32 toolchain from Bootlin using
glibc 2.28 and thus suffering from the bug.

Before the patch:

  $ ./readdir-bug
  dir=0x86000
  readdir(dir)=(nil)
  errno=75: Value too large for defined data type

After the patch:

  $ ./readdir-bug
  dir=0x86000
  readdir(dir)=0x86020
  errno=0: Success

Problem solved.

Cc: Florian Weimer <fw@deneb.enyo.de>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: stable@vger.kernel.org
Suggested-by: Theodore Ts'o <tytso@mit.edu>
Link: https://bugs.launchpad.net/qemu/+bug/1805913
Link: https://lore.kernel.org/lkml/87bm56vqg4.fsf@mid.deneb.enyo.de/
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205957
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 fs/ext4/dir.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 9aa1f75409b0..3faf9edf3e92 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/iversion.h>
 #include <linux/unicode.h>
+#include <linux/personality.h>
 #include "ext4.h"
 #include "xattr.h"
 
@@ -618,6 +619,14 @@ static int ext4_dx_readdir(struct file *file, struct dir_context *ctx)
 
 static int ext4_dir_open(struct inode * inode, struct file * filp)
 {
+	/*
+	 * If we are currently running e.g. a 32 bit emulator on
+	 * a 64 bit machine, the emulator will indicate that it needs
+	 * a 32 bit personality and thus 32 bit hashes from the file
+	 * system.
+	 */
+	if (personality(current->personality) == PER_LINUX32)
+		filp->f_mode |= FMODE_32BITHASH;
 	if (IS_ENCRYPTED(inode))
 		return fscrypt_get_encryption_info(inode) ? -EACCES : 0;
 	return 0;
-- 
2.24.1

