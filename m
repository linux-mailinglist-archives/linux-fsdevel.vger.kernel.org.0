Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAEE1F4D4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 07:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgFJFyF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 01:54:05 -0400
Received: from mout-p-101.mailbox.org ([80.241.56.151]:51528 "EHLO
        mout-p-101.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgFJFyC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 01:54:02 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 49hblR2dW9zKmrq;
        Wed, 10 Jun 2020 07:53:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id UoN5h8M60M3c; Wed, 10 Jun 2020 07:53:52 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, christian@brauner.io,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH] symlink.7: document magic-links more completely
Date:   Wed, 10 Jun 2020 15:53:19 +1000
Message-Id: <20200610055319.26374-1-cyphar@cyphar.com>
In-Reply-To: <20200414103524.wjhyfobzpjk236o7@yavin.dot.cyphar.com>
References: <20200414103524.wjhyfobzpjk236o7@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3F5A41750
X-Rspamd-Score: 2.16 / 15.00 / 15.00
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Michael,

Sorry for the delay and here is the patch I promised in this thread.

--8<---------------------------------------------------------------------8<--

Traditionally, magic-links have not been a well-understood topic in
Linux. This helps clarify some of the terminology used in openat2.2.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man7/symlink.7 | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/man7/symlink.7 b/man7/symlink.7
index 07b1db3a3764..ed99bc4236f1 100644
--- a/man7/symlink.7
+++ b/man7/symlink.7
@@ -84,6 +84,21 @@ as they are implemented on Linux and other systems,
 are outlined here.
 It is important that site-local applications also conform to these rules,
 so that the user interface can be as consistent as possible.
+.SS Magic-links
+There is a special class of symlink-like objects known as "magic-links" which
+can be found in certain pseudo-filesystems such as
+.BR proc (5)
+(examples include
+.IR /proc/[pid]/exe " and " /proc/[pid]/fd/* .)
+Unlike normal symlinks, magic-links are not resolved through
+pathname-expansion, but instead act as direct references to the kernel's own
+representation of a file handle. As such, these magic-links allow users to
+access files which cannot be referenced with normal paths (such as unlinked
+files still referenced by a running program.)
+.PP
+Because they can bypass ordinary
+.BR mount_namespaces (7)-based
+restrictions, magic-links have been used as attack vectors in various exploits.
 .SS Symbolic link ownership, permissions, and timestamps
 The owner and group of an existing symbolic link can be changed
 using
@@ -99,16 +114,14 @@ of a symbolic link can be changed using
 or
 .BR lutimes (3).
 .PP
-On Linux, the permissions of a symbolic link are not used
-in any operations; the permissions are always
-0777 (read, write, and execute for all user categories),
 .\" Linux does not currently implement an lchmod(2).
-and can't be changed.
-(Note that there are some "magic" symbolic links in the
-.I /proc
-directory tree\(emfor example, the
-.IR /proc/[pid]/fd/*
-files\(emthat have different permissions.)
+On Linux, the permissions of an ordinary symbolic link are not used in any
+operations; the permissions are always 0777 (read, write, and execute for all
+user categories), and can't be changed.
+.PP
+However, magic-links do not follow this rule. They can have a non-0777 mode,
+though this mode is not currently used in any permission checks.
+
 .\"
 .\" The
 .\" 4.4BSD
-- 
2.26.2

