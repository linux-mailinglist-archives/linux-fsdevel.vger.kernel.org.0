Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7702E3A7BD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 12:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhFOK3b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 06:29:31 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:24109 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231689AbhFOK30 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 06:29:26 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-DOPPCgdoPuuodX4AY4s6FQ-1; Tue, 15 Jun 2021 06:27:16 -0400
X-MC-Unique: DOPPCgdoPuuodX4AY4s6FQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BBD2A40C0;
        Tue, 15 Jun 2021 10:27:15 +0000 (UTC)
Received: from web.messagingengine.com (ovpn-116-40.sin2.redhat.com [10.67.116.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 596A060C0F;
        Tue, 15 Jun 2021 10:27:07 +0000 (UTC)
Subject: [PATCH v7 6/6] kernfs: dont call d_splice_alias() under kernfs node
 lock
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
Date:   Tue, 15 Jun 2021 18:27:06 +0800
Message-ID: <162375282484.232295.17118280961409351125.stgit@web.messagingengine.com>
In-Reply-To: <162375263398.232295.14755578426619198534.stgit@web.messagingengine.com>
References: <162375263398.232295.14755578426619198534.stgit@web.messagingengine.com>
User-Agent: StGit/0.23
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=raven@themaw.net
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: themaw.net
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The call to d_splice_alias() in kernfs_iop_lookup() doesn't depend on
any kernfs node so there's no reason to hold the kernfs node lock when
calling it.

Signed-off-by: Ian Kent <raven@themaw.net>
Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/kernfs/dir.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index a5080fb1dfc05..723348607033c 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1097,7 +1097,6 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 					struct dentry *dentry,
 					unsigned int flags)
 {
-	struct dentry *ret;
 	struct kernfs_node *parent = dir->i_private;
 	struct kernfs_node *kn;
 	struct inode *inode = NULL;
@@ -1117,11 +1116,10 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	/* Needed only for negative dentry validation */
 	if (!inode)
 		kernfs_set_rev(parent, dentry);
-	/* instantiate and hash (possibly negative) dentry */
-	ret = d_splice_alias(inode, dentry);
 	up_read(&kernfs_rwsem);
 
-	return ret;
+	/* instantiate and hash (possibly negative) dentry */
+	return d_splice_alias(inode, dentry);
 }
 
 static int kernfs_iop_mkdir(struct user_namespace *mnt_userns,


