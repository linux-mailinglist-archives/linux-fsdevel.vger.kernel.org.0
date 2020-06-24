Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6B6207832
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 18:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404730AbgFXQAf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 12:00:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20212 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404647AbgFXQAe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593014433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kdnyTnxVnkPT//BmZpUifF3vPn430L7/1dAjHHZhWZg=;
        b=Tgcf6Qtc13hwPCe8L+zf72jljkUF5rryga+ZyIaTlxgttDjeYNg94Y0ephl6UOz/oiMPH9
        M5/pADPs+xynbQSwKsa++Z9tOYAtufAlC1xZ2LpVtza2UrtdPI/6TcvXNGcjlgVGgcqezq
        yn3ITTHC2fQjz3N7BxijHov+oD6Uhw8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-1OUjAlkjN5-ADDM06uXK2Q-1; Wed, 24 Jun 2020 12:00:28 -0400
X-MC-Unique: 1OUjAlkjN5-ADDM06uXK2Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD7F618585A0;
        Wed, 24 Jun 2020 16:00:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CF902B471;
        Wed, 24 Jun 2020 16:00:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix storage of cell names
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Colin Ian King <colin.king@canonical.com>, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 24 Jun 2020 17:00:24 +0100
Message-ID: <159301442487.3143734.7373031577179431362.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The cell name stored in the afs_cell struct is a 64-char + NUL buffer -
when it needs to be able to handle up to AFS_MAXCELLNAME (256 chars) + NUL.

Fix this by changing the array to a pointer and allocating the string.

Found using Coverity.

Fixes: 989782dcdc91 ("afs: Overhaul cell database management")
Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/cell.c     |    9 +++++++++
 fs/afs/internal.h |    2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 0d25565a2e37..1cdabbdeeb2c 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -154,10 +154,17 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 		return ERR_PTR(-ENOMEM);
 	}
 
+	cell->name = kmalloc(namelen + 1, GFP_KERNEL);
+	if (!cell->name) {
+		kfree(cell);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	cell->net = net;
 	cell->name_len = namelen;
 	for (i = 0; i < namelen; i++)
 		cell->name[i] = tolower(name[i]);
+	cell->name[i] = 0;
 
 	atomic_set(&cell->usage, 2);
 	INIT_WORK(&cell->manager, afs_manage_cell);
@@ -207,6 +214,7 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 	if (ret == -EINVAL)
 		printk(KERN_ERR "kAFS: bad VL server IP address\n");
 error:
+	kfree(cell->name);
 	kfree(cell);
 	_leave(" = %d", ret);
 	return ERR_PTR(ret);
@@ -489,6 +497,7 @@ static void afs_cell_destroy(struct rcu_head *rcu)
 	afs_put_vlserverlist(cell->net, rcu_access_pointer(cell->vl_servers));
 	afs_put_cell(cell->net, cell->alias_of);
 	key_put(cell->anonymous_key);
+	kfree(cell->name);
 	kfree(cell);
 
 	_leave(" [destroyed]");
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 5892605b1a44..bf26fd28ccbd 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -390,7 +390,7 @@ struct afs_cell {
 	struct afs_vlserver_list __rcu *vl_servers;
 
 	u8			name_len;	/* Length of name */
-	char			name[64 + 1];	/* Cell name, case-flattened and NUL-padded */
+	char			*name;		/* Cell name, case-flattened and NUL-padded */
 };
 
 /*


