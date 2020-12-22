Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407E82E06F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 08:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgLVHtz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 02:49:55 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:20556 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725300AbgLVHtz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 02:49:55 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-G6FqNAIFO-WUMl6zQO5Gcw-1; Tue, 22 Dec 2020 02:48:34 -0500
X-MC-Unique: G6FqNAIFO-WUMl6zQO5Gcw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64CB11005513;
        Tue, 22 Dec 2020 07:48:33 +0000 (UTC)
Received: from mickey.themaw.net (ovpn-116-49.sin2.redhat.com [10.67.116.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0DCC55D6D1;
        Tue, 22 Dec 2020 07:48:27 +0000 (UTC)
Subject: [PATCH 5/6] kernfs: stay in rcu-walk mode if possible
From:   Ian Kent <raven@themaw.net>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Tue, 22 Dec 2020 15:48:24 +0800
Message-ID: <160862330474.291330.11664503360150456908.stgit@mickey.themaw.net>
In-Reply-To: <160862320263.291330.9467216031366035418.stgit@mickey.themaw.net>
References: <160862320263.291330.9467216031366035418.stgit@mickey.themaw.net>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=raven@themaw.net
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: themaw.net
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

During path walks in sysfs (kernfs) needing to take a reference to
a mount doesn't happen often since the walk won't be crossing mount
point boundaries.

Also while staying in rcu-walk mode where possible wouldn't normally
give much improvement.

But when there are many concurrent path walks and there is high d_lock
contention dget() will often need to resort to taking a spin lock to
get the reference. And that could happen each time the reference is
passed from component to component.

So, in the high contention case, it will contribute to the contention.

Therefore staying in rcu-walk mode when possible will reduce contention.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/kernfs/dir.c |   48 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index fdeae2c6e7ba..50c5c8c886af 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1048,8 +1048,54 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	struct kernfs_node *parent;
 	struct kernfs_node *kn;
 
-	if (flags & LOOKUP_RCU)
+	if (flags & LOOKUP_RCU) {
+		parent = kernfs_dentry_node(dentry->d_parent);
+
+		/* Directory node changed, no, then don't search? */
+		if (!kernfs_dir_changed(parent, dentry))
+			return 1;
+
+		kn = kernfs_dentry_node(dentry);
+		if (!kn) {
+			/* Negative hashed dentry, tell the VFS to switch to
+			 * ref-walk mode and call us again so that node
+			 * existence can be checked.
+			 */
+			if (!d_unhashed(dentry))
+				return -ECHILD;
+
+			/* Negative unhashed dentry, this shouldn't happen
+			 * because this case occurs in ref-walk mode after
+			 * dentry allocation which is followed by a call
+			 * to ->loopup(). But if it does happen the dentry
+			 * is surely invalid.
+			 */
+			return 0;
+		}
+
+		/* Since the dentry is positive (we got the kernfs node) a
+		 * kernfs node reference was held at the time. Now if the
+		 * dentry reference count is still greater than 0 it's still
+		 * positive so take a reference to the node to perform an
+		 * active check.
+		 */
+		if (d_count(dentry) <= 0 || !atomic_inc_not_zero(&kn->count))
+			return -ECHILD;
+
+		/* The kernfs node reference count was greater than 0, if
+		 * it's active continue in rcu-walk mode.
+		 */
+		if (kernfs_active_read(kn)) {
+			kernfs_put(kn);
+			return 1;
+		}
+
+		/* Otherwise, just tell the VFS to switch to ref-walk mode
+		 * and call us again so the kernfs node can be validated.
+		 */
+		kernfs_put(kn);
 		return -ECHILD;
+	}
 
 	down_read(&kernfs_rwsem);
 


