Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04624566FFD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jul 2022 15:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbiGENyX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 09:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiGENxq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:53:46 -0400
Received: from mail.yonan.net (mail.yonan.net [54.244.116.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1E62559E;
        Tue,  5 Jul 2022 06:31:52 -0700 (PDT)
Received: from unless.localdomain (c-71-196-190-209.hsd1.co.comcast.net [71.196.190.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.yonan.net (Postfix) with ESMTPSA id 20E1643323;
        Tue,  5 Jul 2022 13:31:52 +0000 (UTC)
From:   James Yonan <james@openvpn.net>
To:     linux-fsdevel@vger.kernel.org
Cc:     david@fromorbit.com, neilb@suse.de, amir73il@gmail.com,
        viro@zeniv.linux.org.uk, linux-api@vger.kernel.org,
        James Yonan <james@openvpn.net>
Subject: [PATCH man-pages] rename.2: document new renameat2() flag RENAME_NEWER_MTIME
Date:   Tue,  5 Jul 2022 07:30:26 -0600
Message-Id: <20220705133026.892700-3-james@openvpn.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220705133026.892700-1-james@openvpn.net>
References: <20220702080710.GB3108597@dread.disaster.area>
 <20220705133026.892700-1-james@openvpn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: James Yonan <james@openvpn.net>
---
 man2/rename.2 | 138 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/man2/rename.2 b/man2/rename.2
index e403c0393..13169310d 100644
--- a/man2/rename.2
+++ b/man2/rename.2
@@ -273,6 +273,106 @@ btrfs (since Linux 4.7),
 .\" btrfs: commit cdd1fedf8261cd7a73c0596298902ff4f0f04492
 and ubifs (since Linux 4.9).
 .\" ubifs: commit 9e0a1fff8db56eaaebb74b4a3ef65f86811c4798
+.TP
+.BR RENAME_NEWER_MTIME " (since Linux 5.xx)"
+.B RENAME_NEWER_MTIME
+modifies the behavior of plain rename or
+.B RENAME_EXCHANGE
+by making the rename or exchange operation conditional on the file
+modification time
+.B mtime.
+If
+.I newpath
+exists, only perform the operation if
+.I oldpath
+.B mtime
+>
+.I newpath
+.B mtime;
+otherwise return an error.  If
+.I newpath
+doesn't exist, do a plain rename.
+.IP
+.B RENAME_NEWER_MTIME
+combines
+.B mtime
+comparison and conditional replacement into
+an atomic operation that augments the existing guarantee
+of rename operations -- that not only is there no point
+at which another process attempting to access
+.I newpath
+would find it missing, but there is no point at which a reader
+could detect an
+.B mtime
+backtrack in
+.I newpath.
+.IP
+Some of the use cases for
+.B RENAME_NEWER_MTIME
+include (a) using a directory as a key-value store, or
+(b) maintaining a near-real-time mirror of a remote data source.
+A common design pattern for maintaining such a data
+store would be to create a file using a temporary pathname,
+setting the file
+.B mtime
+using
+.BR utimensat (2)
+or
+.BR futimens (2)
+based on the remote creation
+timestamp of the file content, then using
+.B RENAME_NEWER_MTIME
+to move the file into place in the target directory.  If
+the operation returns an error with
+.I errno
+set to
+.B EEXIST,
+then
+.I oldpath
+is not up-to-date and can safely be deleted.
+The goal is to facilitate distributed systems
+having many concurrent writers and readers,
+where update notifications are possibly delayed, duplicated,
+or reordered, yet where readers see a consistent view
+of the target directory with predictable semantics
+and atomic updates.
+.IP
+Note that
+.B RENAME_NEWER_MTIME
+depends on accurate, high-resolution timestamps for
+.B mtime,
+preferably approaching nanosecond resolution.
+.IP
+.B RENAME_NEWER_MTIME
+only works on non-directory files and cannot be used when
+.I oldpath
+or
+.I newpath
+is open for write.
+.IP
+.B RENAME_NEWER_MTIME
+can be combined with
+.B RENAME_EXCHANGE
+where
+.I oldpath
+and
+.I newpath
+will only be exchanged if
+.I oldpath
+.B mtime
+>
+.I newpath
+.B mtime.
+.IP
+.B RENAME_NEWER_MTIME
+cannot be combined with
+.B RENAME_NOREPLACE
+or
+.B RENAME_WHITEOUT.
+.IP
+.B RENAME_NEWER_MTIME
+requires support from the underlying filesystem.  As of Linux 5.xx,
+ext2, ext3, ext4, xfs, btrfs, and tmpfs are supported.
 .SH RETURN VALUE
 On success, zero is returned.
 On error, \-1 is returned, and
@@ -449,6 +549,37 @@ and
 .I newpath
 already exists.
 .TP
+.B EEXIST
+.I flags
+contain
+.B RENAME_NEWER_MTIME
+and
+.I oldpath
+.B mtime
+<=
+.I newpath
+.B mtime.
+.TP
+.B EISDIR
+.I flags
+contain
+.B RENAME_NEWER_MTIME
+and
+.I oldpath
+or
+.I newpath
+is a directory.
+.TP
+.B ETXTBSY
+.I flags
+contain
+.B RENAME_NEWER_MTIME
+and
+.I oldpath
+or
+.I newpath
+is open for write.
+.TP
 .B EINVAL
 An invalid flag was specified in
 .IR flags .
@@ -470,6 +601,13 @@ were specified in
 .IR flags .
 .TP
 .B EINVAL
+.B RENAME_NEWER_MTIME
+was used together with 
+.B RENAME_NOREPLACE
+or
+.B RENAME_WHITEOUT.
+.TP
+.B EINVAL
 The filesystem does not support one of the flags in
 .IR flags .
 .TP
-- 
2.25.1

