Return-Path: <linux-fsdevel+bounces-70584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63258CA1089
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 19:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB2E93005AB5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 18:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4058398F8E;
	Wed,  3 Dec 2025 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=turretllc.us header.i=@turretllc.us header.b="paSPEE0Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.turretllc.us (unknown [67.11.194.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959E130F556;
	Wed,  3 Dec 2025 18:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.11.194.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764787091; cv=none; b=f3R21EVA0tq4DE1SLFL7/Z5ba8joZicojX0WL2zp2tvBhgIKQ3uq0GomFBwfCMHWnXWYtVD83dc7k3fPve0LcaMmXdRs3Z09S4oHIvU5LRkZLVklyIsiY7UV56TQ7vRF5Jde9xh6M7WggE78W33UP6ns7M7EWowcbJRWl5BZ2i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764787091; c=relaxed/simple;
	bh=tb+YaiAld5NKIEfGrIRZ8dO42xoqivVAoR01OT88nKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fltlE/5JTngfKsYIwvM+DRToZXjPh5uzKf1PrlxWfvwrEej5j3XhvNMWqnHjOQK7IPWwtY5C+whEj9kqxTfIRpI4SlRzqx8COpU6KGpXgNSeDFb1IfzHUMEbdlqTmEJisS/vsJXoQTllwGUMIRk3VFzjghFMz++p48oPMbgx8Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=turretllc.us; spf=pass smtp.mailfrom=turretllc.us; dkim=pass (1024-bit key) header.d=turretllc.us header.i=@turretllc.us header.b=paSPEE0Y; arc=none smtp.client-ip=67.11.194.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=turretllc.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=turretllc.us
Received: from chromebux.comalisd.org (unknown [209.249.103.10])
	by mail.turretllc.us (Postfix) with ESMTPSA id C98EA203EC;
	Wed, 03 Dec 2025 18:32:23 +0000 (-00)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=turretllc.us;
	s=mail; t=1764786744;
	bh=91lcvSmtjDMDNRd3BCpWScxWXrNQS7Sezjx+gmKn7dE=;
	h=From:To:Cc:Subject:Date;
	b=paSPEE0YbKbnVZca17Lh1i18oNoEZOdxKKQc5Acp72O4gWKwXcFu7w5+ZwShmluYg
	 RrZRdAbX0bkpeQUysniT2G+Y9Qpn/HXJYozGQe39cik6KWqYh4l8cFxxYyawv1/zKP
	 cjktSZezo1s2638UpL9uA6+4irx7mXKY2XdhNMVE=
From: Mason Rocha <mrocha@turretllc.us>
To: linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	jack@suse.cz,
	Mason Rocha <mrocha@turretllc.us>
Subject: [RFC PATCH] init/mount: allow searching initramfs for init process
Date: Wed,  3 Dec 2025 12:26:41 -0600
Message-ID: <20251203182639.3037-3-mrocha@turretllc.us>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we initiate a kernal panic if the initramfs does not have /init and
if root= is either not specified or does not equal a valid specifier.  If root=
is specified and initramfs' /init is missing, provided rdinit or init is not
set, we check and try to execute /sbin/init, /etc/init, /bin/init, and then
finally /bin/sh.

The original functionality of initiating a kernel panic was v0 linux, a time
when we had no initramfs.  This has since become outdated as it is possible for
us to, for instance, embed busybox into a kernel so if a userspace process fails
in generating the initramfs and the user fails to catch this error there is
still a way for the recovery of the system without the use of install media.

Unfortunately, this means that even if the initramfs holds some valid init
process (such as /sbin/init, or even /bin/sh) and the kernel isn't able to mount
root, instead of trying to run these processes, for the same reason why we try
to run /bin/sh in the above scenario, in which to allow for the user to recover,
the kernel simply panics.  This, in my experience, is a headache and a half as
you have to perform a system reset alongside changing the kernel command line
(which could be an issue in some embedded systems or with a unified kernel image).

Below is an incredibly elementary patch simply changing the panics to printks.
This is not the best course of action, as this change leads to the following in
the klog, which could be changed to reflect the new state more accurately:

[    2.946841] /dev/root: Can't open blockdev
[    2.949068] VFS: Cannot open root device "" or unknown-block(0,0): error -6
[    2.949626] Please append a correct "root=" boot option; here are the available partitions:
[    2.951352] 0b00         1048575 sr0
[    2.951639]  driver: sr
[    2.952573] List of all bdev filesystems:
[    2.953063]  ext3
[    2.953125]  ext2
[    2.953302]  ext4
[    2.953493]
[    2.953797] VFS: Unable to mount root fs on unknown-block(0,0)
[    3.450296] Run /sbin/init as init process
[    3.452139] Run /etc/init as init process
[    3.452728] Run /bin/init as init process
[    3.453529] Run /bin/sh as init process

I think it would be beneficial if we were to remove the messages printed for
root not being specified on the kernel command line if we were to allow
continuing the boot process with root not specified, and maintain the messages
if root is specified but cannot be found (ie, if a disk is loaded into a
different system and root=sda instead of root=UUID=), to make obvious the error.

Comments?

Signed-off-by: Mason Rocha <mrocha@turretllc.us>
---
 init/do_mounts.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 64d5e25a2..6234c4a2c 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -234,7 +234,8 @@ void __init mount_root_generic(char *name, char *pretty_name, int flags)
 			pr_err("\n");
 		}
 
-		panic("VFS: Unable to mount root fs on %s", b);
+		printk("VFS: Unable to mount root fs on %s", b);
+		goto out;
 	}
 	if (!(flags & SB_RDONLY)) {
 		flags |= SB_RDONLY;
@@ -247,7 +248,7 @@ void __init mount_root_generic(char *name, char *pretty_name, int flags)
 	for (i = 0, p = fs_names; i < num_fs; i++, p += strlen(p)+1)
 		printk(" %s", p);
 	printk("\n");
-	panic("VFS: Unable to mount root fs on \"%s\" or %s", pretty_name, b);
+	printk("VFS: Unable to mount root fs on \"%s\" or %s", pretty_name, b);
 out:
 	put_page(page);
 }
-- 
2.51.0


