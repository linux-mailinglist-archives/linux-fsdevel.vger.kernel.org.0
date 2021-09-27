Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E449419231
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 12:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbhI0KZx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 06:25:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233759AbhI0KZw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 06:25:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1214D60F6D;
        Mon, 27 Sep 2021 10:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632738254;
        bh=0aOydrFoj9rdoYW/inrYYjH1DD0dFF+hrVGxPuisMZI=;
        h=From:To:Cc:Subject:Date:From;
        b=NNsKuk+f6pb0KyeXpv3p3KNdXyRUGsI0281odPObdSjzr18HUywXxk7QA84bEKFdC
         1tEDbCfJ6CyRKBcnKzdnlpraoLIPvjfOUNFcLb4kHFcmHyLWqQAt6/cqt41hWu0Z5F
         076B12c9FolL+wED9Al40dBI8+36QrnNmBg8Io2+oD9q7UqGziHxmrAWdKVESH/sgk
         e0nllaWVyQ+Ak3JIzGzUrElbIbTSYeinjkZZmdXapT9UIk/euuIYoiHfGij40suCtm
         dnI5URJI/y0ku7BtBFVziOec8QOsyscUf3ZuFez5J7iCN2d/Oj1HxwO8M00YuV51vL
         pcA5zObmQZbTw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Serge Hallyn <serge@hallyn.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] [v2] posix-acl: avoid -Wempty-body warning
Date:   Mon, 27 Sep 2021 12:23:56 +0200
Message-Id: <20210927102410.1863853-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The fallthrough comment for an ignored cmpxchg() return value
produces a harmless warning with 'make W=1':

fs/posix_acl.c: In function 'get_acl':
fs/posix_acl.c:127:36: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  127 |                 /* fall through */ ;
      |                                    ^

Simplify it as a step towards a clean W=1 build.  As all architectures
define cmpxchg() as a statement expression these days, it is no longer
necessary to evaluate its return code, and the if() can just be droped.

Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
Link: https://lore.kernel.org/all/20210322132103.qiun2rjilnlgztxe@wittgenstein/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/posix_acl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index f5c25f580dd9..9323a854a60a 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -134,8 +134,7 @@ struct posix_acl *get_acl(struct inode *inode, int type)
 	 * to just call ->get_acl to fetch the ACL ourself.  (This is going to
 	 * be an unlikely race.)
 	 */
-	if (cmpxchg(p, ACL_NOT_CACHED, sentinel) != ACL_NOT_CACHED)
-		/* fall through */ ;
+	cmpxchg(p, ACL_NOT_CACHED, sentinel);
 
 	/*
 	 * Normally, the ACL returned by ->get_acl will be cached.
-- 
2.29.2

