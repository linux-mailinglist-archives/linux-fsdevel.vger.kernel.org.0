Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669B51AF363
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 20:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgDRSlX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 14:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727826AbgDRSlT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 14:41:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F651C061A0C;
        Sat, 18 Apr 2020 11:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=a1s3aPpvGKpLdiCJSF1xLoCWRs8yNfGARacikYyrDtI=; b=jiUzn1PA4booMrgyt5t3GsYFr/
        ZqbT1yqWuAseTRoPR1cZ03WbQhbWrvrfb3Shktw7TgEPLJPejITeFAbVpfnenXWRmF7BSdlw5fufc
        5xVlLn5sdiZQghsGwMmWWL3arC3NhWrkyBajNutMr9ImoAPpM5lUCW04FYz0kBfqOP3r4nEhct+h+
        TCAeoRiWqPwZ5aMwlmi2X9WUo2e8C3nduhVceISsZ3l3t8Xh7FJIDIIpigt0+kncqSYZfrE4lZsBt
        6TUBNG1H8zQfQhU58PLzemrg6gBhYWrYtkQmRG8kcbMriC/faW7nNfRC00eH2Qpc13GljIFfSJ2mg
        RiFLp/YA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPsP1-0007rZ-9Y; Sat, 18 Apr 2020 18:41:19 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Zzy Wysm <zzy@zzywysm.com>
Subject: [PATCH 6/9] nfsd: fix empty-body warning in nfs4state.c
Date:   Sat, 18 Apr 2020 11:41:08 -0700
Message-Id: <20200418184111.13401-7-rdunlap@infradead.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200418184111.13401-1-rdunlap@infradead.org>
References: <20200418184111.13401-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix gcc empty-body warning when -Wextra is used:

../fs/nfsd/nfs4state.c:3898:3: warning: suggest braces around empty body in an ‘else’ statement [-Wempty-body]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
---
 fs/nfsd/nfs4state.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-next-20200417.orig/fs/nfsd/nfs4state.c
+++ linux-next-20200417/fs/nfsd/nfs4state.c
@@ -34,6 +34,7 @@
 
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/namei.h>
 #include <linux/swap.h>
@@ -3895,7 +3896,7 @@ nfsd4_setclientid(struct svc_rqst *rqstp
 		copy_clid(new, conf);
 		gen_confirm(new, nn);
 	} else /* case 4 (new client) or cases 2, 3 (client reboot): */
-		;
+		do_empty();
 	new->cl_minorversion = 0;
 	gen_callback(new, setclid, rqstp);
 	add_to_unconfirmed(new);
