Return-Path: <linux-fsdevel+bounces-58559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 408D3B2EA92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A8EE4E2C2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB05218AC4;
	Thu, 21 Aug 2025 01:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGojEliO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5529920B81B;
	Thu, 21 Aug 2025 01:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739396; cv=none; b=qTCsiqRng1aloC/7E6Z+XzoaG29RoX7xo/4UDEMXJEaVQCPGocUTuAQHkevCZ2QqJbI+9mdUJz3XUo6UhCyjaZiGXAN4gnG1tBb6EtKBHaDG9cPqrfFVU8kjUExUv9214ama6PyLqguNWKJF0tPRVeqSTWsvH8Qd0jfIsdZZcKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739396; c=relaxed/simple;
	bh=i9XmbDibZwM7byLkb39dUonbRLldaLnJd1H0lO/HT7g=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ry40QbE9F80Qu889v3Sj9hB0d8avWThpUXFvbb/hkXlB0v9kHCqefM7es7Hf2+gP5oDyN9yEKw4MmGf1BeVL22zmarvxaqTxDqHiixXD73mu0liYmQSLV8ZLyyjmZyNO3Mb9ktT8uWbs9q2WZCji5BQCRilnqQhfonr/4E8QqaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGojEliO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A305C4CEE7;
	Thu, 21 Aug 2025 01:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755739396;
	bh=i9XmbDibZwM7byLkb39dUonbRLldaLnJd1H0lO/HT7g=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ZGojEliO5VmtwbAckxIlcFa3zr25Le3f6Q81unegKgTRHVe27CL5x5i+DTvsctz3W
	 D53w+oB9xNtxnzo7MF1VHRz7y5eBeE5dH46/afJ0m7WCEmZS/GLy4po+Zb12QIRTp6
	 EAFQscolS49u2RPkTACAsjBvJrnNWUZ99uq+n8csTpuZVWn4SVEb5TU7LaOuAhUrYI
	 AxJPQD2qcSUItpqne9aqlBvJ6sNsLJGXyCgmexpGimMHtTLiBT1Dt+uJJb2/nNM/rZ
	 fq/cuMACecxEmX0HcgbMOzVjA9WSjjyZ1C8P2DsUej6utpdI2GRdKD//LgbeXHxhTJ
	 fNWz8lS90xuRg==
Date: Wed, 20 Aug 2025 18:23:15 -0700
Subject: [PATCH 8/8] fuse2fs: skip the gdt write in op_destroy if syncfs is
 working
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573714537.22854.4387913032128676357.stgit@frogsfrogsfrogs>
In-Reply-To: <175573714359.22854.5198450217393478706.stgit@frogsfrogsfrogs>
References: <175573714359.22854.5198450217393478706.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

As an umount-time performance enhancement, don't bother to write the
group descriptor tables in op_destroy if we know that op_syncfs will do
it for us.  That only happens if iomap is enabled.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   19 ++++++++++++++++---
 misc/fuse4fs.c |   19 ++++++++++++++++---
 2 files changed, 32 insertions(+), 6 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 62aca0ab56ec07..f5d68cc549ad69 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -269,6 +269,7 @@ struct fuse2fs {
 	uint8_t unmount_in_destroy;
 	uint8_t noblkdev;
 	uint8_t iomap_passthrough_options;
+	uint8_t write_gdt_on_destroy;
 
 	enum fuse2fs_opstate opstate;
 	int logfd;
@@ -1309,9 +1310,11 @@ static void op_destroy(void *p EXT2FS_ATTR((unused)))
 		if (fs->super->s_error_count)
 			fs->super->s_state |= EXT2_ERROR_FS;
 		ext2fs_mark_super_dirty(fs);
-		err = ext2fs_set_gdt_csum(fs);
-		if (err)
-			translate_error(fs, 0, err);
+		if (ff->write_gdt_on_destroy) {
+			err = ext2fs_set_gdt_csum(fs);
+			if (err)
+				translate_error(fs, 0, err);
+		}
 
 		err = ext2fs_flush2(fs, 0);
 		if (err)
@@ -5443,6 +5446,15 @@ static int op_syncfs(const char *path)
 		}
 	}
 
+	/*
+	 * When iomap is enabled, the kernel will call syncfs right before
+	 * calling the destroy method.  If any syncfs succeeds, then we know
+	 * that there will be a last syncfs and that it will write the GDT, so
+	 * destroy doesn't need to waste time doing that.
+	 */
+	if (fuse2fs_iomap_enabled(ff))
+		ff->write_gdt_on_destroy = 0;
+
 out_unlock:
 	fuse2fs_finish(ff, ret);
 	return ret;
@@ -7088,6 +7100,7 @@ int main(int argc, char *argv[])
 		.iomap_dev = FUSE_IOMAP_DEV_NULL,
 		.iomap_cache = 1,
 #endif
+		.write_gdt_on_destroy = 1,
 	};
 	errcode_t err;
 	FILE *orig_stderr = stderr;
diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index e01b83e271415c..6f03c6a0933a3d 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -265,6 +265,7 @@ struct fuse4fs {
 	uint8_t noblkdev;
 	uint8_t iomap_passthrough_options;
 	uint8_t translate_inums;
+	uint8_t write_gdt_on_destroy;
 
 	enum fuse4fs_opstate opstate;
 	int logfd;
@@ -1472,9 +1473,11 @@ static void op_destroy(void *userdata)
 		if (fs->super->s_error_count)
 			fs->super->s_state |= EXT2_ERROR_FS;
 		ext2fs_mark_super_dirty(fs);
-		err = ext2fs_set_gdt_csum(fs);
-		if (err)
-			translate_error(fs, 0, err);
+		if (ff->write_gdt_on_destroy) {
+			err = ext2fs_set_gdt_csum(fs);
+			if (err)
+				translate_error(fs, 0, err);
+		}
 
 		err = ext2fs_flush2(fs, 0);
 		if (err)
@@ -5736,6 +5739,15 @@ static void op_syncfs(fuse_req_t req, fuse_ino_t ino)
 		}
 	}
 
+	/*
+	 * When iomap is enabled, the kernel will call syncfs right before
+	 * calling the destroy method.  If any syncfs succeeds, then we know
+	 * that there will be a last syncfs and that it will write the GDT, so
+	 * destroy doesn't need to waste time doing that.
+	 */
+	if (fuse4fs_iomap_enabled(ff))
+		ff->write_gdt_on_destroy = 0;
+
 out_unlock:
 	fuse4fs_finish(ff, ret);
 	fuse_reply_err(req, -ret);
@@ -7472,6 +7484,7 @@ int main(int argc, char *argv[])
 		.iomap_cache = 1,
 #endif
 		.translate_inums = 1,
+		.write_gdt_on_destroy = 1,
 	};
 	errcode_t err;
 	FILE *orig_stderr = stderr;


