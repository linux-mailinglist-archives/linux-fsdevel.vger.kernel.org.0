Return-Path: <linux-fsdevel+bounces-48463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA687AAF61B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 10:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4324C76A2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 08:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786F7262FFE;
	Thu,  8 May 2025 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exnMG6s6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C239423E35F;
	Thu,  8 May 2025 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746694454; cv=none; b=jL4SQ2alMdYbzfJtxpVXJ4Eva89LqvNFOj2AarKPJ0xIDKxkz+XLIpvrsKqwd0K3zQyRd1X6djeNaY8FDmum5mTVCB1zJN4v+E6IlattfmmybcgAcZWsQ/GKkz3oqmOoi2jAZWrDEkpwBJCUOHqp//Yrc8C4vK8W/jXjtK3Jhj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746694454; c=relaxed/simple;
	bh=aeZPyyvtHWmKYFfyG8fSOBi9lfDKNm0mWBz3v98X+YA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nMmSGuKhfxjIVg6CryYPgrj/GVxALNtG8/ErF9ZEjWUMy+PWv/Xb9c4iUbAaEZYrfUB9gmdG+R0iSrfowSk+SnTvq/rqxHGbNXhtDck15wL2uwhpRRlyvjKY+0rbsmh/t0WjMHFMDInKofC+Poc1E9BROQQB+cAZHxIsRg0qx5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exnMG6s6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5EB9CC4CEEB;
	Thu,  8 May 2025 08:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746694454;
	bh=aeZPyyvtHWmKYFfyG8fSOBi9lfDKNm0mWBz3v98X+YA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=exnMG6s67MADw4z/6O6OIxZLxHzLJd3GTY0zO/Rv8FghMA5cBj6pjXmPk2NochDLh
	 gSFPQN6a8J02CsTvjn8Wgmqd0n5D+bzbvjMgAxYykPxG5NGw7BIG2IrrHAYQSXh0Cg
	 7MUEooF+sEYTaItGd/30uqweDc+FwYPgOuTUU9G//kgFigrYPG2GqMpYImBe6PVJDK
	 sLCHrtFHJ28JLVqtFGyBriHtWgMZuv02bIh1fbQdvxIZY8wpb8svVqKBWyxSZzPTUq
	 uEP5tEIo2tXRxvG/nZFxN5bXCmErsBuGwcH1f4scK21M4ZeGsYhKcZP2VD0zFe1BIY
	 w3UALKydszhRw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510CFC3ABC9;
	Thu,  8 May 2025 08:54:14 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+chenlinxuan.uniontech.com@kernel.org>
Date: Thu, 08 May 2025 16:53:45 +0800
Subject: [PATCH v2 2/3] fs: fuse: add backing_files control file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250508-fusectl-backing-files-v2-2-62f564e76984@uniontech.com>
References: <20250508-fusectl-backing-files-v2-0-62f564e76984@uniontech.com>
In-Reply-To: <20250508-fusectl-backing-files-v2-0-62f564e76984@uniontech.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chen Linxuan <chenlinxuan@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6076;
 i=chenlinxuan@uniontech.com; h=from:subject:message-id;
 bh=id6oT8a7yC3qd46gYMaegcNojko0bpH3Ayxh7JPrSGg=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBoHHEt1CnQi/e7pwJqkt2cfNBt81LpsAuTZBz42
 AhCXSVLg96JAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCaBxxLQAKCRB2HuYUOZmu
 izp6D/oDY1tR3wOwTQg7lSqwVEOAwbsXdkPYA0b4xhU+k4ApVRChlwM/Ud1SnNgsxRGpI6sFu1w
 abACmc9gNArdAEt/1AcEEhWKdRMLQ2xS06V+++3vr8OSXzuUtLt0eCju5KxpfiEla56OmFVwuhq
 1zKGzUxtpjvO31e2iLxG3zoyEyZKvBj4Od9sYP3gC+tgTTyCeeWJlvDn7SqnWnReL4SzT2m5txC
 VF07yYeefeb+ScTnMUrjSCFxyZYcxQJ+CIqRHGlZWizksDJFw6YxSKloXSYZfXkMJyKfGu7S6OL
 OyR8U9aUjtzme1RpkHd/q/Jnxyrkbdfpl5qhiX8J6uL7GXbu5oenkJ1yqIW/QePWz8Lt4CUvsc2
 DSQEmjdLt9xSArjux2LMmCGCFXbhxPETDU7ivsTbPQ+NVwQbAB1X/RLmiS1WAfiZGjSt/wc1NG4
 axFuGMpM0rwFtlYNgKu0WsJiOqexwwLZ1+zsM/MhxygLA1w78oH9GnXVtp13LSPxZ6YUZAFfrEy
 MapRw9SX6OmS+m3tJsdM8FM5RAK0IiiMdKtYDJefeEfr2EzFYgSAASiqd7g8FKR/LZ9Mfo4qldT
 ZqBVMH1E+9U2Jt3SaWD5tnlOZWVtno5Rl5vXAbMxM5wgRUjOVlnM7sufVI94ChQ6msnE/iD5LAq
 UaVvZNNEFOb8hIA==
X-Developer-Key: i=chenlinxuan@uniontech.com; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for chenlinxuan@uniontech.com/default with
 auth_id=380
X-Original-From: Chen Linxuan <chenlinxuan@uniontech.com>
Reply-To: chenlinxuan@uniontech.com

From: Chen Linxuan <chenlinxuan@uniontech.com>

Add a new FUSE control file "/sys/fs/fuse/connections/*/backing_files"
that exposes the paths of all backing files currently being used in
FUSE mount points. This is particularly valuable for tracking and
debugging files used in FUSE passthrough mode.

This approach is similar to how fixed files in io_uring expose their
status through fdinfo, providing administrators with visibility into
backing file usage. By making backing files visible through the FUSE
control filesystem, administrators can monitor which files are being
used for passthrough operations and can force-close them if needed by
aborting the connection.

This exposure of backing files information is an important step towards
potentially relaxing CAP_SYS_ADMIN requirements for certain passthrough
operations in the future, allowing for better security analysis of
passthrough usage patterns.

The control file is implemented using the seq_file interface for
efficient handling of potentially large numbers of backing files.
Access permissions are set to read-only (0400) as this is an
informational interface.

FUSE_CTL_NUM_DENTRIES has been increased from 5 to 6 to accommodate the
additional control file.

Some related discussions can be found at links below.

Link: https://lore.kernel.org/all/4b64a41c-6167-4c02-8bae-3021270ca519@fastmail.fm/T/#mc73e04df56b8830b1d7b06b5d9f22e594fba423e
Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxhAY1m7ubJ3p-A3rSufw_53WuDRMT1Zqe_OC0bP_Fb3Zw@mail.gmail.com/
Cc: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 fs/fuse/control.c | 136 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h  |   2 +-
 2 files changed, 136 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index f0874403b1f7c91571f38e4ae9f8cebe259f7dd1..d1ac934d7b8949577545ffd20535c68a9c4ef90f 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/fs_context.h>
+#include <linux/seq_file.h>
 
 #define FUSE_CTL_SUPER_MAGIC 0x65735543
 
@@ -180,6 +181,136 @@ static ssize_t fuse_conn_congestion_threshold_write(struct file *file,
 	return ret;
 }
 
+struct fuse_backing_files_seq_state {
+	struct fuse_conn *fc;
+	int backing_id;
+};
+
+static void *fuse_backing_files_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct fuse_backing *fb;
+	struct fuse_backing_files_seq_state *state;
+	struct fuse_conn *fc;
+	int backing_id;
+	void *ret;
+
+	if (*pos + 1 > INT_MAX)
+		return ERR_PTR(-EINVAL);
+
+	backing_id = *pos + 1;
+
+	fc = fuse_ctl_file_conn_get(seq->file);
+	if (!fc)
+		return ERR_PTR(-ENOTCONN);
+
+	rcu_read_lock();
+
+	fb = idr_get_next(&fc->backing_files_map, &backing_id);
+
+	rcu_read_unlock();
+
+	if (!fb) {
+		ret = NULL;
+		goto err;
+	}
+
+	state = kmalloc(sizeof(*state), GFP_KERNEL);
+	if (!state) {
+		ret = ERR_PTR(-ENOMEM);
+		goto err;
+	}
+
+	state->fc = fc;
+	state->backing_id = backing_id;
+
+	ret = state;
+	return ret;
+
+err:
+	fuse_conn_put(fc);
+	return ret;
+}
+
+static void *fuse_backing_files_seq_next(struct seq_file *seq, void *v,
+					 loff_t *pos)
+{
+	struct fuse_backing_files_seq_state *state = v;
+	struct fuse_backing *fb;
+
+	(*pos)++;
+	state->backing_id++;
+
+	rcu_read_lock();
+
+	fb = idr_get_next(&state->fc->backing_files_map, &state->backing_id);
+
+	rcu_read_unlock();
+
+	if (!fb)
+		return NULL;
+
+
+	return state;
+}
+
+static int fuse_backing_files_seq_show(struct seq_file *seq, void *v)
+{
+	struct fuse_backing_files_seq_state *state = v;
+	struct fuse_conn *fc = state->fc;
+	struct fuse_backing *fb;
+
+	rcu_read_lock();
+
+	fb = idr_find(&fc->backing_files_map, state->backing_id);
+	fb = fuse_backing_get(fb);
+	if (!fb)
+		goto out;
+
+	if (!fb->file)
+		goto out_put_fb;
+
+	seq_printf(seq, "%5u: ", state->backing_id);
+	seq_file_path(seq, fb->file, " \t\n\\");
+	seq_puts(seq, "\n");
+
+out_put_fb:
+	fuse_backing_put(fb);
+out:
+	rcu_read_unlock();
+	return 0;
+}
+
+static void fuse_backing_files_seq_stop(struct seq_file *seq, void *v)
+{
+	struct fuse_backing_files_seq_state *state;
+
+	if (!v)
+		return;
+
+	state = v;
+	fuse_conn_put(state->fc);
+	kvfree(state);
+}
+
+static const struct seq_operations fuse_backing_files_seq_ops = {
+	.start = fuse_backing_files_seq_start,
+	.next = fuse_backing_files_seq_next,
+	.stop = fuse_backing_files_seq_stop,
+	.show = fuse_backing_files_seq_show,
+};
+
+static int fuse_backing_files_seq_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &fuse_backing_files_seq_ops);
+}
+
+static const struct file_operations fuse_conn_backing_files_ops = {
+	.open = fuse_backing_files_seq_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
 static const struct file_operations fuse_ctl_abort_ops = {
 	.open = nonseekable_open,
 	.write = fuse_conn_abort_write,
@@ -270,7 +401,10 @@ int fuse_ctl_add_conn(struct fuse_conn *fc)
 				 1, NULL, &fuse_conn_max_background_ops) ||
 	    !fuse_ctl_add_dentry(parent, fc, "congestion_threshold",
 				 S_IFREG | 0600, 1, NULL,
-				 &fuse_conn_congestion_threshold_ops))
+				 &fuse_conn_congestion_threshold_ops) ||
+	    !fuse_ctl_add_dentry(parent, fc, "backing_files", S_IFREG | 0400, 1,
+				 NULL,
+				 &fuse_conn_backing_files_ops))
 		goto err;
 
 	return 0;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index d56d4fd956db99ecd93052a9655428664882cb72..2830b05bb0928e9b30f9905d70fc3ec1ef11c2a5 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -46,7 +46,7 @@
 #define FUSE_NAME_MAX (PATH_MAX - 1)
 
 /** Number of dentries for each connection in the control filesystem */
-#define FUSE_CTL_NUM_DENTRIES 5
+#define FUSE_CTL_NUM_DENTRIES 6
 
 /* Frequency (in seconds) of request timeout checks, if opted into */
 #define FUSE_TIMEOUT_TIMER_FREQ 15

-- 
2.43.0



