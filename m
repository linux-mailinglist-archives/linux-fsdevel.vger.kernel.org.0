Return-Path: <linux-fsdevel+bounces-78195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MH5xIbbnnGmNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:50:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 311B618004B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8919E316C833
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9CE37FF7F;
	Mon, 23 Feb 2026 23:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mM4YqR7N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C929134CFBA;
	Mon, 23 Feb 2026 23:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890421; cv=none; b=SqnJv45SJvlr7jRWoVqODxSN2vmXTjTDe7BBg/1QNHFRdu2Vu4JWSxI/pbypwCUIQvVvokF7LnG7medjEZWZ0KM/3BJvr812VmcmERHTRJYi/zRJnJaxVl+Mdh84jW0BvZf6mXvlbjZtFIQSPJgXJ7IZ9KycbsBoHGLAibgJ2ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890421; c=relaxed/simple;
	bh=uA5AhlhpR3qsbrlG+Exo723wgoz2qpGl0I9OGgEgd1E=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e05e1/vHaFZxYyAzmTkfi0HMGT+P/XTM918tLYdPELB4GaYzgkxIFjD9YHPEKrFFrHFwF7dkR8a6CFL4Otl/JFxAThXvYfyqeIxQejYMdhKEAtldE6wCAbP4epdtGnJLDtf5uAEf0MO6Nwo/U9pPOb2bdhTVk5KI/KYnMYUtwvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mM4YqR7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E8FC116C6;
	Mon, 23 Feb 2026 23:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890421;
	bh=uA5AhlhpR3qsbrlG+Exo723wgoz2qpGl0I9OGgEgd1E=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=mM4YqR7NP0rOQROX76TdF7XckIKzAG2oTuznwShNHdWQuIqyQ/fDdVRfqXK4qGDj9
	 ++u6714FCo3UZtHQI4ez3KrI2yhWqQJl+AelzHuMo3Jpy0Bl/UFmCBOkVNyC+I7v5K
	 vLU4NL9ct9+/u/CleF/yUCvj4TF+QWwy8YMhf9U4HaQNVaVsl1KeEXWHwmSqD7Q5+Q
	 CENu5HlkzlGH3VkjUN5/ZpMfC06fXxfDcWELtGfqxDOqysgI7bg3PIxBdXa1CILWUp
	 LCy8gXyQxlSAf0Jtq35OxEUwRUQre7r0VTvqcDYKz4PvPQNEFF/gTGsDfG0WiicgK9
	 CpsEk9Oi5hM3Q==
Date: Mon, 23 Feb 2026 15:47:01 -0800
Subject: [PATCH 3/8] fuse4fs: set proc title when in fuse service mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188746011.3944907.10470919790477719177.stgit@frogsfrogsfrogs>
In-Reply-To: <177188745924.3944907.12406087337118974135.stgit@frogsfrogsfrogs>
References: <177188745924.3944907.12406087337118974135.stgit@frogsfrogsfrogs>
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
	TAGGED_FROM(0.00)[bounces-78195-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,configure.ac:url]
X-Rspamd-Queue-Id: 311B618004B
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

When in fuse service mode, set the process title so that we can identify
fuse servers by mount arguments.  When the service ends, amend the title
again to say that we're cleaning up.  This is done to make ps aux a bit
more communicative as to what is going on.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 configure           |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++
 configure.ac        |    9 ++++++++
 fuse4fs/Makefile.in |    2 +-
 fuse4fs/fuse4fs.c   |   28 +++++++++++++++++++++++++-
 lib/config.h.in     |    3 +++
 5 files changed, 95 insertions(+), 2 deletions(-)


diff --git a/configure b/configure
index 15e9fd92eaf6e7..44bd0e73a74279 100755
--- a/configure
+++ b/configure
@@ -695,6 +695,7 @@ gcc_ranlib
 gcc_ar
 UNI_DIFF_OPTS
 SEM_INIT_LIB
+LIBBSD_LIB
 FUSE4FS_CMT
 FUSE2FS_CMT
 fuse_service_socket_dir
@@ -15061,6 +15062,60 @@ printf "%s\n" "#define HAVE_FUSE_CACHE_READDIR 1" >>confdefs.h
 
 fi
 
+{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for setproctitle in -lbsd" >&5
+printf %s "checking for setproctitle in -lbsd... " >&6; }
+if test ${ac_cv_lib_bsd_setproctitle+y}
+then :
+  printf %s "(cached) " >&6
+else case e in #(
+  e) ac_check_lib_save_LIBS=$LIBS
+LIBS="-lbsd  $LIBS"
+cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+
+/* Override any GCC internal prototype to avoid an error.
+   Use char because int might match the return type of a GCC
+   builtin and then its argument prototype would still apply.
+   The 'extern "C"' is for builds by C++ compilers;
+   although this is not generally supported in C code supporting it here
+   has little cost and some practical benefit (sr 110532).  */
+#ifdef __cplusplus
+extern "C"
+#endif
+char setproctitle (void);
+int
+main (void)
+{
+return setproctitle ();
+  ;
+  return 0;
+}
+_ACEOF
+if ac_fn_c_try_link "$LINENO"
+then :
+  ac_cv_lib_bsd_setproctitle=yes
+else case e in #(
+  e) ac_cv_lib_bsd_setproctitle=no ;;
+esac
+fi
+rm -f core conftest.err conftest.$ac_objext conftest.beam \
+    conftest$ac_exeext conftest.$ac_ext
+LIBS=$ac_check_lib_save_LIBS ;;
+esac
+fi
+{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: $ac_cv_lib_bsd_setproctitle" >&5
+printf "%s\n" "$ac_cv_lib_bsd_setproctitle" >&6; }
+if test "x$ac_cv_lib_bsd_setproctitle" = xyes
+then :
+  LIBBSD_LIB=-lbsd
+fi
+
+
+if test "$ac_cv_lib_bsd_setproctitle" = yes ; then
+	printf "%s\n" "#define HAVE_SETPROCTITLE 1" >>confdefs.h
+
+fi
+
 { printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for PR_SET_IO_FLUSHER" >&5
 printf %s "checking for PR_SET_IO_FLUSHER... " >&6; }
 cat confdefs.h - <<_ACEOF >conftest.$ac_ext
diff --git a/configure.ac b/configure.ac
index 8aa25ca7585f32..a3162a64123d20 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1625,6 +1625,15 @@ then
 		  [Define to 1 if fuse supports cache_readdir])
 fi
 
+dnl
+dnl see if setproctitle exists
+dnl
+AC_CHECK_LIB(bsd, setproctitle, [LIBBSD_LIB=-lbsd])
+AC_SUBST(LIBBSD_LIB)
+if test "$ac_cv_lib_bsd_setproctitle" = yes ; then
+	AC_DEFINE(HAVE_SETPROCTITLE, 1, Define to 1 if setproctitle])
+fi
+
 dnl
 dnl see if PR_SET_IO_FLUSHER exists
 dnl
diff --git a/fuse4fs/Makefile.in b/fuse4fs/Makefile.in
index 119fb1f37ad1ae..f6473ad0027e51 100644
--- a/fuse4fs/Makefile.in
+++ b/fuse4fs/Makefile.in
@@ -76,7 +76,7 @@ fuse4fs: $(FUSE4FS_OBJS) $(DEPLIBS) $(DEPLIBBLKID) $(DEPLIBUUID) \
 	$(E) "	LD $@"
 	$(Q) $(CC) $(ALL_LDFLAGS) -o fuse4fs $(FUSE4FS_OBJS) $(LIBS) \
 		$(LIBFUSE) $(LIBBLKID) $(LIBUUID) $(LIBEXT2FS) $(LIBINTL) \
-		$(CLOCK_GETTIME_LIB) $(SYSLIBS) $(LIBS_E2P)
+		$(CLOCK_GETTIME_LIB) $(SYSLIBS) $(LIBS_E2P) @LIBBSD_LIB@
 
 %.socket: %.socket.in $(DEP_SUBSTITUTE)
 	$(E) "	SUBST $@"
diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index acb6402a174ad3..522afde7c9356b 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -49,6 +49,9 @@
 #ifdef HAVE_FUSE_SERVICE
 # include <sys/mount.h>
 # include <fuse_service.h>
+# ifdef HAVE_SETPROCTITLE
+#  include <bsd/unistd.h>
+# endif
 #endif
 #ifdef __SET_FOB_FOR_FUSE
 # undef _FILE_OFFSET_BITS
@@ -320,6 +323,7 @@ struct fuse4fs {
 	struct cache inodes;
 #ifdef HAVE_FUSE_SERVICE
 	struct fuse_service *service;
+	char *svc_cmdline;
 	int bdev_fd;
 	int fusedev_fd;
 #endif
@@ -1443,10 +1447,21 @@ static int fuse4fs_service_connect(struct fuse4fs *ff, struct fuse_args *args)
 
 	if (fuse4fs_is_service(ff))
 		fuse_service_append_args(ff->service, args);
-
 	return 0;
 }
 
+static void fuse4fs_service_set_proc_cmdline(struct fuse4fs *ff, int argc,
+					     char *argv[],
+					     struct fuse_args *args)
+{
+	setproctitle_init(argc, argv, environ);
+	ff->svc_cmdline = fuse_service_cmdline(argc, argv, args);
+	if (!ff->svc_cmdline)
+		return;
+
+	setproctitle("-%s", ff->svc_cmdline);
+}
+
 static inline int
 fuse4fs_service_parse_cmdline(struct fuse_args *args,
 			      struct fuse_cmdline_opts *opts)
@@ -1491,6 +1506,8 @@ static int fuse4fs_service_finish(struct fuse4fs *ff, int ret)
 	 * program scraping the journalctl output needs to see all of our
 	 * output.
 	 */
+	setproctitle("-%s [cleaning up]", ff->svc_cmdline);
+	free(ff->svc_cmdline);
 	sleep(2);
 	if (ret != EXIT_SUCCESS)
 		return EXIT_FAILURE;
@@ -1592,6 +1609,7 @@ static int fuse4fs_service(struct fuse4fs *ff, struct fuse_session *se,
 }
 #else
 # define fuse4fs_service_connect(...)		(0)
+# define fuse4fs_service_set_proc_cmdline(...)	((void)0)
 # define fuse4fs_service_parse_cmdline(...)	(EOPNOTSUPP)
 # define fuse4fs_service_release(...)		((void)0)
 # define fuse4fs_service_close_bdev(...)	((void)0)
@@ -4341,6 +4359,11 @@ static void detect_linux_executable_open(int kernel_flags, int *access_check,
 }
 #endif /* __linux__ */
 
+static int fuse4fs_iomap_begin_read(struct fuse4fs *ff, ext2_ino_t ino,
+				    struct ext2_inode_large *inode, off_t pos,
+				    uint64_t count, uint32_t opflags,
+				    struct fuse_file_iomap *read);
+
 static int fuse4fs_open_file(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 			     ext2_ino_t ino, bool linked,
 			     struct fuse_file_info *fp)
@@ -8406,6 +8429,9 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
+	if (fuse4fs_is_service(&fctx))
+		fuse4fs_service_set_proc_cmdline(&fctx, argc, argv, &args);
+
 	ret = fuse_opt_parse(&args, &fctx, fuse4fs_opts, fuse4fs_opt_proc);
 	if (ret)
 		exit(1);
diff --git a/lib/config.h.in b/lib/config.h.in
index 8c5ba567a748a8..129f7ffcf060f3 100644
--- a/lib/config.h.in
+++ b/lib/config.h.in
@@ -714,4 +714,7 @@
 /* Define to 1 if CLOCK_MONOTONIC is present */
 #undef HAVE_CLOCK_MONOTONIC
 
+/* Define to 1 if you have the 'setproctitle' function. */
+#undef HAVE_SETPROCTITLE
+
 #include <dirpaths.h>


