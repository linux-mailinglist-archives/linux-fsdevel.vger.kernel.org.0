Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6212404FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 13:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgHJLCp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 07:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgHJLCm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 07:02:42 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C8FC061786
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 04:02:41 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w25so9031602ljo.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 04:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U2JMQwQuDgHlcfFwPb65GGl9226SqxYKSo8gW1+qV4A=;
        b=ycd09Q6Ye7sc8xqUC49v6AA4FxlLR1Hhhh1W8l247b5DxMeoGrHGyCyBbcY+ZiSH90
         GeV1Cf91H5eFnM79C4JBDeH9AXTAfcF7ZDnLEOm5K2bMnAM4iFLTNk+ZxhgM0X9fCmmD
         ZTurMhH/RXWXDFaHBRgqIxCSL+pjcAemO3QhifUTqZlHj2WS1S6BNKnBgDBRLmszQ3V9
         Ps1F8x7lzay/fBYHEHQ45zhw8pAG4B+koE1WUB9pF9+RVvc3+qiJ738gc55yoaogOoOE
         ImEfQsr/iFcxtv087s9yBFxnrKp3K/GIPtIvcZcMneoY3EMVmvCGymFyzAAwYhiONzBa
         3oEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U2JMQwQuDgHlcfFwPb65GGl9226SqxYKSo8gW1+qV4A=;
        b=rYExZWE+7EoLk3CakTbrZS5masFOzW+qqPUGPgA/6nDqhTsOsQwq35M8jQ0WPvy9IR
         +jzS7OSiafDUiWPz9QY1z6DEl/td8jdjM1mo93mvP/hBG9O2eUkY0NHVDDaCjaz7Fl0w
         wbTDmRbmtig4cI6XbUIjsxet+5hzCT8gnARKKe2fIvxf/0RRh0IilsJi1gptsVTN+dw8
         t1djIiEmP/tYDeYfZvlWFLjLPnelYnbYkcjSSigwX3bQd5CbAtUAup8ttlkOzRbFNoDj
         Woi6/PBEd+GPmui6tllejd76vT/O7M5kYZHwZvJzOB9MizenfrF5XX4ECrYDQqqmgnr/
         zKeg==
X-Gm-Message-State: AOAM531zlVH3m9Y5gcjCrbO5FOH6gTTTLlQmLDc5IfSEx+KQMbxTwATa
        dOb2BhMvYSrsWSURIlEQDSlY+g==
X-Google-Smtp-Source: ABdhPJw3yxD6ZDS/L2suPjxFjHfDzdlOqM5qnYl24R3NyHXPuk0N9Bpai2F2cl0Q/XqafWDMauOqGA==
X-Received: by 2002:a2e:9e8a:: with SMTP id f10mr262329ljk.330.1597057357892;
        Mon, 10 Aug 2020 04:02:37 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id k12sm10551672lfe.68.2020.08.10.04.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 04:02:37 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        Peter Maydell <peter.maydell@linaro.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3] fcntl: Add 32bit filesystem mode
Date:   Mon, 10 Aug 2020 13:02:33 +0200
Message-Id: <20200810110233.4374-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It was brought to my attention that this bug from 2018 was
still unresolved: 32 bit emulators like QEMU were given
64 bit hashes when running 32 bit emulation on 64 bit systems.

This adds a flag to the fcntl() F_GETFD and F_SETFD operations
to set the underlying filesystem into 32bit mode even if the
file handle was opened using 64bit mode without the compat
syscalls.

Programs that need the 32 bit file system behavior need to
issue a fcntl() system call such as in this example:

  #define FD_32BIT_MODE 2

  int main(int argc, char** argv) {
    DIR* dir;
    int err;
    int fd;

    dir = opendir("/boot");
    fd = dirfd(dir);
    err = fcntl(fd, F_SETFD, FD_32BIT_MODE);
    if (err) {
      printf("fcntl() failed! err=%d\n", err);
      return 1;
    }
    printf("dir=%p\n", dir);
    printf("readdir(dir)=%p\n", readdir(dir));
    printf("errno=%d: %s\n", errno, strerror(errno));
    return 0;
  }

This can be pretty hard to test since C libraries and linux
userspace security extensions aggressively filter the parameters
that are passed down and allowed to commit into actual system
calls.

Cc: Florian Weimer <fw@deneb.enyo.de>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Andy Lutomirski <luto@kernel.org>
Suggested-by: Theodore Ts'o <tytso@mit.edu>
Link: https://bugs.launchpad.net/qemu/+bug/1805913
Link: https://lore.kernel.org/lkml/87bm56vqg4.fsf@mid.deneb.enyo.de/
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205957
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Realized that I also have to clear the flag correspondingly
  if someone ask for !FD_32BIT_MODE after setting it the
  first time.
ChangeLog v1->v2:
- Use a new flag FD_32BIT_MODE to F_GETFD and F_SETFD
  instead of a new fcntl operation, there is already a fcntl
  operation to set random flags.
- Sorry for taking forever to respin this patch :(
---
 fs/fcntl.c                       | 7 +++++++
 include/uapi/asm-generic/fcntl.h | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 2e4c0fa2074b..a937be835924 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -335,10 +335,17 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		break;
 	case F_GETFD:
 		err = get_close_on_exec(fd) ? FD_CLOEXEC : 0;
+		/* Report 32bit file system mode */
+		if (filp->f_mode & FMODE_32BITHASH)
+			err |= FD_32BIT_MODE;
 		break;
 	case F_SETFD:
 		err = 0;
 		set_close_on_exec(fd, arg & FD_CLOEXEC);
+		if (arg & FD_32BIT_MODE)
+			filp->f_mode |= FMODE_32BITHASH;
+		else
+			filp->f_mode &= ~FMODE_32BITHASH;
 		break;
 	case F_GETFL:
 		err = filp->f_flags;
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 9dc0bf0c5a6e..edd3573cb7ef 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -160,6 +160,14 @@ struct f_owner_ex {
 
 /* for F_[GET|SET]FL */
 #define FD_CLOEXEC	1	/* actually anything with low bit set goes */
+/*
+ * This instructs the kernel to provide 32bit semantics (such as hashes) from
+ * the file system layer, when running a userland that depend on 32bit
+ * semantics on a kernel that supports 64bit userland, but does not use the
+ * compat ioctl() for e.g. open(), so that the kernel would otherwise assume
+ * that the userland process is capable of dealing with 64bit semantics.
+ */
+#define FD_32BIT_MODE	2
 
 /* for posix fcntl() and lockf() */
 #ifndef F_RDLCK
-- 
2.26.2

