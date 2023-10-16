Return-Path: <linux-fsdevel+bounces-402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C337CA80D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 14:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555B11C20B0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 12:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB622771D;
	Mon, 16 Oct 2023 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P/5AsY4d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IXx7DWbt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF19C273D6
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 12:32:48 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379E6E6
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 05:32:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BEE24218A9;
	Mon, 16 Oct 2023 12:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697459564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HQ8pxnPeMYSbxZyOCsx64KMBH2xZTE+evVfhbydEtDI=;
	b=P/5AsY4dLZiqt5I8K89e6fvNMMm0SwGSqIj/kSxtEeX2DvgGm6SUrRievLngKXktkG1wFG
	4JvSFrQCGuZPRY/25tdCmA+v5Jl6Tw0/YXlI/d5fhvjR3D/IcOS5Yy/gwtLifCUV+WFsx7
	pfu0h93n8/7KVS5PtaEklgWX5nDReuk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697459564;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HQ8pxnPeMYSbxZyOCsx64KMBH2xZTE+evVfhbydEtDI=;
	b=IXx7DWbtBiRYLmwhPtrFWD2Hic5yfHsQinPTkI4dlX/U5P+Nldba9CrCHx8+WoWrjn2Wvo
	wG6Adju8hn1BfHCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 75C14133B7;
	Mon, 16 Oct 2023 12:32:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id zJ+SGmwtLWVOHwAAMHmgww
	(envelope-from <chrubis@suse.cz>); Mon, 16 Oct 2023 12:32:44 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Cc: Matthew Wilcox <willy@infradead.org>,
	amir73il@gmail.com,
	mszeredi@redhat.com,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/4] syscalls: readahead01: Make use of tst_fd
Date: Mon, 16 Oct 2023 14:33:18 +0200
Message-ID: <20231016123320.9865-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016123320.9865-1-chrubis@suse.cz>
References: <20231016123320.9865-1-chrubis@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 6.90
X-Spamd-Result: default: False [6.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-0.998];
	 NEURAL_SPAM_LONG(3.00)[1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 FREEMAIL_CC(0.00)[infradead.org,gmail.com,redhat.com,kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org]
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

TODO:
- readahead() on /proc/self/maps seems to succeed
- readahead() on pipe write end, O_PATH file and open_tree() fd returns EBADFD

Are these to be expected?

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../kernel/syscalls/readahead/readahead01.c   | 54 ++++++++++---------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/testcases/kernel/syscalls/readahead/readahead01.c b/testcases/kernel/syscalls/readahead/readahead01.c
index bdef7945d..6dd5086e5 100644
--- a/testcases/kernel/syscalls/readahead/readahead01.c
+++ b/testcases/kernel/syscalls/readahead/readahead01.c
@@ -30,43 +30,47 @@
 
 static void test_bad_fd(void)
 {
-	char tempname[PATH_MAX] = "readahead01_XXXXXX";
-	int fd;
+	int fd[2];
+
+	TST_EXP_FAIL(readahead(-1, 0, getpagesize()), EBADF,
+	             "readahead() with fd = -1");
 
-	tst_res(TINFO, "%s -1", __func__);
-	TST_EXP_FAIL(readahead(-1, 0, getpagesize()), EBADF);
+	SAFE_PIPE(fd);
+	SAFE_CLOSE(fd[0]);
+	SAFE_CLOSE(fd[1]);
 
-	tst_res(TINFO, "%s O_WRONLY", __func__);
-	fd = mkstemp(tempname);
-	if (fd == -1)
-		tst_res(TFAIL | TERRNO, "mkstemp failed");
-	SAFE_CLOSE(fd);
-	fd = SAFE_OPEN(tempname, O_WRONLY);
-	TST_EXP_FAIL(readahead(fd, 0, getpagesize()), EBADF);
-	SAFE_CLOSE(fd);
-	unlink(tempname);
+	TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EBADF,
+	             "readahead() with invalid fd");
 }
 
-static void test_invalid_fd(void)
+static void test_invalid_fd(struct tst_fd *fd)
 {
-	int fd[2];
+	int exp_errno = EINVAL;
 
-	tst_res(TINFO, "%s pipe", __func__);
-	SAFE_PIPE(fd);
-	TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EINVAL);
-	SAFE_CLOSE(fd[0]);
-	SAFE_CLOSE(fd[1]);
+	switch (fd->type) {
+	/* These two succeed */
+	case TST_FD_FILE:
+	case TST_FD_MEMFD:
+		return;
+	case TST_FD_PIPE_WRITE:
+	case TST_FD_OPEN_TREE:
+	case TST_FD_PATH:
+		exp_errno = EBADF;
+	break;
+	default:
+		break;
+	}
 
-	tst_res(TINFO, "%s socket", __func__);
-	fd[0] = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
-	TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EINVAL);
-	SAFE_CLOSE(fd[0]);
+	TST_EXP_FAIL(readahead(fd->fd, 0, getpagesize()), exp_errno,
+		     "readahead() on %s", tst_fd_desc(fd));
 }
 
 static void test_readahead(void)
 {
 	test_bad_fd();
-	test_invalid_fd();
+
+	TST_FD_FOREACH(fd)
+		test_invalid_fd(&fd);
 }
 
 static void setup(void)
-- 
2.41.0


