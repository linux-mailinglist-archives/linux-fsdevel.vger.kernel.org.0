Return-Path: <linux-fsdevel+bounces-35262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA909D3344
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 06:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E37FD283AB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 05:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4C71581E5;
	Wed, 20 Nov 2024 05:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kh7ZVabP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79001E545;
	Wed, 20 Nov 2024 05:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732081975; cv=none; b=nqpk5RxZQVffSYbFEi8yMSwcekAIV/UffMxRfdiDTMVZ55chwCXcJcMorUygl6ZETIL2+AUzej4sP93Vs4PJAXoCKemBPpOdPEQD9FxFuwdyiA0ELiOuwwmlOa/XfQQFTkcttB/xmZFBzajNSJt114oFIWayrVjOoi15ZuDwKlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732081975; c=relaxed/simple;
	bh=HhjLfZzAV2GlW3VZGQfySWZBZmERQ56RLr3tlOdBncI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KCjMiE4LoFVAZbOpaMSWZmKbi7cZP2h8wzHNZ+9/YUGYxckNtd5g/5sO6J4800t3mjYpAy8n+n1+lWQU7ufFd24qWl2MZB+hCSQ6UYkTqVnJMzQL7XUb2g8pWHbOhYlwFIRGiMBvWbOiwnXL+U96ce9x0LkdZQ3Szugn3RS4200=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kh7ZVabP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=jr9WLGkJrrZOa98eYcd077ebF/TWB7trxnSnvwKlbOA=; b=kh7ZVabPW5MmiXgGZnnRsh4lkh
	Gg1CIt2l7b5iHBPiouaBLfNYV01fDd0h5SqmXhjsLrZ8dDFYnxnSfrortlmqNYXMq1X4BrNkbLTkQ
	ppa4U+c5/YOt5Si1+Lv53bfvTktL4UckV7fCMB0+55GUs/s9S/iQ5iEPsfMnMIJGEjmMTehHroyf1
	kAPqZYhMI9Gy4xW6nJAKx/Ky91oKFFuIQpp4TPDlVCzMReUs01J/vLUUAm1G+nXn6tEM+YGY2PnXs
	+XQMNjd7a9gnA3KfsMSVxUxVdXe0FesnCvQQg42PSKg7V+ofsoBMio1mkTctA03W6o1F9kHnsN7ur
	ZSLQ/mkQ==;
Received: from [50.53.2.24] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDddx-0000000ESJw-0Ma0;
	Wed, 20 Nov 2024 05:52:49 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	autofs@vger.kernel.org,
	Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>,
	gfs2@lists.linux.dev,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	fsverity@lists.linux.dev,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	ocfs2-devel@lists.linux.dev
Subject: [PATCH] Documentation: filesystems: update filename extensions
Date: Tue, 19 Nov 2024 21:52:46 -0800
Message-ID: <20241120055246.158368-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update references to most txt files to rst files.
Update one reference to an md file to a rst file.
Update one file path to its current location.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Cc: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org
Cc: Alexander Aring <aahringo@redhat.com>
Cc: David Teigland <teigland@redhat.com>
Cc: gfs2@lists.linux.dev
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Theodore Y. Ts'o <tytso@mit.edu>
Cc: fsverity@lists.linux.dev
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: ocfs2-devel@lists.linux.dev
---
 Documentation/filesystems/autofs.rst                 |    2 +-
 Documentation/filesystems/dlmfs.rst                  |    2 +-
 Documentation/filesystems/fsverity.rst               |    2 +-
 Documentation/filesystems/path-lookup.rst            |    2 +-
 Documentation/filesystems/path-lookup.txt            |    2 +-
 Documentation/filesystems/ramfs-rootfs-initramfs.rst |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

--- linux-next-20241119.orig/Documentation/filesystems/autofs.rst
+++ linux-next-20241119/Documentation/filesystems/autofs.rst
@@ -442,7 +442,7 @@ which can be used to communicate directl
 It requires CAP_SYS_ADMIN for access.
 
 The 'ioctl's that can be used on this device are described in a separate
-document `autofs-mount-control.txt`, and are summarised briefly here.
+document `autofs-mount-control.rst`, and are summarised briefly here.
 Each ioctl is passed a pointer to an `autofs_dev_ioctl` structure::
 
         struct autofs_dev_ioctl {
--- linux-next-20241119.orig/Documentation/filesystems/dlmfs.rst
+++ linux-next-20241119/Documentation/filesystems/dlmfs.rst
@@ -36,7 +36,7 @@ None
 Usage
 =====
 
-If you're just interested in OCFS2, then please see ocfs2.txt. The
+If you're just interested in OCFS2, then please see ocfs2.rst. The
 rest of this document will be geared towards those who want to use
 dlmfs for easy to setup and easy to use clustered locking in
 userspace.
--- linux-next-20241119.orig/Documentation/filesystems/fsverity.rst
+++ linux-next-20241119/Documentation/filesystems/fsverity.rst
@@ -16,7 +16,7 @@ btrfs filesystems.  Like fscrypt, not to
 code is needed to support fs-verity.
 
 fs-verity is similar to `dm-verity
-<https://www.kernel.org/doc/Documentation/device-mapper/verity.txt>`_
+<https://www.kernel.org/doc/Documentation/admin-guide/device-mapper/verity.rst>`_
 but works on files rather than block devices.  On regular files on
 filesystems supporting fs-verity, userspace can execute an ioctl that
 causes the filesystem to build a Merkle tree for the file and persist
--- linux-next-20241119.orig/Documentation/filesystems/path-lookup.rst
+++ linux-next-20241119/Documentation/filesystems/path-lookup.rst
@@ -531,7 +531,7 @@ this retry process in the next article.
 Automount points are locations in the filesystem where an attempt to
 lookup a name can trigger changes to how that lookup should be
 handled, in particular by mounting a filesystem there.  These are
-covered in greater detail in autofs.txt in the Linux documentation
+covered in greater detail in autofs.rst in the Linux documentation
 tree, but a few notes specifically related to path lookup are in order
 here.
 
--- linux-next-20241119.orig/Documentation/filesystems/ramfs-rootfs-initramfs.rst
+++ linux-next-20241119/Documentation/filesystems/ramfs-rootfs-initramfs.rst
@@ -315,7 +315,7 @@ the above threads) is:
 2) The cpio archive format chosen by the kernel is simpler and cleaner (and
    thus easier to create and parse) than any of the (literally dozens of)
    various tar archive formats.  The complete initramfs archive format is
-   explained in buffer-format.txt, created in usr/gen_init_cpio.c, and
+   explained in buffer-format.rst, created in usr/gen_init_cpio.c, and
    extracted in init/initramfs.c.  All three together come to less than 26k
    total of human-readable text.
 
--- linux-next-20241119.orig/Documentation/filesystems/path-lookup.txt
+++ linux-next-20241119/Documentation/filesystems/path-lookup.txt
@@ -379,4 +379,4 @@ Papers and other documentation on dcache
 
 2. http://lse.sourceforge.net/locking/dcache/dcache.html
 
-3. path-lookup.md in this directory.
+3. path-lookup.rst in this directory.

