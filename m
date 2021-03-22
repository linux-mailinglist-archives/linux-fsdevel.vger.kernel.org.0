Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9B034454E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 14:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbhCVNQP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 09:16:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232661AbhCVNOI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:14:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62A0B6191F;
        Mon, 22 Mar 2021 13:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616418846;
        bh=tpP9vsOaJw+QQHNQx5DUZ9aUL871dDJBEd8x4XcJrTI=;
        h=From:To:Cc:Subject:Date:From;
        b=HowRztNRgSQuCrPUg99BUpd4uX4eagbj9tuR3xBXvYkyv8S0ZTgKGWtVH7VXr92Gu
         ozv+lelLSxKiCkPBKcvqNVAIGSi/qeAeeE7xInCJYFZftXI8YM5bL6TO/jkjGcyjvq
         U40F0grOq+Xe1Fc1xUW97oLBZdkYq1wixSTxpubRzmmCZxStdU1DViQYfQQYoEpw22
         qa1ctvEMiqwyzPnQEpicbvzsiKCbvTdIdcGPmTthVFdp64EEAnCauKfpAbpM6gyCun
         uLBj8zxQMzfxOj0Majg0yf/J/RJyqNrqktOP1a5ZnNzrTPh+8ZyvoBrmRSeztGmwzl
         Q/fqZF4reNUeg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Serge Hallyn <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] posix-acl: avoid -Wempty-body warning
Date:   Mon, 22 Mar 2021 14:13:59 +0100
Message-Id: <20210322131402.3117465-1-arnd@kernel.org>
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

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/posix_acl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index f3309a7edb49..7f939f6add7d 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -123,8 +123,7 @@ struct posix_acl *get_acl(struct inode *inode, int type)
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

