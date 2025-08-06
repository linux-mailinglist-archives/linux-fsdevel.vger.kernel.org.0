Return-Path: <linux-fsdevel+bounces-56869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BF4B1CB61
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 19:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC31C18C2DC1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 17:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FA82BF3CA;
	Wed,  6 Aug 2025 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="jhTAtbyw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7618F2BF009;
	Wed,  6 Aug 2025 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754502355; cv=none; b=AHJt69o5f8JdJps2SZI7zBfT0DLnjFbeuIxHzPiz4oMmZ2mZPtlgo9hjvaFPQpZqQ9uBpDtkjp15DkaR0ccuiNMPHB9gAH8EOpy6zjMRQaKTlceAL1qy5aazVwMPOha7fS/bmVksB9/ZoNBM+wOkqveNAlHJ7w9IFV4pRURtZo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754502355; c=relaxed/simple;
	bh=88pixLZilCbLz/yjfDYQoTyUZ5ObBDDeN1zdu4FRdNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AWtMmx7xgyxneEiokrpClkQJX8SVK/T0YsoFWtf6I4S0KVdYCZF60J9vidDPqE27hWicdtsuRAlynOYfRxKR2FOgF6C8WkBANVsnLUxMxdHjYqYRWRXFDTYRGDZTQPx0RpfYHBk6G3UH2L3w9FUUwtea/Pp4eJDSjPEgsL1xsEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=jhTAtbyw; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bxyPp0T0nz9t80;
	Wed,  6 Aug 2025 19:45:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754502350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+MX4/TVRSIyTRewqaveai9CyOrf1mx+NDItuqJPG/w=;
	b=jhTAtbywriLs41Suas6vpFfmC29X5P4NiluYw9S6NmEf3Q0sHWt3rrlp18ohsvXpFYxcKC
	4zFIibL1yg2/BCaQPqMkA32XldoP7WIXtzOt8+UaTAll8SDTGxMgwTr0RspVjquxJJLCF5
	VcY8bGghzzBXQWsyLrv0h4z2TOeFicvHhcZ9pZ41105WA9LpwqIGQdxch4Sg7mFC+7+VP5
	gXegQkRwWCC5VasW0LLr3F8gRxHezCcFXY+23NHCbKeQ/c1JCUiZWCjY2VAGWlyKho7cUD
	1ouuV1ZDfewhwCv2/xxFYzCYtgjoGN75eKaPFOiY980FbQWv+REBWqun8B43dw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Thu, 07 Aug 2025 03:44:44 +1000
Subject: [PATCH v2 10/11] open_tree_attr.2, open_tree.2: document new
 open_tree_attr() api
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-new-mount-api-v2-10-558a27b8068c@cyphar.com>
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
In-Reply-To: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Askar Safin <safinaskar@zohomail.com>, 
 "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
 linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3539; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=88pixLZilCbLz/yjfDYQoTyUZ5ObBDDeN1zdu4FRdNI=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMntJuMf1j3Ydzv/o2X0lcwDBpHdOFarFlSUeP+waus
 2f5prDxWUcpC4MYF4OsmCLLNj/P0E3zF19J/rSSDWYOKxPIEAYuTgGYSIs/I8PfT1YfrLO3sy5Y
 v8Qnq6xMZJnx7OTSGSfWrvqTI3jRONCc4Q/nZ41F8/ume/szrFI2r8mwje175pV4XPiHJ++fP9L
 vdLgA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4bxyPp0T0nz9t80

This is a new API added in Linux 6.15, and is effectively just a minor
expansion of open_tree(2) in order to allow for MOUNT_ATTR_IDMAP to be
changed for an existing ID-mapped mount.  Glibc does not yet have a
wrapper for this.

Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man/man2/open_tree.2      | 74 +++++++++++++++++++++++++++++++++++++++++++++++
 man/man2/open_tree_attr.2 |  1 +
 2 files changed, 75 insertions(+)

diff --git a/man/man2/open_tree.2 b/man/man2/open_tree.2
index 3d38e27b5254..6e7ec4998d42 100644
--- a/man/man2/open_tree.2
+++ b/man/man2/open_tree.2
@@ -15,7 +15,19 @@ .SH SYNOPSIS
 .BR "#include <sys/mount.h>"
 .P
 .BI "int open_tree(int " dirfd ", const char *" path ", unsigned int " flags ");"
+.P
+.BR "#include <sys/syscall.h>" "    /* Definition of " SYS_* " constants */"
+.P
+.BI "int syscall(SYS_open_tree_attr, int " dirfd ", const char *" path ","
+.BI "            unsigned int " flags ", struct mount_attr *" attr ", \
+size_t " size ");"
 .fi
+.P
+.IR Note :
+glibc provides no wrapper for
+.BR open_tree_attr (),
+necessitating the use of
+.BR syscall (2).
 .SH DESCRIPTION
 The
 .BR open_tree ()
@@ -222,6 +234,64 @@ .SH DESCRIPTION
 and attach it to the file descriptor.
 This flag is only permitted in conjunction with
 .BR \%OPEN_TREE_CLONE .
+.SS open_tree_attr()
+The
+.BR open_tree_attr ()
+system call operates in exactly the same way as
+.BR open_tree (),
+except for the differences described here.
+.P
+After performing the same operation as with
+.BR open_tree (),
+(before returning the resulting file descriptor)
+.BR open_tree_attr ()
+will apply the mount attributes requested in
+.I attr
+to the mount object.
+(See
+.BR mount_attr (2type)
+for a description of the
+.I mount_attr
+structure.
+As described in
+.BR mount_setattr (2),
+.I size
+must be set to
+.I sizeof(struct mount_attr)
+in order to support future extensions.)
+.P
+For the most part, the application of
+.I attr
+has identical semantics to
+.BR mount_setattr (2),
+except that it is possible to change the
+.B \%MOUNT_ATTR_IDMAP
+attribute for a mount object
+that is already configured as an ID-mapped mount.
+This is usually forbidden by
+.BR mount_setattr (2)
+and thus
+.BR open_tree_attr ()
+is currently the only permitted mechanism to change this attribute.
+Changing an ID-mapped mount is only permitted
+if a new detached mount object is being created with
+.I flags
+including
+.BR \%OPEN_TREE_CLONE .
+.P
+If
+.I flags
+contains
+.BR \%AT_RECURSIVE ,
+then the attributes are applied recursively
+(just as when
+.BR mount_setattr (2)
+is called with
+.BR \%AT_RECURSIVE ).
+This applies in addition to the
+.BR open_tree ()-specific
+behaviour regarding
+.BR \%AT_RECURSIVE .
 .SH RETURN VALUE
 On success, a new file descriptor is returned.
 On error, \-1 is returned, and
@@ -316,9 +386,13 @@ .SH ERRORS
 .SH STANDARDS
 Linux.
 .SH HISTORY
+.SS open_tree()
 Linux 5.2.
 .\" commit a07b20004793d8926f78d63eb5980559f7813404
 glibc 2.36.
+.SS open_tree_attr()
+Linux 6.15.
+.\" commit c4a16820d90199409c9bf01c4f794e1e9e8d8fd8
 .SH NOTES
 .SS Anonymous mount namespaces
 The bind-mount mount objects created by
diff --git a/man/man2/open_tree_attr.2 b/man/man2/open_tree_attr.2
new file mode 100644
index 000000000000..e57269bbd269
--- /dev/null
+++ b/man/man2/open_tree_attr.2
@@ -0,0 +1 @@
+.so man2/open_tree.2

-- 
2.50.1


