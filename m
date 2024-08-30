Return-Path: <linux-fsdevel+bounces-28034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6431966293
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A27628290E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3748E1B3B0C;
	Fri, 30 Aug 2024 13:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNIp3QTx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926711B2EEE
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023170; cv=none; b=F0l02rmEbiok3JcukxqDhTyOCYlGg3j0N7Wr1S9Q7ZV31dUmbFh2TyY8jKHV9e6UyUs1L5WLggJ13uxxs+L2UTMhBFZrEbE/F6l3eWAJUvROVi4j7zfemzAI9t348oHSuu8iykJsDSFVhSQP0iZYFcsFKLk6wX8zUZfxcQGF5hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023170; c=relaxed/simple;
	bh=/p1il7Thqi0OGbn6Xz4Ra6ZuS26mNe4kBd4gJc1HSzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VuC405jUE1Q9GdiFA+XJDRqBlYr6hMYzuMduy+XkZdH/sM7tQAkfKC+4l5k9Fg7Kg/oMvkY725KvyRdfmlpp5XLr+heHgFGv4BBuBXWDVfO68Dj6Oezh0ffZwxSpdTNT1rjs9gb08u4nquSXffcDr+b1az90NkNwDhsPyXtQH3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNIp3QTx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC4DC4CEC7;
	Fri, 30 Aug 2024 13:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023169;
	bh=/p1il7Thqi0OGbn6Xz4Ra6ZuS26mNe4kBd4gJc1HSzU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rNIp3QTxSOqzFr1oGnH9h5bRmQ89sf4WfAS07mpxvEeCAyRYcZDk6l0yiTtxMP9/z
	 9JxGR9i8iYoDTrB89M5CKhx1acU+MamuWG68gAHZVLDpWooHkwTcHvaUnegZ7SFA+Y
	 WRojAehFy6rMYAD4V2pcqqIk8hNVtHVVKFheofJkvIktyTz72EWRWy+kL34kQScuy7
	 G54ngNlFMBFqZEf6OZIlwbvk7q/osP8eIvnICEQTcPpOM+94bTCw7UhE31FvKGwqYR
	 IlDJU5b51uDErOES9xDOCIHgi0sS5TrvxpeKNIQVvYTo3L/jrN92Br9ityOAZes8bH
	 lGehb2S299HdA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Aug 2024 15:04:53 +0200
Subject: [PATCH RFC 12/20] input: remove f_version abuse
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-vfs-file-f_version-v1-12-6d3e4816aa7b@kernel.org>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
In-Reply-To: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1272; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/p1il7Thqi0OGbn6Xz4Ra6ZuS26mNe4kBd4gJc1HSzU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdPDynTuanHe/ZGxkfOf2FxZX2TE4L73nqf6Z6++z36
 w6JpF517ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI4naG/2FfU0WFEkIXt7pP
 Vu15l31UodlxS5NJ8cLwdZfL/18L0WX4X1hwMtqdd0WOivNZ8Z/lMmdfzj+iaqjw2u36W6PjYo5
 T2QE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Remove the f_version abuse from input. Use seq_private_open() to stash
the information for poll.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/input/input.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 54c57b267b25..b03ae43707d8 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1081,9 +1081,11 @@ static inline void input_wakeup_procfs_readers(void)
 
 static __poll_t input_proc_devices_poll(struct file *file, poll_table *wait)
 {
+	struct seq_file *m = file->private_data;
+
 	poll_wait(file, &input_devices_poll_wait, wait);
-	if (file->f_version != input_devices_state) {
-		file->f_version = input_devices_state;
+	if (*(u64 *)m->private != input_devices_state) {
+		*(u64 *)m->private = input_devices_state;
 		return EPOLLIN | EPOLLRDNORM;
 	}
 
@@ -1210,7 +1212,7 @@ static const struct seq_operations input_devices_seq_ops = {
 
 static int input_proc_devices_open(struct inode *inode, struct file *file)
 {
-	return seq_open(file, &input_devices_seq_ops);
+	return seq_open_private(file, &input_devices_seq_ops, sizeof(u64));
 }
 
 static const struct proc_ops input_devices_proc_ops = {

-- 
2.45.2


