Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E668E53EF8D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jun 2022 22:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbiFFUZo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 16:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbiFFUYj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:24:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238BD3DA74;
        Mon,  6 Jun 2022 13:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GqOZ2oW44Rjd4l49qywswNf1QFY4EfDlPVXlmqLvIWY=; b=usGdyI+OHK9lwgBXsMP0vw/JGP
        xuWtAzGmimpHjSXBNH+xs2VSbqGVilyhFIjzH5xOdTGCu2Jc0mGbVijV6S0ys8/yh5AsWPpZ1PAfS
        MIt4JtEJRVIUvy4grt+TEUlgma0VC/0rDleuyufqcJVta8DS9UgplKviSI6GOce953E7xST6avEP8
        sPSOPlaRjz6SyQQrOkv1Nm8TfkWxufEB9ABSyEC1vXMk6zGOOA62xJPOZz+03kw2qMonbVcuLytZK
        ln/yubj3x/2UpBxi7o3ZTOWhm8TFBe97Vn7hsYrrFRjAXN2mXokc9gIZVYp/q5GGTgPB3zD0JdTp9
        UaYNXnJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyJFy-00AzpO-Qa; Mon, 06 Jun 2022 20:23:23 +0000
Date:   Mon, 6 Jun 2022 21:23:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        gwml@vger.gnuweeb.org
Subject: Re: Linux 5.18-rc4
Message-ID: <Yp5iOlrgELc9SkSI@casper.infradead.org>
References: <CAHk-=whmtHMzjaVUF9bS+7vE_rrRctcCTvsAeB8fuLYcyYLN-g@mail.gmail.com>
 <226cee6a-6ca1-b603-db08-8500cd8f77b7@gnuweeb.org>
 <CAHk-=whayT+o58FrPCXVVJ3Bn-3SeoDkMA77TOd9jg4yMGNExw@mail.gmail.com>
 <87r1414y5v.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wijAnOcC2qQEAvFtRD_xpPbG+aSUXkfM-nFTHuMmPbZGA@mail.gmail.com>
 <266e648a-c537-66bc-455b-37105567c942@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <266e648a-c537-66bc-455b-37105567c942@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 06, 2022 at 12:19:36PM -0700, John Johansen wrote:
> > I suspect that part is that both Apparmor and IPC use the idr local lock.
> > 
> bingo,
> 
> apparmor moved its secids allocation from a custom radix tree to idr in
> 
>   99cc45e48678 apparmor: Use an IDR to allocate apparmor secids
> 
> and ipc is using the idr for its id allocation as well
> 
> I can easily lift the secid() allocation out of the ctx->lock but that
> would still leave it happening under the file_lock and not fix the problem.
> I think the quick solution would be for apparmor to stop using idr, reverting
> back at least temporarily to the custom radix tree.

How about moving forward to the XArray that doesn't use that horrid
prealloc gunk?  Compile tested only.


diff --git a/security/apparmor/include/secid.h b/security/apparmor/include/secid.h
index 48ff1ddecad5..278dff5ecd1f 100644
--- a/security/apparmor/include/secid.h
+++ b/security/apparmor/include/secid.h
@@ -31,6 +31,4 @@ int aa_alloc_secid(struct aa_label *label, gfp_t gfp);
 void aa_free_secid(u32 secid);
 void aa_secid_update(u32 secid, struct aa_label *label);
 
-void aa_secids_init(void);
-
 #endif /* __AA_SECID_H */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 900bc540656a..9dfb4e4631da 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1857,8 +1857,6 @@ static int __init apparmor_init(void)
 {
 	int error;
 
-	aa_secids_init();
-
 	error = aa_setup_dfa_engine();
 	if (error) {
 		AA_ERROR("Unable to setup dfa engine\n");
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index ce545f99259e..3b08942db1f6 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -13,9 +13,9 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/gfp.h>
-#include <linux/idr.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/xarray.h>
 
 #include "include/cred.h"
 #include "include/lib.h"
@@ -29,8 +29,7 @@
  */
 #define AA_FIRST_SECID 2
 
-static DEFINE_IDR(aa_secids);
-static DEFINE_SPINLOCK(secid_lock);
+static DEFINE_XARRAY_FLAGS(aa_secids, XA_FLAGS_LOCK_IRQ | XA_FLAGS_TRACK_FREE);
 
 /*
  * TODO: allow policy to reserve a secid range?
@@ -47,9 +46,9 @@ void aa_secid_update(u32 secid, struct aa_label *label)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&secid_lock, flags);
-	idr_replace(&aa_secids, label, secid);
-	spin_unlock_irqrestore(&secid_lock, flags);
+	xa_lock_irqsave(&aa_secids, flags);
+	__xa_store(&aa_secids, secid, label, 0);
+	xa_unlock_irqrestore(&aa_secids, flags);
 }
 
 /**
@@ -58,13 +57,7 @@ void aa_secid_update(u32 secid, struct aa_label *label)
  */
 struct aa_label *aa_secid_to_label(u32 secid)
 {
-	struct aa_label *label;
-
-	rcu_read_lock();
-	label = idr_find(&aa_secids, secid);
-	rcu_read_unlock();
-
-	return label;
+	return xa_load(&aa_secids, secid);
 }
 
 int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
@@ -126,19 +119,16 @@ int aa_alloc_secid(struct aa_label *label, gfp_t gfp)
 	unsigned long flags;
 	int ret;
 
-	idr_preload(gfp);
-	spin_lock_irqsave(&secid_lock, flags);
-	ret = idr_alloc(&aa_secids, label, AA_FIRST_SECID, 0, GFP_ATOMIC);
-	spin_unlock_irqrestore(&secid_lock, flags);
-	idr_preload_end();
+	xa_lock_irqsave(&aa_secids, flags);
+	ret = __xa_alloc(&aa_secids, &label->secid, label,
+			XA_LIMIT(AA_FIRST_SECID, INT_MAX), gfp);
+	xa_unlock_irqrestore(&aa_secids, flags);
 
 	if (ret < 0) {
 		label->secid = AA_SECID_INVALID;
 		return ret;
 	}
 
-	AA_BUG(ret == AA_SECID_INVALID);
-	label->secid = ret;
 	return 0;
 }
 
@@ -150,12 +140,7 @@ void aa_free_secid(u32 secid)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&secid_lock, flags);
-	idr_remove(&aa_secids, secid);
-	spin_unlock_irqrestore(&secid_lock, flags);
-}
-
-void aa_secids_init(void)
-{
-	idr_init_base(&aa_secids, AA_FIRST_SECID);
+	xa_lock_irqsave(&aa_secids, flags);
+	__xa_erase(&aa_secids, secid);
+	xa_unlock_irqrestore(&aa_secids, flags);
 }
