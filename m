Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77D62DFBDD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Dec 2020 13:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgLUMcT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 07:32:19 -0500
Received: from condef-10.nifty.com ([202.248.20.75]:30550 "EHLO
        condef-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgLUMcT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 07:32:19 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Dec 2020 07:32:18 EST
Received: from conuserg-11.nifty.com ([10.126.8.74])by condef-10.nifty.com with ESMTP id 0BLCL9pX023972
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Dec 2020 21:21:09 +0900
Received: from grover.flets-west.jp (softbank126090214151.bbtec.net [126.90.214.151]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 0BLCJeD8020122;
        Mon, 21 Dec 2020 21:19:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 0BLCJeD8020122
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1608553181;
        bh=JLjvabwiiqZORWv+oTjs4oddxbNIzMH5ENS/Q7Ac9KI=;
        h=From:To:Cc:Subject:Date:From;
        b=Rg/mqfVksPCpYmggcT3s/LPUTG74zOHlbZElBeGt/W/sLGCffsiHhQrAFhu9goj4W
         IPaipglZNeHIrRV8cq7kOp9asV/XWnNDRBl8wtfhr67SWa6pY/fkQh104ap4gGzj8/
         mQApKgR4tZK0VLKAnebCUhoOQMFAP1TyzjeltOK1oCL4YTHPhxA5dRocaZgFp6Zeu6
         YHbzIneQOvXelsKB7KoO8O6ddiam0R4q1cs7Ebd6UrHwTz9vewI75FNncDLtmmo1jz
         pFMHT7mUHTCISalenmz+fU0N4lh+xVj3p6tWhZdXrjT66IlBsrrVAyB56GJwhnIP7m
         6vUtXfbrEhp5g==
X-Nifty-SrcIP: [126.90.214.151]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] fs: binfmt_em86: check the result of remove_arg_zero()
Date:   Mon, 21 Dec 2020 21:19:33 +0900
Message-Id: <20201221121933.293635-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix the following warning:

fs/binfmt_em86.c: In function 'load_em86':
fs/binfmt_em86.c:66:2: warning: ignoring return value of 'remove_arg_zero', declared with attribute warn_unused_result [-Wunused-result]
   66 |  remove_arg_zero(bprm);
      |  ^~~~~~~~~~~~~~~~~~~~~

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 fs/binfmt_em86.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_em86.c b/fs/binfmt_em86.c
index 06b9b9fddf70..ba1e22b2e2a3 100644
--- a/fs/binfmt_em86.c
+++ b/fs/binfmt_em86.c
@@ -63,7 +63,9 @@ static int load_em86(struct linux_binprm *bprm)
 	 * This is done in reverse order, because of how the
 	 * user environment and arguments are stored.
 	 */
-	remove_arg_zero(bprm);
+	retval = remove_arg_zero(bprm);
+	if (retval)
+		return retval;
 	retval = copy_string_kernel(bprm->filename, bprm);
 	if (retval < 0) return retval; 
 	bprm->argc++;
-- 
2.27.0

