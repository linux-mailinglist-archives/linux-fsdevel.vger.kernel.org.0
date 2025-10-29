Return-Path: <linux-fsdevel+bounces-66134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C0BC17D6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB1C14FB48B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358122D839E;
	Wed, 29 Oct 2025 01:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eExEVHP5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB6E28467C;
	Wed, 29 Oct 2025 01:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700764; cv=none; b=qqBCUfNpuhJt8c0Q+NIAWM5LULXyiMfQ2k0cQC8/5d1dczXzwxCae+inu17SmoLaBh1QqNXAIEu+jw3jxA8dgpmD2W87nxOXCsoUge0ySjaK7mXUkJHOTff+nOXSX6AIT04oQ60iNYjDfqoK/faMOOHcyosyIqWVucE+njaBjLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700764; c=relaxed/simple;
	bh=O8tAxyJcg1uRHjd9OW/FaGYxRiw+PhHhNBWnMtjqguo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K1gd+txYGQx6So02EIE+KBmafjsZTRsdB90GNHA3OLGV9HVIW3x4PASF+mgzAz9AEIW54e98OPyO5qND4qYm3hxLSYAnWhADPGI24TJUGzubez5NUsbuz5ggwG/XOgEktPt265vvYhzZhLJfmfXh0C6jEj+Oc+LiwolruQcAuI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eExEVHP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F3DC4CEE7;
	Wed, 29 Oct 2025 01:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700764;
	bh=O8tAxyJcg1uRHjd9OW/FaGYxRiw+PhHhNBWnMtjqguo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=eExEVHP5RxRdC1t28FFPcAux8YbPXFfrwiW5E3AlIUmfUvgepXsgOJqUt/a0ibNq5
	 FXXpyDFbt1GRW94/sRObJG+4tW8D96oV7WlbORtRCcMZqTW5OuPq+s+WZ1JfeHMygG
	 4hGyAlaeuAnaPzX8fR0YLEk/Pzlj2SqJB+FiQVQEyw82MoTVu6zI2B0q6imJMvd16X
	 9HPM9qrYlVDgfLnzTbnfg2hM/hZt4FyugcL1lXFh8uUG86Cm1eD6hcKrMEUWRRvA/K
	 2KCGDl0JYG9RhSUzlXXrRE+48vreGcL/LeAFlAvkmicQWAZUHbbwUp4bkk3/h5ati/
	 lQweD06v2Jo+w==
Date: Tue, 28 Oct 2025 18:19:23 -0700
Subject: [PATCH 3/7] fuse4fs: set proc title when in fuse service mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169819086.1431292.15797034926274863898.stgit@frogsfrogsfrogs>
In-Reply-To: <176169819000.1431292.8063152341472986305.stgit@frogsfrogsfrogs>
References: <176169819000.1431292.8063152341472986305.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

When in fuse service mode, set the proc title so that we can identify
fuse servers by mount arguments.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 configure           |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 configure.ac        |   24 ++++++++++++++++++++++++
 fuse4fs/Makefile.in |    2 +-
 fuse4fs/fuse4fs.c   |   23 ++++++++++++++++++++++-
 lib/config.h.in     |    3 +++
 5 files changed, 98 insertions(+), 2 deletions(-)


diff --git a/configure b/configure
index f02b262f2389b5..727b84c25a790e 100755
--- a/configure
+++ b/configure
@@ -701,6 +701,7 @@ gcc_ranlib
 gcc_ar
 UNI_DIFF_OPTS
 SEM_INIT_LIB
+LIBBSD_LIB
 FUSE4FS_CMT
 FUSE2FS_CMT
 fuse_service_socket_dir
@@ -14639,6 +14640,53 @@ fi
 
 
 
+{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for setproctitle in -lbsd" >&5
+printf %s "checking for setproctitle in -lbsd... " >&6; }
+if test ${ac_cv_lib_bsd_setproctitle+y}
+then :
+  printf %s "(cached) " >&6
+else $as_nop
+  ac_check_lib_save_LIBS=$LIBS
+LIBS="-lbsd  $LIBS"
+cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+
+/* Override any GCC internal prototype to avoid an error.
+   Use char because int might match the return type of a GCC
+   builtin and then its argument prototype would still apply.  */
+char setproctitle ();
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
+else $as_nop
+  ac_cv_lib_bsd_setproctitle=no
+fi
+rm -f core conftest.err conftest.$ac_objext conftest.beam \
+    conftest$ac_exeext conftest.$ac_ext
+LIBS=$ac_check_lib_save_LIBS
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
+
 { printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for PR_SET_IO_FLUSHER" >&5
 printf %s "checking for PR_SET_IO_FLUSHER... " >&6; }
 cat confdefs.h - <<_ACEOF >conftest.$ac_ext
diff --git a/configure.ac b/configure.ac
index 0ce63094eab3e5..e925a72b48a42e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1597,6 +1597,30 @@ AS_HELP_STRING([--disable-fuse4fs],[do not build fuse4fs]),
 )
 AC_SUBST(FUSE4FS_CMT)
 
+dnl
+dnl see if setproctitle exists
+dnl
+AC_CHECK_LIB(bsd, setproctitle, [LIBBSD_LIB=-lbsd])
+AC_SUBST(LIBBSD_LIB)
+if test "$ac_cv_lib_bsd_setproctitle" = yes ; then
+	AC_DEFINE(HAVE_SETPROCTITLE, 1, Define to 1 if setproctitle])
+fi
+
+dnl AC_LINK_IFELSE(
+dnl [	AC_LANG_PROGRAM([[
+dnl #define _GNU_SOURCE
+dnl #include <bsd/unistd.h>
+dnl 	]], [[
+dnl setproctitle_init(argc, argv, environ);
+dnl setproctitle("-What sourcery is this???");
+dnl 	]])
+dnl ], have_setproctitle=yes
+dnl    AC_MSG_RESULT(yes),
+dnl    AC_MSG_RESULT(no))
+dnl if test "$setproctitle" = yes; then
+dnl   AC_DEFINE(HAVE_SETPROCTITLE, 1, [Define to 1 if setproctitle exists])
+dnl fi
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
index 1d8e171865230f..0a67456243d0c3 100644
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
@@ -1444,10 +1447,24 @@ static int fuse4fs_service_connect(struct fuse4fs *ff, struct fuse_args *args)
 
 	if (fuse4fs_is_service(ff))
 		fuse_service_append_args(ff->service, args);
-
 	return 0;
 }
 
+static void fuse4fs_service_set_proc_cmdline(struct fuse4fs *ff, int argc,
+					     char *argv[],
+					     struct fuse_args *args)
+{
+	char *cmdline;
+
+	setproctitle_init(argc, argv, environ);
+	cmdline = fuse_service_cmdline(argc, argv, args);
+	if (!cmdline)
+		return;
+
+	setproctitle("-%s", cmdline);
+	free(cmdline);
+}
+
 static inline int
 fuse4fs_service_parse_cmdline(struct fuse_args *args,
 			      struct fuse_cmdline_opts *opts)
@@ -1593,6 +1610,7 @@ static int fuse4fs_service(struct fuse4fs *ff, struct fuse_session *se,
 }
 #else
 # define fuse4fs_service_connect(...)		(0)
+# define fuse4fs_service_set_proc_cmdline(...)	((void)0)
 # define fuse4fs_service_parse_cmdline(...)	(EOPNOTSUPP)
 # define fuse4fs_service_release(...)		((void)0)
 # define fuse4fs_service_close_bdev(...)	((void)0)
@@ -8387,6 +8405,9 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
+	if (fuse4fs_is_service(&fctx))
+		fuse4fs_service_set_proc_cmdline(&fctx, argc, argv, &args);
+
 	ret = fuse_opt_parse(&args, &fctx, fuse4fs_opts, fuse4fs_opt_proc);
 	if (ret)
 		exit(1);
diff --git a/lib/config.h.in b/lib/config.h.in
index 6734d87d4b10ec..e4723e5ded88bf 100644
--- a/lib/config.h.in
+++ b/lib/config.h.in
@@ -361,6 +361,9 @@
 /* Define to 1 if you have the `setmntent' function. */
 #undef HAVE_SETMNTENT
 
+/* Define to 1 if setproctitle */
+#undef HAVE_SETPROCTITLE
+
 /* Define to 1 if you have the `setresgid' function. */
 #undef HAVE_SETRESGID
 


