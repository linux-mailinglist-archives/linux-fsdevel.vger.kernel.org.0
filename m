Return-Path: <linux-fsdevel+bounces-75335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KE9/NiYVdGk32AAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 01:41:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1BB7BC07
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 01:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56AEC30484FC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 00:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EE31E7C03;
	Sat, 24 Jan 2026 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="O/rAv7sy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F3A1B983F;
	Sat, 24 Jan 2026 00:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769215224; cv=none; b=C0b8JHbaNyn9GVFl+QeqN0uDvhVAXFyICK7IYRJXFaS7IqBuK/qLQFU4mbguU3z+cQaUYHDa7zk400L05vvjxVuxVXB8+l+2QoC3ADmYODah92IwiIRaGxnRKeA6aoqeGpMSH5aZsl08wSAnQkyVs+D83a8kOBO7VX6xMlbMfQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769215224; c=relaxed/simple;
	bh=qB+IOSkyKBdATauosJ5Yg0X7FjCJjLgE0oiXuqsG6lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3tLG3r7xRS4/RYfFK8ko5UIxHsyZtkL4eyY4Z6cPlDmovoV/hwsuvQfWFQlFh1scm7KQ3Z/RoCKBpRrvRQmDwddlWNbHQiJZOyA4wNydbJsvncRV2B0mCbnw0BUlgXHmkUjKTAZkBXeVtvU6ogn94k6oGFvnvWuaKFe2JTcw50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=O/rAv7sy; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from mail.zytor.com (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 60O0dnvX1194278
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 23 Jan 2026 16:39:59 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 60O0dnvX1194278
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025122301; t=1769215200;
	bh=qgqCVVYC4g8IPodTRYXQvgyAgGlYYA2s0aoJDPH/JY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O/rAv7sy3ru6J+JaF1sIVvws6airJxj4RycIDOdMTaZm1o1CrAV+azzYRmcnf583A
	 fE6C7+MwwqMKhbHRAq3qcjVWWa/ivc3XrJNH9fWW8q07EzFjG3fW/kkMGiSXjKMbnx
	 2P43FVDwKUImNjB7ZI//maLsdnyfH4ghcsDcV1yslNO9GyWKhnMbwNF9jW8ca0KQkD
	 ozFJOX4KeS8Lc+DCwsCGQKZg1kckbmzGefKP6vB1jR5QmrhqsiDR88ieKhRi4kBIRd
	 hajCas16yk7deyUIk7JEQRfJOlZZpVsvt+JSABgYrSylfP1kHH8kJcMIJ+TXOMXPI9
	 9JFgM1LoaASWQ==
From: "H. Peter Anvin" <hpa@zytor.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        systemd-devel@lists.freedesktop.org
Subject: [RFC PATCH 2/3] initramfs: support mounting filesystems during initramfs expansion
Date: Fri, 23 Jan 2026 16:39:35 -0800
Message-ID: <20260124003939.426931-3-hpa@zytor.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124003939.426931-1-hpa@zytor.com>
References: <20260124003939.426931-1-hpa@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2025122301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75335-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[zytor.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zytor.com:email,zytor.com:dkim,zytor.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C1BB7BC07
X-Rspamd-Action: no action

Expanding the initramfs contents directly into the rootfs is not
always desirable. Allow the initramfs to contain instructions to mount
additional filesystems before continuing processing.

This is done by a magic filename !!!MOUNT!!! which, instead of being
expanded as a file, is processed as a simplified fstab(5) mount
specification (see following documentation patch.)

Some reasons this may be desirable:

1. The early init code may wish to expand into a separate tmpfs so it
   can be pivoted, remounted, or efficiently garbage collected on
   umount.
2. The early init code may which to pass some content, but not all, to
   the main userspace. This allows mounting a second tmpfs that can
   then be mounted underneath somewhere the main root without having
   to copy the contents.
3. The main userspace can retain the rootfs as the only root. In that
   case, the initramfs contents can be expanded into a tmpfs that is
   mounted at a different path. One use case for that might be
   /lib/modules.
4. It may be convenient for the early init code to have /dev, /proc
   and /sys pre-mounted.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 init/initramfs.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 95 insertions(+), 3 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 6ddbfb17fb8f..681ab59ab6cd 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -222,6 +222,7 @@ static __initdata enum state {
 	GotName,
 	CopyFile,
 	GotSymlink,
+	GotMountpoint,
 	Reset
 } state, next_state;
 
@@ -254,6 +255,9 @@ static void __init read_into(char *buf, unsigned size, enum state next)
 	}
 }
 
+#define SYMLINK_BUF_SIZE	(PATH_MAX + N_ALIGN(PATH_MAX) + 1)
+#define NAME_BUF_SIZE		N_ALIGN(PATH_MAX)
+
 static __initdata char *header_buf, *symlink_buf, *name_buf;
 
 static int __init do_start(void)
@@ -355,6 +359,37 @@ static int __init maybe_link(void)
 	return 0;
 }
 
+static int __init maybe_mountpoint(void)
+{
+	static const char mount_magic_name[] __initconst = "!!!MOUNT!!!";
+	const unsigned long mount_magic_len = sizeof(mount_magic_name)-1;
+	unsigned long len = name_len-1;
+	const char *name = collected;
+
+	if (!S_ISREG(mode))
+		return 0;
+	if (len < mount_magic_len)
+		return 0;
+	if (len > mount_magic_len && name[len-mount_magic_len] != '/')
+		return 0;
+	if (memcmp(name+len-mount_magic_len, mount_magic_name, mount_magic_len))
+		return 0;
+
+	/* Factor out the parent directory name and save it in name_buf */
+	len -= mount_magic_len;
+	if (!len)
+		name_buf[len++] = '.';
+	else
+		memmove(name_buf, name, len);
+	name_buf[len] = '\0';
+
+	if (body_len >= SYMLINK_BUF_SIZE)
+		return 1;	/* Option file too large */
+
+	read_into(symlink_buf, body_len, GotMountpoint);
+	return 1;
+}
+
 static __initdata struct file *wfile;
 static __initdata loff_t wfile_pos;
 
@@ -375,6 +410,10 @@ static int __init do_name(void)
 		free_hash();
 		return 0;
 	}
+
+	if (maybe_mountpoint())
+		return 0;
+
 	clean_path(collected, mode);
 	if (S_ISREG(mode)) {
 		int ml = maybe_link();
@@ -392,6 +431,7 @@ static int __init do_name(void)
 			vfs_fchmod(wfile, mode);
 			if (body_len)
 				vfs_truncate(&wfile->f_path, body_len);
+
 			state = CopyFile;
 		}
 	} else if (S_ISDIR(mode)) {
@@ -451,6 +491,56 @@ static int __init do_symlink(void)
 	return 0;
 }
 
+static int __init do_mountpoint(void)
+{
+	int ret;
+	char *p, *ep;
+	const char *opts[3];
+	const char *opstart;
+	unsigned long n;
+
+	state = SkipIt;
+	next_state = Reset;
+
+	memset(opts, 0, sizeof(opts));
+
+	/* Default filesystem type */
+	opts[0] = IS_ENABLED(CONFIG_TMPFS) ? "tmpfs" : "ramfs";
+
+	p = collected;
+	ep = p + body_len;
+	n = 0;
+	opstart = NULL;
+	while (p < ep && n < 3) {
+		char c = *p;
+		if (c <= ' ') {
+			if (opstart) {
+				*p = '\0';
+				opts[n++] = opstart;
+				opstart = NULL;
+			}
+		} else {
+			if (!opstart)
+				opstart = p;
+		}
+		p++;
+	}
+
+	if (!opts[1])
+		opts[1] = opts[0];
+
+	ret = init_mount(opts[0], name_buf, opts[1], 0, opts[2]);
+	if (!ret) {
+		init_chown(name_buf, uid, gid, 0);
+		init_chmod(name_buf, mode); /* S_IFMT is ignored by chmod() */
+		dir_add(name_buf, name_len, mtime);
+	} else {
+		pr_err("initramfs mount %s %s %s failed, error %d\n",
+		       opts[0], name_buf, opts[1], ret);
+	}
+	return 0;
+}
+
 static __initdata int (*actions[])(void) = {
 	[Start]		= do_start,
 	[Collect]	= do_collect,
@@ -459,6 +549,7 @@ static __initdata int (*actions[])(void) = {
 	[GotName]	= do_name,
 	[CopyFile]	= do_copy,
 	[GotSymlink]	= do_symlink,
+	[GotMountpoint] = do_mountpoint,
 	[Reset]		= do_reset,
 };
 
@@ -515,8 +606,8 @@ char * __init unpack_to_rootfs(char *buf, unsigned long len)
 	const char *compress_name;
 	struct {
 		char header[CPIO_HDRLEN];
-		char symlink[PATH_MAX + N_ALIGN(PATH_MAX) + 1];
-		char name[N_ALIGN(PATH_MAX)];
+		char symlink[SYMLINK_BUF_SIZE];
+		char name[NAME_BUF_SIZE];
 	} *bufs = kmalloc(sizeof(*bufs), GFP_KERNEL);
 
 	if (!bufs)

