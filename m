Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCD76263F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 22:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbiKKVzw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 16:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbiKKVzr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 16:55:47 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9034877F;
        Fri, 11 Nov 2022 13:55:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 211C5CE2A74;
        Fri, 11 Nov 2022 21:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB267C433B5;
        Fri, 11 Nov 2022 21:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668203743;
        bh=gkZZ3phGmC29ywySX6JEl3OOS1JDkneQIJNXEdcO4Qw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kKksT8awl2B21A8H9+F3zomJMGZSi/8epQBhzihQy+MtM27+l3HWB/Jq8+PdGFI8t
         IWhdVMKefUIFnO1eJyxzyVLV0N0A8G6/R5nTEFh2R6fl6jxaYTY8jugoGNdTSTHIci
         9BDNvDSptCS5EO0CbVelIp3hELpwl5nZMsoFNcuHk0HU6tKvmNpchmwYlxS9bhbnCp
         kZ79dnf1+hQgr0xoqldT5wRsC518blvF5F6Slz2AkncBfKgws2tZpEA6PgkxZbD/Xq
         Z3VIS0pYNR3kLonqpgw5sWwQM4aWqArsPoM7DjPbShi6B7fg5LD2XsXqaGVdggGOZk
         Le+pGHGNiDzNQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com,
        linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>
Subject: [PATCH 4/4] filelock: WARN_ON_ONCE when ->fl_file and filp don't match
Date:   Fri, 11 Nov 2022 16:55:38 -0500
Message-Id: <20221111215538.356543-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111215538.356543-1-jlayton@kernel.org>
References: <20221111215538.356543-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

vfs_lock_file, vfs_test_lock and vfs_cancel_lock all take both a struct
file argument and a file_lock. The file_lock has a fl_file field in it
howevever and it _must_ match the file passed in.

While most of the locks.c routines use the separately-passed file
argument, some filesystems rely on fl_file being filled out correctly.

I'm working on a patch series to remove the redundant argument from
these routines, but for now, let's ensure that the callers always set
this properly by issuing a WARN_ON_ONCE if they ever don't match.

Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/locks.c b/fs/locks.c
index 607f94a0e789..5876c8ff0edc 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2146,6 +2146,7 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
  */
 int vfs_test_lock(struct file *filp, struct file_lock *fl)
 {
+	WARN_ON_ONCE(filp != fl->fl_file);
 	if (filp->f_op->lock)
 		return filp->f_op->lock(filp, F_GETLK, fl);
 	posix_test_lock(filp, fl);
@@ -2295,6 +2296,7 @@ int fcntl_getlk(struct file *filp, unsigned int cmd, struct flock *flock)
  */
 int vfs_lock_file(struct file *filp, unsigned int cmd, struct file_lock *fl, struct file_lock *conf)
 {
+	WARN_ON_ONCE(filp != fl->fl_file);
 	if (filp->f_op->lock)
 		return filp->f_op->lock(filp, cmd, fl);
 	else
@@ -2663,6 +2665,7 @@ void locks_remove_file(struct file *filp)
  */
 int vfs_cancel_lock(struct file *filp, struct file_lock *fl)
 {
+	WARN_ON_ONCE(filp != fl->fl_file);
 	if (filp->f_op->lock)
 		return filp->f_op->lock(filp, F_CANCELLK, fl);
 	return 0;
-- 
2.38.1

