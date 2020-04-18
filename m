Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05D61AF381
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 20:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgDRSlU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 14:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726089AbgDRSlR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 14:41:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87721C061A10;
        Sat, 18 Apr 2020 11:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=BNcb4DjvEal/26p9FFLHA1PNQV3UKc32zHdLl0ttKSE=; b=kQXoOERERzpS0IoQotzhrC17AM
        BDqI0juPogoA1CutrU8uGOPsgmnH4QRxJkDAbfNciiSq0Z69PFmgx/TEZQgstSuVQf4s8ApWyZOIN
        N0IbkOKt56gcF//A3Gy0d9YkRaR0LroHAHn9xHV3q9Bg5gPjWHvSwd3aZ1XMnWGalvGvI3KsnHTOi
        PkF+38XbJVP04POPyWZMr+qjWfRfv/aYYUcvlXgcFpJEXyrtNbDsB0vSWbenyA4qfTd9ifIw7FyGe
        xHv6sxTZM8XTMTEwomUpQxoXy67XId7pgN/x2b6xhXYuH0hEoT/2krPvePcGZYn4RwiePLRAa3KKE
        lj06imMg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPsOx-0007rZ-5c; Sat, 18 Apr 2020 18:41:15 +0000
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
Subject: [PATCH 2/9] fs: fix empty-body warning in posix_acl.c
Date:   Sat, 18 Apr 2020 11:41:04 -0700
Message-Id: <20200418184111.13401-3-rdunlap@infradead.org>
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

../fs/posix_acl.c: In function ‘get_acl’:
../fs/posix_acl.c:127:22: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
   /* fall through */ ;
                      ^

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 fs/posix_acl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200327.orig/fs/posix_acl.c
+++ linux-next-20200327/fs/posix_acl.c
@@ -124,7 +124,7 @@ struct posix_acl *get_acl(struct inode *
 	 * be an unlikely race.)
 	 */
 	if (cmpxchg(p, ACL_NOT_CACHED, sentinel) != ACL_NOT_CACHED)
-		/* fall through */ ;
+		do_empty(); /* fall through */
 
 	/*
 	 * Normally, the ACL returned by ->get_acl will be cached.
