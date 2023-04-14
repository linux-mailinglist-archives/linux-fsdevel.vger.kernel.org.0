Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313476E26EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 17:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjDNP1S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 11:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjDNP1D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:27:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0073CC39;
        Fri, 14 Apr 2023 08:26:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B11A41758;
        Fri, 14 Apr 2023 08:26:07 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2F1813F6C4;
        Fri, 14 Apr 2023 08:25:21 -0700 (PDT)
From:   Luca Vizzarro <Luca.Vizzarro@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luca Vizzarro <Luca.Vizzarro@arm.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
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
Subject: [PATCH v2 5/5] dnotify: Pass argument of fcntl_dirnotify as int
Date:   Fri, 14 Apr 2023 16:24:59 +0100
Message-Id: <20230414152459.816046-6-Luca.Vizzarro@arm.com>
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
F_DIRNOTIFY to be of type int. The current code wrongly treats it as
a long. In order to avoid access to undefined bits, we should explicitly
cast the argument to int.

Cc: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>
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
Acked-by: Jan Kara <jack@suse.cz>
Signed-off-by: Luca Vizzarro <Luca.Vizzarro@arm.com>
---
 fs/notify/dnotify/dnotify.c | 4 ++--
 include/linux/dnotify.h     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index 190aa717fa32..ebdcc25df0f7 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -199,7 +199,7 @@ void dnotify_flush(struct file *filp, fl_owner_t id)
 }
 
 /* this conversion is done only at watch creation */
-static __u32 convert_arg(unsigned long arg)
+static __u32 convert_arg(unsigned int arg)
 {
 	__u32 new_mask = FS_EVENT_ON_CHILD;
 
@@ -258,7 +258,7 @@ static int attach_dn(struct dnotify_struct *dn, struct dnotify_mark *dn_mark,
  * up here.  Allocate both a mark for fsnotify to add and a dnotify_struct to be
  * attached to the fsnotify_mark.
  */
-int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
+int fcntl_dirnotify(int fd, struct file *filp, unsigned int arg)
 {
 	struct dnotify_mark *new_dn_mark, *dn_mark;
 	struct fsnotify_mark *new_fsn_mark, *fsn_mark;
diff --git a/include/linux/dnotify.h b/include/linux/dnotify.h
index b1d26f9f1c9f..9f183a679277 100644
--- a/include/linux/dnotify.h
+++ b/include/linux/dnotify.h
@@ -30,7 +30,7 @@ struct dnotify_struct {
 			    FS_MOVED_FROM | FS_MOVED_TO)
 
 extern void dnotify_flush(struct file *, fl_owner_t);
-extern int fcntl_dirnotify(int, struct file *, unsigned long);
+extern int fcntl_dirnotify(int, struct file *, unsigned int);
 
 #else
 
@@ -38,7 +38,7 @@ static inline void dnotify_flush(struct file *filp, fl_owner_t id)
 {
 }
 
-static inline int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
+static inline int fcntl_dirnotify(int fd, struct file *filp, unsigned int arg)
 {
 	return -EINVAL;
 }
-- 
2.34.1

