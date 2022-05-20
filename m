Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB23452E300
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 05:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345124AbiETDSf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 23:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345127AbiETDSe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 23:18:34 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DD45D5EA
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 20:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SPXO38tGZkuNyt1CtgbfYpB02lf7sBpJcGAY9aRyD8k=; b=Y3px/QLlbyOQOPfkeb/fX9V/Zq
        glCb2zDDya8n+4hG8uCXOxLBqVptTuBHDLN0KYPxB1defXRV/jnx74RiJZotNNS4XLvZONhDqDVHI
        XnSOdAkG7zK++jOz+gB5XGZZWuIsNA/VNxA2VsW5X2cw1R2vRxT+kjBeda2bYAPzYYJciiRyHcW7c
        cZ6iV1cTsVchYgK0oYSyrJGyu0CjpCqcAttuuKjiJ0b6egg1p3Vsizch3eYNY96k2226H/SQM/et5
        mf440RNdTo81nu2qtpArqMsnRJPNAFW4a4NuEPWa3VXBCtbJl3gpJwt7oorNmWimcz6Pv+GoV32z8
        9NC5Y+3Q==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrt9s-00GU8J-6s
        for linux-fsdevel@vger.kernel.org; Fri, 20 May 2022 03:18:32 +0000
Date:   Fri, 20 May 2022 03:18:32 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] get rid of dead code in legitimize_root()
Message-ID: <YocIiPQjR7tuYdkP@zeniv-ca.linux.org.uk>
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

Combination of LOOKUP_IS_SCOPED and NULL nd->root.mnt is impossible
after successful path_init().  All places where ->root.mnt might
become NULL do that only if LOOKUP_IS_SCOPED is not there and
path_init() itself can return success without setting nd->root
only if ND_ROOT_PRESET had been set (in which case nd->root
had been set by caller and never changed) or if the name had
been a relative one *and* none of the bits in LOOKUP_IS_SCOPED
had been present.

Since all calls of legitimize_root() must be downstream of successful
path_init(), the check for !nd->root.mnt && (nd->flags & LOOKUP_IS_SCOPED)
is pure paranoia.

FWIW, it had been discussed (and agreed upon) with Aleksa back when
scoped lookups had been merged; looks like that had fallen through the
cracks back then.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 2d6b94a950fe..bfe4ec9e282b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -729,13 +729,6 @@ static bool legitimize_links(struct nameidata *nd)
 
 static bool legitimize_root(struct nameidata *nd)
 {
-	/*
-	 * For scoped-lookups (where nd->root has been zeroed), we need to
-	 * restart the whole lookup from scratch -- because set_root() is wrong
-	 * for these lookups (nd->dfd is the root, not the filesystem root).
-	 */
-	if (!nd->root.mnt && (nd->flags & LOOKUP_IS_SCOPED))
-		return false;
 	/* Nothing to do if nd->root is zero or is managed by the VFS user. */
 	if (!nd->root.mnt || (nd->state & ND_ROOT_PRESET))
 		return true;
-- 
2.30.2

