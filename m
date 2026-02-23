Return-Path: <linux-fsdevel+bounces-78190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uChJNavmnGlNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:45:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C70A17FE87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E69D3035BFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4315837FF74;
	Mon, 23 Feb 2026 23:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGxxd1/T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C319C37756A;
	Mon, 23 Feb 2026 23:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890343; cv=none; b=nspGlyDJXTJRWlEs81w4jFyH8pic8G9omO4rFoeaE+KyNxyCoW1vkKUViouBljpBLyznKEcvVOM5diYW1uZvN4rMP1hmyTB7nKYhN1RJDCFoqNynnFzZhL6zile9B9AngQXijVYgnEHAfdG5iFmthOQeY6R4oSPwH+RtZ7BKIkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890343; c=relaxed/simple;
	bh=Kymsv5FeuWcSI4j8liXVr1/oa8KZmqNY3ddMEl2N6uY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tjfu0IDYvifyEnH/LBiRrXbdlar6dMXKfXXogSXdDUaSht40GUYHEHTX5DiSvfPZ9UjL4qSuN0UpvpyVrDm1AjW/I7gmEmnQeBumDKLbagPZNUqaCeL29bo1fbX8gFl1XSt9gMjLk0YtCkaEbLSaZiLApvLNbijedbmfVali/30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGxxd1/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D171C116C6;
	Mon, 23 Feb 2026 23:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890343;
	bh=Kymsv5FeuWcSI4j8liXVr1/oa8KZmqNY3ddMEl2N6uY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=TGxxd1/T2S2dGBE0VKFMOr6IWDSqfw6J4mCj+tIpdwe+sn3W/BYVzzmmkidERNpPC
	 TRx4LFW5dR+IExuTb3N5B/ValeI6mbjrZfgs40UBLPw5St1CZGqfuDpeRz3M345cSM
	 1XHnu7554ZRCvMHYffbnSPtmME+V4OG1IzGiezfXC1kn5InBHcPPExMwI5+aF8ZIqA
	 OiY1PLqvOYSHyVl5Vbb53KW6RE7SxSq0e9bWjK0njENQyMaTRE1gN51eseZdskX1fZ
	 kuXPAnCSOoQmUskZKtbiq0wIHD/nIx5Yg7jGtsjXeja1gbSKDjRMfp34A3QptFQ1IM
	 aH9eWj2nDDMoA==
Date: Mon, 23 Feb 2026 15:45:42 -0800
Subject: [PATCH 4/6] fuse2fs: enable caching IO manager
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188745764.3944626.6557175043695858878.stgit@frogsfrogsfrogs>
In-Reply-To: <177188745668.3944626.16408108516155796668.stgit@frogsfrogsfrogs>
References: <177188745668.3944626.16408108516155796668.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78190-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C70A17FE87
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Enable the new dynamic iocache I/O manager in the fuse server, and turn
off all the other cache control.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/Makefile.in |    3 ++-
 fuse4fs/fuse4fs.c   |    4 +++-
 misc/Makefile.in    |    4 +++-
 misc/fuse2fs.c      |    6 +++++-
 4 files changed, 13 insertions(+), 4 deletions(-)


diff --git a/fuse4fs/Makefile.in b/fuse4fs/Makefile.in
index 9f3547c271638f..0a558da23ced81 100644
--- a/fuse4fs/Makefile.in
+++ b/fuse4fs/Makefile.in
@@ -147,7 +147,8 @@ fuse4fs.o: $(srcdir)/fuse4fs.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/ext2fs/ext2fsP.h \
  $(top_srcdir)/lib/ext2fs/ext2fs.h $(top_srcdir)/version.h \
  $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/support/cache.h \
- $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/support/xbitops.h
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/support/xbitops.h \
+ $(top_srcdir)/lib/support/iocache.h
 journal.o: $(srcdir)/../debugfs/journal.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/../debugfs/journal.h \
  $(top_srcdir)/e2fsck/jfs_user.h $(top_srcdir)/e2fsck/e2fsck.h \
diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index e8edeb8f62e88a..d91817f362674a 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -56,6 +56,7 @@
 #include "support/bthread.h"
 #include "support/list.h"
 #include "support/cache.h"
+#include "support/iocache.h"
 
 #include "../version.h"
 #include "uuid/uuid.h"
@@ -1574,6 +1575,7 @@ static errcode_t fuse4fs_open(struct fuse4fs *ff)
 		flags |= EXT2_FLAG_DIRECT_IO;
 
 	dbg_printf(ff, "opening with flags=0x%x\n", flags);
+	iocache_set_backing_manager(unix_io_manager);
 
 	err = fuse4fs_try_losetup(ff, flags);
 	if (err)
@@ -1611,7 +1613,7 @@ static errcode_t fuse4fs_open(struct fuse4fs *ff)
 	deadline = init_deadline(FUSE4FS_OPEN_TIMEOUT);
 	do {
 		err = ext2fs_open2(fuse4fs_device(ff), options, flags, 0, 0,
-				   unix_io_manager, &ff->fs);
+				   iocache_io_manager, &ff->fs);
 		if ((err == EPERM || err == EACCES) &&
 		    (!ff->ro || (flags & EXT2_FLAG_RW))) {
 			/*
diff --git a/misc/Makefile.in b/misc/Makefile.in
index ec964688acd623..8a3adc70fb736e 100644
--- a/misc/Makefile.in
+++ b/misc/Makefile.in
@@ -880,7 +880,9 @@ fuse2fs.o: $(srcdir)/fuse2fs.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/ext2_ext_attr.h $(top_srcdir)/lib/ext2fs/hashmap.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/ext2fs/ext2fsP.h \
  $(top_srcdir)/lib/ext2fs/ext2fs.h $(top_srcdir)/version.h \
- $(top_srcdir)/lib/e2p/e2p.h
+ $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/support/cache.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/support/xbitops.h \
+ $(top_srcdir)/lib/support/iocache.h
 e2fuzz.o: $(srcdir)/e2fuzz.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 96118942c324ba..3d78a3967f7d9a 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -53,6 +53,9 @@
 #include "ext2fs/ext2_fs.h"
 #include "ext2fs/ext2fsP.h"
 #include "support/bthread.h"
+#include "support/list.h"
+#include "support/cache.h"
+#include "support/iocache.h"
 
 #include "../version.h"
 #include "uuid/uuid.h"
@@ -1404,6 +1407,7 @@ static errcode_t fuse2fs_open(struct fuse2fs *ff)
 		flags |= EXT2_FLAG_DIRECT_IO;
 
 	dbg_printf(ff, "opening with flags=0x%x\n", flags);
+	iocache_set_backing_manager(unix_io_manager);
 
 	err = fuse2fs_try_losetup(ff, flags);
 	if (err)
@@ -1441,7 +1445,7 @@ static errcode_t fuse2fs_open(struct fuse2fs *ff)
 	deadline = init_deadline(FUSE2FS_OPEN_TIMEOUT);
 	do {
 		err = ext2fs_open2(fuse2fs_device(ff), options, flags, 0, 0,
-				   unix_io_manager, &ff->fs);
+				   iocache_io_manager, &ff->fs);
 		if ((err == EPERM || err == EACCES) &&
 		    (!ff->ro || (flags & EXT2_FLAG_RW))) {
 			/*


