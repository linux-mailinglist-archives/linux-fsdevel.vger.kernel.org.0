Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D941E8A94
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 00:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgE2WAn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 18:00:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60360 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728447AbgE2WAn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 18:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590789642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Z+Gadu21Z2xRE8cYGvxOo9yHCfq6rp1d/CEGZW+78A=;
        b=IjSnFU9OsxW5K0oD9pemcdodqut2eItYcMbHoL9d8k2SufsSO5PmFB24raZ4ry9cD020rd
        qXl70GL69Sj9n0bqaU7NWQ29VTMecG9z2SNqdRoLDd8ciX5hFR3H8ZUWBxC0MC5JnhEeS6
        jSS//FhlyGDAx3d5QSxHX9kkHu9lu70=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-XcEcBHW0OdCgj8IYgyOT5w-1; Fri, 29 May 2020 18:00:38 -0400
X-MC-Unique: XcEcBHW0OdCgj8IYgyOT5w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01EDD107ACF7;
        Fri, 29 May 2020 22:00:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC9545D9D7;
        Fri, 29 May 2020 22:00:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 04/27] afs: Always include dir in bulk status fetch from
 afs_do_lookup()
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Dave Botsch <botsch@cnf.cornell.edu>,
        Jeffrey Altman <jaltman@auristor.com>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 29 May 2020 23:00:35 +0100
Message-ID: <159078963510.679399.16104194195445298436.stgit@warthog.procyon.org.uk>
In-Reply-To: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
References: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a lookup is done in an AFS directory, the filesystem will speculate
and fetch up to 49 other statuses for files in the same directory and fetch
those as well, turning them into inodes or updating inodes that already
exist.

However, occasionally, a callback break might go missing due to NAT timing
out, but the afs filesystem doesn't then realise that the directory is not
up to date.

Alleviate this by using one of the status slots to check the directory in
which the lookup is being done.

Reported-by: Dave Botsch <botsch@cnf.cornell.edu>
Suggested-by: Jeffrey Altman <jaltman@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/dir.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index d1e1caa23c8b..3c486340b220 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -658,7 +658,8 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
 
 	cookie->ctx.actor = afs_lookup_filldir;
 	cookie->name = dentry->d_name;
-	cookie->nr_fids = 1; /* slot 0 is saved for the fid we actually want */
+	cookie->nr_fids = 2; /* slot 0 is saved for the fid we actually want
+			      * and slot 1 for the directory */
 
 	read_seqlock_excl(&dvnode->cb_lock);
 	dcbi = rcu_dereference_protected(dvnode->cb_interest,
@@ -709,7 +710,11 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
 	if (!cookie->inodes)
 		goto out_s;
 
-	for (i = 1; i < cookie->nr_fids; i++) {
+	cookie->fids[1] = dvnode->fid;
+	cookie->statuses[1].cb_break = afs_calc_vnode_cb_break(dvnode);
+	cookie->inodes[1] = igrab(&dvnode->vfs_inode);
+
+	for (i = 2; i < cookie->nr_fids; i++) {
 		scb = &cookie->statuses[i];
 
 		/* Find any inodes that already exist and get their


