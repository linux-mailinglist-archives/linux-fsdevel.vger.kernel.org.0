Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241EE41992C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 18:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbhI0QkJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 12:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235673AbhI0QkC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:40:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E9AC061575;
        Mon, 27 Sep 2021 09:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4KirTB7VY9SdAqVf3vHSLLAh3zhrPlo2Qk48uTXZukk=; b=nstZx9H3ZfJEiJdzZJzzserJt0
        yan/MIjMY9/u3dwvJFJZf0WfcoxpZRpNDFpTShmLkF4XLJpJ3b++tAk2vCHBIx+8OlZnjzWioulLT
        yKcIowgZgKx/FSuyxUKEkG+30ufftWHhrApL8+E1KOdf7lcYIleqR6KEw89VNd+xkAHa8pLhm9icr
        QBUASh+a+F2I0YmhKNS1lxGf+LMt0UKRXiBk02y2LdQW7AdoKd+jwoLIMjca1gYGpfrM1bIgzU3ke
        I8ZL7dI+RmHNUR5kt+uScy53jWHrLsBA0CH0Rm//UE+Qr5nEAoLLHhG8akU5ZBBSx9QP50ahV1qgB
        YJzUOjSQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUtdm-003OSP-To; Mon, 27 Sep 2021 16:38:06 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org
Cc:     bvanassche@acm.org, dan.j.williams@intel.com, joe@perches.com,
        tglx@linutronix.de, mcgrof@kernel.org, keescook@chromium.org,
        rostedt@goodmis.org, linux-spdx@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 07/12] fs/kernfs/symlink.c: replace S_IRWXUGO with 0777 on kernfs_create_link()
Date:   Mon, 27 Sep 2021 09:38:00 -0700
Message-Id: <20210927163805.808907-8-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927163805.808907-1-mcgrof@kernel.org>
References: <20210927163805.808907-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If one ends up extending this line checkpatch will complain about the
use of S_IRWXUGO suggesting it is not preferred and that 0777
should be used instead. Take the tip from checkpatch and do that
change before we do our subsequent changes.

This makes no functional changes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/kernfs/symlink.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
index c8f8e41b8411..19a6c71c6ff5 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -36,8 +36,7 @@ struct kernfs_node *kernfs_create_link(struct kernfs_node *parent,
 		gid = target->iattr->ia_gid;
 	}
 
-	kn = kernfs_new_node(parent, name, S_IFLNK|S_IRWXUGO, uid, gid,
-			     KERNFS_LINK);
+	kn = kernfs_new_node(parent, name, S_IFLNK|0777, uid, gid, KERNFS_LINK);
 	if (!kn)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.30.2

