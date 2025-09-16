Return-Path: <linux-fsdevel+bounces-61560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA86B589E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B5F16FADC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E3F14F112;
	Tue, 16 Sep 2025 00:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkb7PLYS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F991F95C
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983308; cv=none; b=elGZV3iYedIibqyoLDtqDeIapCd0KzfsnGHgbZdTkv6yGF/4v4sCeIvGdrxbrubu6V7PcbhrLNbBuwiFYd+hGqOQUIZ9uenRyhuwopWfzmYSk77HFFFrVzuMIvddjiRckeis2vfpa3z4Rgb2USvMlR2M6Yqxdae1x5AzFOApLUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983308; c=relaxed/simple;
	bh=Jj3Jo5hYuGzysiSOZIpqnew5Sj9LKWBZ1l8WghwCTA8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t6XuggjrBxeeGvRaOvT/tket5iPDQ1AU/ZFfX+2AqLN6rI1p3a91KQ0J2TQwwOWg9xI1I4Sin9wyrGBuyY6tZE/rQjAvb2x55HYxKz/IkJqg72jA4+zRfilRQQ0ugiGvkNyaOoiR+HxzqN1HrsEvsH37OcILUNwleMUsnwFLRLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkb7PLYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE499C4CEF1;
	Tue, 16 Sep 2025 00:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983307;
	bh=Jj3Jo5hYuGzysiSOZIpqnew5Sj9LKWBZ1l8WghwCTA8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=hkb7PLYSmzlt/AlRCyB7LdZ8NP4iYpEyPvh1X27377lHc845CWYg7AqCsiSn11MGo
	 0o0+wEikPnR3vR27VL2n4X//uzi2Fd4WKGMvzJl4hhiH9tf6BzcDpGZutAms5i2EaS
	 /l6X40AbSIbqBCGJpQj/lpgnFo1544DjZp6zXgpe7kJ3a2gLQy/xHyifzVRoB2gK2P
	 orHmKJaDAv3FNEFyXw5TTLmbFnmy0f1OTJ2IecFcoCOeNr54w1vX9vE4rMczIsmi0D
	 DdCi3tD/vhj+wOjgP3eZp/BrS+v3Ydro/ZtRi1izt6Zvj6R2FXvtrE7TT8qdNurV6m
	 cmzZEO0zATkmw==
Date: Mon, 15 Sep 2025 17:41:47 -0700
Subject: [PATCH 1/1] libfuse: don't put HAVE_STATX in a public header
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798154240.386823.11914403737098230888.stgit@frogsfrogsfrogs>
In-Reply-To: <175798154222.386823.13485387355674002636.stgit@frogsfrogsfrogs>
References: <175798154222.386823.13485387355674002636.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

fuse.h and fuse_lowlevel.h are public headers, don't expose internal
build system config variables to downstream clients.  This can also lead
to function pointer ordering issues if (say) libfuse gets built with
HAVE_STATX but the client program doesn't define a HAVE_STATX.

Get rid of the conditionals in the public header files to fix this.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h           |    2 --
 include/fuse_lowlevel.h  |    2 --
 example/memfs_ll.cc      |    2 +-
 example/passthrough.c    |    2 +-
 example/passthrough_fh.c |    2 +-
 example/passthrough_ll.c |    2 +-
 6 files changed, 4 insertions(+), 8 deletions(-)


diff --git a/include/fuse.h b/include/fuse.h
index 06feacb070fbfb..209102651e9454 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -854,7 +854,6 @@ struct fuse_operations {
 	 */
 	off_t (*lseek) (const char *, off_t off, int whence, struct fuse_file_info *);
 
-#ifdef HAVE_STATX
 	/**
 	 * Get extended file attributes.
 	 *
@@ -865,7 +864,6 @@ struct fuse_operations {
 	 */
 	int (*statx)(const char *path, int flags, int mask, struct statx *stxbuf,
 		     struct fuse_file_info *fi);
-#endif
 };
 
 /** Extra context that may be needed by some filesystems
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index dc4ec07e6dbb00..a6cce014391aec 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -1327,7 +1327,6 @@ struct fuse_lowlevel_ops {
 	void (*tmpfile) (fuse_req_t req, fuse_ino_t parent,
 			mode_t mode, struct fuse_file_info *fi);
 
-#ifdef HAVE_STATX
 	/**
 	 * Get extended file attributes.
 	 *
@@ -1343,7 +1342,6 @@ struct fuse_lowlevel_ops {
 	 */
 	void (*statx)(fuse_req_t req, fuse_ino_t ino, int flags, int mask,
 		      struct fuse_file_info *fi);
-#endif
 };
 
 /**
diff --git a/example/memfs_ll.cc b/example/memfs_ll.cc
index edda34b4e43d39..7055a434a439cd 100644
--- a/example/memfs_ll.cc
+++ b/example/memfs_ll.cc
@@ -6,7 +6,7 @@
   See the file GPL2.txt.
 */
 
-#define FUSE_USE_VERSION 317
+#define FUSE_USE_VERSION FUSE_MAKE_VERSION(3, 18)
 
 #include <algorithm>
 #include <stdio.h>
diff --git a/example/passthrough.c b/example/passthrough.c
index fdaa19e331a17d..1f09c2dc05df1e 100644
--- a/example/passthrough.c
+++ b/example/passthrough.c
@@ -23,7 +23,7 @@
  */
 
 
-#define FUSE_USE_VERSION 31
+#define FUSE_USE_VERSION FUSE_MAKE_VERSION(3, 18)
 
 #define _GNU_SOURCE
 
diff --git a/example/passthrough_fh.c b/example/passthrough_fh.c
index 0d4fb5bd4df0d6..6403fbb74c7759 100644
--- a/example/passthrough_fh.c
+++ b/example/passthrough_fh.c
@@ -23,7 +23,7 @@
  * \include passthrough_fh.c
  */
 
-#define FUSE_USE_VERSION 31
+#define FUSE_USE_VERSION FUSE_MAKE_VERSION(3, 18)
 
 #define _GNU_SOURCE
 
diff --git a/example/passthrough_ll.c b/example/passthrough_ll.c
index 5ca6efa2300abe..8a5ac2e9226b59 100644
--- a/example/passthrough_ll.c
+++ b/example/passthrough_ll.c
@@ -35,7 +35,7 @@
  */
 
 #define _GNU_SOURCE
-#define FUSE_USE_VERSION FUSE_MAKE_VERSION(3, 12)
+#define FUSE_USE_VERSION FUSE_MAKE_VERSION(3, 18)
 
 #include <fuse_lowlevel.h>
 #include <unistd.h>


