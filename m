Return-Path: <linux-fsdevel+bounces-55358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6DFB0982E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC7E16FEDC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9324223A9AD;
	Thu, 17 Jul 2025 23:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwPNbaIK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003AF2459DA
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795469; cv=none; b=eZFtiO15PRTmok4UcU0eXtsKYRVNpqlnu02wDjDESZhxksT2pwVZS10ItBmEJchCKnsnZRJBO9TGGW1IZzH9nnXLFH00Fhw8Q4YEgemQc8ovvoMQGKMMn2jE+cfXKFI5JVHnapPbTY42DiSQ4BVpltnAz7LuV0tUEuAv2WJLlAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795469; c=relaxed/simple;
	bh=tA431Abe7djLglomRQIRGBnyWrIJo5YnRJesGuqagVs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tX8MCgU66TIHByqaUBIR9ehBrMzvzMLkfdrD/mWFQRr0vRogP9aEdckuh2u3ntkeez85hv739n3CBDfomBE1UiawCPRGrOkPoE36G07HjyloQrXxQmTl6v8ZwmYbt3WgIAqYFuz37bfiB8XNCBC9U1fvfRSIE81/s778ofVwHfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwPNbaIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCA7C4CEF4;
	Thu, 17 Jul 2025 23:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795468;
	bh=tA431Abe7djLglomRQIRGBnyWrIJo5YnRJesGuqagVs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=PwPNbaIK0DC+LXK5LwRX4l/isbPVDwb1Mlouf1Eg30FaiizPPwBqZIyHSAYJ3r+oK
	 lfyKp3h++JQCWhf0i1EBiE19mOGv8TNVYegVxqJiWj2QISlMV7vc58CnuX8czbUinr
	 Of31gYX8aOjnwlB1jU7Uxnhwpv/VZh+gYf8viR0+IYpbygNZ5pMjwNIm4Oy0GutYBM
	 ULRXMDqD7swLv+6nmeR3EecT/3Q1vnf5utrQBkMQBNmvlIiL7PYjkc+kFl5Ygk0sSR
	 LGvUW995HyYygCQ8oaAWYAgaxpgovvKsT6IqOn0FQrxSLiDoGMN/QjndMmmM4pWB+B
	 TM6jOOWOW2BEA==
Date: Thu, 17 Jul 2025 16:37:48 -0700
Subject: [PATCH 13/14] libfuse: add upper level iomap_config implementation
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, neal@gompa.dev, miklos@szeredi.hu
Message-ID: <175279459965.714161.6675698162970623637.stgit@frogsfrogsfrogs>
In-Reply-To: <175279459673.714161.10658209239262310420.stgit@frogsfrogsfrogs>
References: <175279459673.714161.10658209239262310420.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add FUSE_IOMAP_CONFIG helpers to the upper level fuse library.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h |    7 +++++++
 lib/fuse.c     |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)


diff --git a/include/fuse.h b/include/fuse.h
index f894dd5da0d106..6ce6ccfd102386 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -883,6 +883,13 @@ struct fuse_operations {
 	 */
 	int (*getattr_iflags) (const char *path, struct stat *buf,
 			       unsigned int *iflags, struct fuse_file_info *fi);
+
+	/**
+	 * Configure the filesystem geometry that will be used by iomap
+	 * files.
+	 */
+	int (*iomap_config) (uint32_t flags, off_t maxbytes,
+			     struct fuse_iomap_config *cfg);
 #endif /* FUSE_USE_VERSION >= 318 */
 };
 
diff --git a/lib/fuse.c b/lib/fuse.c
index 685d0181e569d0..b722a1b526e3de 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2870,6 +2870,23 @@ static int fuse_fs_iomap_ioend(struct fuse_fs *fs, const char *path,
 				  ioendflags, error, new_addr);
 }
 
+static int fuse_fs_iomap_config(struct fuse_fs *fs, uint32_t flags,
+				int64_t maxbytes,
+				struct fuse_iomap_config *cfg)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.iomap_config)
+		return -ENOSYS;
+
+	if (fs->debug) {
+		fuse_log(FUSE_LOG_DEBUG,
+			 "iomap_config flags 0x%x maxbytes %lld\n",
+			 flags, (long long)maxbytes);
+	}
+
+	return fs->op.iomap_config(flags, maxbytes, cfg);
+}
+
 static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 			     int valid, struct fuse_file_info *fi)
 {
@@ -4637,6 +4654,25 @@ static void fuse_lib_iomap_ioend(fuse_req_t req, fuse_ino_t nodeid,
 	reply_err(req, err);
 }
 
+static void fuse_lib_iomap_config(fuse_req_t req, uint32_t flags,
+				  int64_t maxbytes)
+{
+	struct fuse_iomap_config cfg = { };
+	struct fuse *f = req_fuse_prepare(req);
+	struct fuse_intr_data d;
+	int err;
+
+	fuse_prepare_interrupt(f, req, &d);
+	err = fuse_fs_iomap_config(f->fs, flags, maxbytes, &cfg);
+	fuse_finish_interrupt(f, req, &d);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	fuse_reply_iomap_config(req, &cfg);
+}
+
 static int clean_delay(struct fuse *f)
 {
 	/*
@@ -4738,6 +4774,7 @@ static struct fuse_lowlevel_ops fuse_path_ops = {
 	.iomap_begin = fuse_lib_iomap_begin,
 	.iomap_end = fuse_lib_iomap_end,
 	.iomap_ioend = fuse_lib_iomap_ioend,
+	.iomap_config = fuse_lib_iomap_config,
 };
 
 int fuse_notify_poll(struct fuse_pollhandle *ph)


