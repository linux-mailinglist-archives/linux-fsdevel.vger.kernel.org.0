Return-Path: <linux-fsdevel+bounces-58494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B92B2EA01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0348C3B3031
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91191E7C23;
	Thu, 21 Aug 2025 01:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWjMFRTs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E4B1A9F9F
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 01:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738379; cv=none; b=X+evrUWliUbsrq8a3WpRCvSa50ChigudpAwSiHoQW0801yMsqQgMkqPk/xExjgHzxfn93a4gpQy7e/9VF/0VuQZO0pO/MgNfAr769zvcQVYJ8+yXoPYx6wvcHFpSqAoyNnj229Gn5mkjuVtmIVac6tTrw3o4XvxdJAUnMZ85Nis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738379; c=relaxed/simple;
	bh=nBr7MD2sIRNNYj0Fxn8Q18H6PQMKHXbKFmnhJs/OvjA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R5KJCVjWh2J908mEwdRpYjaUr6iNln0prQKT+bsZFvWuytogGGRWoRP1NME05pa4Q22WLKea/V3BMTTyk38BDVILKWqfALNkbGRatAYLESw3jli6WHna4FLXXslIkkvdoPUZ4g7+1yGOFYB5+aZPIGxD3XfHYy/dbvDr+k5WA2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWjMFRTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C66BC4CEE7;
	Thu, 21 Aug 2025 01:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738379;
	bh=nBr7MD2sIRNNYj0Fxn8Q18H6PQMKHXbKFmnhJs/OvjA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=uWjMFRTsn96HojSiJZhRt+9woqBpfSPOokRqByWLvG6171AHiqIute/6+K44odnBB
	 g02IhKrkuM5BTlG5SFM8k8teUY4dEMVCRkzIYuRSljnU7A//ydPYMUFLP2DaM37GI0
	 hR7WCg+zxY3MLy32aTjmgk3+dZvFHaZx4Ho1Alyz64l1pd3ZiN2W7X7L2CDCDZHf/Z
	 wODeVlkBRTEOY7lGFejOqkILucW54wYw0cDMGiMWE8jTq2wIK92SL2fiT7mPMhfMps
	 jaGugd8tDk/SaU6nt72/0/LD2hixinhkucn1//DaJeeX4NA20Y7mxv/epeNYwY1Y/3
	 ame9wTwGkJNEw==
Date: Wed, 20 Aug 2025 18:06:18 -0700
Subject: [PATCH 19/21] libfuse: add upper-level API to invalidate parts of an
 iomap block device
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <175573711641.19163.7507090510081227510.stgit@frogsfrogsfrogs>
In-Reply-To: <175573711192.19163.9486664721161324503.stgit@frogsfrogsfrogs>
References: <175573711192.19163.9486664721161324503.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Wire up the upper-level wrappers to
fuse_lowlevel_iomap_invalidate_device.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h         |   10 ++++++++++
 lib/fuse.c             |    9 +++++++++
 lib/fuse_versionscript |    1 +
 3 files changed, 20 insertions(+)


diff --git a/include/fuse.h b/include/fuse.h
index 74b86e8d27fb35..e53e92786cea08 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -1422,6 +1422,16 @@ int fuse_fs_iomap_device_add(int fd, unsigned int flags);
  */
 int fuse_fs_iomap_device_remove(int device_id);
 
+/**
+ * Invalidate any pagecache for the given iomap (block) device.
+ *
+ * @param device_id device index as returned by fuse_lowlevel_iomap_device_add
+ * @param offset starting offset of the range to invalidate
+ * @param length length of the range to invalidate
+ * @return 0 on success, or negative errno on failure
+ */
+int fuse_fs_iomap_device_invalidate(int device_id, off_t offset, off_t length);
+
 /**
  * Decide if we can enable iomap mode for a particular file for an upper-level
  * fuse server.
diff --git a/lib/fuse.c b/lib/fuse.c
index 177c524eff736b..1c813ec5a697a0 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2917,6 +2917,15 @@ int fuse_fs_iomap_device_remove(int device_id)
 	return fuse_lowlevel_iomap_device_remove(se, device_id);
 }
 
+int fuse_fs_iomap_device_invalidate(int device_id, off_t offset, off_t length)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse_session *se = fuse_get_session(ctxt->fuse);
+
+	return fuse_lowlevel_iomap_device_invalidate(se, device_id, offset,
+						     length);
+}
+
 static int fuse_fs_iomap_ioend(struct fuse_fs *fs, const char *path,
 			       uint64_t nodeid, uint64_t attr_ino, off_t pos,
 			       size_t written, uint32_t ioendflags, int error,
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 65ce70649b031c..102f449d28a0be 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -234,6 +234,7 @@ FUSE_3.99 {
 		fuse_lowlevel_discover_iomap;
 		fuse_reply_iomap_config;
 		fuse_lowlevel_iomap_device_invalidate;
+		fuse_fs_iomap_device_invalidate;
 } FUSE_3.18;
 
 # Local Variables:


