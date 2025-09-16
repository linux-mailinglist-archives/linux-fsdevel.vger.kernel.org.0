Return-Path: <linux-fsdevel+bounces-61587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D465B58A06
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6501B22F14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51E114B950;
	Tue, 16 Sep 2025 00:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m42xlLw2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083FA3D561
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983730; cv=none; b=H8NZkDlUXbftbeBWPFFOQbLHFI9vnicDp5PDrLTxbmj2J27DKKP2+/mf4LDx21ImiLkmtC23GPieD5hD0T1Y67Ndx8e95Vp+NaziCI1bQWvhbZgAHbdwMs/lh++KEjQzUnQzx6tHVZBz3K5Jv6cVnEpWgnqxlh88Vb6Zekpw/d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983730; c=relaxed/simple;
	bh=6HFph9wdJTbkuAMPyuuy0ySzDqSoxBeU+2YLH+gST90=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVQRBFP6uD7pwEF1Wnvn7N0j4g3mzt/E9PcHRu29JmQP9vIIL54pCuuMTOqQOEhtcrP4HeEwNiPCk7dlQOi3yb3ohaltc2SXrqowLDdngbl7a/ha4Sg+0ktsoM/b5ngQigovaUgNskOlNoNATlGbL2u//medQ4XMgvap/BMMpxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m42xlLw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8712DC4CEF1;
	Tue, 16 Sep 2025 00:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983729;
	bh=6HFph9wdJTbkuAMPyuuy0ySzDqSoxBeU+2YLH+gST90=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=m42xlLw2nRGBYSQCzHUWWBSORXwD1m43XKo7tjSiPrmPK+ATGhAoQqyN2LtqZ9LdD
	 kVNKrCUozEN6NvUNGCGB8IZlxUxwrZWYTVAqN2uEtLcojk6xVvB9xeKkoh6FcJ8q0p
	 w50HdFq7emFSAfyfFjLTMyKxUr0pOyeQMdY6db8UUcRNoicPLQAYbPe89ATsLoJFFn
	 KNfqA141imOs1c+lHh8S/71uJVp2IeQt+TuNMpJoE4Cbgn+e371xcESfbhFnpCC77u
	 +sc56p3IGkeOJ72EhiAZTJxNrR9O2TJ7IBVp7R7S4N4qUEgIl1DYobQQJK+u3g2yDh
	 34koKaSLk4MCA==
Date: Mon, 15 Sep 2025 17:48:49 -0700
Subject: [PATCH 1/4] libfuse: add systemd/inetd socket service mounting helper
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798155788.388120.6904064506237991324.stgit@frogsfrogsfrogs>
In-Reply-To: <175798155756.388120.4267843355083714610.stgit@frogsfrogsfrogs>
References: <175798155756.388120.4267843355083714610.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create a mount.service helper that can start a fuse server that runs
as a socket-based systemd (or inetd) service.  To make things simpler
for fuse server authors, define a new library interface to wrap all the
functionality so that they don't have to know the details

This enables untrusted ext4 mounts via systemd service containers, which
avoids the problem of malicious filesystems compromising the integrity
of the running kernel through memory corruption.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_service.h      |  151 +++++++
 include/fuse_service_priv.h |   98 ++++
 lib/fuse_i.h                |    5 
 util/mount_service.h        |   32 +
 doc/fuservicemount3.8       |   24 +
 doc/meson.build             |    3 
 include/meson.build         |    4 
 lib/fuse_service.c          |  764 ++++++++++++++++++++++++++++++++++
 lib/fuse_service_stub.c     |   90 ++++
 lib/fuse_versionscript      |   13 +
 lib/helper.c                |   53 ++
 lib/meson.build             |   14 +
 lib/mount.c                 |   57 ++-
 meson.build                 |   36 ++
 meson_options.txt           |    6 
 util/fuservicemount.c       |   18 +
 util/meson.build            |    9 
 util/mount_service.c        |  962 +++++++++++++++++++++++++++++++++++++++++++
 18 files changed, 2325 insertions(+), 14 deletions(-)
 create mode 100644 include/fuse_service.h
 create mode 100644 include/fuse_service_priv.h
 create mode 100644 util/mount_service.h
 create mode 100644 doc/fuservicemount3.8
 create mode 100644 lib/fuse_service.c
 create mode 100644 lib/fuse_service_stub.c
 create mode 100644 util/fuservicemount.c
 create mode 100644 util/mount_service.c


diff --git a/include/fuse_service.h b/include/fuse_service.h
new file mode 100644
index 00000000000000..7c44c701bd695b
--- /dev/null
+++ b/include/fuse_service.h
@@ -0,0 +1,151 @@
+/*  FUSE: Filesystem in Userspace
+  Copyright (C) 2025 Oracle.
+  Author: Darrick J. Wong <djwong@kernel.org>
+
+  This program can be distributed under the terms of the GNU LGPLv2.
+  See the file LGPL2.txt.
+*/
+#ifndef FUSE_SERVICE_H_
+#define FUSE_SERVICE_H_
+
+struct fuse_service;
+
+/**
+ * Accept a socket created by mount.service for information exchange.
+ *
+ * @param sfp pointer to pointer to a service context
+ * @return -1 on error, 0 on success
+ */
+int fuse_service_accept(struct fuse_service **sfp);
+
+/**
+ * Has the fuse server accepted a service context?
+ *
+ * @param sf service context
+ */
+static inline bool fuse_service_accepted(struct fuse_service *sf)
+{
+	return sf != NULL;
+}
+
+/**
+ * Release all resources associated with the service context.
+ *
+ * @param sfp service context
+ */
+void fuse_service_release(struct fuse_service *sf);
+
+/**
+ * Destroy a service context and release all resources
+ *
+ * @param sfp pointer to pointer to a service context
+ */
+void fuse_service_destroy(struct fuse_service **sfp);
+
+/**
+ * Append the command line arguments from the mount service helper to an
+ * existing fuse_args structure.  The fuse_args should have been initialized
+ * with the argc and argv passed to main().
+ *
+ * @param sfp service context
+ * @param args arguments to modify (input+output)
+ * @return -1 on success, 0 on success
+ */
+int fuse_service_append_args(struct fuse_service *sf, struct fuse_args *args);
+
+/**
+ * Generate the effective fuse server command line from the args structure.
+ * The args structure should be the outcome from fuse_service_append_args.
+ * The resulting string is suitable for setproctitle and must be freed by the
+ * callre.
+ *
+ * @param argc argument count passed to main()
+ * @param argv argument vector passed to main()
+ * @param args fuse args structure
+ * @return effective command line string, or NULL
+ */
+char *fuse_service_cmdline(int argc, char *argv[], struct fuse_args *args);
+
+/**
+ * Take the fuse device fd passed from the mount.service helper
+ *
+ * @return device fd on success, -1 on error
+ */
+int fuse_service_take_fusedev(struct fuse_service *sfp);
+
+/**
+ * Utility function to parse common options for simple file systems
+ * using the low-level API. A help text that describes the available
+ * options can be printed with `fuse_cmdline_help`. A single
+ * non-option argument is treated as the mountpoint. Multiple
+ * non-option arguments will result in an error.
+ *
+ * If neither -o subtype= or -o fsname= options are given, a new
+ * subtype option will be added and set to the basename of the program
+ * (the fsname will remain unset, and then defaults to "fuse").
+ *
+ * Known options will be removed from *args*, unknown options will
+ * remain. The mountpoint will not be checked here; that is the job of
+ * mount.service.
+ *
+ * @param args argument vector (input+output)
+ * @param opts output argument for parsed options
+ * @return 0 on success, -1 on failure
+ */
+int fuse_service_parse_cmdline_opts(struct fuse_args *args,
+				    struct fuse_cmdline_opts *opts);
+
+/**
+ * Ask the mount.service helper to open a file on behalf of the fuse server.
+ *
+ * @param sf service context
+ * @param path path to file
+ * @param flags O_ flags
+ * @param mode mode with which to create the file
+ * @return 0 on success, -1 on failure
+ */
+int fuse_service_request_file(struct fuse_service *sf, const char *path,
+			      int flags, mode_t mode);
+
+/**
+ * Receive a file perviously requested.
+ *
+ * @param sf service context
+ * @param path to file
+ * @fdp pointer to file descriptor
+ * @return 0 on success, -1 on socket communication failure, -2 on file open
+ * failure
+ */
+int fuse_service_receive_file(struct fuse_service *sf,
+			      const char *path, int *fdp);
+
+/**
+ * Prevent the mount.service server from sending us any more open files.
+ *
+ * @param sf service context
+ */
+int fuse_service_finish_file_requests(struct fuse_service *sf);
+
+/**
+ * Ask the mount.service helper to mount the filesystem for us.  The fuse client
+ * will begin sending requests to the fuse server immediately after this.
+ *
+ * @param sf service context
+ * @param se fuse session
+ * @param mountpoint place to mount the filesystem
+ * @return 0 on success, -1 on error
+ */
+int fuse_service_mount(struct fuse_service *sf, struct fuse_session *se,
+		       const char *mountpoint);
+
+/**
+ * Bid farewell to the mount.service helper.  It is still necessary to call
+ * fuse_service_destroy after this.
+ *
+ * @param sf service context
+ * @param error any additional errors to send to the mount helper
+ * @return 0 on success, -1 on error
+ */
+int fuse_service_send_goodbye(struct fuse_service *sf, int error);
+
+#endif /* FUSE_SERVICE_H_ */
diff --git a/include/fuse_service_priv.h b/include/fuse_service_priv.h
new file mode 100644
index 00000000000000..1c01a7ba9614f2
--- /dev/null
+++ b/include/fuse_service_priv.h
@@ -0,0 +1,98 @@
+/*  FUSE: Filesystem in Userspace
+  Copyright (C) 2025 Oracle.
+  Author: Darrick J. Wong <djwong@kernel.org>
+
+  This program can be distributed under the terms of the GNU LGPLv2.
+  See the file LGPL2.txt.
+*/
+#ifndef FUSE_SERVICE_PRIV_H_
+#define FUSE_SERVICE_PRIV_H_
+
+struct fuse_service_memfd_arg {
+	__be32 pos;
+	__be32 len;
+};
+
+struct fuse_service_memfd_argv {
+	__be32 magic;
+	__be32 argc;
+};
+
+#define FUSE_SERVICE_ARGS_MAGIC		0x41524753	/* ARGS */
+
+/* mount.service sends a hello to the server and it replies */
+#define FUSE_SERVICE_HELLO_CMD		0x53414654	/* SAFT */
+#define FUSE_SERVICE_HELLO_REPLY	0x4c415354	/* LAST */
+
+/* fuse servers send commands to mount.service */
+#define FUSE_SERVICE_OPEN_CMD		0x4f50454e	/* OPEN */
+#define FUSE_SERVICE_FSOPEN_CMD		0x54595045	/* TYPE */
+#define FUSE_SERVICE_SOURCE_CMD		0x4e414d45	/* NAME */
+#define FUSE_SERVICE_MNTOPTS_CMD	0x4f505453	/* OPTS */
+#define FUSE_SERVICE_MNTPT_CMD		0x4d4e5450	/* MNTP */
+#define FUSE_SERVICE_MOUNT_CMD		0x444f4954	/* DOIT */
+#define FUSE_SERVICE_BYE_CMD		0x42594545	/* BYEE */
+
+/* mount.service sends replies to the fuse server */
+#define FUSE_SERVICE_OPEN_REPLY		0x46494c45	/* FILE */
+#define FUSE_SERVICE_SIMPLE_REPLY	0x5245504c	/* REPL */
+
+struct fuse_service_packet {
+	__be32 magic;			/* FUSE_SERVICE_*_{CMD,REPLY} */
+};
+
+struct fuse_service_simple_reply {
+	struct fuse_service_packet p;
+	__be32 error;
+};
+
+struct fuse_service_requested_file {
+	struct fuse_service_packet p;
+	__be32 error;			/* positive errno */
+	char path[];
+};
+
+static inline size_t sizeof_fuse_service_requested_file(size_t pathlen)
+{
+	return sizeof(struct fuse_service_requested_file) + pathlen + 1;
+}
+
+struct fuse_service_open_command {
+	struct fuse_service_packet p;
+	__be32 flags;
+	__be32 mode;
+	char path[];
+};
+
+static inline size_t sizeof_fuse_service_open_command(size_t pathlen)
+{
+	return sizeof(struct fuse_service_open_command) + pathlen + 1;
+}
+
+struct fuse_service_string_command {
+	struct fuse_service_packet p;
+	char value[];
+};
+
+static inline size_t sizeof_fuse_service_string_command(size_t len)
+{
+	return sizeof(struct fuse_service_string_command) + len + 1;
+}
+
+struct fuse_service_bye_command {
+	struct fuse_service_packet p;
+	__be32 error;
+};
+
+struct fuse_service_mount_command {
+	struct fuse_service_packet p;
+	__be32 flags;
+};
+
+int fuse_parse_cmdline_service(struct fuse_args *args,
+				 struct fuse_cmdline_opts *opts);
+
+#define FUSE_SERVICE_ARGV	"argv"
+#define FUSE_SERVICE_FUSEDEV	"fusedev"
+
+#endif /* FUSE_SERVICE_PRIV_H_ */
diff --git a/lib/fuse_i.h b/lib/fuse_i.h
index 0d0e637ae5a31c..5af8ed6a382a19 100644
--- a/lib/fuse_i.h
+++ b/lib/fuse_i.h
@@ -214,6 +214,11 @@ unsigned get_max_read(struct mount_opts *o);
 void fuse_kern_unmount(const char *mountpoint, int fd);
 int fuse_kern_mount(const char *mountpoint, struct mount_opts *mo);
 
+char *fuse_mountopts_fstype(const struct mount_opts *mo);
+char *fuse_mountopts_source(const struct mount_opts *mo, const char *devname);
+char *fuse_mountopts_kernel_opts(const struct mount_opts *mo);
+unsigned int fuse_mountopts_flags(const struct mount_opts *mo);
+
 int fuse_send_reply_iov_nofree(fuse_req_t req, int error, struct iovec *iov,
 			       int count);
 void fuse_free_req(fuse_req_t req);
diff --git a/util/mount_service.h b/util/mount_service.h
new file mode 100644
index 00000000000000..986a785bed3e74
--- /dev/null
+++ b/util/mount_service.h
@@ -0,0 +1,32 @@
+/*
+  FUSE: Filesystem in Userspace
+  Copyright (C) 2025 Oracle.
+  Author: Darrick J. Wong <djwong@kernel.org>
+
+  This program can be distributed under the terms of the GNU GPLv2.
+  See the file GPL2.txt.
+*/
+#ifndef MOUNT_SERVICE_H_
+#define MOUNT_SERVICE_H_
+
+/**
+ * Connect to a fuse service socket and try to mount the filesystem as
+ * specified with the CLI arguments.
+ *
+ * @argc argument count
+ * @argv vector of argument strings
+ * @return EXIT_SUCCESS for success, EXIT_FAILURE if mount fails
+ */
+int mount_service_main(int argc, char *argv[]);
+
+/**
+ * Return the fuse filesystem subtype from a full fuse filesystem type
+ * specification.  IOWs, fuse.Y -> Y; fuseblk.Z -> Z; or A -> A.  The returned
+ * pointer is within the caller's string.
+ *
+ * @param fstype full fuse filesystem type
+ * @return fuse subtype
+ */
+const char *mount_service_subtype(const char *fstype);
+
+#endif /* MOUNT_SERVICE_H_ */
diff --git a/doc/fuservicemount3.8 b/doc/fuservicemount3.8
new file mode 100644
index 00000000000000..e45d6a89c8b81a
--- /dev/null
+++ b/doc/fuservicemount3.8
@@ -0,0 +1,24 @@
+.TH fuservicemount3 "8"
+.SH NAME
+fuservicemount3 \- mount a FUSE filesystem that runs as a system socket service
+.SH SYNOPSIS
+.B fuservicemount3
+.B source
+.B mountpoint
+.BI -t " fstype"
+[
+.I options
+]
+.SH DESCRIPTION
+Mount a filesystem using a FUSE server that runs as a socket service.
+These servers can be contained using the platform's service management
+framework.
+.SH "AUTHORS"
+.LP
+The author of the fuse socket service code is Darrick J. Wong <djwong@kernel.org>.
+Debian GNU/Linux distribution.
+.SH SEE ALSO
+.BR fusermount3 (1)
+.BR fusermount (1)
+.BR mount (8)
+.BR fuse (4)
diff --git a/doc/meson.build b/doc/meson.build
index db3e0b26f71975..c105cf3471fdf4 100644
--- a/doc/meson.build
+++ b/doc/meson.build
@@ -2,3 +2,6 @@ if not platform.endswith('bsd') and platform != 'dragonfly'
   install_man('fusermount3.1', 'mount.fuse3.8')
 endif
 
+if private_cfg.get('HAVE_SERVICEMOUNT', false)
+  install_man('fuservicemount3.8')
+endif
diff --git a/include/meson.build b/include/meson.build
index bf671977a5a6a9..da51180f87eea2 100644
--- a/include/meson.build
+++ b/include/meson.build
@@ -1,4 +1,8 @@
 libfuse_headers = [ 'fuse.h', 'fuse_common.h', 'fuse_lowlevel.h',
 	            'fuse_opt.h', 'cuse_lowlevel.h', 'fuse_log.h' ]
 
+if private_cfg.get('HAVE_SERVICEMOUNT', false)
+  libfuse_headers += [ 'fuse_service.h' ]
+endif
+
 install_headers(libfuse_headers, subdir: 'fuse3')
diff --git a/lib/fuse_service.c b/lib/fuse_service.c
new file mode 100644
index 00000000000000..ab50f0017b255c
--- /dev/null
+++ b/lib/fuse_service.c
@@ -0,0 +1,764 @@
+/*
+  FUSE: Filesystem in Userspace
+  Copyright (C) 2025 Oracle.
+  Author: Darrick J. Wong <djwong@kernel.org>
+
+  Library functions to support fuse servers that can be run as "safe" systemd
+  containers.
+
+  This program can be distributed under the terms of the GNU LGPLv2.
+  See the file LGPL2.txt
+*/
+
+#define _GNU_SOURCE
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdio.h>
+#include <errno.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <systemd/sd-daemon.h>
+#include <arpa/inet.h>
+
+#include "fuse_config.h"
+#include "fuse_i.h"
+#include "fuse_service_priv.h"
+#include "fuse_service.h"
+
+struct fuse_service {
+	/* socket fd */
+	int sockfd;
+
+	/* /dev/fuse device */
+	int fusedevfd;
+
+	/* memfd for cli arguments */
+	int argvfd;
+};
+
+static int __recv_fd(int sockfd, struct fuse_service_requested_file *buf,
+		     ssize_t bufsize, int *fdp)
+{
+	struct iovec iov = {
+		.iov_base = buf,
+		.iov_len = bufsize,
+	};
+	union {
+		struct cmsghdr cmsghdr;
+		char control[CMSG_SPACE(sizeof (int))];
+	} cmsgu;
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = cmsgu.control,
+		.msg_controllen = sizeof(cmsgu.control),
+	};
+	struct cmsghdr *cmsg;
+	ssize_t size;
+
+	memset(&cmsgu, 0, sizeof(cmsgu));
+
+	size = recvmsg(sockfd, &msg, MSG_TRUNC);
+	if (size < 0) {
+		perror("fuse: service file reply");
+		return -1;
+	}
+	if (size > bufsize ||
+	    size < offsetof(struct fuse_service_requested_file, path)) {
+		fprintf(stderr,
+ "fuse: wrong service file reply size %zd, expected %zd\n",
+			size, bufsize);
+		return -1;
+	}
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	if (!cmsg) {
+		/* no control message means mount.service sent us an error */
+		return 0;
+	}
+	if (cmsg->cmsg_len != CMSG_LEN(sizeof(int))) {
+		fprintf(stderr,
+ "fuse: wrong service file reply control data size %zd, expected %zd\n",
+			cmsg->cmsg_len, CMSG_LEN(sizeof(int)));
+		return -1;
+	}
+	if (cmsg->cmsg_level != SOL_SOCKET || cmsg->cmsg_type != SCM_RIGHTS) {
+		fprintf(stderr,
+ "fuse: wrong service file reply control data level %d type %d, expected %d and %d\n",
+			cmsg->cmsg_level, cmsg->cmsg_type, SOL_SOCKET,
+			SCM_RIGHTS);
+		return -1;
+	}
+
+	memcpy(fdp, (int *)CMSG_DATA(cmsg), sizeof(int));
+	return 0;
+}
+
+static int recv_requested_file(int sockfd, const char *path, int *fdp)
+{
+	struct fuse_service_requested_file *req;
+	const size_t req_sz = sizeof_fuse_service_requested_file(strlen(path));
+	int ret;
+
+	*fdp = -1;
+	req = calloc(1, req_sz + 1);
+	if (!req) {
+		perror("fuse: alloc service file reply");
+		return -1;
+	}
+
+	ret = __recv_fd(sockfd, req, req_sz, fdp);
+	if (ret)
+		goto out_req;
+
+	if (req->p.magic != ntohl(FUSE_SERVICE_OPEN_REPLY)) {
+		fprintf(stderr,
+ "fuse: service file reply contains wrong magic!\n");
+		ret = -1;
+		goto out_close;
+	}
+	if (strcmp(req->path, path)) {
+		fprintf(stderr,
+ "fuse: `%s': not the requested service file, got `%s'\n",
+			path, req->path);
+		ret = -1;
+		goto out_close;
+	}
+
+	if (req->error) {
+		errno = ntohl(req->error);
+		ret = -2;
+		goto out_req;
+	}
+
+	free(req);
+	return 0;
+
+out_close:
+	close(*fdp);
+	*fdp = -1;
+out_req:
+	free(req);
+	return ret;
+}
+
+int fuse_service_receive_file(struct fuse_service *sf, const char *path,
+			      int *fdp)
+{
+	return recv_requested_file(sf->sockfd, path, fdp);
+}
+
+int fuse_service_request_file(struct fuse_service *sf, const char *path,
+			      int flags, mode_t mode)
+{
+	struct iovec iov = {
+		.iov_len = sizeof_fuse_service_open_command(strlen(path)),
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+	struct fuse_service_open_command *cmd;
+	ssize_t size;
+	int ret;
+
+	cmd = calloc(1, iov.iov_len);
+	if (!cmd) {
+		perror("fuse: alloc service file request");
+		return -1;
+	}
+	cmd->p.magic = htonl(FUSE_SERVICE_OPEN_CMD);
+	cmd->flags = htonl(flags);
+	cmd->mode = htonl(mode);
+	strcpy(cmd->path, path);
+	iov.iov_base = cmd;
+
+	size = sendmsg(sf->sockfd, &msg, MSG_EOR | MSG_NOSIGNAL);
+	if (size < 0) {
+		perror("fuse: request service file");
+		ret = -1;
+		goto out_free;
+	}
+
+	ret = 0;
+out_free:
+	free(cmd);
+	return ret;
+}
+
+int fuse_service_send_goodbye(struct fuse_service *sf, int error)
+{
+	struct fuse_service_bye_command c = {
+		.p.magic = htonl(FUSE_SERVICE_BYE_CMD),
+		.error = htonl(error),
+	};
+	struct iovec iov = {
+		.iov_base = &c,
+		.iov_len = sizeof(c),
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+	ssize_t size;
+
+	/* already gone? */
+	if (sf->sockfd < 0)
+		return 0;
+
+	size = sendmsg(sf->sockfd, &msg, MSG_EOR | MSG_NOSIGNAL);
+	if (size < 0) {
+		perror("fuse: send service goodbye");
+		return -1;
+	}
+
+	shutdown(sf->sockfd, SHUT_RDWR);
+	close(sf->sockfd);
+	sf->sockfd = -1;
+	return 0;
+}
+
+static int find_socket_fd(void)
+{
+	struct stat statbuf;
+	char *listen_fds;
+	int nr_fds;
+	int ret;
+
+	listen_fds = getenv("LISTEN_FDS");
+	if (!listen_fds)
+		return -2;
+
+	nr_fds = atoi(listen_fds);
+	if (nr_fds != 1) {
+		fprintf(stderr,
+ "fuse: can only handle 1 service socket, got %d.\n",
+			nr_fds);
+		return -1;
+	}
+
+	ret = fstat(SD_LISTEN_FDS_START, &statbuf);
+	if (ret) {
+		perror("fuse: service socket");
+		return -1;
+	}
+
+	if (!S_ISSOCK(statbuf.st_mode)) {
+		fprintf(stderr,
+ "fuse: expected service fd %d to be a socket\n",
+				SD_LISTEN_FDS_START);
+		return -1;
+	}
+
+	return SD_LISTEN_FDS_START;
+}
+
+static int negotiate_hello(int sockfd)
+{
+	struct fuse_service_packet p = { };
+	struct iovec iov = {
+		.iov_base = &p,
+		.iov_len = sizeof(p),
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+	ssize_t size;
+
+	size = recvmsg(sockfd, &msg, MSG_TRUNC);
+	if (size < 0) {
+		perror("fuse: receive service hello");
+		return -1;
+	}
+	if (size != sizeof(p)) {
+		fprintf(stderr,
+ "fuse: wrong service hello size %zd, expected %zd\n",
+			size, sizeof(p));
+		return -1;
+	}
+
+	if (p.magic != ntohl(FUSE_SERVICE_HELLO_CMD)) {
+		fprintf(stderr,
+ "fuse: service server did not send hello command\n");
+		return -1;
+	}
+
+	p.magic = htonl(FUSE_SERVICE_HELLO_REPLY);
+	size = sendmsg(sockfd, &msg, MSG_EOR | MSG_NOSIGNAL);
+	if (size < 0) {
+		perror("fuse: service hello reply");
+		return -1;
+	}
+
+	return 0;
+}
+
+int fuse_service_accept(struct fuse_service **sfp)
+{
+	struct fuse_service *sf;
+	int ret = 0;
+
+	*sfp = NULL;
+
+	sf = calloc(1, sizeof(struct fuse_service));
+	if (!sf) {
+		perror("fuse: service alloc");
+		return -1;
+	}
+
+	/* Find the socket that connects us to mount.service */
+	sf->sockfd = find_socket_fd();
+	if (sf->sockfd == -2) {
+		/* magic code that means no service configured */
+		ret = 0;
+		goto out_sf;
+	}
+	if (sf->sockfd < 0) {
+		ret = -1;
+		goto out_sf;
+	}
+
+	ret = negotiate_hello(sf->sockfd);
+	if (ret)
+		goto out_sf;
+
+	/* Receive the two critical sockets */
+	ret = recv_requested_file(sf->sockfd, FUSE_SERVICE_ARGV, &sf->argvfd);
+	if (ret == -2) {
+		perror("fuse: service mount options file");
+		goto out_sockfd;
+	}
+	if (ret < 0)
+		goto out_sockfd;
+
+	ret = recv_requested_file(sf->sockfd, FUSE_SERVICE_FUSEDEV,
+				  &sf->fusedevfd);
+	if (ret == -2) {
+		perror("fuse: service fuse device");
+		goto out_argvfd;
+	}
+	if (ret < 0)
+		goto out_argvfd;
+
+	*sfp = sf;
+	return 0;
+
+out_argvfd:
+	close(sf->argvfd);
+out_sockfd:
+	shutdown(sf->sockfd, SHUT_RDWR);
+	close(sf->sockfd);
+out_sf:
+	free(sf);
+	return ret;
+}
+
+int fuse_service_append_args(struct fuse_service *sf,
+			     struct fuse_args *existing_args)
+{
+	struct fuse_service_memfd_argv memfd_args = { };
+	struct fuse_args new_args = {
+		.allocated = 1,
+	};
+	char *str = NULL;
+	off_t memfd_pos = 0;
+	ssize_t received;
+	unsigned int i;
+	int ret;
+
+	/* Figure out how many arguments we're getting from the mount helper. */
+	received = pread(sf->argvfd, &memfd_args, sizeof(memfd_args), 0);
+	if (received < 0) {
+		perror("fuse: service args file");
+		return -1;
+	}
+	if (received < sizeof(memfd_args)) {
+		fprintf(stderr,
+ "fuse: service args file length unreadable\n");
+		return -1;
+	}
+	if (ntohl(memfd_args.magic) != FUSE_SERVICE_ARGS_MAGIC) {
+		fprintf(stderr, "fuse: service args file corrupt\n");
+		return -1;
+	}
+	memfd_args.magic = ntohl(memfd_args.magic);
+	memfd_args.argc = ntohl(memfd_args.argc);
+	memfd_pos += sizeof(memfd_args);
+
+	/* Allocate a new array of argv string pointers */
+	new_args.argv = calloc(memfd_args.argc + existing_args->argc,
+			       sizeof(char *));
+	if (!new_args.argv) {
+		perror("fuse: service new args");
+		return -1;
+	}
+
+	/*
+	 * Copy the fuse server's CLI arguments.  We'll leave new_args.argv[0]
+	 * unset for now, because we'll set it in the next step with the fstype
+	 * that the mount helper sent us.
+	 */
+	new_args.argc++;
+	for (i = 1; i < existing_args->argc; i++) {
+		if (existing_args->allocated) {
+			new_args.argv[new_args.argc] = existing_args->argv[i];
+			existing_args->argv[i] = NULL;
+		} else {
+			new_args.argv[new_args.argc] =
+						strdup(existing_args->argv[i]);
+			if (!new_args.argv[new_args.argc]) {
+				perror("fuse: service duplicate existing args");
+				ret = -1;
+				goto out_new_args;
+			}
+		}
+
+		new_args.argc++;
+	}
+
+	/* Copy the rest of the arguments from the helper */
+	for (i = 0; i < memfd_args.argc; i++) {
+		struct fuse_service_memfd_arg memfd_arg = { };
+
+		/* Read argv iovec */
+		received = pread(sf->argvfd, &memfd_arg, sizeof(memfd_arg),
+				 memfd_pos);
+		if (received < 0) {
+			perror("fuse: service args file iovec read");
+			ret = -1;
+			goto out_new_args;
+		}
+		if (received < sizeof(struct fuse_service_memfd_arg)) {
+			fprintf(stderr,
+ "fuse: service args file argv[%u] iovec short read %zd",
+				i, received);
+			ret = -1;
+			goto out_new_args;
+		}
+		memfd_arg.pos = ntohl(memfd_arg.pos);
+		memfd_arg.len = ntohl(memfd_arg.len);
+		memfd_pos += sizeof(memfd_arg);
+
+		/* read arg string from file */
+		str = calloc(1, memfd_arg.len + 1);
+		if (!str) {
+			perror("fuse: service arg alloc");
+			ret = -1;
+			goto out_new_args;
+		}
+
+		received = pread(sf->argvfd, str, memfd_arg.len, memfd_arg.pos);
+		if (received < 0) {
+			perror("fuse: service args file read");
+			ret = -1;
+			goto out_str;
+		}
+		if (received < memfd_arg.len) {
+			fprintf(stderr,
+ "fuse: service args file argv[%u] short read %zd",
+				i, received);
+			ret = -1;
+			goto out_str;
+		}
+
+		/* move string into the args structure */
+		if (i == 0) {
+			/* the first argument is the fs type */
+			new_args.argv[0] = str;
+		} else {
+			new_args.argv[new_args.argc] = str;
+			new_args.argc++;
+		}
+		str = NULL;
+	}
+
+	/* drop existing args, move new args to existing args */
+	fuse_opt_free_args(existing_args);
+	memcpy(existing_args, &new_args, sizeof(*existing_args));
+
+	close(sf->argvfd);
+	sf->argvfd = -1;
+
+	return 0;
+
+out_str:
+	free(str);
+out_new_args:
+	fuse_opt_free_args(&new_args);
+	return ret;
+}
+
+int fuse_service_take_fusedev(struct fuse_service *sfp)
+{
+	int ret = sfp->fusedevfd;
+
+	sfp->fusedevfd = -1;
+	return ret;
+}
+
+int fuse_service_finish_file_requests(struct fuse_service *sf)
+{
+#ifdef SO_PASSRIGHTS
+	int zero = 0;
+
+	/* don't let a malicious mount helper send us more fds */
+	return setsockopt(sf->sockfd, SOL_SOCKET, SO_PASSRIGHTS, &zero,
+			  sizeof(zero));
+#else
+	/* shut up gcc */
+	sf = sf;
+	return 0;
+#endif
+}
+
+static int send_string(struct fuse_service *sf, uint32_t command,
+		       const char *value, int *error)
+{
+	struct fuse_service_simple_reply reply = { };
+	struct iovec iov = {
+		.iov_len = sizeof_fuse_service_string_command(strlen(value)),
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+	struct fuse_service_string_command *cmd;
+	ssize_t size;
+
+	cmd = malloc(iov.iov_len);
+	if (!cmd) {
+		perror("fuse: alloc service string send");
+		return -1;
+	}
+	cmd->p.magic = ntohl(command);
+	strcpy(cmd->value, value);
+	iov.iov_base = cmd;
+
+	size = sendmsg(sf->sockfd, &msg, MSG_EOR | MSG_NOSIGNAL);
+	if (size < 0) {
+		perror("fuse: send service string");
+		return -1;
+	}
+	free(cmd);
+
+	iov.iov_base = &reply;
+	iov.iov_len = sizeof(reply);
+	size = recvmsg(sf->sockfd, &msg, MSG_TRUNC);
+	if (size < 0) {
+		perror("fuse: service string reply");
+		return -1;
+	}
+	if (size != sizeof(reply)) {
+		fprintf(stderr,
+ "fuse: wrong service string reply size %zd, expected %zd\n",
+			size, sizeof(reply));
+		return -1;
+	}
+
+	if (ntohl(reply.p.magic) != FUSE_SERVICE_SIMPLE_REPLY) {
+		fprintf(stderr,
+ "fuse: service string reply contains wrong magic!\n");
+		return -1;
+	}
+
+	*error = ntohl(reply.error);
+	return 0;
+}
+
+static int send_mount(struct fuse_service *sf, unsigned int flags, int *error)
+{
+	struct fuse_service_simple_reply reply = { };
+	struct fuse_service_mount_command c = {
+		.p.magic = htonl(FUSE_SERVICE_MOUNT_CMD),
+		.flags = htonl(flags),
+	};
+	struct iovec iov = {
+		.iov_base = &c,
+		.iov_len = sizeof(c),
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+	ssize_t size;
+
+	size = sendmsg(sf->sockfd, &msg, MSG_EOR | MSG_NOSIGNAL);
+	if (size < 0) {
+		perror("fuse: send service mount command");
+		return -1;
+	}
+
+	iov.iov_base = &reply;
+	iov.iov_len = sizeof(reply);
+	size = recvmsg(sf->sockfd, &msg, MSG_TRUNC);
+	if (size < 0) {
+		perror("fuse: service mount reply");
+		return -1;
+	}
+	if (size != sizeof(reply)) {
+		fprintf(stderr,
+ "fuse: wrong service mount reply size %zd, expected %zd\n",
+			size, sizeof(reply));
+		return -1;
+	}
+
+	if (ntohl(reply.p.magic) != FUSE_SERVICE_SIMPLE_REPLY) {
+		fprintf(stderr,
+ "fuse: service mount reply contains wrong magic!\n");
+		return -1;
+	}
+
+	*error = ntohl(reply.error);
+	return 0;
+}
+
+int fuse_service_mount(struct fuse_service *sf, struct fuse_session *se,
+		       const char *mountpoint)
+{
+	char *fstype = fuse_mountopts_fstype(se->mo);
+	char *source = fuse_mountopts_source(se->mo, "???");
+	char *mntopts = fuse_mountopts_kernel_opts(se->mo);
+	int ret;
+	int error;
+
+	if (!fstype || !source) {
+		fprintf(stderr, "fuse: cannot allocate service strings\n");
+		ret = -1;
+		goto out_strings;
+	}
+
+	ret = send_string(sf, FUSE_SERVICE_FSOPEN_CMD, fstype, &error);
+	if (ret)
+		goto out_strings;
+	if (error) {
+		fprintf(stderr, "fuse: service fsopen: %s\n",
+			strerror(error));
+		ret = -1;
+		goto out_strings;
+	}
+
+	ret = send_string(sf, FUSE_SERVICE_SOURCE_CMD, source, &error);
+	if (ret)
+		goto out_strings;
+	if (error) {
+		fprintf(stderr, "fuse: service fs source: %s\n",
+			strerror(error));
+		ret = -1;
+		goto out_strings;
+	}
+
+	ret = send_string(sf, FUSE_SERVICE_MNTPT_CMD, mountpoint, &error);
+	if (ret)
+		goto out_strings;
+	if (error) {
+		fprintf(stderr, "fuse: service fs mountpoint: %s\n",
+			strerror(error));
+		ret = -1;
+		goto out_strings;
+	}
+
+	if (mntopts) {
+		ret = send_string(sf, FUSE_SERVICE_MNTOPTS_CMD, mntopts,
+				  &error);
+		if (ret)
+			goto out_strings;
+		if (error) {
+			fprintf(stderr,
+ "fuse: service fs mount options: %s\n",
+				strerror(error));
+			ret = -1;
+			goto out_strings;
+		}
+	}
+
+	ret = send_mount(sf, fuse_mountopts_flags(se->mo), &error);
+	if (ret)
+		goto out_strings;
+	if (error) {
+		fprintf(stderr, "fuse: service mount: %s\n", strerror(error));
+		ret = -1;
+		goto out_strings;
+	}
+
+out_strings:
+	free(mntopts);
+	free(source);
+	free(fstype);
+	return ret;
+}
+
+void fuse_service_release(struct fuse_service *sf)
+{
+	close(sf->fusedevfd);
+	sf->fusedevfd = -1;
+	close(sf->argvfd);
+	sf->argvfd = -1;
+	shutdown(sf->sockfd, SHUT_RDWR);
+	close(sf->sockfd);
+	sf->sockfd = -1;
+}
+
+void fuse_service_destroy(struct fuse_service **sfp)
+{
+	struct fuse_service *sf = *sfp;
+
+	if (sf) {
+		fuse_service_release(*sfp);
+		free(sf);
+	}
+
+	*sfp = NULL;
+}
+
+char *fuse_service_cmdline(int argc, char *argv[], struct fuse_args *args)
+{
+	char *p, *dst;
+	size_t len = 1;
+	ssize_t ret;
+	char *argv0;
+	unsigned int i;
+
+	/* Try to preserve argv[0] */
+	if (argc > 0)
+		argv0 = argv[0];
+	else if (args->argc > 0)
+		argv0 = args->argv[0];
+	else
+		return NULL;
+
+	/* Pick up the alleged fstype from args->argv[0] */
+	if (args->argc == 0)
+		return NULL;
+
+	len += strlen(argv0) + 1;
+	len += 3; /* " -t" */
+	for (i = 0; i < args->argc; i++) {
+		len += strlen(args->argv[i]) + 1;
+	}
+
+	p = malloc(len);
+	if (!p)
+		return NULL;
+	dst = p;
+
+	/* Format: argv0 -t alleged_fstype [all other options...] */
+	ret = sprintf(dst, "%s -t", argv0);
+	dst += ret;
+	for (i = 0; i < args->argc; i++) {
+		ret = sprintf(dst, " %s", args->argv[i]);
+		dst += ret;
+	}
+
+	return p;
+}
+
+int fuse_service_parse_cmdline_opts(struct fuse_args *args,
+				    struct fuse_cmdline_opts *opts)
+{
+	return fuse_parse_cmdline_service(args, opts);
+}
diff --git a/lib/fuse_service_stub.c b/lib/fuse_service_stub.c
new file mode 100644
index 00000000000000..b65a711d5a9946
--- /dev/null
+++ b/lib/fuse_service_stub.c
@@ -0,0 +1,90 @@
+/*
+  FUSE: Filesystem in Userspace
+  Copyright (C) 2025 Oracle.
+  Author: Darrick J. Wong <djwong@kernel.org>
+
+  Stub functions for platforms where we cannot have fuse servers run as "safe"
+  systemd containers.
+
+  This program can be distributed under the terms of the GNU LGPLv2.
+  See the file LGPL2.txt
+*/
+
+/* shut up gcc */
+#pragma GCC diagnostic ignored "-Wunused-parameter"
+
+#define _GNU_SOURCE
+#include <errno.h>
+
+#include "fuse_config.h"
+#include "fuse_i.h"
+#include "fuse_service_priv.h"
+#include "fuse_service.h"
+
+int fuse_service_receive_file(struct fuse_service *sf, const char *path,
+			      int *fdp)
+{
+	errno = EOPNOTSUPP;
+	return -1;
+}
+
+int fuse_service_request_file(struct fuse_service *sf, const char *path,
+			      int flags, mode_t mode)
+{
+	errno = EOPNOTSUPP;
+	return -1;
+}
+
+int fuse_service_send_goodbye(struct fuse_service *sf, int error)
+{
+	errno = EOPNOTSUPP;
+	return -1;
+}
+
+int fuse_service_accept(struct fuse_service **sfp)
+{
+	*sfp = NULL;
+	errno = EOPNOTSUPP;
+	return -1;
+}
+
+int fuse_service_append_args(struct fuse_service *sf,
+			     struct fuse_args *existing_args)
+{
+	errno = EOPNOTSUPP;
+	return -1;
+}
+
+int fuse_service_take_fusedev(struct fuse_service *sfp)
+{
+	return -1;
+}
+
+int fuse_service_finish_file_requests(struct fuse_service *sf)
+{
+	errno = EOPNOTSUPP;
+	return -1;
+}
+
+int fuse_service_mount(struct fuse_service *sf, struct fuse_session *se,
+		       const char *mountpoint)
+{
+	errno = EOPNOTSUPP;
+	return -1;
+}
+
+void fuse_service_release(struct fuse_service *sf)
+{
+}
+
+void fuse_service_destroy(struct fuse_service **sfp)
+{
+	*sfp = NULL;
+}
+
+int fuse_service_parse_cmdline(struct fuse_args *args,
+			       struct fuse_cmdline_opts *opts)
+{
+	errno = EOPNOTSUPP;
+	return -1;
+}
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index db95fc6e7b1b41..335e18063bab00 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -240,6 +240,19 @@ FUSE_3.99 {
 		fuse_lowlevel_notify_iomap_inval;
 		fuse_fs_iomap_upsert;
 		fuse_fs_iomap_inval;
+
+		fuse_service_accept;
+		fuse_service_append_args;
+		fuse_service_destroy;
+		fuse_service_finish_file_requests;
+		fuse_service_mount;
+		fuse_service_cmdline;
+		fuse_service_parse_cmdline_opts;
+		fuse_service_receive_file;
+		fuse_service_release;
+		fuse_service_request_file;
+		fuse_service_send_goodbye;
+		fuse_service_take_fusedev;
 } FUSE_3.18;
 
 # Local Variables:
diff --git a/lib/helper.c b/lib/helper.c
index 5c13b93a473181..3b57788621d902 100644
--- a/lib/helper.c
+++ b/lib/helper.c
@@ -26,6 +26,11 @@
 #include <errno.h>
 #include <sys/param.h>
 
+#ifdef HAVE_SERVICEMOUNT
+# include <linux/types.h>
+# include "fuse_service_priv.h"
+#endif
+
 #define FUSE_HELPER_OPT(t, p) \
 	{ t, offsetof(struct fuse_cmdline_opts, p), 1 }
 
@@ -174,6 +179,29 @@ static int fuse_helper_opt_proc(void *data, const char *arg, int key,
 	}
 }
 
+#ifdef HAVE_SERVICEMOUNT
+static int fuse_helper_opt_proc_service(void *data, const char *arg, int key,
+					struct fuse_args *outargs)
+{
+	(void) outargs;
+	struct fuse_cmdline_opts *opts = data;
+
+	switch (key) {
+	case FUSE_OPT_KEY_NONOPT:
+		if (!opts->mountpoint) {
+			return fuse_opt_add_opt(&opts->mountpoint, arg);
+		} else {
+			fuse_log(FUSE_LOG_ERR, "fuse: invalid argument `%s'\n", arg);
+			return -1;
+		}
+
+	default:
+		/* Pass through unknown options */
+		return 1;
+	}
+}
+#endif
+
 /* Under FreeBSD, there is no subtype option so this
    function actually sets the fsname */
 static int add_default_subtype(const char *progname, struct fuse_args *args)
@@ -228,6 +256,31 @@ int fuse_parse_cmdline_312(struct fuse_args *args,
 	return 0;
 }
 
+#ifdef HAVE_SERVICEMOUNT
+int fuse_parse_cmdline_service(struct fuse_args *args,
+			       struct fuse_cmdline_opts *opts)
+{
+	memset(opts, 0, sizeof(struct fuse_cmdline_opts));
+
+	opts->max_idle_threads = UINT_MAX; /* new default in fuse version 3.12 */
+	opts->max_threads = 10;
+
+	if (fuse_opt_parse(args, opts, fuse_helper_opts,
+			   fuse_helper_opt_proc_service) == -1)
+		return -1;
+
+	/* *Linux*: if neither -o subtype nor -o fsname are specified,
+	   set subtype to program's basename.
+	   *FreeBSD*: if fsname is not specified, set to program's
+	   basename. */
+	if (!opts->nodefault_subtype)
+		if (add_default_subtype(args->argv[0], args) == -1)
+			return -1;
+
+	return 0;
+}
+#endif
+
 /**
  * struct fuse_cmdline_opts got extended in libfuse-3.12
  */
diff --git a/lib/meson.build b/lib/meson.build
index 8efe71abfabc9e..83993d2f0e529c 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -10,6 +10,12 @@ else
    libfuse_sources += [ 'mount_bsd.c' ]
 endif
 
+if private_cfg.get('HAVE_SERVICEMOUNT', false)
+  libfuse_sources += [ 'fuse_service.c' ]
+else
+  libfuse_sources += [ 'fuse_service_stub.c' ]
+endif
+
 deps = [ thread_dep ]
 if private_cfg.get('HAVE_ICONV')
    libfuse_sources += [ 'modules/iconv.c' ]
@@ -54,13 +60,19 @@ libfuse = library('fuse3',
                   link_args: ['-Wl,--version-script,' + meson.current_source_dir()
                               + '/fuse_versionscript' ])
 
+vars = []
+if private_cfg.get('HAVE_SERVICEMOUNT', false)
+  service_socket_dir = private_cfg.get_unquoted('FUSE_SERVICE_SOCKET_DIR', '')
+  vars += ['service_socket_dir=' + service_socket_dir]
+endif
 pkg = import('pkgconfig')
 pkg.generate(libraries: [ libfuse, '-lpthread' ],
              libraries_private: '-ldl',
              version: meson.project_version(),
              name: 'fuse3',
              description: 'Filesystem in Userspace',
-             subdirs: 'fuse3')
+             subdirs: 'fuse3',
+             variables: vars)
 
 libfuse_dep = declare_dependency(include_directories: include_dirs,
                                  link_with: libfuse, dependencies: deps)
diff --git a/lib/mount.c b/lib/mount.c
index 01d473902d50d7..a116fe35eaa5ba 100644
--- a/lib/mount.c
+++ b/lib/mount.c
@@ -562,24 +562,13 @@ static int fuse_mount_sys(const char *mnt, struct mount_opts *mo,
 	if (res == -1)
 		goto out_close;
 
-	source = malloc((mo->fsname ? strlen(mo->fsname) : 0) +
-			(mo->subtype ? strlen(mo->subtype) : 0) +
-			strlen(devname) + 32);
-
-	type = malloc((mo->subtype ? strlen(mo->subtype) : 0) + 32);
+	type = fuse_mountopts_fstype(mo);
+	source = fuse_mountopts_source(mo, devname);
 	if (!type || !source) {
 		fuse_log(FUSE_LOG_ERR, "fuse: failed to allocate memory\n");
 		goto out_close;
 	}
 
-	strcpy(type, mo->blkdev ? "fuseblk" : "fuse");
-	if (mo->subtype) {
-		strcat(type, ".");
-		strcat(type, mo->subtype);
-	}
-	strcpy(source,
-	       mo->fsname ? mo->fsname : (mo->subtype ? mo->subtype : devname));
-
 	res = mount(source, mnt, type, mo->flags, mo->kernel_opts);
 	if (res == -1 && errno == ENODEV && mo->subtype) {
 		/* Probably missing subtype support */
@@ -690,6 +679,48 @@ void destroy_mount_opts(struct mount_opts *mo)
 	free(mo);
 }
 
+char *fuse_mountopts_fstype(const struct mount_opts *mo)
+{
+	char *type = malloc((mo->subtype ? strlen(mo->subtype) : 0) + 32);
+
+	if (!type)
+		return NULL;
+
+	strcpy(type, mo->blkdev ? "fuseblk" : "fuse");
+	if (mo->subtype) {
+		strcat(type, ".");
+		strcat(type, mo->subtype);
+	}
+
+	return type;
+}
+
+char *fuse_mountopts_source(const struct mount_opts *mo, const char *devname)
+{
+	char *source = malloc((mo->fsname ? strlen(mo->fsname) : 0) +
+			(mo->subtype ? strlen(mo->subtype) : 0) +
+			strlen(devname) + 32);
+
+	if (!source)
+		return NULL;
+
+	strcpy(source,
+	       mo->fsname ? mo->fsname : (mo->subtype ? mo->subtype : devname));
+
+	return source;
+}
+
+char *fuse_mountopts_kernel_opts(const struct mount_opts *mo)
+{
+	if (mo->kernel_opts)
+		return strdup(mo->kernel_opts);
+	return NULL;
+}
+
+unsigned int fuse_mountopts_flags(const struct mount_opts *mo)
+{
+	return mo->flags;
+}
 
 int fuse_kern_mount(const char *mountpoint, struct mount_opts *mo)
 {
diff --git a/meson.build b/meson.build
index 7214d24705c7fb..9b7a0a319a91a3 100644
--- a/meson.build
+++ b/meson.build
@@ -69,6 +69,11 @@ args_default = [ '-D_GNU_SOURCE' ]
 #
 private_cfg = configuration_data()
 private_cfg.set_quoted('PACKAGE_VERSION', meson.project_version())
+service_socket_dir = get_option('service-socket-dir')
+if service_socket_dir == ''
+  service_socket_dir = '/run/filesystems'
+endif
+private_cfg.set_quoted('FUSE_SERVICE_SOCKET_DIR', service_socket_dir)
 
 # Test for presence of some functions
 test_funcs = [ 'fork', 'fstatat', 'openat', 'readlinkat', 'pipe2',
@@ -163,6 +168,37 @@ if get_option('enable-io-uring') and liburing.found() and libnuma.found()
    endif
 endif
 
+# Check for systemd support
+systemd_system_unit_dir = get_option('systemdsystemunitdir')
+if systemd_system_unit_dir == ''
+  systemd = dependency('systemd', required: false)
+  if systemd.found()
+     systemd_system_unit_dir = systemd.get_variable(pkgconfig: 'systemd_system_unit_dir')
+  endif
+endif
+
+if systemd_system_unit_dir == ''
+  warning('could not determine systemdsystemunitdir, systemd stuff will not be installed')
+else
+  private_cfg.set_quoted('SYSTEMD_SYSTEM_UNIT_DIR', systemd_system_unit_dir)
+  private_cfg.set('HAVE_SYSTEMD', true)
+endif
+
+# Check for libc SCM_RIGHTS support (aka Linux)
+code = '''
+#include <sys/socket.h>
+int main(void) {
+    int moo = SCM_RIGHTS;
+    return moo;
+}'''
+if cc.links(code, name: 'libc SCM_RIGHTS support')
+  private_cfg.set('HAVE_SCM_RIGHTS', true)
+endif
+
+if private_cfg.get('HAVE_SCM_RIGHTS', false) and private_cfg.get('HAVE_SYSTEMD', false)
+  private_cfg.set('HAVE_SERVICEMOUNT', true)
+endif
+
 #
 # Compiler configuration
 #
diff --git a/meson_options.txt b/meson_options.txt
index c1f8fe69467184..95655a0d64895c 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -27,3 +27,9 @@ option('enable-usdt', type : 'boolean', value : false,
 
 option('enable-io-uring', type: 'boolean', value: true,
        description: 'Enable fuse-over-io-uring support')
+
+option('service-socket-dir', type : 'string', value : '',
+       description: 'Where to install fuse server sockets (if empty, /run/filesystems)')
+
+option('systemdsystemunitdir', type : 'string', value : '',
+       description: 'Where to install systemd unit files (if empty, query pkg-config(1))')
diff --git a/util/fuservicemount.c b/util/fuservicemount.c
new file mode 100644
index 00000000000000..c54d5b0767f760
--- /dev/null
+++ b/util/fuservicemount.c
@@ -0,0 +1,18 @@
+/*
+  FUSE: Filesystem in Userspace
+  Copyright (C) 2025 Oracle.
+  Author: Darrick J. Wong <djwong@kernel.org>
+
+  This program can be distributed under the terms of the GNU GPLv2.
+  See the file GPL2.txt.
+*/
+/* This program does the mounting of FUSE filesystems that run in systemd */
+
+#define _GNU_SOURCE
+#include "fuse_config.h"
+#include "mount_service.h"
+
+int main(int argc, char *argv[])
+{
+	return mount_service_main(argc, argv);
+}
diff --git a/util/meson.build b/util/meson.build
index 0e4b1cce95377e..68d8bb11f92955 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -6,6 +6,15 @@ executable('fusermount3', ['fusermount.c', '../lib/mount_util.c', '../lib/util.c
            install_dir: get_option('bindir'),
            c_args: '-DFUSE_CONF="@0@"'.format(fuseconf_path))
 
+if private_cfg.get('HAVE_SERVICEMOUNT', false)
+  executable('fuservicemount3', ['mount_service.c', 'fuservicemount.c'],
+             include_directories: include_dirs,
+             link_with: [ libfuse ],
+             install: true,
+             install_dir: get_option('sbindir'),
+             c_args: '-DFUSE_USE_VERSION=317')
+endif
+
 executable('mount.fuse3', ['mount.fuse.c'],
            include_directories: include_dirs,
            link_with: [ libfuse ],
diff --git a/util/mount_service.c b/util/mount_service.c
new file mode 100644
index 00000000000000..46d368d0cba922
--- /dev/null
+++ b/util/mount_service.c
@@ -0,0 +1,962 @@
+/*
+  FUSE: Filesystem in Userspace
+  Copyright (C) 2025 Oracle.
+  Author: Darrick J. Wong <djwong@kernel.org>
+
+  This program can be distributed under the terms of the GNU GPLv2.
+  See the file GPL2.txt.
+*/
+/* This program does the mounting of FUSE filesystems that run in systemd */
+
+#define _GNU_SOURCE
+#include <stdint.h>
+#include <sys/mman.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/mount.h>
+#include <stdbool.h>
+#include <limits.h>
+#include <sys/stat.h>
+#include <arpa/inet.h>
+
+#include "fuse_config.h"
+#include "mount_util.h"
+#include "util.h"
+#include "fuse_i.h"
+#include "fuse_service_priv.h"
+#include "mount_service.h"
+
+#define FUSE_KERN_DEVICE_ENV	"FUSE_KERN_DEVICE"
+#define FUSE_DEV		"/dev/fuse"
+
+struct mount_service {
+	/* alleged fuse subtype based on -t cli argument */
+	const char *subtype;
+
+	/* full fuse filesystem type we give to mount() */
+	char *fstype;
+
+	/* source argument to mount() */
+	char *source;
+
+	/* target argument (aka mountpoint) to mount() */
+	char *mountpoint;
+
+	/* mount options */
+	char *mntopts;
+
+	/* socket fd */
+	int sockfd;
+
+	/* /dev/fuse device */
+	int fusedevfd;
+
+	/* memfd for cli arguments */
+	int argvfd;
+
+	/* fd for fsopen */
+	int fsopenfd;
+};
+
+/* Filter out the subtype of the filesystem (e.g. fuse.Y -> Y) */
+const char *mount_service_subtype(const char *fstype)
+{
+	char *period = strrchr(fstype, '.');
+	if (period)
+		return period + 1;
+
+	return fstype;
+}
+
+static int mount_service_init(struct mount_service *mo, int argc,
+			      char *argv[])
+{
+	char *fstype = NULL;
+	int i;
+
+	mo->sockfd = -1;
+	mo->fsopenfd = -1;
+
+	for (i = 0; i < argc; i++) {
+		if (!strcmp(argv[i], "-t") && i + 1 < argc) {
+			fstype = argv[i + 1];
+			break;
+		}
+	}
+	if (!fstype)
+		return -1;
+
+	mo->subtype = mount_service_subtype(fstype);
+	return 0;
+}
+
+static int mount_service_connect(struct mount_service *mo)
+{
+	struct sockaddr_un name = {
+		.sun_family = AF_UNIX,
+	};
+	int sockfd;
+	ssize_t written;
+	int ret;
+
+	written = snprintf(name.sun_path, sizeof(name.sun_path),
+			FUSE_SERVICE_SOCKET_DIR "/%s", mo->subtype);
+	if (written > sizeof(name.sun_path)) {
+		fprintf(stderr,
+ "mount.service: filesystem type name (\"%s\") is too long.\n",
+			mo->subtype);
+		return -1;
+	}
+
+	sockfd = socket(AF_UNIX, SOCK_SEQPACKET, 0);
+	if (sockfd < 0) {
+		fprintf(stderr,
+ "mount.service: opening %s service socket: %s\n", mo->subtype,
+			strerror(errno));
+		return -1;
+	}
+
+	ret = connect(sockfd, (const struct sockaddr *)&name, sizeof(name));
+	if (ret) {
+		if (errno == ENOENT)
+			fprintf(stderr,
+ "mount.service: no safe filesystem driver for %s available.\n",
+				mo->subtype);
+		else
+			perror(name.sun_path);
+		goto out;
+	}
+
+#ifdef SO_PASSRIGHTS
+	{
+		int zero = 0;
+
+		/* don't let a malicious fuse server send us more fds */
+		setsockopt(sockfd, SOL_SOCKET, SO_PASSRIGHTS, &zero,
+			   sizeof(zero));
+	}
+#endif
+
+	mo->sockfd = sockfd;
+	return 0;
+out:
+	close(sockfd);
+	return -1;
+}
+
+static int mount_service_send_hello(struct mount_service *mo)
+{
+	struct fuse_service_packet p = {
+		.magic = htonl(FUSE_SERVICE_HELLO_CMD),
+	};
+	struct iovec iov = {
+		.iov_base = &p,
+		.iov_len = sizeof(p),
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+	ssize_t size;
+
+	size = sendmsg(mo->sockfd, &msg, MSG_EOR | MSG_NOSIGNAL);
+	if (size < 0) {
+		perror("mount.service: send hello");
+		return -1;
+	}
+
+	size = recvmsg(mo->sockfd, &msg, MSG_TRUNC);
+	if (size < 0) {
+		perror("mount.service: hello reply");
+		return -1;
+	}
+	if (size != sizeof(p)) {
+		fprintf(stderr,
+ "mount.service: wrong hello reply size %zd, expected %zd\n",
+			size, sizeof(p));
+		return -1;
+	}
+
+	if (p.magic != ntohl(FUSE_SERVICE_HELLO_REPLY)) {
+		fprintf(stderr,
+ "mount.service: %s service server did not reply to hello\n",
+			mo->subtype);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int mount_service_capture_arg(struct mount_service *mo,
+				     struct fuse_service_memfd_argv *args,
+				     const char *string, off_t *array_pos,
+				     off_t *string_pos)
+{
+	const size_t string_len = strlen(string) + 1;
+	struct fuse_service_memfd_arg arg = {
+		.pos = htonl(*string_pos),
+		.len = htonl(string_len),
+	};
+	ssize_t written;
+
+	written = pwrite(mo->argvfd, string, string_len, *string_pos);
+	if (written < 0) {
+		perror("mount.service: memfd argv write");
+		return -1;
+	}
+	if (written < string_len) {
+		fprintf(stderr, "mount.service: memfd argv[%u] write %zd\n",
+			args->argc, written);
+		return -1;
+	}
+
+	written = pwrite(mo->argvfd, &arg, sizeof(arg), *array_pos);
+	if (written < 0) {
+		perror("mount.service: memfd arg write");
+		return -1;
+	}
+	if (written < sizeof(arg)) {
+		fprintf(stderr, "mount.service: memfd arg[%u] write %zd\n",
+			args->argc, written);
+		return -1;
+	}
+
+	args->argc++;
+	*string_pos += string_len;
+	*array_pos += sizeof(arg);
+
+	return 0;
+}
+
+static int mount_service_capture_args(struct mount_service *mo, int argc,
+				      char *argv[])
+{
+	struct fuse_service_memfd_argv args = {
+		.magic = htonl(FUSE_SERVICE_ARGS_MAGIC),
+	};
+	off_t array_pos = sizeof(struct fuse_service_memfd_argv);
+	off_t string_pos = array_pos +
+			(argc * sizeof(struct fuse_service_memfd_arg));
+	ssize_t written;
+	int i;
+	int ret;
+
+	if (argc < 0) {
+		fprintf(stderr, "mount.service: argc cannot be negative\n");
+		return -1;
+	}
+
+	/*
+	 * Create the memfd in which we'll stash arguments, and set the write
+	 * pointer for the names.
+	 */
+	mo->argvfd = memfd_create("mount.service args", MFD_CLOEXEC);
+	if (mo->argvfd < 0) {
+		perror("mount.service: argvfd create");
+		return -1;
+	}
+
+	/*
+	 * Write the alleged subtype as if it were argv[0], then write the rest
+	 * of the argv arguments.
+	 */
+	ret = mount_service_capture_arg(mo, &args, mo->subtype, &array_pos,
+					&string_pos);
+	if (ret)
+		return ret;
+
+	for (i = 1; i < argc; i++) {
+		/* skip the -t(ype) argument */
+		if (!strcmp(argv[i], "-t")) {
+			i++;
+			continue;
+		}
+
+		ret = mount_service_capture_arg(mo, &args, argv[i],
+						&array_pos, &string_pos);
+		if (ret)
+			return ret;
+	}
+
+	/* Now write the header */
+	args.argc = htonl(args.argc);
+	written = pwrite(mo->argvfd, &args, sizeof(args), 0);
+	if (written < 0) {
+		perror("mount.service: memfd argv write");
+		return -1;
+	}
+	if (written < sizeof(args)) {
+		fprintf(stderr, "mount.service: memfd argv wrote %zd\n",
+			written);
+		return -1;
+	}
+
+	return 0;
+}
+
+static ssize_t __send_fd(int sockfd, struct fuse_service_requested_file *req,
+			 size_t req_sz, int fd)
+{
+	union {
+		struct cmsghdr cmsghdr;
+		char control[CMSG_SPACE(sizeof(int))];
+	} cmsgu;
+	struct iovec iov = {
+		.iov_base = req,
+		.iov_len = req_sz,
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = cmsgu.control,
+		.msg_controllen = sizeof(cmsgu.control),
+	};
+	struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
+
+	memset(&cmsgu, 0, sizeof(cmsgu));
+	cmsg->cmsg_len = CMSG_LEN(sizeof (int));
+	cmsg->cmsg_level = SOL_SOCKET;
+	cmsg->cmsg_type = SCM_RIGHTS;
+
+	*((int *)CMSG_DATA(cmsg)) = fd;
+
+	return sendmsg(sockfd, &msg, MSG_EOR | MSG_NOSIGNAL);
+}
+
+static int mount_service_send_file(struct mount_service *mo,
+				   const char *path, int fd)
+{
+	struct fuse_service_requested_file *req;
+	const size_t req_sz =
+			sizeof_fuse_service_requested_file(strlen(path));
+	ssize_t written;
+	int ret = 0;
+
+	req = malloc(req_sz);
+	if (!req) {
+		perror("mount.service: alloc send file reply");
+		return -1;
+	}
+	req->p.magic = htonl(FUSE_SERVICE_OPEN_REPLY);
+	req->error = 0;
+	strcpy(req->path, path);
+
+	written = __send_fd(mo->sockfd, req, req_sz, fd);
+	if (written < 0) {
+		perror("mount.service: send file reply");
+		ret = -1;
+	}
+
+	free(req);
+	return ret;
+}
+
+static ssize_t __send_packet(int sockfd, void *buf, ssize_t buflen)
+{
+	struct iovec iov = {
+		.iov_base = buf,
+		.iov_len = buflen,
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+
+	return sendmsg(sockfd, &msg, MSG_EOR | MSG_NOSIGNAL);
+}
+
+static int mount_service_send_file_error(struct mount_service *mo, int error,
+					 const char *path)
+{
+	struct fuse_service_requested_file *req;
+	const size_t req_sz =
+			sizeof_fuse_service_requested_file(strlen(path));
+	ssize_t written;
+	int ret = 0;
+
+	req = malloc(req_sz);
+	if (!req) {
+		perror("mount.service: alloc send file error");
+		return -1;
+	}
+	req->p.magic = htonl(FUSE_SERVICE_OPEN_REPLY);
+	req->error = htonl(error);
+	strcpy(req->path, path);
+
+	written = __send_packet(mo->sockfd, req, req_sz);
+	if (written < 0) {
+		perror("mount.service: send file error");
+		ret = -1;
+	}
+
+	free(req);
+	return ret;
+}
+
+static int mount_service_send_required_files(struct mount_service *mo,
+					     const char *fusedev)
+{
+	int ret;
+
+	mo->fusedevfd = open(fusedev, O_RDWR | O_CLOEXEC);
+	if (mo->fusedevfd < 0) {
+		perror(fusedev);
+		return -1;
+	}
+
+	ret = mount_service_send_file(mo, FUSE_SERVICE_ARGV, mo->argvfd);
+	close(mo->argvfd);
+	mo->argvfd = -1;
+	if (ret)
+		return ret;
+
+	return mount_service_send_file(mo, FUSE_SERVICE_FUSEDEV,
+				       mo->fusedevfd);
+}
+
+static int
+mount_service_receive_command(struct mount_service *mo,
+			      struct fuse_service_packet **commandp)
+{
+	struct iovec iov = {
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+	struct fuse_service_packet *command;
+	ssize_t size;
+
+	size = recvmsg(mo->sockfd, &msg, MSG_PEEK | MSG_TRUNC);
+	if (size < 0) {
+		perror("mount.service: peek service command");
+		return -1;
+	}
+	if (size == 0) {
+		/* fuse server probably exited early */
+		return -1;
+	}
+	if (size < sizeof(struct fuse_service_packet)) {
+		fprintf(stderr,
+ "mount.service: wrong command packet size %zd, expected at least %zd\n",
+			size, sizeof(struct fuse_service_packet));
+		return -1;
+	}
+
+	command = calloc(1, size + 1);
+	if (!command) {
+		perror("mount.service: alloc service command");
+		return -1;
+	}
+	iov.iov_base = command;
+	iov.iov_len = size;
+
+	size = recvmsg(mo->sockfd, &msg, MSG_TRUNC);
+	if (size < 0) {
+		perror("mount.service: receive service command");
+		return -1;
+	}
+	if (size != iov.iov_len) {
+		fprintf(stderr,
+ "mount.service: wrong service command size %zd, expected %zd\n",
+			size, iov.iov_len);
+		return -1;
+	}
+
+	*commandp = command;
+	return 0;
+}
+
+static int mount_service_send_reply(struct mount_service *mo, int error)
+{
+	struct fuse_service_simple_reply reply = {
+		.p.magic = htonl(FUSE_SERVICE_SIMPLE_REPLY),
+		.error = htonl(error),
+	};
+	struct iovec iov = {
+		.iov_base = &reply,
+		.iov_len = sizeof(reply),
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+	ssize_t size;
+
+	size = sendmsg(mo->sockfd, &msg, MSG_EOR | MSG_NOSIGNAL);
+	if (size < 0) {
+		perror("mount.service: send service reply");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int mount_service_handle_open_cmd(struct mount_service *mo,
+					 struct fuse_service_packet *p)
+{
+	struct fuse_service_open_command *oc =
+			container_of(p, struct fuse_service_open_command, p);
+	int ret;
+	int fd;
+
+	fd = open(oc->path, ntohl(oc->flags), ntohl(oc->mode));
+	if (fd >= 0) {
+		ret = mount_service_send_file(mo, oc->path, fd);
+	} else {
+		int error = errno;
+
+		perror(oc->path);
+		ret = mount_service_send_file_error(mo, error, oc->path);
+	}
+	close(fd);
+
+	return ret;
+}
+
+static int
+mount_service_handle_fsopen_cmd(struct mount_service *mo,
+				const struct fuse_service_packet *p)
+{
+	struct fuse_service_string_command *oc =
+			container_of(p, struct fuse_service_string_command, p);
+
+	mo->fsopenfd = -1;
+#if 0
+	mo->fsopenfd = fsopen(oc->value, FSOPEN_CLOEXEC);
+#endif
+	if (mo->fsopenfd >= 0)
+		return mount_service_send_reply(mo, 0);
+
+	if (mo->fstype) {
+		fprintf(stderr, "mount.service: fstype respecified!\n");
+		mount_service_send_reply(mo, EINVAL);
+		return -1;
+	}
+
+	mo->fstype = strdup(oc->value);
+	if (!mo->fstype) {
+		perror("mount.service: alloc fstype string");
+		mount_service_send_reply(mo, errno);
+		return -1;
+	}
+
+	return mount_service_send_reply(mo, 0);
+}
+
+static int
+mount_service_handle_source_cmd(struct mount_service *mo,
+				const struct fuse_service_packet *p)
+{
+	struct fuse_service_string_command *oc =
+			container_of(p, struct fuse_service_string_command, p);
+	int ret;
+
+	if (mo->fsopenfd < 0) {
+		if (mo->source) {
+			fprintf(stderr, "mount.service: source respecified!\n");
+			mount_service_send_reply(mo, EINVAL);
+			return -1;
+		}
+
+		mo->source = strdup(oc->value);
+		if (!mo->source) {
+			perror("mount.service: alloc source string");
+			mount_service_send_reply(mo, errno);
+			return -1;
+		}
+
+		return mount_service_send_reply(mo, 0);
+	}
+
+	ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_STRING, "source", oc->value,
+		       0);
+	if (ret) {
+		perror("mount.service: fsconfig source");
+		mount_service_send_reply(mo, errno);
+		return -1;
+	}
+
+	return mount_service_send_reply(mo, 0);
+}
+
+static int
+mount_service_handle_mntopts_cmd(struct mount_service *mo,
+				 const struct fuse_service_packet *p)
+{
+	struct fuse_service_string_command *oc =
+			container_of(p, struct fuse_service_string_command, p);
+	char *tokstr = oc->value;
+	char *tok, *savetok;
+	int ret;
+
+	if (mo->fsopenfd < 0) {
+		if (mo->mntopts) {
+			fprintf(stderr,
+ "mount.service: mount options respecified!\n");
+			mount_service_send_reply(mo, EINVAL);
+			return -1;
+		}
+
+		mo->mntopts = strdup(oc->value);
+		if (!mo->mntopts) {
+			perror("mount.service: alloc mount options string");
+			mount_service_send_reply(mo, errno);
+			return -1;
+		}
+
+		return mount_service_send_reply(mo, 0);
+	}
+
+	while ((tok = strtok_r(tokstr, ",", &savetok)) != NULL) {
+		char *equals = strchr(tok, '=');
+
+		if (equals) {
+			char oldchar = *equals;
+
+			*equals = 0;
+			ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_STRING, tok,
+				       equals + 1, 0);
+			*equals = oldchar;
+		} else {
+			ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_FLAG, tok,
+				       NULL, 0);
+		}
+		if (ret) {
+			perror("mount.service: set mount option");
+			mount_service_send_reply(mo, errno);
+			return -1;
+		}
+
+		tokstr = NULL;
+	}
+
+	return mount_service_send_reply(mo, 0);
+}
+
+static int
+mount_service_handle_mountpoint_cmd(struct mount_service *mo,
+				    const struct fuse_service_packet *p)
+{
+	struct fuse_service_string_command *oc =
+			container_of(p, struct fuse_service_string_command, p);
+
+	if (mo->mountpoint) {
+		fprintf(stderr, "mount.service: mount point respecified!\n");
+		mount_service_send_reply(mo, EINVAL);
+		return -1;
+	}
+
+	mo->mountpoint = strdup(oc->value);
+	if (!mo->mountpoint) {
+		perror("mount.service: alloc mount point string");
+		mount_service_send_reply(mo, errno);
+		return -1;
+	}
+
+	return mount_service_send_reply(mo, 0);
+}
+
+static inline int format_libfuse_mntopts(char *buf, size_t bufsz,
+					 const struct mount_service *mo,
+					 const struct stat *statbuf)
+{
+	if (mo->mntopts)
+		return snprintf(buf, bufsz,
+				"%s,fd=%i,rootmode=%o,user_id=%u,group_id=%u",
+				mo->mntopts, mo->fusedevfd,
+				statbuf->st_mode & S_IFMT,
+				getuid(), getgid());
+
+	return snprintf(buf, bufsz,
+			"fd=%i,rootmode=%o,user_id=%u,group_id=%u",
+			mo->fusedevfd, statbuf->st_mode & S_IFMT,
+			getuid(), getgid());
+}
+
+static int mount_service_regular_mount(struct mount_service *mo,
+				       struct fuse_service_mount_command *oc,
+				       struct stat *stbuf)
+{
+	char *realmopts;
+	int ret;
+
+	if (!mo->fstype) {
+		fprintf(stderr, "mount.service: missing mount type parameter\n");
+		mount_service_send_reply(mo, EINVAL);
+		return -1;
+	}
+
+	if (!mo->source) {
+		fprintf(stderr, "mount.service: missing mount source parameter\n");
+		mount_service_send_reply(mo, EINVAL);
+		return -1;
+	}
+
+	ret = format_libfuse_mntopts(NULL, 0, mo, stbuf);
+	if (ret < 0) {
+		perror("mount.service: mount option preformatting");
+		mount_service_send_reply(mo, errno);
+		return -1;
+	}
+
+	realmopts = malloc(ret + 1);
+	if (!realmopts) {
+		perror("mount.service: alloc real mount options string");
+		mount_service_send_reply(mo, errno);
+		return -1;
+	}
+
+	ret = format_libfuse_mntopts(realmopts, ret + 1, mo, stbuf);
+	if (ret < 0) {
+		free(realmopts);
+		perror("mount.service: mount options formatting");
+		mount_service_send_reply(mo, errno);
+		return -1;
+	}
+
+	ret = mount(mo->source, mo->mountpoint, mo->fstype, ntohl(oc->flags),
+		    realmopts);
+	free(realmopts);
+	if (ret) {
+		perror("mount.service");
+		mount_service_send_reply(mo, errno);
+		return -1;
+	}
+
+	return mount_service_send_reply(mo, 0);
+}
+
+static int mount_service_fsopen_mount(struct mount_service *mo,
+				      struct fuse_service_mount_command *oc,
+				      struct stat *stbuf)
+{
+	char tmp[64];
+	int mfd;
+	int ret;
+
+	snprintf(tmp, sizeof(tmp), "%i", mo->fusedevfd);
+	ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_STRING, "fd", tmp, 0);
+	if (ret) {
+		perror("mount.service: set fd option");
+		mount_service_send_reply(mo, errno);
+		return -1;
+	}
+
+	snprintf(tmp, sizeof(tmp), "%o", stbuf->st_mode & S_IFMT);
+	ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_STRING, "rootmode", tmp, 0);
+	if (ret) {
+		perror("mount.service: set rootmode option");
+		mount_service_send_reply(mo, errno);
+		return -1;
+	}
+
+	snprintf(tmp, sizeof(tmp), "%u", getuid());
+	ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_STRING, "user_id", tmp, 0);
+	if (ret) {
+		perror("mount.service: set user_id option");
+		mount_service_send_reply(mo, errno);
+		return -1;
+	}
+
+	snprintf(tmp, sizeof(tmp), "%u", getgid());
+	ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_STRING, "group_id", tmp, 0);
+	if (ret) {
+		perror("mount.service: set group_id option");
+		mount_service_send_reply(mo, errno);
+		return -1;
+	}
+
+	mfd = fsmount(mo->fsopenfd, FSMOUNT_CLOEXEC, ntohl(oc->flags));
+	if (mfd < 0) {
+		perror("mount.service");
+		mount_service_send_reply(mo, errno);
+		return -1;
+	}
+
+	ret = move_mount(mfd, "", AT_FDCWD, mo->mountpoint,
+			 MOVE_MOUNT_F_EMPTY_PATH);
+	close(mfd);
+	if (ret) {
+		perror("mount.service: move_mount");
+		mount_service_send_reply(mo, errno);
+		return -1;
+	}
+
+	return mount_service_send_reply(mo, 0);
+}
+
+static int mount_service_handle_mount_cmd(struct mount_service *mo,
+					  struct fuse_service_packet *p)
+{
+	struct stat stbuf;
+	char mountpoint[PATH_MAX] = "";
+	struct fuse_service_mount_command *oc =
+			container_of(p, struct fuse_service_mount_command, p);
+	int ret;
+
+	if (!mo->mountpoint) {
+		fprintf(stderr, "mount.service: missing mount point parameter\n");
+		mount_service_send_reply(mo, EINVAL);
+		return -1;
+	}
+
+	if (realpath(mo->mountpoint, mountpoint) == NULL) {
+		int error = errno;
+
+		fprintf(stderr, "mount.service: bad mount point `%s': %s\n",
+			mo->mountpoint, strerror(error));
+		mount_service_send_reply(mo, error);
+		return -1;
+	}
+
+	ret = stat(mo->mountpoint, &stbuf);
+	if (ret == -1) {
+		perror(mo->mountpoint);
+		mount_service_send_reply(mo, errno);
+		return -1;
+	}
+
+	if (mo->fsopenfd >= 0)
+		return mount_service_fsopen_mount(mo, oc, &stbuf);
+	return mount_service_regular_mount(mo, oc, &stbuf);
+}
+
+static int mount_service_handle_bye_cmd(struct fuse_service_packet *p)
+{
+	int error;
+
+	struct fuse_service_bye_command *bc =
+			container_of(p, struct fuse_service_bye_command, p);
+
+	error = ntohl(bc->error);
+	if (error) {
+		fprintf(stderr, "mount.service: initialization failed: %s\n",
+			strerror(error));
+		return -1;
+	}
+
+	return 0;
+}
+
+static void mount_service_destroy(struct mount_service *mo)
+{
+	close(mo->fusedevfd);
+	close(mo->argvfd);
+	close(mo->fsopenfd);
+	shutdown(mo->sockfd, SHUT_RDWR);
+	close(mo->sockfd);
+
+	free(mo->source);
+	free(mo->mountpoint);
+	free(mo->mntopts);
+	free(mo->fstype);
+
+	memset(mo, 0, sizeof(*mo));
+	mo->fsopenfd = -1;
+	mo->sockfd = -1;
+	mo->argvfd = -1;
+	mo->fusedevfd = -1;
+}
+
+int mount_service_main(int argc, char *argv[])
+{
+	const char *fusedev = getenv(FUSE_KERN_DEVICE_ENV) ?: FUSE_DEV;
+	struct mount_service mo = { };
+	bool running = true;
+	int ret;
+
+	if (argc < 3 || !strcmp(argv[1], "--help")) {
+		printf("Usage: %s source mountpoint -t type [-o options]\n",
+				argv[0]);
+		return EXIT_FAILURE;
+	}
+
+	ret = mount_service_init(&mo, argc, argv);
+	if (ret) {
+		fprintf(stderr, "%s: cannot determine filesystem type.\n",
+			argv[0]);
+		return EXIT_FAILURE;
+	}
+
+	ret = mount_service_connect(&mo);
+	if (ret) {
+		ret = EXIT_FAILURE;
+		goto out;
+	}
+
+	ret = mount_service_send_hello(&mo);
+	if (ret) {
+		ret = EXIT_FAILURE;
+		goto out;
+	}
+
+	ret = mount_service_capture_args(&mo, argc, argv);
+	if (ret) {
+		ret = EXIT_FAILURE;
+		goto out;
+	}
+
+	ret = mount_service_send_required_files(&mo, fusedev);
+	if (ret) {
+		ret = EXIT_FAILURE;
+		goto out;
+	}
+
+	while (running) {
+		struct fuse_service_packet *p = NULL;
+
+		ret = mount_service_receive_command(&mo, &p);
+		if (ret) {
+			ret = EXIT_FAILURE;
+			goto out;
+		}
+
+		switch (ntohl(p->magic)) {
+		case FUSE_SERVICE_OPEN_CMD:
+			ret = mount_service_handle_open_cmd(&mo, p);
+			break;
+		case FUSE_SERVICE_FSOPEN_CMD:
+			ret = mount_service_handle_fsopen_cmd(&mo, p);
+			break;
+		case FUSE_SERVICE_SOURCE_CMD:
+			ret = mount_service_handle_source_cmd(&mo, p);
+			break;
+		case FUSE_SERVICE_MNTOPTS_CMD:
+			ret = mount_service_handle_mntopts_cmd(&mo, p);
+			break;
+		case FUSE_SERVICE_MNTPT_CMD:
+			ret = mount_service_handle_mountpoint_cmd(&mo, p);
+			break;
+		case FUSE_SERVICE_MOUNT_CMD:
+			ret = mount_service_handle_mount_cmd(&mo, p);
+			break;
+		case FUSE_SERVICE_BYE_CMD:
+			ret = mount_service_handle_bye_cmd(p);
+			running = false;
+			break;
+		default:
+			fprintf(stderr, "unrecognized packet 0x%x\n",
+				ntohl(p->magic));
+			ret = EXIT_FAILURE;
+			break;
+		}
+		free(p);
+
+		if (ret) {
+			ret = EXIT_FAILURE;
+			goto out;
+		}
+	}
+
+	ret = EXIT_SUCCESS;
+out:
+	mount_service_destroy(&mo);
+	return ret;
+}


