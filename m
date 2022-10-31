Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0256D613C9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 18:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiJaRxK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 13:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiJaRxF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:53:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF6E13D4A
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 10:53:03 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a14so17053951wru.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 10:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U7UbF4nZPug8lSmlrO1tsRcqhQZwCNdlA+12Y/ynwzs=;
        b=Y097of5rV70g0ZvYp+B8s8y1ErB3xlFNDaYW6ykJJYNatkuqJlr+z+CyX0O3OdoplY
         3mu+Og8NL2wgCY/UedkxZg/63j/icDlf6ELFCdMtov2T/caOd8nStl63B1f6Ng8tcU1M
         5hgV7wZQwyNOFnJIJGLc7IfcKpyE6ArcZAM/dMQojkvPcXsLX6wzBQ4wxV0vVsqUBgQo
         nlt47HP/JLDJZw1BxKGWt8/cguUb1ck9UcwvtLChSK4ybEORV7tsGUXsaKD8Z+PJmzIw
         A5XIJIsaFJUKt+TXFuyjzrL8cPOIZQL4DK4C9/b8ysCbhMYRzIA+6uJ2wpervRsmuhoV
         ljgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U7UbF4nZPug8lSmlrO1tsRcqhQZwCNdlA+12Y/ynwzs=;
        b=jT3tEBSJzTn/PTo2fCbm+YaH0q+pxSj8flYajUF5pJPJdznHmGD6bHSUhkiIFlqzrY
         5dO+0FgqFpLkTlwzbFJ1rHqVnYwQBD2IHVuNyc5hwYqgqTvxJDo0zdrhuzvnrV9sG9sd
         vlqakkBQk9ee2wViWfUnMy1GhrlTG8nUQ7Q4b5vnxN07FvTz1SJ8JWdg3eC5p9giLqRe
         G0Yvuyta+wtLRCQ89VUy3eL1MYI6Pwn5VjWE9v4BAVJrxoXPSbSCGZIIFACe4JBbThxe
         x3Cobntp2i07XY9uhGMea1PPtVGlLKSbIkb6IWDS6U9xy/yX8PiXkIfe8Ojh31n+//dw
         YXlg==
X-Gm-Message-State: ACrzQf2KTWryb3JkQDBR+Cd2McOSfn0q4EIy03qch/bUzYn8oBVjUn5b
        lnVyhclVnHhfZkaN5DmyE/5Fg06fj0K6PA==
X-Google-Smtp-Source: AMsMyM5ksIiwwEdcbAoXUp9mw+fnCu32gyggOowB0ZCU9CcmXDMrGnGnJ7hKs8yI9xpzoMHb2FouMw==
X-Received: by 2002:a05:6000:1841:b0:236:70dc:1a6f with SMTP id c1-20020a056000184100b0023670dc1a6fmr9096259wri.464.1667238782105;
        Mon, 31 Oct 2022 10:53:02 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:f03a:db2e:7a5c:b47c])
        by smtp.gmail.com with ESMTPSA id w12-20020a5d404c000000b002365254ea42sm7937270wrp.1.2022.10.31.10.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 10:53:01 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
Subject: [PATCH v2] fs: use acquire ordering in __fget_light()
Date:   Mon, 31 Oct 2022 18:52:56 +0100
Message-Id: <20221031175256.2813280-1-jannh@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We must prevent the CPU from reordering the files->count read with the
FD table access like this, on architectures where read-read reordering is
possible:

    files_lookup_fd_raw()
                                  close_fd()
                                  put_files_struct()
    atomic_read(&files->count)

I would like to mark this for stable, but the stable rules explicitly say
"no theoretical races", and given that the FD table pointer and
files->count are explicitly stored in the same cacheline, this sort of
reordering seems quite unlikely in practice...

Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/file.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/file.c b/fs/file.c
index 5f9c802a5d8d3..c942c89ca4cda 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1003,7 +1003,16 @@ static unsigned long __fget_light(unsigned int fd, f=
mode_t mask)
 	struct files_struct *files =3D current->files;
 	struct file *file;
=20
-	if (atomic_read(&files->count) =3D=3D 1) {
+	/*
+	 * If another thread is concurrently calling close_fd() followed
+	 * by put_files_struct(), we must not observe the old table
+	 * entry combined with the new refcount - otherwise we could
+	 * return a file that is concurrently being freed.
+	 *
+	 * atomic_read_acquire() pairs with atomic_dec_and_test() in
+	 * put_files_struct().
+	 */
+	if (atomic_read_acquire(&files->count) =3D=3D 1) {
 		file =3D files_lookup_fd_raw(files, fd);
 		if (!file || unlikely(file->f_mode & mask))
 			return 0;

base-commit: 30a0b95b1335e12efef89dd78518ed3e4a71a763
--=20
2.38.1.273.g43a17bfeac-goog

