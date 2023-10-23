Return-Path: <linux-fsdevel+bounces-909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EC17D2E7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 11:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4235EB20F22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 09:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C16F13ACA;
	Mon, 23 Oct 2023 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD873134A8
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 09:34:32 +0000 (UTC)
Received: from smtp02.aussiebb.com.au (smtp02.aussiebb.com.au [IPv6:2403:5800:3:25::1002])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18E41722;
	Mon, 23 Oct 2023 02:34:24 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp02.aussiebb.com.au (Postfix) with ESMTP id 387E710181C;
	Mon, 23 Oct 2023 20:34:17 +1100 (AEDT)
X-Virus-Scanned: Debian amavisd-new at smtp02.aussiebb.com.au
Received: from smtp02.aussiebb.com.au ([127.0.0.1])
	by localhost (smtp02.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RmsSVixHbriO; Mon, 23 Oct 2023 20:34:17 +1100 (AEDT)
Received: by smtp02.aussiebb.com.au (Postfix, from userid 116)
	id 2E13F1026C5; Mon, 23 Oct 2023 20:34:17 +1100 (AEDT)
X-Spam-Level: 
Received: from donald.themaw.com (159-196-82-144.9fc452.per.static.aussiebb.net [159.196.82.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ian146@aussiebb.com.au)
	by smtp02.aussiebb.com.au (Postfix) with ESMTPSA id F363910181C;
	Mon, 23 Oct 2023 20:34:14 +1100 (AEDT)
From: Ian Kent <raven@themaw.net>
To: Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Christian Brauner <brauner@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Bill O'Donnell <bodonnel@redhat.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	autofs mailing list <autofs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Ian Kent <raven@themaw.net>,
	lkft-triage@lists.linaro.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH] autofs: fix add autofs_parse_fd()
Date: Mon, 23 Oct 2023 17:33:59 +0800
Message-ID: <20231023093359.64265-1-raven@themaw.net>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are seeing systemd hang on its autofs direct mount at
/proc/sys/fs/binfmt_misc.

Historically this was due to a mismatch in the communication structure
size between a 64 bit kernel and a 32 bit user space and was fixed by
making the pipe communication record oriented.

During autofs v5 development I decided to stay with the existing usage
instead of changing to a packed structure for autofs <=> user space
communications which turned out to be a mistake on my part.

Problems arose and they were fixed by allowing for the 64 bit to 32
bit size difference in the automount(8) code.

Along the way systemd started to use autofs and eventually encountered
this problem too. systemd refused to compensate for the length
difference insisting it be fixed in the kernel. Fortunately Linus
implemented the packetized pipe which resolved the problem in a
straight forward and simple way.

In the autofs mount api conversion series I inadvertatly dropped the
packet pipe flag settings when adding the autofs_parse_fd() function.
This patch fixes that omission.

Fixes: 546694b8f658 ("autofs: add autofs_parse_fd()")
Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Bill O'Donnell <bodonnel@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Anders Roxell <anders.roxell@linaro.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Reported-by: Anders Roxell <anders.roxell@linaro.org>
---
 fs/autofs/autofs_i.h | 13 +++++++++----
 fs/autofs/inode.c    |  2 ++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index 244f18cdf23c..8c1d587b3eef 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -221,15 +221,20 @@ static inline int autofs_check_pipe(struct file *pipe)
 	return 0;
 }
 
-static inline int autofs_prepare_pipe(struct file *pipe)
+static inline void autofs_set_packet_pipe_flags(struct file *pipe)
 {
-	int ret = autofs_check_pipe(pipe);
-	if (ret < 0)
-		return ret;
 	/* We want a packet pipe */
 	pipe->f_flags |= O_DIRECT;
 	/* We don't expect -EAGAIN */
 	pipe->f_flags &= ~O_NONBLOCK;
+}
+
+static inline int autofs_prepare_pipe(struct file *pipe)
+{
+	int ret = autofs_check_pipe(pipe);
+	if (ret < 0)
+		return ret;
+	autofs_set_packet_pipe_flags(pipe);
 	return 0;
 }
 
diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 6d2e01c9057d..a3d62acc293a 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -177,6 +177,8 @@ static int autofs_parse_fd(struct fs_context *fc, struct autofs_sb_info *sbi,
 		return -EBADF;
 	}
 
+	autofs_set_packet_pipe_flags(pipe);
+
 	if (sbi->pipe)
 		fput(sbi->pipe);
 
-- 
2.41.0


