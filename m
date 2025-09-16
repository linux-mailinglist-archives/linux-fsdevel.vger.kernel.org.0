Return-Path: <linux-fsdevel+bounces-61593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE974B58A1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86201B23902
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1441C3BE0;
	Tue, 16 Sep 2025 00:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fl9t3LjS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A80D13C8FF;
	Tue, 16 Sep 2025 00:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983871; cv=none; b=b47o0eRjAyvHtjR7xApZIdGbCZcM1V/Bmrb5RXouI++HhMUOHkGm5+xZhA8UUWkZgKKEv+R59KAqCPapdq3fzAwMA3KXy8yCqhHP185hGIr08SnqSO3byhVNAX16XbQajyu1Qi/xLZ9gSI3SpTWxd9keoxIeKF/c1d4UK/2XIVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983871; c=relaxed/simple;
	bh=i4vD5yi/CQRLiFcDtojJ1UbrlEWcTla6RKm2j9fZmYM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Su2KPbtHBVl9RKJMG1Bxd9J8HQzSrf5wHpCJxg2++aRdrzbRzZkWygbcESj3FqZwFt7lagrOfGOZdEdlFftR1hswty7339mWknEgHa3uCyHXOKEj8wIRaAziU0gYd1GA6Q3Ilgejcul38Qrt/Mo41D0wxMeNk1Mz5QiZ4Kuundk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fl9t3LjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C272EC4CEF1;
	Tue, 16 Sep 2025 00:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983870;
	bh=i4vD5yi/CQRLiFcDtojJ1UbrlEWcTla6RKm2j9fZmYM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=fl9t3LjS+Ifvt2HCioIe+6re+WEdgQ/SN0EeHNvjXd9KnkZgMySAqnaex2PHBaCRk
	 GRezWbMyNpIvpjowyztsAabKAOyMa8wsiDWPDax/69R1gSM2l9hzsZSkUgtgT/Ptrr
	 b6UAAiwQSZayMlPawh3N0+Kkkt+1u4BPFdSA5A35RIgkiVDQqIxprd9I5nqHetQDqd
	 e2/B2Kk1tJ+xasoJn/Pal/VktEPkgyyyUj8qe88Y6bA13CrOf057o4Rkp0+8z6jNhU
	 L6T+5s98HoNniIL4joJTlYt4qn3SdB6soxVybCb1n5iV3csDfoH4bAxcGoGkBofnCK
	 PsLes7J0YBc3w==
Date: Mon, 15 Sep 2025 17:51:10 -0700
Subject: [PATCH 02/21] fuse2fs: start porting fuse2fs to lowlevel libfuse API
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, John@groves.net,
 bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175798160810.389252.8733818770141383468.stgit@frogsfrogsfrogs>
In-Reply-To: <175798160681.389252.3813376553626224026.stgit@frogsfrogsfrogs>
References: <175798160681.389252.3813376553626224026.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Copy fuse2fs.c to fuse4fs.c.  This will become our testbed for trying
out lowlevel fuse server support in the next few patches.

Namespacing conversions performed via:
sed -e 's/fuse2fs/fuse4fs/g' -e 's/FUSE2FS/FUSE4FS/g' -e 's/F2OP_/F4OP_/g' -e 's/FUSE server/FUSE low-level server/g'

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 Makefile.in          |    3 
 configure            |  113 +
 configure.ac         |   65 +
 fuse4fs/Makefile.in  |  192 ++
 fuse4fs/fuse4fs.1.in |  118 +
 fuse4fs/fuse4fs.c    | 5516 ++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/config.h.in      |    3 
 7 files changed, 6007 insertions(+), 3 deletions(-)
 create mode 100644 fuse4fs/Makefile.in
 create mode 100644 fuse4fs/fuse4fs.1.in
 create mode 100644 fuse4fs/fuse4fs.c


diff --git a/Makefile.in b/Makefile.in
index 277b500bbc9acc..d000f94bc88f0f 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -18,12 +18,13 @@ MKDIR_P = @MKDIR_P@
 @ALL_CMT@SUPPORT_LIB_SUBDIR= lib/support
 @ALL_CMT@E2P_LIB_SUBDIR= lib/e2p
 @ALL_CMT@EXT2FS_LIB_SUBDIR= lib/ext2fs
+@FUSE4FS_CMT@FUSE4FS_DIR=fuse4fs
 
 LIB_SUBDIRS=lib/et lib/ss $(E2P_LIB_SUBDIR) $(UUID_LIB_SUBDIR) \
 	$(BLKID_LIB_SUBDIR) $(SUPPORT_LIB_SUBDIR) $(EXT2FS_LIB_SUBDIR)
 
 PROG_SUBDIRS=e2fsck $(DEBUGFS_DIR) misc $(RESIZE_DIR) tests/progs \
-	tests/fuzz po $(E2SCRUB_DIR)
+	tests/fuzz po $(E2SCRUB_DIR) $(FUSE4FS_DIR)
 
 SUBDIRS=util $(LIB_SUBDIRS) $(PROG_SUBDIRS) tests
 
diff --git a/configure b/configure
index 22031343f078ab..7f5fb7c1a62084 100755
--- a/configure
+++ b/configure
@@ -701,6 +701,7 @@ gcc_ranlib
 gcc_ar
 UNI_DIFF_OPTS
 SEM_INIT_LIB
+FUSE4FS_CMT
 FUSE2FS_CMT
 FUSE_LIB
 fuse3_LIBS
@@ -933,6 +934,7 @@ with_libintl_prefix
 enable_largefile
 with_libarchive
 enable_fuse2fs
+enable_fuse4fs
 enable_lto
 enable_ubsan
 enable_addrsan
@@ -1628,6 +1630,7 @@ Optional Features:
   --disable-rpath         do not hardcode runtime library paths
   --disable-largefile     omit support for large files
   --disable-fuse2fs       do not build fuse2fs
+  --disable-fuse4fs       do not build fuse4fs
   --enable-lto            enable link time optimization
   --enable-ubsan          enable undefined behavior sanitizer
   --enable-addrsan        enable address sanitizer
@@ -14242,6 +14245,49 @@ printf "%s\n" "#define FUSE_USE_VERSION $FUSE_USE_VERSION" >>confdefs.h
 
 fi
 
+have_fuse_lowlevel=
+if test -n "$FUSE_USE_VERSION"
+then
+	{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for lowlevel interface in libfuse" >&5
+printf %s "checking for lowlevel interface in libfuse... " >&6; }
+	cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+
+	#define _GNU_SOURCE
+	#define _FILE_OFFSET_BITS	64
+	#define FUSE_USE_VERSION	314
+	#include <fuse_lowlevel.h>
+
+int
+main (void)
+{
+
+	struct fuse_lowlevel_ops fs_ops = { };
+
+  ;
+  return 0;
+}
+
+_ACEOF
+if ac_fn_c_try_link "$LINENO"
+then :
+  have_fuse_lowlevel=yes
+	   { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: yes" >&5
+printf "%s\n" "yes" >&6; }
+else $as_nop
+  { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: no" >&5
+printf "%s\n" "no" >&6; }
+fi
+rm -f core conftest.err conftest.$ac_objext conftest.beam \
+    conftest$ac_exeext conftest.$ac_ext
+fi
+if test -n "$have_fuse_lowlevel"
+then
+
+printf "%s\n" "#define HAVE_FUSE_LOWLEVEL 1" >>confdefs.h
+
+fi
+
 FUSE2FS_CMT=
 # Check whether --enable-fuse2fs was given.
 if test ${enable_fuse2fs+y}
@@ -14307,6 +14353,71 @@ fi
 
 
 
+FUSE4FS_CMT=
+# Check whether --enable-fuse4fs was given.
+if test ${enable_fuse4fs+y}
+then :
+  enableval=$enable_fuse4fs;
+	if test "$enableval" = "no"
+	then
+		FUSE4FS_CMT="#"
+		{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: Disabling fuse4fs" >&5
+printf "%s\n" "Disabling fuse4fs" >&6; }
+	else
+		cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+#ifdef __linux__
+	#include <linux/fs.h>
+	#include <linux/falloc.h>
+	#include <linux/xattr.h>
+	#endif
+
+int
+main (void)
+{
+
+  ;
+  return 0;
+}
+_ACEOF
+if ac_fn_c_try_cpp "$LINENO"
+then :
+
+else $as_nop
+  { { printf "%s\n" "$as_me:${as_lineno-$LINENO}: error: in \`$ac_pwd':" >&5
+printf "%s\n" "$as_me: error: in \`$ac_pwd':" >&2;}
+as_fn_error $? "Cannot find fuse4fs Linux headers
+See \`config.log' for more details" "$LINENO" 5; }
+fi
+rm -f conftest.err conftest.i conftest.$ac_ext
+
+		if test -z "$have_fuse_lowlevel"
+		then
+			{ { printf "%s\n" "$as_me:${as_lineno-$LINENO}: error: in \`$ac_pwd':" >&5
+printf "%s\n" "$as_me: error: in \`$ac_pwd':" >&2;}
+as_fn_error $? "Cannot find fuse lowlevel library.
+See \`config.log' for more details" "$LINENO" 5; }
+		fi
+		{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: Enabling fuse4fs" >&5
+printf "%s\n" "Enabling fuse4fs" >&6; }
+	fi
+
+else $as_nop
+
+	if test -n "$have_fuse_lowlevel"
+	then
+		{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: Enabling fuse4fs by default" >&5
+printf "%s\n" "Enabling fuse4fs by default" >&6; }
+	else
+		{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: Disabling fuse4fs by default" >&5
+printf "%s\n" "Disabling fuse4fs by default" >&6; }
+	fi
+
+
+fi
+
+
+
 { printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for PR_SET_IO_FLUSHER" >&5
 printf %s "checking for PR_SET_IO_FLUSHER... " >&6; }
 cat confdefs.h - <<_ACEOF >conftest.$ac_ext
@@ -15984,7 +16095,7 @@ for i in MCONFIG Makefile \
 	misc/Makefile ext2ed/Makefile e2fsck/Makefile \
 	debugfs/Makefile tests/Makefile tests/progs/Makefile \
 	tests/fuzz/Makefile resize/Makefile doc/Makefile \
-	po/Makefile.in scrub/Makefile; do
+	po/Makefile.in scrub/Makefile fuse4fs/Makefile; do
 	if test -d `dirname ${srcdir}/$i` ; then
 		outlist="$outlist $i"
 	fi
diff --git a/configure.ac b/configure.ac
index b40ed1456d1515..2eb11873ea0e50 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1398,6 +1398,32 @@ then
 		[Define to the version of FUSE to use])
 fi
 
+dnl
+dnl Check if the FUSE lowlevel library is supported
+dnl
+have_fuse_lowlevel=
+if test -n "$FUSE_USE_VERSION"
+then
+	AC_MSG_CHECKING(for lowlevel interface in libfuse)
+	AC_LINK_IFELSE(
+	[	AC_LANG_PROGRAM([[
+	#define _GNU_SOURCE
+	#define _FILE_OFFSET_BITS	64
+	#define FUSE_USE_VERSION	314
+	#include <fuse_lowlevel.h>
+		]], [[
+	struct fuse_lowlevel_ops fs_ops = { };
+		]])
+	], have_fuse_lowlevel=yes
+	   AC_MSG_RESULT(yes),
+	   AC_MSG_RESULT(no))
+fi
+if test -n "$have_fuse_lowlevel"
+then
+	AC_DEFINE(HAVE_FUSE_LOWLEVEL, 1,
+		  [Define to 1 if fuse supports lowlevel API])
+fi
+
 dnl
 dnl Check if fuse2fs is actually built.
 dnl
@@ -1435,6 +1461,43 @@ AS_HELP_STRING([--disable-fuse2fs],[do not build fuse2fs]),
 )
 AC_SUBST(FUSE2FS_CMT)
 
+dnl
+dnl Check if fuse4fs is actually built.
+dnl
+FUSE4FS_CMT=
+AC_ARG_ENABLE([fuse4fs],
+AS_HELP_STRING([--disable-fuse4fs],[do not build fuse4fs]),
+[
+	if test "$enableval" = "no"
+	then
+		FUSE4FS_CMT="#"
+		AC_MSG_RESULT([Disabling fuse4fs])
+	else
+		AC_PREPROC_IFELSE(
+	[AC_LANG_PROGRAM([[#ifdef __linux__
+	#include <linux/fs.h>
+	#include <linux/falloc.h>
+	#include <linux/xattr.h>
+	#endif
+	]], [])], [], [AC_MSG_FAILURE([Cannot find fuse4fs Linux headers])])
+
+		if test -z "$have_fuse_lowlevel"
+		then
+			AC_MSG_FAILURE([Cannot find fuse lowlevel library.])
+		fi
+		AC_MSG_RESULT([Enabling fuse4fs])
+	fi
+], [
+	if test -n "$have_fuse_lowlevel"
+	then
+		AC_MSG_RESULT([Enabling fuse4fs by default])
+	else
+		AC_MSG_RESULT([Disabling fuse4fs by default])
+	fi
+]
+)
+AC_SUBST(FUSE4FS_CMT)
+
 dnl
 dnl see if PR_SET_IO_FLUSHER exists
 dnl
@@ -2042,7 +2105,7 @@ for i in MCONFIG Makefile \
 	misc/Makefile ext2ed/Makefile e2fsck/Makefile \
 	debugfs/Makefile tests/Makefile tests/progs/Makefile \
 	tests/fuzz/Makefile resize/Makefile doc/Makefile \
-	po/Makefile.in scrub/Makefile; do
+	po/Makefile.in scrub/Makefile fuse4fs/Makefile; do
 	if test -d `dirname ${srcdir}/$i` ; then
 		outlist="$outlist $i"
 	fi
diff --git a/fuse4fs/Makefile.in b/fuse4fs/Makefile.in
new file mode 100644
index 00000000000000..bc137a765ee2b7
--- /dev/null
+++ b/fuse4fs/Makefile.in
@@ -0,0 +1,192 @@
+#
+# Standard e2fsprogs prologue....
+#
+
+srcdir = @srcdir@
+top_srcdir = @top_srcdir@
+VPATH = @srcdir@
+top_builddir = ..
+my_dir = misc
+INSTALL = @INSTALL@
+MKDIR_P = @MKDIR_P@
+
+@MCONFIG@
+
+UPROGS=
+UMANPAGES=
+@FUSE4FS_CMT@UPROGS+=fuse4fs
+@FUSE4FS_CMT@UMANPAGES+=fuse4fs.1
+
+FUSE4FS_OBJS=	fuse4fs.o journal.o recovery.o revoke.o
+
+PROFILED_FUSE4FS_OJBS=	profiled/fuse4fs.o profiled/journal.o \
+			profiled/recovery.o profiled/revoke.o
+
+SRCS=\
+	$(srcdir)/fuse4fs.c \
+	$(srcdir)/../debugfs/journal.c \
+	$(srcdir)/../e2fsck/revoke.c \
+	$(srcdir)/../e2fsck/recovery.c
+
+LIBS= $(LIBEXT2FS) $(LIBCOM_ERR) $(LIBSUPPORT)
+DEPLIBS= $(LIBEXT2FS) $(DEPLIBCOM_ERR) $(DEPLIBSUPPORT)
+PROFILED_LIBS= $(LIBSUPPORT) $(PROFILED_LIBEXT2FS) $(PROFILED_LIBCOM_ERR)
+PROFILED_DEPLIBS= $(DEPLIBSUPPORT) $(PROFILED_LIBEXT2FS) $(DEPPROFILED_LIBCOM_ERR)
+
+STATIC_LIBS= $(LIBSUPPORT) $(STATIC_LIBEXT2FS) $(STATIC_LIBCOM_ERR)
+STATIC_DEPLIBS= $(DEPLIBSUPPORT) $(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBCOM_ERR)
+
+LIBS_E2P= $(LIBE2P) $(LIBCOM_ERR)
+DEPLIBS_E2P= $(LIBE2P) $(DEPLIBCOM_ERR)
+
+COMPILE_ET=	_ET_DIR_OVERRIDE=$(srcdir)/../lib/et/et ../lib/et/compile_et
+
+# This nastiness is needed because of jfs_user.h hackery; when we finally
+# clean up this mess, we should be able to drop it
+JOURNAL_CFLAGS = -I$(srcdir)/../e2fsck $(ALL_CFLAGS) -DDEBUGFS
+DEPEND_CFLAGS = -I$(top_srcdir)/e2fsck
+
+.c.o:
+	$(E) "	CC $<"
+	$(Q) $(CC) -c $(ALL_CFLAGS) $< -o $@
+	$(Q) $(CHECK_CMD) $(ALL_CFLAGS) $<
+	$(Q) $(CPPCHECK_CMD) $(CPPFLAGS) $<
+@PROFILE_CMT@	$(Q) $(CC) $(ALL_CFLAGS) -g -pg -o profiled/$*.o -c $<
+
+all:: profiled $(SPROGS) $(UPROGS) $(USPROGS) $(SMANPAGES) $(UMANPAGES) \
+	$(FMANPAGES) $(LPROGS)
+
+all-static::
+
+@PROFILE_CMT@all:: fuse4fs.profiled
+
+profiled:
+@PROFILE_CMT@	$(E) "	MKDIR $@"
+@PROFILE_CMT@	$(Q) mkdir profiled
+
+fuse4fs: $(FUSE4FS_OBJS) $(DEPLIBS) $(DEPLIBBLKID) $(DEPLIBUUID) \
+		$(LIBEXT2FS) $(DEPLIBS_E2P)
+	$(E) "	LD $@"
+	$(Q) $(CC) $(ALL_LDFLAGS) -o fuse4fs $(FUSE4FS_OBJS) $(LIBS) \
+		$(LIBFUSE) $(LIBBLKID) $(LIBUUID) $(LIBEXT2FS) $(LIBINTL) \
+		$(CLOCK_GETTIME_LIB) $(SYSLIBS) $(LIBS_E2P)
+
+journal.o: $(srcdir)/../debugfs/journal.c
+	$(E) "	CC $<"
+	$(Q) $(CC) -c $(JOURNAL_CFLAGS) -I$(srcdir) \
+		$(srcdir)/../debugfs/journal.c -o $@
+@PROFILE_CMT@	$(Q) $(CC) $(JOURNAL_CFLAGS) -g -pg -o profiled/$*.o -c $<
+
+recovery.o: $(srcdir)/../e2fsck/recovery.c
+	$(E) "	CC $<"
+	$(Q) $(CC) -c $(JOURNAL_CFLAGS) -I$(srcdir) \
+		$(srcdir)/../e2fsck/recovery.c -o $@
+@PROFILE_CMT@	$(Q) $(CC) $(JOURNAL_CFLAGS) -g -pg -o profiled/$*.o -c $<
+
+revoke.o: $(srcdir)/../e2fsck/revoke.c
+	$(E) "	CC $<"
+	$(Q) $(CC) -c $(JOURNAL_CFLAGS) -I$(srcdir) \
+		$(srcdir)/../e2fsck/revoke.c -o $@
+@PROFILE_CMT@	$(Q) $(CC) $(JOURNAL_CFLAGS) -g -pg -o profiled/$*.o -c $<
+
+fuse4fs.1: $(DEP_SUBSTITUTE) $(srcdir)/fuse4fs.1.in
+	$(E) "	SUBST $@"
+	$(Q) $(SUBSTITUTE_UPTIME) $(srcdir)/fuse4fs.1.in fuse4fs.1
+
+installdirs:
+	$(E) "	MKDIR_P $(bindir) $(man1dir)"
+	$(Q) $(MKDIR_P) $(DESTDIR)$(bindir) $(DESTDIR)$(man1dir)
+
+install: all $(UMANPAGES) installdirs
+	$(Q) for i in $(UPROGS); do \
+		$(ES) "	INSTALL $(bindir)/$$i"; \
+		$(INSTALL_PROGRAM) $$i $(DESTDIR)$(bindir)/$$i; \
+	done
+	$(Q) for i in $(UMANPAGES); do \
+		for j in $(COMPRESS_EXT); do \
+			$(RM) -f $(DESTDIR)$(man1dir)/$$i.$$j; \
+		done; \
+		$(ES) "	INSTALL_DATA $(man1dir)/$$i"; \
+		$(INSTALL_DATA) $$i $(DESTDIR)$(man1dir)/$$i; \
+	done
+
+install-strip: install
+	$(Q) for i in $(UPROGS); do \
+		$(E) "	STRIP $(bindir)/$$i"; \
+		$(STRIP) $(DESTDIR)$(bindir)/$$i; \
+	done
+
+uninstall:
+	for i in $(UPROGS); do \
+		$(RM) -f $(DESTDIR)$(bindir)/$$i; \
+	done
+	for i in $(UMANPAGES); do \
+		$(RM) -f $(DESTDIR)$(man1dir)/$$i; \
+	done
+
+clean::
+	$(RM) -f $(UPROGS) $(UMANPAGES) profile.h \
+		fuse4fs.profiled \
+		profiled/*.o \#* *.s *.o *.a *~ core gmon.out
+
+mostlyclean: clean
+distclean: clean
+	$(RM) -f .depend Makefile $(srcdir)/TAGS $(srcdir)/Makefile.in.old
+
+# +++ Dependency line eater +++
+#
+# Makefile dependencies follow.  This must be the last section in
+# the Makefile.in file
+#
+fuse4fs.o: $(srcdir)/fuse4fs.c $(top_builddir)/lib/config.h \
+ $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
+ $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
+ $(top_srcdir)/lib/ext2fs/ext3_extents.h $(top_srcdir)/lib/et/com_err.h \
+ $(top_srcdir)/lib/ext2fs/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
+ $(top_srcdir)/lib/ext2fs/ext2_ext_attr.h $(top_srcdir)/lib/ext2fs/hashmap.h \
+ $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/ext2fs/ext2fsP.h \
+ $(top_srcdir)/lib/ext2fs/ext2fs.h $(top_srcdir)/version.h \
+ $(top_srcdir)/lib/e2p/e2p.h
+journal.o: $(srcdir)/../debugfs/journal.c $(top_builddir)/lib/config.h \
+ $(top_builddir)/lib/dirpaths.h $(srcdir)/../debugfs/journal.h \
+ $(top_srcdir)/e2fsck/jfs_user.h $(top_srcdir)/e2fsck/e2fsck.h \
+ $(top_srcdir)/lib/ext2fs/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
+ $(top_srcdir)/lib/ext2fs/ext2fs.h $(top_srcdir)/lib/ext2fs/ext3_extents.h \
+ $(top_srcdir)/lib/et/com_err.h $(top_srcdir)/lib/ext2fs/ext2_io.h \
+ $(top_builddir)/lib/ext2fs/ext2_err.h \
+ $(top_srcdir)/lib/ext2fs/ext2_ext_attr.h $(top_srcdir)/lib/ext2fs/hashmap.h \
+ $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/support/profile.h \
+ $(top_builddir)/lib/support/prof_err.h $(top_srcdir)/lib/support/quotaio.h \
+ $(top_srcdir)/lib/support/dqblk_v2.h \
+ $(top_srcdir)/lib/support/quotaio_tree.h \
+ $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
+ $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/ext2fs/kernel-jbd.h
+revoke.o: $(srcdir)/../e2fsck/revoke.c $(srcdir)/../e2fsck/jfs_user.h \
+ $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
+ $(srcdir)/../e2fsck/e2fsck.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
+ $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
+ $(top_srcdir)/lib/ext2fs/ext3_extents.h $(top_srcdir)/lib/et/com_err.h \
+ $(top_srcdir)/lib/ext2fs/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
+ $(top_srcdir)/lib/ext2fs/ext2_ext_attr.h $(top_srcdir)/lib/ext2fs/hashmap.h \
+ $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/support/profile.h \
+ $(top_builddir)/lib/support/prof_err.h $(top_srcdir)/lib/support/quotaio.h \
+ $(top_srcdir)/lib/support/dqblk_v2.h \
+ $(top_srcdir)/lib/support/quotaio_tree.h \
+ $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
+ $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/ext2fs/kernel-jbd.h
+recovery.o: $(srcdir)/../e2fsck/recovery.c $(srcdir)/../e2fsck/jfs_user.h \
+ $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
+ $(srcdir)/../e2fsck/e2fsck.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
+ $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
+ $(top_srcdir)/lib/ext2fs/ext3_extents.h $(top_srcdir)/lib/et/com_err.h \
+ $(top_srcdir)/lib/ext2fs/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
+ $(top_srcdir)/lib/ext2fs/ext2_ext_attr.h $(top_srcdir)/lib/ext2fs/hashmap.h \
+ $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/support/profile.h \
+ $(top_builddir)/lib/support/prof_err.h $(top_srcdir)/lib/support/quotaio.h \
+ $(top_srcdir)/lib/support/dqblk_v2.h \
+ $(top_srcdir)/lib/support/quotaio_tree.h \
+ $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
+ $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/ext2fs/kernel-jbd.h
diff --git a/fuse4fs/fuse4fs.1.in b/fuse4fs/fuse4fs.1.in
new file mode 100644
index 00000000000000..8bef5f48802385
--- /dev/null
+++ b/fuse4fs/fuse4fs.1.in
@@ -0,0 +1,118 @@
+.\" -*- nroff -*-
+.\" Copyright 2025 Oracle.  All Rights Reserved.
+.\" This file may be copied under the terms of the GNU Public License.
+.\"
+.TH FUSE4FS 1 "@E2FSPROGS_MONTH@ @E2FSPROGS_YEAR@" "E2fsprogs version @E2FSPROGS_VERSION@"
+.SH NAME
+fuse4fs \- FUSE file system client for ext2/ext3/ext4 file systems
+.SH SYNOPSIS
+.B fuse4fs
+[
+.B device/image
+]
+[
+.B mountpoint
+]
+[
+.I options
+]
+.SH DESCRIPTION
+.B fuse4fs
+is a FUSE file system client that supports reading and writing from
+devices or image files containing ext2, ext3, and ext4 file systems.
+.SH OPTIONS
+.SS "general options:"
+.TP
+\fB\-o\fR opt,[opt...]
+mount options
+.TP
+\fB\-h\fR   \fB\-\-help\fR
+print help
+.TP
+\fB\-V\fR   \fB\-\-version\fR
+print version
+.SS "fuse4fs options:"
+.TP
+\fB-o\fR ro
+read-only mount
+.TP
+\fB-o\fR rw
+read-write mount (default)
+.TP
+\fB-o\fR bsddf
+bsd-style df (default)
+.TP
+\fB-o\fR minixdf
+minix-style df
+.TP
+\fB-o\fR acl
+enable file access control lists
+.TP
+\fB-o\fR cache_size
+Set the disk cache size to this quantity.
+The quantity may contain the suffixes k, m, or g.
+By default, the size is 32MB.
+The size may not be larger than 2GB.
+.TP
+\fB-o\fR direct
+Use O_DIRECT to access the block device.
+.TP
+\fB-o\fR dirsync
+Flush dirty metadata to disk after every directory update.
+.TP
+\fB-o\fR errors=continue
+ignore errors
+.TP
+\fB-o\fR errors=remount-ro
+stop allowing writes after errors
+.TP
+\fB-o\fR errors=panic
+dump core on error
+.TP
+\fB-o\fR fakeroot
+pretend to be root for permission checks
+.TP
+\fB-o\fR fuse4fs_debug
+enable fuse4fs debugging
+.TP
+\fB-o\fR kernel
+Behave more like the kernel ext4 driver in the following ways:
+Allows processes owned by other users to access the filesystem.
+Uses the kernel's permissions checking logic instead of fuse4fs's.
+Enables setuid and device files.
+Note that these options can still be overridden (e.g.
+.I nosuid
+) later.
+.TP
+\fB-o\fR lockfile=path
+use this file to control access to the filesystem
+.TP
+\fB-o\fR no_default_opts
+do not include default fuse options
+.TP
+\fB-o\fR norecovery
+do not replay the journal and mount the file system read-only
+.SS "FUSE options:"
+.TP
+\fB-d -o\fR debug
+enable debug output (implies -f)
+.TP
+\fB-f\fR
+foreground operation
+.TP
+\fB-s\fR
+disable multi-threaded operation
+.P
+For other FUSE options please see
+.BR mount.fuse (8)
+or see the output of
+.I fuse4fs \-\-helpfull
+.SH AVAILABILITY
+.B fuse4fs
+is part of the e2fsprogs package and is available from
+http://e2fsprogs.sourceforge.net.
+.SH SEE ALSO
+.BR ext4 (5)
+.BR e2fsck (8),
+.BR mount.fuse (8)
+
diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
new file mode 100644
index 00000000000000..99b9b902b37a57
--- /dev/null
+++ b/fuse4fs/fuse4fs.c
@@ -0,0 +1,5516 @@
+/*
+ * fuse4fs.c - FUSE low-level server for e2fsprogs.
+ *
+ * Copyright (C) 2014-2025 Oracle.
+ *
+ * %Begin-Header%
+ * This file may be redistributed under the terms of the GNU Public
+ * License.
+ * %End-Header%
+ */
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include "config.h"
+#include <pthread.h>
+#ifdef __linux__
+# include <linux/fs.h>
+# include <linux/falloc.h>
+# include <linux/xattr.h>
+# include <sys/prctl.h>
+#endif
+#ifdef HAVE_SYS_XATTR_H
+#include <sys/xattr.h>
+#endif
+#include <sys/ioctl.h>
+#include <unistd.h>
+#include <ctype.h>
+#include <stdbool.h>
+#define FUSE_DARWIN_ENABLE_EXTENSIONS 0
+#ifdef __SET_FOB_FOR_FUSE
+# error Do not set magic value __SET_FOB_FOR_FUSE!!!!
+#endif
+#ifndef _FILE_OFFSET_BITS
+/*
+ * Old versions of libfuse (e.g. Debian 2.9.9 package) required that the build
+ * system set _FILE_OFFSET_BITS explicitly, even if doing so isn't required to
+ * get a 64-bit off_t.  AC_SYS_LARGEFILE doesn't set any _FILE_OFFSET_BITS if
+ * it's not required (such as on aarch64), so we must inject it here.
+ */
+# define __SET_FOB_FOR_FUSE
+# define _FILE_OFFSET_BITS 64
+#endif /* _FILE_OFFSET_BITS */
+#include <fuse.h>
+#ifdef __SET_FOB_FOR_FUSE
+# undef _FILE_OFFSET_BITS
+#endif /* __SET_FOB_FOR_FUSE */
+#include <inttypes.h>
+#include "ext2fs/ext2fs.h"
+#include "ext2fs/ext2_fs.h"
+#include "ext2fs/ext2fsP.h"
+
+#include "../version.h"
+#include "uuid/uuid.h"
+#include "e2p/e2p.h"
+
+#ifdef ENABLE_NLS
+#include <libintl.h>
+#include <locale.h>
+#define _(a) (gettext(a))
+#ifdef gettext_noop
+#define N_(a) gettext_noop(a)
+#else
+#define N_(a) (a)
+#endif
+#define P_(singular, plural, n) (ngettext(singular, plural, n))
+#ifndef NLS_CAT_NAME
+#define NLS_CAT_NAME "e2fsprogs"
+#endif
+#ifndef LOCALEDIR
+#define LOCALEDIR "/usr/share/locale"
+#endif
+#else
+#define _(a) (a)
+#define N_(a) a
+#define P_(singular, plural, n) ((n) == 1 ? (singular) : (plural))
+#endif
+
+#ifndef XATTR_NAME_POSIX_ACL_DEFAULT
+#define XATTR_NAME_POSIX_ACL_DEFAULT "posix_acl_default"
+#endif
+#ifndef XATTR_SECURITY_PREFIX
+#define XATTR_SECURITY_PREFIX "security."
+#define XATTR_SECURITY_PREFIX_LEN (sizeof (XATTR_SECURITY_PREFIX) - 1)
+#endif
+
+/*
+ * Linux and MacOS implement the setxattr(2) interface, which defines
+ * XATTR_CREATE and XATTR_REPLACE.  However, FreeBSD uses
+ * extattr_set_file(2), which does not have a flags or options
+ * parameter, and does not define XATTR_CREATE and XATTR_REPLACE.
+ */
+#ifndef XATTR_CREATE
+#define XATTR_CREATE 0
+#endif
+
+#ifndef XATTR_REPLACE
+#define XATTR_REPLACE 0
+#endif
+
+#if !defined(EUCLEAN)
+#if !defined(EBADMSG)
+#define EUCLEAN EBADMSG
+#elif !defined(EPROTO)
+#define EUCLEAN EPROTO
+#else
+#define EUCLEAN EIO
+#endif
+#endif /* !defined(EUCLEAN) */
+
+#if !defined(ENODATA)
+#ifdef ENOATTR
+#define ENODATA ENOATTR
+#else
+#define ENODATA ENOENT
+#endif
+#endif /* !defined(ENODATA) */
+
+static inline uint64_t round_up(uint64_t b, unsigned int align)
+{
+	unsigned int m;
+
+	if (align == 0)
+		return b;
+	m = b % align;
+	if (m)
+		b += align - m;
+	return b;
+}
+
+static inline uint64_t round_down(uint64_t b, unsigned int align)
+{
+	unsigned int m;
+
+	if (align == 0)
+		return b;
+	m = b % align;
+	return b - m;
+}
+
+#define dbg_printf(fuse4fs, format, ...) \
+	while ((fuse4fs)->debug) { \
+		printf("FUSE4FS (%s): tid=%d " format, (fuse4fs)->shortdev, gettid(), ##__VA_ARGS__); \
+		fflush(stdout); \
+		break; \
+	}
+
+#define log_printf(fuse4fs, format, ...) \
+	do { \
+		printf("FUSE4FS (%s): " format, (fuse4fs)->shortdev, ##__VA_ARGS__); \
+		fflush(stdout); \
+	} while (0)
+
+#define err_printf(fuse4fs, format, ...) \
+	do { \
+		fprintf(stderr, "FUSE4FS (%s): " format, (fuse4fs)->shortdev, ##__VA_ARGS__); \
+		fflush(stderr); \
+	} while (0)
+
+#define timing_printf(fuse4fs, format, ...) \
+	while ((fuse4fs)->timing) { \
+		printf("FUSE4FS (%s): " format, (fuse4fs)->shortdev, ##__VA_ARGS__); \
+		break; \
+	}
+
+#ifdef _IOR
+# ifdef _IOW
+#  define SUPPORT_I_FLAGS
+# endif
+#endif
+
+#ifdef FALLOC_FL_KEEP_SIZE
+# define FL_KEEP_SIZE_FLAG FALLOC_FL_KEEP_SIZE
+# define SUPPORT_FALLOCATE
+#else
+# define FL_KEEP_SIZE_FLAG (0)
+#endif
+
+#ifdef FALLOC_FL_PUNCH_HOLE
+# define FL_PUNCH_HOLE_FLAG FALLOC_FL_PUNCH_HOLE
+#else
+# define FL_PUNCH_HOLE_FLAG (0)
+#endif
+
+#ifdef FALLOC_FL_ZERO_RANGE
+# define FL_ZERO_RANGE_FLAG FALLOC_FL_ZERO_RANGE
+#else
+# define FL_ZERO_RANGE_FLAG (0)
+#endif
+
+errcode_t ext2fs_run_ext3_journal(ext2_filsys *fs);
+
+const char *err_shortdev;
+
+#ifdef CONFIG_JBD_DEBUG		/* Enabled by configure --enable-jbd-debug */
+int journal_enable_debug = -1;
+#endif
+
+/*
+ * ext2_file_t contains a struct inode, so we can't leave files open.
+ * Use this as a proxy instead.
+ */
+#define FUSE4FS_FILE_MAGIC	(0xEF53DEAFUL)
+struct fuse4fs_file_handle {
+	unsigned long magic;
+	ext2_ino_t ino;
+	int open_flags;
+	int check_flags;
+};
+
+enum fuse4fs_opstate {
+	F4OP_READONLY,
+	F4OP_WRITABLE,
+	F4OP_SHUTDOWN,
+};
+
+/* Main program context */
+#define FUSE4FS_MAGIC		(0xEF53DEADUL)
+struct fuse4fs {
+	unsigned long magic;
+	ext2_filsys fs;
+	pthread_mutex_t bfl;
+	char *device;
+	char *shortdev;
+
+	/* options set by fuse_opt_parse must be of type int */
+	int ro;
+	int debug;
+	int no_default_opts;
+	int errors_behavior; /* actually an enum */
+	int minixdf;
+	int fakeroot;
+	int alloc_all_blocks;
+	int norecovery;
+	int kernel;
+	int directio;
+	int acl;
+	int dirsync;
+	int unmount_in_destroy;
+	int noblkdev;
+
+	enum fuse4fs_opstate opstate;
+	int logfd;
+	int blocklog;
+	unsigned int blockmask;
+	unsigned long offset;
+	unsigned int next_generation;
+	unsigned long long cache_size;
+	char *lockfile;
+#ifdef HAVE_CLOCK_MONOTONIC
+	struct timespec lock_start_time;
+	struct timespec op_start_time;
+
+	/* options set by fuse_opt_parse must be of type int */
+	int timing;
+#endif
+};
+
+#define FUSE4FS_CHECK_HANDLE(ff, fh) \
+	do { \
+		if ((fh) == NULL || (fh)->magic != FUSE4FS_FILE_MAGIC) { \
+			fprintf(stderr, \
+				"FUSE4FS: Corrupt in-memory file handle at %s:%d!\n", \
+				__func__, __LINE__); \
+			fflush(stderr); \
+			return -EUCLEAN; \
+		} \
+	} while (0)
+
+#define __FUSE4FS_CHECK_CONTEXT(ff, retcode, shutcode) \
+	do { \
+		if ((ff) == NULL || (ff)->magic != FUSE4FS_MAGIC) { \
+			fprintf(stderr, \
+				"FUSE4FS: Corrupt in-memory data at %s:%d!\n", \
+				__func__, __LINE__); \
+			fflush(stderr); \
+			retcode; \
+		} \
+		if ((ff)->opstate == F4OP_SHUTDOWN) { \
+			shutcode; \
+		} \
+	} while (0)
+
+#define FUSE4FS_CHECK_CONTEXT(ff) \
+	__FUSE4FS_CHECK_CONTEXT((ff), return -EUCLEAN, return -EIO)
+#define FUSE4FS_CHECK_CONTEXT_RETURN(ff) \
+	__FUSE4FS_CHECK_CONTEXT((ff), return, return)
+#define FUSE4FS_CHECK_CONTEXT_ABORT(ff) \
+	__FUSE4FS_CHECK_CONTEXT((ff), abort(), abort())
+
+static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
+			     const char *func, int line);
+#define translate_error(fs, ino, err) __translate_error((fs), (ino), (err), \
+			__func__, __LINE__)
+
+/* for macosx */
+#ifndef W_OK
+#  define W_OK 2
+#endif
+
+#ifndef R_OK
+#  define R_OK 4
+#endif
+
+static inline int u_log2(unsigned int arg)
+{
+	int	l = 0;
+
+	arg >>= 1;
+	while (arg) {
+		l++;
+		arg >>= 1;
+	}
+	return l;
+}
+
+static inline blk64_t FUSE4FS_B_TO_FSBT(const struct fuse4fs *ff, off_t pos)
+{
+	return pos >> ff->blocklog;
+}
+
+static inline blk64_t FUSE4FS_B_TO_FSB(const struct fuse4fs *ff, off_t pos)
+{
+	return (pos + ff->blockmask) >> ff->blocklog;
+}
+
+static inline unsigned int FUSE4FS_OFF_IN_FSB(const struct fuse4fs *ff,
+					      off_t pos)
+{
+	return pos & ff->blockmask;
+}
+
+static inline off_t FUSE4FS_FSB_TO_B(const struct fuse4fs *ff, blk64_t bno)
+{
+	return bno << ff->blocklog;
+}
+
+#define EXT4_EPOCH_BITS 2
+#define EXT4_EPOCH_MASK ((1 << EXT4_EPOCH_BITS) - 1)
+#define EXT4_NSEC_MASK  (~0UL << EXT4_EPOCH_BITS)
+
+/*
+ * Extended fields will fit into an inode if the filesystem was formatted
+ * with large inodes (-I 256 or larger) and there are not currently any EAs
+ * consuming all of the available space. For new inodes we always reserve
+ * enough space for the kernel's known extended fields, but for inodes
+ * created with an old kernel this might not have been the case. None of
+ * the extended inode fields is critical for correct filesystem operation.
+ * This macro checks if a certain field fits in the inode. Note that
+ * inode-size = GOOD_OLD_INODE_SIZE + i_extra_isize
+ */
+#define EXT4_FITS_IN_INODE(ext4_inode, field)		\
+	((offsetof(typeof(*ext4_inode), field) +	\
+	  sizeof((ext4_inode)->field))			\
+	 <= ((size_t) EXT2_GOOD_OLD_INODE_SIZE +		\
+	    (ext4_inode)->i_extra_isize))		\
+
+static inline __u32 ext4_encode_extra_time(const struct timespec *time)
+{
+	__u32 extra = sizeof(time->tv_sec) > 4 ?
+			((time->tv_sec - (__s32)time->tv_sec) >> 32) &
+			EXT4_EPOCH_MASK : 0;
+	return extra | (time->tv_nsec << EXT4_EPOCH_BITS);
+}
+
+static inline void ext4_decode_extra_time(struct timespec *time, __u32 extra)
+{
+	if (sizeof(time->tv_sec) > 4 && (extra & EXT4_EPOCH_MASK)) {
+		__u64 extra_bits = extra & EXT4_EPOCH_MASK;
+		/*
+		 * Prior to kernel 3.14?, we had a broken decode function,
+		 * wherein we effectively did this:
+		 * if (extra_bits == 3)
+		 *     extra_bits = 0;
+		 */
+		time->tv_sec += extra_bits << 32;
+	}
+	time->tv_nsec = ((extra) & EXT4_NSEC_MASK) >> EXT4_EPOCH_BITS;
+}
+
+#define EXT4_CLAMP_TIMESTAMP(xtime, timespec, raw_inode)		       \
+do {									       \
+	if ((timespec)->tv_sec < EXT4_TIMESTAMP_MIN)			       \
+		(timespec)->tv_sec = EXT4_TIMESTAMP_MIN;		       \
+	if ((timespec)->tv_sec < EXT4_TIMESTAMP_MIN)			       \
+		(timespec)->tv_sec = EXT4_TIMESTAMP_MIN;		       \
+									       \
+	if (EXT4_FITS_IN_INODE(raw_inode, xtime ## _extra)) {		       \
+		if ((timespec)->tv_sec > EXT4_EXTRA_TIMESTAMP_MAX)	       \
+			(timespec)->tv_sec = EXT4_EXTRA_TIMESTAMP_MAX;	       \
+	} else {							       \
+		if ((timespec)->tv_sec > EXT4_NON_EXTRA_TIMESTAMP_MAX)	       \
+			(timespec)->tv_sec = EXT4_NON_EXTRA_TIMESTAMP_MAX;     \
+	}								       \
+} while (0)
+
+#define EXT4_INODE_SET_XTIME(xtime, timespec, raw_inode)		       \
+do {									       \
+	typeof(*(timespec)) _ts = *(timespec);				       \
+									       \
+	EXT4_CLAMP_TIMESTAMP(xtime, &_ts, raw_inode);			       \
+	(raw_inode)->xtime = _ts.tv_sec;				       \
+	if (EXT4_FITS_IN_INODE(raw_inode, xtime ## _extra))		       \
+		(raw_inode)->xtime ## _extra =				       \
+				ext4_encode_extra_time(&_ts);		       \
+} while (0)
+
+#define EXT4_EINODE_SET_XTIME(xtime, timespec, raw_inode)		       \
+do {									       \
+	typeof(*(timespec)) _ts = *(timespec);				       \
+									       \
+	EXT4_CLAMP_TIMESTAMP(xtime, &_ts, raw_inode);			       \
+	if (EXT4_FITS_IN_INODE(raw_inode, xtime))			       \
+		(raw_inode)->xtime = _ts.tv_sec;			       \
+	if (EXT4_FITS_IN_INODE(raw_inode, xtime ## _extra))		       \
+		(raw_inode)->xtime ## _extra =				       \
+				ext4_encode_extra_time(&_ts);		       \
+} while (0)
+
+#define EXT4_INODE_GET_XTIME(xtime, timespec, raw_inode)		       \
+do {									       \
+	(timespec)->tv_sec = (signed)((raw_inode)->xtime);		       \
+	if (EXT4_FITS_IN_INODE(raw_inode, xtime ## _extra))		       \
+		ext4_decode_extra_time((timespec),			       \
+				       (raw_inode)->xtime ## _extra);	       \
+	else								       \
+		(timespec)->tv_nsec = 0;				       \
+} while (0)
+
+#define EXT4_EINODE_GET_XTIME(xtime, timespec, raw_inode)		       \
+do {									       \
+	if (EXT4_FITS_IN_INODE(raw_inode, xtime))			       \
+		(timespec)->tv_sec =					       \
+			(signed)((raw_inode)->xtime);			       \
+	if (EXT4_FITS_IN_INODE(raw_inode, xtime ## _extra))		       \
+		ext4_decode_extra_time((timespec),			       \
+				       raw_inode->xtime ## _extra);	       \
+	else								       \
+		(timespec)->tv_nsec = 0;				       \
+} while (0)
+
+static inline errcode_t fuse4fs_read_inode(ext2_filsys fs, ext2_ino_t ino,
+					   struct ext2_inode_large *inode)
+{
+	memset(inode, 0, sizeof(*inode));
+	return ext2fs_read_inode_full(fs, ino, EXT2_INODE(inode),
+				      sizeof(*inode));
+}
+
+static inline errcode_t fuse4fs_write_inode(ext2_filsys fs, ext2_ino_t ino,
+					    struct ext2_inode_large *inode)
+{
+	return ext2fs_write_inode_full(fs, ino, EXT2_INODE(inode),
+				       sizeof(*inode));
+}
+
+static inline struct fuse4fs *fuse4fs_get(void)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+
+	return ctxt->private_data;
+}
+
+static inline struct fuse4fs_file_handle *
+fuse4fs_get_handle(const struct fuse_file_info *fp)
+{
+	return (struct fuse4fs_file_handle *)(uintptr_t)fp->fh;
+}
+
+static inline void
+fuse4fs_set_handle(struct fuse_file_info *fp, struct fuse4fs_file_handle *fh)
+{
+	fp->fh = (uintptr_t)fh;
+}
+
+#ifdef HAVE_CLOCK_MONOTONIC
+static inline ext2_filsys fuse4fs_start(struct fuse4fs *ff)
+{
+	struct timespec lock_time;
+	int ret;
+
+	if (ff->timing)
+		clock_gettime(CLOCK_MONOTONIC, &lock_time);
+
+	pthread_mutex_lock(&ff->bfl);
+	if (ff->timing) {
+		ret = clock_gettime(CLOCK_MONOTONIC, &ff->op_start_time);
+		if (ret)
+			ff->timing = 0;
+		ff->lock_start_time = lock_time;
+	}
+	return ff->fs;
+}
+
+static inline double ms_from_timespec(const struct timespec *ts)
+{
+	return ((double)ts->tv_sec * 1000) + ((double)ts->tv_nsec / 1000000);
+}
+
+static inline void fuse4fs_finish_timing(struct fuse4fs *ff, const char *func)
+{
+	struct timespec now;
+	double lockf, startf, nowf;
+	int ret;
+
+	if (!ff->timing)
+		return;
+
+	ret = clock_gettime(CLOCK_MONOTONIC, &now);
+	if (ret) {
+		ff->timing = 0;
+		return;
+	}
+
+	lockf = ms_from_timespec(&ff->lock_start_time);
+	startf = ms_from_timespec(&ff->op_start_time);
+	nowf = ms_from_timespec(&now);
+	timing_printf(ff, "%s: lock=%.2fms elapsed=%.2fms\n", func,
+		      startf - lockf, nowf - startf);
+}
+#else
+static inline ext2_filsys fuse4fs_start(struct fuse4fs *ff)
+{
+	pthread_mutex_lock(&ff->bfl);
+	return ff->fs;
+}
+# define fuse4fs_finish_timing(...)	((void)0)
+#endif
+
+static inline void __fuse4fs_finish(struct fuse4fs *ff, int ret,
+				    const char *func)
+{
+	fuse4fs_finish_timing(ff, func);
+	if (ret)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", func, ret);
+	pthread_mutex_unlock(&ff->bfl);
+}
+#define fuse4fs_finish(ff, ret) __fuse4fs_finish((ff), (ret), __func__)
+
+static void get_now(struct timespec *now)
+{
+#ifdef CLOCK_REALTIME
+	if (!clock_gettime(CLOCK_REALTIME, now))
+		return;
+#endif
+
+	now->tv_sec = time(NULL);
+	now->tv_nsec = 0;
+}
+
+static void increment_version(struct ext2_inode_large *inode)
+{
+	__u64 ver;
+
+	ver = inode->osd1.linux1.l_i_version;
+	if (EXT4_FITS_IN_INODE(inode, i_version_hi))
+		ver |= (__u64)inode->i_version_hi << 32;
+	ver++;
+	inode->osd1.linux1.l_i_version = ver;
+	if (EXT4_FITS_IN_INODE(inode, i_version_hi))
+		inode->i_version_hi = ver >> 32;
+}
+
+static void init_times(struct ext2_inode_large *inode)
+{
+	struct timespec now;
+
+	get_now(&now);
+	EXT4_INODE_SET_XTIME(i_atime, &now, inode);
+	EXT4_INODE_SET_XTIME(i_ctime, &now, inode);
+	EXT4_INODE_SET_XTIME(i_mtime, &now, inode);
+	EXT4_EINODE_SET_XTIME(i_crtime, &now, inode);
+	increment_version(inode);
+}
+
+static int update_ctime(ext2_filsys fs, ext2_ino_t ino,
+			struct ext2_inode_large *pinode)
+{
+	errcode_t err;
+	struct timespec now;
+	struct ext2_inode_large inode;
+
+	get_now(&now);
+
+	/* If user already has a inode buffer, just update that */
+	if (pinode) {
+		increment_version(pinode);
+		EXT4_INODE_SET_XTIME(i_ctime, &now, pinode);
+		return 0;
+	}
+
+	/* Otherwise we have to read-modify-write the inode */
+	err = fuse4fs_read_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	increment_version(&inode);
+	EXT4_INODE_SET_XTIME(i_ctime, &now, &inode);
+
+	err = fuse4fs_write_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	return 0;
+}
+
+static int update_atime(ext2_filsys fs, ext2_ino_t ino)
+{
+	errcode_t err;
+	struct ext2_inode_large inode, *pinode;
+	struct timespec atime, mtime, now;
+	double datime, dmtime, dnow;
+
+	err = fuse4fs_read_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	pinode = &inode;
+	EXT4_INODE_GET_XTIME(i_atime, &atime, pinode);
+	EXT4_INODE_GET_XTIME(i_mtime, &mtime, pinode);
+	get_now(&now);
+
+	datime = atime.tv_sec + ((double)atime.tv_nsec / 1000000000);
+	dmtime = mtime.tv_sec + ((double)mtime.tv_nsec / 1000000000);
+	dnow = now.tv_sec + ((double)now.tv_nsec / 1000000000);
+
+	/*
+	 * If atime is newer than mtime and atime hasn't been updated in thirty
+	 * seconds, skip the atime update.  Same idea as Linux "relatime".  Use
+	 * doubles to account for nanosecond resolution.
+	 */
+	if (datime >= dmtime && datime >= dnow - 30)
+		return 0;
+	EXT4_INODE_SET_XTIME(i_atime, &now, &inode);
+
+	err = fuse4fs_write_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	return 0;
+}
+
+static int update_mtime(ext2_filsys fs, ext2_ino_t ino,
+			struct ext2_inode_large *pinode)
+{
+	errcode_t err;
+	struct ext2_inode_large inode;
+	struct timespec now;
+
+	if (pinode) {
+		get_now(&now);
+		EXT4_INODE_SET_XTIME(i_mtime, &now, pinode);
+		EXT4_INODE_SET_XTIME(i_ctime, &now, pinode);
+		increment_version(pinode);
+		return 0;
+	}
+
+	err = fuse4fs_read_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	get_now(&now);
+	EXT4_INODE_SET_XTIME(i_mtime, &now, &inode);
+	EXT4_INODE_SET_XTIME(i_ctime, &now, &inode);
+	increment_version(&inode);
+
+	err = fuse4fs_write_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	return 0;
+}
+
+static int ext2_file_type(unsigned int mode)
+{
+	if (LINUX_S_ISREG(mode))
+		return EXT2_FT_REG_FILE;
+
+	if (LINUX_S_ISDIR(mode))
+		return EXT2_FT_DIR;
+
+	if (LINUX_S_ISCHR(mode))
+		return EXT2_FT_CHRDEV;
+
+	if (LINUX_S_ISBLK(mode))
+		return EXT2_FT_BLKDEV;
+
+	if (LINUX_S_ISLNK(mode))
+		return EXT2_FT_SYMLINK;
+
+	if (LINUX_S_ISFIFO(mode))
+		return EXT2_FT_FIFO;
+
+	if (LINUX_S_ISSOCK(mode))
+		return EXT2_FT_SOCK;
+
+	return 0;
+}
+
+static int fs_can_allocate(struct fuse4fs *ff, blk64_t num)
+{
+	ext2_filsys fs = ff->fs;
+	blk64_t reserved;
+
+	dbg_printf(ff, "%s: Asking for %llu; alloc_all=%d total=%llu free=%llu "
+		   "rsvd=%llu\n", __func__, num, ff->alloc_all_blocks,
+		   ext2fs_blocks_count(fs->super),
+		   ext2fs_free_blocks_count(fs->super),
+		   ext2fs_r_blocks_count(fs->super));
+	if (num > ext2fs_blocks_count(fs->super))
+		return 0;
+
+	if (ff->alloc_all_blocks)
+		return 1;
+
+	/*
+	 * Different meaning for r_blocks -- libext2fs has bugs where the FS
+	 * can get corrupted if it totally runs out of blocks.  Avoid this
+	 * by refusing to allocate any of the reserve blocks to anybody.
+	 */
+	reserved = ext2fs_r_blocks_count(fs->super);
+	if (reserved == 0)
+		reserved = ext2fs_blocks_count(fs->super) / 10;
+	return ext2fs_free_blocks_count(fs->super) > reserved + num;
+}
+
+static int fuse4fs_is_writeable(struct fuse4fs *ff)
+{
+	return ff->opstate == F4OP_WRITABLE &&
+		(ff->fs->super->s_error_count == 0);
+}
+
+static inline int is_superuser(struct fuse4fs *ff, struct fuse_context *ctxt)
+{
+	if (ff->fakeroot)
+		return 1;
+	return ctxt->uid == 0;
+}
+
+static inline int want_check_owner(struct fuse4fs *ff,
+				   struct fuse_context *ctxt)
+{
+	/*
+	 * The kernel is responsible for access control, so we allow anything
+	 * that the superuser can do.
+	 */
+	if (ff->kernel)
+		return 0;
+	return !is_superuser(ff, ctxt);
+}
+
+/* Test for append permission */
+#define A_OK	16
+
+static int check_iflags_access(struct fuse4fs *ff, ext2_ino_t ino,
+			       const struct ext2_inode *inode, int mask)
+{
+	EXT2FS_BUILD_BUG_ON((A_OK & (R_OK | W_OK | X_OK | F_OK)) != 0);
+
+	/* no writing or metadata changes to read-only or broken fs */
+	if ((mask & (W_OK | A_OK)) && !fuse4fs_is_writeable(ff))
+		return -EROFS;
+
+	dbg_printf(ff, "access ino=%d mask=e%s%s%s%s iflags=0x%x\n",
+		   ino,
+		   (mask & R_OK ? "r" : ""),
+		   (mask & W_OK ? "w" : ""),
+		   (mask & X_OK ? "x" : ""),
+		   (mask & A_OK ? "a" : ""),
+		   inode->i_flags);
+
+	/* is immutable? */
+	if ((mask & W_OK) &&
+	    (inode->i_flags & EXT2_IMMUTABLE_FL))
+		return -EPERM;
+
+	/* is append-only? */
+	if ((inode->i_flags & EXT2_APPEND_FL) && (mask & W_OK) && !(mask & A_OK))
+		return -EPERM;
+
+	return 0;
+}
+
+static int check_inum_access(struct fuse4fs *ff, ext2_ino_t ino, int mask)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	ext2_filsys fs = ff->fs;
+	struct ext2_inode inode;
+	mode_t perms;
+	errcode_t err;
+	int ret;
+
+	/* no writing to read-only or broken fs */
+	if ((mask & (W_OK | A_OK)) && !fuse4fs_is_writeable(ff))
+		return -EROFS;
+
+	err = ext2fs_read_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+	perms = inode.i_mode & 0777;
+
+	dbg_printf(ff, "access ino=%d mask=e%s%s%s%s perms=0%o iflags=0x%x "
+		   "fuid=%d fgid=%d uid=%d gid=%d\n", ino,
+		   (mask & R_OK ? "r" : ""),
+		   (mask & W_OK ? "w" : ""),
+		   (mask & X_OK ? "x" : ""),
+		   (mask & A_OK ? "a" : ""),
+		   perms, inode.i_flags,
+		   inode_uid(inode), inode_gid(inode),
+		   ctxt->uid, ctxt->gid);
+
+	/* existence check */
+	if (mask == 0)
+		return 0;
+
+	ret = check_iflags_access(ff, ino, &inode, mask);
+	if (ret)
+		return ret;
+
+	/* If kernel is responsible for mode and acl checks, we're done. */
+	if (ff->kernel)
+		return 0;
+
+	/* Figure out what root's allowed to do */
+	if (is_superuser(ff, ctxt)) {
+		/* Non-file access always ok */
+		if (!LINUX_S_ISREG(inode.i_mode))
+			return 0;
+
+		/* R/W access to a file always ok */
+		if (!(mask & X_OK))
+			return 0;
+
+		/* X access to a file ok if a user/group/other can X */
+		if (perms & 0111)
+			return 0;
+
+		/* Trying to execute a file that's not executable. BZZT! */
+		return -EACCES;
+	}
+
+	/* Remove the O_APPEND flag before testing permissions */
+	mask &= ~A_OK;
+
+	/* allow owner, if perms match */
+	if (inode_uid(inode) == ctxt->uid) {
+		if ((mask & (perms >> 6)) == mask)
+			return 0;
+		return -EACCES;
+	}
+
+	/* allow group, if perms match */
+	if (inode_gid(inode) == ctxt->gid) {
+		if ((mask & (perms >> 3)) == mask)
+			return 0;
+		return -EACCES;
+	}
+
+	/* otherwise check other */
+	if ((mask & perms) == mask)
+		return 0;
+	return -EACCES;
+}
+
+static errcode_t fuse4fs_acquire_lockfile(struct fuse4fs *ff)
+{
+	char *resolved;
+	int lockfd;
+	errcode_t err;
+
+	lockfd = open(ff->lockfile, O_RDWR | O_CREAT | O_EXCL, 0400);
+	if (lockfd < 0) {
+		if (errno == EEXIST)
+			err = EWOULDBLOCK;
+		else
+			err = errno;
+		err_printf(ff, "%s: %s: %s\n", ff->lockfile,
+			   _("opening lockfile failed"),
+			   strerror(err));
+		ff->lockfile = NULL;
+		return err;
+	}
+	close(lockfd);
+
+	resolved = realpath(ff->lockfile, NULL);
+	if (!resolved) {
+		err = errno;
+		err_printf(ff, "%s: %s: %s\n", ff->lockfile,
+			   _("resolving lockfile failed"),
+			   strerror(err));
+		unlink(ff->lockfile);
+		ff->lockfile = NULL;
+		return err;
+	}
+	free(ff->lockfile);
+	ff->lockfile = resolved;
+
+	return 0;
+}
+
+static void fuse4fs_release_lockfile(struct fuse4fs *ff)
+{
+	if (unlink(ff->lockfile)) {
+		errcode_t err = errno;
+
+		err_printf(ff, "%s: %s: %s\n", ff->lockfile,
+			   _("removing lockfile failed"),
+			   strerror(err));
+	}
+	free(ff->lockfile);
+}
+
+static void fuse4fs_unmount(struct fuse4fs *ff)
+{
+	errcode_t err;
+
+	if (!ff->fs)
+		return;
+
+	err = ext2fs_close(ff->fs);
+	if (err) {
+		err_printf(ff, "%s: %s\n", _("while closing fs"),
+			   error_message(err));
+		ext2fs_free(ff->fs);
+	}
+	ff->fs = NULL;
+
+	if (ff->lockfile)
+		fuse4fs_release_lockfile(ff);
+}
+
+static errcode_t fuse4fs_open(struct fuse4fs *ff, int libext2_flags)
+{
+	char options[128];
+	int flags = EXT2_FLAG_64BITS | EXT2_FLAG_THREADS | EXT2_FLAG_RW |
+		    libext2_flags;
+	errcode_t err;
+
+	if (ff->lockfile) {
+		err = fuse4fs_acquire_lockfile(ff);
+		if (err)
+			return err;
+	}
+
+	snprintf(options, sizeof(options) - 1, "offset=%lu", ff->offset);
+	ff->opstate = F4OP_READONLY;
+
+	if (ff->directio)
+		flags |= EXT2_FLAG_DIRECT_IO;
+
+	err = ext2fs_open2(ff->device, options, flags, 0, 0, unix_io_manager,
+			   &ff->fs);
+	if (err == EPERM) {
+		err_printf(ff, "%s.\n",
+			   _("read-only device, trying to mount norecovery"));
+		flags &= ~EXT2_FLAG_RW;
+		ff->ro = 1;
+		ff->norecovery = 1;
+		err = ext2fs_open2(ff->device, options, flags, 0, 0,
+				   unix_io_manager, &ff->fs);
+	}
+	if (err) {
+		err_printf(ff, "%s.\n", error_message(err));
+		err_printf(ff, "%s\n", _("Please run e2fsck -fy."));
+		return err;
+	}
+
+	ff->fs->priv_data = ff;
+	ff->blocklog = u_log2(ff->fs->blocksize);
+	ff->blockmask = ff->fs->blocksize - 1;
+	return 0;
+}
+
+static inline bool fuse4fs_on_bdev(const struct fuse4fs *ff)
+{
+	return ff->fs->io->flags & CHANNEL_FLAGS_BLOCK_DEVICE;
+}
+
+static errcode_t fuse4fs_config_cache(struct fuse4fs *ff)
+{
+	char buf[128];
+	errcode_t err;
+
+	snprintf(buf, sizeof(buf), "cache_blocks=%llu",
+		 FUSE4FS_B_TO_FSBT(ff, ff->cache_size));
+	err = io_channel_set_options(ff->fs->io, buf);
+	if (err) {
+		err_printf(ff, "%s %lluk: %s\n",
+			   _("cannot set disk cache size to"),
+			   ff->cache_size >> 10,
+			   error_message(err));
+		return err;
+	}
+
+	return 0;
+}
+
+static errcode_t fuse4fs_check_support(struct fuse4fs *ff)
+{
+	ext2_filsys fs = ff->fs;
+
+	if (ext2fs_has_feature_quota(fs->super)) {
+		err_printf(ff, "%s\n", _("quotas not supported."));
+		return EXT2_ET_UNSUPP_FEATURE;
+	}
+	if (ext2fs_has_feature_verity(fs->super)) {
+		err_printf(ff, "%s\n", _("verity not supported."));
+		return EXT2_ET_UNSUPP_FEATURE;
+	}
+	if (ext2fs_has_feature_encrypt(fs->super)) {
+		err_printf(ff, "%s\n", _("encryption not supported."));
+		return EXT2_ET_UNSUPP_FEATURE;
+	}
+	if (ext2fs_has_feature_casefold(fs->super)) {
+		err_printf(ff, "%s\n", _("casefolding not supported."));
+		return EXT2_ET_UNSUPP_FEATURE;
+	}
+
+	if (fs->super->s_state & EXT2_ERROR_FS) {
+		err_printf(ff, "%s\n",
+ _("Errors detected; running e2fsck is required."));
+		return EXT2_ET_FILESYSTEM_CORRUPTED;
+	}
+
+	return 0;
+}
+
+static int fuse4fs_check_norecovery(struct fuse4fs *ff)
+{
+	if (ext2fs_has_feature_journal_needs_recovery(ff->fs->super) &&
+	    !ff->ro) {
+		log_printf(ff, "%s\n",
+ _("Required journal recovery suppressed and not mounted read-only."));
+		return 32;
+	}
+
+	/*
+	 * Amazingly, norecovery allows a rw mount when there's a clean journal
+	 * present.
+	 */
+	return 0;
+}
+
+static int fuse4fs_mount(struct fuse4fs *ff)
+{
+	struct ext2_inode_large inode;
+	ext2_filsys fs = ff->fs;
+	errcode_t err;
+
+	if (ext2fs_has_feature_journal_needs_recovery(fs->super)) {
+		if (ff->norecovery) {
+			log_printf(ff, "%s\n",
+ _("Mounting read-only without recovering journal."));
+		} else {
+			log_printf(ff, "%s\n", _("Recovering journal."));
+			err = ext2fs_run_ext3_journal(&ff->fs);
+			if (err) {
+				err_printf(ff, "%s.\n", error_message(err));
+				err_printf(ff, "%s\n",
+						_("Please run e2fsck -fy."));
+				return translate_error(fs, 0, err);
+			}
+			fs = ff->fs;
+			ext2fs_clear_feature_journal_needs_recovery(fs->super);
+			ext2fs_mark_super_dirty(fs);
+
+			err = fuse4fs_check_support(ff);
+			if (err)
+				return err;
+		}
+	}
+
+	/* Make sure the root directory is readable. */
+	err = fuse4fs_read_inode(fs, EXT2_ROOT_INO, &inode);
+	if (err)
+		return translate_error(fs, EXT2_ROOT_INO, err);
+
+	if (fs->flags & EXT2_FLAG_RW) {
+		if (ext2fs_has_feature_journal(fs->super))
+			log_printf(ff, "%s",
+ _("Warning: fuse4fs does not support using the journal.\n"
+   "There may be file system corruption or data loss if\n"
+   "the file system is not gracefully unmounted.\n"));
+		ff->opstate = F4OP_WRITABLE;
+	}
+
+	if (!(fs->super->s_state & EXT2_VALID_FS))
+		err_printf(ff, "%s\n",
+ _("Warning: Mounting unchecked fs, running e2fsck is recommended."));
+	if (fs->super->s_max_mnt_count > 0 &&
+	    fs->super->s_mnt_count >= fs->super->s_max_mnt_count)
+		err_printf(ff, "%s\n",
+ _("Warning: Maximal mount count reached, running e2fsck is recommended."));
+	if (fs->super->s_checkinterval > 0 &&
+	    (time_t) (fs->super->s_lastcheck +
+		      fs->super->s_checkinterval) <= time(0))
+		err_printf(ff, "%s\n",
+ _("Warning: Check time reached; running e2fsck is recommended."));
+	if (fs->super->s_last_orphan)
+		err_printf(ff, "%s\n",
+ _("Orphans detected; running e2fsck is recommended."));
+
+	if (!ff->errors_behavior)
+		ff->errors_behavior = fs->super->s_errors;
+
+	/* Clear the valid flag so that an unclean shutdown forces a fsck */
+	if (ff->opstate == F4OP_WRITABLE) {
+		fs->super->s_mnt_count++;
+		ext2fs_set_tstamp(fs->super, s_mtime, time(NULL));
+		fs->super->s_state &= ~EXT2_VALID_FS;
+		ext2fs_mark_super_dirty(fs);
+		err = ext2fs_flush2(fs, 0);
+		if (err)
+			return translate_error(fs, 0, err);
+	}
+
+	return 0;
+}
+
+static void op_destroy(void *p EXT2FS_ATTR((unused)))
+{
+	struct fuse4fs *ff = fuse4fs_get();
+	ext2_filsys fs;
+	errcode_t err;
+
+	FUSE4FS_CHECK_CONTEXT_RETURN(ff);
+
+	fs = fuse4fs_start(ff);
+
+	dbg_printf(ff, "%s: dev=%s\n", __func__, fs->device_name);
+	if (ff->opstate == F4OP_WRITABLE) {
+		fs->super->s_state |= EXT2_VALID_FS;
+		if (fs->super->s_error_count)
+			fs->super->s_state |= EXT2_ERROR_FS;
+		ext2fs_mark_super_dirty(fs);
+		err = ext2fs_set_gdt_csum(fs);
+		if (err)
+			translate_error(fs, 0, err);
+
+		err = ext2fs_flush2(fs, 0);
+		if (err)
+			translate_error(fs, 0, err);
+	}
+
+	if (ff->debug && fs->io->manager->get_stats) {
+		io_stats stats = NULL;
+
+		fs->io->manager->get_stats(fs->io, &stats);
+		dbg_printf(ff, "read: %lluk\n",  stats->bytes_read >> 10);
+		dbg_printf(ff, "write: %lluk\n", stats->bytes_written >> 10);
+		dbg_printf(ff, "hits: %llu\n",   stats->cache_hits);
+		dbg_printf(ff, "misses: %llu\n", stats->cache_misses);
+		dbg_printf(ff, "hit_ratio: %.1f%%\n",
+				(100.0 * stats->cache_hits) /
+				(stats->cache_hits + stats->cache_misses));
+	}
+
+	if (ff->kernel) {
+		char uuid[UUID_STR_SIZE];
+
+		uuid_unparse(fs->super->s_uuid, uuid);
+		log_printf(ff, "%s %s.\n", _("unmounting filesystem"), uuid);
+	}
+
+	if (ff->unmount_in_destroy)
+		fuse4fs_unmount(ff);
+
+	fuse4fs_finish(ff, 0);
+}
+
+/* Reopen @stream with @fileno */
+static int fuse4fs_freopen_stream(const char *path, int fileno, FILE *stream)
+{
+	char _fdpath[256];
+	const char *fdpath;
+	FILE *fp;
+	int ret;
+
+	ret = snprintf(_fdpath, sizeof(_fdpath), "/dev/fd/%d", fileno);
+	if (ret >= sizeof(_fdpath))
+		fdpath = path;
+	else
+		fdpath = _fdpath;
+
+	/*
+	 * C23 defines std{out,err} as an expression of type FILE* that need
+	 * not be an lvalue.  What this means is that we can't just assign to
+	 * stdout: we have to use freopen, which takes a path.
+	 *
+	 * There's no guarantee that the OS provides a /dev/fd/X alias for open
+	 * file descriptors, so if that fails, fall back to the original log
+	 * file path.  We'd rather not do a path-based reopen because that
+	 * exposes us to rename race attacks.
+	 */
+	fp = freopen(fdpath, "a", stream);
+	if (!fp && errno == ENOENT && fdpath == _fdpath)
+		fp = freopen(path, "a", stream);
+	if (!fp) {
+		perror(fdpath);
+		return -1;
+	}
+
+	return 0;
+}
+
+/* Redirect stdout/stderr to a file, or return a mount-compatible error. */
+static int fuse4fs_capture_output(struct fuse4fs *ff, const char *path)
+{
+	int ret;
+	int fd;
+
+	/*
+	 * First, open the log file path with system calls so that we can
+	 * redirect the stdout/stderr file numbers (typically 1 and 2) to our
+	 * logfile descriptor.  We'd like to avoid allocating extra file
+	 * objects in the kernel if we can because pos will be the same between
+	 * stdout and stderr.
+	 */
+	if (ff->logfd < 0) {
+		fd = open(path, O_WRONLY | O_CREAT | O_APPEND, 0600);
+		if (fd < 0) {
+			perror(path);
+			return -1;
+		}
+
+		/*
+		 * Save the newly opened fd in case we have to do this again in
+		 * op_init.
+		 */
+		ff->logfd = fd;
+	}
+
+	ret = dup2(ff->logfd, STDOUT_FILENO);
+	if (ret < 0) {
+		perror(path);
+		return -1;
+	}
+
+	ret = dup2(ff->logfd, STDERR_FILENO);
+	if (ret < 0) {
+		perror(path);
+		return -1;
+	}
+
+	/*
+	 * Now that we've changed STD{OUT,ERR}_FILENO to be the log file, use
+	 * freopen to make sure that std{out,err} (the C library abstractions)
+	 * point to the STDXXX_FILENO because any of our library dependencies
+	 * might decide to printf to one of those streams and we want to
+	 * capture all output in the log.
+	 */
+	ret = fuse4fs_freopen_stream(path, STDOUT_FILENO, stdout);
+	if (ret)
+		return ret;
+	ret = fuse4fs_freopen_stream(path, STDERR_FILENO, stderr);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/* Set up debug and error logging files */
+static int fuse4fs_setup_logging(struct fuse4fs *ff)
+{
+	char *logfile = getenv("FUSE4FS_LOGFILE");
+	if (logfile)
+		return fuse4fs_capture_output(ff, logfile);
+
+	/* in kernel mode, try to log errors to the kernel log */
+	if (ff->kernel)
+		fuse4fs_capture_output(ff, "/dev/ttyprintk");
+
+	return 0;
+}
+
+static int fuse4fs_read_bitmaps(struct fuse4fs *ff)
+{
+	errcode_t err;
+
+	err = ext2fs_read_inode_bitmap(ff->fs);
+	if (err)
+		return translate_error(ff->fs, 0, err);
+
+	err = ext2fs_read_block_bitmap(ff->fs);
+	if (err)
+		return translate_error(ff->fs, 0, err);
+
+	return 0;
+}
+
+#if FUSE_VERSION < FUSE_MAKE_VERSION(3, 17)
+static inline int fuse_set_feature_flag(struct fuse_conn_info *conn,
+					 uint64_t flag)
+{
+	if (conn->capable & flag) {
+		conn->want |= flag;
+		return 1;
+	}
+
+	return 0;
+}
+#endif
+
+static void *op_init(struct fuse_conn_info *conn,
+		     struct fuse_config *cfg EXT2FS_ATTR((unused)))
+{
+	struct fuse4fs *ff = fuse4fs_get();
+	ext2_filsys fs;
+
+	FUSE4FS_CHECK_CONTEXT_ABORT(ff);
+
+	/*
+	 * Configure logging a second time, because libfuse might have
+	 * redirected std{out,err} as part of daemonization.  If this fails,
+	 * give up and move on.
+	 */
+	fuse4fs_setup_logging(ff);
+	if (ff->logfd >= 0)
+		close(ff->logfd);
+	ff->logfd = -1;
+
+	fs = ff->fs;
+	dbg_printf(ff, "%s: dev=%s\n", __func__, fs->device_name);
+#ifdef FUSE_CAP_IOCTL_DIR
+	fuse_set_feature_flag(conn, FUSE_CAP_IOCTL_DIR);
+#endif
+#ifdef FUSE_CAP_POSIX_ACL
+	if (ff->acl)
+		fuse_set_feature_flag(conn, FUSE_CAP_POSIX_ACL);
+#endif
+#ifdef FUSE_CAP_CACHE_SYMLINKS
+	fuse_set_feature_flag(conn, FUSE_CAP_CACHE_SYMLINKS);
+#endif
+#ifdef FUSE_CAP_NO_EXPORT_SUPPORT
+	fuse_set_feature_flag(conn, FUSE_CAP_NO_EXPORT_SUPPORT);
+#endif
+	conn->time_gran = 1;
+	cfg->use_ino = 1;
+	if (ff->debug)
+		cfg->debug = 1;
+	cfg->nullpath_ok = 1;
+
+	if (ff->kernel) {
+		char uuid[UUID_STR_SIZE];
+
+		uuid_unparse(fs->super->s_uuid, uuid);
+		log_printf(ff, "%s %s.\n", _("mounted filesystem"), uuid);
+	}
+
+	if (ff->opstate == F4OP_WRITABLE)
+		fuse4fs_read_bitmaps(ff);
+
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 17)
+	/*
+	 * THIS MUST GO LAST!
+	 *
+	 * fuse_set_feature_flag in 3.17.0 has a strange bug: it sets feature
+	 * flags in conn->want_ext, but not conn->want.  Upon return to
+	 * libfuse, the lower level library observes that want and want_ext
+	 * have gotten out of sync, and refuses to mount.  Therefore,
+	 * synchronize the two.  This bug went away in 3.17.3, but we're stuck
+	 * with this forever because Debian trixie released with 3.17.2.
+	 */
+	conn->want = conn->want_ext & 0xFFFFFFFF;
+#endif
+	return ff;
+}
+
+static int stat_inode(ext2_filsys fs, ext2_ino_t ino, struct stat *statbuf)
+{
+	struct ext2_inode_large inode;
+	dev_t fakedev = 0;
+	errcode_t err;
+	int ret = 0;
+	struct timespec tv;
+
+	err = fuse4fs_read_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	memcpy(&fakedev, fs->super->s_uuid, sizeof(fakedev));
+	statbuf->st_dev = fakedev;
+	statbuf->st_ino = ino;
+	statbuf->st_mode = inode.i_mode;
+	statbuf->st_nlink = inode.i_links_count;
+	statbuf->st_uid = inode_uid(inode);
+	statbuf->st_gid = inode_gid(inode);
+	statbuf->st_size = EXT2_I_SIZE(&inode);
+	statbuf->st_blksize = fs->blocksize;
+	statbuf->st_blocks = ext2fs_get_stat_i_blocks(fs,
+						EXT2_INODE(&inode));
+	EXT4_INODE_GET_XTIME(i_atime, &tv, &inode);
+#if HAVE_STRUCT_STAT_ST_ATIM
+	statbuf->st_atim = tv;
+#else
+	statbuf->st_atime = tv.tv_sec;
+#endif
+	EXT4_INODE_GET_XTIME(i_mtime, &tv, &inode);
+#if HAVE_STRUCT_STAT_ST_ATIM
+	statbuf->st_mtim = tv;
+#else
+	statbuf->st_mtime = tv.tv_sec;
+#endif
+	EXT4_INODE_GET_XTIME(i_ctime, &tv, &inode);
+#if HAVE_STRUCT_STAT_ST_ATIM
+	statbuf->st_ctim = tv;
+#else
+	statbuf->st_ctime = tv.tv_sec;
+#endif
+	if (LINUX_S_ISCHR(inode.i_mode) ||
+	    LINUX_S_ISBLK(inode.i_mode)) {
+		if (inode.i_block[0])
+			statbuf->st_rdev = inode.i_block[0];
+		else
+			statbuf->st_rdev = inode.i_block[1];
+	}
+
+	return ret;
+}
+
+static int __fuse4fs_file_ino(struct fuse4fs *ff, const char *path,
+			      struct fuse_file_info *fp EXT2FS_ATTR((unused)),
+			      ext2_ino_t *inop,
+			      const char *func,
+			      int line)
+{
+	ext2_filsys fs = ff->fs;
+	errcode_t err;
+
+	if (fp) {
+		struct fuse4fs_file_handle *fh = fuse4fs_get_handle(fp);
+
+		if (fh->ino == 0)
+			return -ESTALE;
+
+		*inop = fh->ino;
+		dbg_printf(ff, "%s: get ino=%d\n", func, fh->ino);
+		return 0;
+	}
+
+	dbg_printf(ff, "%s: get path=%s\n", func, path);
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, inop);
+	if (err)
+		return __translate_error(fs, 0, err, func, line);
+
+	return 0;
+}
+
+# define fuse4fs_file_ino(ff, path, fp, inop) \
+	__fuse4fs_file_ino((ff), (path), (fp), (inop), __func__, __LINE__)
+
+static int op_getattr(const char *path, struct stat *statbuf,
+		      struct fuse_file_info *fi)
+{
+	struct fuse4fs *ff = fuse4fs_get();
+	ext2_filsys fs;
+	ext2_ino_t ino;
+	int ret = 0;
+
+	FUSE4FS_CHECK_CONTEXT(ff);
+	fs = fuse4fs_start(ff);
+	ret = fuse4fs_file_ino(ff, path, fi, &ino);
+	if (ret)
+		goto out;
+	ret = stat_inode(fs, ino, statbuf);
+out:
+	fuse4fs_finish(ff, ret);
+	return ret;
+}
+
+static int op_readlink(const char *path, char *buf, size_t len)
+{
+	struct fuse4fs *ff = fuse4fs_get();
+	ext2_filsys fs;
+	errcode_t err;
+	ext2_ino_t ino;
+	struct ext2_inode inode;
+	unsigned int got;
+	ext2_file_t file;
+	int ret = 0;
+
+	FUSE4FS_CHECK_CONTEXT(ff);
+	dbg_printf(ff, "%s: path=%s\n", __func__, path);
+	fs = fuse4fs_start(ff);
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
+	if (err || ino == 0) {
+		ret = translate_error(fs, 0, err);
+		goto out;
+	}
+
+	err = ext2fs_read_inode(fs, ino, &inode);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out;
+	}
+
+	if (!LINUX_S_ISLNK(inode.i_mode)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	len--;
+	if (inode.i_size < len)
+		len = inode.i_size;
+	if (ext2fs_is_fast_symlink(&inode))
+		memcpy(buf, (char *)inode.i_block, len);
+	else {
+		/* big/inline symlink */
+
+		err = ext2fs_file_open(fs, ino, 0, &file);
+		if (err) {
+			ret = translate_error(fs, ino, err);
+			goto out;
+		}
+
+		err = ext2fs_file_read(file, buf, len, &got);
+		if (err)
+			ret = translate_error(fs, ino, err);
+		else if (got != len)
+			ret = translate_error(fs, ino, EXT2_ET_INODE_CORRUPTED);
+
+		err = ext2fs_file_close(file);
+		if (ret)
+			goto out;
+		if (err) {
+			ret = translate_error(fs, ino, err);
+			goto out;
+		}
+	}
+	buf[len] = 0;
+
+	if (fuse4fs_is_writeable(ff)) {
+		ret = update_atime(fs, ino);
+		if (ret)
+			goto out;
+	}
+
+out:
+	fuse4fs_finish(ff, ret);
+	return ret;
+}
+
+static int __getxattr(struct fuse4fs *ff, ext2_ino_t ino, const char *name,
+		      void **value, size_t *value_len)
+{
+	ext2_filsys fs = ff->fs;
+	struct ext2_xattr_handle *h;
+	errcode_t err;
+	int ret = 0;
+
+	err = ext2fs_xattrs_open(fs, ino, &h);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	err = ext2fs_xattrs_read(h);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out_close;
+	}
+
+	err = ext2fs_xattr_get(h, name, value, value_len);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out_close;
+	}
+
+out_close:
+	err = ext2fs_xattrs_close(&h);
+	if (err && !ret)
+		ret = translate_error(fs, ino, err);
+	return ret;
+}
+
+static int __setxattr(struct fuse4fs *ff, ext2_ino_t ino, const char *name,
+		      void *value, size_t valuelen)
+{
+	ext2_filsys fs = ff->fs;
+	struct ext2_xattr_handle *h;
+	errcode_t err;
+	int ret = 0;
+
+	err = ext2fs_xattrs_open(fs, ino, &h);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	err = ext2fs_xattrs_read(h);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out_close;
+	}
+
+	err = ext2fs_xattr_set(h, name, value, valuelen);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out_close;
+	}
+
+out_close:
+	err = ext2fs_xattrs_close(&h);
+	if (err && !ret)
+		ret = translate_error(fs, ino, err);
+	return ret;
+}
+
+static int propagate_default_acls(struct fuse4fs *ff, ext2_ino_t parent,
+				  ext2_ino_t child, mode_t mode)
+{
+	void *def;
+	size_t deflen;
+	int ret;
+
+	if (!ff->acl || S_ISDIR(mode))
+		return 0;
+
+	ret = __getxattr(ff, parent, XATTR_NAME_POSIX_ACL_DEFAULT, &def,
+			 &deflen);
+	switch (ret) {
+	case -ENODATA:
+	case -ENOENT:
+		/* no default acl */
+		return 0;
+	case 0:
+		break;
+	default:
+		return ret;
+	}
+
+	ret = __setxattr(ff, child, XATTR_NAME_POSIX_ACL_DEFAULT, def, deflen);
+	ext2fs_free_mem(&def);
+	return ret;
+}
+
+static inline void fuse4fs_set_uid(struct ext2_inode_large *inode, uid_t uid)
+{
+	inode->i_uid = uid;
+	ext2fs_set_i_uid_high(*inode, uid >> 16);
+}
+
+static inline void fuse4fs_set_gid(struct ext2_inode_large *inode, gid_t gid)
+{
+	inode->i_gid = gid;
+	ext2fs_set_i_gid_high(*inode, gid >> 16);
+}
+
+static int fuse4fs_new_child_gid(struct fuse4fs *ff, ext2_ino_t parent,
+				 gid_t *gid, int *parent_sgid)
+{
+	struct ext2_inode_large inode;
+	struct fuse_context *ctxt = fuse_get_context();
+	errcode_t err;
+
+	err = fuse4fs_read_inode(ff->fs, parent, &inode);
+	if (err)
+		return translate_error(ff->fs, parent, err);
+
+	if (inode.i_mode & S_ISGID) {
+		if (parent_sgid)
+			*parent_sgid = 1;
+		*gid = inode.i_gid;
+	} else {
+		if (parent_sgid)
+			*parent_sgid = 0;
+		*gid = ctxt->gid;
+	}
+
+	return 0;
+}
+
+/*
+ * Flush dirty data to disk if we're running in dirsync mode.  If @flushed is a
+ * non-null pointer, this function sets @flushed to 1 if we decided to flush
+ * data, or 0 if not.
+ */
+static inline int fuse4fs_dirsync_flush(struct fuse4fs *ff, ext2_ino_t ino,
+					int *flushed)
+{
+	struct ext2_inode_large inode;
+	ext2_filsys fs = ff->fs;
+	errcode_t err;
+
+	if (ff->dirsync)
+		goto flush;
+
+	err = fuse4fs_read_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, 0, err);
+
+	if (inode.i_flags & EXT2_DIRSYNC_FL)
+		goto flush;
+
+	if (flushed)
+		*flushed = 0;
+	return 0;
+flush:
+	err = ext2fs_flush2(fs, 0);
+	if (err)
+		return translate_error(fs, 0, err);
+
+	if (flushed)
+		*flushed = 1;
+	return 0;
+}
+
+static void fuse4fs_set_extra_isize(struct fuse4fs *ff, ext2_ino_t ino,
+				    struct ext2_inode_large *inode)
+{
+	ext2_filsys fs = ff->fs;
+	size_t extra = sizeof(struct ext2_inode_large) -
+		EXT2_GOOD_OLD_INODE_SIZE;
+
+	if (ext2fs_has_feature_extra_isize(fs->super)) {
+		dbg_printf(ff, "%s: ino=%u extra=%zu want=%u min=%u\n",
+			   __func__, ino, extra, fs->super->s_want_extra_isize,
+			   fs->super->s_min_extra_isize);
+
+		if (fs->super->s_want_extra_isize > extra)
+			extra = fs->super->s_want_extra_isize;
+		if (fs->super->s_min_extra_isize > extra)
+			extra = fs->super->s_min_extra_isize;
+	}
+
+	inode->i_extra_isize = extra;
+}
+
+static int op_mknod(const char *path, mode_t mode, dev_t dev)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse4fs *ff = fuse4fs_get();
+	ext2_filsys fs;
+	ext2_ino_t parent, child;
+	char *temp_path;
+	errcode_t err;
+	char *node_name, a;
+	int filetype;
+	struct ext2_inode_large inode;
+	gid_t gid;
+	int ret = 0;
+
+	FUSE4FS_CHECK_CONTEXT(ff);
+	dbg_printf(ff, "%s: path=%s mode=0%o dev=0x%x\n", __func__, path, mode,
+		   (unsigned int)dev);
+	temp_path = strdup(path);
+	if (!temp_path) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	node_name = strrchr(temp_path, '/');
+	if (!node_name) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	node_name++;
+	a = *node_name;
+	*node_name = 0;
+
+	fs = fuse4fs_start(ff);
+	if (!fs_can_allocate(ff, 2)) {
+		ret = -ENOSPC;
+		goto out2;
+	}
+
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, temp_path,
+			   &parent);
+	if (err) {
+		ret = translate_error(fs, 0, err);
+		goto out2;
+	}
+
+	ret = check_inum_access(ff, parent, A_OK | W_OK);
+	if (ret)
+		goto out2;
+
+	*node_name = a;
+
+	if (LINUX_S_ISCHR(mode))
+		filetype = EXT2_FT_CHRDEV;
+	else if (LINUX_S_ISBLK(mode))
+		filetype = EXT2_FT_BLKDEV;
+	else if (LINUX_S_ISFIFO(mode))
+		filetype = EXT2_FT_FIFO;
+	else if (LINUX_S_ISSOCK(mode))
+		filetype = EXT2_FT_SOCK;
+	else {
+		ret = -EINVAL;
+		goto out2;
+	}
+
+	err = fuse4fs_new_child_gid(ff, parent, &gid, NULL);
+	if (err)
+		goto out2;
+
+	err = ext2fs_new_inode(fs, parent, mode, 0, &child);
+	if (err) {
+		ret = translate_error(fs, 0, err);
+		goto out2;
+	}
+
+	dbg_printf(ff, "%s: create ino=%d/name=%s in dir=%d\n", __func__, child,
+		   node_name, parent);
+	err = ext2fs_link(fs, parent, node_name, child,
+			  filetype | EXT2FS_LINK_EXPAND);
+	if (err) {
+		ret = translate_error(fs, parent, err);
+		goto out2;
+	}
+
+	ret = update_mtime(fs, parent, NULL);
+	if (ret)
+		goto out2;
+
+	memset(&inode, 0, sizeof(inode));
+	inode.i_mode = mode;
+
+	if (dev & ~0xFFFF)
+		inode.i_block[1] = dev;
+	else
+		inode.i_block[0] = dev;
+	inode.i_links_count = 1;
+	fuse4fs_set_extra_isize(ff, child, &inode);
+	fuse4fs_set_uid(&inode, ctxt->uid);
+	fuse4fs_set_gid(&inode, gid);
+
+	err = ext2fs_write_new_inode(fs, child, EXT2_INODE(&inode));
+	if (err) {
+		ret = translate_error(fs, child, err);
+		goto out2;
+	}
+
+	inode.i_generation = ff->next_generation++;
+	init_times(&inode);
+	err = fuse4fs_write_inode(fs, child, &inode);
+	if (err) {
+		ret = translate_error(fs, child, err);
+		goto out2;
+	}
+
+	ext2fs_inode_alloc_stats2(fs, child, 1, 0);
+
+	ret = propagate_default_acls(ff, parent, child, inode.i_mode);
+	if (ret)
+		goto out2;
+
+	ret = fuse4fs_dirsync_flush(ff, parent, NULL);
+	if (ret)
+		goto out2;
+
+out2:
+	fuse4fs_finish(ff, ret);
+out:
+	free(temp_path);
+	return ret;
+}
+
+static int op_mkdir(const char *path, mode_t mode)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse4fs *ff = fuse4fs_get();
+	ext2_filsys fs;
+	ext2_ino_t parent, child;
+	char *temp_path;
+	errcode_t err;
+	char *node_name, a;
+	struct ext2_inode_large inode;
+	char *block;
+	blk64_t blk;
+	int ret = 0;
+	gid_t gid;
+	int parent_sgid;
+
+	FUSE4FS_CHECK_CONTEXT(ff);
+	dbg_printf(ff, "%s: path=%s mode=0%o\n", __func__, path, mode);
+	temp_path = strdup(path);
+	if (!temp_path) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	node_name = strrchr(temp_path, '/');
+	if (!node_name) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	node_name++;
+	a = *node_name;
+	*node_name = 0;
+
+	fs = fuse4fs_start(ff);
+	if (!fs_can_allocate(ff, 1)) {
+		ret = -ENOSPC;
+		goto out2;
+	}
+
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, temp_path,
+			   &parent);
+	if (err) {
+		ret = translate_error(fs, 0, err);
+		goto out2;
+	}
+
+	ret = check_inum_access(ff, parent, A_OK | W_OK);
+	if (ret)
+		goto out2;
+
+	err = fuse4fs_new_child_gid(ff, parent, &gid, &parent_sgid);
+	if (err)
+		goto out2;
+
+	*node_name = a;
+
+	err = ext2fs_mkdir2(fs, parent, 0, 0, EXT2FS_LINK_EXPAND,
+			    node_name, NULL);
+	if (err) {
+		ret = translate_error(fs, parent, err);
+		goto out2;
+	}
+
+	ret = update_mtime(fs, parent, NULL);
+	if (ret)
+		goto out2;
+
+	/* Still have to update the uid/gid of the dir */
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, temp_path,
+			   &child);
+	if (err) {
+		ret = translate_error(fs, 0, err);
+		goto out2;
+	}
+	dbg_printf(ff, "%s: created ino=%d/path=%s in dir=%d\n", __func__, child,
+		   node_name, parent);
+
+	err = fuse4fs_read_inode(fs, child, &inode);
+	if (err) {
+		ret = translate_error(fs, child, err);
+		goto out2;
+	}
+
+	fuse4fs_set_extra_isize(ff, child, &inode);
+	fuse4fs_set_uid(&inode, ctxt->uid);
+	fuse4fs_set_gid(&inode, gid);
+	inode.i_mode = LINUX_S_IFDIR | (mode & ~S_ISUID);
+	if (parent_sgid)
+		inode.i_mode |= S_ISGID;
+	inode.i_generation = ff->next_generation++;
+	init_times(&inode);
+
+	err = fuse4fs_write_inode(fs, child, &inode);
+	if (err) {
+		ret = translate_error(fs, child, err);
+		goto out2;
+	}
+
+	/* Rewrite the directory block checksum, having set i_generation */
+	if ((inode.i_flags & EXT4_INLINE_DATA_FL) ||
+	    !ext2fs_has_feature_metadata_csum(fs->super))
+		goto out2;
+	err = ext2fs_new_dir_block(fs, child, parent, &block);
+	if (err) {
+		ret = translate_error(fs, child, err);
+		goto out2;
+	}
+	err = ext2fs_bmap2(fs, child, EXT2_INODE(&inode), NULL, 0, 0,
+			   NULL, &blk);
+	if (err) {
+		ret = translate_error(fs, child, err);
+		goto out3;
+	}
+	err = ext2fs_write_dir_block4(fs, blk, block, 0, child);
+	if (err) {
+		ret = translate_error(fs, child, err);
+		goto out3;
+	}
+
+	ret = propagate_default_acls(ff, parent, child, inode.i_mode);
+	if (ret)
+		goto out3;
+
+	ret = fuse4fs_dirsync_flush(ff, parent, NULL);
+	if (ret)
+		goto out3;
+
+out3:
+	ext2fs_free_mem(&block);
+out2:
+	fuse4fs_finish(ff, ret);
+out:
+	free(temp_path);
+	return ret;
+}
+
+static int fuse4fs_unlink(struct fuse4fs *ff, const char *path,
+			  ext2_ino_t *parent)
+{
+	ext2_filsys fs = ff->fs;
+	errcode_t err;
+	ext2_ino_t dir;
+	char *filename = strdup(path);
+	char *base_name;
+	int ret;
+
+	base_name = strrchr(filename, '/');
+	if (base_name) {
+		*base_name++ = '\0';
+		err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, filename,
+				   &dir);
+		if (err) {
+			free(filename);
+			return translate_error(fs, 0, err);
+		}
+	} else {
+		dir = EXT2_ROOT_INO;
+		base_name = filename;
+	}
+
+	ret = check_inum_access(ff, dir, W_OK);
+	if (ret) {
+		free(filename);
+		return ret;
+	}
+
+	dbg_printf(ff, "%s: unlinking name=%s from dir=%d\n", __func__,
+		   base_name, dir);
+	err = ext2fs_unlink(fs, dir, base_name, 0, 0);
+	free(filename);
+	if (err)
+		return translate_error(fs, dir, err);
+
+	ret = update_mtime(fs, dir, NULL);
+	if (ret)
+		return ret;
+
+	if (parent)
+		*parent = dir;
+	return 0;
+}
+
+static int remove_ea_inodes(struct fuse4fs *ff, ext2_ino_t ino,
+			    struct ext2_inode_large *inode)
+{
+	ext2_filsys fs = ff->fs;
+	struct ext2_xattr_handle *h;
+	errcode_t err;
+	int ret = 0;
+
+	/*
+	 * The xattr handle maintains its own private copy of the inode, so
+	 * write ours to disk so that we can read it.
+	 */
+	err = fuse4fs_write_inode(fs, ino, inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	err = ext2fs_xattrs_open(fs, ino, &h);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	err = ext2fs_xattrs_read(h);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out_close;
+	}
+
+	err = ext2fs_xattr_remove_all(h);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out_close;
+	}
+
+out_close:
+	ext2fs_xattrs_close(&h);
+	if (ret)
+		return ret;
+
+	/* Now read the inode back in. */
+	err = fuse4fs_read_inode(fs, ino, inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	return 0;
+}
+
+static int remove_inode(struct fuse4fs *ff, ext2_ino_t ino)
+{
+	ext2_filsys fs = ff->fs;
+	errcode_t err;
+	struct ext2_inode_large inode;
+	int ret = 0;
+
+	err = fuse4fs_read_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	dbg_printf(ff, "%s: put ino=%d links=%d\n", __func__, ino,
+		   inode.i_links_count);
+
+	switch (inode.i_links_count) {
+	case 0:
+		return 0; /* XXX: already done? */
+	case 1:
+		inode.i_links_count--;
+		ext2fs_set_dtime(fs, EXT2_INODE(&inode));
+		break;
+	default:
+		inode.i_links_count--;
+	}
+
+	ret = update_ctime(fs, ino, &inode);
+	if (ret)
+		return ret;
+
+	if (inode.i_links_count)
+		goto write_out;
+
+	if (ext2fs_has_feature_ea_inode(fs->super)) {
+		ret = remove_ea_inodes(ff, ino, &inode);
+		if (ret)
+			return ret;
+	}
+
+	/* Nobody holds this file; free its blocks! */
+	err = ext2fs_free_ext_attr(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	if (ext2fs_inode_has_valid_blocks2(fs, EXT2_INODE(&inode))) {
+		err = ext2fs_punch(fs, ino, EXT2_INODE(&inode), NULL,
+				   0, ~0ULL);
+		if (err)
+			return translate_error(fs, ino, err);
+	}
+
+	ext2fs_inode_alloc_stats2(fs, ino, -1,
+				  LINUX_S_ISDIR(inode.i_mode));
+
+write_out:
+	err = fuse4fs_write_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	return 0;
+}
+
+static int __op_unlink(struct fuse4fs *ff, const char *path)
+{
+	ext2_filsys fs = ff->fs;
+	ext2_ino_t parent, ino;
+	errcode_t err;
+	int ret = 0;
+
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
+	if (err) {
+		ret = translate_error(fs, 0, err);
+		goto out;
+	}
+
+	ret = check_inum_access(ff, ino, W_OK);
+	if (ret)
+		goto out;
+
+	ret = fuse4fs_unlink(ff, path, &parent);
+	if (ret)
+		goto out;
+
+	ret = remove_inode(ff, ino);
+	if (ret)
+		goto out;
+
+	ret = fuse4fs_dirsync_flush(ff, parent, NULL);
+	if (ret)
+		goto out;
+
+out:
+	return ret;
+}
+
+static int op_unlink(const char *path)
+{
+	struct fuse4fs *ff = fuse4fs_get();
+	int ret;
+
+	FUSE4FS_CHECK_CONTEXT(ff);
+	fuse4fs_start(ff);
+	ret = __op_unlink(ff, path);
+	fuse4fs_finish(ff, ret);
+	return ret;
+}
+
+struct rd_struct {
+	ext2_ino_t	parent;
+	int		empty;
+};
+
+static int rmdir_proc(ext2_ino_t dir EXT2FS_ATTR((unused)),
+		      int	entry EXT2FS_ATTR((unused)),
+		      struct ext2_dir_entry *dirent,
+		      int	offset EXT2FS_ATTR((unused)),
+		      int	blocksize EXT2FS_ATTR((unused)),
+		      char	*buf EXT2FS_ATTR((unused)),
+		      void	*private)
+{
+	struct rd_struct *rds = (struct rd_struct *) private;
+
+	if (dirent->inode == 0)
+		return 0;
+	if (((dirent->name_len & 0xFF) == 1) && (dirent->name[0] == '.'))
+		return 0;
+	if (((dirent->name_len & 0xFF) == 2) && (dirent->name[0] == '.') &&
+	    (dirent->name[1] == '.')) {
+		rds->parent = dirent->inode;
+		return 0;
+	}
+	rds->empty = 0;
+	return 0;
+}
+
+static int __op_rmdir(struct fuse4fs *ff, const char *path)
+{
+	ext2_filsys fs = ff->fs;
+	ext2_ino_t parent, child;
+	errcode_t err;
+	struct ext2_inode_large inode;
+	struct rd_struct rds;
+	int ret = 0;
+
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &child);
+	if (err) {
+		ret = translate_error(fs, 0, err);
+		goto out;
+	}
+	dbg_printf(ff, "%s: rmdir path=%s ino=%d\n", __func__, path, child);
+
+	ret = check_inum_access(ff, child, W_OK);
+	if (ret)
+		goto out;
+
+	rds.parent = 0;
+	rds.empty = 1;
+
+	err = ext2fs_dir_iterate2(fs, child, 0, 0, rmdir_proc, &rds);
+	if (err) {
+		ret = translate_error(fs, child, err);
+		goto out;
+	}
+
+	/* the kernel checks parent permissions before emptiness */
+	if (rds.parent == 0) {
+		ret = translate_error(fs, child, EXT2_ET_FILESYSTEM_CORRUPTED);
+		goto out;
+	}
+
+	ret = check_inum_access(ff, rds.parent, W_OK);
+	if (ret)
+		goto out;
+
+	if (rds.empty == 0) {
+		ret = -ENOTEMPTY;
+		goto out;
+	}
+
+	ret = fuse4fs_unlink(ff, path, &parent);
+	if (ret)
+		goto out;
+	/* Directories have to be "removed" twice. */
+	ret = remove_inode(ff, child);
+	if (ret)
+		goto out;
+	ret = remove_inode(ff, child);
+	if (ret)
+		goto out;
+
+	if (rds.parent) {
+		dbg_printf(ff, "%s: decr dir=%d link count\n", __func__,
+			   rds.parent);
+		err = fuse4fs_read_inode(fs, rds.parent, &inode);
+		if (err) {
+			ret = translate_error(fs, rds.parent, err);
+			goto out;
+		}
+		if (inode.i_links_count > 1)
+			inode.i_links_count--;
+		ret = update_mtime(fs, rds.parent, &inode);
+		if (ret)
+			goto out;
+		err = fuse4fs_write_inode(fs, rds.parent, &inode);
+		if (err) {
+			ret = translate_error(fs, rds.parent, err);
+			goto out;
+		}
+	}
+
+	ret = fuse4fs_dirsync_flush(ff, parent, NULL);
+	if (ret)
+		goto out;
+
+out:
+	return ret;
+}
+
+static int op_rmdir(const char *path)
+{
+	struct fuse4fs *ff = fuse4fs_get();
+	int ret;
+
+	FUSE4FS_CHECK_CONTEXT(ff);
+	fuse4fs_start(ff);
+	ret = __op_rmdir(ff, path);
+	fuse4fs_finish(ff, ret);
+	return ret;
+}
+
+static int op_symlink(const char *src, const char *dest)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse4fs *ff = fuse4fs_get();
+	ext2_filsys fs;
+	ext2_ino_t parent, child;
+	char *temp_path;
+	errcode_t err;
+	char *node_name, a;
+	struct ext2_inode_large inode;
+	gid_t gid;
+	int ret = 0;
+
+	FUSE4FS_CHECK_CONTEXT(ff);
+	dbg_printf(ff, "%s: symlink %s to %s\n", __func__, src, dest);
+	temp_path = strdup(dest);
+	if (!temp_path) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	node_name = strrchr(temp_path, '/');
+	if (!node_name) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	node_name++;
+	a = *node_name;
+	*node_name = 0;
+
+	fs = fuse4fs_start(ff);
+	if (!fs_can_allocate(ff, 1)) {
+		ret = -ENOSPC;
+		goto out2;
+	}
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, temp_path,
+			   &parent);
+	*node_name = a;
+	if (err) {
+		ret = translate_error(fs, 0, err);
+		goto out2;
+	}
+
+	ret = check_inum_access(ff, parent, A_OK | W_OK);
+	if (ret)
+		goto out2;
+
+	err = fuse4fs_new_child_gid(ff, parent, &gid, NULL);
+	if (err)
+		goto out2;
+
+	/* Create symlink */
+	err = ext2fs_symlink(fs, parent, 0, node_name, src);
+	if (err == EXT2_ET_DIR_NO_SPACE) {
+		err = ext2fs_expand_dir(fs, parent);
+		if (err) {
+			ret = translate_error(fs, parent, err);
+			goto out2;
+		}
+
+		err = ext2fs_symlink(fs, parent, 0, node_name, src);
+	}
+	if (err) {
+		ret = translate_error(fs, parent, err);
+		goto out2;
+	}
+
+	/* Update parent dir's mtime */
+	ret = update_mtime(fs, parent, NULL);
+	if (ret)
+		goto out2;
+
+	/* Still have to update the uid/gid of the symlink */
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, temp_path,
+			   &child);
+	if (err) {
+		ret = translate_error(fs, 0, err);
+		goto out2;
+	}
+	dbg_printf(ff, "%s: symlinking ino=%d/name=%s to dir=%d\n", __func__,
+		   child, node_name, parent);
+
+	err = fuse4fs_read_inode(fs, child, &inode);
+	if (err) {
+		ret = translate_error(fs, child, err);
+		goto out2;
+	}
+
+	fuse4fs_set_extra_isize(ff, child, &inode);
+	fuse4fs_set_uid(&inode, ctxt->uid);
+	fuse4fs_set_gid(&inode, gid);
+	inode.i_generation = ff->next_generation++;
+	init_times(&inode);
+
+	err = fuse4fs_write_inode(fs, child, &inode);
+	if (err) {
+		ret = translate_error(fs, child, err);
+		goto out2;
+	}
+
+	ret = fuse4fs_dirsync_flush(ff, parent, NULL);
+	if (ret)
+		goto out2;
+
+out2:
+	fuse4fs_finish(ff, ret);
+out:
+	free(temp_path);
+	return ret;
+}
+
+struct update_dotdot {
+	ext2_ino_t new_dotdot;
+};
+
+static int update_dotdot_helper(ext2_ino_t dir EXT2FS_ATTR((unused)),
+				int entry EXT2FS_ATTR((unused)),
+				struct ext2_dir_entry *dirent,
+				int offset EXT2FS_ATTR((unused)),
+				int blocksize EXT2FS_ATTR((unused)),
+				char *buf EXT2FS_ATTR((unused)),
+				void *priv_data)
+{
+	struct update_dotdot *ud = priv_data;
+
+	if (ext2fs_dirent_name_len(dirent) == 2 &&
+	    dirent->name[0] == '.' && dirent->name[1] == '.') {
+		dirent->inode = ud->new_dotdot;
+		return DIRENT_CHANGED | DIRENT_ABORT;
+	}
+
+	return 0;
+}
+
+static int op_rename(const char *from, const char *to,
+		     unsigned int flags EXT2FS_ATTR((unused)))
+{
+	struct fuse4fs *ff = fuse4fs_get();
+	ext2_filsys fs;
+	errcode_t err;
+	ext2_ino_t from_ino, to_ino, to_dir_ino, from_dir_ino;
+	char *temp_to = NULL, *temp_from = NULL;
+	char *cp, a;
+	struct ext2_inode inode;
+	struct update_dotdot ud;
+	int flushed = 0;
+	int ret = 0;
+
+	/* renameat2 is not supported */
+	if (flags)
+		return -ENOSYS;
+
+	FUSE4FS_CHECK_CONTEXT(ff);
+	dbg_printf(ff, "%s: renaming %s to %s\n", __func__, from, to);
+	fs = fuse4fs_start(ff);
+	if (!fs_can_allocate(ff, 5)) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, from, &from_ino);
+	if (err || from_ino == 0) {
+		ret = translate_error(fs, 0, err);
+		goto out;
+	}
+
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, to, &to_ino);
+	if (err && err != EXT2_ET_FILE_NOT_FOUND) {
+		ret = translate_error(fs, 0, err);
+		goto out;
+	}
+
+	if (err == EXT2_ET_FILE_NOT_FOUND)
+		to_ino = 0;
+
+	/* Already the same file? */
+	if (to_ino != 0 && to_ino == from_ino) {
+		ret = 0;
+		goto out;
+	}
+
+	ret = check_inum_access(ff, from_ino, W_OK);
+	if (ret)
+		goto out;
+
+	if (to_ino) {
+		ret = check_inum_access(ff, to_ino, W_OK);
+		if (ret)
+			goto out;
+	}
+
+	temp_to = strdup(to);
+	if (!temp_to) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	temp_from = strdup(from);
+	if (!temp_from) {
+		ret = -ENOMEM;
+		goto out2;
+	}
+
+	/* Find parent dir of the source and check write access */
+	cp = strrchr(temp_from, '/');
+	if (!cp) {
+		ret = -EINVAL;
+		goto out2;
+	}
+
+	a = *(cp + 1);
+	*(cp + 1) = 0;
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, temp_from,
+			   &from_dir_ino);
+	*(cp + 1) = a;
+	if (err) {
+		ret = translate_error(fs, 0, err);
+		goto out2;
+	}
+	if (from_dir_ino == 0) {
+		ret = -ENOENT;
+		goto out2;
+	}
+
+	ret = check_inum_access(ff, from_dir_ino, W_OK);
+	if (ret)
+		goto out2;
+
+	/* Find parent dir of the destination and check write access */
+	cp = strrchr(temp_to, '/');
+	if (!cp) {
+		ret = -EINVAL;
+		goto out2;
+	}
+
+	a = *(cp + 1);
+	*(cp + 1) = 0;
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, temp_to,
+			   &to_dir_ino);
+	*(cp + 1) = a;
+	if (err) {
+		ret = translate_error(fs, 0, err);
+		goto out2;
+	}
+	if (to_dir_ino == 0) {
+		ret = -ENOENT;
+		goto out2;
+	}
+
+	ret = check_inum_access(ff, to_dir_ino, W_OK);
+	if (ret)
+		goto out2;
+
+	/* If the target exists, unlink it first */
+	if (to_ino != 0) {
+		err = ext2fs_read_inode(fs, to_ino, &inode);
+		if (err) {
+			ret = translate_error(fs, to_ino, err);
+			goto out2;
+		}
+
+		dbg_printf(ff, "%s: unlinking %s ino=%d\n", __func__,
+			   LINUX_S_ISDIR(inode.i_mode) ? "dir" : "file",
+			   to_ino);
+		if (LINUX_S_ISDIR(inode.i_mode))
+			ret = __op_rmdir(ff, to);
+		else
+			ret = __op_unlink(ff, to);
+		if (ret)
+			goto out2;
+	}
+
+	/* Get ready to do the move */
+	err = ext2fs_read_inode(fs, from_ino, &inode);
+	if (err) {
+		ret = translate_error(fs, from_ino, err);
+		goto out2;
+	}
+
+	/* Link in the new file */
+	dbg_printf(ff, "%s: linking ino=%d/path=%s to dir=%d\n", __func__,
+		   from_ino, cp + 1, to_dir_ino);
+	err = ext2fs_link(fs, to_dir_ino, cp + 1, from_ino,
+			  ext2_file_type(inode.i_mode) | EXT2FS_LINK_EXPAND);
+	if (err) {
+		ret = translate_error(fs, to_dir_ino, err);
+		goto out2;
+	}
+
+	/* Update '..' pointer if dir */
+	err = ext2fs_read_inode(fs, from_ino, &inode);
+	if (err) {
+		ret = translate_error(fs, from_ino, err);
+		goto out2;
+	}
+
+	if (LINUX_S_ISDIR(inode.i_mode)) {
+		ud.new_dotdot = to_dir_ino;
+		dbg_printf(ff, "%s: updating .. entry for dir=%d\n", __func__,
+			   to_dir_ino);
+		err = ext2fs_dir_iterate2(fs, from_ino, 0, NULL,
+					  update_dotdot_helper, &ud);
+		if (err) {
+			ret = translate_error(fs, from_ino, err);
+			goto out2;
+		}
+
+		/* Decrease from_dir_ino's links_count */
+		dbg_printf(ff, "%s: moving linkcount from dir=%d to dir=%d\n",
+			   __func__, from_dir_ino, to_dir_ino);
+		err = ext2fs_read_inode(fs, from_dir_ino, &inode);
+		if (err) {
+			ret = translate_error(fs, from_dir_ino, err);
+			goto out2;
+		}
+		inode.i_links_count--;
+		err = ext2fs_write_inode(fs, from_dir_ino, &inode);
+		if (err) {
+			ret = translate_error(fs, from_dir_ino, err);
+			goto out2;
+		}
+
+		/* Increase to_dir_ino's links_count */
+		err = ext2fs_read_inode(fs, to_dir_ino, &inode);
+		if (err) {
+			ret = translate_error(fs, to_dir_ino, err);
+			goto out2;
+		}
+		inode.i_links_count++;
+		err = ext2fs_write_inode(fs, to_dir_ino, &inode);
+		if (err) {
+			ret = translate_error(fs, to_dir_ino, err);
+			goto out2;
+		}
+	}
+
+	/* Update timestamps */
+	ret = update_ctime(fs, from_ino, NULL);
+	if (ret)
+		goto out2;
+
+	ret = update_mtime(fs, to_dir_ino, NULL);
+	if (ret)
+		goto out2;
+
+	/* Remove the old file */
+	ret = fuse4fs_unlink(ff, from, NULL);
+	if (ret)
+		goto out2;
+
+	ret = fuse4fs_dirsync_flush(ff, from_dir_ino, &flushed);
+	if (ret)
+		goto out2;
+
+	if (from_dir_ino != to_dir_ino && !flushed) {
+		ret = fuse4fs_dirsync_flush(ff, to_dir_ino, NULL);
+		if (ret)
+			goto out2;
+	}
+
+out2:
+	free(temp_from);
+	free(temp_to);
+out:
+	fuse4fs_finish(ff, ret);
+	return ret;
+}
+
+static int op_link(const char *src, const char *dest)
+{
+	struct fuse4fs *ff = fuse4fs_get();
+	ext2_filsys fs;
+	char *temp_path;
+	errcode_t err;
+	char *node_name, a;
+	ext2_ino_t parent, ino;
+	struct ext2_inode_large inode;
+	int ret = 0;
+
+	FUSE4FS_CHECK_CONTEXT(ff);
+	dbg_printf(ff, "%s: src=%s dest=%s\n", __func__, src, dest);
+	temp_path = strdup(dest);
+	if (!temp_path) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	node_name = strrchr(temp_path, '/');
+	if (!node_name) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	node_name++;
+	a = *node_name;
+	*node_name = 0;
+
+	fs = fuse4fs_start(ff);
+	if (!fs_can_allocate(ff, 2)) {
+		ret = -ENOSPC;
+		goto out2;
+	}
+
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, temp_path,
+			   &parent);
+	*node_name = a;
+	if (err) {
+		err = -ENOENT;
+		goto out2;
+	}
+
+	ret = check_inum_access(ff, parent, A_OK | W_OK);
+	if (ret)
+		goto out2;
+
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, src, &ino);
+	if (err || ino == 0) {
+		ret = translate_error(fs, 0, err);
+		goto out2;
+	}
+
+	err = fuse4fs_read_inode(fs, ino, &inode);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out2;
+	}
+
+	ret = check_iflags_access(ff, ino, EXT2_INODE(&inode), W_OK);
+	if (ret)
+		goto out2;
+
+	inode.i_links_count++;
+	ret = update_ctime(fs, ino, &inode);
+	if (ret)
+		goto out2;
+
+	err = fuse4fs_write_inode(fs, ino, &inode);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out2;
+	}
+
+	dbg_printf(ff, "%s: linking ino=%d/name=%s to dir=%d\n", __func__, ino,
+		   node_name, parent);
+	err = ext2fs_link(fs, parent, node_name, ino,
+			  ext2_file_type(inode.i_mode) | EXT2FS_LINK_EXPAND);
+	if (err) {
+		ret = translate_error(fs, parent, err);
+		goto out2;
+	}
+
+	ret = update_mtime(fs, parent, NULL);
+	if (ret)
+		goto out2;
+
+	ret = fuse4fs_dirsync_flush(ff, parent, NULL);
+	if (ret)
+		goto out2;
+
+out2:
+	fuse4fs_finish(ff, ret);
+out:
+	free(temp_path);
+	return ret;
+}
+
+/* Obtain group ids of the process that sent us a command(?) */
+static int get_req_groups(struct fuse4fs *ff, gid_t **gids, size_t *nr_gids)
+{
+	ext2_filsys fs = ff->fs;
+	errcode_t err;
+	gid_t *array;
+	int nr = 32;	/* nobody has more than 32 groups right? */
+	int ret;
+
+	do {
+		err = ext2fs_get_array(nr, sizeof(gid_t), &array);
+		if (err)
+			return translate_error(fs, 0, err);
+
+		ret = fuse_getgroups(nr, array);
+		if (ret < 0) {
+			/*
+			 * If there's an error, we failed to find the group
+			 * membership of the process that initiated the file
+			 * change, either because the process went away or
+			 * because there's no Linux procfs.  Regardless of the
+			 * cause, we return -ENOENT.
+			 */
+			ext2fs_free_mem(&array);
+			return -ENOENT;
+		}
+
+		if (ret <= nr) {
+			*gids = array;
+			*nr_gids = ret;
+			return 0;
+		}
+
+		ext2fs_free_mem(&array);
+		nr = ret;
+	} while (0);
+
+	/* shut up gcc */
+	return -ENOMEM;
+}
+
+/*
+ * Is this file's group id in the set of groups associated with the process
+ * that initiated the fuse request?  Returns 1 for yes, 0 for no, or a negative
+ * errno.
+ */
+static int in_file_group(struct fuse_context *ctxt,
+			 const struct ext2_inode_large *inode)
+{
+	struct fuse4fs *ff = fuse4fs_get();
+	gid_t *gids = NULL;
+	size_t i, nr_gids = 0;
+	gid_t gid = inode_gid(*inode);
+	int ret;
+
+	/* If the inode gid matches the process' primary group, we're done. */
+	if (ctxt->gid == gid)
+		return 1;
+
+	ret = get_req_groups(ff, &gids, &nr_gids);
+	if (ret == -ENOENT) {
+		/* magic return code for "could not get caller group info" */
+		return 0;
+	}
+	if (ret < 0)
+		return ret;
+
+	ret = 0;
+	for (i = 0; i < nr_gids; i++) {
+		if (gids[i] == gid) {
+			ret = 1;
+			break;
+		}
+	}
+
+	ext2fs_free_mem(&gids);
+	return ret;
+}
+
+static int op_chmod(const char *path, mode_t mode, struct fuse_file_info *fi)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse4fs *ff = fuse4fs_get();
+	ext2_filsys fs;
+	errcode_t err;
+	ext2_ino_t ino;
+	struct ext2_inode_large inode;
+	int ret = 0;
+
+	FUSE4FS_CHECK_CONTEXT(ff);
+	fs = fuse4fs_start(ff);
+	ret = fuse4fs_file_ino(ff, path, fi, &ino);
+	if (ret)
+		goto out;
+	dbg_printf(ff, "%s: path=%s mode=0%o ino=%d\n", __func__, path, mode, ino);
+
+	err = fuse4fs_read_inode(fs, ino, &inode);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out;
+	}
+
+	ret = check_iflags_access(ff, ino, EXT2_INODE(&inode), W_OK);
+	if (ret)
+		goto out;
+
+	if (want_check_owner(ff, ctxt) && ctxt->uid != inode_uid(inode)) {
+		ret = -EPERM;
+		goto out;
+	}
+
+	/*
+	 * XXX: We should really check that the inode gid is not in /any/
+	 * of the user's groups, but FUSE only tells us about the primary
+	 * group.
+	 */
+	if (!is_superuser(ff, ctxt)) {
+		ret = in_file_group(ctxt, &inode);
+		if (ret < 0)
+			goto out;
+
+		if (!ret)
+			mode &= ~S_ISGID;
+	}
+
+	inode.i_mode &= ~0xFFF;
+	inode.i_mode |= mode & 0xFFF;
+
+	dbg_printf(ff, "%s: path=%s new_mode=0%o ino=%d\n", __func__,
+		   path, inode.i_mode, ino);
+
+	ret = update_ctime(fs, ino, &inode);
+	if (ret)
+		goto out;
+
+	err = fuse4fs_write_inode(fs, ino, &inode);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out;
+	}
+
+out:
+	fuse4fs_finish(ff, ret);
+	return ret;
+}
+
+static int op_chown(const char *path, uid_t owner, gid_t group,
+		    struct fuse_file_info *fi)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse4fs *ff = fuse4fs_get();
+	ext2_filsys fs;
+	errcode_t err;
+	ext2_ino_t ino;
+	struct ext2_inode_large inode;
+	int ret = 0;
+
+	FUSE4FS_CHECK_CONTEXT(ff);
+	fs = fuse4fs_start(ff);
+	ret = fuse4fs_file_ino(ff, path, fi, &ino);
+	if (ret)
+		goto out;
+	dbg_printf(ff, "%s: path=%s owner=%d group=%d ino=%d\n", __func__,
+		   path, owner, group, ino);
+
+	err = fuse4fs_read_inode(fs, ino, &inode);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out;
+	}
+
+	ret = check_iflags_access(ff, ino, EXT2_INODE(&inode), W_OK);
+	if (ret)
+		goto out;
+
+	/* FUSE seems to feed us ~0 to mean "don't change" */
+	if (owner != (uid_t) ~0) {
+		/* Only root gets to change UID. */
+		if (want_check_owner(ff, ctxt) &&
+		    !(inode_uid(inode) == ctxt->uid && owner == ctxt->uid)) {
+			ret = -EPERM;
+			goto out;
+		}
+		fuse4fs_set_uid(&inode, owner);
+	}
+
+	if (group != (gid_t) ~0) {
+		/* Only root or the owner get to change GID. */
+		if (want_check_owner(ff, ctxt) &&
+		    inode_uid(inode) != ctxt->uid) {
+			ret = -EPERM;
+			goto out;
+		}
+
+		/* XXX: We /should/ check group membership but FUSE */
+		fuse4fs_set_gid(&inode, group);
+	}
+
+	ret = update_ctime(fs, ino, &inode);
+	if (ret)
+		goto out;
+
+	err = fuse4fs_write_inode(fs, ino, &inode);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out;
+	}
+
+out:
+	fuse4fs_finish(ff, ret);
+	return ret;
+}
+
+static int fuse4fs_punch_posteof(struct fuse4fs *ff, ext2_ino_t ino,
+				 off_t new_size)
+{
+	ext2_filsys fs = ff->fs;
+	struct ext2_inode_large inode;
+	blk64_t truncate_block = FUSE4FS_B_TO_FSB(ff, new_size);
+	errcode_t err;
+
+	err = fuse4fs_read_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	err = ext2fs_punch(fs, ino, EXT2_INODE(&inode), 0, truncate_block,
+			   ~0ULL);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	err = fuse4fs_write_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	return 0;
+}
+
+static int fuse4fs_truncate(struct fuse4fs *ff, ext2_ino_t ino, off_t new_size)
+{
+	ext2_filsys fs = ff->fs;
+	ext2_file_t file;
+	__u64 old_isize;
+	errcode_t err;
+	int ret = 0;
+
+	err = ext2fs_file_open(fs, ino, EXT2_FILE_WRITE, &file);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	err = ext2fs_file_get_lsize(file, &old_isize);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out_close;
+	}
+
+	dbg_printf(ff, "%s: ino=%u isize=0x%llx new_size=0x%llx\n", __func__,
+		   ino,
+		   (unsigned long long)old_isize,
+		   (unsigned long long)new_size);
+
+	err = ext2fs_file_set_size2(file, new_size);
+	if (err)
+		ret = translate_error(fs, ino, err);
+
+out_close:
+	err = ext2fs_file_close(file);
+	if (ret)
+		return ret;
+	if (err)
+		return translate_error(fs, ino, err);
+
+	ret = update_mtime(fs, ino, NULL);
+	if (ret)
+		return ret;
+
+	/*
+	 * Truncating to the current size is usually understood to mean that
+	 * we should clear out post-EOF preallocations.
+	 */
+	if (new_size == old_isize)
+		return fuse4fs_punch_posteof(ff, ino, new_size);
+
+	return 0;
+}
+
+static int op_truncate(const char *path, off_t len, struct fuse_file_info *fi)
+{
+	struct fuse4fs *ff = fuse4fs_get();
+	ext2_ino_t ino;
+	int ret = 0;
+
+	FUSE4FS_CHECK_CONTEXT(ff);
+	fuse4fs_start(ff);
+	ret = fuse4fs_file_ino(ff, path, fi, &ino);
+	if (ret)
+		goto out;
+	dbg_printf(ff, "%s: ino=%d len=%jd\n", __func__, ino, (intmax_t) len);
+
+	ret = check_inum_access(ff, ino, W_OK);
+	if (ret)
+		goto out;
+
+	ret = fuse4fs_truncate(ff, ino, len);
+	if (ret)
+		goto out;
+
+out:
+	fuse4fs_finish(ff, ret);
+	return ret;
+}
+
+#ifdef __linux__
+static void detect_linux_executable_open(int kernel_flags, int *access_check,
+				  int *e2fs_open_flags)
+{
+	/*
+	 * On Linux, execve will bleed __FMODE_EXEC into the file mode flags,
+	 * and FUSE is more than happy to let that slip through.
+	 */
+	if (kernel_flags & 0x20) {
+		*access_check = X_OK;
+		*e2fs_open_flags &= ~EXT2_FILE_WRITE;
+	}
+}
+#else
+static void detect_linux_executable_open(int kernel_flags, int *access_check,
+				  int *e2fs_open_flags)
+{
+	/* empty */
+}
+#endif /* __linux__ */
+
+static int __op_open(struct fuse4fs *ff, const char *path,
+		     struct fuse_file_info *fp)
+{
+	ext2_filsys fs = ff->fs;
+	errcode_t err;
+	struct fuse4fs_file_handle *file;
+	int check = 0, ret = 0;
+
+	dbg_printf(ff, "%s: path=%s oflags=0o%o\n", __func__, path, fp->flags);
+	err = ext2fs_get_mem(sizeof(*file), &file);
+	if (err)
+		return translate_error(fs, 0, err);
+	file->magic = FUSE4FS_FILE_MAGIC;
+
+	file->open_flags = 0;
+	switch (fp->flags & O_ACCMODE) {
+	case O_RDONLY:
+		check = R_OK;
+		break;
+	case O_WRONLY:
+		check = W_OK;
+		file->open_flags |= EXT2_FILE_WRITE;
+		break;
+	case O_RDWR:
+		check = R_OK | W_OK;
+		file->open_flags |= EXT2_FILE_WRITE;
+		break;
+	}
+
+	/*
+	 * If the caller wants to truncate the file, we need to ask for full
+	 * write access even if the caller claims to be appending.
+	 */
+	if ((fp->flags & O_APPEND) && !(fp->flags & O_TRUNC))
+		check |= A_OK;
+
+	detect_linux_executable_open(fp->flags, &check, &file->open_flags);
+
+	if (fp->flags & O_CREAT)
+		file->open_flags |= EXT2_FILE_CREATE;
+
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &file->ino);
+	if (err || file->ino == 0) {
+		ret = translate_error(fs, 0, err);
+		goto out;
+	}
+	dbg_printf(ff, "%s: ino=%d\n", __func__, file->ino);
+
+	ret = check_inum_access(ff, file->ino, check);
+	if (ret) {
+		/*
+		 * In a regular (Linux) fs driver, the kernel will open
+		 * binaries for reading if the user has --x privileges (i.e.
+		 * execute without read).  Since the kernel doesn't have any
+		 * way to tell us if it's opening a file via execve, we'll
+		 * just assume that allowing access is ok if asking for ro mode
+		 * fails but asking for x mode succeeds.  Of course we can
+		 * also employ undocumented hacks (see above).
+		 */
+		if (check == R_OK) {
+			ret = check_inum_access(ff, file->ino, X_OK);
+			if (ret)
+				goto out;
+			check = X_OK;
+		} else
+			goto out;
+	}
+
+	if (fp->flags & O_TRUNC) {
+		ret = fuse4fs_truncate(ff, file->ino, 0);
+		if (ret)
+			goto out;
+	}
+
+	file->check_flags = check;
+	fuse4fs_set_handle(fp, file);
+
+out:
+	if (ret)
+		ext2fs_free_mem(&file);
+	return ret;
+}
+
+static int op_open(const char *path, struct fuse_file_info *fp)
+{
+	struct fuse4fs *ff = fuse4fs_get();
+	int ret;
+
+	FUSE4FS_CHECK_CONTEXT(ff);
+	fuse4fs_start(ff);
+	ret = __op_open(ff, path, fp);
+	fuse4fs_finish(ff, ret);
+	return ret;
+}
+
+static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
+		   size_t len, off_t offset,
+		   struct fuse_file_info *fp)
+{
+	struct fuse4fs *ff = fuse4fs_get();
+	struct fuse4fs_file_handle *fh = fuse4fs_get_handle(fp);
+	ext2_filsys fs;
+	ext2_file_t efp;
+	errcode_t err;
+	unsigned int got = 0;
+	int ret = 0;
+
+	FUSE4FS_CHECK_CONTEXT(ff);
+	FUSE4FS_CHECK_HANDLE(ff, fh);
+	dbg_printf(ff, "%s: ino=%d off=0x%llx len=0x%zx\n", __func__, fh->ino,
+		   (unsigned long long)offset, len);
+	fs = fuse4fs_start(ff);
+	err = ext2fs_file_open(fs, fh->ino, fh->open_flags, &efp);
+	if (err) {
+		ret = translate_error(fs, fh->ino, err);
+		goto out;
+	}
+
+	err = ext2fs_file_llseek(efp, offset, SEEK_SET, NULL);
+	if (err) {
+		ret = translate_error(fs, fh->ino, err);
+		goto out2;
+	}
+
+	err = ext2fs_file_read(efp, buf, len, &got);
+	if (err) {
+		ret = translate_error(fs, fh->ino, err);
+		goto out2;
+	}
+
+out2:
+	err = ext2fs_file_close(efp);
+	if (ret)
+		goto out;
+	if (err) {
+		ret = translate_error(fs, fh->ino, err);
+		goto out;
+	}
+
+	if (fh->check_flags != X_OK && fuse4fs_is_writeable(ff)) {
+		ret = update_atime(fs, fh->ino);
+		if (ret)
+			goto out;
+	}
+out:
+	fuse4fs_finish(ff, ret);
+	return got ? (int) got : ret;
+}
+
+static int op_write(const char *path EXT2FS_ATTR((unused)),
+		    const char *buf, size_t len, off_t offset,
+		    struct fuse_file_info *fp)
+{
+	struct fuse4fs *ff = fuse4fs_get();
+	struct fuse4fs_file_handle *fh = fuse4fs_get_handle(fp);
+	ext2_filsys fs;
+	ext2_file_t efp;
+	errcode_t err;
+	unsigned int got = 0;
+	int ret = 0;
+
+	FUSE4FS_CHECK_CONTEXT(ff);
+	FUSE4FS_CHECK_HANDLE(ff, fh);
+	dbg_printf(ff, "%s: ino=%d off=0x%llx len=0x%zx\n", __func__, fh->ino,
+		   (unsigned long long) offset, len);
+	fs = fuse4fs_start(ff);
+	if (!fuse4fs_is_writeable(ff)) {
+		ret = -EROFS;
+		goto out;
+	}
+
+	if (!fs_can_allocate(ff, FUSE4FS_B_TO_FSB(ff, len))) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	err = ext2fs_file_open(fs, fh->ino, fh->open_flags, &efp);
+	if (err) {
+		ret = translate_error(fs, fh->ino, err);
+		goto out;
+	}
+
+	err = ext2fs_file_llseek(efp, offset, SEEK_SET, NULL);
+	if (err) {
+		ret = translate_error(fs, fh->ino, err);
+		goto out2;
+	}
+
+	err = ext2fs_file_write(efp, buf, len, &got);
+	if (err) {
+		ret = translate_error(fs, fh->ino, err);
+		goto out2;
+	}
+
+	err = ext2fs_file_flush(efp);
+	if (err) {
+		got = 0;
+		ret = translate_error(fs, fh->ino, err);
+		goto out2;
+	}
+
+out2:
+	err = ext2fs_file_close(efp);
+	if (ret)
+		goto out;
+	if (err) {
+		ret = translate_error(fs, fh->ino, err);
+		goto out;
+	}
+
+	ret = update_mtime(fs, fh->ino, NULL);
+	if (ret)
+		goto out;
+
+out:
+	fuse4fs_finish(ff, ret);
+	return got ? (int) got : ret;
+}
+
+static int op_release(const char *path EXT2FS_ATTR((unused)),
+		      struct fuse_file_info *fp)
+{
+	struct fuse4fs *ff = fuse4fs_get();
+	struct fuse4fs_file_handle *fh = fuse4fs_get_handle(fp);
+	ext2_filsys fs;
+	errcode_t err;
+	int ret = 0;
+
+	FUSE4FS_CHECK_CONTEXT(ff);
+	FUSE4FS_CHECK_HANDLE(ff, fh);
+	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
+	fs = fuse4fs_start(ff);
+
+	if ((fp->flags & O_SYNC) &&
+	    fuse4fs_is_writeable(ff) &&
+	    (fh->open_flags & EXT2_FILE_WRITE)) {
+		err = ext2fs_flush2(fs, EXT2_FLAG_FLUSH_NO_SYNC);
+		if (err)
+			ret = translate_error(fs, fh->ino, err);
+	}
+
+	fp->fh = 0;
+	fuse4fs_finish(ff, ret);
+
+	ext2fs_free_mem(&fh);
+
+	return ret;
+}
+
+static int op_fsync(const char *path EXT2FS_ATTR((unused)),
+		    int datasync EXT2FS_ATTR((unused)),
+		    struct fuse_file_info *fp)
+{
+	struct fuse4fs *ff = fuse4fs_get();
+	struct fuse4fs_file_handle *fh = fuse4fs_get_handle(fp);
+	ext2_filsys fs;
+	errcode_t err;
+	int ret = 0;
+
+	FUSE4FS_CHECK_CONTEXT(ff);
+	FUSE4FS_CHECK_HANDLE(ff, fh);
+	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
+	fs = fuse4fs_start(ff);
+	/* For now, flush everything, even if it's slow */
+	if (fuse4fs_is_writeable(ff) && fh->open_flags & EXT2_FILE_WRITE) {
+		err = ext2fs_flush2(fs, 0);
+		if (err)
+			ret = translate_error(fs, fh->ino, err);
+	}
+	fuse4fs_finish(ff, ret);
+
+	return ret;
+}
+
+static int op_statfs(const char *path EXT2FS_ATTR((unused)),
+		     struct statvfs *buf)
+{
+	struct fuse4fs *ff = fuse4fs_get();
+	ext2_filsys fs;
+	uint64_t fsid, *f;
+	blk64_t overhead, reserved, free;
+
+	FUSE4FS_CHECK_CONTEXT(ff);
+	dbg_printf(ff, "%s: path=%s\n", __func__, path);
+	fs = fuse4fs_start(ff);
+	buf->f_bsize = fs->blocksize;
+	buf->f_frsize = 0;
+
+	if (ff->minixdf)
+		overhead = 0;
+	else
+		overhead = fs->desc_blocks +
+			   (blk64_t)fs->group_desc_count *
+			   (fs->inode_blocks_per_group + 2);
+	reserved = ext2fs_r_blocks_count(fs->super);
+	if (!reserved)
+		reserved = ext2fs_blocks_count(fs->super) / 10;
+	free = ext2fs_free_blocks_count(fs->super);
+
+	buf->f_blocks = ext2fs_blocks_count(fs->super) - overhead;
+	buf->f_bfree = free;
+	if (free < reserved)
+		buf->f_bavail = 0;
+	else
+		buf->f_bavail = free - reserved;
+	buf->f_files = fs->super->s_inodes_count;
+	buf->f_ffree = fs->super->s_free_inodes_count;
+	buf->f_favail = fs->super->s_free_inodes_count;
+	f = (uint64_t *)fs->super->s_uuid;
+	fsid = *f;
+	f++;
+	fsid ^= *f;
+	buf->f_fsid = fsid;
+	buf->f_flag = 0;
+	if (ff->opstate != F4OP_WRITABLE)
+		buf->f_flag |= ST_RDONLY;
+	buf->f_namemax = EXT2_NAME_LEN;
+	fuse4fs_finish(ff, 0);
+
+	return 0;
+}
+
+static const char *valid_xattr_prefixes[] = {
+	"user.",
+	"trusted.",
+	"security.",
+	"gnu.",
+	"system.",
+};
+
+static int validate_xattr_name(const char *name)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(valid_xattr_prefixes); i++) {
+		if (!strncmp(name, valid_xattr_prefixes[i],
+					strlen(valid_xattr_prefixes[i])))
+			return 1;
+	}
+
+	return 0;
+}
+
+static int op_getxattr(const char *path, const char *key, char *value,
+		       size_t len)
+{
+	struct fuse4fs *ff = fuse4fs_get();
+	ext2_filsys fs;
+	void *ptr;
+	size_t plen;
+	ext2_ino_t ino;
+	errcode_t err;
+	int ret = 0;
+
+	if (!validate_xattr_name(key))
+		return -ENODATA;
+
+	FUSE4FS_CHECK_CONTEXT(ff);
+	fs = fuse4fs_start(ff);
+	if (!ext2fs_has_feature_xattr(fs->super)) {
+		ret = -ENOTSUP;
+		goto out;
+	}
+
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
+	if (err || ino == 0) {
+		ret = translate_error(fs, 0, err);
+		goto out;
+	}
+	dbg_printf(ff, "%s: ino=%d name=%s\n", __func__, ino, key);
+
+	ret = check_inum_access(ff, ino, R_OK);
+	if (ret)
+		goto out;
+
+	ret = __getxattr(ff, ino, key, &ptr, &plen);
+	if (ret)
+		goto out;
+
+	if (!len) {
+		ret = plen;
+	} else if (len < plen) {
+		ret = -ERANGE;
+	} else {
+		memcpy(value, ptr, plen);
+		ret = plen;
+	}
+
+	ext2fs_free_mem(&ptr);
+out:
+	fuse4fs_finish(ff, ret);
+
+	return ret;
+}
+
+static int count_buffer_space(char *name, char *value EXT2FS_ATTR((unused)),
+			      size_t value_len EXT2FS_ATTR((unused)),
+			      void *data)
+{
+	unsigned int *x = data;
+
+	*x = *x + strlen(name) + 1;
+	return 0;
+}
+
+static int copy_names(char *name, char *value EXT2FS_ATTR((unused)),
+		      size_t value_len EXT2FS_ATTR((unused)), void *data)
+{
+	char **b = data;
+	size_t name_len = strlen(name);
+
+	memcpy(*b, name, name_len + 1);
+	*b = *b + name_len + 1;
+
+	return 0;
+}
+
+static int op_listxattr(const char *path, char *names, size_t len)
+{
+	struct fuse4fs *ff = fuse4fs_get();
+	ext2_filsys fs;
+	struct ext2_xattr_handle *h;
+	unsigned int bufsz;
+	ext2_ino_t ino;
+	errcode_t err;
+	int ret = 0;
+
+	FUSE4FS_CHECK_CONTEXT(ff);
+	fs = fuse4fs_start(ff);
+	if (!ext2fs_has_feature_xattr(fs->super)) {
+		ret = -ENOTSUP;
+		goto out;
+	}
+
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
+	if (err || ino == 0) {
+		ret = translate_error(fs, ino, err);
+		goto out;
+	}
+	dbg_printf(ff, "%s: ino=%d\n", __func__, ino);
+
+	ret = check_inum_access(ff, ino, R_OK);
+	if (ret)
+		goto out;
+
+	err = ext2fs_xattrs_open(fs, ino, &h);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out;
+	}
+
+	err = ext2fs_xattrs_read(h);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out2;
+	}
+
+	/* Count buffer space needed for names */
+	bufsz = 0;
+	err = ext2fs_xattrs_iterate(h, count_buffer_space, &bufsz);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out2;
+	}
+
+	if (len == 0) {
+		ret = bufsz;
+		goto out2;
+	} else if (len < bufsz) {
+		ret = -ERANGE;
+		goto out2;
+	}
+
+	/* Copy names out */
+	memset(names, 0, len);
+	err = ext2fs_xattrs_iterate(h, copy_names, &names);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out2;
+	}
+	ret = bufsz;
+out2:
+	err = ext2fs_xattrs_close(&h);
+	if (err && !ret)
+		ret = translate_error(fs, ino, err);
+out:
+	fuse4fs_finish(ff, ret);
+
+	return ret;
+}
+
+static int op_setxattr(const char *path EXT2FS_ATTR((unused)),
+		       const char *key, const char *value,
+		       size_t len, int flags)
+{
+	struct fuse4fs *ff = fuse4fs_get();
+	ext2_filsys fs;
+	struct ext2_xattr_handle *h;
+	ext2_ino_t ino;
+	errcode_t err;
+	int ret = 0;
+
+	if (flags & ~(XATTR_CREATE | XATTR_REPLACE))
+		return -EOPNOTSUPP;
+
+	if (!validate_xattr_name(key))
+		return -EINVAL;
+
+	FUSE4FS_CHECK_CONTEXT(ff);
+	fs = fuse4fs_start(ff);
+	if (!ext2fs_has_feature_xattr(fs->super)) {
+		ret = -ENOTSUP;
+		goto out;
+	}
+
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
+	if (err || ino == 0) {
+		ret = translate_error(fs, 0, err);
+		goto out;
+	}
+	dbg_printf(ff, "%s: ino=%d name=%s\n", __func__, ino, key);
+
+	ret = check_inum_access(ff, ino, W_OK);
+	if (ret == -EACCES) {
+		ret = -EPERM;
+		goto out;
+	} else if (ret)
+		goto out;
+
+	err = ext2fs_xattrs_open(fs, ino, &h);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out;
+	}
+
+	err = ext2fs_xattrs_read(h);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out2;
+	}
+
+	if (flags & (XATTR_CREATE | XATTR_REPLACE)) {
+		void *buf;
+		size_t buflen;
+
+		err = ext2fs_xattr_get(h, key, &buf, &buflen);
+		switch (err) {
+		case EXT2_ET_EA_KEY_NOT_FOUND:
+			if (flags & XATTR_REPLACE) {
+				ret = -ENODATA;
+				goto out2;
+			}
+			break;
+		case 0:
+			ext2fs_free_mem(&buf);
+			if (flags & XATTR_CREATE) {
+				ret = -EEXIST;
+				goto out2;
+			}
+			break;
+		default:
+			ret = translate_error(fs, ino, err);
+			goto out2;
+		}
+	}
+
+	err = ext2fs_xattr_set(h, key, value, len);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out2;
+	}
+
+	ret = update_ctime(fs, ino, NULL);
+out2:
+	err = ext2fs_xattrs_close(&h);
+	if (!ret && err)
+		ret = translate_error(fs, ino, err);
+out:
+	fuse4fs_finish(ff, ret);
+
+	return ret;
+}
+
+static int op_removexattr(const char *path, const char *key)
+{
+	struct fuse4fs *ff = fuse4fs_get();
+	ext2_filsys fs;
+	struct ext2_xattr_handle *h;
+	void *buf;
+	size_t buflen;
+	ext2_ino_t ino;
+	errcode_t err;
+	int ret = 0;
+
+	/*
+	 * Once in a while libfuse gives us a no-name xattr to delete as part
+	 * of clearing ACLs.  Just pretend we cleared them.
+	 */
+	if (key[0] == 0)
+		return 0;
+
+	if (!validate_xattr_name(key))
+		return -ENODATA;
+
+	FUSE4FS_CHECK_CONTEXT(ff);
+	fs = fuse4fs_start(ff);
+	if (!ext2fs_has_feature_xattr(fs->super)) {
+		ret = -ENOTSUP;
+		goto out;
+	}
+
+	if (!fs_can_allocate(ff, 1)) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
+	if (err || ino == 0) {
+		ret = translate_error(fs, 0, err);
+		goto out;
+	}
+	dbg_printf(ff, "%s: ino=%d name=%s\n", __func__, ino, key);
+
+	ret = check_inum_access(ff, ino, W_OK);
+	if (ret)
+		goto out;
+
+	err = ext2fs_xattrs_open(fs, ino, &h);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out;
+	}
+
+	err = ext2fs_xattrs_read(h);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out2;
+	}
+
+	err = ext2fs_xattr_get(h, key, &buf, &buflen);
+	switch (err) {
+	case EXT2_ET_EA_KEY_NOT_FOUND:
+		/*
+		 * ACLs are special snowflakes that require a 0 return when
+		 * the ACL never existed in the first place.
+		 */
+		if (!strncmp(XATTR_SECURITY_PREFIX, key,
+			     XATTR_SECURITY_PREFIX_LEN))
+			ret = 0;
+		else
+			ret = -ENODATA;
+		goto out2;
+	case 0:
+		ext2fs_free_mem(&buf);
+		break;
+	default:
+		ret = translate_error(fs, ino, err);
+		goto out2;
+	}
+
+	err = ext2fs_xattr_remove(h, key);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out2;
+	}
+
+	ret = update_ctime(fs, ino, NULL);
+out2:
+	err = ext2fs_xattrs_close(&h);
+	if (err && !ret)
+		ret = translate_error(fs, ino, err);
+out:
+	fuse4fs_finish(ff, ret);
+
+	return ret;
+}
+
+struct readdir_iter {
+	void *buf;
+	ext2_filsys fs;
+	fuse_fill_dir_t func;
+
+	struct fuse4fs *ff;
+	enum fuse_readdir_flags flags;
+	unsigned int nr;
+	off_t startpos;
+	off_t dirpos;
+};
+
+static inline mode_t dirent_fmode(ext2_filsys fs,
+				   const struct ext2_dir_entry *dirent)
+{
+	if (!ext2fs_has_feature_filetype(fs->super))
+		return 0;
+
+	switch (ext2fs_dirent_file_type(dirent)) {
+	case EXT2_FT_REG_FILE:
+		return S_IFREG;
+	case EXT2_FT_DIR:
+		return S_IFDIR;
+	case EXT2_FT_CHRDEV:
+		return S_IFCHR;
+	case EXT2_FT_BLKDEV:
+		return S_IFBLK;
+	case EXT2_FT_FIFO:
+		return S_IFIFO;
+	case EXT2_FT_SOCK:
+		return S_IFSOCK;
+	case EXT2_FT_SYMLINK:
+		return S_IFLNK;
+	}
+
+	return 0;
+}
+
+static int op_readdir_iter(ext2_ino_t dir EXT2FS_ATTR((unused)),
+			   int entry EXT2FS_ATTR((unused)),
+			   struct ext2_dir_entry *dirent,
+			   int offset EXT2FS_ATTR((unused)),
+			   int blocksize EXT2FS_ATTR((unused)),
+			   char *buf EXT2FS_ATTR((unused)), void *data)
+{
+	struct readdir_iter *i = data;
+	char namebuf[EXT2_NAME_LEN + 1];
+	struct stat stat = {
+		.st_ino = dirent->inode,
+		.st_mode = dirent_fmode(i->fs, dirent),
+	};
+	int ret;
+
+	i->dirpos++;
+	if (i->startpos >= i->dirpos)
+		return 0;
+
+	dbg_printf(i->ff, "READDIR%s ino=%d %u offset=0x%llx\n",
+			i->flags == FUSE_READDIR_PLUS ? "PLUS" : "",
+			dir,
+			i->nr++,
+			(unsigned long long)i->dirpos);
+
+	if (i->flags == FUSE_READDIR_PLUS) {
+		ret = stat_inode(i->fs, dirent->inode, &stat);
+		if (ret)
+			return DIRENT_ABORT;
+	}
+
+	memcpy(namebuf, dirent->name, dirent->name_len & 0xFF);
+	namebuf[dirent->name_len & 0xFF] = 0;
+	ret = i->func(i->buf, namebuf, &stat, i->dirpos , 0);
+	if (ret)
+		return DIRENT_ABORT;
+
+	return 0;
+}
+
+static int op_readdir(const char *path EXT2FS_ATTR((unused)), void *buf,
+		      fuse_fill_dir_t fill_func, off_t offset,
+		      struct fuse_file_info *fp, enum fuse_readdir_flags flags)
+{
+	struct fuse4fs *ff = fuse4fs_get();
+	struct fuse4fs_file_handle *fh = fuse4fs_get_handle(fp);
+	errcode_t err;
+	struct readdir_iter i = {
+		.ff = ff,
+		.dirpos = 0,
+		.startpos = offset,
+		.flags = flags,
+	};
+	int ret = 0;
+
+	FUSE4FS_CHECK_CONTEXT(ff);
+	FUSE4FS_CHECK_HANDLE(ff, fh);
+	dbg_printf(ff, "%s: ino=%d offset=0x%llx\n", __func__, fh->ino,
+			(unsigned long long)offset);
+	i.fs = fuse4fs_start(ff);
+	i.buf = buf;
+	i.func = fill_func;
+	err = ext2fs_dir_iterate2(i.fs, fh->ino, 0, NULL, op_readdir_iter, &i);
+	if (err) {
+		ret = translate_error(i.fs, fh->ino, err);
+		goto out;
+	}
+
+	if (fuse4fs_is_writeable(ff)) {
+		ret = update_atime(i.fs, fh->ino);
+		if (ret)
+			goto out;
+	}
+out:
+	fuse4fs_finish(ff, ret);
+	return ret;
+}
+
+static int op_access(const char *path, int mask)
+{
+	struct fuse4fs *ff = fuse4fs_get();
+	ext2_filsys fs;
+	errcode_t err;
+	ext2_ino_t ino;
+	int ret = 0;
+
+	FUSE4FS_CHECK_CONTEXT(ff);
+	dbg_printf(ff, "%s: path=%s mask=0x%x\n", __func__, path, mask);
+	fs = fuse4fs_start(ff);
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
+	if (err || ino == 0) {
+		ret = translate_error(fs, 0, err);
+		goto out;
+	}
+
+	ret = check_inum_access(ff, ino, mask);
+	if (ret)
+		goto out;
+
+out:
+	fuse4fs_finish(ff, ret);
+	return ret;
+}
+
+static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse4fs *ff = fuse4fs_get();
+	ext2_filsys fs;
+	ext2_ino_t parent, child;
+	char *temp_path;
+	errcode_t err;
+	char *node_name, a;
+	int filetype;
+	struct ext2_inode_large inode;
+	gid_t gid;
+	int ret = 0;
+
+	FUSE4FS_CHECK_CONTEXT(ff);
+	dbg_printf(ff, "%s: path=%s mode=0%o\n", __func__, path, mode);
+	temp_path = strdup(path);
+	if (!temp_path) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	node_name = strrchr(temp_path, '/');
+	if (!node_name) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	node_name++;
+	a = *node_name;
+	*node_name = 0;
+
+	fs = fuse4fs_start(ff);
+	if (!fs_can_allocate(ff, 1)) {
+		ret = -ENOSPC;
+		goto out2;
+	}
+
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, temp_path,
+			   &parent);
+	if (err) {
+		ret = translate_error(fs, 0, err);
+		goto out2;
+	}
+
+	ret = check_inum_access(ff, parent, A_OK | W_OK);
+	if (ret)
+		goto out2;
+
+	err = fuse4fs_new_child_gid(ff, parent, &gid, NULL);
+	if (err)
+		goto out2;
+
+	*node_name = a;
+
+	filetype = ext2_file_type(mode);
+
+	err = ext2fs_new_inode(fs, parent, mode, 0, &child);
+	if (err) {
+		ret = translate_error(fs, parent, err);
+		goto out2;
+	}
+
+	dbg_printf(ff, "%s: creating ino=%d/name=%s in dir=%d\n", __func__, child,
+		   node_name, parent);
+	err = ext2fs_link(fs, parent, node_name, child,
+			  filetype | EXT2FS_LINK_EXPAND);
+	if (err) {
+		ret = translate_error(fs, parent, err);
+		goto out2;
+	}
+
+	ret = update_mtime(fs, parent, NULL);
+	if (ret)
+		goto out2;
+
+	memset(&inode, 0, sizeof(inode));
+	inode.i_mode = mode;
+	inode.i_links_count = 1;
+	fuse4fs_set_extra_isize(ff, child, &inode);
+	fuse4fs_set_uid(&inode, ctxt->uid);
+	fuse4fs_set_gid(&inode, gid);
+	if (ext2fs_has_feature_extents(fs->super)) {
+		ext2_extent_handle_t handle;
+
+		inode.i_flags &= ~EXT4_EXTENTS_FL;
+		ret = ext2fs_extent_open2(fs, child,
+					  EXT2_INODE(&inode), &handle);
+		if (ret) {
+			ret = translate_error(fs, child, err);
+			goto out2;
+		}
+
+		ext2fs_extent_free(handle);
+	}
+
+	err = ext2fs_write_new_inode(fs, child, EXT2_INODE(&inode));
+	if (err) {
+		ret = translate_error(fs, child, err);
+		goto out2;
+	}
+
+	inode.i_generation = ff->next_generation++;
+	init_times(&inode);
+	err = fuse4fs_write_inode(fs, child, &inode);
+	if (err) {
+		ret = translate_error(fs, child, err);
+		goto out2;
+	}
+
+	ext2fs_inode_alloc_stats2(fs, child, 1, 0);
+
+	ret = propagate_default_acls(ff, parent, child, inode.i_mode);
+	if (ret)
+		goto out2;
+
+	fp->flags &= ~O_TRUNC;
+	ret = __op_open(ff, path, fp);
+	if (ret)
+		goto out2;
+
+	ret = fuse4fs_dirsync_flush(ff, parent, NULL);
+	if (ret)
+		goto out2;
+
+out2:
+	fuse4fs_finish(ff, ret);
+out:
+	free(temp_path);
+	return ret;
+}
+
+static int op_utimens(const char *path, const struct timespec ctv[2],
+		      struct fuse_file_info *fi)
+{
+	struct fuse4fs *ff = fuse4fs_get();
+	struct timespec tv[2];
+	ext2_filsys fs;
+	errcode_t err;
+	ext2_ino_t ino;
+	struct ext2_inode_large inode;
+	int access = W_OK;
+	int ret = 0;
+
+	FUSE4FS_CHECK_CONTEXT(ff);
+	fs = fuse4fs_start(ff);
+	ret = fuse4fs_file_ino(ff, path, fi, &ino);
+	if (ret)
+		goto out;
+	dbg_printf(ff, "%s: ino=%d atime=%lld.%ld mtime=%lld.%ld\n", __func__,
+			ino,
+			(long long int)ctv[0].tv_sec, ctv[0].tv_nsec,
+			(long long int)ctv[1].tv_sec, ctv[1].tv_nsec);
+
+	/*
+	 * ext4 allows timestamp updates of append-only files but only if we're
+	 * setting to current time
+	 */
+	if (ctv[0].tv_nsec == UTIME_NOW && ctv[1].tv_nsec == UTIME_NOW)
+		access |= A_OK;
+	ret = check_inum_access(ff, ino, access);
+	if (ret)
+		goto out;
+
+	err = fuse4fs_read_inode(fs, ino, &inode);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out;
+	}
+
+	tv[0] = ctv[0];
+	tv[1] = ctv[1];
+#ifdef UTIME_NOW
+	if (tv[0].tv_nsec == UTIME_NOW)
+		get_now(tv);
+	if (tv[1].tv_nsec == UTIME_NOW)
+		get_now(tv + 1);
+#endif /* UTIME_NOW */
+#ifdef UTIME_OMIT
+	if (tv[0].tv_nsec != UTIME_OMIT)
+		EXT4_INODE_SET_XTIME(i_atime, &tv[0], &inode);
+	if (tv[1].tv_nsec != UTIME_OMIT)
+		EXT4_INODE_SET_XTIME(i_mtime, &tv[1], &inode);
+#endif /* UTIME_OMIT */
+	ret = update_ctime(fs, ino, &inode);
+	if (ret)
+		goto out;
+
+	err = fuse4fs_write_inode(fs, ino, &inode);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out;
+	}
+
+out:
+	fuse4fs_finish(ff, ret);
+	return ret;
+}
+
+#define FUSE4FS_MODIFIABLE_IFLAGS \
+	(EXT2_FL_USER_MODIFIABLE & ~(EXT4_EXTENTS_FL | EXT4_CASEFOLD_FL | \
+				     EXT3_JOURNAL_DATA_FL))
+
+static inline int set_iflags(struct ext2_inode_large *inode, __u32 iflags)
+{
+	if ((inode->i_flags ^ iflags) & ~FUSE4FS_MODIFIABLE_IFLAGS)
+		return -EINVAL;
+
+	inode->i_flags = (inode->i_flags & ~FUSE4FS_MODIFIABLE_IFLAGS) |
+			 (iflags & FUSE4FS_MODIFIABLE_IFLAGS);
+	return 0;
+}
+
+#ifdef SUPPORT_I_FLAGS
+static int ioctl_getflags(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
+			  void *data)
+{
+	ext2_filsys fs = ff->fs;
+	errcode_t err;
+	struct ext2_inode_large inode;
+
+	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
+	err = fuse4fs_read_inode(fs, fh->ino, &inode);
+	if (err)
+		return translate_error(fs, fh->ino, err);
+
+	*(__u32 *)data = inode.i_flags & EXT2_FL_USER_VISIBLE;
+	return 0;
+}
+
+static int ioctl_setflags(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
+			  void *data)
+{
+	ext2_filsys fs = ff->fs;
+	errcode_t err;
+	struct ext2_inode_large inode;
+	int ret;
+	__u32 flags = *(__u32 *)data;
+	struct fuse_context *ctxt = fuse_get_context();
+
+	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
+	err = fuse4fs_read_inode(fs, fh->ino, &inode);
+	if (err)
+		return translate_error(fs, fh->ino, err);
+
+	if (want_check_owner(ff, ctxt) && inode_uid(inode) != ctxt->uid)
+		return -EPERM;
+
+	ret = set_iflags(&inode, flags);
+	if (ret)
+		return ret;
+
+	ret = update_ctime(fs, fh->ino, &inode);
+	if (ret)
+		return ret;
+
+	err = fuse4fs_write_inode(fs, fh->ino, &inode);
+	if (err)
+		return translate_error(fs, fh->ino, err);
+
+	return 0;
+}
+
+static int ioctl_getversion(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
+			    void *data)
+{
+	ext2_filsys fs = ff->fs;
+	errcode_t err;
+	struct ext2_inode_large inode;
+
+	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
+	err = fuse4fs_read_inode(fs, fh->ino, &inode);
+	if (err)
+		return translate_error(fs, fh->ino, err);
+
+	*(__u32 *)data = inode.i_generation;
+	return 0;
+}
+
+static int ioctl_setversion(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
+			    void *data)
+{
+	ext2_filsys fs = ff->fs;
+	errcode_t err;
+	struct ext2_inode_large inode;
+	int ret;
+	__u32 generation = *(__u32 *)data;
+	struct fuse_context *ctxt = fuse_get_context();
+
+	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
+	err = fuse4fs_read_inode(fs, fh->ino, &inode);
+	if (err)
+		return translate_error(fs, fh->ino, err);
+
+	if (want_check_owner(ff, ctxt) && inode_uid(inode) != ctxt->uid)
+		return -EPERM;
+
+	inode.i_generation = generation;
+
+	ret = update_ctime(fs, fh->ino, &inode);
+	if (ret)
+		return ret;
+
+	err = fuse4fs_write_inode(fs, fh->ino, &inode);
+	if (err)
+		return translate_error(fs, fh->ino, err);
+
+	return 0;
+}
+#endif /* SUPPORT_I_FLAGS */
+
+#ifdef FS_IOC_FSGETXATTR
+static __u32 iflags_to_fsxflags(__u32 iflags)
+{
+	__u32 xflags = 0;
+
+	if (iflags & FS_SYNC_FL)
+		xflags |= FS_XFLAG_SYNC;
+	if (iflags & FS_IMMUTABLE_FL)
+		xflags |= FS_XFLAG_IMMUTABLE;
+	if (iflags & FS_APPEND_FL)
+		xflags |= FS_XFLAG_APPEND;
+	if (iflags & FS_NODUMP_FL)
+		xflags |= FS_XFLAG_NODUMP;
+	if (iflags & FS_NOATIME_FL)
+		xflags |= FS_XFLAG_NOATIME;
+	if (iflags & FS_DAX_FL)
+		xflags |= FS_XFLAG_DAX;
+	if (iflags & FS_PROJINHERIT_FL)
+		xflags |= FS_XFLAG_PROJINHERIT;
+	return xflags;
+}
+
+static int ioctl_fsgetxattr(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
+			    void *data)
+{
+	ext2_filsys fs = ff->fs;
+	errcode_t err;
+	struct ext2_inode_large inode;
+	struct fsxattr *fsx = data;
+	unsigned int inode_size;
+
+	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
+	err = fuse4fs_read_inode(fs, fh->ino, &inode);
+	if (err)
+		return translate_error(fs, fh->ino, err);
+
+	memset(fsx, 0, sizeof(*fsx));
+	inode_size = EXT2_GOOD_OLD_INODE_SIZE + inode.i_extra_isize;
+	if (ext2fs_inode_includes(inode_size, i_projid))
+		fsx->fsx_projid = inode_projid(inode);
+	fsx->fsx_xflags = iflags_to_fsxflags(inode.i_flags);
+	return 0;
+}
+
+static __u32 fsxflags_to_iflags(__u32 xflags)
+{
+	__u32 iflags = 0;
+
+	if (xflags & FS_XFLAG_IMMUTABLE)
+		iflags |= FS_IMMUTABLE_FL;
+	if (xflags & FS_XFLAG_APPEND)
+		iflags |= FS_APPEND_FL;
+	if (xflags & FS_XFLAG_SYNC)
+		iflags |= FS_SYNC_FL;
+	if (xflags & FS_XFLAG_NOATIME)
+		iflags |= FS_NOATIME_FL;
+	if (xflags & FS_XFLAG_NODUMP)
+		iflags |= FS_NODUMP_FL;
+	if (xflags & FS_XFLAG_DAX)
+		iflags |= FS_DAX_FL;
+	if (xflags & FS_XFLAG_PROJINHERIT)
+		iflags |= FS_PROJINHERIT_FL;
+	return iflags;
+}
+
+#define FUSE4FS_MODIFIABLE_XFLAGS (FS_XFLAG_IMMUTABLE | \
+				   FS_XFLAG_APPEND | \
+				   FS_XFLAG_SYNC | \
+				   FS_XFLAG_NOATIME | \
+				   FS_XFLAG_NODUMP | \
+				   FS_XFLAG_PROJINHERIT)
+
+#define FUSE4FS_MODIFIABLE_IXFLAGS (FS_IMMUTABLE_FL | \
+				    FS_APPEND_FL | \
+				    FS_SYNC_FL | \
+				    FS_NOATIME_FL | \
+				    FS_NODUMP_FL | \
+				    FS_PROJINHERIT_FL)
+
+static inline int set_xflags(struct ext2_inode_large *inode, __u32 xflags)
+{
+	__u32 iflags;
+
+	if (xflags & ~FUSE4FS_MODIFIABLE_XFLAGS)
+		return -EINVAL;
+
+	iflags = fsxflags_to_iflags(xflags);
+	inode->i_flags = (inode->i_flags & ~FUSE4FS_MODIFIABLE_IXFLAGS) |
+			 (iflags & FUSE4FS_MODIFIABLE_IXFLAGS);
+	return 0;
+}
+
+static int ioctl_fssetxattr(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
+			    void *data)
+{
+	ext2_filsys fs = ff->fs;
+	errcode_t err;
+	struct ext2_inode_large inode;
+	int ret;
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fsxattr *fsx = data;
+	unsigned int inode_size;
+
+	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
+	err = fuse4fs_read_inode(fs, fh->ino, &inode);
+	if (err)
+		return translate_error(fs, fh->ino, err);
+
+	if (want_check_owner(ff, ctxt) && inode_uid(inode) != ctxt->uid)
+		return -EPERM;
+
+	ret = set_xflags(&inode, fsx->fsx_xflags);
+	if (ret)
+		return ret;
+
+	inode_size = EXT2_GOOD_OLD_INODE_SIZE + inode.i_extra_isize;
+	if (ext2fs_inode_includes(inode_size, i_projid))
+		inode.i_projid = fsx->fsx_projid;
+
+	ret = update_ctime(fs, fh->ino, &inode);
+	if (ret)
+		return ret;
+
+	err = fuse4fs_write_inode(fs, fh->ino, &inode);
+	if (err)
+		return translate_error(fs, fh->ino, err);
+
+	return 0;
+}
+#endif /* FS_IOC_FSGETXATTR */
+
+#ifdef FITRIM
+static int ioctl_fitrim(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
+			void *data)
+{
+	ext2_filsys fs = ff->fs;
+	struct fstrim_range *fr = data;
+	blk64_t start, end, max_blocks, b, cleared, minlen;
+	blk64_t max_blks = ext2fs_blocks_count(fs->super);
+	errcode_t err = 0;
+
+	if (!fuse4fs_is_writeable(ff))
+		return -EROFS;
+
+	start = FUSE4FS_B_TO_FSBT(ff, fr->start);
+	if (fr->len == -1ULL)
+		end = -1ULL;
+	else
+		end = FUSE4FS_B_TO_FSBT(ff, fr->start + fr->len - 1);
+	minlen = FUSE4FS_B_TO_FSBT(ff, fr->minlen);
+
+	if (EXT2FS_NUM_B2C(fs, minlen) > EXT2_CLUSTERS_PER_GROUP(fs->super) ||
+	    start >= max_blks ||
+	    fr->len < fs->blocksize)
+		return -EINVAL;
+
+	dbg_printf(ff, "%s: start=0x%llx end=0x%llx minlen=0x%llx\n", __func__,
+		   start, end, minlen);
+
+	if (start < fs->super->s_first_data_block)
+		start = fs->super->s_first_data_block;
+
+	if (end < fs->super->s_first_data_block)
+		end = fs->super->s_first_data_block;
+	if (end >= ext2fs_blocks_count(fs->super))
+		end = ext2fs_blocks_count(fs->super) - 1;
+
+	cleared = 0;
+	max_blocks = FUSE4FS_B_TO_FSBT(ff, 2048ULL * 1024 * 1024);
+
+	fr->len = 0;
+	while (start <= end) {
+		err = ext2fs_find_first_zero_block_bitmap2(fs->block_map,
+							   start, end, &start);
+		switch (err) {
+		case 0:
+			break;
+		case ENOENT:
+			/* no free blocks found, so we're done */
+			err = 0;
+			goto out;
+		default:
+			return translate_error(fs, fh->ino, err);
+		}
+
+		b = start + max_blocks < end ? start + max_blocks : end;
+		err =  ext2fs_find_first_set_block_bitmap2(fs->block_map,
+							   start, b, &b);
+		switch (err) {
+		case 0:
+			break;
+		case ENOENT:
+			/*
+			 * No free blocks found between start and b; discard
+			 * the entire range.
+			 */
+			err = 0;
+			break;
+		default:
+			return translate_error(fs, fh->ino, err);
+		}
+
+		if (b - start >= minlen) {
+			err = io_channel_discard(fs->io, start, b - start);
+			if (err == EBUSY) {
+				/*
+				 * Apparently dm-thinp can return EBUSY when
+				 * it's too busy deallocating thinp units to
+				 * deallocate more.  Swallow these errors.
+				 */
+				err = 0;
+			}
+			if (err)
+				return translate_error(fs, fh->ino, err);
+			cleared += b - start;
+			fr->len = FUSE4FS_FSB_TO_B(ff, cleared);
+		}
+		start = b + 1;
+	}
+
+out:
+	fr->len = FUSE4FS_FSB_TO_B(ff, cleared);
+	dbg_printf(ff, "%s: len=%llu err=%ld\n", __func__, fr->len, err);
+	return err;
+}
+#endif /* FITRIM */
+
+#ifndef EXT4_IOC_SHUTDOWN
+# define EXT4_IOC_SHUTDOWN	_IOR('X', 125, __u32)
+#endif
+
+static int ioctl_shutdown(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
+			  void *data)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	ext2_filsys fs = ff->fs;
+
+	if (!is_superuser(ff, ctxt))
+		return -EPERM;
+
+	err_printf(ff, "%s.\n", _("shut down requested"));
+
+	/*
+	 * EXT4_IOC_SHUTDOWN inherited the inverted polarity on the ioctl
+	 * direction from XFS.  Unfortunately, that means we can't implement
+	 * any of the flags.  Flush whatever is dirty and shut down.
+	 */
+	if (ff->opstate == F4OP_WRITABLE)
+		ext2fs_flush2(fs, 0);
+	ff->opstate = F4OP_SHUTDOWN;
+
+	return 0;
+}
+
+static int op_ioctl(const char *path EXT2FS_ATTR((unused)),
+		    unsigned int cmd,
+		    void *arg EXT2FS_ATTR((unused)),
+		    struct fuse_file_info *fp,
+		    unsigned int flags EXT2FS_ATTR((unused)), void *data)
+{
+	struct fuse4fs *ff = fuse4fs_get();
+	struct fuse4fs_file_handle *fh = fuse4fs_get_handle(fp);
+	int ret = 0;
+
+	FUSE4FS_CHECK_CONTEXT(ff);
+	FUSE4FS_CHECK_HANDLE(ff, fh);
+	fuse4fs_start(ff);
+	switch ((unsigned long) cmd) {
+#ifdef SUPPORT_I_FLAGS
+	case EXT2_IOC_GETFLAGS:
+		ret = ioctl_getflags(ff, fh, data);
+		break;
+	case EXT2_IOC_SETFLAGS:
+		ret = ioctl_setflags(ff, fh, data);
+		break;
+	case EXT2_IOC_GETVERSION:
+		ret = ioctl_getversion(ff, fh, data);
+		break;
+	case EXT2_IOC_SETVERSION:
+		ret = ioctl_setversion(ff, fh, data);
+		break;
+#endif
+#ifdef FS_IOC_FSGETXATTR
+	case FS_IOC_FSGETXATTR:
+		ret = ioctl_fsgetxattr(ff, fh, data);
+		break;
+	case FS_IOC_FSSETXATTR:
+		ret = ioctl_fssetxattr(ff, fh, data);
+		break;
+#endif
+#ifdef FITRIM
+	case FITRIM:
+		ret = ioctl_fitrim(ff, fh, data);
+		break;
+#endif
+	case EXT4_IOC_SHUTDOWN:
+		ret = ioctl_shutdown(ff, fh, data);
+		break;
+	default:
+		dbg_printf(ff, "%s: Unknown ioctl %d\n", __func__, cmd);
+		ret = -ENOTTY;
+	}
+	fuse4fs_finish(ff, ret);
+
+	return ret;
+}
+
+static int op_bmap(const char *path, size_t blocksize EXT2FS_ATTR((unused)),
+		   uint64_t *idx)
+{
+	struct fuse4fs *ff = fuse4fs_get();
+	ext2_filsys fs;
+	ext2_ino_t ino;
+	errcode_t err;
+	int ret = 0;
+
+	FUSE4FS_CHECK_CONTEXT(ff);
+	fs = fuse4fs_start(ff);
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
+	if (err) {
+		ret = translate_error(fs, 0, err);
+		goto out;
+	}
+	dbg_printf(ff, "%s: ino=%d blk=%"PRIu64"\n", __func__, ino, *idx);
+
+	err = ext2fs_bmap2(fs, ino, NULL, NULL, 0, *idx, 0, (blk64_t *)idx);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out;
+	}
+
+out:
+	fuse4fs_finish(ff, ret);
+	return ret;
+}
+
+#ifdef SUPPORT_FALLOCATE
+static int fuse4fs_allocate_range(struct fuse4fs *ff,
+				  struct fuse4fs_file_handle *fh, int mode,
+				  off_t offset, off_t len)
+{
+	ext2_filsys fs = ff->fs;
+	struct ext2_inode_large inode;
+	blk64_t start, end;
+	__u64 fsize;
+	errcode_t err;
+	int flags;
+
+	start = FUSE4FS_B_TO_FSBT(ff, offset);
+	end = FUSE4FS_B_TO_FSBT(ff, offset + len - 1);
+	dbg_printf(ff, "%s: ino=%d mode=0x%x offset=0x%llx len=0x%llx start=0x%llx end=0x%llx\n",
+		   __func__, fh->ino, mode,
+		   (unsigned long long)offset,
+		   (unsigned long long)len,
+		   (unsigned long long)start,
+		   (unsigned long long)end);
+	if (!fs_can_allocate(ff, FUSE4FS_B_TO_FSB(ff, len)))
+		return -ENOSPC;
+
+	err = fuse4fs_read_inode(fs, fh->ino, &inode);
+	if (err)
+		return err;
+	fsize = EXT2_I_SIZE(&inode);
+
+	/* Indirect files do not support unwritten extents */
+	if (!(inode.i_flags & EXT4_EXTENTS_FL))
+		return -EOPNOTSUPP;
+
+	/* Allocate a bunch of blocks */
+	flags = (mode & FL_KEEP_SIZE_FLAG ? 0 :
+			EXT2_FALLOCATE_INIT_BEYOND_EOF);
+	err = ext2fs_fallocate(fs, flags, fh->ino,
+			       EXT2_INODE(&inode),
+			       ~0ULL, start, end - start + 1);
+	if (err && err != EXT2_ET_BLOCK_ALLOC_FAIL)
+		return translate_error(fs, fh->ino, err);
+
+	/* Update i_size */
+	if (!(mode & FL_KEEP_SIZE_FLAG)) {
+		if ((__u64) offset + len > fsize) {
+			err = ext2fs_inode_size_set(fs,
+						EXT2_INODE(&inode),
+						offset + len);
+			if (err)
+				return translate_error(fs, fh->ino, err);
+		}
+	}
+
+	err = update_mtime(fs, fh->ino, &inode);
+	if (err)
+		return err;
+
+	err = fuse4fs_write_inode(fs, fh->ino, &inode);
+	if (err)
+		return translate_error(fs, fh->ino, err);
+
+	return err;
+}
+
+static errcode_t clean_block_middle(struct fuse4fs *ff, ext2_ino_t ino,
+				    struct ext2_inode_large *inode,
+				    off_t offset, off_t len, char **buf)
+{
+	ext2_filsys fs = ff->fs;
+	blk64_t blk;
+	off_t residue = FUSE4FS_OFF_IN_FSB(ff, offset);
+	int retflags;
+	errcode_t err;
+
+	if (!*buf) {
+		err = ext2fs_get_mem(fs->blocksize, buf);
+		if (err)
+			return err;
+	}
+
+	err = ext2fs_bmap2(fs, ino, EXT2_INODE(inode), *buf, 0,
+			   FUSE4FS_B_TO_FSBT(ff, offset), &retflags, &blk);
+	if (err)
+		return err;
+	if (!blk || (retflags & BMAP_RET_UNINIT))
+		return 0;
+
+	err = io_channel_read_blk64(fs->io, blk, 1, *buf);
+	if (err)
+		return err;
+
+	dbg_printf(ff, "%s: ino=%d offset=0x%llx len=0x%llx\n",
+		   __func__, ino,
+		   (unsigned long long)offset + residue,
+		   (unsigned long long)len);
+	memset(*buf + residue, 0, len);
+
+	return io_channel_write_blk64(fs->io, blk, 1, *buf);
+}
+
+static errcode_t clean_block_edge(struct fuse4fs *ff, ext2_ino_t ino,
+				  struct ext2_inode_large *inode, off_t offset,
+				  int clean_before, char **buf)
+{
+	ext2_filsys fs = ff->fs;
+	blk64_t blk;
+	int retflags;
+	off_t residue;
+	errcode_t err;
+
+	residue = FUSE4FS_OFF_IN_FSB(ff, offset);
+	if (residue == 0)
+		return 0;
+
+	if (!*buf) {
+		err = ext2fs_get_mem(fs->blocksize, buf);
+		if (err)
+			return err;
+	}
+
+	err = ext2fs_bmap2(fs, ino, EXT2_INODE(inode), *buf, 0,
+			   FUSE4FS_B_TO_FSBT(ff, offset), &retflags, &blk);
+	if (err)
+		return err;
+
+	err = io_channel_read_blk64(fs->io, blk, 1, *buf);
+	if (err)
+		return err;
+	if (!blk || (retflags & BMAP_RET_UNINIT))
+		return 0;
+
+	if (clean_before) {
+		dbg_printf(ff, "%s: ino=%d before offset=0x%llx len=0x%llx\n",
+			   __func__, ino,
+			   (unsigned long long)offset,
+			   (unsigned long long)residue);
+		memset(*buf, 0, residue);
+	} else {
+		dbg_printf(ff, "%s: ino=%d after offset=0x%llx len=0x%llx\n",
+			   __func__, ino,
+			   (unsigned long long)offset,
+			   (unsigned long long)fs->blocksize - residue);
+		memset(*buf + residue, 0, fs->blocksize - residue);
+	}
+
+	return io_channel_write_blk64(fs->io, blk, 1, *buf);
+}
+
+static int fuse4fs_punch_range(struct fuse4fs *ff,
+			       struct fuse4fs_file_handle *fh, int mode,
+			       off_t offset, off_t len)
+{
+	ext2_filsys fs = ff->fs;
+	struct ext2_inode_large inode;
+	blk64_t start, end;
+	errcode_t err;
+	char *buf = NULL;
+
+	/* kernel ext4 punch requires this flag to be set */
+	if (!(mode & FL_KEEP_SIZE_FLAG))
+		return -EINVAL;
+
+	/*
+	 * Unmap out all full blocks in the middle of the range being punched.
+	 * The start of the unmap range should be the first byte of the first
+	 * fsblock that starts within the range.  The end of the range should
+	 * be the next byte after the last fsblock to end in the range.
+	 */
+	start = FUSE4FS_B_TO_FSBT(ff, round_up(offset, fs->blocksize));
+	end = FUSE4FS_B_TO_FSBT(ff, round_down(offset + len, fs->blocksize));
+
+	dbg_printf(ff,
+ "%s: ino=%d mode=0x%x offset=0x%llx len=0x%llx start=0x%llx end=0x%llx\n",
+		   __func__, fh->ino, mode,
+		   (unsigned long long)offset,
+		   (unsigned long long)len,
+		   (unsigned long long)start,
+		   (unsigned long long)end);
+
+	err = fuse4fs_read_inode(fs, fh->ino, &inode);
+	if (err)
+		return translate_error(fs, fh->ino, err);
+
+	/*
+	 * Indirect files do not support unwritten extents, which means we
+	 * can't support zero range.  Punch goes first in zero-range, which
+	 * is why the check is here.
+	 */
+	if ((mode & FL_ZERO_RANGE_FLAG) && !(inode.i_flags & EXT4_EXTENTS_FL))
+		return -EOPNOTSUPP;
+
+	/* Zero everything before the first block and after the last block */
+	if (FUSE4FS_B_TO_FSBT(ff, offset) == FUSE4FS_B_TO_FSBT(ff, offset + len))
+		err = clean_block_middle(ff, fh->ino, &inode, offset,
+					 len, &buf);
+	else {
+		err = clean_block_edge(ff, fh->ino, &inode, offset, 0, &buf);
+		if (!err)
+			err = clean_block_edge(ff, fh->ino, &inode,
+					       offset + len, 1, &buf);
+	}
+	if (buf)
+		ext2fs_free_mem(&buf);
+	if (err)
+		return translate_error(fs, fh->ino, err);
+
+	/*
+	 * Unmap full blocks in the middle, which is to say that start - end
+	 * must be at least one fsblock.  ext2fs_punch takes a closed interval
+	 * as its argument, so we pass [start, end - 1].
+	 */
+	if (start < end) {
+		err = ext2fs_punch(fs, fh->ino, EXT2_INODE(&inode),
+				   NULL, start, end - 1);
+		if (err)
+			return translate_error(fs, fh->ino, err);
+	}
+
+	err = update_mtime(fs, fh->ino, &inode);
+	if (err)
+		return err;
+
+	err = fuse4fs_write_inode(fs, fh->ino, &inode);
+	if (err)
+		return translate_error(fs, fh->ino, err);
+
+	return 0;
+}
+
+static int fuse4fs_zero_range(struct fuse4fs *ff,
+			      struct fuse4fs_file_handle *fh, int mode,
+			      off_t offset, off_t len)
+{
+	int ret = fuse4fs_punch_range(ff, fh, mode | FL_KEEP_SIZE_FLAG, offset,
+				      len);
+
+	if (!ret)
+		ret = fuse4fs_allocate_range(ff, fh, mode, offset, len);
+	return ret;
+}
+
+static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
+			off_t offset, off_t len,
+			struct fuse_file_info *fp)
+{
+	struct fuse4fs *ff = fuse4fs_get();
+	struct fuse4fs_file_handle *fh = fuse4fs_get_handle(fp);
+	int ret;
+
+	/* Catch unknown flags */
+	if (mode & ~(FL_ZERO_RANGE_FLAG | FL_PUNCH_HOLE_FLAG | FL_KEEP_SIZE_FLAG))
+		return -EOPNOTSUPP;
+
+	FUSE4FS_CHECK_CONTEXT(ff);
+	FUSE4FS_CHECK_HANDLE(ff, fh);
+	fuse4fs_start(ff);
+	if (!fuse4fs_is_writeable(ff)) {
+		ret = -EROFS;
+		goto out;
+	}
+
+	dbg_printf(ff, "%s: ino=%d mode=0x%x start=0x%llx end=0x%llx\n", __func__,
+		   fh->ino, mode,
+		   (unsigned long long)offset,
+		   (unsigned long long)offset + len);
+
+	if (mode & FL_ZERO_RANGE_FLAG)
+		ret = fuse4fs_zero_range(ff, fh, mode, offset, len);
+	else if (mode & FL_PUNCH_HOLE_FLAG)
+		ret = fuse4fs_punch_range(ff, fh, mode, offset, len);
+	else
+		ret = fuse4fs_allocate_range(ff, fh, mode, offset, len);
+out:
+	fuse4fs_finish(ff, ret);
+
+	return ret;
+}
+#endif /* SUPPORT_FALLOCATE */
+
+static struct fuse_operations fs_ops = {
+	.init = op_init,
+	.destroy = op_destroy,
+	.getattr = op_getattr,
+	.readlink = op_readlink,
+	.mknod = op_mknod,
+	.mkdir = op_mkdir,
+	.unlink = op_unlink,
+	.rmdir = op_rmdir,
+	.symlink = op_symlink,
+	.rename = op_rename,
+	.link = op_link,
+	.chmod = op_chmod,
+	.chown = op_chown,
+	.truncate = op_truncate,
+	.open = op_open,
+	.read = op_read,
+	.write = op_write,
+	.statfs = op_statfs,
+	.release = op_release,
+	.fsync = op_fsync,
+	.setxattr = op_setxattr,
+	.getxattr = op_getxattr,
+	.listxattr = op_listxattr,
+	.removexattr = op_removexattr,
+	.opendir = op_open,
+	.readdir = op_readdir,
+	.releasedir = op_release,
+	.fsyncdir = op_fsync,
+	.access = op_access,
+	.create = op_create,
+	.utimens = op_utimens,
+	.bmap = op_bmap,
+#ifdef SUPERFLUOUS
+	.lock = op_lock,
+	.poll = op_poll,
+#endif
+	.ioctl = op_ioctl,
+#ifdef SUPPORT_FALLOCATE
+	.fallocate = op_fallocate,
+#endif
+};
+
+static int get_random_bytes(void *p, size_t sz)
+{
+	int fd;
+	ssize_t r;
+
+	fd = open("/dev/urandom", O_RDONLY);
+	if (fd < 0) {
+		perror("/dev/urandom");
+		return 0;
+	}
+
+	r = read(fd, p, sz);
+
+	close(fd);
+	return (size_t) r == sz;
+}
+
+enum {
+	FUSE4FS_IGNORED,
+	FUSE4FS_VERSION,
+	FUSE4FS_HELP,
+	FUSE4FS_HELPFULL,
+	FUSE4FS_CACHE_SIZE,
+	FUSE4FS_DIRSYNC,
+	FUSE4FS_ERRORS_BEHAVIOR,
+};
+
+#define FUSE4FS_OPT(t, p, v) { t, offsetof(struct fuse4fs, p), v }
+
+static struct fuse_opt fuse4fs_opts[] = {
+	FUSE4FS_OPT("ro",		ro,			1),
+	FUSE4FS_OPT("rw",		ro,			0),
+	FUSE4FS_OPT("minixdf",		minixdf,		1),
+	FUSE4FS_OPT("bsddf",		minixdf,		0),
+	FUSE4FS_OPT("fakeroot",		fakeroot,		1),
+	FUSE4FS_OPT("fuse4fs_debug",	debug,			1),
+	FUSE4FS_OPT("no_default_opts",	no_default_opts,	1),
+	FUSE4FS_OPT("norecovery",	norecovery,		1),
+	FUSE4FS_OPT("noload",		norecovery,		1),
+	FUSE4FS_OPT("offset=%lu",	offset,			0),
+	FUSE4FS_OPT("kernel",		kernel,			1),
+	FUSE4FS_OPT("directio",		directio,		1),
+	FUSE4FS_OPT("acl",		acl,			1),
+	FUSE4FS_OPT("noacl",		acl,			0),
+	FUSE4FS_OPT("lockfile=%s",	lockfile,		0),
+#ifdef HAVE_CLOCK_MONOTONIC
+	FUSE4FS_OPT("timing",		timing,			1),
+#endif
+	FUSE4FS_OPT("noblkdev",		noblkdev,		1),
+
+	FUSE_OPT_KEY("user_xattr",	FUSE4FS_IGNORED),
+	FUSE_OPT_KEY("noblock_validity", FUSE4FS_IGNORED),
+	FUSE_OPT_KEY("nodelalloc",	FUSE4FS_IGNORED),
+	FUSE_OPT_KEY("cache_size=%s",	FUSE4FS_CACHE_SIZE),
+	FUSE_OPT_KEY("dirsync",		FUSE4FS_DIRSYNC),
+	FUSE_OPT_KEY("errors=%s",	FUSE4FS_ERRORS_BEHAVIOR),
+
+	FUSE_OPT_KEY("-V",             FUSE4FS_VERSION),
+	FUSE_OPT_KEY("--version",      FUSE4FS_VERSION),
+	FUSE_OPT_KEY("-h",             FUSE4FS_HELP),
+	FUSE_OPT_KEY("--help",         FUSE4FS_HELP),
+	FUSE_OPT_KEY("--helpfull",     FUSE4FS_HELPFULL),
+	FUSE_OPT_END
+};
+
+
+static int fuse4fs_opt_proc(void *data, const char *arg,
+			    int key, struct fuse_args *outargs)
+{
+	struct fuse4fs *ff = data;
+
+	switch (key) {
+	case FUSE4FS_DIRSYNC:
+		ff->dirsync = 1;
+		/* pass through to libfuse */
+		return 1;
+	case FUSE_OPT_KEY_NONOPT:
+		if (!ff->device) {
+			ff->device = strdup(arg);
+			return 0;
+		}
+		return 1;
+	case FUSE4FS_CACHE_SIZE:
+		ff->cache_size = parse_num_blocks2(arg + 11, -1);
+		if (ff->cache_size < 1 || ff->cache_size > INT32_MAX) {
+			fprintf(stderr, "%s: %s\n", arg,
+ _("cache size must be between 1 block and 2GB."));
+			return -1;
+		}
+
+		/* do not pass through to libfuse */
+		return 0;
+	case FUSE4FS_ERRORS_BEHAVIOR:
+		if (strcmp(arg + 7, "continue") == 0)
+			ff->errors_behavior = EXT2_ERRORS_CONTINUE;
+		else if (strcmp(arg + 7, "remount-ro") == 0)
+			ff->errors_behavior = EXT2_ERRORS_RO;
+		else if (strcmp(arg + 7, "panic") == 0)
+			ff->errors_behavior = EXT2_ERRORS_PANIC;
+		else {
+			fprintf(stderr, "%s: %s\n", arg,
+ _("unknown errors behavior."));
+			return -1;
+		}
+
+		/* do not pass through to libfuse */
+		return 0;
+	case FUSE4FS_IGNORED:
+		return 0;
+	case FUSE4FS_HELP:
+	case FUSE4FS_HELPFULL:
+		fprintf(stderr,
+	"usage: %s device/image mountpoint [options]\n"
+	"\n"
+	"general options:\n"
+	"    -o opt,[opt...]  mount options\n"
+	"    -h   --help      print help\n"
+	"    -V   --version   print version\n"
+	"\n"
+	"fuse4fs options:\n"
+	"    -o errors=panic        dump core on error\n"
+	"    -o minixdf             minix-style df\n"
+	"    -o fakeroot            pretend to be root for permission checks\n"
+	"    -o no_default_opts     do not include default fuse options\n"
+	"    -o offset=<bytes>      similar to mount -o offset=<bytes>, mount the partition starting at <bytes>\n"
+	"    -o norecovery          don't replay the journal\n"
+	"    -o fuse4fs_debug       enable fuse4fs debugging\n"
+	"    -o lockfile=<file>     file to show that fuse is still using the file system image\n"
+	"    -o kernel              run this as if it were the kernel, which sets:\n"
+	"                           allow_others,default_permissions,suid,dev\n"
+	"    -o directio            use O_DIRECT to read and write the disk\n"
+	"    -o cache_size=N[KMG]   use a disk cache of this size\n"
+	"    -o errors=             behavior when an error is encountered:\n"
+	"                           continue|remount-ro|panic\n"
+	"\n",
+			outargs->argv[0]);
+		if (key == FUSE4FS_HELPFULL) {
+			fuse_opt_add_arg(outargs, "-h");
+			fuse_main(outargs->argc, outargs->argv, &fs_ops, NULL);
+		} else {
+			fprintf(stderr, "Try --helpfull to get a list of "
+				"all flags, including the FUSE options.\n");
+		}
+		exit(1);
+
+	case FUSE4FS_VERSION:
+		fprintf(stderr, "fuse4fs %s (%s)\n", E2FSPROGS_VERSION,
+			E2FSPROGS_DATE);
+		fuse_opt_add_arg(outargs, "--version");
+		fuse_main(outargs->argc, outargs->argv, &fs_ops, NULL);
+		exit(0);
+	}
+	return 1;
+}
+
+static const char *get_subtype(const char *argv0)
+{
+	size_t argvlen = strlen(argv0);
+
+	if (argvlen < 4)
+		goto out_default;
+
+	if (argv0[argvlen - 4] == 'e' &&
+	    argv0[argvlen - 3] == 'x' &&
+	    argv0[argvlen - 2] == 't' &&
+	    isdigit(argv0[argvlen - 1]))
+		return &argv0[argvlen - 4];
+
+out_default:
+	return "ext4";
+}
+
+/* Figure out a reasonable default size for the disk cache */
+static unsigned long long default_cache_size(void)
+{
+	long pages = 0, pagesize = 0;
+	unsigned long long max_cache;
+	unsigned long long ret = 32ULL << 20; /* 32 MB */
+
+#ifdef _SC_PHYS_PAGES
+	pages = sysconf(_SC_PHYS_PAGES);
+#endif
+#ifdef _SC_PAGESIZE
+	pagesize = sysconf(_SC_PAGESIZE);
+#endif
+	if (pages > 0 && pagesize > 0) {
+		max_cache = (unsigned long long)pagesize * pages / 20;
+
+		if (max_cache > 0 && ret > max_cache)
+			ret = max_cache;
+	}
+	return ret;
+}
+
+static inline bool fuse4fs_want_fuseblk(const struct fuse4fs *ff)
+{
+	if (ff->noblkdev)
+		return false;
+
+	/* libfuse won't let non-root do fuseblk mounts */
+	if (getuid() != 0)
+		return false;
+
+	return fuse4fs_on_bdev(ff);
+}
+
+static void fuse4fs_com_err_proc(const char *whoami, errcode_t code,
+				 const char *fmt, va_list args)
+{
+	fprintf(stderr, "FUSE4FS (%s): ", err_shortdev ? err_shortdev : "?");
+	if (whoami)
+		fprintf(stderr, "%s: ", whoami);
+	fprintf(stderr, "%s ", error_message(code));
+        vfprintf(stderr, fmt, args);
+	fprintf(stderr, "\n");
+	fflush(stderr);
+}
+
+int main(int argc, char *argv[])
+{
+	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
+	struct fuse4fs fctx;
+	errcode_t err;
+	FILE *orig_stderr = stderr;
+	char extra_args[BUFSIZ];
+	int ret;
+
+	memset(&fctx, 0, sizeof(fctx));
+	fctx.magic = FUSE4FS_MAGIC;
+	fctx.logfd = -1;
+	fctx.opstate = F4OP_WRITABLE;
+
+	ret = fuse_opt_parse(&args, &fctx, fuse4fs_opts, fuse4fs_opt_proc);
+	if (ret)
+		exit(1);
+	if (fctx.device == NULL) {
+		fprintf(stderr, "Missing ext4 device/image\n");
+		fprintf(stderr, "See '%s -h' for usage\n", argv[0]);
+		exit(1);
+	}
+
+	/* /dev/sda -> sda for reporting */
+	fctx.shortdev = strrchr(fctx.device, '/');
+	if (fctx.shortdev)
+		fctx.shortdev++;
+	else
+		fctx.shortdev = fctx.device;
+
+	/* capture library error messages */
+	err_shortdev = fctx.shortdev;
+	set_com_err_hook(fuse4fs_com_err_proc);
+
+#ifdef ENABLE_NLS
+	setlocale(LC_MESSAGES, "");
+	setlocale(LC_CTYPE, "");
+	bindtextdomain(NLS_CAT_NAME, LOCALEDIR);
+	textdomain(NLS_CAT_NAME);
+	set_com_err_gettext(gettext);
+#endif
+	add_error_table(&et_ext2_error_table);
+
+	ret = fuse4fs_setup_logging(&fctx);
+	if (ret) {
+		/* operational error */
+		ret = 2;
+		goto out;
+	}
+
+#ifdef HAVE_PR_SET_IO_FLUSHER
+	/*
+	 * Register as a filesystem I/O server process so that our memory
+	 * allocations don't cause fs reclaim.
+	 */
+	ret = prctl(PR_GET_IO_FLUSHER, 0, 0, 0, 0);
+	if (ret == 0) {
+		ret = prctl(PR_SET_IO_FLUSHER, 1, 0, 0, 0);
+		if (ret < 0) {
+			err_printf(&fctx, "%s: %s.\n",
+ _("Could not register as IO flusher thread"),
+					strerror(errno));
+			ret = 0;
+		}
+	}
+#endif
+
+	/* Will we allow users to allocate every last block? */
+	if (getenv("FUSE4FS_ALLOC_ALL_BLOCKS")) {
+		log_printf(&fctx, "%s\n",
+ _("Allowing users to allocate all blocks. This is dangerous!"));
+		fctx.alloc_all_blocks = 1;
+	}
+
+	err = fuse4fs_open(&fctx, EXT2_FLAG_EXCLUSIVE);
+	if (err) {
+		ret = 32;
+		goto out;
+	}
+
+	if (fuse4fs_want_fuseblk(&fctx)) {
+		/*
+		 * If this is a block device, we want to close the fs, reopen
+		 * the block device in non-exclusive mode, and start the fuse
+		 * driver in fuseblk mode (which will reopen the block device
+		 * in exclusive mode) so that unmount will wait until
+		 * op_destroy completes.
+		 */
+		fuse4fs_unmount(&fctx);
+		err = fuse4fs_open(&fctx, 0);
+		if (err) {
+			ret = 32;
+			goto out;
+		}
+
+		/* "blkdev" is the magic mount option for fuseblk mode */
+		snprintf(extra_args, BUFSIZ, "-oblkdev,blksize=%u",
+			 fctx.fs->blocksize);
+		fuse_opt_add_arg(&args, extra_args);
+		fctx.unmount_in_destroy = 1;
+	}
+
+	if (!fctx.cache_size)
+		fctx.cache_size = default_cache_size();
+	if (fctx.cache_size) {
+		err = fuse4fs_config_cache(&fctx);
+		if (err) {
+			ret = 32;
+			goto out;
+		}
+	}
+
+	err = fuse4fs_check_support(&fctx);
+	if (err) {
+		ret = 32;
+		goto out;
+	}
+
+	/*
+	 * ext4 can't do COW of shared blocks, so if the feature is enabled,
+	 * we must force ro mode.
+	 */
+	if (ext2fs_has_feature_shared_blocks(fctx.fs->super))
+		fctx.ro = 1;
+
+	if (fctx.norecovery) {
+		ret = fuse4fs_check_norecovery(&fctx);
+		if (ret)
+			goto out;
+	}
+
+	err = fuse4fs_mount(&fctx);
+	if (err) {
+		ret = 32;
+		goto out;
+	}
+
+	/* Initialize generation counter */
+	get_random_bytes(&fctx.next_generation, sizeof(unsigned int));
+
+	/* Set up default fuse parameters */
+	snprintf(extra_args, BUFSIZ, "-okernel_cache,subtype=%s,"
+		 "fsname=%s,attr_timeout=0",
+		 get_subtype(argv[0]),
+		 fctx.device);
+	if (fctx.no_default_opts == 0)
+		fuse_opt_add_arg(&args, extra_args);
+
+	if (fctx.ro)
+		fuse_opt_add_arg(&args, "-oro");
+
+	if (fctx.fakeroot) {
+#ifdef HAVE_MOUNT_NODEV
+		fuse_opt_add_arg(&args,"-onodev");
+#endif
+#ifdef HAVE_MOUNT_NOSUID
+		fuse_opt_add_arg(&args,"-onosuid");
+#endif
+	}
+
+	if (fctx.kernel) {
+		/*
+		 * ACLs are always enforced when kernel mode is enabled, to
+		 * match the kernel ext4 driver which always enables ACLs.
+		 */
+		fctx.acl = 1;
+		fuse_opt_insert_arg(&args, 1,
+ "-oallow_other,default_permissions,suid,dev");
+	}
+
+	/*
+	 * Since there's a Big Kernel Lock around all the libext2fs code, we
+	 * only need to start four threads -- one to decode a request, another
+	 * to do the filesystem work, a third to transmit the reply, and a
+	 * fourth to handle fuse notifications.
+	 */
+	fuse_opt_insert_arg(&args, 1, "-omax_threads=4");
+
+	if (fctx.debug) {
+		int	i;
+
+		printf("FUSE4FS (%s): fuse arguments:", fctx.shortdev);
+		for (i = 0; i < args.argc; i++)
+			printf(" '%s'", args.argv[i]);
+		printf("\n");
+		fflush(stdout);
+	}
+
+	pthread_mutex_init(&fctx.bfl, NULL);
+	ret = fuse_main(args.argc, args.argv, &fs_ops, &fctx);
+	pthread_mutex_destroy(&fctx.bfl);
+
+	switch(ret) {
+	case 0:
+		/* success */
+		ret = 0;
+		break;
+	case 1:
+	case 2:
+		/* invalid option or no mountpoint */
+		ret = 1;
+		break;
+	case 3:
+	case 4:
+	case 5:
+	case 6:
+	case 7:
+		/* setup or mounting failed */
+		ret = 32;
+		break;
+	default:
+		/* fuse started up enough to call op_init */
+		ret = 0;
+		break;
+	}
+out:
+	if (ret & 1) {
+		fprintf(orig_stderr, "%s\n",
+ _("Mount failed due to unrecognized options.  Check dmesg(1) for details."));
+		fflush(orig_stderr);
+	}
+	if (ret & 32) {
+		fprintf(orig_stderr, "%s\n",
+ _("Mount failed while opening filesystem.  Check dmesg(1) for details."));
+		fflush(orig_stderr);
+	}
+	fuse4fs_unmount(&fctx);
+	reset_com_err_hook();
+	err_shortdev = NULL;
+	if (fctx.device)
+		free(fctx.device);
+	fuse_opt_free_args(&args);
+	return ret;
+}
+
+static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
+			     const char *func, int line)
+{
+	struct timespec now;
+	int ret = err;
+	struct fuse4fs *ff = fs->priv_data;
+	int is_err = 0;
+
+	/* Translate ext2 error to unix error code */
+	switch (err) {
+	case 0:
+		break;
+	case EXT2_ET_NO_MEMORY:
+	case EXT2_ET_TDB_ERR_OOM:
+		ret = -ENOMEM;
+		break;
+	case EXT2_ET_INVALID_ARGUMENT:
+	case EXT2_ET_LLSEEK_FAILED:
+		ret = -EINVAL;
+		break;
+	case EXT2_ET_NO_DIRECTORY:
+		ret = -ENOTDIR;
+		break;
+	case EXT2_ET_FILE_NOT_FOUND:
+		ret = -ENOENT;
+		break;
+	case EXT2_ET_DIR_NO_SPACE:
+		is_err = 1;
+		/* fallthrough */
+	case EXT2_ET_TOOSMALL:
+	case EXT2_ET_BLOCK_ALLOC_FAIL:
+	case EXT2_ET_INODE_ALLOC_FAIL:
+	case EXT2_ET_EA_NO_SPACE:
+		ret = -ENOSPC;
+		break;
+	case EXT2_ET_SYMLINK_LOOP:
+		ret = -EMLINK;
+		break;
+	case EXT2_ET_FILE_TOO_BIG:
+		ret = -EFBIG;
+		break;
+	case EXT2_ET_TDB_ERR_EXISTS:
+	case EXT2_ET_FILE_EXISTS:
+		ret = -EEXIST;
+		break;
+	case EXT2_ET_MMP_FAILED:
+	case EXT2_ET_MMP_FSCK_ON:
+		ret = -EBUSY;
+		break;
+	case EXT2_ET_EA_KEY_NOT_FOUND:
+		ret = -ENODATA;
+		break;
+	case EXT2_ET_UNIMPLEMENTED:
+		ret = -EOPNOTSUPP;
+		break;
+	case EXT2_ET_RO_FILSYS:
+		ret = -EROFS;
+		break;
+	case EXT2_ET_MAGIC_EXT2_FILE:
+	case EXT2_ET_MAGIC_EXT2FS_FILSYS:
+	case EXT2_ET_MAGIC_BADBLOCKS_LIST:
+	case EXT2_ET_MAGIC_BADBLOCKS_ITERATE:
+	case EXT2_ET_MAGIC_INODE_SCAN:
+	case EXT2_ET_MAGIC_IO_CHANNEL:
+	case EXT2_ET_MAGIC_UNIX_IO_CHANNEL:
+	case EXT2_ET_MAGIC_IO_MANAGER:
+	case EXT2_ET_MAGIC_BLOCK_BITMAP:
+	case EXT2_ET_MAGIC_INODE_BITMAP:
+	case EXT2_ET_MAGIC_GENERIC_BITMAP:
+	case EXT2_ET_MAGIC_TEST_IO_CHANNEL:
+	case EXT2_ET_MAGIC_DBLIST:
+	case EXT2_ET_MAGIC_ICOUNT:
+	case EXT2_ET_MAGIC_PQ_IO_CHANNEL:
+	case EXT2_ET_MAGIC_E2IMAGE:
+	case EXT2_ET_MAGIC_INODE_IO_CHANNEL:
+	case EXT2_ET_MAGIC_EXTENT_HANDLE:
+	case EXT2_ET_BAD_MAGIC:
+	case EXT2_ET_MAGIC_EXTENT_PATH:
+	case EXT2_ET_MAGIC_GENERIC_BITMAP64:
+	case EXT2_ET_MAGIC_BLOCK_BITMAP64:
+	case EXT2_ET_MAGIC_INODE_BITMAP64:
+	case EXT2_ET_MAGIC_RESERVED_13:
+	case EXT2_ET_MAGIC_RESERVED_14:
+	case EXT2_ET_MAGIC_RESERVED_15:
+	case EXT2_ET_MAGIC_RESERVED_16:
+	case EXT2_ET_MAGIC_RESERVED_17:
+	case EXT2_ET_MAGIC_RESERVED_18:
+	case EXT2_ET_MAGIC_RESERVED_19:
+	case EXT2_ET_MMP_MAGIC_INVALID:
+	case EXT2_ET_MAGIC_EA_HANDLE:
+	case EXT2_ET_DIR_CORRUPTED:
+	case EXT2_ET_CORRUPT_SUPERBLOCK:
+	case EXT2_ET_RESIZE_INODE_CORRUPT:
+	case EXT2_ET_TDB_ERR_CORRUPT:
+	case EXT2_ET_UNDO_FILE_CORRUPT:
+	case EXT2_ET_FILESYSTEM_CORRUPTED:
+	case EXT2_ET_CORRUPT_JOURNAL_SB:
+	case EXT2_ET_INODE_CORRUPTED:
+	case EXT2_ET_EA_INODE_CORRUPTED:
+		/* same errno that linux uses */
+		is_err = 1;
+		ret = -EUCLEAN;
+		break;
+	case EIO:
+#ifdef EILSEQ
+	case EILSEQ:
+#endif
+	case EUCLEAN:
+		/* these errnos usually denote corruption or persistence fail */
+		is_err = 1;
+		ret = -err;
+		break;
+	default:
+		if (err < 256) {
+			/* other errno are usually operational errors */
+			ret = -err;
+		} else {
+			is_err = 1;
+			ret = -EIO;
+		}
+		break;
+	}
+
+	if (!is_err)
+		return ret;
+
+	if (ino)
+		err_printf(ff, "%s (inode #%d) at %s:%d.\n",
+			error_message(err), ino, func, line);
+	else
+		err_printf(ff, "%s at %s:%d.\n",
+			error_message(err), func, line);
+
+	/* Make a note in the error log */
+	get_now(&now);
+	ext2fs_set_tstamp(fs->super, s_last_error_time, now.tv_sec);
+	fs->super->s_last_error_ino = ino;
+	fs->super->s_last_error_line = line;
+	fs->super->s_last_error_block = err; /* Yeah... */
+	strncpy((char *)fs->super->s_last_error_func, func,
+		sizeof(fs->super->s_last_error_func));
+	if (ext2fs_get_tstamp(fs->super, s_first_error_time) == 0) {
+		ext2fs_set_tstamp(fs->super, s_first_error_time, now.tv_sec);
+		fs->super->s_first_error_ino = ino;
+		fs->super->s_first_error_line = line;
+		fs->super->s_first_error_block = err;
+		strncpy((char *)fs->super->s_first_error_func, func,
+			sizeof(fs->super->s_first_error_func));
+	}
+
+	fs->super->s_state |= EXT2_ERROR_FS;
+	fs->super->s_error_count++;
+	ext2fs_mark_super_dirty(fs);
+	ext2fs_flush(fs);
+	switch (ff->errors_behavior) {
+	case EXT2_ERRORS_CONTINUE:
+		err_printf(ff, "%s\n",
+ _("Continuing after errors; is this a good idea?"));
+		break;
+	case EXT2_ERRORS_RO:
+		if (ff->opstate == F4OP_WRITABLE) {
+			err_printf(ff, "%s\n",
+ _("Remounting read-only due to errors."));
+			ff->opstate = F4OP_READONLY;
+		}
+		fs->flags &= ~EXT2_FLAG_RW;
+		break;
+	case EXT2_ERRORS_PANIC:
+		err_printf(ff, "%s\n",
+ _("Aborting filesystem mount due to errors."));
+		abort();
+		break;
+	}
+
+	return ret;
+}
diff --git a/lib/config.h.in b/lib/config.h.in
index a4d8ce1c3765ed..c3379758c3c9bc 100644
--- a/lib/config.h.in
+++ b/lib/config.h.in
@@ -73,6 +73,9 @@
 /* Define to 1 if PR_SET_IO_FLUSHER is present */
 #undef HAVE_PR_SET_IO_FLUSHER
 
+/* Define to 1 if fuse supports lowlevel API */
+#undef HAVE_FUSE_LOWLEVEL
+
 /* Define to 1 if you have the Mac OS X function
    CFLocaleCopyPreferredLanguages in the CoreFoundation framework. */
 #undef HAVE_CFLOCALECOPYPREFERREDLANGUAGES


