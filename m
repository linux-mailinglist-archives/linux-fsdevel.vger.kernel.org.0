Return-Path: <linux-fsdevel+bounces-44497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0916AA69D2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 01:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B556919C214E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 00:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066AA1C5D77;
	Thu, 20 Mar 2025 00:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="bufE96Mx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF8A1B85C5;
	Thu, 20 Mar 2025 00:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742429684; cv=none; b=Z0p/e1N/imSfchPyzBlDf4X0dsjkYAvof0Y/ZmQ13vY6eYZ/cMtMqVpWfy6hilm947ScTjDs3TN6YVIL26sJRfu6nC17LdKkyXy4rC283U4jkFkh64GDJAHQUsjCoUWhP5n3j7yutiimpNWrU6tOWcsxcVPST1v2pNzXRW83ZiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742429684; c=relaxed/simple;
	bh=Q6GbWsVFbVZvwlRkCbX2EKd/++0NsJW+Xu2Dl3r1wdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZH20kdWs/zuZO8Jo262z7WNGJy823MThNc66ri1Vq5JzCi5ESGOWUEn1bHdth/na3VkaZU78IXmQXmhJmOOPMRpIIkBQULDjWpF5OGK9WByP9bqAuezLE/FwgOLFVbsdwVSGp164yU8nKE9N+jmcCNggO40QdSkUZ1eLFD2gfuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=bufE96Mx; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ZJ5fx0620z9sbt;
	Thu, 20 Mar 2025 01:14:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1742429673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v22hv3n1eIaZNFrKPr5XKFlzLUunMQOC3iRYfPRx2JQ=;
	b=bufE96MxgGbn6nG+3JwsLlz5RpfqHa1l4pa+Nk4cQASiIfiuXF47Jf1CIJM2n3JU17wipd
	ZJKqvw5jGAeDlpZ6sk9cG1eTL8StYnOeVuLm+UQXo4rsHhCWzdQmJbti9cCOiSntGR663D
	pV4GiygxVNlNAtPjoNzQjddarinTtbhrTxzilF2D9ztshYEZIkJx8Ipzac+DWcvbUpVKqE
	ZrED0KWoPxclAED1FnSAqVWDAPcZ3N/MWUGZ3/aiz2USsVNDlAbmVk3Z/7o5RPRB/KgVwv
	cI2CR8k4XUjvVTs0WsZjHfzeGi5LvfjFc2npOPf+HGYyIUgJ7NsNqRkmH0jPXA==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Wed, 19 Mar 2025 20:13:56 -0400
Subject: [PATCH RFC v2 7/8] staging: apfs: init TODO and README.rst
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250319-apfs-v2-7-475de2e25782@ethancedwards.com>
References: <20250319-apfs-v2-0-475de2e25782@ethancedwards.com>
In-Reply-To: <20250319-apfs-v2-0-475de2e25782@ethancedwards.com>
To: brauner@kernel.org, tytso@mit.edu, jack@suse.cz, 
 viro@zeniv.linux.org.uk
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 ernesto.mnd.fernandez@gmail.com, dan.carpenter@linaro.org, 
 sven@svenpeter.dev, ernesto@corellium.com, gargaditya08@live.com, 
 willy@infradead.org, asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-staging@lists.linux.dev, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4767;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=Q6GbWsVFbVZvwlRkCbX2EKd/++0NsJW+Xu2Dl3r1wdM=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBOK09QZkRNY0kvei9DVy9uZFcrejd6bnR5UDFqdFUzClhxMkRFMUlhUDdBcEpreDUw
 UEszbzVTRlFZeUxRVlpNa2VWL2puTGFRODBaQ2p2L3VqVEJ6R0ZsQWhuQ3dNVXAKQUJPUkYySmt
 hSGcxSlgzWHNvemdSVHR1VDlvbXBWSlVaNzkyMTdyQS93bi9MOWNmMlZIMFZaU1JZWVBOaCtPTQ
 pNbGFzUGt3Vmtod0hjZzNqMS9aK2JUODIyN0ZNN3RpcXAyaytiQUNzUUU2Mgo9SGxxbQotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE
X-Rspamd-Queue-Id: 4ZJ5fx0620z9sbt

There are various cleanup tasks required before this driver can be moved
to fs/ and out of staging/. TODO attempts to start a list of what those
tasks may be.

The README delineates a history and provides credit to the module's
original authors. I am not the original author, I have just ported it
for upstream submission.

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 drivers/staging/apfs/README.rst | 87 +++++++++++++++++++++++++++++++++++++++++
 drivers/staging/apfs/TODO       |  7 ++++
 2 files changed, 94 insertions(+)

diff --git a/drivers/staging/apfs/README.rst b/drivers/staging/apfs/README.rst
new file mode 100644
index 0000000000000000000000000000000000000000..d7cd1eb1068f473160951c6ddb65372026445c0d
--- /dev/null
+++ b/drivers/staging/apfs/README.rst
@@ -0,0 +1,87 @@
+===========================
+Apple File System for Linux
+===========================
+
+The Apple File System (APFS) is the copy-on-write filesystem currently used on
+all Apple devices. This module provides a degree of experimental support on
+Linux.
+
+To help test write support, a set of userland tools is also under development.
+The git tree can be retrieved from https://github.com/eafer/apfsprogs.git.
+
+Known limitations
+=================
+
+This module is the result of reverse engineering and testing has been limited.
+If you make use of the write support, there is a real risk of data corruption.
+Please report any issues that you find.
+
+Writes to fusion drives are not currently supported.
+Encryption is also not yet implemented even in read-only mode.
+
+Reporting bugs
+==============
+
+If you encounter any problem, the first thing you should do is run (as root)::
+
+	dmesg | grep -i apfs
+
+to see all the error messages. If that doesn't help you, please report the
+issue via email at lore.kernel.org.
+
+Mount
+=====
+
+Like all filesystems, apfs is mounted with::
+
+	mount [-o options] device dir
+
+where ``device`` is the path to your device file or filesystem image, and
+``dir`` is the mount point. The following options are accepted:
+
+============   =================================================================
+vol=n	       Volume number to mount. The default is volume 0.
+
+snap=label     Volume snapshot to mount (in read-only mode).
+
+tier2=path     Path to the tier 2 device. For fusion drives only.
+
+uid=n, gid=n   Override on-disk inode ownership data with given uid/gid.
+
+cknodes	       Verify the checksum on all metadata nodes. Right now this has a
+	       severe performance cost, so it's not recommended.
+
+readwrite      Enable the experimental write support. This may corrupt your
+	       container.
+============   =================================================================
+
+So for instance, if you want to mount volume number 2, and you want the metadata
+to be checked, you should run (as root)::
+
+	mount -o cknodes,vol=2 device dir
+
+To unmount it, run::
+
+	umount dir
+
+Credits
+=======
+
+Originally written by Ernesto A. Fernández <ernesto@corellium.com>, with
+several contributions from Gabriel Krisman Bertazi <krisman@collabora.com>,
+Arnaud Ferraris <arnaud.ferraris@collabora.com> and Stan Skowronek
+<skylark@disorder.metrascale.com>. For attribution details see the historical
+git tree at https://github.com/eafer/linux-apfs.git and
+https://github.com/linux-apfs/linux-apfs-rw.
+
+The module was ported by Ethan Carter Edwards <ethan@ethancedwards.com> to
+mainline and submitted upstream in 2025.
+
+Work was first based on reverse engineering done by others [1]_ [2]_, and later
+on the (very incomplete) official specification [3]_. Some parts of the code
+imitate the ext2 module, and to a lesser degree xfs, udf, gfs2 and hfsplus.
+
+.. [1] Hansen, K.H., Toolan, F., Decoding the APFS file system, Digital
+   Investigation (2017), https://dx.doi.org/10.1016/j.diin.2017.07.003
+.. [2] https://github.com/sgan81/apfs-fuse
+.. [3] https://developer.apple.com/support/apple-file-system/Apple-File-System-Reference.pdf
diff --git a/drivers/staging/apfs/TODO b/drivers/staging/apfs/TODO
new file mode 100644
index 0000000000000000000000000000000000000000..b73107f4ea976af20d7e9ae19a928c5d6eb85026
--- /dev/null
+++ b/drivers/staging/apfs/TODO
@@ -0,0 +1,7 @@
+There are a couple things that should probably happen before this
+module is moved to fs/ and out of staging/. Most notably is the
+proper documentation of how APFS/this module works. Another is the
+conversion from bufferheads/pages to folios.
+
+Another good task for newcomers is patches that make it so this
+module conforms to current kernel coding standards.

-- 
2.48.1


