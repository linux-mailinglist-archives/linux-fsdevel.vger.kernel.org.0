Return-Path: <linux-fsdevel+bounces-75334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SF89IPwUdGk32AAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 01:40:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 274AD7BBD5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 01:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD8FB30156D4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 00:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3C51DEFE8;
	Sat, 24 Jan 2026 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bn/0m0OP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EAF192590;
	Sat, 24 Jan 2026 00:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769215224; cv=none; b=dUbEolHMJ6fBjqXPEhiXwTOEnZNnH9ZHCsYam4js6MCc6Hl+mv5dW3Tf7srjNeevixanun6f8FmcKYnQdJtEcNHYoCdipmV5rzztoUFVioacbAPpCwoYMNcoaBAnbVbQkW80u8kw+jR3tiyTN8C7tRzJp/6Cn1paCvI9LdIgBCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769215224; c=relaxed/simple;
	bh=sxCYWInGWcJQzA2I9jwBu6cloSbClI3rKDeIROS8Aoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jb9mvGmglyeenR0HFz9ZuWbwanq6LWOHlHCCpezJnOilAYCOErm6+9HaAbi/YlOPivQ0jN2L7TYAW35K+cKZP/xo5HgLUNIQl+OBj7U4ydaJnwVO9myJdWpoc5Bf2Ryh7oHupuaO923xA6b0IgpDo/bcCo5KXIzX12kvZAKfKA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=bn/0m0OP; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from mail.zytor.com (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 60O0dnvY1194278
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 23 Jan 2026 16:40:00 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 60O0dnvY1194278
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025122301; t=1769215201;
	bh=4va4Vi1oM4mVPAzSfh+07TIDR6BSUY4QxzNfUhSYeE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bn/0m0OP6ydBZerJ5bYNgIWvCw9jmD6sMeXonaQ5WDZLoLQ15pxI7MFpGS2SaU85Z
	 gAEg+wjx8R5V9kgu6LFGiioqN5RdDkBk5eBJMMwoLdA8Sxg6MYQeGWuqjOeKJMe5UI
	 IGrvwG5uJWTPAArLOf3MDuw7LCtjJCl23CT+QsUIzehyoO8v79/cv1FXDeDjopX4UA
	 29xh4rGJxZZq6V1QqqquGHEfR+E9/6ZGhDgPelcdf34JWSYWcPKefNrZQGKxzg66ry
	 37MVPar7XVevksRnGoMnBb17rScoElQx+5RqtfUbf02CxO59Lp+Wl46MLmyJSWgchq
	 y+envHmh7lA/A==
From: "H. Peter Anvin" <hpa@zytor.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        systemd-devel@lists.freedesktop.org
Subject: [RFC PATCH 3/3] Documentation/initramfs: document mount points in initramfs
Date: Fri, 23 Jan 2026 16:39:36 -0800
Message-ID: <20260124003939.426931-4-hpa@zytor.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2025122301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75334-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 274AD7BBD5
X-Rspamd-Action: no action

Document how to create mount points in initramfs, using magic
"!!!MOUNT!!!" file entries, the format the kernel expects for these
files, and their exact semantics.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 .../early-userspace/buffer-format.rst         | 60 ++++++++++++++++++-
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/early-userspace/buffer-format.rst b/Documentation/driver-api/early-userspace/buffer-format.rst
index 4597a91100b7..40f86b9eec75 100644
--- a/Documentation/driver-api/early-userspace/buffer-format.rst
+++ b/Documentation/driver-api/early-userspace/buffer-format.rst
@@ -8,8 +8,8 @@ With kernel 2.5.x, the old "initial ramdisk" protocol was complemented
 with an "initial ramfs" protocol.  The initramfs content is passed
 using the same memory buffer protocol used by initrd, but the content
 is different.  The initramfs buffer contains an archive which is
-expanded into a ramfs filesystem; this document details the initramfs
-buffer format.
+expanded into a tmpfs or ramfs filesystem; this document details the
+initramfs buffer format.
 
 The initramfs buffer format is based around the "newc" or "crc" CPIO
 formats, and can be created with the cpio(1) utility.  The cpio
@@ -17,6 +17,9 @@ archive can be compressed using gzip(1), or any other algorithm provided
 via CONFIG_DECOMPRESS_*.  One valid version of an initramfs buffer is
 thus a single .cpio.gz file.
 
+In kernel version XXXX the feature to mount additional filesystems
+during initramfs expansion was introduced, see below.
+
 The full format of the initramfs buffer is defined by the following
 grammar, where::
 
@@ -130,3 +133,56 @@ a) Separate the different file data sources with a "TRAILER!!!"
    end-of-archive marker, or
 
 b) Make sure c_nlink == 1 for all nondirectory entries.
+
+
+Mounting additional filesystems
+===============================
+
+If a regular file with the special name "!!!MOUNT!!!" is encountered
+during initramfs processing, the file contents is parsed as a mount
+specification in format similar to fstab(5). It should contain of a
+single line in one of the following formats::
+
+	fs_spec fs_vfstype fs_mntops
+	fs_spec fs_vfstype
+	fs_vfstype
+
+
+Comment or blank lines are NOT allowed, and the terminating newline is
+required.
+
+The specified filesystem is then mounted onto the directory in which
+the !!!MOUNT!!! file is located, for example, if the file is named::
+
+	dev/!!!MOUNT!!!
+
+
+then the filesystem will be mounted onto the /dev directory, which
+must already exist.
+
+The mount is performed immediately, before processing any further
+initramfs entries.
+
+The c_mode, c_uid, c_gid, and c_mtime (with CONFIG_INITRAMFS_PRESERVE_MTIME)
+values for the file are applied to the root directory of the newly
+mounted filesystem, if that filesystem is writable and allows those
+operations. Therefore, the !!!MOUNT!!!  file should typically have the
+x permission bit set, as a directory would.
+
+fs_spec or fs_mntops values that require user space support, such as
+LABEL= or UUID=, are not supported. To mount a filesystem that
+requires a block device, the appropriate /dev entry need to have
+been created, or devtmpfs have been mounted, earlier in the initramfs
+image.
+
+A !!!MOUNT!!! entry in the cpio archive root, or multiple !!!MOUNT!!!
+entries for the same path, will cause overmounts. This allows the
+initramfs to be expanded into a tmpfs that is separate from the
+rootfs, and which therefore, unlike the rootfs, can be unmounted.
+
+The special name !!!MOUNT!!! was chosen because the sequence !!!
+already has special meaning in cpio (the TRAILER!!! entry) and because
+! is the lowest-numbered non-blank character in ASCII. Therefore
+creating a sorted cpio archive will naturally end up with the
+!!!MOUNT!!! entry immediately after the directory itself and before
+its contents.
-- 
2.52.0


