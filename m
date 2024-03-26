Return-Path: <linux-fsdevel+bounces-15273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 254D288B6F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 02:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB70E1F3B2C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 01:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D451427458;
	Tue, 26 Mar 2024 01:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWD8+oiW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320D2208C3;
	Tue, 26 Mar 2024 01:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711416965; cv=none; b=m3BfBU3rCNVVjpeOEoTg2x1hSZD6hA0x7PPaxKM0rgIxCk6YYDh9K/vfPM9AshbRaFHjkHGyjI8mxFs1S3Q66y6e/NpeWnMzC0FyMSd4/o7pGmMihzUjXlZZro0XNM7Zpo1oYUYUxjfy7ziD1hqIEVHQ2vXeboAqxd/gT02IgvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711416965; c=relaxed/simple;
	bh=lWmFCW3E1cmFH4KzQVtNpNX3lS13zmnBzK7/lzOc7kI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cLXg4L+H0Sv2ahcsdAKXFsdsBeBdoszaxQPxTdWvjFWh3MagLabrswfhjYlAUBJEUoi5BgEMCJD23od7xQGpor5eS1Almw+mtYfjM1HauuaccJ84SAFBVUlAFmcLWI2+osxzrH+q8DfqkKXtO8UBMDUL+zTtt2RdmwkuX6gDVAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWD8+oiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320E9C433F1;
	Tue, 26 Mar 2024 01:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711416964;
	bh=lWmFCW3E1cmFH4KzQVtNpNX3lS13zmnBzK7/lzOc7kI=;
	h=Date:From:To:Cc:Subject:From;
	b=lWD8+oiWRHB0cipl3whT0kQ+zek0oWZCm1LSHrREIMG/OvUQ/oEV3Prwa/A6C3XQ5
	 ufdtBPv9NwXGxCbjDsi3c0TcY/0IS5eOriqyr5+UtdmFwuHo/xPtVoMK5t4VB2i+Cl
	 4chJpBlow3W21+s3JLjdi9TXFl2t7wYnOjoKcFB1ylieVpuWcHuAzi5WaVHkmnwLPr
	 LoUftmF9wgzNIjq/ieAZvcNQiZYcfUaQghpmVa1JJ3myqaTHRJJu3OPLi9gDLyy1Gu
	 oowTaUGKIdOi4NnHjNGz/E5rMaF7PnHNdlQSjSwtOAJI04EhShickJLxrMEOKJ35/n
	 t0Tt9+d/HWR+Q==
Date: Mon, 25 Mar 2024 19:36:02 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] fsnotify: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <ZgImguNzJBiis9Mj@neat>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use the `DEFINE_FLEX()` helper for an on-stack definition of a
flexible structure where the size of the flexible-array member
is known at compile-time, and refactor the rest of the code,
accordingly.

So, with these changes, fix the following warning:
fs/notify/fdinfo.c:45:36: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Link: https://github.com/KSPP/linux/issues/202
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Use DEFINE_FLEX() instead of struct_group_tagged().

v1:
 - Link: https://lore.kernel.org/linux-hardening/ZeeaRuTpuxInH6ZB@neat/

 fs/notify/fdinfo.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 5c430736ec12..dec553034027 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -41,29 +41,25 @@ static void show_fdinfo(struct seq_file *m, struct file *f,
 #if defined(CONFIG_EXPORTFS)
 static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
 {
-	struct {
-		struct file_handle handle;
-		u8 pad[MAX_HANDLE_SZ];
-	} f;
+	DEFINE_FLEX(struct file_handle, f, f_handle, handle_bytes, MAX_HANDLE_SZ);
 	int size, ret, i;
 
-	f.handle.handle_bytes = sizeof(f.pad);
-	size = f.handle.handle_bytes >> 2;
+	size = f->handle_bytes >> 2;
 
-	ret = exportfs_encode_fid(inode, (struct fid *)f.handle.f_handle, &size);
+	ret = exportfs_encode_fid(inode, (struct fid *)f->f_handle, &size);
 	if ((ret == FILEID_INVALID) || (ret < 0)) {
 		WARN_ONCE(1, "Can't encode file handler for inotify: %d\n", ret);
 		return;
 	}
 
-	f.handle.handle_type = ret;
-	f.handle.handle_bytes = size * sizeof(u32);
+	f->handle_type = ret;
+	f->handle_bytes = size * sizeof(u32);
 
 	seq_printf(m, "fhandle-bytes:%x fhandle-type:%x f_handle:",
-		   f.handle.handle_bytes, f.handle.handle_type);
+		   f->handle_bytes, f->handle_type);
 
-	for (i = 0; i < f.handle.handle_bytes; i++)
-		seq_printf(m, "%02x", (int)f.handle.f_handle[i]);
+	for (i = 0; i < f->handle_bytes; i++)
+		seq_printf(m, "%02x", (int)f->f_handle[i]);
 }
 #else
 static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
-- 
2.34.1


