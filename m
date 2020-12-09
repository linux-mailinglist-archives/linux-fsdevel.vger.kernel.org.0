Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375ED2D4D57
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 23:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388292AbgLIWK1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 17:10:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:56930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388515AbgLIWKK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 17:10:10 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FDAA23D1C;
        Wed,  9 Dec 2020 22:09:29 +0000 (UTC)
Date:   Wed, 9 Dec 2020 17:09:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] fs/namei.c: Remove unlikely of status being -ECHILD in
 lookup_fast()
Message-ID: <20201209170928.26b4cda7@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From:  Steven Rostedt (VMware) <rostedt@goodmis.org>

Running my yearly branch profiling code, it detected a 100% wrong branch
condition in name.c for lookup_fast(). The code in question has:

		status = d_revalidate(dentry, nd->flags);
		if (likely(status > 0))
			return dentry;
		if (unlazy_child(nd, dentry, seq))
			return ERR_PTR(-ECHILD);
		if (unlikely(status == -ECHILD))
			/* we'd been told to redo it in non-rcu mode */
			status = d_revalidate(dentry, nd->flags);

If the status of the d_revalidate() is greater than zero, then the function
finishes. Otherwise, if it is an "unlazy_child" it returns with -ECHILD.
After the above two checks, the status is compared to -ECHILD, as that is
what is returned if the original d_revalidate() needed to be done in a
non-rcu mode.

Especially this path is called in a condition of:

	if (nd->flags & LOOKUP_RCU) {

And most of the d_revalidate() functions have:

	if (flags & LOOKUP_RCU)
		return -ECHILD;

It appears that that is the only case that this if statement is triggered
on two of my machines, running in production.

As it is dependent on what filesystem mix is configured in the running
kernel, simply remove the unlikely() from the if statement.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
Changes since v1:

 - Remove unlikely() instead of making it a likely()

diff --git a/fs/namei.c b/fs/namei.c
index d4a6dd772303..c7b7e83853f3 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1495,7 +1495,7 @@ static struct dentry *lookup_fast(struct nameidata *nd,
 			return dentry;
 		if (unlazy_child(nd, dentry, seq))
 			return ERR_PTR(-ECHILD);
-		if (unlikely(status == -ECHILD))
+		if (status == -ECHILD)
 			/* we'd been told to redo it in non-rcu mode */
 			status = d_revalidate(dentry, nd->flags);
 	} else {
