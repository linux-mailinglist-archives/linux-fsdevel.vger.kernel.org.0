Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B3F39D963
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 12:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhFGKOw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Mon, 7 Jun 2021 06:14:52 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:55471 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230383AbhFGKOv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:14:51 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-3Lglvf-YPGeF-wOFVogcHQ-1; Mon, 07 Jun 2021 06:12:57 -0400
X-MC-Unique: 3Lglvf-YPGeF-wOFVogcHQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5864F1883527;
        Mon,  7 Jun 2021 10:12:55 +0000 (UTC)
Received: from web.messagingengine.com (ovpn-116-49.sin2.redhat.com [10.67.116.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74B935C238;
        Mon,  7 Jun 2021 10:12:48 +0000 (UTC)
Subject: [PATCH v5 6/6] kernfs: add kernfs_need_inode_refresh()
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Eric Sandeen <sandeen@sandeen.net>, Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 07 Jun 2021 18:12:47 +0800
Message-ID: <162306076700.69474.13051618210568968165.stgit@web.messagingengine.com>
In-Reply-To: <162306058093.69474.2367505736322611930.stgit@web.messagingengine.com>
References: <162306058093.69474.2367505736322611930.stgit@web.messagingengine.com>
User-Agent: StGit/0.23
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=raven@themaw.net
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: themaw.net
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now the kernfs_rwsem read lock is held for kernfs_refresh_inode() and
the i_lock taken to protect inode updates there can be some contention
introduced when .permission() is called with concurrent path walks in
progress.

Since .permission() is called frequently during path walks it's worth
checking if the update is actually needed before taking the lock and
performing the update.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/kernfs/inode.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 6728ecd81eb37..67fb1289c51dc 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -158,6 +158,30 @@ static inline void set_default_inode_attr(struct inode *inode, umode_t mode)
 		inode->i_ctime = current_time(inode);
 }
 
+static bool kernfs_need_inode_refresh(struct kernfs_node *kn,
+				      struct inode *inode,
+				      struct kernfs_iattrs *attrs)
+{
+	if (kernfs_type(kn) == KERNFS_DIR) {
+		if (inode->i_nlink != kn->dir.subdirs + 2)
+			return true;
+	}
+
+	if (inode->i_mode != kn->mode)
+		return true;
+
+	if (attrs) {
+		if (!timespec64_equal(&inode->i_atime, &attrs->ia_atime) ||
+		    !timespec64_equal(&inode->i_mtime, &attrs->ia_mtime) ||
+		    !timespec64_equal(&inode->i_ctime, &attrs->ia_ctime) ||
+		    !uid_eq(inode->i_uid, attrs->ia_uid) ||
+		    !gid_eq(inode->i_gid, attrs->ia_gid))
+			return true;
+	}
+
+	return false;
+}
+
 static inline void set_inode_attr(struct inode *inode,
 				  struct kernfs_iattrs *attrs)
 {
@@ -172,6 +196,9 @@ static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
 {
 	struct kernfs_iattrs *attrs = kn->iattr;
 
+	if (!kernfs_need_inode_refresh(kn, inode, attrs))
+		return;
+
 	spin_lock(&inode->i_lock);
 	inode->i_mode = kn->mode;
 	if (attrs)


