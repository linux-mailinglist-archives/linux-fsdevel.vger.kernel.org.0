Return-Path: <linux-fsdevel+bounces-61663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6E6B58AD8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECC791B26C08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AB81DE89A;
	Tue, 16 Sep 2025 01:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8bx7678"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90F07E0E4;
	Tue, 16 Sep 2025 01:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984951; cv=none; b=i3g01NvbBTf1T2s618kCwxue2DLHar48JkvSSV2Etgs6DkZ6lYG8eDx+J+8IwwVT2pjUawi2GuxohsyI2T0jgSAYk5Kb9I0Os/5ezB70rYDgc9OwCm4flHXB3COCUerZ8ZPCHIja0bHGbem4nEK1EBBSspMdMURL/1AzEvvf0Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984951; c=relaxed/simple;
	bh=YrNdJIb5GvVUXeN38Lep1KSvkbZbYgNQTwDklswNS7U=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cylabs//iyGH9YVZiQf9WCrdm47sxPOGrzuY7UtKQUNG3r5oQynyiMS9k5XeX08LWBRp8hSYWgfg2X3dRzIV/HC/AVT2pnp82tFemYuSzPPymcSfN3yoyMjoftjo2V/b5A2tiVJmsV0e/GOaDD0lvnldORazOPZRr8l5dHGgQrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8bx7678; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFDEC4CEF1;
	Tue, 16 Sep 2025 01:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984951;
	bh=YrNdJIb5GvVUXeN38Lep1KSvkbZbYgNQTwDklswNS7U=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=n8bx7678Mg/r0tNaG4yPmWEZo7Yr4mJqxMfl49gXt/ITLcV0iriKHbSuLJW4YS1io
	 WUInnj2YuNIvKaAgF6IvD3qW+cYeY8j1wdq8ialuCf5PHe0X8PSmomDzGIceIe7U9q
	 P3crrdSdqNSdI1Q0qEH4dUTETK7L5mXFbjxYv6dZlxEUfhbA7btJ2Nlv+x2G9tKEuh
	 ysQLPdPSBXMX2t9TABX0LyqLSIV9jwQHmkBgEydhd2My+mB1+yr7hwUEVBp7DU3eWE
	 cbHuJVMohHWo1HKMlPcdAQ1bIZB6hlDU6F7+RPKH+7oGxpwM+XODJvA6SIIGErgVGj
	 tnpPmdc/uWTAA==
Date: Mon, 15 Sep 2025 18:09:10 -0700
Subject: [PATCH 3/4] fuse4fs: set proc title when in fuse service mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798163153.392148.11363900743040313759.stgit@frogsfrogsfrogs>
In-Reply-To: <175798163083.392148.13563951490661745612.stgit@frogsfrogsfrogs>
References: <175798163083.392148.13563951490661745612.stgit@frogsfrogsfrogs>
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
index b2b8bbf2f92ea3..d089e5e35a66c3 100755
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
@@ -14599,6 +14600,53 @@ fi
 
 
 
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
index 7d3e3d86fff94e..603d6ec1a1712c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1574,6 +1574,30 @@ AS_HELP_STRING([--disable-fuse4fs],[do not build fuse4fs]),
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
index ef15316eff59ca..447212f836cbc0 100644
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
index db86a749b74af0..0e43e99c3c080d 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -47,6 +47,9 @@
 #ifdef HAVE_FUSE_SERVICE
 # include <sys/mount.h>
 # include <fuse_service.h>
+# ifdef HAVE_SETPROCTITLE
+#  include <bsd/unistd.h>
+# endif
 #endif
 #ifdef __SET_FOB_FOR_FUSE
 # undef _FILE_OFFSET_BITS
@@ -1221,10 +1224,24 @@ static int fuse4fs_service_connect(struct fuse4fs *ff, struct fuse_args *args)
 
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
@@ -1357,6 +1374,7 @@ static int fuse4fs_service(struct fuse4fs *ff, struct fuse_session *se,
 #else
 # define fuse4fs_is_service(...)		(false)
 # define fuse4fs_service_connect(...)		(0)
+# define fuse4fs_service_set_proc_cmdline(...)	(0)
 # define fuse4fs_service_parse_cmdline(...)	(EOPNOTSUPP)
 # define fuse4fs_service_release(...)		((void)0)
 # define fuse4fs_service_finish(ret)		(ret)
@@ -7746,6 +7764,9 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
+	if (fuse4fs_is_service(&fctx))
+		fuse4fs_service_set_proc_cmdline(&fctx, argc, argv, &args);
+
 	ret = fuse_opt_parse(&args, &fctx, fuse4fs_opts, fuse4fs_opt_proc);
 	if (ret)
 		exit(1);
diff --git a/lib/config.h.in b/lib/config.h.in
index dcbbb3a7bf1ac4..7ef6a815213856 100644
--- a/lib/config.h.in
+++ b/lib/config.h.in
@@ -358,6 +358,9 @@
 /* Define to 1 if you have the `setmntent' function. */
 #undef HAVE_SETMNTENT
 
+/* Define to 1 if setproctitle */
+#undef HAVE_SETPROCTITLE
+
 /* Define to 1 if you have the `setresgid' function. */
 #undef HAVE_SETRESGID
 


