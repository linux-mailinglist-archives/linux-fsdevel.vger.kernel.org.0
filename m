Return-Path: <linux-fsdevel+bounces-61662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A977BB58AD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662423B369C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AE61F5834;
	Tue, 16 Sep 2025 01:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoLTZy8m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129DB1E1C02;
	Tue, 16 Sep 2025 01:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984936; cv=none; b=T5bgiZ8Ix9vhde9rR4CR6DSP8R+gpEfK+EVBtljjuNRHisqTyXF8Qu96gjNwdZXuLR5eJKc+JRIRZfRsdlBqLlFPzumeWw5XV1nrkpi5xVoUNoJZpIpc7IHX6JDG7o1gdxJQHO7aGXdVzBkQE/i1e0o+dSZfj214YCQnGRZ7dEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984936; c=relaxed/simple;
	bh=rjX2Rsc+1GzoYmulF1bnOL3NPcBEr8+I4ZXlBDoFzuo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q23lJjvUhY+CTXMWZ8NMtteA2elzR31WOfo/MwnmJuDPuFauHCTureEP8pUGwSxDqpNwjTzeD2wnqeSfGmexFEALo0mpb4bRDkmj5GFycyfRM1n7mu0LHBNFagmWF/3FEpuu5BvRYoPWBDB9f7QUmL99Uyl7IVIgpXOE2hNLjFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoLTZy8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5D3C4CEFB;
	Tue, 16 Sep 2025 01:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984935;
	bh=rjX2Rsc+1GzoYmulF1bnOL3NPcBEr8+I4ZXlBDoFzuo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=HoLTZy8mWstrKZbgk7Ly0QA17TF6PqGn88C1vzTOhPNIvttEfv2Q/8xcR9DwqMxFZ
	 uNzbseaqCNmqkx/aVlQEF5/ZcnAWqh9rXG45t5ni5gzttL4B578xD6Gnv2kgLDwVqh
	 3cjcGVjzCyh9BqdgsmbRLavrV8uqpapr3XfPU/U4SlKRJ8DPTlHQ6ymWAzcq86Q0sx
	 uYD5HCuKxGlgBlfZ4uQ0+Q7jzf4Z+UzNTXZiU3sqHjEDOzOoS6/jajf/u2wOrAebsw
	 ncYTRX351j/3AXbGNxJwgFmYe4sDADUUip0WlHXVR0YFYac4A2XA1yHfcp/5xz9is0
	 /mQR8Ee9MoCKQ==
Date: Mon, 15 Sep 2025 18:08:55 -0700
Subject: [PATCH 2/4] fuse4fs: enable safe service mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798163134.392148.916250692315504893.stgit@frogsfrogsfrogs>
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

Make it possible to run fuse4fs as a safe systemd service, wherein the
fuse server only has access to the fds that we pass in.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 MCONFIG.in                  |    1 
 configure                   |  133 +++++++++++++++++++++++
 configure.ac                |   45 ++++++++
 debian/fuse4fs.install      |    2 
 fuse4fs/Makefile.in         |   40 ++++++-
 fuse4fs/fuse4fs.c           |  253 ++++++++++++++++++++++++++++++++++++++++++-
 fuse4fs/fuse4fs.socket.in   |   14 ++
 fuse4fs/fuse4fs@.service.in |   95 ++++++++++++++++
 lib/config.h.in             |    3 +
 util/subst.conf.in          |    2 
 10 files changed, 577 insertions(+), 11 deletions(-)
 create mode 100644 fuse4fs/fuse4fs.socket.in
 create mode 100644 fuse4fs/fuse4fs@.service.in


diff --git a/MCONFIG.in b/MCONFIG.in
index 96c6fe8928b1d6..7f94ebf23c2124 100644
--- a/MCONFIG.in
+++ b/MCONFIG.in
@@ -42,6 +42,7 @@ HAVE_CROND = @have_crond@
 CROND_DIR = @crond_dir@
 HAVE_SYSTEMD = @have_systemd@
 SYSTEMD_SYSTEM_UNIT_DIR = @systemd_system_unit_dir@
+HAVE_FUSE_SERVICE = @have_fuse_service@
 
 @SET_MAKE@
 
diff --git a/configure b/configure
index 4137f942efaef5..b2b8bbf2f92ea3 100755
--- a/configure
+++ b/configure
@@ -703,6 +703,8 @@ UNI_DIFF_OPTS
 SEM_INIT_LIB
 FUSE4FS_CMT
 FUSE2FS_CMT
+fuse_service_socket_dir
+have_fuse_service
 FUSE_LIB
 fuse3_LIBS
 fuse3_CFLAGS
@@ -933,6 +935,7 @@ with_libiconv_prefix
 with_libintl_prefix
 enable_largefile
 with_libarchive
+with_fuse_service_socket_dir
 enable_fuse2fs
 enable_fuse4fs
 enable_lto
@@ -1654,6 +1657,8 @@ Optional Packages:
   --with-libintl-prefix[=DIR]  search for libintl in DIR/include and DIR/lib
   --without-libintl-prefix     don't search for libintl in includedir and libdir
   --without-libarchive    disable use of libarchive
+  --with-fuse-service-socket-dir[=DIR]
+                          Create fuse3 filesystem service sockets in DIR.
   --with-multiarch=ARCH   specify the multiarch triplet
   --with-udev-rules-dir[=DIR]
                           Install udev rules into DIR.
@@ -14336,6 +14341,134 @@ printf "%s\n" "#define HAVE_FUSE_LOWLEVEL 1" >>confdefs.h
 
 fi
 
+have_fuse_service=
+fuse_service_socket_dir=
+if test -n "$have_fuse_lowlevel"
+then
+
+# Check whether --with-fuse_service_socket_dir was given.
+if test ${with_fuse_service_socket_dir+y}
+then :
+  withval=$with_fuse_service_socket_dir;
+else $as_nop
+  with_fuse_service_socket_dir=yes
+fi
+
+	if test "x${with_fuse_service_socket_dir}" != "xno"
+then :
+
+		if test "x${with_fuse_service_socket_dir}" = "xyes"
+then :
+
+
+pkg_failed=no
+{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for fuse3" >&5
+printf %s "checking for fuse3... " >&6; }
+
+if test -n "$fuse3_CFLAGS"; then
+    pkg_cv_fuse3_CFLAGS="$fuse3_CFLAGS"
+ elif test -n "$PKG_CONFIG"; then
+    if test -n "$PKG_CONFIG" && \
+    { { printf "%s\n" "$as_me:${as_lineno-$LINENO}: \$PKG_CONFIG --exists --print-errors \"fuse3\""; } >&5
+  ($PKG_CONFIG --exists --print-errors "fuse3") 2>&5
+  ac_status=$?
+  printf "%s\n" "$as_me:${as_lineno-$LINENO}: \$? = $ac_status" >&5
+  test $ac_status = 0; }; then
+  pkg_cv_fuse3_CFLAGS=`$PKG_CONFIG --cflags "fuse3" 2>/dev/null`
+		      test "x$?" != "x0" && pkg_failed=yes
+else
+  pkg_failed=yes
+fi
+ else
+    pkg_failed=untried
+fi
+if test -n "$fuse3_LIBS"; then
+    pkg_cv_fuse3_LIBS="$fuse3_LIBS"
+ elif test -n "$PKG_CONFIG"; then
+    if test -n "$PKG_CONFIG" && \
+    { { printf "%s\n" "$as_me:${as_lineno-$LINENO}: \$PKG_CONFIG --exists --print-errors \"fuse3\""; } >&5
+  ($PKG_CONFIG --exists --print-errors "fuse3") 2>&5
+  ac_status=$?
+  printf "%s\n" "$as_me:${as_lineno-$LINENO}: \$? = $ac_status" >&5
+  test $ac_status = 0; }; then
+  pkg_cv_fuse3_LIBS=`$PKG_CONFIG --libs "fuse3" 2>/dev/null`
+		      test "x$?" != "x0" && pkg_failed=yes
+else
+  pkg_failed=yes
+fi
+ else
+    pkg_failed=untried
+fi
+
+
+
+if test $pkg_failed = yes; then
+        { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: no" >&5
+printf "%s\n" "no" >&6; }
+
+if $PKG_CONFIG --atleast-pkgconfig-version 0.20; then
+        _pkg_short_errors_supported=yes
+else
+        _pkg_short_errors_supported=no
+fi
+        if test $_pkg_short_errors_supported = yes; then
+                fuse3_PKG_ERRORS=`$PKG_CONFIG --short-errors --print-errors --cflags --libs "fuse3" 2>&1`
+        else
+                fuse3_PKG_ERRORS=`$PKG_CONFIG --print-errors --cflags --libs "fuse3" 2>&1`
+        fi
+        # Put the nasty error message in config.log where it belongs
+        echo "$fuse3_PKG_ERRORS" >&5
+
+
+				with_fuse_service_socket_dir=""
+
+elif test $pkg_failed = untried; then
+        { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: no" >&5
+printf "%s\n" "no" >&6; }
+
+				with_fuse_service_socket_dir=""
+
+else
+        fuse3_CFLAGS=$pkg_cv_fuse3_CFLAGS
+        fuse3_LIBS=$pkg_cv_fuse3_LIBS
+        { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: yes" >&5
+printf "%s\n" "yes" >&6; }
+
+				with_fuse_service_socket_dir="$($PKG_CONFIG --variable=service_socket_dir fuse3)"
+
+fi
+
+
+fi
+		{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for fuse3 service socket dir" >&5
+printf %s "checking for fuse3 service socket dir... " >&6; }
+		fuse_service_socket_dir="${with_fuse_service_socket_dir}"
+		if test -n "${fuse_service_socket_dir}"
+then :
+
+			{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: ${fuse_service_socket_dir}" >&5
+printf "%s\n" "${fuse_service_socket_dir}" >&6; }
+			have_fuse_service="yes"
+
+else $as_nop
+
+			{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: no" >&5
+printf "%s\n" "no" >&6; }
+			have_fuse_service="no"
+
+fi
+
+fi
+fi
+
+
+if test "$have_fuse_service" = yes
+then
+
+printf "%s\n" "#define HAVE_FUSE_SERVICE 1" >>confdefs.h
+
+fi
+
 FUSE2FS_CMT=
 # Check whether --enable-fuse2fs was given.
 if test ${enable_fuse2fs+y}
diff --git a/configure.ac b/configure.ac
index a1057c07b8c056..7d3e3d86fff94e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1455,6 +1455,51 @@ then
 		  [Define to 1 if fuse supports lowlevel API])
 fi
 
+dnl
+dnl Check if the FUSE library tells us where to put fs service sockets
+dnl
+have_fuse_service=
+fuse_service_socket_dir=
+if test -n "$have_fuse_lowlevel"
+then
+	AC_ARG_WITH([fuse_service_socket_dir],
+	  [AS_HELP_STRING([--with-fuse-service-socket-dir@<:@=DIR@:>@],
+		  [Create fuse3 filesystem service sockets in DIR.])],
+	  [],
+	  [with_fuse_service_socket_dir=yes])
+	AS_IF([test "x${with_fuse_service_socket_dir}" != "xno"],
+	  [
+		AS_IF([test "x${with_fuse_service_socket_dir}" = "xyes"],
+		  [
+			PKG_CHECK_MODULES([fuse3], [fuse3],
+			  [
+				with_fuse_service_socket_dir="$($PKG_CONFIG --variable=service_socket_dir fuse3)"
+			  ], [
+				with_fuse_service_socket_dir=""
+			  ])
+			m4_pattern_allow([^PKG_(MAJOR|MINOR|BUILD|REVISION)$])
+		  ])
+		AC_MSG_CHECKING([for fuse3 service socket dir])
+		fuse_service_socket_dir="${with_fuse_service_socket_dir}"
+		AS_IF([test -n "${fuse_service_socket_dir}"],
+		  [
+			AC_MSG_RESULT(${fuse_service_socket_dir})
+			have_fuse_service="yes"
+		  ],
+		  [
+			AC_MSG_RESULT(no)
+			have_fuse_service="no"
+		  ])
+	  ],
+	  [])
+fi
+AC_SUBST(have_fuse_service)
+AC_SUBST(fuse_service_socket_dir)
+if test "$have_fuse_service" = yes
+then
+	AC_DEFINE(HAVE_FUSE_SERVICE, 1, [Define to 1 if fuse supports service])
+fi
+
 dnl
 dnl Check if fuse2fs is actually built.
 dnl
diff --git a/debian/fuse4fs.install b/debian/fuse4fs.install
index fb8c8ab671c73c..2da71546e8c1d5 100644
--- a/debian/fuse4fs.install
+++ b/debian/fuse4fs.install
@@ -1,2 +1,4 @@
 /usr/bin/fuse4fs
 /usr/share/man/man1/fuse4fs.1
+[linux-any] lib/systemd/system/fuse4fs.socket
+[linux-any] lib/systemd/system/fuse4fs@.service
diff --git a/fuse4fs/Makefile.in b/fuse4fs/Makefile.in
index 0a558da23ced81..ef15316eff59ca 100644
--- a/fuse4fs/Makefile.in
+++ b/fuse4fs/Makefile.in
@@ -17,6 +17,13 @@ UMANPAGES=
 @FUSE4FS_CMT@UPROGS+=fuse4fs
 @FUSE4FS_CMT@UMANPAGES+=fuse4fs.1
 
+ifeq ($(HAVE_SYSTEMD),yes)
+SERVICE_FILES	+= fuse4fs.socket fuse4fs@.service
+INSTALLDIRS_TGT	+= installdirs-systemd
+INSTALL_TGT	+= install-systemd
+UNINSTALL_TGT	+= uninstall-systemd
+endif
+
 FUSE4FS_OBJS=	fuse4fs.o journal.o recovery.o revoke.o
 
 PROFILED_FUSE4FS_OJBS=	profiled/fuse4fs.o profiled/journal.o \
@@ -54,7 +61,7 @@ DEPEND_CFLAGS = -I$(top_srcdir)/e2fsck
 @PROFILE_CMT@	$(Q) $(CC) $(ALL_CFLAGS) -g -pg -o profiled/$*.o -c $<
 
 all:: profiled $(SPROGS) $(UPROGS) $(USPROGS) $(SMANPAGES) $(UMANPAGES) \
-	$(FMANPAGES) $(LPROGS)
+	$(FMANPAGES) $(LPROGS) $(SERVICE_FILES)
 
 all-static::
 
@@ -71,6 +78,14 @@ fuse4fs: $(FUSE4FS_OBJS) $(DEPLIBS) $(DEPLIBBLKID) $(DEPLIBUUID) \
 		$(LIBFUSE) $(LIBBLKID) $(LIBUUID) $(LIBEXT2FS) $(LIBINTL) \
 		$(CLOCK_GETTIME_LIB) $(SYSLIBS) $(LIBS_E2P)
 
+%.socket: %.socket.in $(DEP_SUBSTITUTE)
+	$(E) "	SUBST $@"
+	$(Q) $(SUBSTITUTE_UPTIME) $< $@
+
+%.service: %.service.in $(DEP_SUBSTITUTE)
+	$(E) "	SUBST $@"
+	$(Q) $(SUBSTITUTE_UPTIME) $< $@
+
 journal.o: $(srcdir)/../debugfs/journal.c
 	$(E) "	CC $<"
 	$(Q) $(CC) -c $(JOURNAL_CFLAGS) -I$(srcdir) \
@@ -93,11 +108,15 @@ fuse4fs.1: $(DEP_SUBSTITUTE) $(srcdir)/fuse4fs.1.in
 	$(E) "	SUBST $@"
 	$(Q) $(SUBSTITUTE_UPTIME) $(srcdir)/fuse4fs.1.in fuse4fs.1
 
-installdirs:
+installdirs: $(INSTALLDIRS_TGT)
 	$(E) "	MKDIR_P $(bindir) $(man1dir)"
 	$(Q) $(MKDIR_P) $(DESTDIR)$(bindir) $(DESTDIR)$(man1dir)
 
-install: all $(UMANPAGES) installdirs
+installdirs-systemd:
+	$(E) "	MKDIR_P $(SYSTEMD_SYSTEM_UNIT_DIR)"
+	$(Q) $(MKDIR_P) $(DESTDIR)$(SYSTEMD_SYSTEM_UNIT_DIR)
+
+install: all $(UMANPAGES) installdirs $(INSTALL_TGT)
 	$(Q) for i in $(UPROGS); do \
 		$(ES) "	INSTALL $(bindir)/$$i"; \
 		$(INSTALL_PROGRAM) $$i $(DESTDIR)$(bindir)/$$i; \
@@ -110,13 +129,19 @@ install: all $(UMANPAGES) installdirs
 		$(INSTALL_DATA) $$i $(DESTDIR)$(man1dir)/$$i; \
 	done
 
+install-systemd: $(SERVICE_FILES) installdirs-systemd
+	$(Q) for i in $(SERVICE_FILES); do \
+		$(ES) "	INSTALL_DATA $(SYSTEMD_SYSTEM_UNIT_DIR)/$$i"; \
+		$(INSTALL_DATA) $$i $(DESTDIR)$(SYSTEMD_SYSTEM_UNIT_DIR)/$$i; \
+	done
+
 install-strip: install
 	$(Q) for i in $(UPROGS); do \
 		$(E) "	STRIP $(bindir)/$$i"; \
 		$(STRIP) $(DESTDIR)$(bindir)/$$i; \
 	done
 
-uninstall:
+uninstall: $(UNINSTALL_TGT)
 	for i in $(UPROGS); do \
 		$(RM) -f $(DESTDIR)$(bindir)/$$i; \
 	done
@@ -124,9 +149,16 @@ uninstall:
 		$(RM) -f $(DESTDIR)$(man1dir)/$$i; \
 	done
 
+uninstall-systemd:
+	for i in $(SERVICE_FILES); do \
+		$(RM) -f $(DESTDIR)$(SYSTEMD_SYSTEM_UNIT_DIR)/$$i; \
+	done
+
 clean::
 	$(RM) -f $(UPROGS) $(UMANPAGES) profile.h \
 		fuse4fs.profiled \
+		$(SERVICE_FILES) \
+		fuse4fs.socket \
 		profiled/*.o \#* *.s *.o *.a *~ core gmon.out
 
 mostlyclean: clean
diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 3e8822fac08630..db86a749b74af0 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -44,6 +44,10 @@
 # define _FILE_OFFSET_BITS 64
 #endif /* _FILE_OFFSET_BITS */
 #include <fuse_lowlevel.h>
+#ifdef HAVE_FUSE_SERVICE
+# include <sys/mount.h>
+# include <fuse_service.h>
+#endif
 #ifdef __SET_FOB_FOR_FUSE
 # undef _FILE_OFFSET_BITS
 #endif /* __SET_FOB_FOR_FUSE */
@@ -301,6 +305,11 @@ struct fuse4fs {
 #endif
 	struct fuse_session *fuse;
 	struct cache inodes;
+#ifdef HAVE_FUSE_SERVICE
+	struct fuse_service *service;
+	int bdev_fd;
+	int fusedev_fd;
+#endif
 };
 
 #define FUSE4FS_CHECK_HANDLE(req, fh) \
@@ -1196,6 +1205,167 @@ static int fuse4fs_inum_access(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 	return -EACCES;
 }
 
+#ifdef HAVE_FUSE_SERVICE
+static inline bool fuse4fs_is_service(const struct fuse4fs *ff)
+{
+	return fuse_service_accepted(ff->service);
+}
+
+static int fuse4fs_service_connect(struct fuse4fs *ff, struct fuse_args *args)
+{
+	int ret;
+
+	ret = fuse_service_accept(&ff->service);
+	if (ret)
+		return ret;
+
+	if (fuse4fs_is_service(ff))
+		fuse_service_append_args(ff->service, args);
+
+	return 0;
+}
+
+static inline int
+fuse4fs_service_parse_cmdline(struct fuse_args *args,
+			      struct fuse_cmdline_opts *opts)
+{
+	return fuse_service_parse_cmdline_opts(args, opts);
+}
+
+static void fuse4fs_service_release(struct fuse4fs *ff, int mount_ret)
+{
+	if (fuse4fs_is_service(ff)) {
+		fuse_service_send_goodbye(ff->service, mount_ret);
+		fuse_service_release(ff->service);
+	}
+}
+
+static int fuse4fs_service_finish(struct fuse4fs *ff, int ret)
+{
+	if (!fuse4fs_is_service(ff))
+		return ret;
+
+	fuse_service_destroy(&ff->service);
+
+	/*
+	 * If we're being run as a service, the return code must fit the LSB
+	 * init script action error guidelines, which is to say that we
+	 * compress all errors to 1 ("generic or unspecified error", LSB 5.0
+	 * section 22.2) and hope the admin will scan the log for what actually
+	 * happened.
+	 *
+	 * We have to sleep 2 seconds here because journald uses the pid to
+	 * connect our log messages to the systemd service.  This is critical
+	 * for capturing all the log messages if the scrub fails, because the
+	 * fail service uses the service name to gather log messages for the
+	 * error report.
+	 */
+	sleep(2);
+	if (ret != EXIT_SUCCESS)
+		return EXIT_FAILURE;
+	return EXIT_SUCCESS;
+}
+
+static int fuse4fs_service_get_config(struct fuse4fs *ff)
+{
+	int open_flags = O_RDWR | O_EXCL;
+	int ret;
+
+retry:
+	ret = fuse_service_request_file(ff->service, ff->device, open_flags,
+					0);
+	if (ret)
+		return ret;
+
+	ret = fuse_service_receive_file(ff->service, ff->device, &ff->bdev_fd);
+	if (ret == -2) {
+		if (errno == EACCES && (open_flags & O_ACCMODE) != O_RDONLY) {
+			open_flags = O_RDONLY | O_EXCL;
+			goto retry;
+		}
+		err_printf(ff, "opening %s: %s.\n", ff->device, strerror(errno));
+		return ret;
+	}
+	if (ret)
+		return ret;
+
+	if (ff->bdev_fd < 0) {
+		err_printf(ff, "%s: %s: %s.\n", ff->device,
+			   _("opening service"), strerror(-ff->bdev_fd));
+		return -1;
+	}
+
+	ret = fuse_service_finish_file_requests(ff->service);
+	if (ret)
+		return ret;
+
+	ff->fusedev_fd = fuse_service_take_fusedev(ff->service);
+	return 0;
+}
+
+static errcode_t fuse4fs_service_openfs(struct fuse4fs *ff, char *options,
+					int flags)
+{
+	char path[32];
+
+	snprintf(path, sizeof(path), "%d", ff->bdev_fd);
+	iocache_set_backing_manager(unixfd_io_manager);
+	return ext2fs_open2(path, options, flags, 0, 0, iocache_io_manager,
+			&ff->fs);
+}
+
+static int fuse4fs_service_configure_iomap(struct fuse4fs *ff)
+{
+	int error = 0;
+	int ret;
+
+	ret = fuse_service_configure_iomap(ff->service,
+					   ff->iomap_want == FT_ENABLE,
+					   &error);
+	if (ret)
+		return -1;
+
+	if (error) {
+		err_printf(ff, "%s: %s.\n", _("enabling iomap"),
+			   strerror(error));
+		return -1;
+	}
+
+	return 0;
+}
+
+static int fuse4fs_service(struct fuse4fs *ff, struct fuse_session *se,
+			   const char *mountpoint)
+{
+	char path[32];
+	int ret = 0;
+
+	snprintf(path, sizeof(path), "/dev/fd/%d", ff->fusedev_fd);
+	ret = fuse_session_mount(se, path);
+	if (ret)
+		return ret;
+
+	ret = fuse_service_mount(ff->service, se, mountpoint);
+	if (ret) {
+		err_printf(ff, "%s: %s\n", _("mounting filesystem"),
+			   strerror(errno));
+		return ret;
+	}
+
+	return 0;
+}
+#else
+# define fuse4fs_is_service(...)		(false)
+# define fuse4fs_service_connect(...)		(0)
+# define fuse4fs_service_parse_cmdline(...)	(EOPNOTSUPP)
+# define fuse4fs_service_release(...)		((void)0)
+# define fuse4fs_service_finish(ret)		(ret)
+# define fuse4fs_service_get_config(...)	(EOPNOTSUPP)
+# define fuse4fs_service_openfs(...)		(EOPNOTSUPP)
+# define fuse4fs_service_configure_iomap(...)	(EOPNOTSUPP)
+# define fuse4fs_service(...)			(EOPNOTSUPP)
+#endif
+
 static errcode_t fuse4fs_acquire_lockfile(struct fuse4fs *ff)
 {
 	char *resolved;
@@ -1290,16 +1460,22 @@ static errcode_t fuse4fs_open(struct fuse4fs *ff, int libext2_flags)
 	dbg_printf(ff, "opening with flags=0x%x\n", flags);
 
 	iocache_set_backing_manager(unix_io_manager);
-	err = ext2fs_open2(ff->device, options, flags, 0, 0, iocache_io_manager,
-			   &ff->fs);
+	if (fuse4fs_is_service(ff))
+		err = fuse4fs_service_openfs(ff, options, flags);
+	else
+		err = ext2fs_open2(ff->device, options, flags, 0, 0,
+				   iocache_io_manager, &ff->fs);
 	if (err == EPERM) {
 		err_printf(ff, "%s.\n",
 			   _("read-only device, trying to mount norecovery"));
 		flags &= ~EXT2_FLAG_RW;
 		ff->ro = 1;
 		ff->norecovery = 1;
-		err = ext2fs_open2(ff->device, options, flags, 0, 0,
-				   iocache_io_manager, &ff->fs);
+		if (fuse4fs_is_service(ff))
+			err = fuse4fs_service_openfs(ff, options, flags);
+		else
+			err = ext2fs_open2(ff->device, options, flags, 0, 0,
+					   iocache_io_manager, &ff->fs);
 	}
 	if (err) {
 		err_printf(ff, "%s.\n", error_message(err));
@@ -1599,6 +1775,10 @@ static int fuse4fs_setup_logging(struct fuse4fs *ff)
 	if (logfile)
 		return fuse4fs_capture_output(ff, logfile);
 
+	/* systemd already hooked us up to /dev/ttyprintk */
+	if (fuse4fs_is_service(ff))
+		return 0;
+
 	/* in kernel mode, try to log errors to the kernel log */
 	if (ff->kernel)
 		fuse4fs_capture_output(ff, "/dev/ttyprintk");
@@ -7370,7 +7550,11 @@ static inline bool fuse4fs_discover_iomap(struct fuse4fs *ff)
 	if (ff->iomap_want == FT_DISABLE)
 		return false;
 
+#ifdef HAVE_FUSE_SERVICE
+	ff->iomap_cap = fuse_lowlevel_discover_iomap(ff->fusedev_fd);
+#else
 	ff->iomap_cap = fuse_lowlevel_discover_iomap(-1);
+#endif
 	return ff->iomap_cap & FUSE_IOMAP_SUPPORT_FILEIO;
 }
 #else
@@ -7408,7 +7592,11 @@ static int fuse4fs_main(struct fuse_args *args, struct fuse4fs *ff)
 	struct fuse_loop_config *loop_config = NULL;
 	int ret;
 
-	if (fuse_parse_cmdline(args, &opts) != 0) {
+	if (fuse4fs_is_service(ff))
+		ret = fuse4fs_service_parse_cmdline(args, &opts);
+	else
+		ret = fuse_parse_cmdline(args, &opts);
+	if (ret != 0) {
 		ret = 1;
 		goto out;
 	}
@@ -7441,7 +7629,18 @@ static int fuse4fs_main(struct fuse_args *args, struct fuse4fs *ff)
 	}
 	ff->fuse = se;
 
-	if (fuse_session_mount(se, opts.mountpoint) != 0) {
+	if (fuse4fs_is_service(ff)) {
+		/*
+		 * foreground mode is needed so that systemd actually tracks
+		 * the service correctly and doesnt try to kill it; and so that
+		 * stdout/stderr don't get zapped
+		 */
+		opts.foreground = 1;
+		ret = fuse4fs_service(ff, se, opts.mountpoint);
+	} else {
+		ret = fuse_session_mount(se, opts.mountpoint);
+	}
+	if (ret != 0) {
 		ret = 4;
 		goto out_destroy_session;
 	}
@@ -7482,6 +7681,8 @@ static int fuse4fs_main(struct fuse_args *args, struct fuse4fs *ff)
 	fuse_loop_cfg_set_idle_threads(loop_config, opts.max_idle_threads);
 	fuse_loop_cfg_set_max_threads(loop_config, 4);
 
+	fuse4fs_service_release(ff, 0);
+
 	if (fuse_session_loop_mt(se, loop_config) != 0) {
 		ret = 8;
 		goto out_loopcfg;
@@ -7499,6 +7700,7 @@ static int fuse4fs_main(struct fuse_args *args, struct fuse4fs *ff)
 out_free_opts:
 	free(opts.mountpoint);
 out:
+	fuse4fs_service_release(ff, ret);
 	return ret;
 }
 
@@ -7517,6 +7719,10 @@ int main(int argc, char *argv[])
 #endif
 		.translate_inums = 1,
 		.write_gdt_on_destroy = 1,
+#ifdef HAVE_FUSE_SERVICE
+		.bdev_fd = -1,
+		.fusedev_fd = -1,
+#endif
 	};
 	errcode_t err;
 	FILE *orig_stderr = stderr;
@@ -7524,6 +7730,22 @@ int main(int argc, char *argv[])
 	bool iomap_detected = false;
 	int ret;
 
+	/* XXX */
+	if (getenv("FUSE4FS_DEBUGGER")) {
+		char *moo = getenv("FUSE4FS_DEBUGGER");
+		int del = atoi(moo);
+
+		fprintf(stderr, "WAITING %ds FOR DEBUGGER\n", del);
+		fflush(stderr);
+		sleep(del);
+	}
+
+	ret = fuse4fs_service_connect(&fctx, &args);
+	if (ret) {
+		fprintf(stderr, "Could not connect to service socket!\n");
+		exit(1);
+	}
+
 	ret = fuse_opt_parse(&args, &fctx, fuse4fs_opts, fuse4fs_opt_proc);
 	if (ret)
 		exit(1);
@@ -7565,6 +7787,22 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
+	if (fuse4fs_is_service(&fctx)) {
+		ret = fuse4fs_service_get_config(&fctx);
+		if (ret) {
+			ret = 2;
+			goto out;
+		}
+
+		if (fctx.iomap_want != FT_DISABLE) {
+			ret = fuse4fs_service_configure_iomap(&fctx);
+			if (ret) {
+				ret = 2;
+				goto out;
+			}
+		}
+	}
+
 #ifdef HAVE_PR_SET_IO_FLUSHER
 	/*
 	 * Register as a filesystem I/O server process so that our memory
@@ -7668,7 +7906,7 @@ int main(int argc, char *argv[])
 
 	/* Set up default fuse parameters */
 	snprintf(extra_args, BUFSIZ, "-osubtype=%s,fsname=%s",
-		 get_subtype(argv[0]),
+		 get_subtype(args.argv[0]),
 		 fctx.device);
 	if (fctx.no_default_opts == 0)
 		fuse_opt_add_arg(&args, extra_args);
@@ -7748,6 +7986,7 @@ int main(int argc, char *argv[])
 	err_shortdev = NULL;
 	if (fctx.device)
 		free(fctx.device);
+	ret = fuse4fs_service_finish(&fctx, ret);
 	fuse_opt_free_args(&args);
 	return ret;
 }
diff --git a/fuse4fs/fuse4fs.socket.in b/fuse4fs/fuse4fs.socket.in
new file mode 100644
index 00000000000000..58b9173c0bd727
--- /dev/null
+++ b/fuse4fs/fuse4fs.socket.in
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2025 Oracle.  All Rights Reserved.
+# Author: Darrick J. Wong <djwong@kernel.org>
+[Unit]
+Description=Socket for ext4 Service
+
+[Socket]
+ListenSequentialPacket=@fuse_service_socket_dir@/ext2
+ListenSequentialPacket=@fuse_service_socket_dir@/ext3
+ListenSequentialPacket=@fuse_service_socket_dir@/ext4
+Accept=yes
+SocketMode=0660
+RemoveOnStop=yes
diff --git a/fuse4fs/fuse4fs@.service.in b/fuse4fs/fuse4fs@.service.in
new file mode 100644
index 00000000000000..4765df462c6461
--- /dev/null
+++ b/fuse4fs/fuse4fs@.service.in
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2025 Oracle.  All Rights Reserved.
+# Author: Darrick J. Wong <djwong@kernel.org>
+[Unit]
+Description=ext4 Service
+
+[Service]
+Type=exec
+ExecStart=@bindir@/fuse4fs -o kernel
+
+# Try to capture core dumps
+LimitCORE=infinity
+
+SyslogIdentifier=%N
+
+# No realtime CPU scheduling
+RestrictRealtime=true
+
+# Don't let us see anything in the regular system, and don't run as root
+DynamicUser=true
+ProtectSystem=strict
+ProtectHome=true
+PrivateTmp=true
+PrivateDevices=true
+PrivateUsers=true
+
+# No network access
+PrivateNetwork=true
+ProtectHostname=true
+RestrictAddressFamilies=none
+IPAddressDeny=any
+
+# Don't let the program mess with the kernel configuration at all
+ProtectKernelLogs=true
+ProtectKernelModules=true
+ProtectKernelTunables=true
+ProtectControlGroups=true
+ProtectProc=invisible
+RestrictNamespaces=true
+RestrictFileSystems=
+
+# Hide everything in /proc, even /proc/mounts
+ProcSubset=pid
+
+# Only allow the default personality Linux
+LockPersonality=true
+
+# No writable memory pages
+MemoryDenyWriteExecute=true
+
+# Don't let our mounts leak out to the host
+PrivateMounts=true
+
+# Restrict system calls to the native arch and only enough to get things going
+SystemCallArchitectures=native
+SystemCallFilter=@system-service
+SystemCallFilter=~@privileged
+SystemCallFilter=~@resources
+
+SystemCallFilter=~@clock
+SystemCallFilter=~@cpu-emulation
+SystemCallFilter=~@debug
+SystemCallFilter=~@module
+SystemCallFilter=~@reboot
+SystemCallFilter=~@swap
+
+SystemCallFilter=~@mount
+
+# Leave a breadcrumb if we get whacked by the system call filter
+SystemCallErrorNumber=EL3RST
+
+# Log to the kernel dmesg, just like an in-kernel ext4 driver
+StandardOutput=append:/dev/ttyprintk
+StandardError=append:/dev/ttyprintk
+
+# Run with no capabilities at all
+CapabilityBoundingSet=
+AmbientCapabilities=
+NoNewPrivileges=true
+
+# fuse4fs doesn't create files
+UMask=7777
+
+# No access to hardware /dev files at all
+ProtectClock=true
+DevicePolicy=closed
+
+# Don't mess with set[ug]id anything.
+RestrictSUIDSGID=true
+
+# Don't let OOM kills of processes in this containment group kill the whole
+# service, because we don't want filesystem drivers to go down.
+OOMPolicy=continue
+OOMScoreAdjust=-1000
diff --git a/lib/config.h.in b/lib/config.h.in
index 55e515020af422..dcbbb3a7bf1ac4 100644
--- a/lib/config.h.in
+++ b/lib/config.h.in
@@ -79,6 +79,9 @@
 /* Define to 1 if fuse supports iomap */
 #undef HAVE_FUSE_IOMAP
 
+/* Define to 1 if fuse supports service */
+#undef HAVE_FUSE_SERVICE
+
 /* Define to 1 if you have the Mac OS X function
    CFLocaleCopyPreferredLanguages in the CoreFoundation framework. */
 #undef HAVE_CFLOCALECOPYPREFERREDLANGUAGES
diff --git a/util/subst.conf.in b/util/subst.conf.in
index 5af5e356d46ac7..5fc7cf8f33fa76 100644
--- a/util/subst.conf.in
+++ b/util/subst.conf.in
@@ -24,3 +24,5 @@ root_bindir		@root_bindir@
 libdir			@libdir@
 $exec_prefix		@exec_prefix@
 pkglibexecdir		@libexecdir@/e2fsprogs
+bindir			@bindir@
+fuse_service_socket_dir	@fuse_service_socket_dir@


