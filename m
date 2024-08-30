Return-Path: <linux-fsdevel+bounces-28041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A70C96629A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CE071C23EE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD17E1B5307;
	Fri, 30 Aug 2024 13:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKBkV3l+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2BD1AE056
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 13:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023187; cv=none; b=b5d8xQN/PLvDsuq0CDD/GrxYg55A7nt2nO+M3moKX3QEJVYTApg2dRz01zzvbQgjy0KK3dBHYauUF7SASIUY8F0yR6WU4u90E3Fpcdm/I75BW2rOg8USzmgwoqQ2mg/wguFQkh44ZrtuIWCwr5X5Ij/apsy7ydSUkfD/kGDm3xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023187; c=relaxed/simple;
	bh=RwsfX6+8EZo3gpTxiLhlAX6rMlnrpQk6hJ4HFOwb8o4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aXr6V4b3bovb33kVk3J/hO4iUowFW04oePEquIPXWacP1y1IZB+n7U7B4JRnOYu/ZrLk18nnvGiw8VaI1OlWFoqlyvGaSCXQa3ZzgCdlgOQ4hoiwPZGc2M1ZN/YDatXZkb/E6c8jr8WT4vc1nVQ5n6Vq1Rku5rLY7uS8PaGLrFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKBkV3l+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D87C4CEC8;
	Fri, 30 Aug 2024 13:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023187;
	bh=RwsfX6+8EZo3gpTxiLhlAX6rMlnrpQk6hJ4HFOwb8o4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gKBkV3l+E/6riwoHIci4bltkrd8kcIcx2wVhI94Mcqe+3eH2yosbCmdx7PeZ79G3x
	 d/nMzerenLgif87FlQMAt3L2lYi9veq/2kmlZ/s8tuZ1OredJ4FtpuZKlKAfgpIQDg
	 m5htEOZflhdpiv/0SGMFCUm3x7CBGJXr1lawHWMaF/b+ZgTpB8tcoem8sBlJRwydXn
	 kVr23OWs4kBYRdedHZLiBH9jLOecDN67a1O8fOE0VqM6uMc3H9H7j5ovYC8E/guU0N
	 bPh1Zkw51k8r4J824KcxDhmgRje7Ds5GUvvmQWsIzJQ4b8g1DMeh4j3nLsKVw0ZIEC
	 nD49nOq7rNGjw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Aug 2024 15:05:00 +0200
Subject: [PATCH RFC 19/20] pipe: use f_pipe
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-vfs-file-f_version-v1-19-6d3e4816aa7b@kernel.org>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
In-Reply-To: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1775; i=brauner@kernel.org;
 h=from:subject:message-id; bh=RwsfX6+8EZo3gpTxiLhlAX6rMlnrpQk6hJ4HFOwb8o4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdPDy39+UKFYZ77cI3QrPm55Z2m++aPfN9/8oHKYkzX
 jf2h39u6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI01OG/76vhI/dc+sWam07
 LJgy8VvrskuS/kFlu2dEN+VdWOVuvZbhn3LxD3VhJktmC97bbq+U5jw3uOVlXRW8+f1ptWLpaye
 iuAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Pipes use f_version to defer poll notifications until a write has been
observed. Since multiple file's refer to the same struct pipe_inode_info
in their ->private_data moving it into their isn't feasible since we
would need to introduce an additional pointer indirection.

However, since pipes don't require f_pos_lock we placed a new f_pipe
member into a union with f_pos_lock that pipes can use. This is similar
to what we already do for struct inode where we have additional fields
per file type. This will allow us to fully remove f_version in the next
step.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pipe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 7dff2aa50a6d..b8f1943c57b9 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -686,7 +686,7 @@ pipe_poll(struct file *filp, poll_table *wait)
 	if (filp->f_mode & FMODE_READ) {
 		if (!pipe_empty(head, tail))
 			mask |= EPOLLIN | EPOLLRDNORM;
-		if (!pipe->writers && filp->f_version != pipe->w_counter)
+		if (!pipe->writers && filp->f_pipe != pipe->w_counter)
 			mask |= EPOLLHUP;
 	}
 
@@ -1108,7 +1108,7 @@ static int fifo_open(struct inode *inode, struct file *filp)
 	bool is_pipe = inode->i_sb->s_magic == PIPEFS_MAGIC;
 	int ret;
 
-	filp->f_version = 0;
+	filp->f_pipe = 0;
 
 	spin_lock(&inode->i_lock);
 	if (inode->i_pipe) {
@@ -1155,7 +1155,7 @@ static int fifo_open(struct inode *inode, struct file *filp)
 			if ((filp->f_flags & O_NONBLOCK)) {
 				/* suppress EPOLLHUP until we have
 				 * seen a writer */
-				filp->f_version = pipe->w_counter;
+				filp->f_pipe = pipe->w_counter;
 			} else {
 				if (wait_for_partner(pipe, &pipe->w_counter))
 					goto err_rd;

-- 
2.45.2


