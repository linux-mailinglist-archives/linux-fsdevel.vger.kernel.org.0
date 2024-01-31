Return-Path: <linux-fsdevel+bounces-9652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4448440BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 14:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4FF1F27969
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 13:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D537F499;
	Wed, 31 Jan 2024 13:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gI2Ll2mD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121F37F48C
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 13:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708231; cv=none; b=eNzS09ruMBusYhhoIknykkTQedq7q/1meMsamPDmY8XljUXhgb8l0W2zrxJCdlQveYd/UZfAlxz/P5NRY3S8k1zI9IUIgfxAAkfTo1DZUwhz919xQdnO0tWuU+kZqz6lnOqoB2wVpACL/WlydJPUukYtkmShaTppFkR5CvPyAtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708231; c=relaxed/simple;
	bh=07pUU6zwtgqMLFLSmenEQPPYHlB+jgIuVh5/Q0ieR80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A3CWMjpCxTLcRiFj+811gdjkQqD7T8opKLZrMRaP/258WfPItFV4JFNJMwRux5srW4c+BVe3rkBnqeyS3V/RH1Bw9TCxlA6PPArLTbReNeO6l0gycMr+Nz0F/tlXL9MJKGa09FhTezDWa1tx2/Po+EP8k0cRlTVk7AN+lzLYm2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gI2Ll2mD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC65C433B1;
	Wed, 31 Jan 2024 13:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706708229;
	bh=07pUU6zwtgqMLFLSmenEQPPYHlB+jgIuVh5/Q0ieR80=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gI2Ll2mD8o6Ni3GvOW/X1ImCJAEV1p/eRuTOfy33ss2owa1fBIYJLlsfzZZSxq9xB
	 CXgLJpIBcNBTmjag+207+PW9j6iHmnasGKqgf7khTKnrBOFlm5y9YItjW7p57sNC65
	 bnWKr4M8KgHt1aHVwHGiL1KifUj2+IMBswBHqgNto8Cz+/nP+9jhlwhaVZfTZmgs6f
	 jRNxfLjl5gwXLCdfTvySmDLfMjkuuJx8mM2aIS7VRptxtq/LjesXtJCDk2q+l6v/2N
	 ku6yTI5PoeCbEK3Mb8AdHUWHMVNoaX/uYbuUTIIhLamsTzw7rwK1Z0r7IqZZ7chg32
	 fvgAh3LuluIQA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 31 Jan 2024 14:36:41 +0100
Subject: [PATCH DRAFT 4/4] : trace: illustrate how to convert basic open
 functions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-tracefs-kernfs-v1-4-f20e2e9a8d61@kernel.org>
References: <20240131-tracefs-kernfs-v1-0-f20e2e9a8d61@kernel.org>
In-Reply-To: <20240131-tracefs-kernfs-v1-0-f20e2e9a8d61@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Amir Goldstein <amir73il@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
 Al Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <willy@infradead.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=2673; i=brauner@kernel.org;
 h=from:subject:message-id; bh=07pUU6zwtgqMLFLSmenEQPPYHlB+jgIuVh5/Q0ieR80=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTu8vkxP6Sj6lPEYjmx422TzeLbY2/mlxs1KRw+/fgxe
 0ey7ttnHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMR3sLw3zXoQeLUrg8nDZ5p
 rFHVOJd+Pm/Se8cdm0pfdT964f1GeDIjw5On2w5viVuzpSTf5MmMQmYecaPTm43OxYt2uld36xg
 tYQYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/trace/trace.c | 16 ++++++++--------
 kernel/trace/trace.h |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 3afc2dd51233..b700feada3e0 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4913,7 +4913,7 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 	return ERR_PTR(-ENOMEM);
 }
 
-int tracing_open_generic(struct inode *inode, struct file *filp)
+int tracing_open_generic(struct kernfs_open_file *of)
 {
 	int ret;
 
@@ -4921,7 +4921,7 @@ int tracing_open_generic(struct inode *inode, struct file *filp)
 	if (ret)
 		return ret;
 
-	filp->private_data = inode->i_private;
+	of->priv = of->kn->priv;
 	return 0;
 }
 
@@ -4934,17 +4934,16 @@ bool tracing_is_disabled(void)
  * Open and update trace_array ref count.
  * Must have the current trace_array passed to it.
  */
-int tracing_open_generic_tr(struct inode *inode, struct file *filp)
+int tracing_open_generic_tr(struct kernfs_open_file *of)
 {
-	struct trace_array *tr = inode->i_private;
+	struct trace_array *tr = of->kn->priv;
 	int ret;
 
 	ret = tracing_check_open_get_tr(tr);
 	if (ret)
 		return ret;
 
-	filp->private_data = inode->i_private;
-
+	of->priv = of->kn->priv;
 	return 0;
 }
 
@@ -5057,9 +5056,10 @@ static int tracing_single_release_tr(struct inode *inode, struct file *file)
 	return single_release(inode, file);
 }
 
-static int tracing_open(struct inode *inode, struct file *file)
+static int tracing_open(struct kernfs_open_file *of)
 {
-	struct trace_array *tr = inode->i_private;
+	struct trace_array *tr = of->kn->priv;
+	struct file *filp = of->file;
 	struct trace_iterator *iter;
 	int ret;
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 00f873910c5d..d91420a6c2e8 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -614,8 +614,8 @@ int tracing_is_enabled(void);
 void tracing_reset_online_cpus(struct array_buffer *buf);
 void tracing_reset_all_online_cpus(void);
 void tracing_reset_all_online_cpus_unlocked(void);
-int tracing_open_generic(struct inode *inode, struct file *filp);
-int tracing_open_generic_tr(struct inode *inode, struct file *filp);
+int tracing_open_generic(struct kernfs_open_file *of);
+int tracing_open_generic_tr(struct kernfs_open_file *of);
 int tracing_release_generic_tr(struct inode *inode, struct file *file);
 int tracing_open_file_tr(struct inode *inode, struct file *filp);
 int tracing_release_file_tr(struct inode *inode, struct file *filp);

-- 
2.43.0


