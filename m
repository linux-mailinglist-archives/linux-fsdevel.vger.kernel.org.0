Return-Path: <linux-fsdevel+bounces-78192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4L9PFVjnnGmNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:48:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ED517FFBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4300A3102153
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B18237FF78;
	Mon, 23 Feb 2026 23:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2oCHpmL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171623783BB;
	Mon, 23 Feb 2026 23:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890375; cv=none; b=PZUBGOicLq3tfw0dwMEmgckSu2qzIptpxUtbmd6oun8lWS3hizrlJDAopuZefM/TuJo+ixY/rYR1ZFhvYxxIq00oixiyMlds/6xCTjK24NF7j+pET/VmOYnLEUj78oGZV/Esqol8V9mOsWPtkWG2ToSicTmbG8IMKzRuE3f+8eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890375; c=relaxed/simple;
	bh=N6aLA5D6GmcgeBhZhoMz1MMMYvn8/tysv57kBECPXvY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DeKXftR2O1sn7nSPr3V7tDTXgQCMECKQqYkNrjPyZDlNfqt1JCYytA0zwuC/efuJ9vYKHNSxgvDa9DiuTwed8PXbCAJGEC2VdPAuR4PcN6Zuup/OAaiMLqPEYRbwNLcW9zk4uOk/cUqMqD5sZAcozbRr9v3YCDDys6bAFsDYOoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2oCHpmL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BD8C116C6;
	Mon, 23 Feb 2026 23:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890374;
	bh=N6aLA5D6GmcgeBhZhoMz1MMMYvn8/tysv57kBECPXvY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=F2oCHpmLG3w5DB44gZ8qLKJn6C3fyAmb0jCcjH2gTMIiTe+ewkcjrTAR+DPm20ahw
	 p2TK8M2reU6dIqeV85CCPes1pxQT3BFsT2+8yjVTW0ofB0C59BCrDocsSM6sNaQXP/
	 +M5i03OZslp7GfHYU2saADxJ6fgqjmqVk6DjyYjHPJmQUHtnRgBV9nKTu/RAlF1FoW
	 IUVPFXFvb6kos4UGGFVHwEksMNhVr1AKzZHEtOHz1zLZPNdjSUOtivuigJf21EH2Uw
	 1G31AB8g3YSEule9bOru54oynb8+iNk28n2CqbQZYZ8ANnZqAtZQ1OAj0lfSpmb75r
	 watk4hUyb5sEQ==
Date: Mon, 23 Feb 2026 15:46:14 -0800
Subject: [PATCH 6/6] libext2fs: improve caching for inodes
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188745799.3944626.6199380767856758602.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78192-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B6ED517FFBE
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Use our new cache code to improve the ondisk inode cache inside
libext2fs.  Oops, list.h duplication, and libext2fs needs to link
against libsupport now.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/ext2fsP.h     |   13 ++-
 debugfs/Makefile.in      |    8 +-
 e2fsck/Makefile.in       |   12 +--
 fuse4fs/Makefile.in      |    8 +-
 lib/ext2fs/Makefile.in   |   70 ++++++++-------
 lib/ext2fs/inline_data.c |    4 -
 lib/ext2fs/inode.c       |  215 ++++++++++++++++++++++++++++++++++++----------
 misc/Makefile.in         |    8 +-
 resize/Makefile.in       |   11 +-
 tests/fuzz/Makefile.in   |    4 -
 tests/progs/Makefile.in  |    4 -
 11 files changed, 240 insertions(+), 117 deletions(-)


diff --git a/lib/ext2fs/ext2fsP.h b/lib/ext2fs/ext2fsP.h
index 428081c9e2ff38..8490dd5139d543 100644
--- a/lib/ext2fs/ext2fsP.h
+++ b/lib/ext2fs/ext2fsP.h
@@ -82,21 +82,26 @@ struct dir_context {
 	errcode_t	errcode;
 };
 
+#include "support/list.h"
+#include "support/cache.h"
+
 /*
  * Inode cache structure
  */
 struct ext2_inode_cache {
 	void *				buffer;
 	blk64_t				buffer_blk;
-	int				cache_last;
-	unsigned int			cache_size;
 	int				refcount;
-	struct ext2_inode_cache_ent	*cache;
+	struct cache			cache;
 };
 
 struct ext2_inode_cache_ent {
+	struct cache_node	node;
 	ext2_ino_t		ino;
-	struct ext2_inode	*inode;
+	uint8_t			access;
+
+	/* bytes representing a host-endian ext2_inode_large object */
+	char			raw[];
 };
 
 /*
diff --git a/debugfs/Makefile.in b/debugfs/Makefile.in
index 700ae87418c268..8bee4b67fc2de7 100644
--- a/debugfs/Makefile.in
+++ b/debugfs/Makefile.in
@@ -38,15 +38,15 @@ SRCS= debug_cmds.c $(srcdir)/debugfs.c $(srcdir)/util.c $(srcdir)/ls.c \
 	$(srcdir)/../e2fsck/recovery.c $(srcdir)/do_journal.c \
 	$(srcdir)/do_orphan.c
 
-LIBS= $(LIBSUPPORT) $(LIBEXT2FS) $(LIBE2P) $(LIBSS) $(LIBCOM_ERR) $(LIBBLKID) \
+LIBS= $(LIBEXT2FS) $(LIBSUPPORT) $(LIBE2P) $(LIBSS) $(LIBCOM_ERR) $(LIBBLKID) \
 	$(LIBUUID) $(LIBMAGIC) $(SYSLIBS) $(LIBARCHIVE)
-DEPLIBS= $(DEPLIBSUPPORT) $(LIBEXT2FS) $(LIBE2P) $(DEPLIBSS) $(DEPLIBCOM_ERR) \
+DEPLIBS= $(LIBEXT2FS) $(DEPLIBSUPPORT) $(LIBE2P) $(DEPLIBSS) $(DEPLIBCOM_ERR) \
 	$(DEPLIBBLKID) $(DEPLIBUUID)
 
-STATIC_LIBS= $(STATIC_LIBSUPPORT) $(STATIC_LIBEXT2FS) $(STATIC_LIBSS) \
+STATIC_LIBS= $(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) $(STATIC_LIBSS) \
 	$(STATIC_LIBCOM_ERR) $(STATIC_LIBBLKID) $(STATIC_LIBUUID) \
 	$(STATIC_LIBE2P) $(LIBMAGIC) $(SYSLIBS)
-STATIC_DEPLIBS= $(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBSS) \
+STATIC_DEPLIBS= $(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBSUPPORT) $(DEPSTATIC_LIBSS) \
 		$(DEPSTATIC_LIBCOM_ERR) $(DEPSTATIC_LIBUUID) \
 		$(DEPSTATIC_LIBE2P)
 
diff --git a/e2fsck/Makefile.in b/e2fsck/Makefile.in
index 52fad9cbfd2b23..d72244f47e47c0 100644
--- a/e2fsck/Makefile.in
+++ b/e2fsck/Makefile.in
@@ -16,22 +16,22 @@ PROGS=		e2fsck
 MANPAGES=	e2fsck.8
 FMANPAGES=	e2fsck.conf.5
 
-LIBS= $(LIBSUPPORT) $(LIBEXT2FS) $(LIBCOM_ERR) $(LIBBLKID) $(LIBUUID) \
+LIBS= $(LIBEXT2FS) $(LIBSUPPORT) $(LIBCOM_ERR) $(LIBBLKID) $(LIBUUID) \
 	$(LIBINTL) $(LIBE2P) $(LIBMAGIC) $(SYSLIBS)
-DEPLIBS= $(DEPLIBSUPPORT) $(LIBEXT2FS) $(DEPLIBCOM_ERR) $(DEPLIBBLKID) \
+DEPLIBS= $(LIBEXT2FS) $(DEPLIBSUPPORT) $(DEPLIBCOM_ERR) $(DEPLIBBLKID) \
 	 $(DEPLIBUUID) $(DEPLIBE2P)
 
-STATIC_LIBS= $(STATIC_LIBSUPPORT) $(STATIC_LIBEXT2FS) $(STATIC_LIBCOM_ERR) \
+STATIC_LIBS= $(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) $(STATIC_LIBCOM_ERR) \
 	     $(STATIC_LIBBLKID) $(STATIC_LIBUUID) $(LIBINTL) $(STATIC_LIBE2P) \
 	     $(LIBMAGIC) $(SYSLIBS)
-STATIC_DEPLIBS= $(DEPSTATIC_LIBSUPPORT) $(STATIC_LIBEXT2FS) \
+STATIC_DEPLIBS= $(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBSUPPORT) \
 		$(DEPSTATIC_LIBCOM_ERR) $(DEPSTATIC_LIBBLKID) \
 		$(DEPSTATIC_LIBUUID) $(DEPSTATIC_LIBE2P)
 
-PROFILED_LIBS= $(PROFILED_LIBSUPPORT) $(PROFILED_LIBEXT2FS) \
+PROFILED_LIBS= $(PROFILED_LIBEXT2FS) $(PROFILED_LIBSUPPORT) \
 	       $(PROFILED_LIBCOM_ERR) $(PROFILED_LIBBLKID) $(PROFILED_LIBUUID) \
 	       $(PROFILED_LIBE2P) $(LIBINTL) $(LIBMAGIC) $(SYSLIBS)
-PROFILED_DEPLIBS= $(DEPPROFILED_LIBSUPPORT) $(PROFILED_LIBEXT2FS) \
+PROFILED_DEPLIBS= $(PROFILED_LIBEXT2FS) $(DEPPROFILED_LIBSUPPORT) \
 		  $(DEPPROFILED_LIBCOM_ERR) $(DEPPROFILED_LIBBLKID) \
 		  $(DEPPROFILED_LIBUUID) $(DEPPROFILED_LIBE2P)
 
diff --git a/fuse4fs/Makefile.in b/fuse4fs/Makefile.in
index 0a558da23ced81..31afbd8def1de6 100644
--- a/fuse4fs/Makefile.in
+++ b/fuse4fs/Makefile.in
@@ -30,11 +30,11 @@ SRCS=\
 
 LIBS= $(LIBEXT2FS) $(LIBCOM_ERR) $(LIBSUPPORT)
 DEPLIBS= $(LIBEXT2FS) $(DEPLIBCOM_ERR) $(DEPLIBSUPPORT)
-PROFILED_LIBS= $(LIBSUPPORT) $(PROFILED_LIBEXT2FS) $(PROFILED_LIBCOM_ERR)
-PROFILED_DEPLIBS= $(DEPLIBSUPPORT) $(PROFILED_LIBEXT2FS) $(DEPPROFILED_LIBCOM_ERR)
+PROFILED_LIBS= $(PROFILED_LIBEXT2FS) $(PROFILED_LIBSUPPORT) $(PROFILED_LIBCOM_ERR)
+PROFILED_DEPLIBS= $(PROFILED_LIBEXT2FS) $(DEPPROFILED_LIBSUPPORT) $(DEPPROFILED_LIBCOM_ERR)
 
-STATIC_LIBS= $(LIBSUPPORT) $(STATIC_LIBEXT2FS) $(STATIC_LIBCOM_ERR)
-STATIC_DEPLIBS= $(DEPLIBSUPPORT) $(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBCOM_ERR)
+STATIC_LIBS= $(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) $(STATIC_LIBCOM_ERR)
+STATIC_DEPLIBS= $(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBSUPPORT) $(DEPSTATIC_LIBCOM_ERR)
 
 LIBS_E2P= $(LIBE2P) $(LIBCOM_ERR)
 DEPLIBS_E2P= $(LIBE2P) $(DEPLIBCOM_ERR)
diff --git a/lib/ext2fs/Makefile.in b/lib/ext2fs/Makefile.in
index 1d0991defff804..ea8785a26829c2 100644
--- a/lib/ext2fs/Makefile.in
+++ b/lib/ext2fs/Makefile.in
@@ -246,7 +246,7 @@ ELF_SO_VERSION = 2
 ELF_IMAGE = libext2fs
 ELF_MYDIR = ext2fs
 ELF_INSTALL_DIR = $(root_libdir)
-ELF_OTHER_LIBS = -lcom_err
+ELF_OTHER_LIBS = -lcom_err $(top_builddir)/../lib/libsupport.a
 
 BSDLIB_VERSION = 2.1
 BSDLIB_IMAGE = libext2fs
@@ -283,54 +283,54 @@ ext2fs.pc: $(srcdir)/ext2fs.pc.in $(top_builddir)/config.status
 	$(E) "	CONFIG.STATUS $@"
 	$(Q) cd $(top_builddir); CONFIG_FILES=lib/ext2fs/ext2fs.pc ./config.status
 
-tst_badblocks: tst_badblocks.o $(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBCOM_ERR)
+tst_badblocks: tst_badblocks.o $(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) $(DEPSTATIC_LIBCOM_ERR)
 	$(E) "	LD $@"
 	$(Q) $(CC) -o tst_badblocks tst_badblocks.o $(ALL_LDFLAGS) \
-		$(STATIC_LIBEXT2FS) $(STATIC_LIBCOM_ERR) $(SYSLIBS)
+		$(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) $(STATIC_LIBCOM_ERR) $(SYSLIBS)
 
 tst_digest_encode: $(srcdir)/digest_encode.c $(srcdir)/ext2_fs.h
 	$(E) "	CC $@"
 	$(Q) $(CC) $(ALL_LDFLAGS) $(ALL_CFLAGS) -o tst_digest_encode \
 		$(srcdir)/digest_encode.c -DUNITTEST $(SYSLIBS)
 
-tst_icount: $(srcdir)/icount.c $(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBCOM_ERR)
+tst_icount: $(srcdir)/icount.c $(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) $(DEPSTATIC_LIBCOM_ERR)
 	$(E) "	LD $@"
 	$(Q) $(CC) -o tst_icount $(srcdir)/icount.c -DDEBUG \
 		$(ALL_CFLAGS) $(ALL_LDFLAGS) \
-		$(STATIC_LIBEXT2FS) $(STATIC_LIBCOM_ERR) $(SYSLIBS)
+		$(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) $(STATIC_LIBCOM_ERR) $(SYSLIBS)
 
-tst_iscan: tst_iscan.o $(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBCOM_ERR)
+tst_iscan: tst_iscan.o $(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) $(DEPSTATIC_LIBCOM_ERR)
 	$(E) "	LD $@"
 	$(Q) $(CC) -o tst_iscan tst_iscan.o $(ALL_LDFLAGS) \
-		$(STATIC_LIBEXT2FS) $(STATIC_LIBCOM_ERR) $(SYSLIBS)
+		$(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) $(STATIC_LIBCOM_ERR) $(SYSLIBS)
 
-tst_getsize: tst_getsize.o $(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBCOM_ERR)
+tst_getsize: tst_getsize.o $(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) $(DEPSTATIC_LIBCOM_ERR)
 	$(E) "	LD $@"
 	$(Q) $(CC) -o tst_getsize tst_getsize.o $(ALL_LDFLAGS) \
-		$(STATIC_LIBEXT2FS) $(STATIC_LIBCOM_ERR) $(SYSLIBS)
+		$(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) $(STATIC_LIBCOM_ERR) $(SYSLIBS)
 
-tst_ismounted: $(srcdir)/ismounted.c $(STATIC_LIBEXT2FS) \
+tst_ismounted: $(srcdir)/ismounted.c $(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) \
 		$(DEPSTATIC_LIBCOM_ERR)
 	$(E) "	LD $@"
 	$(Q) $(CC) -o tst_ismounted $(srcdir)/ismounted.c \
-		$(STATIC_LIBEXT2FS) -DDEBUG $(ALL_CFLAGS) $(ALL_LDFLAGS) \
+		$(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) -DDEBUG $(ALL_CFLAGS) $(ALL_LDFLAGS) \
 		$(STATIC_LIBCOM_ERR) $(SYSLIBS)
 
-tst_byteswap: tst_byteswap.o $(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBCOM_ERR)
+tst_byteswap: tst_byteswap.o $(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) $(DEPSTATIC_LIBCOM_ERR)
 	$(E) "	LD $@"
 	$(Q) $(CC) -o tst_byteswap tst_byteswap.o $(ALL_LDFLAGS) \
-		$(STATIC_LIBEXT2FS) $(STATIC_LIBCOM_ERR) $(SYSLIBS)
+		$(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) $(STATIC_LIBCOM_ERR) $(SYSLIBS)
 
-tst_bitops: tst_bitops.o $(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBCOM_ERR)
+tst_bitops: tst_bitops.o $(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) $(DEPSTATIC_LIBCOM_ERR)
 	$(E) "	LD $@"
 	$(Q) $(CC) -o tst_bitops tst_bitops.o $(ALL_CFLAGS) $(ALL_LDFLAGS) \
-		$(STATIC_LIBEXT2FS) $(STATIC_LIBCOM_ERR) $(SYSLIBS)
+		$(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) $(STATIC_LIBCOM_ERR) $(SYSLIBS)
 
-tst_getsectsize: tst_getsectsize.o getsectsize.o $(STATIC_LIBEXT2FS) \
+tst_getsectsize: tst_getsectsize.o getsectsize.o $(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) \
 			$(DEPSTATIC_LIBCOM_ERR)
 	$(E) "	LD $@"
 	$(Q) $(CC) -o tst_getsectsize tst_getsectsize.o getsectsize.o \
-		$(ALL_LDFLAGS) $(STATIC_LIBEXT2FS) $(STATIC_LIBCOM_ERR) \
+		$(ALL_LDFLAGS) $(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) $(STATIC_LIBCOM_ERR) \
 		$(SYSLIBS)
 
 tst_types.o: $(srcdir)/tst_types.c ext2_types.h 
@@ -490,11 +490,11 @@ tst_bitmaps_cmd.c: tst_bitmaps_cmd.ct
 	$(Q) DIR=$(srcdir) $(MK_CMDS) $(srcdir)/tst_bitmaps_cmd.ct
 
 tst_bitmaps: tst_bitmaps.o tst_bitmaps_cmd.o $(srcdir)/blkmap64_rb.c \
-		$(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBSS) $(DEPSTATIC_LIBCOM_ERR)
+		$(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) $(DEPSTATIC_LIBSS) $(DEPSTATIC_LIBCOM_ERR)
 	$(E) "	LD $@"
 	$(Q) $(CC) -o $@ tst_bitmaps.o tst_bitmaps_cmd.o \
 		-DDEBUG_RB $(srcdir)/blkmap64_rb.c $(ALL_CFLAGS) \
-		$(ALL_LDFLAGS) $(STATIC_LIBEXT2FS) $(STATIC_LIBSS) \
+		$(ALL_LDFLAGS) $(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) $(STATIC_LIBSS) \
 		$(STATIC_LIBCOM_ERR) $(SYSLIBS)
 
 tst_extents: $(srcdir)/extent.c $(DEBUG_OBJS) $(DEPSTATIC_LIBSS) libext2fs.a \
@@ -503,8 +503,8 @@ tst_extents: $(srcdir)/extent.c $(DEBUG_OBJS) $(DEPSTATIC_LIBSS) libext2fs.a \
 	$(E) "	LD $@"
 	$(Q) $(CC) -o tst_extents $(srcdir)/extent.c \
 		$(ALL_CFLAGS) $(ALL_LDFLAGS) -DDEBUG $(DEBUG_OBJS) \
-		$(STATIC_LIBSS) $(STATIC_LIBE2P) $(LIBSUPPORT) \
-		$(STATIC_LIBEXT2FS) $(LIBBLKID) $(LIBUUID) \
+		$(STATIC_LIBSS) $(STATIC_LIBE2P) \
+		$(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) $(LIBSUPPORT) $(LIBBLKID) $(LIBUUID) \
 		$(STATIC_LIBCOM_ERR) $(SYSLIBS) -I $(top_srcdir)/debugfs
 
 tst_libext2fs: $(DEBUG_OBJS) \
@@ -512,38 +512,38 @@ tst_libext2fs: $(DEBUG_OBJS) \
 	$(DEPLIBBLKID) $(DEPSTATIC_LIBCOM_ERR) $(DEPLIBSUPPORT)
 	$(E) "	LD $@"
 	$(Q) $(CC) -o tst_libext2fs $(ALL_LDFLAGS) -DDEBUG $(DEBUG_OBJS) \
-		$(STATIC_LIBSS) $(STATIC_LIBE2P) $(LIBSUPPORT) \
-		$(STATIC_LIBEXT2FS) $(LIBBLKID) $(LIBUUID) $(LIBMAGIC) \
+		$(STATIC_LIBSS) $(STATIC_LIBE2P) $(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) \
+		$(LIBSUPPORT) $(LIBBLKID) $(LIBUUID) $(LIBMAGIC) \
 		$(STATIC_LIBCOM_ERR) $(SYSLIBS) $(LIBARCHIVE) -I $(top_srcdir)/debugfs
 
-tst_inline: $(srcdir)/inline.c $(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBCOM_ERR)
+tst_inline: $(srcdir)/inline.c $(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) $(DEPSTATIC_LIBCOM_ERR)
 	$(E) "	LD $@"
 	$(Q) $(CC) -o tst_inline $(srcdir)/inline.c $(ALL_CFLAGS) \
-		$(ALL_LDFLAGS) -DDEBUG $(STATIC_LIBEXT2FS) \
+		$(ALL_LDFLAGS) -DDEBUG $(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) \
 		$(STATIC_LIBCOM_ERR) $(SYSLIBS)
 
-tst_inline_data: inline_data.c $(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBCOM_ERR)
+tst_inline_data: inline_data.c $(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) $(DEPSTATIC_LIBCOM_ERR)
 	$(E) "	LD $@"
 	$(Q) $(CC) -o tst_inline_data $(srcdir)/inline_data.c $(ALL_CFLAGS) \
-		$(ALL_LDFLAGS) -DDEBUG $(STATIC_LIBEXT2FS) \
+		$(ALL_LDFLAGS) -DDEBUG $(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) \
 		$(STATIC_LIBCOM_ERR) $(SYSLIBS)
 
-tst_csum: csum.c $(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBCOM_ERR) $(STATIC_LIBE2P) \
+tst_csum: csum.c $(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) $(DEPSTATIC_LIBCOM_ERR) $(STATIC_LIBE2P) \
 		$(top_srcdir)/lib/e2p/e2p.h
 	$(E) "	LD $@"
 	$(Q) $(CC) -o tst_csum $(srcdir)/csum.c -DDEBUG \
-		$(ALL_CFLAGS) $(ALL_LDFLAGS) $(STATIC_LIBEXT2FS) \
+		$(ALL_CFLAGS) $(ALL_LDFLAGS) $(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) \
 		$(STATIC_LIBCOM_ERR) $(STATIC_LIBE2P) $(SYSLIBS)
 
-tst_crc32c: $(srcdir)/crc32c.c $(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBCOM_ERR)
+tst_crc32c: $(srcdir)/crc32c.c $(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) $(DEPSTATIC_LIBCOM_ERR)
 	$(Q) $(CC) $(ALL_LDFLAGS) $(ALL_CFLAGS) -o tst_crc32c $(srcdir)/crc32c.c \
-		-DUNITTEST $(STATIC_LIBEXT2FS) $(STATIC_LIBCOM_ERR) \
+		-DUNITTEST $(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) $(STATIC_LIBCOM_ERR) \
 		$(SYSLIBS)
 
-mkjournal: mkjournal.c $(STATIC_LIBEXT2FS) $(DEPLIBCOM_ERR)
+mkjournal: mkjournal.c $(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) $(DEPLIBCOM_ERR)
 	$(E) "	LD $@"
 	$(Q) $(CC) -o mkjournal $(srcdir)/mkjournal.c -DDEBUG \
-		$(STATIC_LIBEXT2FS) $(LIBCOM_ERR) $(ALL_CFLAGS) $(SYSLIBS)
+		$(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) $(LIBCOM_ERR) $(ALL_CFLAGS) $(SYSLIBS)
 
 fullcheck check:: tst_bitops tst_badblocks tst_iscan tst_types tst_icount \
     tst_super_size tst_types tst_inode_size tst_csum tst_crc32c tst_bitmaps \
@@ -976,7 +976,9 @@ inode.o: $(srcdir)/inode.c $(top_builddir)/lib/config.h \
  $(srcdir)/ext2fs.h $(srcdir)/ext2_fs.h $(srcdir)/ext3_extents.h \
  $(top_srcdir)/lib/et/com_err.h $(srcdir)/ext2_io.h \
  $(top_builddir)/lib/ext2fs/ext2_err.h $(srcdir)/ext2_ext_attr.h \
- $(srcdir)/hashmap.h $(srcdir)/bitops.h $(srcdir)/e2image.h
+ $(srcdir)/hashmap.h $(srcdir)/bitops.h $(srcdir)/e2image.h \
+ $(srcdir)/../support/cache.h $(srcdir)/../support/list.h \
+ $(srcdir)/../support/xbitops.h 
 inode_io.o: $(srcdir)/inode_io.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(srcdir)/ext2fs.h \
diff --git a/lib/ext2fs/inline_data.c b/lib/ext2fs/inline_data.c
index bd52e37708ccad..8ff4a23397f499 100644
--- a/lib/ext2fs/inline_data.c
+++ b/lib/ext2fs/inline_data.c
@@ -817,10 +817,6 @@ int main(int argc, char *argv[])
 				"tst_inline_data: init inode cache failed\n");
 			exit(1);
 		}
-
-		/* setup inode cache */
-		for (i = 0; i < fs->icache->cache_size; i++)
-			fs->icache->cache[i].ino = first_ino++;
 	}
 
 	/* test */
diff --git a/lib/ext2fs/inode.c b/lib/ext2fs/inode.c
index c9389a2324be07..8ca82af1ab35d3 100644
--- a/lib/ext2fs/inode.c
+++ b/lib/ext2fs/inode.c
@@ -59,18 +59,145 @@ struct ext2_struct_inode_scan {
 	int			reserved[6];
 };
 
+struct ext2_inode_cache_key {
+	ext2_filsys		fs;
+	ext2_ino_t		ino;
+};
+
+#define ICKEY(key)	((struct ext2_inode_cache_key *)(key))
+#define ICNODE(node)	(container_of((node), struct ext2_inode_cache_ent, node))
+
+static unsigned int
+ext2_inode_cache_hash(cache_key_t key, unsigned int hashsize,
+		      unsigned int hashshift)
+{
+	uint64_t	hashval = ICKEY(key)->ino;
+	uint64_t	tmp;
+
+	tmp = hashval ^ (GOLDEN_RATIO_PRIME + hashval) / CACHE_LINE_SIZE;
+	tmp = tmp ^ ((tmp ^ GOLDEN_RATIO_PRIME) >> hashshift);
+	return tmp % hashsize;
+}
+
+static int ext2_inode_cache_compare(struct cache_node *node, cache_key_t key)
+{
+	struct ext2_inode_cache_ent *ent = ICNODE(node);
+	struct ext2_inode_cache_key *ikey = ICKEY(key);
+
+	if (ent->ino == ikey->ino)
+		return CACHE_HIT;
+
+	return CACHE_MISS;
+}
+
+static struct cache_node *ext2_inode_cache_alloc(struct cache *c,
+						 cache_key_t key)
+{
+	struct ext2_inode_cache_key *ikey = ICKEY(key);
+	struct ext2_inode_cache_ent *ent;
+
+	ent = calloc(1, sizeof(struct ext2_inode_cache_ent) +
+			EXT2_INODE_SIZE(ikey->fs->super));
+	if (!ent)
+		return NULL;
+
+	ent->ino = ikey->ino;
+	return &ent->node;
+}
+
+static bool ext2_inode_cache_flush(struct cache *c, struct cache_node *node)
+{
+	/* can always drop inode cache */
+	return 0;
+}
+
+static void ext2_inode_cache_relse(struct cache *c, struct cache_node *node)
+{
+	struct ext2_inode_cache_ent *ent = ICNODE(node);
+
+	free(ent);
+}
+
+static unsigned int ext2_inode_cache_bulkrelse(struct cache *cache,
+					       struct list_head *list)
+{
+	struct cache_node *cn, *n;
+	int count = 0;
+
+	if (list_empty(list))
+		return 0;
+
+	list_for_each_entry_safe(cn, n, list, cn_mru) {
+		ext2_inode_cache_relse(cache, cn);
+		count++;
+	}
+
+	return count;
+}
+
+static const struct cache_operations ext2_inode_cache_ops = {
+	.hash		= ext2_inode_cache_hash,
+	.alloc		= ext2_inode_cache_alloc,
+	.flush		= ext2_inode_cache_flush,
+	.relse		= ext2_inode_cache_relse,
+	.compare	= ext2_inode_cache_compare,
+	.bulkrelse	= ext2_inode_cache_bulkrelse,
+	.resize		= cache_gradual_resize,
+};
+
+static errcode_t ext2_inode_cache_iget(ext2_filsys fs, ext2_ino_t ino,
+				       unsigned int getflags,
+				       struct ext2_inode_cache_ent **entp)
+{
+	struct ext2_inode_cache_key ikey = {
+		.fs = fs,
+		.ino = ino,
+	};
+	struct cache_node *node = NULL;
+
+	cache_node_get(&fs->icache->cache, &ikey, getflags, &node);
+	if (!node)
+		return ENOMEM;
+
+	*entp = ICNODE(node);
+	return 0;
+}
+
+static void ext2_inode_cache_iput(ext2_filsys fs,
+				  struct ext2_inode_cache_ent *ent)
+{
+	cache_node_put(&fs->icache->cache, &ent->node);
+}
+
+static int ext2_inode_cache_ipurge(ext2_filsys fs, ext2_ino_t ino,
+				   struct ext2_inode_cache_ent *ent)
+{
+	struct ext2_inode_cache_key ikey = {
+		.fs = fs,
+		.ino = ino,
+	};
+
+	return cache_node_purge(&fs->icache->cache, &ikey, &ent->node);
+}
+
+static void ext2_inode_cache_ibump(ext2_filsys fs,
+				   struct ext2_inode_cache_ent *ent)
+{
+	if (++ent->access > 50) {
+		cache_node_bump_priority(&fs->icache->cache, &ent->node);
+		ent->access = 0;
+	}
+}
+
 /*
  * This routine flushes the icache, if it exists.
  */
 errcode_t ext2fs_flush_icache(ext2_filsys fs)
 {
-	unsigned	i;
-
 	if (!fs->icache)
 		return 0;
 
-	for (i=0; i < fs->icache->cache_size; i++)
-		fs->icache->cache[i].ino = 0;
+	cache_purge(&fs->icache->cache);
 
 	fs->icache->buffer_blk = 0;
 	return 0;
@@ -81,23 +208,20 @@ errcode_t ext2fs_flush_icache(ext2_filsys fs)
  */
 void ext2fs_free_inode_cache(struct ext2_inode_cache *icache)
 {
-	unsigned i;
-
 	if (--icache->refcount)
 		return;
 	if (icache->buffer)
 		ext2fs_free_mem(&icache->buffer);
-	for (i = 0; i < icache->cache_size; i++)
-		ext2fs_free_mem(&icache->cache[i].inode);
-	if (icache->cache)
-		ext2fs_free_mem(&icache->cache);
+	if (cache_initialized(&icache->cache)) {
+		cache_purge(&icache->cache);
+		cache_destroy(&icache->cache);
+	}
 	icache->buffer_blk = 0;
 	ext2fs_free_mem(&icache);
 }
 
 errcode_t ext2fs_create_inode_cache(ext2_filsys fs, unsigned int cache_size)
 {
-	unsigned	i;
 	errcode_t	retval;
 
 	if (fs->icache)
@@ -112,22 +236,12 @@ errcode_t ext2fs_create_inode_cache(ext2_filsys fs, unsigned int cache_size)
 		goto errout;
 
 	fs->icache->buffer_blk = 0;
-	fs->icache->cache_last = -1;
-	fs->icache->cache_size = cache_size;
 	fs->icache->refcount = 1;
-	retval = ext2fs_get_array(fs->icache->cache_size,
-				  sizeof(struct ext2_inode_cache_ent),
-				  &fs->icache->cache);
+	retval = cache_init(0, cache_size, &ext2_inode_cache_ops,
+			    &fs->icache->cache);
 	if (retval)
 		goto errout;
 
-	for (i = 0; i < fs->icache->cache_size; i++) {
-		retval = ext2fs_get_mem(EXT2_INODE_SIZE(fs->super),
-					&fs->icache->cache[i].inode);
-		if (retval)
-			goto errout;
-	}
-
 	ext2fs_flush_icache(fs);
 	return 0;
 errout:
@@ -762,12 +876,12 @@ errcode_t ext2fs_read_inode2(ext2_filsys fs, ext2_ino_t ino,
 	unsigned long 	block, offset;
 	char 		*ptr;
 	errcode_t	retval;
-	unsigned	i;
 	int		clen, inodes_per_block;
 	io_channel	io;
 	int		length = EXT2_INODE_SIZE(fs->super);
 	struct ext2_inode_large	*iptr;
-	int		cache_slot, fail_csum;
+	struct ext2_inode_cache_ent *ent = NULL;
+	int		fail_csum;
 
 	EXT2_CHECK_MAGIC(fs, EXT2_ET_MAGIC_EXT2FS_FILSYS);
 
@@ -794,12 +908,12 @@ errcode_t ext2fs_read_inode2(ext2_filsys fs, ext2_ino_t ino,
 			return retval;
 	}
 	/* Check to see if it's in the inode cache */
-	for (i = 0; i < fs->icache->cache_size; i++) {
-		if (fs->icache->cache[i].ino == ino) {
-			memcpy(inode, fs->icache->cache[i].inode,
-			       (bufsize > length) ? length : bufsize);
-			return 0;
-		}
+	ext2_inode_cache_iget(fs, ino, CACHE_GET_INCORE, &ent);
+	if (ent) {
+		memcpy(inode, ent->raw, (bufsize > length) ? length : bufsize);
+		ext2_inode_cache_ibump(fs, ent);
+		ext2_inode_cache_iput(fs, ent);
+		return 0;
 	}
 	if (fs->flags & EXT2_FLAG_IMAGE_FILE) {
 		inodes_per_block = fs->blocksize / EXT2_INODE_SIZE(fs->super);
@@ -827,8 +941,10 @@ errcode_t ext2fs_read_inode2(ext2_filsys fs, ext2_ino_t ino,
 	}
 	offset &= (EXT2_BLOCK_SIZE(fs->super) - 1);
 
-	cache_slot = (fs->icache->cache_last + 1) % fs->icache->cache_size;
-	iptr = (struct ext2_inode_large *)fs->icache->cache[cache_slot].inode;
+	retval = ext2_inode_cache_iget(fs, ino, 0, &ent);
+	if (retval)
+		return retval;
+	iptr = (struct ext2_inode_large *)ent->raw;
 
 	ptr = (char *) iptr;
 	while (length) {
@@ -863,13 +979,15 @@ errcode_t ext2fs_read_inode2(ext2_filsys fs, ext2_ino_t ino,
 			       0, length);
 #endif
 
-	/* Update the inode cache bookkeeping */
-	if (!fail_csum) {
-		fs->icache->cache_last = cache_slot;
-		fs->icache->cache[cache_slot].ino = ino;
-	}
 	memcpy(inode, iptr, (bufsize > length) ? length : bufsize);
 
+	/* Update the inode cache bookkeeping */
+	if (!fail_csum)
+		ext2_inode_cache_ibump(fs, ent);
+	ext2_inode_cache_iput(fs, ent);
+	if (fail_csum)
+		ext2_inode_cache_ipurge(fs, ino, ent);
+
 	if (!(fs->flags & EXT2_FLAG_IGNORE_CSUM_ERRORS) &&
 	    !(flags & READ_INODE_NOCSUM) && fail_csum)
 		return EXT2_ET_INODE_CSUM_INVALID;
@@ -899,8 +1017,8 @@ errcode_t ext2fs_write_inode2(ext2_filsys fs, ext2_ino_t ino,
 	unsigned long block, offset;
 	errcode_t retval = 0;
 	struct ext2_inode_large *w_inode;
+	struct ext2_inode_cache_ent *ent;
 	char *ptr;
-	unsigned i;
 	int clen;
 	int length = EXT2_INODE_SIZE(fs->super);
 
@@ -933,19 +1051,20 @@ errcode_t ext2fs_write_inode2(ext2_filsys fs, ext2_ino_t ino,
 	}
 
 	/* Check to see if the inode cache needs to be updated */
-	if (fs->icache) {
-		for (i=0; i < fs->icache->cache_size; i++) {
-			if (fs->icache->cache[i].ino == ino) {
-				memcpy(fs->icache->cache[i].inode, inode,
-				       (bufsize > length) ? length : bufsize);
-				break;
-			}
-		}
-	} else {
+	if (!fs->icache) {
 		retval = ext2fs_create_inode_cache(fs, 4);
 		if (retval)
 			goto errout;
 	}
+
+	retval = ext2_inode_cache_iget(fs, ino, 0, &ent);
+	if (retval)
+		goto errout;
+
+	memcpy(ent->raw, inode, (bufsize > length) ? length : bufsize);
+	ext2_inode_cache_ibump(fs, ent);
+	ext2_inode_cache_iput(fs, ent);
+
 	memcpy(w_inode, inode, (bufsize > length) ? length : bufsize);
 
 	if (!(fs->flags & EXT2_FLAG_RW)) {
diff --git a/misc/Makefile.in b/misc/Makefile.in
index 8a3adc70fb736e..5b19cdc96bf4f7 100644
--- a/misc/Makefile.in
+++ b/misc/Makefile.in
@@ -115,11 +115,11 @@ SRCS=	$(srcdir)/tune2fs.c $(srcdir)/mklost+found.c $(srcdir)/mke2fs.c $(srcdir)/
 
 LIBS= $(LIBEXT2FS) $(LIBCOM_ERR) $(LIBSUPPORT)
 DEPLIBS= $(LIBEXT2FS) $(DEPLIBCOM_ERR) $(DEPLIBSUPPORT)
-PROFILED_LIBS= $(LIBSUPPORT) $(PROFILED_LIBEXT2FS) $(PROFILED_LIBCOM_ERR)
-PROFILED_DEPLIBS= $(DEPLIBSUPPORT) $(PROFILED_LIBEXT2FS) $(DEPPROFILED_LIBCOM_ERR)
+PROFILED_LIBS= $(PROFILED_LIBEXT2FS) $(PROFILED_LIBSUPPORT) $(PROFILED_LIBCOM_ERR)
+PROFILED_DEPLIBS= $(PROFILED_LIBEXT2FS) $(DEPPROFILED_LIBSUPPORT) $(DEPPROFILED_LIBCOM_ERR)
 
-STATIC_LIBS= $(LIBSUPPORT) $(STATIC_LIBEXT2FS) $(STATIC_LIBCOM_ERR)
-STATIC_DEPLIBS= $(DEPLIBSUPPORT) $(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBCOM_ERR)
+STATIC_LIBS= $(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) $(STATIC_LIBCOM_ERR)
+STATIC_DEPLIBS= $(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBSUPPORT) $(DEPSTATIC_LIBCOM_ERR)
 
 LIBS_E2P= $(LIBE2P) $(LIBCOM_ERR)
 DEPLIBS_E2P= $(LIBE2P) $(DEPLIBCOM_ERR)
diff --git a/resize/Makefile.in b/resize/Makefile.in
index 27f721305e052e..101cdbeaa9f1ef 100644
--- a/resize/Makefile.in
+++ b/resize/Makefile.in
@@ -28,12 +28,13 @@ SRCS= $(srcdir)/extent.c \
 	$(srcdir)/resource_track.c \
 	$(srcdir)/sim_progress.c
 
-LIBS= $(LIBE2P) $(LIBEXT2FS) $(LIBCOM_ERR) $(LIBINTL) $(SYSLIBS)
-DEPLIBS= $(LIBE2P) $(LIBEXT2FS) $(DEPLIBCOM_ERR)
+LIBS= $(LIBE2P) $(LIBEXT2FS) $(LIBSUPPORT) $(LIBCOM_ERR) $(LIBINTL) $(SYSLIBS)
+DEPLIBS= $(LIBE2P) $(LIBEXT2FS) $(DEPLIBSUPPORT) $(DEPLIBCOM_ERR)
 
-STATIC_LIBS= $(STATIC_LIBE2P) $(STATIC_LIBEXT2FS) $(STATIC_LIBCOM_ERR) \
-	$(LIBINTL) $(SYSLIBS)
-DEPSTATIC_LIBS= $(STATIC_LIBE2P) $(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBCOM_ERR) 
+STATIC_LIBS= $(STATIC_LIBE2P) $(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) \
+	     $(STATIC_LIBCOM_ERR) $(LIBINTL) $(SYSLIBS)
+DEPSTATIC_LIBS= $(STATIC_LIBE2P) $(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBSUPPORT) \
+		$(DEPSTATIC_LIBCOM_ERR)
 
 .c.o:
 	$(E) "	CC $<"
diff --git a/tests/fuzz/Makefile.in b/tests/fuzz/Makefile.in
index 949579e7c6501f..2b959f612e2079 100644
--- a/tests/fuzz/Makefile.in
+++ b/tests/fuzz/Makefile.in
@@ -24,9 +24,9 @@ LOCAL_LDFLAGS= @fuzzer_ldflags@
 LIBS= $(LIBEXT2FS) $(LIBCOM_ERR) $(LIBSUPPORT)
 DEPLIBS= $(LIBEXT2FS) $(DEPLIBCOM_ERR) $(DEPLIBSUPPORT)
 
-STATIC_LIBS= $(LIBSUPPORT) $(STATIC_LIBE2P) $(STATIC_LIBEXT2FS) \
+STATIC_LIBS= $(STATIC_LIBE2P) $(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) \
 	$(STATIC_LIBCOM_ERR)
-STATIC_DEPLIBS= $(DEPLIBSUPPORT) $(STATIC_LIBE2P) $(STATIC_LIBEXT2FS) \
+STATIC_DEPLIBS= $(STATIC_LIBE2P) $(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBSUPPORT) \
 	$(DEPSTATIC_LIBCOM_ERR)
 
 FUZZ_LDFLAGS= $(ALL_LDFLAGS)
diff --git a/tests/progs/Makefile.in b/tests/progs/Makefile.in
index 1a8e9299a1c1ca..64069a52c57cd3 100644
--- a/tests/progs/Makefile.in
+++ b/tests/progs/Makefile.in
@@ -23,8 +23,8 @@ TEST_ICOUNT_OBJS=	test_icount.o test_icount_cmds.o
 SRCS=	$(srcdir)/test_icount.c \
 	$(srcdir)/test_rel.c
 
-LIBS= $(LIBEXT2FS) $(LIBSS) $(LIBCOM_ERR) $(SYSLIBS)
-DEPLIBS= $(LIBEXT2FS) $(DEPLIBSS) $(DEPLIBCOM_ERR)
+LIBS= $(LIBEXT2FS) $(LIBSUPPORT) $(LIBSS) $(LIBCOM_ERR) $(SYSLIBS)
+DEPLIBS= $(LIBEXT2FS) $(DEPLIBSUPPORT) $(DEPLIBSS) $(DEPLIBCOM_ERR)
 
 .c.o:
 	$(E) "	CC $<"


