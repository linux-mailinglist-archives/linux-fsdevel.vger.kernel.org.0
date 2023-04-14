Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5796E26E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 17:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjDNP0v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 11:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjDNP0l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:26:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACF75D338;
        Fri, 14 Apr 2023 08:26:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F0001713;
        Fri, 14 Apr 2023 08:26:03 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DAC573F6C4;
        Fri, 14 Apr 2023 08:25:16 -0700 (PDT)
From:   Luca Vizzarro <Luca.Vizzarro@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luca Vizzarro <Luca.Vizzarro@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        David Laight <David.Laight@ACULAB.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        linux-fsdevel@vger.kernel.org, linux-morello@op-lists.linaro.org
Subject: [PATCH v2 3/5] pipe: Pass argument of pipe_fcntl as int
Date:   Fri, 14 Apr 2023 16:24:57 +0100
Message-Id: <20230414152459.816046-4-Luca.Vizzarro@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414152459.816046-1-Luca.Vizzarro@arm.com>
References: <20230414152459.816046-1-Luca.Vizzarro@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The interface for fcntl expects the argument passed for the command
F_SETPIPE_SZ to be of type int. The current code wrongly treats it as
a long. In order to avoid access to undefined bits, we should explicitly
cast the argument to int.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Kevin Brodsky <Kevin.Brodsky@arm.com>
Cc: Vincenzo Frascino <Vincenzo.Frascino@arm.com>
Cc: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: David Laight <David.Laight@ACULAB.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-morello@op-lists.linaro.org
Signed-off-by: Luca Vizzarro <Luca.Vizzarro@arm.com>
---
 fs/pipe.c                 | 6 +++---
 include/linux/pipe_fs_i.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 42c7ff41c2db..5b718342105f 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1231,7 +1231,7 @@ const struct file_operations pipefifo_fops = {
  * Currently we rely on the pipe array holding a power-of-2 number
  * of pages. Returns 0 on error.
  */
-unsigned int round_pipe_size(unsigned long size)
+unsigned int round_pipe_size(unsigned int size)
 {
 	if (size > (1U << 31))
 		return 0;
@@ -1314,7 +1314,7 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
  * Allocate a new array of pipe buffers and copy the info over. Returns the
  * pipe size if successful, or return -ERROR on error.
  */
-static long pipe_set_size(struct pipe_inode_info *pipe, unsigned long arg)
+static long pipe_set_size(struct pipe_inode_info *pipe, unsigned int arg)
 {
 	unsigned long user_bufs;
 	unsigned int nr_slots, size;
@@ -1382,7 +1382,7 @@ struct pipe_inode_info *get_pipe_info(struct file *file, bool for_splice)
 	return pipe;
 }
 
-long pipe_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
+long pipe_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
 {
 	struct pipe_inode_info *pipe;
 	long ret;
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index d2c3f16cf6b1..033d77f0c568 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -273,10 +273,10 @@ bool pipe_is_unprivileged_user(void);
 #ifdef CONFIG_WATCH_QUEUE
 int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots);
 #endif
-long pipe_fcntl(struct file *, unsigned int, unsigned long arg);
+long pipe_fcntl(struct file *, unsigned int, unsigned int arg);
 struct pipe_inode_info *get_pipe_info(struct file *file, bool for_splice);
 
 int create_pipe_files(struct file **, int);
-unsigned int round_pipe_size(unsigned long size);
+unsigned int round_pipe_size(unsigned int size);
 
 #endif
-- 
2.34.1

