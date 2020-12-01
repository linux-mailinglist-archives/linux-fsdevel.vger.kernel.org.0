Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406622CA75E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 16:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390760AbgLAPpv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 10:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388237AbgLAPpv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:45:51 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EF7C0613CF;
        Tue,  1 Dec 2020 07:45:10 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 8C6B4C009; Tue,  1 Dec 2020 16:45:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1606837509; bh=4ZXOky5X68edX+ZKji8/7+h5ZsUJEEYYFZe9izZo8+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V1K25wq1u1fSElfnlqOpXx/DR0/vSYT89xuRf2OGvW+Baxb7n394nVp0d6LCf8fiS
         ARMuITlvTDKM3wI24I76ntsZLoS6tYVHxJ4+PGhefksxvNmKLPdHN4TgNA+J1YIT9g
         1E6vRacn3RaVgUCdSsMKp917hjdn6IygiZIaKUEtA4Fr/gAZd1MUqxqg2oYOkXR7FY
         qCu0PtB/9qTZAVS/dpn1d/A1MYw3ymiB0YFsDbwjYBuro86F/11m4dqylGG8fQz2al
         ptoo0xPnWDz4E4BApccvuQ4B7PgQa8EweUpkzC1Hz4lGf1Ui9I9Sn36DysRVPUuBLt
         LU+yKLTrrW7lw==
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     asmadeus@codewreck.org
Cc:     linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH] fs: 9p: add generic splice_write file operation
Date:   Tue,  1 Dec 2020 16:44:56 +0100
Message-Id: <1606837496-21717-1-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <20201201151658.GA13180@nautica>
References: <20201201151658.GA13180@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The default splice operations got removed recently, add it back to 9p
with iter_file_splice_write like many other filesystems do.

Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
Cc: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 fs/9p/vfs_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 145f6f83aa9a..5f9c0c796a37 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -668,6 +668,7 @@ const struct file_operations v9fs_cached_file_operations = {
 	.lock = v9fs_file_lock,
 	.mmap = v9fs_file_mmap,
 	.splice_read = generic_file_splice_read,
+	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync,
 };
 
@@ -681,6 +682,7 @@ const struct file_operations v9fs_cached_file_operations_dotl = {
 	.flock = v9fs_file_flock_dotl,
 	.mmap = v9fs_file_mmap,
 	.splice_read = generic_file_splice_read,
+	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync_dotl,
 };
 
@@ -693,6 +695,7 @@ const struct file_operations v9fs_file_operations = {
 	.lock = v9fs_file_lock,
 	.mmap = generic_file_readonly_mmap,
 	.splice_read = generic_file_splice_read,
+	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync,
 };
 
@@ -706,6 +709,7 @@ const struct file_operations v9fs_file_operations_dotl = {
 	.flock = v9fs_file_flock_dotl,
 	.mmap = generic_file_readonly_mmap,
 	.splice_read = generic_file_splice_read,
+	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync_dotl,
 };
 
@@ -718,6 +722,7 @@ const struct file_operations v9fs_mmap_file_operations = {
 	.lock = v9fs_file_lock,
 	.mmap = v9fs_mmap_file_mmap,
 	.splice_read = generic_file_splice_read,
+	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync,
 };
 
@@ -731,5 +736,6 @@ const struct file_operations v9fs_mmap_file_operations_dotl = {
 	.flock = v9fs_file_flock_dotl,
 	.mmap = v9fs_mmap_file_mmap,
 	.splice_read = generic_file_splice_read,
+	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync_dotl,
 };
-- 
2.28.0

