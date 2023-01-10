Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F385B66374F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 03:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237653AbjAJC0C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 21:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237892AbjAJCZ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 21:25:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2BE6261
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jan 2023 18:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=yCoZQ6u/vSHwl3t6fRuU2iK/cgdhfYmUr11mLONNi2Y=; b=CFzl8E0m27+GuRJMq3QgdJRJR+
        X72+SHxWztnz4MxoqJ/GXUp87LkqPLSMJ0Hzz1hwIyQxQgJjSpcCSwlkduMqp3f04+HivTZgGIix4
        /+Q2s/OxfDbnELDQCnKzZEG2e5XJKfLupmNMSRySXxEGKL74ok4+1IZr8LGw432Gbqmx9XHhK9maI
        JC7LkKnlDkztE0SGR15ZKG79d/g7hNd8hqwVUcbjC96OysDPSAnVlFYtV9HGkRSJdY50q7iy4WbgV
        n/sogH0efUniwLA+Qh7h1F4abgZoDd2xhxIz58c19BLmMrJfEuVhFdY5beXvVm9nCA0ze2GTekkPn
        7kKauL4A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pF4Kp-004yfe-B7; Tue, 10 Jan 2023 02:25:55 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, p.raghav@samsung.com,
        hch@infradead.org, john.johansen@canonical.com,
        dhowells@redhat.com, mcgrof@kernel.org
Subject: [RFC 3/3] fs: remove old MS_* internal flags for the superblock
Date:   Mon,  9 Jan 2023 18:25:54 -0800
Message-Id: <20230110022554.1186499-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230110022554.1186499-1-mcgrof@kernel.org>
References: <20230110022554.1186499-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

During commit e462ec50cb5 ("VFS: Differentiate mount flags (MS_*) from
internal superblock flags") Christoph had suggested we should eventually
remove these old flags which were exposed to userspace but could not
be used as they were internal-only.

Nuke them.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/uapi/linux/mount.h       | 8 --------
 tools/include/uapi/linux/mount.h | 8 --------
 2 files changed, 16 deletions(-)

diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 4d93967f8aea..eb6617a5426b 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -38,14 +38,6 @@
 #define MS_STRICTATIME	(1<<24) /* Always perform atime updates */
 #define MS_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
 
-/* These sb flags are internal to the kernel */
-#define MS_SUBMOUNT     (1<<26)
-#define MS_NOREMOTELOCK	(1<<27)
-#define MS_NOSEC	(1<<28)
-#define MS_BORN		(1<<29)
-#define MS_ACTIVE	(1<<30)
-#define MS_NOUSER	(1<<31)
-
 /*
  * Superblock flags that can be altered by MS_REMOUNT
  */
diff --git a/tools/include/uapi/linux/mount.h b/tools/include/uapi/linux/mount.h
index 4d93967f8aea..eb6617a5426b 100644
--- a/tools/include/uapi/linux/mount.h
+++ b/tools/include/uapi/linux/mount.h
@@ -38,14 +38,6 @@
 #define MS_STRICTATIME	(1<<24) /* Always perform atime updates */
 #define MS_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
 
-/* These sb flags are internal to the kernel */
-#define MS_SUBMOUNT     (1<<26)
-#define MS_NOREMOTELOCK	(1<<27)
-#define MS_NOSEC	(1<<28)
-#define MS_BORN		(1<<29)
-#define MS_ACTIVE	(1<<30)
-#define MS_NOUSER	(1<<31)
-
 /*
  * Superblock flags that can be altered by MS_REMOUNT
  */
-- 
2.35.1

