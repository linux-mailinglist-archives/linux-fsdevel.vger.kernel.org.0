Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12A179D8D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 20:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjILSlq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 14:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjILSlp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:41:45 -0400
X-Greylist: delayed 440 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Sep 2023 11:41:41 PDT
Received: from snail.cherry.relay.mailchannels.net (snail.cherry.relay.mailchannels.net [23.83.223.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6DE10D3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 11:41:41 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 7898280DDE
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 18:34:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a271.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 0D1C381A88
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 18:34:33 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1694543673; a=rsa-sha256;
        cv=none;
        b=9TLBxcZ9c1WAi9mrGZv2QSDRm1NtIPjqtlo3XeSRxEgw/YLTXIiva2tTLd7L6XCY8fgZRw
        uTvkjPKOLXylymW8Zc7teizs/8BprbpcquyYPvY4kKiaZX/8faRGF37yHo68vAKsICCWkc
        PIyZpd3NuUpsrANjAIAGIIopE+IDs3HGD2i1MQ5m4UsitzY4f5i0ICeO35tU+9JoHf/M8c
        RZnjvEinLccdXA7+5Z9ddUGaOkxmMNLui+Nnv9m2IJSUqlmbSeKOeYNlWEMXizLbvh+CnL
        9PyD6FI7YSYBjx7uQhQo1L2q1gWUHcY+RUNbtkzXo4vOGybuOF4MCsfVRxgJZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1694543673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=qxi+CJvQQtvK74E3Vo3p+KVNJms56lu0ly94jseqZbM=;
        b=Op4P6Mzo3ggbiqOcCF8LqKOTBZNx62D9nV1eJjTTkkkyZT5NlxH06C1tLXI1oPy0l2q8Ep
        m4B7BAf5bvKtCtqCyBRifZ/wGgGoKp/acZ70Z8qnUiW8Vpt6pJEHCJjdx/ZNU4UVgzh1HN
        Zkbut+Ph3Kpgnn7PA33qH66gno+HxV+eoaRzQcMrEd5FXrNeWmQPYs4wP01SXJcuKhyUUy
        K5d5Etgw68z/ygXA0unMUvJGoAzWj3G8M0JilknFxYeWIfZJ0UgSaBmL4EI30CO2MmrQJQ
        N9U5mGfD/lZFXq1Yfaxf6j6Pmh3fcgVhxlLo7u/IRGvj7HRdL520sRUKqD8IOA==
ARC-Authentication-Results: i=1;
        rspamd-7d5dc8fd68-j44rq;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Juvenile-Little: 4042436e5d55ecdc_1694543673326_3704616411
X-MC-Loop-Signature: 1694543673326:3534928179
X-MC-Ingress-Time: 1694543673325
Received: from pdx1-sub0-mail-a271.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.115.138.83 (trex/6.9.1);
        Tue, 12 Sep 2023 18:34:33 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a271.dreamhost.com (Postfix) with ESMTPSA id 4RlXLJ5MWGzXM
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 11:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1694543672;
        bh=qxi+CJvQQtvK74E3Vo3p+KVNJms56lu0ly94jseqZbM=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=F8TQlKovqhZCWwYNfFxDpg7MW8mDZRj1lGqGGsqiua+9l1M2dDs7ojaUrHp1DHrrj
         xi2LYitdfZqYagwU1wMdg8X6pVipOXvZUUIL5Gci7JSgN8kT19J+FSXAEuGnf3nISz
         171CAB9ch26K9240za/C1cWiSapVlavPPHmv/L01r3LqKhElDnr0vWXy1Tpb7ZjWDR
         A0I386QmTsoTWQgfQNxa9NT/2N40zEDULeocdB3xg2t2VLgE3RBlumbxq1Uq/3BLB7
         2X4mpVP5bEeQbBnpsn5PCzXpIIqqN+RBSTbrhUrjZ73hGpYSQergIMosr7oiV4CSib
         k1phPXAqjHbGw==
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0111
        by kmjvbox (DragonFly Mail Agent v0.12);
        Tue, 12 Sep 2023 11:34:22 -0700
Date:   Tue, 12 Sep 2023 11:34:22 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>,
        Bernd Schubert <bernd.schubert@fastmail.fm>
Subject: [PATCH v2 1/2] fuse: revalidate: move lookup into a separate function
Message-ID: <e21fe75ba435ddc4d0b2e056c950dd421af794bf.1694541252.git.kjlx@templeofstupid.com>
References: <cover.1694541252.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694541252.git.kjlx@templeofstupid.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If this refactoring seems cumbersome, it's because the goal is to move
the lookup parts of fuse_dentry_revalidate into a common function.  This
function will be used elsewhere in a separate commit.  In the meantime,
the new function fuse_dentry_revalidate_lookup is responsible for just
the lookup and validation portions of the revalidate dance.  The
fuse_dentry_revalidate function retains the responsibility for
invalidating and mutating any state associated with the origial
fuse_inode and dentry.

Cc: stable@vger.kernel.org
Fixes: 1866d779d5d2 ("fuse: Allow fuse_fill_super_common() for submounts")
Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
 fs/fuse/dir.c | 85 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 27 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 04a1c62342dc..da5b6079d88c 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -183,6 +183,57 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
 	args->out_args[0].value = outarg;
 }
 
+static int fuse_dentry_revalidate_lookup(struct fuse_mount *fm,
+					 struct dentry *entry,
+					 struct inode *inode,
+					 struct fuse_entry_out *outarg,
+					 bool *lookedup)
+{
+	struct dentry *parent;
+	struct fuse_forget_link *forget;
+	FUSE_ARGS(args);
+	int ret;
+
+	forget = fuse_alloc_forget();
+	ret = -ENOMEM;
+	if (!forget)
+		goto out;
+
+	parent = dget_parent(entry);
+	fuse_lookup_init(fm->fc, &args, get_node_id(d_inode(parent)),
+			 &entry->d_name, outarg);
+	ret = fuse_simple_request(fm, &args);
+	dput(parent);
+
+	/* Zero nodeid is same as -ENOENT */
+	if (!ret && !outarg->nodeid)
+		ret = -ENOENT;
+	if (!ret) {
+		if (outarg->nodeid != get_node_id(inode) ||
+		    (bool) IS_AUTOMOUNT(inode) != (bool) (outarg->attr.flags & FUSE_ATTR_SUBMOUNT)) {
+			fuse_queue_forget(fm->fc, forget,
+					  outarg->nodeid, 1);
+			goto invalid;
+		}
+		*lookedup = true;
+	}
+	kfree(forget);
+	if (ret == -ENOMEM || ret == -EINTR)
+		goto out;
+	if (ret || fuse_invalid_attr(&outarg->attr) ||
+	    fuse_stale_inode(inode, outarg->generation, &outarg->attr)) {
+		goto invalid;
+	}
+
+	ret = 1;
+out:
+	return ret;
+
+invalid:
+	ret = 0;
+	goto out;
+}
+
 /*
  * Check whether the dentry is still valid
  *
@@ -206,9 +257,8 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 	else if (time_before64(fuse_dentry_time(entry), get_jiffies_64()) ||
 		 (flags & (LOOKUP_EXCL | LOOKUP_REVAL | LOOKUP_RENAME_TARGET))) {
 		struct fuse_entry_out outarg;
-		FUSE_ARGS(args);
-		struct fuse_forget_link *forget;
 		u64 attr_version;
+		bool lookedup = false;
 
 		/* For negative dentries, always do a fresh lookup */
 		if (!inode)
@@ -220,38 +270,19 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 
 		fm = get_fuse_mount(inode);
 
-		forget = fuse_alloc_forget();
-		ret = -ENOMEM;
-		if (!forget)
-			goto out;
-
 		attr_version = fuse_get_attr_version(fm->fc);
 
-		parent = dget_parent(entry);
-		fuse_lookup_init(fm->fc, &args, get_node_id(d_inode(parent)),
-				 &entry->d_name, &outarg);
-		ret = fuse_simple_request(fm, &args);
-		dput(parent);
-		/* Zero nodeid is same as -ENOENT */
-		if (!ret && !outarg.nodeid)
-			ret = -ENOENT;
-		if (!ret) {
+		ret = fuse_dentry_revalidate_lookup(fm, entry, inode, &outarg,
+						    &lookedup);
+		if (ret == -ENOMEM || ret == -EINTR)
+			goto out;
+		if (lookedup) {
 			fi = get_fuse_inode(inode);
-			if (outarg.nodeid != get_node_id(inode) ||
-			    (bool) IS_AUTOMOUNT(inode) != (bool) (outarg.attr.flags & FUSE_ATTR_SUBMOUNT)) {
-				fuse_queue_forget(fm->fc, forget,
-						  outarg.nodeid, 1);
-				goto invalid;
-			}
 			spin_lock(&fi->lock);
 			fi->nlookup++;
 			spin_unlock(&fi->lock);
 		}
-		kfree(forget);
-		if (ret == -ENOMEM || ret == -EINTR)
-			goto out;
-		if (ret || fuse_invalid_attr(&outarg.attr) ||
-		    fuse_stale_inode(inode, outarg.generation, &outarg.attr))
+		if (ret <= 0)
 			goto invalid;
 
 		forget_all_cached_acls(inode);
-- 
2.25.1

