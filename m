Return-Path: <linux-fsdevel+bounces-78205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHIVNZnnnGmNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:49:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E6D18000B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 57B433006204
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A3335D604;
	Mon, 23 Feb 2026 23:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gtifb121"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591D537FF79;
	Mon, 23 Feb 2026 23:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890578; cv=none; b=i9szTnzWRTZgCIhpHQ9dP7JWW3xLNPHMVvOsc9Fnh/sDDHOt8dykng76IEyQQLzmYDUkIrmItu39oarIV3yRLMCfFYOFSF2pqDTsVSv++/7O3t07opjTz7mgojkw+9Ifof4wrDvjsTqt0op4fbbmJAIgaF0DmagEJ1FK9OQhjvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890578; c=relaxed/simple;
	bh=l6/RjeR2M+3IQ4KB3dM1k6stZqyAP3/FEbwUbYuzbqo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W24Gj8xONgxbGzyCSnG7FXCVpracrHJKkCT78U6v8hlpniL9eKaQbrZJKEoz5XDmdotfsCE4x+WjRPt252ZrSV4ABBoKbIK3xidfnM2zhgPoT5cyJfC7JN3xAOMc6y+ZzT2COnflPDIe3Q074NoCwcDxWndLtUQ/m89r0FegcIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gtifb121; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC80CC116C6;
	Mon, 23 Feb 2026 23:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890578;
	bh=l6/RjeR2M+3IQ4KB3dM1k6stZqyAP3/FEbwUbYuzbqo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Gtifb1212osnuEexRaPAdNpUxHLEw9GBP1axOtZXaPJwhxRVD+K40GILnNg472cEK
	 qyrta9Dx3rnK8mn8skUnNoKi+sC0rIJjsRaOCRwoj1ka/TO1H9t10rwKHNGFW0abSN
	 XwvfF36wbL+ANMAxzJfp2VvflqvxcSuZQRrI6IfvahLgx6q+49P+kUxnHtYpwzM0CJ
	 e8UOKnYM6ViHqSUI37b+ABS7fMiNQCKOz2UlDEfma9n0R7Ysk3ZytzOOv8WIveMkil
	 pJzzTi1JreYClxz1PGAf9y8+qUAMZDUEwWHeL1RovLk9pwTWT0SsQbanF6Dz7NupJD
	 Ngu2h1Us17zoA==
Date: Mon, 23 Feb 2026 15:49:37 -0800
Subject: [PATCH 1/3] fuse4fs: add dynamic iomap bpf prototype which will break
 FIEMAP
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev, john@groves.net
Message-ID: <177188746488.3945469.4623945694500959593.stgit@frogsfrogsfrogs>
In-Reply-To: <177188746460.3945469.14760426500960341844.stgit@frogsfrogsfrogs>
References: <177188746460.3945469.14760426500960341844.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev,groves.net];
	TAGGED_FROM(0.00)[bounces-78205-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mconfig.in:url,configure.ac:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,makefile.in:url]
X-Rspamd-Queue-Id: F3E6D18000B
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Enhance fuse4fs to report rogue results from FIEMAP to prove that iomap
bpf actually works.  This patch employs dynamic compilation of the bpf
program so that the filesystem can tailor the bpf code to the needs of
the filesystem it's serving.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs_bpf.h |   54 +++++++
 MCONFIG.in            |    5 +
 configure             |  188 +++++++++++++++++++++++
 configure.ac          |   94 +++++++++++
 fuse4fs/Makefile.in   |   22 ++-
 fuse4fs/fuse4fs.c     |   82 ++++++++++
 fuse4fs/fuse4fs_bpf.c |  404 +++++++++++++++++++++++++++++++++++++++++++++++++
 lib/config.h.in       |   12 +
 8 files changed, 859 insertions(+), 2 deletions(-)
 create mode 100644 fuse4fs/fuse4fs_bpf.h
 create mode 100644 fuse4fs/fuse4fs_bpf.c


diff --git a/fuse4fs/fuse4fs_bpf.h b/fuse4fs/fuse4fs_bpf.h
new file mode 100644
index 00000000000000..4fcede160a3731
--- /dev/null
+++ b/fuse4fs/fuse4fs_bpf.h
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#ifndef __FUSE4FS_BPF_H__
+#define __FUSE4FS_BPF_H__
+
+struct fuse4fs_bpf_attrs {
+	/* vector to the binary elf data */
+	const void *elf_data;
+	size_t elf_size;
+
+	/* name associated with this bpf skeleton */
+	const char *skel_name;
+
+	/* name of the fuse_iomap_bpf_ops object in the bpf code */
+	const char *ops_name;
+
+	/* name of the iomap_begin bpf function, if provided */
+	const char *begin_fn_name;
+
+	/* name of the iomap_end bpf function, if provided */
+	const char *end_fn_name;
+
+	/* name of the iomap_ioend bpf function, if provided */
+	const char *ioend_fn_name;
+};
+
+struct fuse4fs_bpf_compile {
+	/* C source code */
+	const char *source_code;
+
+	/* directory containing vmlinux.h */
+	const char *vmlinux_h_dir;
+
+	/* directory containing fuse_iomap_bpf.h */
+	const char *fuse_include_dir;
+};
+
+struct fuse4fs_bpf_ctl {
+	struct fuse4fs_bpf *skel;
+	struct bpf_link *link;
+};
+
+int fuse4fs_bpf_ctl_setup(struct fuse4fs_bpf_ctl *arg, struct fuse_session *se,
+			  const struct fuse4fs_bpf_attrs *attrs);
+void fuse4fs_bpf_ctl_drop_skeleton(struct fuse4fs_bpf_ctl *arg);
+void fuse4fs_bpf_ctl_cleanup(struct fuse4fs_bpf_ctl *arg);
+
+int fuse4fs_bpf_compile(struct fuse4fs_bpf_attrs *attrs,
+			const struct fuse4fs_bpf_compile *cc);
+
+#endif /* __FUSE4FS_BPF_H__ */
diff --git a/MCONFIG.in b/MCONFIG.in
index 2fcb71d898fef7..9b25cbb78d3f00 100644
--- a/MCONFIG.in
+++ b/MCONFIG.in
@@ -44,6 +44,11 @@ HAVE_SYSTEMD = @have_systemd@
 SYSTEMD_SYSTEM_UNIT_DIR = @systemd_system_unit_dir@
 HAVE_FUSE_SERVICE = @have_fuse_service@
 
+VMLINUX_H_DIR = @VMLINUX_H_DIR@
+FUSE_INCLUDE_PATH = @FUSE_INCLUDE_PATH@
+HAVE_IOMAP_BPF = @have_iomap_bpf@
+LIBBPF = @BPF_LIB@
+
 @SET_MAKE@
 
 @ifGNUmake@ V =
diff --git a/configure b/configure
index 44bd0e73a74279..a9ffadc8793647 100755
--- a/configure
+++ b/configure
@@ -696,6 +696,11 @@ gcc_ar
 UNI_DIFF_OPTS
 SEM_INIT_LIB
 LIBBSD_LIB
+have_iomap_bpf
+VMLINUX_H_DIR
+BPF_LIB
+libbpf_LIBS
+libbpf_CFLAGS
 FUSE4FS_CMT
 FUSE2FS_CMT
 fuse_service_socket_dir
@@ -935,6 +940,9 @@ with_libarchive
 with_fuse_service_socket_dir
 enable_fuse2fs
 enable_fuse4fs
+enable_bpf
+with_vmlinux_h_path
+with_fuse_include_path
 enable_lto
 enable_ubsan
 enable_addrsan
@@ -962,6 +970,8 @@ ARCHIVE_CFLAGS
 ARCHIVE_LIBS
 fuse3_CFLAGS
 fuse3_LIBS
+libbpf_CFLAGS
+libbpf_LIBS
 CXX
 CXXFLAGS
 CCC
@@ -1632,6 +1642,7 @@ Optional Features:
   --disable-largefile     omit support for large files
   --disable-fuse2fs       do not build fuse2fs
   --disable-fuse4fs       do not build fuse4fs
+  --disable-bpf           disable use of bpf in fuse4fs
   --enable-lto            enable link time optimization
   --enable-ubsan          enable undefined behavior sanitizer
   --enable-addrsan        enable address sanitizer
@@ -1658,6 +1669,12 @@ Optional Packages:
   --without-libarchive    disable use of libarchive
   --with-fuse-service-socket-dir[=DIR]
                           Create fuse3 filesystem service sockets in DIR.
+  --with-vmlinux-h-path[=PATH]
+                          Use this vmlinux.h file on the target for compiling
+                          BPF programs.
+  --with-fuse-include-path[=PATH]
+                          Use this path on the target to libfuse headers for
+                          compiling BPF programs.
   --with-multiarch=ARCH   specify the multiarch triplet
   --with-udev-rules-dir[=DIR]
                           Install udev rules into DIR.
@@ -1686,6 +1703,9 @@ Some influential environment variables:
   fuse3_CFLAGS
               C compiler flags for fuse3, overriding pkg-config
   fuse3_LIBS  linker flags for fuse3, overriding pkg-config
+  libbpf_CFLAGS
+              C compiler flags for libbpf, overriding pkg-config
+  libbpf_LIBS linker flags for libbpf, overriding pkg-config
   CXX         C++ compiler command
   CXXFLAGS    C++ compiler flags
   udev_CFLAGS C compiler flags for udev, overriding pkg-config
@@ -13641,6 +13661,12 @@ if test "x$ac_cv_func_chflags" = xyes
 then :
   printf "%s\n" "#define HAVE_CHFLAGS 1" >>confdefs.h
 
+fi
+ac_fn_c_check_func "$LINENO" "close_range" "ac_cv_func_close_range"
+if test "x$ac_cv_func_close_range" = xyes
+then :
+  printf "%s\n" "#define HAVE_CLOSE_RANGE 1" >>confdefs.h
+
 fi
 ac_fn_c_check_func "$LINENO" "dlopen" "ac_cv_func_dlopen"
 if test "x$ac_cv_func_dlopen" = xyes
@@ -15062,6 +15088,168 @@ printf "%s\n" "#define HAVE_FUSE_CACHE_READDIR 1" >>confdefs.h
 
 fi
 
+# Check whether --enable-bpf was given.
+if test ${enable_bpf+y}
+then :
+  enableval=$enable_bpf;
+fi
+
+
+
+# Check whether --with-vmlinux_h_path was given.
+if test ${with_vmlinux_h_path+y}
+then :
+  withval=$with_vmlinux_h_path;
+else case e in #(
+  e) with_vmlinux_h_path=yes ;;
+esac
+fi
+
+vmlinux_h_path="$withval"
+
+# Check whether --with-fuse_include_path was given.
+if test ${with_fuse_include_path+y}
+then :
+  withval=$with_fuse_include_path;
+else case e in #(
+  e) with_fuse_include_path=yes ;;
+esac
+fi
+
+fuse_include_path="$withval"
+
+if test "x$enable_bpf" != "xno" && test -n "$have_fuse_lowlevel" && test -n "$have_fuse_iomap"; then
+	{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking if we can find vmlinux.h" >&5
+printf %s "checking if we can find vmlinux.h... " >&6; }
+
+
+		if test -n "$vmlinux_h_path"; then
+		VMLINUX_H_DIR="$(dirname "$vmlinux_h_path")"
+	fi
+
+		location="/usr/src/kernels/$(uname -r)/vmlinux.h"
+	if test -z "$VMLINUX_H_DIR" && test -s "$location"; then
+		VMLINUX_H_DIR="$(dirname "$location")"
+	fi
+
+		location="/usr/include/$(gcc -print-multiarch)/linux/bpf/vmlinux.h"
+	if test -z "$VMLINUX_H_DIR" && test -s "$location"; then
+		VMLINUX_H_DIR="$(dirname "$location")"
+	fi
+
+	if test -n "$VMLINUX_H_DIR"; then
+		{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: yes" >&5
+printf "%s\n" "yes" >&6; }
+	else
+		{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: no" >&5
+printf "%s\n" "no" >&6; }
+	fi
+
+						if test -n "$fuse_include_path"; then
+		FUSE_INCLUDE_PATH="$fuse_include_path"
+	else
+		FUSE_INCLUDE_PATH="/usr/include/fuse3"
+	fi
+
+				BPF_LIB=
+
+pkg_failed=no
+{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for libbpf" >&5
+printf %s "checking for libbpf... " >&6; }
+
+if test -n "$libbpf_CFLAGS"; then
+    pkg_cv_libbpf_CFLAGS="$libbpf_CFLAGS"
+ elif test -n "$PKG_CONFIG"; then
+    if test -n "$PKG_CONFIG" && \
+    { { printf "%s\n" "$as_me:${as_lineno-$LINENO}: \$PKG_CONFIG --exists --print-errors \"libbpf\""; } >&5
+  ($PKG_CONFIG --exists --print-errors "libbpf") 2>&5
+  ac_status=$?
+  printf "%s\n" "$as_me:${as_lineno-$LINENO}: \$? = $ac_status" >&5
+  test $ac_status = 0; }; then
+  pkg_cv_libbpf_CFLAGS=`$PKG_CONFIG --cflags "libbpf" 2>/dev/null`
+		      test "x$?" != "x0" && pkg_failed=yes
+else
+  pkg_failed=yes
+fi
+ else
+    pkg_failed=untried
+fi
+if test -n "$libbpf_LIBS"; then
+    pkg_cv_libbpf_LIBS="$libbpf_LIBS"
+ elif test -n "$PKG_CONFIG"; then
+    if test -n "$PKG_CONFIG" && \
+    { { printf "%s\n" "$as_me:${as_lineno-$LINENO}: \$PKG_CONFIG --exists --print-errors \"libbpf\""; } >&5
+  ($PKG_CONFIG --exists --print-errors "libbpf") 2>&5
+  ac_status=$?
+  printf "%s\n" "$as_me:${as_lineno-$LINENO}: \$? = $ac_status" >&5
+  test $ac_status = 0; }; then
+  pkg_cv_libbpf_LIBS=`$PKG_CONFIG --libs "libbpf" 2>/dev/null`
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
+                libbpf_PKG_ERRORS=`$PKG_CONFIG --short-errors --print-errors --cflags --libs "libbpf" 2>&1`
+        else
+                libbpf_PKG_ERRORS=`$PKG_CONFIG --print-errors --cflags --libs "libbpf" 2>&1`
+        fi
+        # Put the nasty error message in config.log where it belongs
+        echo "$libbpf_PKG_ERRORS" >&5
+
+        BPF_LIB=
+elif test $pkg_failed = untried; then
+        { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: no" >&5
+printf "%s\n" "no" >&6; }
+        BPF_LIB=
+else
+        libbpf_CFLAGS=$pkg_cv_libbpf_CFLAGS
+        libbpf_LIBS=$pkg_cv_libbpf_LIBS
+        { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: yes" >&5
+printf "%s\n" "yes" >&6; }
+        BPF_LIB=-lbpf
+fi
+
+
+				{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking if we can enable iomap bpf overrides" >&5
+printf %s "checking if we can enable iomap bpf overrides... " >&6; }
+	if test -n "$VMLINUX_H_DIR" && test -n "$FUSE_INCLUDE_PATH" && test -n "$BPF_LIB"; then
+		printf "%s\n" "#define HAVE_IOMAP_BPF 1" >>confdefs.h
+
+		printf "%s\n" "#define VMLINUX_H_DIR \"$VMLINUX_H_DIR\"" >>confdefs.h
+
+		printf "%s\n" "#define FUSE_INCLUDE_PATH \"$FUSE_INCLUDE_PATH\"" >>confdefs.h
+
+		have_iomap_bpf=yes
+
+		{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: yes" >&5
+printf "%s\n" "yes" >&6; }
+	else
+		have_iomap_bpf=
+		{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: no" >&5
+printf "%s\n" "no" >&6; }
+	fi
+fi
+
+
+if test "x$enable_bpf" = "xyes" && test -z "$have_iomap_bpf"; then
+	as_fn_error $? "cannot find bpf override library" "$LINENO" 5
+fi
+
 { printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for setproctitle in -lbsd" >&5
 printf %s "checking for setproctitle in -lbsd... " >&6; }
 if test ${ac_cv_lib_bsd_setproctitle+y}
diff --git a/configure.ac b/configure.ac
index a3162a64123d20..b749096fc6e062 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1226,6 +1226,7 @@ AC_CHECK_FUNCS(m4_flatten([
 	add_key
 	backtrace
 	chflags
+	close_range
 	dlopen
 	fadvise64
 	fallocate
@@ -1625,6 +1626,99 @@ then
 		  [Define to 1 if fuse supports cache_readdir])
 fi
 
+AC_ARG_ENABLE([bpf],
+AS_HELP_STRING([--disable-bpf],[disable use of bpf in fuse4fs]), [] [])
+
+dnl
+dnl If we have fuse and iomap, let's see if we can build BPF
+dnl
+AC_ARG_WITH([vmlinux_h_path],
+  [AS_HELP_STRING([--with-vmlinux-h-path@<:@=PATH@:>@],
+		  [Use this vmlinux.h file on the target for compiling BPF programs.])],
+  [],
+  [with_vmlinux_h_path=yes])
+vmlinux_h_path="$withval"
+AC_ARG_WITH([fuse_include_path],
+  [AS_HELP_STRING([--with-fuse-include-path@<:@=PATH@:>@],
+		  [Use this path on the target to libfuse headers for compiling BPF programs.])],
+  [],
+  [with_fuse_include_path=yes])
+fuse_include_path="$withval"
+
+if test "x$enable_bpf" != "xno" && test -n "$have_fuse_lowlevel" && test -n "$have_fuse_iomap"; then
+	AC_MSG_CHECKING(if we can find vmlinux.h)
+
+	dnl
+	dnl fuse4fs needs to have a vmlinux.h to compile bpf on the fly.
+	dnl Either the user gave us a path to one in the target environment,
+	dnl or we need to detect it based on the OS kernel.  If this were to
+	dnl be made production-ready you'd have to detect the path at
+	dnl runtime.  Not sure what you do for SUSE or Debian.
+	dnl
+
+	dnl User-provided path
+	if test -n "$vmlinux_h_path"; then
+		VMLINUX_H_DIR="$(dirname "$vmlinux_h_path")"
+	fi
+
+	dnl RHEL/Fedora
+	location="/usr/src/kernels/$(uname -r)/vmlinux.h"
+	if test -z "$VMLINUX_H_DIR" && test -s "$location"; then
+		VMLINUX_H_DIR="$(dirname "$location")"
+	fi
+
+	dnl Debian
+	location="/usr/include/$(gcc -print-multiarch)/linux/bpf/vmlinux.h"
+	if test -z "$VMLINUX_H_DIR" && test -s "$location"; then
+		VMLINUX_H_DIR="$(dirname "$location")"
+	fi
+
+	if test -n "$VMLINUX_H_DIR"; then
+		AC_MSG_RESULT(yes)
+	else
+		AC_MSG_RESULT(no)
+	fi
+
+	dnl
+	dnl fuse4fs also needs to know the path to the fuse library headers
+	dnl to compile bpf on the fly.  If the user gave us one, cool;
+	dnl otherwise just default to /usr/include/fuse3.
+	dnl
+	if test -n "$fuse_include_path"; then
+		FUSE_INCLUDE_PATH="$fuse_include_path"
+	else
+		FUSE_INCLUDE_PATH="/usr/include/fuse3"
+	fi
+
+	dnl
+	dnl Check for libbpf.  It's not fatal to configure if we don't find it.
+	dnl
+	BPF_LIB=
+	PKG_CHECK_MODULES([libbpf], [libbpf], [BPF_LIB=-lbpf], [BPF_LIB=])
+	AC_SUBST(BPF_LIB)
+
+	dnl
+	dnl Only enable iomap bpf if the compilers work and libbpf is present
+	dnl
+	AC_MSG_CHECKING(if we can enable iomap bpf overrides)
+	if test -n "$VMLINUX_H_DIR" && test -n "$FUSE_INCLUDE_PATH" && test -n "$BPF_LIB"; then
+		AC_DEFINE(HAVE_IOMAP_BPF, 1, Define to 1 if fuse iomap bpf present])
+		AC_DEFINE_UNQUOTED(VMLINUX_H_DIR, ["$VMLINUX_H_DIR"], Location of vmlinux.h])
+		AC_DEFINE_UNQUOTED(FUSE_INCLUDE_PATH, ["$FUSE_INCLUDE_PATH"], Location of fuse headers])
+		have_iomap_bpf=yes
+		AC_SUBST(VMLINUX_H_DIR)
+		AC_MSG_RESULT(yes)
+	else
+		have_iomap_bpf=
+		AC_MSG_RESULT(no)
+	fi
+fi
+AC_SUBST(have_iomap_bpf)
+
+if test "x$enable_bpf" = "xyes" && test -z "$have_iomap_bpf"; then
+	AC_MSG_ERROR([cannot find bpf override library])
+fi
+
 dnl
 dnl see if setproctitle exists
 dnl
diff --git a/fuse4fs/Makefile.in b/fuse4fs/Makefile.in
index 0600485b074158..cb2d6c54a73f07 100644
--- a/fuse4fs/Makefile.in
+++ b/fuse4fs/Makefile.in
@@ -35,12 +35,18 @@ SRCS=\
 	$(srcdir)/../e2fsck/revoke.c \
 	$(srcdir)/../e2fsck/recovery.c
 
-LIBS= $(LIBEXT2FS) $(LIBCOM_ERR) $(LIBSUPPORT)
+ifeq ($(HAVE_IOMAP_BPF),yes)
+SRCS += $(srcdir)/fuse4fs_bpf.c
+FUSE4FS_OBJS += fuse4fs_bpf.o
+BPF_SKEL=fuse4fs_bpf.h
+endif
+
+LIBS= $(LIBEXT2FS) $(LIBCOM_ERR) $(LIBSUPPORT) $(LIBBPF)
 DEPLIBS= $(LIBEXT2FS) $(DEPLIBCOM_ERR) $(DEPLIBSUPPORT)
 PROFILED_LIBS= $(PROFILED_LIBEXT2FS) $(PROFILED_LIBSUPPORT) $(PROFILED_LIBCOM_ERR)
 PROFILED_DEPLIBS= $(PROFILED_LIBEXT2FS) $(DEPPROFILED_LIBSUPPORT) $(DEPPROFILED_LIBCOM_ERR)
 
-STATIC_LIBS= $(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) $(STATIC_LIBCOM_ERR)
+STATIC_LIBS= $(STATIC_LIBEXT2FS) $(STATIC_LIBSUPPORT) $(STATIC_LIBCOM_ERR) $(LIBBPF)
 STATIC_DEPLIBS= $(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBSUPPORT) $(DEPSTATIC_LIBCOM_ERR)
 
 LIBS_E2P= $(LIBE2P) $(LIBCOM_ERR)
@@ -171,6 +177,18 @@ distclean: clean
 # the Makefile.in file
 #
 fuse4fs.o: $(srcdir)/fuse4fs.c $(top_builddir)/lib/config.h \
+ $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
+ $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
+ $(top_srcdir)/lib/ext2fs/ext3_extents.h $(top_srcdir)/lib/et/com_err.h \
+ $(top_srcdir)/lib/ext2fs/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
+ $(top_srcdir)/lib/ext2fs/ext2_ext_attr.h $(top_srcdir)/lib/ext2fs/hashmap.h \
+ $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/ext2fs/ext2fsP.h \
+ $(top_srcdir)/lib/ext2fs/ext2fs.h $(top_srcdir)/version.h \
+ $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/support/cache.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/support/xbitops.h \
+ $(top_srcdir)/lib/support/iocache.h $(top_srcdir)/lib/support/psi.h \
+ $(BPF_SKEL)
+fuse4fs_bpf.o: $(srcdir)/fuse4fs_bpf.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
  $(top_srcdir)/lib/ext2fs/ext3_extents.h $(top_srcdir)/lib/et/com_err.h \
diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 1fbf5e48af8724..b5deed0ef767e9 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -71,6 +71,10 @@
 #include "uuid/uuid.h"
 #include "e2p/e2p.h"
 
+#ifdef HAVE_IOMAP_BPF
+#include "fuse4fs_bpf.h"
+#endif
+
 #ifdef ENABLE_NLS
 #include <libintl.h>
 #include <locale.h>
@@ -304,7 +308,11 @@ struct fuse4fs {
 #endif
 	/* options set by fuse_opt_parse must be of type int */
 	int iomap_cache;
+#ifdef HAVE_IOMAP_BPF
+	int bpf_crap;
+	struct fuse4fs_bpf_ctl bpf;
 #endif
+#endif /* HAVE_FUSE_IOMAP */
 	unsigned int blockmask;
 	unsigned long offset;
 	unsigned int next_generation;
@@ -2010,6 +2018,10 @@ static void fuse4fs_unmount(struct fuse4fs *ff)
 	char uuid[UUID_STR_SIZE];
 	errcode_t err;
 
+#ifdef HAVE_IOMAP_BPF
+	fuse4fs_bpf_ctl_cleanup(&ff->bpf);
+#endif
+
 	if (ff->fs) {
 		if (cache_initialized(&ff->inodes)) {
 			cache_purge(&ff->inodes);
@@ -7788,6 +7800,73 @@ static void op_iomap_config(fuse_req_t req, uint64_t flags, uint64_t maxbytes,
 				&ff->old_alloc_stats_range);
 	}
 
+#ifdef HAVE_IOMAP_BPF
+	if (ff->bpf_crap) {
+		char source_code[4096];
+		struct fuse4fs_bpf_attrs attrs = {
+			.skel_name	= "bogus_iomap_bpf",
+			.ops_name	= "bogus_iomap_bpf_ops",
+			.begin_fn_name	= "bogus_iomap_begin_bpf",
+//			.end_fn_name	= "bogus_iomap_end_bpf",
+//			.ioend_fn_name	= "bogus_iomap_ioend_bpf",
+		};
+		struct fuse4fs_bpf_compile cc = {
+			.source_code = source_code,
+			.vmlinux_h_dir	= VMLINUX_H_DIR,
+			.fuse_include_dir = FUSE_INCLUDE_PATH,
+		};
+		int ret2;
+
+		snprintf(source_code, sizeof(source_code),
+"#include <vmlinux.h>\n\
+#include <bpf/bpf_helpers.h>\n\
+#include <bpf/bpf_tracing.h>\n\
+\n\
+#include <fuse_iomap_bpf.h>\n\
+\n\
+DECLARE_GPL2_LICENSE_FOR_FUSE_IOMAP_BPF;\n\
+\n\
+FUSE_IOMAP_BEGIN_BPF_FUNC(bogus_iomap_begin_bpf)\n\
+{\n\
+	const uint32_t dev = %u;\n\
+	const uint32_t blocksize = %u;\n\
+\n\
+	/*\n\
+	 * Create an alternating pattern of written and unwritten mappings\n\
+	 * for FIEMAP as a demonstration of using BPF for iomapping.  Do NOT\n\
+	 * run this in production!\n\
+	 */\n\
+	if ((opflags & FUSE_IOMAP_OP_REPORT) && pos <= (16 * blocksize)) {\n\
+		outarg->read.offset = pos;\n\
+		outarg->read.length = blocksize;\n\
+		outarg->read.type = ((pos / blocksize) %% 2) + FUSE_IOMAP_TYPE_MAPPED;\n\
+		outarg->read.dev = dev;\n\
+		outarg->read.addr = (99 * blocksize) + pos;\n\
+\n\
+		fuse_iomap_begin_pure_overwrite(outarg);\n\
+		return FIB_HANDLED;\n\
+	}\n\
+\n\
+	return FIB_FALLBACK;\n\
+}\n\
+\n\
+DEFINE_FUSE_IOMAP_BPF_OPS(bogus_iomap_bpf_ops, \"bogus_bpf\",\n\
+		bogus_iomap_begin_bpf, NULL, NULL);\n",
+				ff->iomap_dev,
+				ff->fs->blocksize);
+
+		ret2 = fuse4fs_bpf_compile(&attrs, &cc);
+		if (!ret2) {
+			ret2 = fuse4fs_bpf_ctl_setup(&ff->bpf, ff->fuse, &attrs);
+			fuse4fs_bpf_ctl_drop_skeleton(&ff->bpf);
+		}
+		if (ret2) {
+			fprintf(stderr,
+ _("Setting up bogus bpf prog failed with err=%d\n"), ret2);
+		}
+	}
+#endif
+
 out_unlock:
 	fuse4fs_finish(ff, ret);
 	if (ret)
@@ -8282,7 +8361,10 @@ static struct fuse_opt fuse4fs_opts[] = {
 #ifdef HAVE_FUSE_IOMAP
 	FUSE4FS_OPT("iomap_cache",	iomap_cache,		1),
 	FUSE4FS_OPT("noiomap_cache",	iomap_cache,		0),
+#ifdef HAVE_IOMAP_BPF
+	FUSE4FS_OPT("bpf_crap",		bpf_crap,		1),
 #endif
+#endif /* HAVE_FUSE_IOMAP */
 
 #ifdef HAVE_FUSE_IOMAP
 #ifdef MS_LAZYTIME
diff --git a/fuse4fs/fuse4fs_bpf.c b/fuse4fs/fuse4fs_bpf.c
new file mode 100644
index 00000000000000..fb66b72febe729
--- /dev/null
+++ b/fuse4fs/fuse4fs_bpf.c
@@ -0,0 +1,404 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include "config.h"
+#include <errno.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <bpf/libbpf.h>
+#include <fuse_lowlevel.h>
+
+#include "fuse4fs_bpf.h"
+
+#define max(a, b)	((a) > (b) ? (a) : (b))
+#define BPF_SKEL_SUPPORTS_MAP_AUTO_ATTACH 1
+
+struct fuse4fs_bpf {
+	struct bpf_object_skeleton *skeleton;
+	struct bpf_object *obj;
+	struct {
+		struct bpf_map *fuse4fs_bpf_ops;
+	} maps;
+	struct {
+		struct fuse4fs_bpf__fuse4fs_bpf_ops__fuse_iomap_bpf_ops {
+			struct bpf_program *iomap_begin;
+			struct bpf_program *iomap_end;
+			struct bpf_program *iomap_ioend;
+			int fuse_fd;
+			unsigned int zeropad;
+			char __unsupported_5[16];
+		} *fuse4fs_bpf_ops;
+	} struct_ops;
+	struct {
+		struct bpf_program *crazy_begin_bpf;
+		struct bpf_program *crazy_end_bpf;
+		struct bpf_program *crazy_ioend_bpf;
+	} progs;
+	struct {
+		struct bpf_link *crazy_begin_bpf;
+		struct bpf_link *crazy_end_bpf;
+		struct bpf_link *crazy_ioend_bpf;
+		struct bpf_link *fuse4fs_bpf_ops;
+	} links;
+};
+
+static void
+fuse4fs_bpf__destroy(struct fuse4fs_bpf *obj)
+{
+	if (!obj)
+		return;
+	if (obj->skeleton)
+		bpf_object__destroy_skeleton(obj->skeleton);
+	free(obj);
+}
+
+static inline size_t
+fuse4fs_bpf_nr_progs(const struct fuse4fs_bpf_attrs *attrs)
+{
+	size_t ret = 0;
+
+	if (attrs->begin_fn_name)
+		ret++;
+	if (attrs->end_fn_name)
+		ret++;
+	if (attrs->ioend_fn_name)
+		ret++;
+	return ret;
+}
+
+static int
+fuse4fs_bpf__create_skeleton(struct fuse4fs_bpf *obj,
+			   const struct fuse4fs_bpf_attrs *attrs)
+{
+	struct bpf_object_skeleton *s;
+	struct bpf_map_skeleton *map __attribute__((unused));
+	int err;
+
+	s = (struct bpf_object_skeleton *)calloc(1, sizeof(*s));
+	if (!s)	{
+		err = -ENOMEM;
+		goto err;
+	}
+
+	s->sz = sizeof(*s);
+	s->name = attrs->skel_name;
+	s->obj = &obj->obj;
+
+	/* maps */
+	s->map_cnt = 1;
+	s->map_skel_sz = 32;
+	s->maps = (struct bpf_map_skeleton *)calloc(s->map_cnt,
+			sizeof(*s->maps) > 32 ? sizeof(*s->maps) : 32);
+	if (!s->maps) {
+		err = -ENOMEM;
+		goto err;
+	}
+
+	map = (struct bpf_map_skeleton *)((char *)s->maps + 0 * s->map_skel_sz);
+	map->name = attrs->ops_name;
+	map->map = &obj->maps.fuse4fs_bpf_ops;
+	map->link = &obj->links.fuse4fs_bpf_ops;
+
+	/* programs */
+	s->prog_cnt = 0;
+	s->prog_skel_sz = sizeof(*s->progs);
+	s->progs = calloc(fuse4fs_bpf_nr_progs(attrs), s->prog_skel_sz);
+	if (!s->progs) {
+		err = -ENOMEM;
+		goto err;
+	}
+
+	if (attrs->begin_fn_name) {
+		s->progs[s->prog_cnt].name = attrs->begin_fn_name;
+		s->progs[s->prog_cnt].prog = &obj->progs.crazy_begin_bpf;
+		s->progs[s->prog_cnt].link = &obj->links.crazy_begin_bpf;
+		s->prog_cnt++;
+	}
+
+	if (attrs->end_fn_name) {
+		s->progs[s->prog_cnt].name = attrs->end_fn_name;
+		s->progs[s->prog_cnt].prog = &obj->progs.crazy_end_bpf;
+		s->progs[s->prog_cnt].link = &obj->links.crazy_end_bpf;
+		s->prog_cnt++;
+	}
+
+	if (attrs->ioend_fn_name) {
+		s->progs[s->prog_cnt].name = attrs->ioend_fn_name;
+		s->progs[s->prog_cnt].prog = &obj->progs.crazy_ioend_bpf;
+		s->progs[s->prog_cnt].link = &obj->links.crazy_ioend_bpf;
+		s->prog_cnt++;
+	}
+
+	s->data = attrs->elf_data;
+	s->data_sz = attrs->elf_size;
+
+	obj->skeleton = s;
+	return 0;
+err:
+	bpf_object__destroy_skeleton(s);
+	return err;
+}
+
+static struct fuse4fs_bpf *
+fuse4fs_bpf__open_opts(const struct bpf_object_open_opts *opts,
+		     const struct fuse4fs_bpf_attrs *attrs)
+{
+	struct fuse4fs_bpf *obj;
+	int err;
+
+	obj = (struct fuse4fs_bpf *)calloc(1, sizeof(*obj));
+	if (!obj) {
+		errno = ENOMEM;
+		return NULL;
+	}
+
+	err = fuse4fs_bpf__create_skeleton(obj, attrs);
+	if (err)
+		goto err_out;
+
+	err = bpf_object__open_skeleton(obj->skeleton, opts);
+	if (err)
+		goto err_out;
+
+	obj->struct_ops.fuse4fs_bpf_ops = (__typeof__(obj->struct_ops.fuse4fs_bpf_ops))
+		bpf_map__initial_value(obj->maps.fuse4fs_bpf_ops, NULL);
+
+	return obj;
+err_out:
+	fuse4fs_bpf__destroy(obj);
+	errno = -err;
+	return NULL;
+}
+
+static inline int
+fuse4fs_bpf__load(struct fuse4fs_bpf *obj)
+{
+	return bpf_object__load_skeleton(obj->skeleton);
+}
+
+static inline int
+fuse4fs_bpf__attach(struct fuse4fs_bpf *obj)
+{
+	return bpf_object__attach_skeleton(obj->skeleton);
+}
+
+static inline void
+fuse4fs_bpf__detach(struct fuse4fs_bpf *obj)
+{
+	bpf_object__detach_skeleton(obj->skeleton);
+}
+
+/* Put compiled BPF program in the kernel and link it to the fuse connection */
+int
+fuse4fs_bpf_ctl_setup(struct fuse4fs_bpf_ctl *arg, struct fuse_session *se,
+		      const struct fuse4fs_bpf_attrs *attrs)
+{
+	int err;
+
+	arg->skel = fuse4fs_bpf__open_opts(NULL, attrs);
+	if (!arg->skel)
+		return -ENOENT;
+
+	arg->skel->struct_ops.fuse4fs_bpf_ops->fuse_fd = fuse_session_fd(se);
+
+	err = fuse4fs_bpf__load(arg->skel);
+	if (err) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	arg->link = bpf_map__attach_struct_ops(arg->skel->maps.fuse4fs_bpf_ops);
+	if (!arg->link) {
+		err = -errno;
+		goto cleanup;
+	}
+
+	return 0;
+
+cleanup:
+	fuse4fs_bpf__destroy(arg->skel);
+	arg->skel = NULL;
+	return err;
+}
+
+/* Drop the BPF object code but leave the overrides running */
+void
+fuse4fs_bpf_ctl_drop_skeleton(struct fuse4fs_bpf_ctl *arg)
+{
+	if (arg->skel) {
+		fuse4fs_bpf__destroy(arg->skel);
+		arg->skel = NULL;
+	}
+}
+
+/* Drop all the BPF artifacts, disabling the override */
+void
+fuse4fs_bpf_ctl_cleanup(struct fuse4fs_bpf_ctl *arg)
+{
+	if (arg->link) {
+		bpf_link__destroy(arg->link);
+		arg->link = NULL;
+	}
+
+	if (arg->skel) {
+		fuse4fs_bpf__destroy(arg->skel);
+		arg->skel = NULL;
+	}
+}
+
+static void
+close_fds(int start_fd)
+{
+	int max_fd = sysconf(_SC_OPEN_MAX);
+	int fd;
+#ifdef HAVE_CLOSE_RANGE
+	int ret;
+#endif
+
+	if (max_fd < 1)
+		max_fd = 1024;
+
+#ifdef HAVE_CLOSE_RANGE
+	ret = close_range(start_fd, max_fd, 0);
+	if (!ret)
+		return;
+#endif
+
+	for (fd = start_fd; fd < max_fd; fd++)
+		close(fd);
+}
+
+/* Compile some BPF source code into binary format */
+int
+fuse4fs_bpf_compile(struct fuse4fs_bpf_attrs *attrs,
+		    const struct fuse4fs_bpf_compile *cc)
+{
+	char infile[64];
+	char outfile[64];
+	// clang --target=bpf -Wall -O2 -g -x c -c /dev/fd/37 -o /dev/fd/38
+	// -I /usr/include/x86_64-linux-gnu/linux/bpf/ -I ../../include/
+	char *args[] = {
+		"clang", "--target=bpf", "-Wall", "-O2", "-g", "-x", "c",
+		"-c", infile, "-o", outfile,
+		"-I", (char *)cc->vmlinux_h_dir,
+		"-I", (char *)cc->fuse_include_dir,
+		NULL
+	};
+	struct stat statbuf;
+	void *buf, *read_ptr;
+	const void *write_ptr;
+	size_t to_read, to_write;
+	pid_t child;
+	int child_status;
+	int infd;
+	int outfd;
+	int ret = 0;
+
+	infd = memfd_create("infile", 0);
+	if (infd < 0)
+		return -1;
+
+	outfd = memfd_create("outfile", 0);
+	if (outfd < 0) {
+		ret = -1;
+		goto out_infd;
+	}
+
+	snprintf(infile, sizeof(infile), "/dev/fd/%d", infd);
+	snprintf(outfile, sizeof(outfile), "/dev/fd/%d", outfd);
+
+	write_ptr = cc->source_code;
+	to_write = strlen(cc->source_code);
+	while (to_write > 0) {
+		ssize_t bytes_written = write(infd, write_ptr, to_write);
+		if (bytes_written < 0) {
+			ret = -1;
+			goto out_outfd;
+		}
+		if (bytes_written == 0) {
+			errno = EIO;
+			ret = -1;
+			goto out_outfd;
+		}
+
+		write_ptr += bytes_written;
+		to_write -= bytes_written;
+	}
+
+	child = fork();
+	switch (child) {
+	case -1:
+		ret = -1;
+		goto out_outfd;
+	case 0:
+		close_fds(max(infd, outfd) + 1);
+		execvp(args[0], args);
+		perror(args[0]);
+		exit(EXIT_FAILURE);
+		break;
+	default:
+		waitpid(child, &child_status, 0);
+		break;
+	}
+
+	if (!WIFEXITED(child_status) || WEXITSTATUS(child_status) != 0) {
+		errno = ENOMEM;
+		ret = -1;
+		goto out_outfd;
+	}
+
+	ret = fstat(outfd, &statbuf);
+	if (ret)
+		goto out_outfd;
+
+	if (statbuf.st_size >= SIZE_MAX) {
+		errno = EFBIG;
+		ret = -1;
+		goto out_outfd;
+	}
+	to_read = statbuf.st_size;
+
+	buf = malloc(to_read);
+	if (!buf)
+		goto out_outfd;
+	read_ptr = buf;
+
+	while (to_read > 0) {
+		ssize_t bytes_read = read(outfd, read_ptr, to_read);
+		if (bytes_read < 0) {
+			ret = -1;
+			goto out_buf;
+		}
+		if (bytes_read == 0) {
+			errno = EIO;
+			ret = -1;
+			goto out_buf;
+		}
+
+		read_ptr += bytes_read;
+		to_read -= bytes_read;
+	}
+
+	attrs->elf_data = buf;
+	attrs->elf_size = statbuf.st_size;
+	buf = NULL;
+	ret = 0;
+
+out_buf:
+	free(buf);
+out_outfd:
+	close(outfd);
+out_infd:
+	close(infd);
+	return ret;
+}
diff --git a/lib/config.h.in b/lib/config.h.in
index 129f7ffcf060f3..ecc81eea839f16 100644
--- a/lib/config.h.in
+++ b/lib/config.h.in
@@ -99,6 +99,9 @@
 /* Define to 1 if you have the 'chflags' function. */
 #undef HAVE_CHFLAGS
 
+/* Define to 1 if you have the 'close_range' function. */
+#undef HAVE_CLOSE_RANGE
+
 /* Define if the GNU dcgettext() function is already present or preinstalled.
    */
 #undef HAVE_DCGETTEXT
@@ -717,4 +720,13 @@
 /* Define to 1 if you have the 'setproctitle' function. */
 #undef HAVE_SETPROCTITLE
 
+/* Define to 1 if fuse iomap bpf present */
+#undef HAVE_IOMAP_BPF
+
+/* Location of vmlinux.h */
+#undef VMLINUX_H_DIR
+
+/* Location of fuse headers */
+#undef FUSE_INCLUDE_PATH
+
 #include <dirpaths.h>


