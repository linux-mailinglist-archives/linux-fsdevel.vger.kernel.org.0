Return-Path: <linux-fsdevel+bounces-66084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28802C17C17
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A6740020C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F62E2D879A;
	Wed, 29 Oct 2025 01:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HifAG7E/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA69823E35B;
	Wed, 29 Oct 2025 01:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699981; cv=none; b=CeewO4s6hukQ6GEX8qGzE96YqZBfLgbnO1B3T4mE9VJqqEmwP5H0W4M6Sx9o9OdI/nosdqAf6yvbbACLSAmSVMuUb4ZQjKaL+/fiYKEkcuSCyPX0XGVwqJWcBMwqsS4i0v2JngwEMQj1LhORlpoYN5YNuKunX/2v2bxK66YooWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699981; c=relaxed/simple;
	bh=J+6Y1Fc42ISYArn7S/TJWG/90CYyZR8fS18z0jFkUrk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VLCRK9fRYLdYNobnPD97uZICFq/KKF9UvNajxIMwncW9aRWE4IDmobCfXLq/czufw6SBCXnGNlxuBTokkoFfzvr4DQIw3W2GlDbIPTZSIgpFlxOg/UPQvfIAzxHJLi9KoIiNzHxsubeNgs4GyaVJTZco9OXGSvE/bxcHZzwh3qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HifAG7E/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37602C4CEE7;
	Wed, 29 Oct 2025 01:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699981;
	bh=J+6Y1Fc42ISYArn7S/TJWG/90CYyZR8fS18z0jFkUrk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=HifAG7E/Ll/8Trv2YQyEyuP5v3C6jcPOGyYok8PFdf6g908CFSepDSDcu95JzWBUa
	 oOJIFPh0uw+1lOaLxYJp02WUo0YPa11hBpMGvjPuyLPR+7b//PYRbN3sQhWpAm9WBQ
	 SUWdeYBEm5sLMEAgmV5nHTSnMRST/ARs/TFBeX7gYqJYNhJwvT4nGYfC7XHrEtVNM0
	 2w4svf/aQOPi4rx9XguIUb7x3tPlQ2kJ3ySBVF7vsp+9WNyjJ2xO4kURUuuYYPxMul
	 C8zCz8xKBZ2qjvVdRXOxjXzLBY8oTSvIKAh7guqkYMczpaf1S3gAeIh52AioGiJxNn
	 th5FROV4Q7c4g==
Date: Tue, 28 Oct 2025 18:06:20 -0700
Subject: [PATCH 4/4] libfuse: add syncfs support to the upper library
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169814390.1428390.9380093122042614031.stgit@frogsfrogsfrogs>
In-Reply-To: <176169814307.1428390.11550104537543281678.stgit@frogsfrogsfrogs>
References: <176169814307.1428390.11550104537543281678.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Support syncfs in the upper level library.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h |    5 +++++
 lib/fuse.c     |   31 +++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)


diff --git a/include/fuse.h b/include/fuse.h
index a10666b78eb1eb..3d36b49e1b3f67 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -918,6 +918,11 @@ struct fuse_operations {
 	 * Shut down the filesystem
 	 */
 	int (*shutdownfs) (const char *path, uint64_t flags);
+
+	/*
+	 * Flush the entire filesystem to disk.
+	 */
+	int (*syncfs) (const char *path);
 };
 
 /** Extra context that may be needed by some filesystems
diff --git a/lib/fuse.c b/lib/fuse.c
index b8d4b4600077d7..d54fc9ea2004bd 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -3000,6 +3000,16 @@ static int fuse_fs_shutdownfs(struct fuse_fs *fs, const char *path,
 	return fs->op.shutdownfs(path, flags);
 }
 
+static int fuse_fs_syncfs(struct fuse_fs *fs, const char *path)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.syncfs)
+		return -ENOSYS;
+	if (fs->debug)
+		fuse_log(FUSE_LOG_DEBUG, "syncfs[%s]\n", path);
+	return fs->op.syncfs(path);
+}
+
 static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 			     int valid, struct fuse_file_info *fi)
 {
@@ -4933,6 +4943,26 @@ static void fuse_lib_shutdownfs(fuse_req_t req, fuse_ino_t ino, uint64_t flags)
 	reply_err(req, err);
 }
 
+static void fuse_lib_syncfs(fuse_req_t req, fuse_ino_t ino)
+{
+	struct fuse *f = req_fuse_prepare(req);
+	struct fuse_intr_data d;
+	char *path;
+	int err;
+
+	err = get_path(f, ino, &path);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	fuse_prepare_interrupt(f, req, &d);
+	err = fuse_fs_syncfs(f->fs, path);
+	fuse_finish_interrupt(f, req, &d);
+	free_path(f, ino, path);
+	reply_err(req, err);
+}
+
 static int clean_delay(struct fuse *f)
 {
 	/*
@@ -5034,6 +5064,7 @@ static struct fuse_lowlevel_ops fuse_path_ops = {
 #ifdef HAVE_STATX
 	.statx = fuse_lib_statx,
 #endif
+	.syncfs = fuse_lib_syncfs,
 	.freezefs = fuse_lib_freezefs,
 	.unfreezefs = fuse_lib_unfreezefs,
 	.shutdownfs = fuse_lib_shutdownfs,


