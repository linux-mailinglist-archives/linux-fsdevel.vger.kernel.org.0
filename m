Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655326E26E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 17:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjDNP0w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 11:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjDNP0m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:26:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68D7BCC26;
        Fri, 14 Apr 2023 08:26:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F7DD1756;
        Fri, 14 Apr 2023 08:26:05 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E1DE73F6C4;
        Fri, 14 Apr 2023 08:25:18 -0700 (PDT)
From:   Luca Vizzarro <Luca.Vizzarro@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luca Vizzarro <Luca.Vizzarro@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-morello@op-lists.linaro.org
Subject: [PATCH v2 4/5] memfd: Pass argument of memfd_fcntl as int
Date:   Fri, 14 Apr 2023 16:24:58 +0100
Message-Id: <20230414152459.816046-5-Luca.Vizzarro@arm.com>
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
F_ADD_SEALS to be of type int. The current code wrongly treats it as
a long. In order to avoid access to undefined bits, we should explicitly
cast the argument to int.

This commit changes the signature of all the related and helper
functions so that they treat the argument as int instead of long.

Cc: Andrew Morton <akpm@linux-foundation.org>
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
Cc: linux-mm@kvack.org
Cc: linux-morello@op-lists.linaro.org
Signed-off-by: Luca Vizzarro <Luca.Vizzarro@arm.com>
---
 include/linux/memfd.h | 4 ++--
 mm/memfd.c            | 6 +-----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/include/linux/memfd.h b/include/linux/memfd.h
index 4f1600413f91..e7abf6fa4c52 100644
--- a/include/linux/memfd.h
+++ b/include/linux/memfd.h
@@ -5,9 +5,9 @@
 #include <linux/file.h>
 
 #ifdef CONFIG_MEMFD_CREATE
-extern long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long arg);
+extern long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg);
 #else
-static inline long memfd_fcntl(struct file *f, unsigned int c, unsigned long a)
+static inline long memfd_fcntl(struct file *f, unsigned int c, unsigned int a)
 {
 	return -EINVAL;
 }
diff --git a/mm/memfd.c b/mm/memfd.c
index a0a7a37e8177..69b90c31d38c 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -243,16 +243,12 @@ static int memfd_get_seals(struct file *file)
 	return seals ? *seals : -EINVAL;
 }
 
-long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
+long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
 {
 	long error;
 
 	switch (cmd) {
 	case F_ADD_SEALS:
-		/* disallow upper 32bit */
-		if (arg > UINT_MAX)
-			return -EINVAL;
-
 		error = memfd_add_seals(file, arg);
 		break;
 	case F_GET_SEALS:
-- 
2.34.1

