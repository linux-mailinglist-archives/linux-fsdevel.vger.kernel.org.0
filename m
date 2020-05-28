Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635351E70BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 01:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437787AbgE1Xtn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 19:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437781AbgE1Xtd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 19:49:33 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11CAC008631;
        Thu, 28 May 2020 16:49:33 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeSHE-00HDpR-7q; Thu, 28 May 2020 23:49:32 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/6] drm/i915/gem: Replace user_access_begin by user_write_access_begin
Date:   Fri, 29 May 2020 00:49:31 +0100
Message-Id: <20200528234931.4104686-3-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200528234931.4104686-1-viro@ZenIV.linux.org.uk>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
 <20200528234931.4104686-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

When i915_gem_execbuffer2_ioctl() is using user_access_begin(),
that's only to perform unsafe_put_user() so use
user_write_access_begin() in order to only open write access.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/ebf1250b6d4f351469fb339e5399d8b92aa8a1c1.1585898438.git.christophe.leroy@c-s.fr
---
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index b7440f06c5e2..8a4e9c1cbf6c 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -2794,7 +2794,8 @@ i915_gem_execbuffer2_ioctl(struct drm_device *dev, void *data,
 		 * And this range already got effectively checked earlier
 		 * when we did the "copy_from_user()" above.
 		 */
-		if (!user_access_begin(user_exec_list, count * sizeof(*user_exec_list)))
+		if (!user_write_access_begin(user_exec_list,
+					     count * sizeof(*user_exec_list)))
 			goto end;
 
 		for (i = 0; i < args->buffer_count; i++) {
@@ -2808,7 +2809,7 @@ i915_gem_execbuffer2_ioctl(struct drm_device *dev, void *data,
 					end_user);
 		}
 end_user:
-		user_access_end();
+		user_write_access_end();
 end:;
 	}
 
-- 
2.11.0

