Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F0B343FFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 12:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhCVLik (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 07:38:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhCVLid (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:38:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 992BA61974;
        Mon, 22 Mar 2021 11:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616413113;
        bh=m/pqstVFIaq8Em2ZR3enQ3PtJojyqYkGHkt4Gp11Saw=;
        h=From:To:Cc:Subject:Date:From;
        b=U2soy6HdXXYCIJF5wV8gpaFJpvXvBV7RysItp3OkxuJhEnAH0jBwY82WdypwfcD2N
         Xb215JtmCchMPoq0JeMQero0dxGqcKByDinD7qd5AA881P1I3UkvoEWb7FSZrZkCxu
         P8ydrqhCalYNrPODsYgH0Gadzi0jJJ1y+QCZQU6u7qnIXYqfTs5LuEhl8JsJ55TWeR
         79YlaDJTTSsqvMXMUDMAKvHhAK98AGkStesEPMIbiIWTFDKsfmGv2b6V/hGhm+EG7y
         cY5LwnSwngGRBop8mC9JanuHJkfR/ncM81fUzBee1S34JK9HwwaRMk/ydpnAyv7non
         S5gyUvzZ2z9ew==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Serge Hallyn <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] posix-acl: avoid -Wempty-body warning
Date:   Mon, 22 Mar 2021 12:38:24 +0100
Message-Id: <20210322113829.3239999-1-arnd@kernel.org>
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

Rewrite it as gcc suggests as a step towards a clean W=1 build.
On most architectures, we could just drop the if() entirely, but
in some cases this causes a different warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/posix_acl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index f3309a7edb49..ee6b040c8b43 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -123,8 +123,9 @@ struct posix_acl *get_acl(struct inode *inode, int type)
 	 * to just call ->get_acl to fetch the ACL ourself.  (This is going to
 	 * be an unlikely race.)
 	 */
-	if (cmpxchg(p, ACL_NOT_CACHED, sentinel) != ACL_NOT_CACHED)
-		/* fall through */ ;
+	if (cmpxchg(p, ACL_NOT_CACHED, sentinel) != ACL_NOT_CACHED) {
+		/* fall through */
+	}
 
 	/*
 	 * Normally, the ACL returned by ->get_acl will be cached.
-- 
2.29.2

