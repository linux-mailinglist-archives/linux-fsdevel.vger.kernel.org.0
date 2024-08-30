Return-Path: <linux-fsdevel+bounces-28028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D627996628C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67751C23C56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC581B2503;
	Fri, 30 Aug 2024 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="if0H5LE5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF5C1B1D4D
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023152; cv=none; b=C6MN4fQ+aRs2SscgSRX4bSuSYNg4OASv8ZDZkut9V0AzdYjqrpLxI9abGUPMLNIiVDIsY6gMgtUrNadAyabO0x3nEhp/hDVxv9ygOVJ44mS00xTO5U0GZGtWCzQCsWR1QgApI6AZMV+Lh5Gkj++VHrgDmgJJ16Wair0mPJId67Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023152; c=relaxed/simple;
	bh=6DHhCREChoI64snZkWIgdThng4Uj2MiT59kqnddj2VQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W/SRvEm34bro78DA3wcUJPF0Mg2aryn4blOmYsB3cEoohv9tCCtsCCtjaJVlJ08+gGKKpPEUY9gCk7gMkcNAJpoCjC9IyfDNuS2zjK+gvv/Hp4/vuQ0QHZR+1oHN7dXugGe7pi15rknKgrcbBAVMQjaUNtW4q9+OeD2ft9u+R9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=if0H5LE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F01C4CEC5;
	Fri, 30 Aug 2024 13:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023152;
	bh=6DHhCREChoI64snZkWIgdThng4Uj2MiT59kqnddj2VQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=if0H5LE5j2mDVJWxZe5D3XESzSQftSoxto8KVfPnzenOhGuwdg79Zazp+VyV7hWpR
	 h3JDkNr9xBDOhGv54cmLOWYLHtPnzBYJpWiZoZ4WPZQa6OSWizr4V/PcggNhl2JXjf
	 5dS1pBisZ9E2ihUElmresN6MzteCOFyOibDUumqJR+Ar+d0KMwQXrTSuC3H+Eu6PBp
	 0BaoKo3t3lBIdL1CAJ5Tf+TVZ/CTezgfq3Ve/MrJlj/TAT6/jEB5LZ2YhbKy0jLprC
	 HzKZoAw+KRqY2Wh459xmyBzMOq9zng5jdtIjZCyUZuOmDu1F2WbLk1Ef0fpjDEXFu8
	 Wb6J64/LNgXgw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Aug 2024 15:04:47 +0200
Subject: [PATCH RFC 06/20] fs: add must_set_pos()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-vfs-file-f_version-v1-6-6d3e4816aa7b@kernel.org>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
In-Reply-To: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2160; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6DHhCREChoI64snZkWIgdThng4Uj2MiT59kqnddj2VQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdPDznpond2ra/D6bFb/9sFmi443+4uMPCCfsyJxx8q
 Jd28eyaHR2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATkZzCyLCvOZptY/Sk2E3h
 c8V1l15d/ury65NvP5zgbbrmet0jWfgjI0NTnPjCJxWLoznOS35f/7Y7g7EiK+j0WoZT3RHeqbe
 2TeUAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a new must_set_pos() helper. We will use it in follow-up patches.
Temporarily mark it as unused. This is only done to keep the diff small
and reviewable.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/read_write.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index 66ff52860496..acee26989d95 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -85,6 +85,58 @@ loff_t vfs_setpos(struct file *file, loff_t offset, loff_t maxsize)
 }
 EXPORT_SYMBOL(vfs_setpos);
 
+/**
+ * must_set_pos - check whether f_pos has to be updated
+ * @offset: offset to use
+ * @whence: type of seek operation
+ * @eof: end of file
+ *
+ * Check whether f_pos needs to be updated and update @offset according
+ * to @whence.
+ *
+ * Return: 0 if f_pos doesn't need to be updated, 1 if f_pos has to be
+ * updated, and negative error code on failure.
+ */
+static __maybe_unused int must_set_pos(struct file *file, loff_t *offset, int whence, loff_t eof)
+{
+	switch (whence) {
+	case SEEK_END:
+		*offset += eof;
+		break;
+	case SEEK_CUR:
+		/*
+		 * Here we special-case the lseek(fd, 0, SEEK_CUR)
+		 * position-querying operation.  Avoid rewriting the "same"
+		 * f_pos value back to the file because a concurrent read(),
+		 * write() or lseek() might have altered it
+		 */
+		if (*offset == 0) {
+			*offset = file->f_pos;
+			return 0;
+		}
+		break;
+	case SEEK_DATA:
+		/*
+		 * In the generic case the entire file is data, so as long as
+		 * offset isn't at the end of the file then the offset is data.
+		 */
+		if ((unsigned long long)*offset >= eof)
+			return -ENXIO;
+		break;
+	case SEEK_HOLE:
+		/*
+		 * There is a virtual hole at the end of the file, so as long as
+		 * offset isn't i_size or larger, return i_size.
+		 */
+		if ((unsigned long long)*offset >= eof)
+			return -ENXIO;
+		*offset = eof;
+		break;
+	}
+
+	return 1;
+}
+
 /**
  * generic_file_llseek_size - generic llseek implementation for regular files
  * @file:	file structure to seek on

-- 
2.45.2


