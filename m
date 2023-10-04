Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A9C7B7F9A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 14:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242486AbjJDMqg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 08:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242492AbjJDMqf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:46:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA1AA9
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Oct 2023 05:46:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 472BE1F74D;
        Wed,  4 Oct 2023 12:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696423590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VeItCfmREetMZWOyX+YlTVpWpRrFsfEO9h9NMi+hFF4=;
        b=NjygP4OoL0voA6n/laTXMpQgECPb+aGqkdWHZoxcFzzc/u0oWpperwPsHd1LAUSc6PkNVh
        6kD8ppsSz+vYxbMr5oTc0AWj0G+cIZ52sfYWKgGBsA2u9PqFSFswuroWw56kZXI7dQT4OI
        TaJJ2M5ttQUDL3yH1OXxpzGOpmzP3J8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696423590;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VeItCfmREetMZWOyX+YlTVpWpRrFsfEO9h9NMi+hFF4=;
        b=RUvomOcmVyLNb54amrb/byVARm9JdWj7NtSqY/lRUYoKIqa6p8etlnDwFVLnx10QIvI4t4
        nXkEpGm+0jy5ohDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 328D413A2E;
        Wed,  4 Oct 2023 12:46:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vdzuCqZeHWXdPAAAMHmgww
        (envelope-from <chrubis@suse.cz>); Wed, 04 Oct 2023 12:46:30 +0000
From:   Cyril Hrubis <chrubis@suse.cz>
To:     ltp@lists.linux.it
Cc:     Matthew Wilcox <willy@infradead.org>, amir73il@gmail.com,
        mszeredi@redhat.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] syscalls/readahead01: Make use of tst_fd_iterate()
Date:   Wed,  4 Oct 2023 14:47:11 +0200
Message-ID: <20231004124712.3833-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004124712.3833-1-chrubis@suse.cz>
References: <20231004124712.3833-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TODO: readahead() on /proc/self/maps seems to succeed is that to be
      expected?

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../kernel/syscalls/readahead/readahead01.c   | 46 ++++++++-----------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/testcases/kernel/syscalls/readahead/readahead01.c b/testcases/kernel/syscalls/readahead/readahead01.c
index bdef7945d..28134d416 100644
--- a/testcases/kernel/syscalls/readahead/readahead01.c
+++ b/testcases/kernel/syscalls/readahead/readahead01.c
@@ -29,44 +29,38 @@
 #if defined(__NR_readahead)
 
 static void test_bad_fd(void)
-{
-	char tempname[PATH_MAX] = "readahead01_XXXXXX";
-	int fd;
-
-	tst_res(TINFO, "%s -1", __func__);
-	TST_EXP_FAIL(readahead(-1, 0, getpagesize()), EBADF);
-
-	tst_res(TINFO, "%s O_WRONLY", __func__);
-	fd = mkstemp(tempname);
-	if (fd == -1)
-		tst_res(TFAIL | TERRNO, "mkstemp failed");
-	SAFE_CLOSE(fd);
-	fd = SAFE_OPEN(tempname, O_WRONLY);
-	TST_EXP_FAIL(readahead(fd, 0, getpagesize()), EBADF);
-	SAFE_CLOSE(fd);
-	unlink(tempname);
-}
-
-static void test_invalid_fd(void)
 {
 	int fd[2];
 
-	tst_res(TINFO, "%s pipe", __func__);
+	TST_EXP_FAIL(readahead(-1, 0, getpagesize()), EBADF,
+	             "readahead() with fd = -1");
+
 	SAFE_PIPE(fd);
-	TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EINVAL);
 	SAFE_CLOSE(fd[0]);
 	SAFE_CLOSE(fd[1]);
 
-	tst_res(TINFO, "%s socket", __func__);
-	fd[0] = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
-	TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EINVAL);
-	SAFE_CLOSE(fd[0]);
+	TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EBADF,
+	             "readahead() with invalid fd");
+}
+
+static void test_invalid_fd(struct tst_fd *fd)
+{
+	switch (fd->type) {
+	case TST_FD_FILE:
+	case TST_FD_PIPE_OUT:
+		return;
+	default:
+		break;
+	}
+
+	TST_EXP_FAIL(readahead(fd->fd, 0, getpagesize()), EINVAL,
+		     "readahead() on %s", tst_fd_desc(fd));
 }
 
 static void test_readahead(void)
 {
 	test_bad_fd();
-	test_invalid_fd();
+	tst_fd_iterate(test_invalid_fd);
 }
 
 static void setup(void)
-- 
2.41.0

