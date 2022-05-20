Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F3652E2FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 05:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345104AbiETDRz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 23:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345124AbiETDRy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 23:17:54 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3915DA34
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 20:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sgLAENrVLhV3Ip9Sf4Lx0FGhBG6cAsuJh+48uPiE0ZU=; b=hyDraljJTFiDtYKWgJTmdSDiCy
        dWbZ1971pGcVgntCWuJcRFAw8hcVqZVXuBmUjmKtQtETCYkHdTyQ/4WKSn1dMdUX77CvnFa3s7Pi+
        acgLuoz8bMh/J31qUR+0OU01QrBGbYCaVw5TC0BMVnDLprQOMfLWSa4EzWiZ5F6MxLjOBcZcj8Gqv
        vWIEfiZDDORbGdgC64gm8bBJ/oMc+rjCGG51pYUoKZRBN7MWAIOomSi21LFdWTFHla4YDXB0Pxfu6
        72vG+VXtqvIx8yBJ/WuHpMOKX6AYvgK4hM44OQEWr351s0oiC9zEyrPwSVdTnoYG2NY64HXulxz6y
        5Lb2n/sA==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrt9E-00GU7n-Ab
        for linux-fsdevel@vger.kernel.org; Fri, 20 May 2022 03:17:52 +0000
Date:   Fri, 20 May 2022 03:17:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/namei.c:reserve_stack(): tidy up the call of
 try_to_unlazy()
Message-ID: <YocIYPe1p5dJTBXc@zeniv-ca.linux.org.uk>
References: <YocIMkS1qcPGrik0@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YocIMkS1qcPGrik0@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

!foo() != 0 is a strange way to spell !foo(); fallout from
"fs: make unlazy_walk() error handling consistent"...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index b867a92c078e..2d6b94a950fe 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1754,7 +1754,7 @@ static int reserve_stack(struct nameidata *nd, struct path *link, unsigned seq)
 		// unlazy even if we fail to grab the link - cleanup needs it
 		bool grabbed_link = legitimize_path(nd, link, seq);
 
-		if (!try_to_unlazy(nd) != 0 || !grabbed_link)
+		if (!try_to_unlazy(nd) || !grabbed_link)
 			return -ECHILD;
 
 		if (nd_alloc_stack(nd))
-- 
2.30.2

