Return-Path: <linux-fsdevel+bounces-62607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 479E3B9AB19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 17:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551721886C60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 15:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B5D313555;
	Wed, 24 Sep 2025 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="vHhw44Tp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136AF311950;
	Wed, 24 Sep 2025 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727964; cv=none; b=sIY6efr9TT34sGClzEYdV6ET1+Gr7b0Y42Fr23uqWwDdC9f5ANFuXg8x80bnYhNwy/CjsnhkuYTZcgTagX6/+cSyCWqO0uccvvrXKBtOy/N6vvV8iR8gZc50ODJ3GbRtEFziAs0veMyVj6chytg1kWUw5Cr7AsZnduGCdH+zdeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727964; c=relaxed/simple;
	bh=mTc1es+fPFgyoAOW2eH1s+w64Uur4VOyAf5pQqsrpdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LbIea8IMPo4fE9APka/re9HI3U+FO78pEPp9QH5m84XswSdCcsG8lbF1sHPhtWkeG9aPEz2HkBccv7aDzWogSW1HaWzjRP8K5x9ascyt1OJHr2iDDy6PoJNlt0U+J0EwersjIw+5gdrm1F6LZ+4IBrCtxKKNfEwHUnk38A8RXQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=vHhw44Tp; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cX17V1fSyz9tV9;
	Wed, 24 Sep 2025 17:32:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1758727958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AvArTlTicYXcpPgiB7521Uo+R9zCrn4ZCR2VtyXXiN8=;
	b=vHhw44TpXtvNqg1iVavajyhTBv4SvgCPnDtgA58nVfIbs7KzUFYSNmaWMmesNBHkKkQDQL
	XyKdHR49gRnXiEKRa97gViF0digwUfSlH9MdUFA/18p71p6M0P58DjTfeFWlK/f0VAEO7R
	mQ3Ld7Br1Yb1Xs9NeSWOz/rntDWbyCtHC3Ij6XK3MWYN+3sYqanUEzROJi5nzOtt2RIan7
	lqokxe2MUiYf2NPUAJaq/hzOiTy4sc1MD3nIs3/vcZOgiQVtKDrDjcHrNjA197k/c/KT/H
	oh89uqURlDgYjfwQSZcqN6RkIeoNjEKBI5QphFOU/4W0A38GhlNU4tp/DSEbdQ==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Thu, 25 Sep 2025 01:31:29 +1000
Subject: [PATCH v5 7/8] man/man2/open_tree{,_attr}.2: document new
 open_tree_attr() API
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-new-mount-api-v5-7-028fb88023f2@cyphar.com>
References: <20250925-new-mount-api-v5-0-028fb88023f2@cyphar.com>
In-Reply-To: <20250925-new-mount-api-v5-0-028fb88023f2@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Askar Safin <safinaskar@zohomail.com>, 
 "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
 linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7437; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=mTc1es+fPFgyoAOW2eH1s+w64Uur4VOyAf5pQqsrpdg=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRc4bsXvD7ZIKnI5XDx48mVy+saF4S8jdXb7nsybP/Hl
 J3p+bVxHRNZGMS4GCzFFFm2+XmGbpq/+Eryp5VsMHNYmUCGSIs0MDAwMLAw8OUm5pUa6RjpmWob
 6hka6hjpGDFwcQrAVK8+zchwcN1JD9+C7EMn4ldrb2KdxhEQdzwn6ctFu5jZ39s+N88sYPifpG7
 14v/Xc1OrZ77/GLBs6ba5seJz1oocdrOMuX3YkHc/CwA=
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

This is a new API added in Linux 6.15, and is effectively just a minor
expansion of open_tree(2) in order to allow for MOUNT_ATTR_IDMAP to be
changed for an existing ID-mapped mount.  glibc does not yet have a
wrapper for this.

While working on this man-page, I discovered a bug in open_tree_attr(2)
that accidentally permitted changing MOUNT_ATTR_IDMAP for extant
detached ID-mapped mount objects.  This is definitely a bug, but there
is no need to add this to BUGS because the patch to fix this has already
been accepted (slated for 6.18, and will be backported to 6.15+).

Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man/man2/open_tree.2      | 191 ++++++++++++++++++++++++++++++++++++++++++++++
 man/man2/open_tree_attr.2 |   1 +
 2 files changed, 192 insertions(+)

diff --git a/man/man2/open_tree.2 b/man/man2/open_tree.2
index 6b04a80927a8b6a394cf7ab341b8d6b29d42d304..8b48f3b782bbb8d017ff50ae6624707cc1db992b 100644
--- a/man/man2/open_tree.2
+++ b/man/man2/open_tree.2
@@ -15,7 +15,19 @@ .SH SYNOPSIS
 .B #include <sys/mount.h>
 .P
 .BI "int open_tree(int " dirfd ", const char *" path ", unsigned int " flags );
+.P
+.BR "#include <sys/syscall.h>" "    /* Definition of " SYS_* " constants */"
+.P
+.B int syscall(SYS_open_tree_attr,
+.BI "            int " dirfd ", const char *" path ", unsigned int " flags ,
+.BI "            struct mount_attr *_Nullable " attr ", size_t " size );
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
@@ -263,6 +275,129 @@ .SH DESCRIPTION
 as a detached mount object.
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
+.BR open_tree_attr ()
+will apply the mount attribute changes described in
+.I attr
+to the file descriptor before it is returned.
+(See
+.BR mount_attr (2type)
+for a description of the
+.I \%mount_attr
+structure.
+As described in
+.BR mount_setattr (2),
+.I size
+must be set to
+.I \%sizeof(struct mount_attr)
+in order to support future extensions.)
+If
+.I attr
+is NULL,
+or has
+.IR \%attr.attr_clr ,
+.IR \%attr.attr_set ,
+and
+.I \%attr.propagation
+all set to zero,
+then
+.BR open_tree_attr ()
+has identical behaviour to
+.BR open_tree ().
+.P
+The application of
+.I attr
+to the resultant file descriptor
+has identical semantics to
+.BR mount_setattr (2),
+except for the following extensions and general caveats:
+.IP \[bu] 3
+Unlike
+.BR mount_setattr (2)
+called with a regular
+.B OPEN_TREE_CLONE
+detached mount object from
+.BR open_tree (),
+.BR open_tree_attr ()
+can specify a different setting for
+.B \%MOUNT_ATTR_IDMAP
+to the original mount object cloned with
+.BR \%OPEN_TREE_CLONE .
+.IP
+Adding
+.B \%MOUNT_ATTR_IDMAP
+to
+.I \%attr.attr_clr
+will disable ID-mapping for the new mount object;
+adding
+.B \%MOUNT_ATTR_IDMAP
+to
+.I \%attr.attr_set
+will configure the mount object to have the ID-mapping defined by
+the user namespace referenced by the file descriptor
+.IR \%attr.userns_fd .
+(The semantics of which are identical to when
+.BR mount_setattr (2)
+is used to configure
+.BR \%MOUNT_ATTR_IDMAP .)
+.IP
+Changing or removing the mapping
+of an ID-mapped mount is only permitted
+if a new detached mount object is being created with
+.I flags
+including
+.BR \%OPEN_TREE_CLONE .
+.\" Aleksa Sarai
+.\"  At time of writing, this is not actually true because of a bug where
+.\"  open_tree_attr() would accidentally permit changing MOUNT_ATTR_IDMAP for
+.\"  existing detached mount objects without setting OPEN_TREE_CLONE, but a
+.\"  patch to fix it has been slated for 6.18 and will be backported to 6.15+.
+.\"  <https://lore.kernel.org/r/20250808-open_tree_attr-bugfix-idmap-v1-0-0ec7bc05646c@cyphar.com/>
+.IP \[bu]
+If
+.I flags
+contains
+.BR \%AT_RECURSIVE ,
+then the attributes described in
+.I attr
+are applied recursively
+(just as when
+.BR mount_setattr (2)
+is called with
+.BR \%AT_RECURSIVE ).
+However, this applies in addition to the
+.BR open_tree ()-specific
+behaviour regarding
+.BR \%AT_RECURSIVE ,
+and thus
+.I flags
+must also contain
+.BR \%OPEN_TREE_CLONE .
+.P
+Note that if
+.I flags
+does not contain
+.BR \%OPEN_TREE_CLONE ,
+.BR open_tree_attr ()
+will attempt to modify the mount attributes of
+the mount object attached at
+the path described by
+.I dirfd
+and
+.IR path .
+As with
+.BR mount_setattr (2),
+if said path is not a mount point,
+.BR open_tree_attr ()
+will return an error.
 .SH RETURN VALUE
 On success, a new file descriptor is returned.
 On error, \-1 is returned, and
@@ -356,10 +491,15 @@ .SH ERRORS
 .SH STANDARDS
 Linux.
 .SH HISTORY
+.SS open_tree()
 Linux 5.2.
 .\" commit a07b20004793d8926f78d63eb5980559f7813404
 .\" commit 400913252d09f9cfb8cce33daee43167921fc343
 glibc 2.36.
+.SS open_tree_attr()
+Linux 6.15.
+.\" commit c4a16820d90199409c9bf01c4f794e1e9e8d8fd8
+.\" commit 7a54947e727b6df840780a66c970395ed9734ebe
 .SH NOTES
 .SS Mount propagation
 The bind-mount mount objects created by
@@ -507,6 +647,57 @@ .SH EXAMPLES
 /* The bind-mount is now destroyed */
 .EE
 .in
+.SS open_tree_attr()
+The following is an example of how
+.BR open_tree_attr ()
+can be used to
+take an existing id-mapped mount and
+construct a new bind-mount mount object
+with a different
+.B \%MOUNT_ATTR_IDMAP
+attribute.
+The resultant detached mount object
+can be used
+like any other mount object
+returned by
+.BR open_tree ().
+.P
+.in +4n
+.EX
+int nsfd1, nsfd2;
+int mntfd1, mntfd2, mntfd3;
+struct mount_attr attr;
+mntfd1 = open_tree(AT_FDCWD, "/foo", OPEN_TREE_CLONE);
+\&
+/* Configure the id-mapping of mntfd1 */
+nsfd1 = open("/proc/1234/ns/user", O_RDONLY);
+memset(&attr, 0, sizeof(attr));
+attr.attr_set = MOUNT_ATTR_IDMAP;
+attr.userns_fd = nsfd1;
+mount_setattr(mntfd1, "", AT_EMPTY_PATH, &attr, sizeof(attr));
+\&
+/* Create a new copy with a different id-mapping */
+nsfd2 = open("/proc/5678/ns/user", O_RDONLY);
+memset(&attr, 0, sizeof(attr));
+attr.attr_clr = MOUNT_ATTR_IDMAP;
+.\" Using .attr_clr is not strictly necessary but makes the intent clearer.
+attr.attr_set = MOUNT_ATTR_IDMAP;
+attr.userns_fd = nsfd2;
+mntfd2 = open_tree(mntfd1, "", OPEN_TREE_CLONE,
+                   &attr, sizeof(attr));
+\&
+/* Create a new copy with the id-mapping cleared */
+memset(&attr, 0, sizeof(attr));
+attr.attr_clr = MOUNT_ATTR_IDMAP;
+mntfd3 = open_tree(mntfd1, "", OPEN_TREE_CLONE,
+                   &attr, sizeof(attr));
+.EE
+.in
+.P
+.BR open_tree_attr ()
+can also be used
+with attached mount objects;
+the above example is only intended to be illustrative.
 .SH SEE ALSO
 .BR fsconfig (2),
 .BR fsmount (2),
diff --git a/man/man2/open_tree_attr.2 b/man/man2/open_tree_attr.2
new file mode 100644
index 0000000000000000000000000000000000000000..e57269bbd269bcce0b0a974425644ba75e379f2f
--- /dev/null
+++ b/man/man2/open_tree_attr.2
@@ -0,0 +1 @@
+.so man2/open_tree.2

-- 
2.51.0


