Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1881E8C0A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 01:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgE2X1m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 19:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbgE2X10 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 19:27:26 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EB2C08C5D1;
        Fri, 29 May 2020 16:27:25 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeoPM-000Bi4-53; Fri, 29 May 2020 23:27:24 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 7/9] user_regset_copyout_zero(): use clear_user()
Date:   Sat, 30 May 2020 00:27:22 +0100
Message-Id: <20200529232723.44942-7-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200529232723.44942-1-viro@ZenIV.linux.org.uk>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
 <20200529232723.44942-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

that's the only caller of __clear_user() in generic code, and it's
not hot enough to bother with skipping access_ok().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/regset.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/regset.h b/include/linux/regset.h
index bf0243779738..46d6ae68c455 100644
--- a/include/linux/regset.h
+++ b/include/linux/regset.h
@@ -320,7 +320,7 @@ static inline int user_regset_copyout_zero(unsigned int *pos,
 		if (*kbuf) {
 			memset(*kbuf, 0, copy);
 			*kbuf += copy;
-		} else if (__clear_user(*ubuf, copy))
+		} else if (clear_user(*ubuf, copy))
 			return -EFAULT;
 		else
 			*ubuf += copy;
-- 
2.11.0

