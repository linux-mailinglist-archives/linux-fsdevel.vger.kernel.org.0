Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE76318EC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 16:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhBKPd2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 10:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhBKPbI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:31:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7131DC061788
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Feb 2021 07:30:28 -0800 (PST)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1lADvG-0006zF-Or; Thu, 11 Feb 2021 16:30:26 +0100
Received: from sha by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1lADvF-0000AS-O4; Thu, 11 Feb 2021 16:30:25 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>, Richard Weinberger <richard@nod.at>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] quotactl.2: Add documentation for quotactl_path()
Date:   Thu, 11 Feb 2021 16:30:24 +0100
Message-Id: <20210211153024.32502-4-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210211153024.32502-1-s.hauer@pengutronix.de>
References: <20210211153024.32502-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Expand the quotactl.2 manpage with a description for quotactl_path()
that takes a mountpoint path instead of a path to a block device.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 man2/quotactl.2      | 31 ++++++++++++++++++++++++++++---
 man2/quotactl_path.2 |  1 +
 2 files changed, 29 insertions(+), 3 deletions(-)
 create mode 100644 man2/quotactl_path.2

diff --git a/man2/quotactl.2 b/man2/quotactl.2
index 7869c64ea..76505c668 100644
--- a/man2/quotactl.2
+++ b/man2/quotactl.2
@@ -34,6 +34,8 @@ quotactl \- manipulate disk quotas
 .PP
 .BI "int quotactl(int " cmd ", const char *" special ", int " id \
 ", caddr_t " addr );
+.BI "int quotactl_path(int " cmd ", const char *" mountpoint ", int " id \
+", caddr_t " addr );
 .fi
 .SH DESCRIPTION
 The quota system can be used to set per-user, per-group, and per-project limits
@@ -48,7 +50,11 @@ after this, the soft limit counts as a hard limit.
 .PP
 The
 .BR quotactl ()
-call manipulates disk quotas.
+and
+.BR quotactl_path ()
+calls manipulate disk quotas. The difference between both functions is the way
+how the filesystem being manipulated is specified, see description of the arguments
+below.
 The
 .I cmd
 argument indicates a command to be applied to the user or
@@ -75,10 +81,19 @@ value is described below.
 .PP
 The
 .I special
-argument is a pointer to a null-terminated string containing the pathname
+argument to
+.BR quotactl ()
+is a pointer to a null-terminated string containing the pathname
 of the (mounted) block special device for the filesystem being manipulated.
 .PP
 The
+.I mountpoint
+argument to
+.BR quotactl_path ()
+is a pointer to a null-terminated string containing the pathname
+of the mountpoint for the filesystem being manipulated.
+.PP
+The
 .I addr
 argument is the address of an optional, command-specific, data structure
 that is copied in or out of the system.
@@ -133,7 +148,17 @@ flag in the
 .I dqi_flags
 field returned by the
 .B Q_GETINFO
-operation.
+operation. The
+.BR quotactl_path ()
+variant of this syscall generally ignores the
+.IR addr
+and
+.IR id
+arguments, so the
+.B Q_QUOTAON
+operation of
+.BR quotactl_path ()
+is only suitable for work with hidden system inodes.
 .IP
 This operation requires privilege
 .RB ( CAP_SYS_ADMIN ).
diff --git a/man2/quotactl_path.2 b/man2/quotactl_path.2
new file mode 100644
index 000000000..5f63187c6
--- /dev/null
+++ b/man2/quotactl_path.2
@@ -0,0 +1 @@
+.so man2/quotactl.2
-- 
2.20.1

